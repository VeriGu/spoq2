#include <ir2spec.h>
#include <nodes.h>
#include <any>
#include <irvalues.h>
#include <shortcuts.h>
#include <llvm.h>
#include <variant>
#include <unordered_set>
#include <log.h>
#include <boost/range/algorithm/set_algorithm.hpp>
#include <project.h>

namespace autov
{
using autov::Bool;
using autov::BoolConst;
using autov::Expr;
using autov::Function;
using autov::Int;
using autov::IntConst;
using autov::SpecType;
using autov::StringConst;
using autov::Struct;
using autov::IRLoader::CFunction;
using autov::IRLoader::IAssign;
using autov::IRLoader::IBreak;
using autov::IRLoader::IReturn;
using autov::IRLoader::IRInst;
using autov::IRLoader::IRType;
using autov::IRLoader::IRValue;
using autov::IRLoader::TArray;
using autov::IRLoader::TBool;
using autov::IRLoader::TFunction;
using autov::IRLoader::TInt;
using autov::IRLoader::TNamedStruct;
using autov::IRLoader::TPtr;
using autov::IRLoader::TStruct;
using autov::IRLoader::TVoid;
using IRLoader::Op;

using std::set;

using Inst = std::variant<IRInst *, IRValue *, CFunction *>;
using Func = std::variant<IRLoader::CFunction *, std::reference_wrapper<vector<unique_ptr<IRInst>>>>;

SpecNode *ir_expr_to_spec(Layer* l, IRLoader::Op op, vector<unique_ptr<IRValue>> *_args, vector<unique_ptr<SpecNode>> *relies);

static void analyze_input_output(CFunction *func);
static void get_input_output(vector<unique_ptr<IRInst>> *inst, int i, vector<Inst> &after, std::set<string> &input,
                             std::set<string> &output);
static void get_input_output(vector<Inst> &before, vector<unique_ptr<IRInst>> *inst, int i, std::set<string> &input,
                             std::set<string> &output);
template <typename T>
static void get_input_output(vector<unique_ptr<T>> *inst, std::set<string> &input, std::set<string> &output);
static void get_input_output(CFunction *inst, std::set<string> &input, std::set<string> &output);
static void get_input_output(IRInst *inst, std::set<string> &input, std::set<string> &output);
static void get_input_output(IRValue *inst, std::set<string> &input, std::set<string> &output);

long load_store_typ(IRType *typ);

unique_ptr<vector<unique_ptr<SpecNode>>> check_fun_ptr(Layer *l, vector<unique_ptr<IRInst>> *insts);

shared_ptr<SpecType> ir_type_to_spec(IRType *typ)
{
    if (dynamic_cast<TInt *>(typ)) {
        return Int::INT;
    } else if (dynamic_cast<TBool *>(typ)) {
        return Bool::BOOL;
    } else if (dynamic_cast<TVoid *>(typ)) {
        return make_shared<SpecType>("Void");
    } else if (auto func = dynamic_cast<TFunction *>(typ)) {
        auto vec = make_shared<vector<shared_ptr<SpecType>>>();

        for (auto t : *(func->arglist))
            vec->push_back(ir_type_to_spec(t.get()));

        return make_shared<Function>(ir_type_to_spec(func->rettype.get()), vec);
    } else if (dynamic_cast<TPtr *>(typ)) {
        return Struct::Ptr;
    } else if (auto ns = dynamic_cast<TNamedStruct *>(typ)) {
        return make_shared<SpecType>(ns->name);
    } else if (auto *array = dynamic_cast<TArray *>(typ)) {
        return make_shared<Array>(ir_type_to_spec(array->subtype.get()));
    } else {
        throw std::invalid_argument("invalid types: " + typ->to_coq());
    }
}

  // return a raw pointer to give a flexibility of handler to deal with
  //  pointer, should be wrapped in a smart pointer
SpecNode *default_val(shared_ptr<SpecType> typ)
{
    if (dynamic_cast<Int *>(typ.get())) {
        return new IntConst(0);
    } else if (dynamic_cast<Bool *>(typ.get())) {
        return new BoolConst(false);
    } else if (dynamic_cast<Struct *>(typ.get()) && typ->name == "Ptr") {
        auto vec = make_unique<vector<unique_ptr<SpecNode>>>();

        vec->push_back(make_unique<StringConst>("#"));
        vec->push_back(make_unique<IntConst>(0));
        return new Expr("mkPtr", std::move(vec));
    } else if (dynamic_cast<String *>(typ.get())) {
        return new StringConst("");
    } else {
        assert(false);
    }
}

using literal_t = std::variant<int, bool, string>;

SpecNode *ir_value_to_spec(Layer* L, literal_t v, vector<unique_ptr<SpecNode>> *relies) {
    if (std::holds_alternative<int>(v))
        return new IntConst(std::get<int>(v));
    else if (std::holds_alternative<bool>(v))
        return new BoolConst(std::get<bool>(v));
    else if (std::holds_alternative<string>(v))
        return new StringConst(std::get<string>(v));
    else
        assert(false);
}

SpecNode *ir_value_to_spec(Layer* L, IRLoader::IRValue *v, vector<unique_ptr<SpecNode>> *relies) {
    if (auto vl = dynamic_cast<IRLoader::VLocal *>(v)) {
        return new Symbol(vl->name);
    } else if (auto vg = dynamic_cast<IRLoader::VGlobal *>(v)) {
        auto vec = make_unique<vector<unique_ptr<SpecNode>>>();

        vec->push_back(make_unique<StringConst>(vg->name));
        vec->push_back(make_unique<IntConst>(0));
        return new Expr("mkPtr", std::move(vec));
    } else if (auto vi = dynamic_cast<IRLoader::VInt *>(v)) {
        if ((long)vi->val > -100 && (long)vi->val < 0) {
            // Heuristically convert a large integer to a negative number
            auto vec = make_unique<vector<unique_ptr<SpecNode>>>();

            vec->push_back(make_unique<IntConst>(-vi->val));

            return new Expr(Expr::binops::MINUS, std::move(vec));
        } else {
            return new IntConst(vi->val);
        }
    } else if (auto vb = dynamic_cast<IRLoader::VBool *>(v)) {
        return new BoolConst(vb->val);
    } else if (auto ve = dynamic_cast<IRLoader::VExpr *>(v)) {
        return ir_expr_to_spec(L, ve->op, ve->operands.get(), relies);
    } else if (auto vn = dynamic_cast<IRLoader::VNull *>(v)) {
        auto vec = make_unique<vector<unique_ptr<SpecNode>>>();

        vec->push_back(make_unique<StringConst>("null"));
        vec->push_back(make_unique<IntConst>(0));
        return new Expr("mkPtr", std::move(vec));
    } else if (auto vu = dynamic_cast<IRLoader::VUndef *>(v)) {
        if (auto ptr = dynamic_cast<IRLoader::TPtr *>(vu->type.get())) {
            auto vec = make_unique<vector<unique_ptr<SpecNode>>>();

            vec->push_back(make_unique<StringConst>("null"));
            vec->push_back(make_unique<IntConst>(0));
            return new Expr("mkPtr", std::move(vec));
        } else if (auto b = dynamic_cast<IRLoader::TBool *>(vu->type.get())) {
            return new BoolConst(false);
        } else if (auto i = dynamic_cast<IRLoader::TInt *>(vu->type.get())) {
            return new IntConst(0);
        } else {
            assert(false);
        }
    } else {
        assert(false);
    }
}


unique_ptr<SpecNode> reduce(vector<unique_ptr<SpecNode>> *offs, int start) {
    if(offs->size() - start == 1)
        return std::move(offs->at(start));

    auto elems = make_unique<vector<unique_ptr<SpecNode>>>();

    elems->push_back(std::move(offs->at(start)));
    elems->push_back(reduce(offs, start + 1));

    return make_unique<Expr>(Expr::binops::ADD, std::move(elems));
}


SpecNode* sizeof_type(shared_ptr<IRType> typ) {
    auto sz = typ->szof_verbose();

    if (std::get<1>(sz) == (IRLoader::coq_sz_t)-1) {
       return new IntConst(std::get<0>(sz));
    }

    auto elems = make_unique<vector<unique_ptr<SpecNode>>>();
    elems->push_back(make_unique<IntConst>(std::get<0>(sz)));
    elems->push_back(make_unique<IntConst>(std::get<1>(sz)));

    return new Expr(Expr::binops::MULT, std::move(elems));
}

SpecNode* get_elem_ptr(Layer *l, IRValue *val, vector<unique_ptr<SpecNode>> *idx, vector<unique_ptr<SpecNode>> *relies) {
    auto tv = val->type;
    auto offs = make_unique<vector<unique_ptr<SpecNode>>>();

    for (auto it = idx->begin() + 1; it != idx->end(); ++it) {
        auto &i = *it;

        if(auto f = dynamic_cast<IRLoader::TPtr *>(tv.get())) {
            auto elems = new vector<unique_ptr<SpecNode>>();
            elems->push_back(unique_ptr<SpecNode>(sizeof_type(f->subtype)));
            elems->push_back(i->deep_copy());

            offs->push_back(unique_ptr<SpecNode>(new Expr(Expr::binops::MULT, unique_ptr<vector<unique_ptr<SpecNode>>>(elems))));

            tv = f->subtype;
        } else if(auto f = dynamic_cast<IRLoader::TArray *>(tv.get())) {
            auto elems = new vector<unique_ptr<SpecNode>>();
            elems->push_back(unique_ptr<SpecNode>(sizeof_type(f->subtype)));
            elems->push_back(i->deep_copy());

            auto elems2 = new vector<unique_ptr<SpecNode>>();
            elems2->push_back(unique_ptr<SpecNode>(new IntConst(0)));
            elems2->push_back(i->deep_copy());

            auto elems3 = new vector<unique_ptr<SpecNode>>();
            elems3->push_back(i->deep_copy());
            elems3->push_back(unique_ptr<SpecNode>(new IntConst(f->length)));

            auto elems4 = new vector<unique_ptr<SpecNode>>();
            elems4->push_back(unique_ptr<SpecNode>(new Expr(Expr::binops::LTE, unique_ptr<vector<unique_ptr<SpecNode>>>(elems2))));
            elems4->push_back(unique_ptr<SpecNode>(new Expr(Expr::binops::LT, unique_ptr<vector<unique_ptr<SpecNode>>>(elems3))));


            offs->push_back(unique_ptr<SpecNode>(new Expr(Expr::binops::MULT, unique_ptr<vector<unique_ptr<SpecNode>>>(elems))));
            relies->push_back(unique_ptr<SpecNode>(new Expr(Expr::binops::AND, unique_ptr<vector<unique_ptr<SpecNode>>>(elems4))));

            tv = f->subtype;
        } else if(auto f = dynamic_cast<IRLoader::TFixedVector *>(tv.get())) {
            auto elems = new vector<unique_ptr<SpecNode>>();
            elems->push_back(unique_ptr<SpecNode>(sizeof_type(f->subtype)));
            elems->push_back(i->deep_copy());

            auto elems2 = new vector<unique_ptr<SpecNode>>();
            elems2->push_back(unique_ptr<SpecNode>(new IntConst(0)));
            elems2->push_back(i->deep_copy());

            auto elems3 = new vector<unique_ptr<SpecNode>>();
            elems3->push_back(i->deep_copy());
            elems3->push_back(unique_ptr<SpecNode>(new IntConst(f->length)));

            auto elems4 = new vector<unique_ptr<SpecNode>>();
            elems4->push_back(unique_ptr<SpecNode>(new Expr(Expr::binops::LTE, unique_ptr<vector<unique_ptr<SpecNode>>>(elems2))));
            elems4->push_back(unique_ptr<SpecNode>(new Expr(Expr::binops::LT, unique_ptr<vector<unique_ptr<SpecNode>>>(elems3))));


            offs->push_back(unique_ptr<SpecNode>(new Expr(Expr::binops::MULT, unique_ptr<vector<unique_ptr<SpecNode>>>(elems))));
            relies->push_back(unique_ptr<SpecNode>(new Expr(Expr::binops::AND, unique_ptr<vector<unique_ptr<SpecNode>>>(elems4))));

            tv = f->subtype;
        } else if (auto f = dynamic_cast<IRLoader::TStruct *>(tv.get())) {
            if(auto index = dynamic_cast<IntConst*>(i.get())) {
                unsigned long in = std::get<unsigned long>(index->value);
                offs->push_back(unique_ptr<SpecNode>(new IntConst(f->elems->at(in)->offset)));
                tv = f->elems->at(in)->type;
            } else {
                assert(false);
            }
        } else if (auto f = dynamic_cast<IRLoader::TNamedStruct *>(tv.get())) {
            auto name = f->name;

            std::replace(name.begin(), name.end(), '.', '!');
            tv = f->structs->at(name);
            if (auto sub = dynamic_cast<IRLoader::TStruct *>(tv.get())) {
                if (auto index = dynamic_cast<IntConst*>(i.get())) {
                    unsigned long in = std::get<unsigned long>(index->value);
                    offs->push_back(unique_ptr<SpecNode>(new IntConst(sub->elems->at(in)->offset)));
                    tv = sub->elems->at(in)->type;
                } else {
                    LOG_DEBUG << "not a IntConst for the index";
                    assert(false);
                }
            } else {
                LOG_DEBUG << "not a struct to be indexed of: " << tv->to_coq();
                assert(false);
            }
        }
    }

    offs->push_back(unique_ptr<SpecNode>(new IntConst(0)));

    auto elems = new vector<unique_ptr<SpecNode>>();
    elems->push_back(unique_ptr<SpecNode>(ir_value_to_spec(l, val, relies)));
    elems->push_back(reduce(offs.get(), 0));

    return new Expr("ptr_offset", unique_ptr<vector<unique_ptr<SpecNode>>>(elems));
  }

SpecNode *ir_expr_to_spec(Layer* l, IRLoader::Op op, vector<unique_ptr<IRValue>> *_args, vector<unique_ptr<SpecNode>> *relies)
{
    auto args = unique_ptr<vector<unique_ptr<SpecNode>>>(new vector<unique_ptr<SpecNode>>());

    for(auto & arg : *_args) {
        args->push_back(unique_ptr<SpecNode>(ir_value_to_spec(l, arg.get(), relies)));
    }

    switch(op.op) {
    case Op::OBitCast:
        return args->at(0).release();
    case Op::OSExt:
        return args->at(0).release();
    case Op::OTrunc:
        return args->at(0).release();
    case Op::OZExt:
        if(dynamic_cast<TBool*>(_args->at(0)->type.get()))
            return new Expr("bool_to_int", std::move(args));
        else
            return args->at(0).release();
    case Op::OPtrToInt:
        return new Expr(l->ops["ptr2int"], std::move(args));
    case Op::OIntToPtr:
        return new Expr(l->ops["int2ptr"], std::move(args));
    case Op::OGetElementPtr:
        return get_elem_ptr(l, _args->at(0).get(), args.get(), relies);
    case Op::Cslt:
        return new Expr(Expr::binops::BLT, std::move(args));
    case Op::Csle:
        return new Expr(Expr::binops::BLE, std::move(args));
    case Op::Cult:
        if(dynamic_cast<TInt*>(_args->at(0)->type.get()))
            return new Expr(Expr::binops::BLT, std::move(args));
        else if (dynamic_cast<TPtr*>(_args->at(0)->type.get()))
            return new Expr(l->ops["ptr_ltb"], std::move(args));
    case Op::Cule:
        return new Expr(Expr::binops::BLE, std::move(args));
    case Op::Ceq:
        if(dynamic_cast<TInt*>(_args->at(0)->type.get())) {

        return new Expr(Expr::binops::BEQ, std::move(args));
        } else if (dynamic_cast<TPtr*>(_args->at(0)->type.get())){
        return new Expr(l->ops["ptr_eqb"], std::move(args));
        }
        assert(false);
    case Op::Cne:
        if(dynamic_cast<TInt*>(_args->at(0)->type.get())) {

        return new Expr(Expr::binops::BNE, std::move(args));
        } else if (dynamic_cast<TPtr*>(_args->at(0)->type.get())){

        return new Expr(Expr::ops::NOT, std::move(args));
        }
        assert(false);
    case Op::Csgt:
        if(dynamic_cast<TInt*>(_args->at(0)->type.get())) {

        return new Expr(Expr::binops::BGT, std::move(args));
        } else if (dynamic_cast<TPtr*>(_args->at(0)->type.get())){

        return new Expr(l->ops["ptr_gtb"], std::move(args));
        }
    case Op::Csge:
        if(dynamic_cast<TInt*>(_args->at(0)->type.get())) {
        return new Expr(Expr::binops::BGE, std::move(args));
        } else {
        assert(false);
        }
    case Op::Cugt:
        if(dynamic_cast<TInt*>(_args->at(0)->type.get())) {
        return new Expr(Expr::binops::BGT, std::move(args));
        } else if (dynamic_cast<TPtr*>(_args->at(0)->type.get())){
        return new Expr(l->ops["ptr_gtb"], std::move(args));
        }
    case Op::Cuge:
        return new Expr(Expr::binops::BGE, std::move(args));
    case Op::OAdd:

        return new Expr(Expr::binops::ADD, std::move(args));
    case Op::OAnd:
        if(dynamic_cast<TInt*>(_args->at(0)->type.get())) {

        return new Expr(Expr::binops::BITAND, std::move(args));
        } else if (dynamic_cast<TBool*>(_args->at(0)->type.get())){

        return new Expr(Expr::binops::BAND, std::move(args));
        }
    case Op::OAshr:
        return new Expr(Expr::binops::RSHIFT, std::move(args));
    case Op::OLshr:
        return new Expr(Expr::binops::RSHIFT, std::move(args));
    case Op::OMul:
        return new Expr(Expr::binops::MULT, std::move(args));
    case Op::OOr:
        if(dynamic_cast<TInt*>(_args->at(0)->type.get())) {
        return new Expr(Expr::binops::BITOR, std::move(args));
        } else if (dynamic_cast<TBool*>(_args->at(0)->type.get())){
        return new Expr(Expr::binops::BOR, std::move(args));
        }
    case Op::OSdiv:
        return new Expr(Expr::binops::DIV, std::move(args));
    case Op::OSrem:
        return new Expr(Expr::binops::MOD, std::move(args));
    case Op::OShl:
        return new Expr(Expr::binops::LSHIFT, std::move(args));
    case Op::OSub:
        return new Expr(Expr::binops::MINUS, std::move(args));
    case Op::OUdiv:
        return new Expr(Expr::binops::DIV, std::move(args));
    case Op::OUrem:
        return new Expr(Expr::binops::MOD, std::move(args));
    case Op::OXor:
        if(dynamic_cast<TInt*>(_args->at(0)->type.get())) {
        return new Expr("Z.lxor", std::move(args));
        } else if (dynamic_cast<TBool*>(_args->at(0)->type.get())){
        return new Expr("xorb", std::move(args));
        }
    default:
        assert(false);
    }
    return nullptr;
}

SpecNode *ir_op_to_spec(Layer *l, IRLoader::IRInst *inst, SpecNode *remain_spec)
{
    auto relies = new vector<unique_ptr<SpecNode>>();
    auto args = new vector<unique_ptr<IRValue>>();
    SpecNode *expr;
    SpecNode *stmt;

    if (auto f = dynamic_cast<IRLoader::IUnaryOp *>(inst)) {
        args->push_back(unique_ptr<IRValue>(f->a->clone()));
        expr = ir_expr_to_spec(l, f->op, args, relies);
        stmt = autov::_Let(f->assign, expr, remain_spec);
    } else if (auto f = dynamic_cast<IRLoader::IBinOp *>(inst)) {
        args->push_back(unique_ptr<IRValue>(f->a->clone()));
        args->push_back(unique_ptr<IRValue>(f->b->clone()));
        expr = ir_expr_to_spec(l, f->op, args, relies);
        stmt = autov::_Let(f->assign, expr, remain_spec);
    }

    for(auto &rely: *relies)
    stmt = new Rely(std::move(rely), unique_ptr<SpecNode>(stmt));

    return stmt;
}

SpecNode* ir_insts_to_spec(Project *proj, Layer *Layer, string fname, vector<unique_ptr<IRInst>> *body,
                           vector<Definition *> *defs, vector<string> *args, bool in_loop,
                           bool final_return, string suffix, int start) {
    auto abs_data = Layer->abs_data;
    auto module = proj->code;
    auto func = (*module->functions)[fname];
    auto &types = func->types;
    auto relies = new vector<unique_ptr<SpecNode>>();
    unique_ptr<SpecNode> returns;

    if(args->size() > 0) {
        vector<unique_ptr<SpecNode>> *name_args = new vector<unique_ptr<SpecNode>>();

        for(auto a : *args) {
            if (a == "")
                continue;
            name_args->push_back(unique_ptr<SpecNode>(_name(a, types.get())));
        }
        name_args->push_back(unique_ptr<SpecNode>(_st(abs_data)));

        returns = unique_ptr<SpecNode>(_Some(_Tuple(name_args)));
    } else {
        returns = unique_ptr<SpecNode>(_Some(_st(abs_data)));
    }

    if(func->alloca_vars.size() > 0 && final_return) {
        auto children = make_unique<vector<unique_ptr<SpecNode>>>();

        children->push_back(make_unique<StringConst>(fname));
        children->push_back(unique_ptr<SpecNode>(_init_st(abs_data)));
        children->push_back(unique_ptr<SpecNode>(_st(abs_data)));

        returns = unique_ptr<SpecNode>(_When(_st(abs_data),
                                       new Expr(Layer->ops["free"], std::move(children)), returns.release()));
    }

    if(body->size() <= start)
        return returns.release();

    auto &inst = body->at(start);
    auto remain_spec = ir_insts_to_spec(proj, Layer, fname, body, defs, args, in_loop, final_return, suffix, start + 1);


    if(auto f = dynamic_cast<IAssign*>(inst.get())){
      auto stmt = _Let(f->assign, ir_value_to_spec(Layer, f->val.get(), relies), remain_spec);
      for(auto &p : *relies) {
        stmt = new Rely(std::move(p), unique_ptr<SpecNode>(stmt));
      }
      return stmt;
    } else if(auto f = dynamic_cast<IReturn*>(inst.get())) {
      if(f->val) {
        auto stmt = _Let("__return__", new BoolConst(true),
          _Let("__retval__", ir_value_to_spec(Layer, f->val.get(), relies), remain_spec));
        for(auto & p : *relies) {
          stmt = new Rely(std::move(p), unique_ptr<SpecNode>(stmt));
        }
        return stmt;
      } else {
        return _Let("__return__", new BoolConst(true), remain_spec);
      }
    } else if(auto f = dynamic_cast<IBreak*>(inst.get())) {
      return _Let("__break__", new BoolConst(true), remain_spec);
    } else if(auto f = dynamic_cast<IRLoader::IContinue*>(inst.get())) {
      return _Let("__continue__", new BoolConst(true), remain_spec);
    } else if(auto f = dynamic_cast<IRLoader::IUnaryOp*>(inst.get())) {
      return ir_op_to_spec(Layer, f, remain_spec);
    } else if(auto f = dynamic_cast<IRLoader::IBinOp*>(inst.get())) {
      return ir_op_to_spec(Layer, f, remain_spec);
    } else if(auto f = dynamic_cast<IRLoader::ISelect*>(inst.get())) {
        auto cond = ir_value_to_spec(Layer, f->cond.get(), relies);
        auto stmt = _Let(f->assign,
                         new If(unique_ptr<SpecNode>(cond),
                                unique_ptr<SpecNode>(ir_value_to_spec(Layer, f->true_val.get(), relies)),
                                unique_ptr<SpecNode>(ir_value_to_spec(Layer, f->false_val.get(), relies))),
                         remain_spec);

        for(auto &p : *relies) {
            stmt = new Rely(std::move(p), unique_ptr<SpecNode>(stmt));
        }

        return stmt;
    } else if(auto f = dynamic_cast<IRLoader::ICall*>(inst.get())) {
      if(auto v = dynamic_cast<IRLoader::VGlobal*>(f->func.get())) {
        auto func = v->name;

        auto args = new vector<unique_ptr<SpecNode>>();
        for(auto & a : *f->args) {
          args->push_back(unique_ptr<SpecNode>(ir_value_to_spec(Layer, a.get(), relies)));
        }

        args->push_back(unique_ptr<SpecNode>(_st(abs_data)));

        SpecNode* ret;
        if (dynamic_cast<IRLoader::TVoid*>(f->typ.get())) {
          ret = _st(abs_data);
        } else {
          auto children = new vector<unique_ptr<SpecNode>>();
          children->push_back(unique_ptr<SpecNode>(_name(f->assign, types.get())));
          children->push_back(unique_ptr<SpecNode>(_st(abs_data)));
          ret = _Tuple(children);
        }
        auto stmt = _When(ret, new Expr(func + "_spec",
        unique_ptr<vector<unique_ptr<SpecNode>>>(args)), remain_spec);
        for(auto &p : *relies) {
          stmt = new Rely(std::move(p) , unique_ptr<SpecNode>(stmt));
        }

        return stmt;
      } else if(dynamic_cast<IRLoader::VInlineAsm*>(f->func.get()) == nullptr) {
            auto wrapped_name = fname + "_funptr_wrap" + std::to_string(f->lineno);
            SpecType* wrapper_ret;
            if(proj->defs.find(wrapped_name) == proj->defs.end()) {
                if(dynamic_cast<IRLoader::TVoid*>(f->typ.get())) {
                    wrapper_ret = new Option(Layer->abs_data);
                } else {
                    auto child = new vector<shared_ptr<SpecType>>();
                    child->push_back(shared_ptr<SpecType>(ir_type_to_spec(f->typ.get())));
                    child->push_back(Layer->abs_data);
                    wrapper_ret = new Option(make_shared<Tuple>(shared_ptr<vector<shared_ptr<SpecType>>>(child)));
                }
                auto wrapper_body = new Symbol("None");
                auto wrapper_args = new vector<shared_ptr<Arg>>();
                wrapper_args->push_back(shared_ptr<Arg>(new Arg("func_ptr", Struct::Ptr)));
                int i = 0;
                for(auto & a : *f->args) {
                    wrapper_args->push_back(make_shared<Arg>("arg" + std::to_string(i), ir_type_to_spec(a->type.get())));
                    i++;
                }
                wrapper_args->push_back(shared_ptr<Arg>(new Arg("st", (*types)["st"])));
                defs->push_back(new Definition(wrapped_name,
                                               shared_ptr<SpecType>(wrapper_ret),
                                               unique_ptr<vector<shared_ptr<Arg>>>(wrapper_args),
                                               unique_ptr<SpecNode>(wrapper_body)));
            }
            auto args = new vector<unique_ptr<SpecNode>>();
            args->push_back(unique_ptr<SpecNode>(ir_value_to_spec(Layer, f->func.get(), relies)));
            for(auto & a : *f->args) {
                args->push_back(unique_ptr<SpecNode>(ir_value_to_spec(Layer, a.get(), relies)));
            }

            args->push_back(unique_ptr<SpecNode>(_st(abs_data)));

            SpecNode* ret;
            if (dynamic_cast<IRLoader::TVoid*>(f->typ.get())) {
                ret = _st(abs_data);
            } else {
                auto children = new vector<unique_ptr<SpecNode>>();
                children->push_back(unique_ptr<SpecNode>(_name(f->assign, types.get())));
                children->push_back(unique_ptr<SpecNode>(_st(abs_data)));
                ret = _Tuple(children);
            }
            auto stmt = _When(ret, new Expr(wrapped_name,
                                            unique_ptr<vector<unique_ptr<SpecNode>>>(args)),
                                            remain_spec);
            for(auto &p : *relies) {
                stmt = new Rely(std::move(p) , unique_ptr<SpecNode>(stmt));
            }
            return stmt;
        }
    } else if(auto f = dynamic_cast<IRLoader::IGetElemPtr*>(inst.get())) {
        auto vec = make_unique<vector<unique_ptr<IRValue>>>();

        vec->push_back(unique_ptr<IRValue>(f->val->clone()));
        for(auto &a : *f->index) {
            vec->push_back(unique_ptr<IRValue>(a->clone()));
        }
        auto stmt = _Let(f->assign, ir_expr_to_spec(Layer, Op::OGetElementPtr, vec.get(), relies), remain_spec);
        for(auto &p : *relies) {
            stmt = new Rely(std::move(p) , unique_ptr<SpecNode>(stmt));
        }
        return stmt;
    } else if(auto f = dynamic_cast<IRLoader::ILoad*>(inst.get())) {
        if(dynamic_cast<TInt*>(f->typ.get())) {
            auto children = new vector<unique_ptr<SpecNode>>();
            children->push_back(unique_ptr<SpecNode>(_name(f->assign, types.get())));
            children->push_back(unique_ptr<SpecNode>(_st(abs_data)));

            auto subexprs = new vector<unique_ptr<SpecNode>>();
            subexprs->push_back(unique_ptr<SpecNode>(new IntConst(load_store_typ(f->typ.get()))));
            subexprs->push_back(unique_ptr<SpecNode>(ir_value_to_spec(Layer, f->ptr.get(), relies)));
            subexprs->push_back(unique_ptr<SpecNode>(_st(abs_data)));

            auto stmt = _When(_Tuple(children),
            new Expr(Layer->ops["load"], unique_ptr<vector<unique_ptr<SpecNode>>>(subexprs)), remain_spec);
            for(auto &p : *relies) {
                stmt = new Rely(std::move(p) , unique_ptr<SpecNode>(stmt));
            }
        return stmt;
      } else if(dynamic_cast<TPtr*>(f->typ.get())) {
            (*types)[f->assign + "_tmp"] = Int::INT;
            auto children = new vector<unique_ptr<SpecNode>>();
            children->push_back(unique_ptr<SpecNode>(_name(f->assign + "_tmp", types.get())));
            children->push_back(unique_ptr<SpecNode>(_st(abs_data)));
            auto subexprs = new vector<unique_ptr<SpecNode>>();
            subexprs->push_back(unique_ptr<SpecNode>(new IntConst(load_store_typ(f->typ.get()))));
            subexprs->push_back(unique_ptr<SpecNode>(ir_value_to_spec(Layer, f->ptr.get(), relies)));
            subexprs->push_back(unique_ptr<SpecNode>(_st(abs_data)));

            auto subexprs2 = new vector<unique_ptr<SpecNode>>();
            subexprs2->push_back(unique_ptr<SpecNode>(_name(f->assign + "_tmp", types.get())));

            auto stmt = _When(_Tuple(children),
                              new Expr(Layer->ops["load"], unique_ptr<vector<unique_ptr<SpecNode>>>(subexprs)),
                              _Let(f->assign, new Expr(Layer->ops["int2ptr"], unique_ptr<vector<unique_ptr<SpecNode>>>(subexprs2)), remain_spec));

            for(auto &p : *relies)
                stmt = new Rely(std::move(p) , unique_ptr<SpecNode>(stmt));

            return stmt;
      } else if(dynamic_cast<TBool*>(f->typ.get())) {
            (*types)[f->assign + "_tmp"] = Int::INT;
            auto children = new vector<unique_ptr<SpecNode>>();
            children->push_back(unique_ptr<SpecNode>(_name(f->assign + "_tmp", types.get())));
            children->push_back(unique_ptr<SpecNode>(_st(abs_data)));
            auto subexprs = new vector<unique_ptr<SpecNode>>();
            subexprs->push_back(unique_ptr<SpecNode>(new IntConst(load_store_typ(f->typ.get()))));
            subexprs->push_back(unique_ptr<SpecNode>(ir_value_to_spec(Layer, f->ptr.get(), relies)));
            subexprs->push_back(unique_ptr<SpecNode>(_st(abs_data)));

            auto subexprs2 = new vector<unique_ptr<SpecNode>>();
            subexprs2->push_back(unique_ptr<SpecNode>(_name(f->assign + "_tmp", types.get())));
            subexprs2->push_back(unique_ptr<SpecNode>(new IntConst(0)));

            auto stmt = _When(_Tuple(children),
                              new Expr(Layer->ops["load"], unique_ptr<vector<unique_ptr<SpecNode>>>(subexprs)),
                              _Let(f->assign, new Expr(Expr::binops::BNE, unique_ptr<vector<unique_ptr<SpecNode>>>(subexprs2)), remain_spec));

            for(auto &p : *relies)
                stmt = new Rely(std::move(p) , unique_ptr<SpecNode>(stmt));

            return stmt;
      } else {
        LOG_DEBUG << "ILoad can only be assigned to int, ptr, or bool";
        assert(false);
      }
    } else if(auto f = dynamic_cast<IRLoader::IStore*>(inst.get())) {
      if(dynamic_cast<TInt*>(f->val->type.get())) {
        auto children = new vector<unique_ptr<SpecNode>>();
        children->push_back(unique_ptr<SpecNode>(new IntConst(load_store_typ(f->val->type.get()))));
        children->push_back(unique_ptr<SpecNode>(ir_value_to_spec(Layer, f->ptr.get(), relies)));
        children->push_back(unique_ptr<SpecNode>(ir_value_to_spec(Layer, f->val.get(), relies)));
        children->push_back(unique_ptr<SpecNode>(_st(abs_data)));

        auto stmt = _When(_st(abs_data),
        new Expr(Layer->ops["store"], unique_ptr<vector<unique_ptr<SpecNode>>>(children)), remain_spec);

        for(auto &p : *relies) {
          stmt = new Rely(std::move(p) , unique_ptr<SpecNode>(stmt));
        }
        return stmt;
      } else if(dynamic_cast<TPtr*>(f->val->type.get())) {
            auto children = new vector<unique_ptr<SpecNode>>();
            children->push_back(unique_ptr<SpecNode>(new IntConst(load_store_typ(f->val->type.get()))));
            children->push_back(unique_ptr<SpecNode>(ir_value_to_spec(Layer, f->ptr.get(), relies)));

            auto children2 = new vector<unique_ptr<SpecNode>>();
            children2->push_back(unique_ptr<SpecNode>(ir_value_to_spec(Layer, f->val.get(), relies)));
            children->push_back(unique_ptr<SpecNode>(new Expr(Layer->ops["ptr2int"], unique_ptr<vector<unique_ptr<SpecNode>>>(children2))));
            children->push_back(unique_ptr<SpecNode>(_st(abs_data)));

            auto stmt = _When(_st(abs_data),
            new Expr(Layer->ops["store"], unique_ptr<vector<unique_ptr<SpecNode>>>(children)), remain_spec);

            for(auto &p : *relies) {
                stmt = new Rely(std::move(p) , unique_ptr<SpecNode>(stmt));
            }
        return stmt;
      } else {
        LOG_DEBUG << "IStore not int or ptr";
        assert(false);
      }
    } else if(auto f = dynamic_cast<IRLoader::IAlloc*>(inst.get())) {
        if(auto typ = dynamic_cast<IRLoader::TPtr*>(f->typ.get())) {
            auto children = new vector<unique_ptr<SpecNode>>();
            children->push_back(unique_ptr<SpecNode>(_name(f->assign, types.get())));
            children->push_back(unique_ptr<SpecNode>(_st(abs_data)));

            auto subexprs = new vector<unique_ptr<SpecNode>>();
            subexprs->push_back(unique_ptr<SpecNode>(new StringConst(fname)));
            subexprs->push_back(unique_ptr<SpecNode>(new IntConst(load_store_typ(typ->subtype.get()))));
            subexprs->push_back(unique_ptr<SpecNode>(ir_value_to_spec(Layer, f->align, relies)));
            subexprs->push_back(unique_ptr<SpecNode>(_st(abs_data)));
            auto stmt = _When(_Tuple(children),
                              new Expr(Layer->ops["alloc"], unique_ptr<vector<unique_ptr<SpecNode>>>(subexprs)),
                              remain_spec);
            for(auto &p : *relies)
                stmt = new Rely(std::move(p) , unique_ptr<SpecNode>(stmt));

            return stmt;
        } else {
            LOG_DEBUG << "Not a pointer for alloc instruction\n";
            assert(false);
        }
    } else if(auto f = dynamic_cast<IRLoader::IIf*>(inst.get())) {
        auto cond = ir_value_to_spec(Layer, f->cond.get(), relies);
        auto then_body = ir_insts_to_spec(proj, Layer, fname, f->true_body.get(), defs, f->output.get(), in_loop, false, suffix, 0);
        auto else_body = ir_insts_to_spec(proj, Layer, fname, f->false_body.get(), defs, f->output.get(), in_loop, false, suffix, 0);

        SpecNode* val = new If(unique_ptr<SpecNode>(cond), unique_ptr<SpecNode>(then_body), unique_ptr<SpecNode>(else_body));
        for(auto o : *f->need_init) {
            if (o == "")
                continue;
            val = _Let(o, default_val((*types)[o]), val);
        }

        if (in_loop) {
            if (std::find(f->output->begin(), f->output->end(), "__continue__") != f->output->end()) {
                remain_spec = new If(unique_ptr<SpecNode>(_name("__continue__", types.get())),
                                unique_ptr<SpecNode>(returns->deep_copy()), unique_ptr<SpecNode>(remain_spec));
            }

            if (std::find(f->output->begin(), f->output->end(), "__break__") != f->output->end()) {
                remain_spec = new If(unique_ptr<SpecNode>(_name("__break__", types.get())),
                                unique_ptr<SpecNode>(returns->deep_copy()), unique_ptr<SpecNode>(remain_spec));
            }
        }

        if (std::find(f->output->begin(), f->output->end(), "__return__") != f->output->end()) {
            remain_spec = new If(unique_ptr<SpecNode>(_name("__return__", types.get())),
                            unique_ptr<SpecNode>(returns->deep_copy()), unique_ptr<SpecNode>(remain_spec));
        }

        SpecNode* out;
        if(f->output->size() > 0) {
            auto vec = new vector<unique_ptr<SpecNode>>();
            for(auto o : *f->output) {
                if (o == "")
                    continue;
                vec->push_back(unique_ptr<SpecNode>(new Symbol(o)));
            }
            vec->push_back(unique_ptr<SpecNode>(_st(abs_data)));
            out = _Tuple(vec);
        } else {
            out = _st(abs_data);
        }

        auto stmt = _When(out, val, remain_spec);
        for(auto &p : *relies) {
            stmt = new Rely(std::move(p) , unique_ptr<SpecNode>(stmt));
        }
        return stmt;
    }  else if(auto f = dynamic_cast<IRLoader::ILoop*>(inst.get())) {
        auto func_ptrs = check_fun_ptr(Layer, f->body.get());

        auto fptrs = vector<string>();
        for (auto & f : *func_ptrs) {
            if (auto symbol = dynamic_cast<Symbol*>(f.get())) {
                fptrs.push_back(symbol->text);
                (*types)[symbol->text] = Struct::Ptr;
            }
        }

        f->loop_args->insert(f->loop_args->end(), fptrs.begin(), fptrs.end());
        f->input->insert(f->input->end(), fptrs.begin(), fptrs.end());

        auto loop_hash = std::to_string(f->lineno);
        auto loop_spec_name = fname + "_loop" + loop_hash + suffix;

        //find a loop_spec_name not in conflict
        std::set<string> def_names;
        for(auto &def : *defs) {
            def_names.insert(def->name);
        }

        int c = 0;
        while (def_names.find(loop_spec_name) != def_names.end()) {
            loop_hash = std::to_string(f->lineno) + "_" + std::to_string(c);
            loop_spec_name = fname + "_loop" = loop_hash + suffix;
            c++;
        }

        auto loop_args = make_unique<vector<unique_ptr<SpecNode>>>();
        auto loop_init = make_unique<vector<unique_ptr<SpecNode>>>();

        loop_args->push_back(unique_ptr<SpecNode>(new Symbol("_N_", Inductive::Nat)));

        auto elems = new vector<unique_ptr<SpecNode>>();
        for(auto a : *f->input) {
            elems->push_back(unique_ptr<SpecNode>(_name(a, types.get())));
        }
        auto children = new Expr(fname + "_loop" + loop_hash + "_rank",
        unique_ptr<vector<unique_ptr<SpecNode>>>(elems));

        auto out_elems = new vector<unique_ptr<SpecNode>>();
        out_elems->push_back(unique_ptr<SpecNode>(children));

        loop_init->push_back(unique_ptr<SpecNode>(new Expr("z_to_nat",
        unique_ptr<vector<unique_ptr<SpecNode>>>(out_elems))));

        for(auto a : *f->loop_args) {
            loop_args->push_back(unique_ptr<SpecNode>(_name(a, types.get())));

            if(a == "__return__" || a == "__break__") {
                loop_init->push_back(unique_ptr<SpecNode>(new BoolConst(false)));
            } else if(std::find(f->input->begin(), f->input->end(), a) != f->input->end()) {
                loop_init->push_back(unique_ptr<SpecNode>(_name(a, types.get())));
            } else {
                loop_init->push_back(unique_ptr<SpecNode>(default_val((*types)[a])));
            }
        }

        loop_args->push_back(unique_ptr<SpecNode>(_st(abs_data)));
        loop_init->push_back(unique_ptr<SpecNode>(_st(abs_data)));

        if(proj->defs.find(loop_spec_name) == proj->defs.end()) {
            if(f->body->size() == 1 && (*f->body)[0]->output->size() == 1 && *(*(*f->body)[0]->output).begin() == "__continue__") {
                return new Symbol("None");
            } else {
                auto iteration_body = ir_insts_to_spec(proj, Layer, fname, f->body.get(), defs, f->loop_args.get(), true, false, suffix, 0);
                string low = "_low";
                auto substring = loop_spec_name.substr(0, loop_spec_name.size() - low.size());

                if ((proj->cmds).InitRely.find(substring) != (proj->cmds).InitRely.end()){
                    for (auto &prop : proj->cmds.InitRely[substring]) {
                        iteration_body = new Rely(prop->deep_copy(), unique_ptr<SpecNode>(iteration_body));
                    }
                }

                if (std::find(f->loop_args->begin(), f->loop_args->end(), "__return__") != f->loop_args->end()) {
                    auto loop_args_sub = new vector<unique_ptr<SpecNode>>();

                    for (auto it = loop_args->begin() + 1; it != loop_args->end(); it++) {
                        loop_args_sub->push_back((*it)->deep_copy());
                    }
                    iteration_body = new If(unique_ptr<SpecNode>(_name("__return__", types.get())),
                                            unique_ptr<SpecNode>(_Some(_Tuple(loop_args_sub))),
                                            unique_ptr<SpecNode>(iteration_body));
                }

                if (std::find(f->loop_args->begin(), f->loop_args->end(), "__break__") != f->loop_args->end()) {
                    auto loop_args_sub = new vector<unique_ptr<SpecNode>>();

                    for (auto it = loop_args->begin() + 1; it != loop_args->end(); it++) {
                        loop_args_sub->push_back((*it)->deep_copy());
                    }
                    iteration_body = new If(unique_ptr<SpecNode>(_name("__break__", types.get())),
                                            unique_ptr<SpecNode>(_Some(_Tuple(loop_args_sub))),
                                            unique_ptr<SpecNode>(iteration_body));
                }

                auto loop_body_args = make_unique<vector<unique_ptr<SpecNode>>>();
                for (auto &a: *loop_args)
                    loop_body_args->push_back(a->deep_copy());

                auto loop_args_sub_body = new vector<unique_ptr<SpecNode>>();
                auto loop_args_sub_O = new vector<unique_ptr<SpecNode>>();

                for (auto it = loop_args->begin() + 1; it != loop_args->end(); it++) {
                    loop_args_sub_body->push_back((*it)->deep_copy());
                    loop_args_sub_O->push_back((*it)->deep_copy());
                }
                auto loop_body = _When(_Tuple(loop_args_sub_body),
                                       new Expr(fname + "_loop" + loop_hash + suffix, std::move(loop_body_args)),
                                       iteration_body);

                auto tupletypes = new vector<shared_ptr<SpecType>>();
                for(auto a: *f->loop_args) {
                    tupletypes->push_back((*types)[a]);
                }
                tupletypes->push_back((*types)["st"]);
                auto option = new Option(shared_ptr<SpecType>(new Tuple(shared_ptr<vector<shared_ptr<SpecType>>>(tupletypes))));

                auto args = new vector<shared_ptr<Arg>>();
                args->push_back(shared_ptr<Arg>(new Arg("_N_", Inductive::Nat)));
                for(auto a :*f->loop_args) {
                    args->push_back(shared_ptr<Arg>(new Arg(a, (*types)[a])));
                }
                args->push_back(shared_ptr<Arg>(new Arg("st", (*types)["st"])));

                auto patterns = new vector<unique_ptr<PatternMatch>>();
                auto scase = new vector<unique_ptr<SpecNode>>();
                scase->push_back(unique_ptr<SpecNode>(new Symbol("_N_")));

                patterns->push_back(make_unique<PatternMatch>(unique_ptr<SpecNode>(_name("O", types.get())),
                                                              unique_ptr<SpecNode>(_Some(_Tuple(loop_args_sub_O)))));
                patterns->push_back(make_unique<PatternMatch>(make_unique<Expr>("S", unique_ptr<vector<unique_ptr<SpecNode>>>(scase)), unique_ptr<SpecNode>(loop_body)));

                auto match = new Match(unique_ptr<SpecNode>(_name("_N_", types.get())), unique_ptr<vector<unique_ptr<PatternMatch>>>(patterns));
                auto fixpoint = new Fixpoint(fname + "_loop" + loop_hash + suffix,
                                             shared_ptr<SpecType>(option), unique_ptr<vector<shared_ptr<Arg>>>(args),
                                             unique_ptr<SpecNode>(match));

                defs->push_back(fixpoint);
            }
        }

        if (proj->defs.find(fname + "_loop" + loop_hash + "_rank") == proj->defs.end()) {
            auto args = new vector<shared_ptr<Arg>>();

            for(auto a :*f->input)
                args->push_back(shared_ptr<Arg>(new Arg(a, (*types)[a])));

            defs->push_back(new Definition(fname + "_loop" + loop_hash + "_rank",
                            Int::INT,
                            unique_ptr<vector<shared_ptr<Arg>>>(args),
                            make_unique<IntConst>(0)));
        }

        if (std::find(f->output->begin(), f->output->end(), "__break__") != f->output->end()) {
            remain_spec = new If(unique_ptr<SpecNode>(_name("__break__", types.get())),
                                 unique_ptr<SpecNode>(remain_spec), unique_ptr<SpecNode>(new Symbol("None")));
        }

        if (std::find(f->output->begin(), f->output->end(), "__return__") != f->output->end()) {
            remain_spec = new If(unique_ptr<SpecNode>(_name("__return__", types.get())),
                                 unique_ptr<SpecNode>(returns->deep_copy()), unique_ptr<SpecNode>(remain_spec));
        }

        auto prop_elems = new vector<unique_ptr<SpecNode>>();
        auto args = new vector<unique_ptr<SpecNode>>();
        for(auto a :*f->input) {
            args->push_back(unique_ptr<SpecNode>(_name(a, types.get())));
        }

        prop_elems->push_back(unique_ptr<SpecNode>(new Expr(fname + "_loop" + loop_hash + "_rank", unique_ptr<vector<unique_ptr<SpecNode>>>(args))));
        prop_elems->push_back(unique_ptr<SpecNode>(new IntConst(0)));

        auto prop = new Expr(Expr::binops::GTE, unique_ptr<vector<unique_ptr<SpecNode>>>(prop_elems));
        auto loop_args_sub = new vector<unique_ptr<SpecNode>>();
        for (auto it = loop_args->begin() + 1; it != loop_args->end(); it++)
            loop_args_sub->push_back((*it)->deep_copy());

        auto spec = _When(_Tuple(loop_args_sub),
                          new Expr(fname + "_loop" + loop_hash + suffix, std::move(loop_init)), remain_spec);

        return new Rely(unique_ptr<SpecNode>(prop), unique_ptr<SpecNode>(spec));
    }  else if(auto f = dynamic_cast<IRLoader::IInsertValue*>(inst.get())) {
      //PASS
    } else {
        LOG_DEBUG << "Instruction not supported converting to SpecNode\n";
        LOG_DEBUG << inst->to_coq();
        assert(false);
    }

    throw std::runtime_error("Unreachable code");
  }

unique_ptr<vector<unique_ptr<SpecNode>>> check_fun_ptr(Layer *l, vector<unique_ptr<IRInst>> *insts) {
    auto ret = unique_ptr<vector<unique_ptr<SpecNode>>>(new vector<unique_ptr<SpecNode>>());
    vector<unique_ptr<SpecNode>> relies;

    for (auto &f : *insts) {
        if (auto i = dynamic_cast<IRLoader::ICall*>(f.get())) {
            if (dynamic_cast<IRLoader::VGlobal*>(i->func.get()) == nullptr && dynamic_cast<IRLoader::VInlineAsm*>(i->func.get()) == nullptr) {
                ret->push_back(unique_ptr<SpecNode>(ir_value_to_spec(l, i->func.get(), &relies)));
            }
        }
    }

    return ret;
}

  // suffix defaults to ""
vector<Definition *>* ir_to_spec(Project *proj, string fname, Layer *layer, string suffix) {
    auto abs_data = layer->abs_data;
    auto module = proj->code;
    auto func = (*module->functions)[fname];
    auto spec_name = func->fname + "_spec" + suffix;

    auto args = new vector<shared_ptr<Arg>>();
    for (auto &arg : *(func->args))
        args->push_back(make_shared<Arg>(arg->name, ir_type_to_spec(arg->type.get())));

    args->push_back(make_shared<Arg>("st", abs_data));

    SpecType* rettype;
    auto *retval = new vector<string>();
    //auto *def = new vector<unique_ptr<SpecNode>>();

    if(dynamic_cast<TVoid *>(func->rettype.get()))
        rettype = new Option(abs_data);
    else {
        shared_ptr<SpecType> ret = ir_type_to_spec(func->rettype.get());
        vector<shared_ptr<SpecType>> *vec = new vector<shared_ptr<SpecType>>();
        vec->push_back(ret);
        vec->push_back(abs_data);
        rettype = new Option(make_shared<Tuple>(unique_ptr<vector<shared_ptr<SpecType>>>(vec)));
        retval->push_back("__retval__");
    }

    analyze_input_output(func.get());
    auto types = new std::unordered_map<string, shared_ptr<SpecType>>();

    types->emplace("st", abs_data);

    analyze_types(func->body.get(), types);
    func->types = unique_ptr<std::unordered_map<string, shared_ptr<SpecType>>>(types);

    vector<Definition *>* defs = new vector<Definition *>();
    SpecNode* body = ir_insts_to_spec(proj, layer, func->fname, func->body.get(), defs, retval, false, true, suffix, 0);

    if(proj->cmds.InitRely.find(fname) != proj->cmds.InitRely.end()) {
        for(auto & f : proj->cmds.InitRely[fname])
            body = new Rely(f->deep_copy(), unique_ptr<SpecNode>(body));
    }

    if(func->alloca_vars.size() > 0) {
        body = _Let("init_st", _st(abs_data), body);
        vector<unique_ptr<SpecNode>> *nodes = new vector<unique_ptr<SpecNode>>();
        nodes->push_back(make_unique<StringConst>(fname));
        nodes->push_back(unique_ptr<SpecNode>(_st(abs_data)));

        SpecNode* expr = new Expr(layer->ops["new_frame"], unique_ptr<vector<unique_ptr<SpecNode>>>(nodes));
        body = _When(_st(abs_data), expr, body);
    }

    defs->push_back(new Definition(spec_name,
                                   shared_ptr<SpecType>(rettype),
                                   unique_ptr<vector<shared_ptr<Arg>>>(args),
                                   unique_ptr<SpecNode>(body)));

    return defs;
}

  // get the size of a IR Type, otherwise return -1
long load_store_typ(IRType *typ)
{
    if (TInt *i = dynamic_cast<TInt *>(typ))
        return i->szof();
    else if (dynamic_cast<TPtr *>(typ))
        return 8;
    else if (dynamic_cast<TBool *>(typ))
        return 1;
    else if (TNamedStruct *ns = dynamic_cast<TNamedStruct *>(typ)) {
        auto name = ns->name;

        std::replace(name.begin(), name.end(), '.', '!');
        return ns->structs->at(name)->szof();
    } else if (TStruct *ts = dynamic_cast<TStruct *>(typ))
        return ts->szof();
    else if (TArray *arr = dynamic_cast<TArray *>(typ))
        return arr->subtype->szof() * arr->length;
    else
        return -1;
}

static void _analyze_input_output(CFunction *func, vector<unique_ptr<IRInst>> &insts, vector<Inst> &before, vector<Inst> &after, bool in_loop) {
    for (int i = 0; i < insts.size(); i++) {
        std::set<string> before_input, before_output, input, output, after_input;

        if (i == 0 && func) {
            get_input_output(func, before_input, before_output);
            before.push_back(func);
        } else
            get_input_output(before, &insts, i, before_input, before_output);
        get_input_output(insts[i].get(), input, output);

        auto new_input = make_shared<vector<string>>();

        std::set_intersection(before_output.begin(), before_output.end(), input.begin(), input.end(), std::back_inserter(*new_input));
        insts[i]->input = new_input;

        if (in_loop) {
            if (output.find("__break__") == output.end() && output.find("__continue__") == output.end()) {
                std::set<string> after_output;

                get_input_output(&insts, i + 1, after, after_input, after_output);

                auto new_output = make_shared<vector<string>>();

                std::set_intersection(output.begin(), output.end(), after_input.begin(), after_input.end(), std::back_inserter(*new_output));
                insts[i]->output = new_output;
            } else {
                insts[i]->output = make_shared<vector<string>>(output.begin(), output.end());
                if (output.find("__continue__") != output.end()) {
                    if (std::find(insts[i]->output->begin(), insts[i]->output->end(), "__continue__") == insts[i]->output->end())
                        insts[i]->output->push_back("__continue__");
                }

                if (output.find("__break__") != output.end()) {
                    if (std::find(insts[i]->output->begin(), insts[i]->output->end(), "__break__") == insts[i]->output->end())
                        insts[i]->output->push_back("__break__");
                }
            }
        } else {
                std::set<string> after_output;

                get_input_output(&insts, i + 1, after, after_input, after_output);

                auto new_output = make_shared<vector<string>>();
                std::set_intersection(output.begin(), output.end(), after_input.begin(), after_input.end(), std::back_inserter(*new_output));
                insts[i]->output = new_output;
        }

        if (output.find("__retval__") != output.end()) {
            if (std::find(insts[i]->output->begin(), insts[i]->output->end(), "__retval__") == insts[i]->output->end())
                insts[i]->output->insert(insts[i]->output->begin(), "__retval__");
        }

        if (output.find("__return__") != output.end()) {
            if (std::find(insts[i]->output->begin(), insts[i]->output->end(), "__return__") == insts[i]->output->end())
                insts[i]->output->insert(insts[i]->output->begin(), "__return__");
        }

        if (auto inst_i = dynamic_cast<IRLoader::IIf *>(insts[i].get())) {
            vector<Inst> new_before, new_after;

            for (auto &i : before)
                new_before.push_back(i);
            for (int j = 0; j < i; j++)
                new_before.push_back(insts[j].get());

            for (int j = i + 1; j < insts.size(); j++)
                new_after.push_back(insts[j].get());
            for (auto &i : after)
                new_after.push_back(i);

            _analyze_input_output(nullptr, *inst_i->true_body, new_before, new_after, in_loop);
            _analyze_input_output(nullptr, *inst_i->false_body, new_before, new_after, in_loop);

            auto diff = make_unique<vector<string>>();
            std::set_difference(insts[i]->output->begin(), insts[i]->output->end(), before_output.begin(), before_output.end(), std::back_inserter(*diff));
            inst_i->need_init = std::move(diff);
        } else if (auto inst_i = dynamic_cast<IRLoader::ILoop *>(insts[i].get())) {
            vector<Inst> new_before, new_after;
            std::set<string> loop_input, loop_output;

            for (auto &i : before)
                new_before.push_back(i);
            for (int j = 0; j < i; j++)
                new_before.push_back(insts[j].get());

            for (int j = i + 1; j < insts.size(); j++)
                new_after.push_back(insts[j].get());
            for (auto &i : after)
                new_after.push_back(i);

            _analyze_input_output(nullptr, *inst_i->body, new_before, new_after, true);
            get_input_output(inst_i->body.get(), loop_input, loop_output);

            std::set<string> intersection;
            std::set_intersection(loop_output.begin(), loop_output.end(), after_input.begin(), after_input.end(), std::inserter(intersection, intersection.begin()));
            loop_output = intersection;

            auto loop_args = make_unique<vector<string>>();

            std::set_union(loop_input.begin(), loop_input.end(), loop_output.begin(), loop_output.end(), std::back_inserter(*loop_args));
            inst_i->loop_args = std::move(loop_args);


            if (output.find("__break__") != output.end()) {
                if (std::find(inst_i->loop_args->begin(), inst_i->loop_args->end(), "__break__") == inst_i->loop_args->end())
                    inst_i->loop_args->insert(inst_i->loop_args->begin(), "__break__");
            }

            if (output.find("__retval__") != output.end()) {
                if (std::find(inst_i->loop_args->begin(), inst_i->loop_args->end(), "__retval__") == inst_i->loop_args->end())
                    inst_i->loop_args->insert(inst_i->loop_args->begin(), "__retval__");
            }

            if (output.find("__return__") != output.end()) {
                if (std::find(inst_i->loop_args->begin(), inst_i->loop_args->end(), "__return__") == inst_i->loop_args->end())
                    inst_i->loop_args->insert(inst_i->loop_args->begin(), "__return__");
            }

            vector<Inst> before_var, after_var;

            for (auto name: *inst_i->loop_args) {
                before_var.push_back(new IRLoader::VLocal(TVoid::TVOID, name));
                after_var.push_back(new IRLoader::VLocal(TBool::TBOOL, name));
            }

            _analyze_input_output(nullptr, *inst_i->body, before_var, after_var, true);

            for (int i = 0; i < before_var.size(); i++) {
                assert(std::get<IRValue *>(before_var[i]));
                assert(std::get<IRValue *>(after_var[i]));

                delete std::get<IRValue *>(before_var[i]);
                delete std::get<IRValue *>(after_var[i]);
            }

        }
    }
}

static void analyze_input_output(CFunction *func) {
    vector <Inst> before, after;

    _analyze_input_output(func, *func->body, before, after, false);
}

static void get_input_output(vector<unique_ptr<IRInst>> *inst, int i, vector<Inst> &after, std::set<string> &input,
                             std::set<string> &output) {
    for (; i < inst->size(); i++)
        get_input_output(inst->at(i).get(), input, output);

    for (auto &i : after) {
        std::holds_alternative<IRInst *>(i) ?
            get_input_output(std::get<IRInst *>(i), input, output) :
            get_input_output(std::get<IRValue *>(i), input, output);
    }
}

static void get_input_output(vector<Inst> &before, vector<unique_ptr<IRInst>> *inst, int i, std::set<string> &input,
                             std::set<string> &output) {
    for (auto &i : before) {
        if (std::holds_alternative<IRInst *>(i))
            get_input_output(std::get<IRInst *>(i), input, output);
        else if (std::holds_alternative<CFunction *>(i))
            get_input_output(std::get<CFunction *>(i), input, output);
        else
            get_input_output(std::get<IRValue *>(i), input, output);
    }

    for (int j = 0; j < i; j++)
        get_input_output(inst->at(j).get(), input, output);
}

template <typename T>
static void get_input_output(vector<unique_ptr<T>> *inst, std::set<string> &input, std::set<string> &output) {
    for (auto &i : *inst)
        get_input_output(i.get(), input, output);
}

template <typename T>
static void get_input_output(vector<T> *inst, std::set<string> &input, std::set<string> &output) {
    for (auto &i : *inst)
        get_input_output(i, input, output);
}

static void get_input_output(CFunction *inst, std::set<string> &input, std::set<string> &output) {
    for (auto &arg : *inst->args) {
        output.insert(arg->name);
    }
}

static void get_input_output(IRInst *inst, std::set<string> &input, std::set<string> &output) {
    if (auto i = dynamic_cast<IAssign *>(inst)) {
        get_input_output(i->val.get(), input, output);
        output.insert(i->assign);
    } else if (auto i = dynamic_cast<IReturn *>(inst)) {
        if (i->val != nullptr) {
            get_input_output(i->val.get(), input, output);
            output.insert("__retval__");
        }
        output.insert("__return__");
    } else if (auto i = dynamic_cast<IBreak *>(inst)) {
        output.insert("__break__");
    } else if (auto i = dynamic_cast<IRLoader::IContinue *>(inst)) {
        output.insert("__continue__");
    } else if (auto i = dynamic_cast<IRLoader::IUnaryOp *>(inst)) {
        get_input_output(i->a.get(), input, output);
        output.insert(i->assign);
    } else if (auto i = dynamic_cast<IRLoader::IBinOp *>(inst)) {
        get_input_output(i->a.get(), input, output);
        get_input_output(i->b.get(), input, output);
        output.insert(i->assign);
    } else if (auto i = dynamic_cast<IRLoader::ISelect *>(inst)) {
        get_input_output(i->cond.get(), input, output);
        get_input_output(i->true_val.get(), input, output);
        get_input_output(i->false_val.get(), input, output);
        output.insert(i->assign);
    } else if (auto i = dynamic_cast<IRLoader::ICall *>(inst)) {
        for (auto &a : *i->args) {
            get_input_output(a.get(), input, output);
        }
        output.insert(i->assign);
    } else if (auto i = dynamic_cast<IRLoader::IIf *>(inst)) {
        get_input_output(i->cond.get(), input, output);
        get_input_output(i->true_body.get(), input, output);
        get_input_output(i->false_body.get(), input, output);
    } else if (auto i = dynamic_cast<IRLoader::ILoop *>(inst)) {
        get_input_output(i->body.get(), input, output);
    } else if (auto i = dynamic_cast<IRLoader::IGetElemPtr *>(inst)) {
        get_input_output(i->val.get(), input, output);
        get_input_output(i->index.get(), input, output);
        output.insert(i->assign);
    } else if (auto i = dynamic_cast<IRLoader::IExtractValue *>(inst)) {
        // TODO
    } else if (auto i = dynamic_cast<IRLoader::ILoad *>(inst)) {
        get_input_output(i->ptr.get(), input, output);
        output.insert(i->assign);
    } else if (auto i = dynamic_cast<IRLoader::IStore *>(inst)) {
        get_input_output(i->ptr.get(), input, output);
        get_input_output(i->val.get(), input, output);
    } else if (auto i = dynamic_cast<IRLoader::IAlloc *>(inst)) {
        output.insert(i->assign);
    } else if (auto i = dynamic_cast<IRLoader::IInsertValue *>(inst)) {
        output.insert(i->assign);
    } else {
        throw std::runtime_error(string(__func__) + ": Unknown instruction: " + inst->to_coq());
    }
}

static void get_input_output(IRValue *inst, std::set<string> &input, std::set<string> &output) {
    if (auto i = dynamic_cast<IRLoader::VLocal *>(inst)) {
        if (dynamic_cast<TVoid *>(i->type.get()))
            output.insert(i->name);
        else if (output.find(i->name) == output.end())
                input.insert(i->name);
    } else if (auto i = dynamic_cast<IRLoader::VExpr *>(inst)) {
        for (auto &a : *i->operands)
            get_input_output(a.get(), input, output);
    }
}

template <typename T, template<typename...> class PtrType>
void analyze_types(vector<PtrType<T>> *insts, unordered_map<string, shared_ptr<SpecType>> *types) {
    for(auto &inst : *insts) {
        analyze_types(inst.get(), types);
    }
}

void analyze_types(IRValue *inst, unordered_map<string, shared_ptr<SpecType>> *types);

void analyze_types(IRInst *inst, unordered_map<string, shared_ptr<SpecType>> *types) {
    if(auto i = dynamic_cast<IAssign *>(inst)) {
        analyze_types(i->val.get(), types);
        (*types)[i->assign] = ir_type_to_spec(i->typ.get());
    } else if(auto i = dynamic_cast<IReturn *>(inst)) {
        if (i->val != nullptr) {
            analyze_types(i->val.get(), types);
            (*types)["__retval__"] = ir_type_to_spec(i->val->type.get());
        }
        (*types)["__return__"] = Bool::BOOL;
    } else if (auto i = dynamic_cast<IBreak *>(inst)) {
        (*types)["__break__"] = Bool::BOOL;
    } else if (auto i = dynamic_cast<IRLoader::IContinue *>(inst)) {
        (*types)["__continue__"] = std::make_shared<Bool>();
    } else if (auto i = dynamic_cast<IRLoader::IUnaryOp *>(inst)) {
        analyze_types(i->a.get(), types);
        (*types)[i->assign] = ir_type_to_spec(i->typ.get());
    } else if (auto i = dynamic_cast<IRLoader::IBinOp *>(inst)) {
        analyze_types(i->a.get(), types);
        analyze_types(i->b.get(), types);
        (*types)[i->assign] = ir_type_to_spec(i->typ.get());
    } else if (auto i = dynamic_cast<IRLoader::ISelect *>(inst)) {
        analyze_types(i->cond.get(), types);
        analyze_types(i->true_val.get(), types);
        analyze_types(i->false_val.get(), types);
        (*types)[i->assign] = ir_type_to_spec(i->typ.get());
    } else if (auto i = dynamic_cast<IRLoader::ICall *>(inst)) {
        for (auto& a : *i->args) {
            analyze_types(a.get(), types);
        }
        (*types)[i->assign] = ir_type_to_spec(i->typ.get());
    } else if (auto i = dynamic_cast<IRLoader::IIf *>(inst)) {
        analyze_types(i->cond.get(), types);
        analyze_types(i->true_body.get(), types);
        analyze_types(i->false_body.get(), types);
    } else if (auto i = dynamic_cast<IRLoader::ILoop*>(inst)) {
        analyze_types(i->body.get(), types);
        (*types)["_N_"] = Inductive::Nat;
    } else if (auto i = dynamic_cast<IRLoader::IGetElemPtr *>(inst)) {
        analyze_types(i->val.get(), types);
        analyze_types(i->index.get(), types);
        (*types)[i->assign] = ir_type_to_spec(i->typ.get());
    } else if (auto i = dynamic_cast<IRLoader::ILoad*>(inst)) {
        analyze_types(i->ptr.get(), types);
        (*types)[i->assign] = ir_type_to_spec(i->typ.get());
    } else if (auto i = dynamic_cast<IRLoader::IStore*>(inst)) {
        analyze_types(i->ptr.get(), types);
        analyze_types(i->val.get(), types);
    } else if (auto i = dynamic_cast<IRLoader::IAlloc*>(inst)) {
        (*types)[i->assign] = ir_type_to_spec(i->typ.get());
    }  else if (auto i = dynamic_cast<IRLoader::IInsertValue*>(inst)) {
    (*types)[i->assign] = ir_type_to_spec(i->typ.get());
    } else {
        throw std::runtime_error(string(__func__) + ": Unknown instruction: " + inst->to_coq());
    }
}

void analyze_types(IRValue *inst, unordered_map<string, shared_ptr<SpecType>> *types) {
    if (auto i = dynamic_cast<IRLoader::VLocal*>(inst)) {
        (*types)[i->name] = ir_type_to_spec(i->type.get());
    } else if (auto i = dynamic_cast<IRLoader::VExpr*>(inst)) {
        for (auto& a : *i->operands) {
            analyze_types(a.get(), types);
        }
    }
}

}