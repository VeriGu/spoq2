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
  
	typedef std::variant<IRValue, IRInst, autov::IRLoader::Function> Inst;

	SpecNode *ir_expr_to_spec(Layer* l, IRLoader::Op op, vector<unique_ptr<IRValue>> *_args, vector<unique_ptr<SpecNode>> *relies);

	template <template<typename...> class PtrType>
	void analyze_input_output(vector<PtrType<Inst>> *insts, vector<shared_ptr<Inst>> *before, vector<shared_ptr<Inst>> *after, bool in_loop);

	template <typename T, template<typename...> class PtrType>
	void analyze_types(vector<PtrType<T>> *insts, unordered_map<string, shared_ptr<SpecNode>> *types);

  long load_store_typ(IRType *typ);

	shared_ptr<SpecType> ir_type_to_spec(IRType *typ)
	{
		if (typeid(typ) == typeid(TInt *))
		{
			return Int::INT;
		}
		else if (typeid(typ) == typeid(TBool *))
		{
			return Bool::BOOL;
		}
		else if (typeid(typ) == typeid(TVoid *))
		{
			return shared_ptr<SpecType>(new SpecType("Void"));
		}
		else if (typeid(typ) == typeid(TFunction))
		{
			TFunction *func = dynamic_cast<TFunction *>(typ);
			vector<shared_ptr<SpecType>> *vec = new vector<shared_ptr<SpecType>>();
			for (auto t : *(func->arglist))
			{
				vec->push_back(ir_type_to_spec(t.get()));
			}
			return shared_ptr<SpecType>(new Function(ir_type_to_spec(func->rettype.get()), shared_ptr<vector<shared_ptr<SpecType>>>(vec)));
		}
		else if (typeid(typ) == typeid(TPtr *))
		{
			return Struct::Ptr;
		}
		else if (typeid(typ) == typeid(TNamedStruct *))
		{
			TNamedStruct *ns = dynamic_cast<TNamedStruct *>(typ);
			return shared_ptr<SpecType>(new SpecType(ns->name));
		}
		else if (typeid(typ) == typeid(TArray *))
		{
			TArray *array = dynamic_cast<TArray *>(typ);
			return shared_ptr<SpecType>(new Array(ir_type_to_spec(array->subtype.get())));
		}
		else
		{
			throw std::invalid_argument("invalid types");
		}
	}

	// return a raw pointer to give a flexibility of handler to deal with
	//  pointer, should be wrapped in a smart pointer
	SpecNode *default_val(shared_ptr<SpecType> typ)
	{
		if (typeid(typ.get()) == typeid(Int *))
		{
			return new IntConst(0);
		}
		else if (typeid(typ.get()) == typeid(Bool *))
		{
			return new BoolConst(false);
		}
		else if (typeid(typ.get()) == typeid(Struct *) && typ->name == "Ptr")
		{
			vector<unique_ptr<SpecNode>> *vec = new vector<unique_ptr<SpecNode>>();
			vec->push_back(unique_ptr<SpecNode>(new StringConst("#")));
			vec->push_back(unique_ptr<SpecNode>(new IntConst(0)));
			return new Expr("mkPtr", unique_ptr<vector<unique_ptr<SpecNode>>>(vec));
		}
		else if (typeid(typ.get()) == typeid(String *))
		{
			return new StringConst("");
		}
		else
		{
			assert(false);
		}
	}

	SpecNode *ir_value_to_spec(Layer* L, std::any v, vector<unique_ptr<SpecNode>> *relies)
	{
		if (typeid(v) == typeid(int))
		{
			return new IntConst(std::any_cast<int>(v));
		}
		else if (typeid(v) == typeid(bool))
		{
			return new BoolConst(std::any_cast<bool>(v));
		}
		else if (typeid(v) == typeid(string))
		{
			return new StringConst(std::any_cast<string>(v));
		}
		else if (typeid(v) == typeid(autov::IRLoader::VLocal))
		{
			return new Symbol((std::any_cast<autov::IRLoader::VLocal>(v)).name);
		}
		else if (typeid(v) == typeid(autov::IRLoader::VGlobal))
		{
			autov::IRLoader::VGlobal vg = std::any_cast<autov::IRLoader::VGlobal>(v);
			vector<unique_ptr<SpecNode>> *vec = new vector<unique_ptr<SpecNode>>();
			vec->push_back(unique_ptr<SpecNode>(new StringConst(vg.name)));
			vec->push_back(unique_ptr<SpecNode>(new IntConst(0)));
			return new Expr("mkPtr", unique_ptr<vector<unique_ptr<SpecNode>>>(vec));
		}
		else if (typeid(v) == typeid(autov::IRLoader::VInt))
		{
			unsigned long val = (std::any_cast<autov::IRLoader::VInt>(v)).val;
			return new IntConst(val);
		}
		else if (typeid(v) == typeid(autov::IRLoader::VBool))
		{
			bool val = (std::any_cast<autov::IRLoader::VBool>(v)).val;
			if (val)
			{
				return new BoolConst(true);
			}
			else
			{
				return new BoolConst(false);
			}
		}
		else if (typeid(v) == typeid(IRLoader::VExpr))
		{
			IRLoader::VExpr v = (std::any_cast<autov::IRLoader::VExpr>(v));
			return ir_expr_to_spec(L, v.op, v.operands.get(), relies);
		}
		else if (typeid(v) == typeid(IRLoader::VNull))
		{
			vector<unique_ptr<SpecNode>> *vec = new vector<unique_ptr<SpecNode>>();
			vec->push_back(unique_ptr<SpecNode>(new StringConst("null")));
			vec->push_back(unique_ptr<SpecNode>(new IntConst(0)));
			return new Expr("mkPtr", unique_ptr<vector<unique_ptr<SpecNode>>>(vec));
		}
		else if (typeid(v) == typeid(autov::IRLoader::VUndef))
		{
			IRLoader::VUndef undef = std::any_cast<autov::IRLoader::VUndef>(v);
			if (typeid((undef.type)) == typeid(IRLoader::TPtr *))
			{
				vector<unique_ptr<SpecNode>> *vec = new vector<unique_ptr<SpecNode>>();
				vec->push_back(unique_ptr<SpecNode>(new StringConst("null")));
				vec->push_back(unique_ptr<SpecNode>(new IntConst(0)));
				return new Expr("mkPtr", unique_ptr<vector<unique_ptr<SpecNode>>>(vec));
			}
			else if (typeid(undef.type) == typeid(IRLoader::TBool *))
			{
				return new BoolConst(false);
			}
			else if (typeid(undef.type) == typeid(IRLoader::TInt *))
			{
				return new IntConst(0);
			}
			else
			{
				unordered_map<string, shared_ptr<SpecType>> *map = new unordered_map<string, shared_ptr<SpecType>>();
				return autov::_name("UNDEF", map);
			}
		}
		else
		{
			unordered_map<string, shared_ptr<SpecType>> *map = new unordered_map<string, shared_ptr<SpecType>>();
			return autov::_name("UNKNOWN_VALUE", map);
		}
	}

	SpecNode *ir_expr_to_spec(Layer* l, IRLoader::Op op, vector<unique_ptr<IRValue>> *_args, vector<unique_ptr<SpecNode>> *relies)
	{
		auto args = unique_ptr<vector<unique_ptr<SpecNode>>>(new vector<unique_ptr<SpecNode>>());
		for(auto & arg : *_args) {
			args->push_back(unique_ptr<SpecNode>(ir_value_to_spec(l, *arg, relies)));
		}

		switch(op.op) {
			case Op::OBitCast:
				return args->at(0).get();
			case Op::OSExt:
				return args->at(0).get();
			case Op::OTrunc:
				return args->at(0).get();
			case Op::OZExt:
				if(dynamic_cast<TBool*>(_args->at(0)->type.get())) {
					return new Expr("bool_to_int", std::move(args));
				} else {
					return args->at(0).get();
				}
			case Op::OPtrToInt:
				return new Expr(l->ops["ptr2int"], std::move(args));
			case Op::OIntToPtr:
				return new Expr(l->ops["int2ptr"], std::move(args));
			case Op::OGetElementPtr:
				//TODO
				return nullptr;
			case Op::Cslt:
				return new Expr("<?", std::move(args));
		  case Op::Csle:
				return new Expr("<=?", std::move(args));
			case Op::Cult:
				if(dynamic_cast<TInt*>(_args->at(0)->type.get())) {
				  return new Expr("<?", std::move(args));
				} else if (dynamic_cast<TPtr*>(_args->at(0)->type.get())){
					return new Expr(l->ops["ptr_ltb"], std::move(args));
				}
			case Op::Cule:
				return new Expr("<=?", std::move(args));
			case Op::Ceq:
				if(dynamic_cast<TInt*>(_args->at(0)->type.get())) {
					
				  return new Expr("=?", std::move(args));
				} else if (dynamic_cast<TPtr*>(_args->at(0)->type.get())){
					return new Expr(l->ops["ptr_eqb"], std::move(args));
				}
				assert(false);
			case Op::Cne:
			  if(dynamic_cast<TInt*>(_args->at(0)->type.get())) {
					
				  return new Expr("<>?", std::move(args));
				} else if (dynamic_cast<TPtr*>(_args->at(0)->type.get())){
					
					return new Expr("!", std::move(args));
				}
				assert(false);
			case Op::Csgt:
				if(dynamic_cast<TInt*>(_args->at(0)->type.get())) {
					
				  return new Expr(">?", std::move(args));
				} else if (dynamic_cast<TPtr*>(_args->at(0)->type.get())){
				
					return new Expr(l->ops["ptr_gtb"], std::move(args));
				}	
			case Op::Csge:
				if(dynamic_cast<TInt*>(_args->at(0)->type.get())) {
				  return new Expr(">=?", std::move(args));
				} else {
					assert(false);
				}
			case Op::Cugt:
				if(dynamic_cast<TInt*>(_args->at(0)->type.get())) {
				  return new Expr(">?", std::move(args));
				} else if (dynamic_cast<TPtr*>(_args->at(0)->type.get())){
					return new Expr(l->ops["ptr_gtb"], std::move(args));
				}
			case Op::Cuge:
				
				return new Expr(">?", std::move(args));
			case Op::OAdd:
				
				return new Expr("+", std::move(args));
			case Op::OAnd:
				if(dynamic_cast<TInt*>(_args->at(0)->type.get())) {
					
				  return new Expr("&", std::move(args));
				} else if (dynamic_cast<TBool*>(_args->at(0)->type.get())){
					
					return new Expr("&&", std::move(args));
				}
			case Op::OAshr:
				return new Expr(">>", std::move(args));
			case Op::OLshr:
				return new Expr("<<", std::move(args));
			case Op::OMul:
				return new Expr("*", std::move(args));
			case Op::OOr:
				if(dynamic_cast<TInt*>(_args->at(0)->type.get())) {
				  return new Expr("|\'", std::move(args));
				} else if (dynamic_cast<TBool*>(_args->at(0)->type.get())){
					return new Expr("||", std::move(args));
				}
			case Op::OSdiv:
				return new Expr("/", std::move(args));
			case Op::OSrem:
				return new Expr("mod", std::move(args));
			case Op::OShl:
				return new Expr("<<", std::move(args));
			case Op::OSub:
				return new Expr("-", std::move(args));
			case Op::OUdiv:
				return new Expr("/", std::move(args));
			case Op::OUrem:
				return new Expr("mod", std::move(args));
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
		if (auto f = dynamic_cast<IRLoader::IUnaryOp *>(inst))
		{
		  args->push_back(unique_ptr<IRValue>(f->a->clone()));
			expr = ir_expr_to_spec(l, f->op, args, relies);
			stmt = autov::_Let(f->assign, expr, remain_spec);
		}
		else if (auto f = dynamic_cast<IRLoader::IBinOp *>(inst))
		{
			args->push_back(unique_ptr<IRValue>(f->a->clone()));
			args->push_back(unique_ptr<IRValue>(f->b->clone()));
			expr = ir_expr_to_spec(l, f->op, args, relies);
			stmt = autov::_Let(f->assign, expr, remain_spec);
		}
		for(auto &rely: *relies) {
			stmt = new Rely(std::move(rely), unique_ptr<SpecNode>(stmt));
		}

		return stmt;
	}

	SpecNode* ir_insts_to_spec(Project *proj, Layer *Layer, string fname, vector<unique_ptr<IRInst>> *body,
	 vector<unique_ptr<autov::Definition>> *defs, std::unordered_set<string> *args, bool in_loop, bool final_return, string suffix, int start) {
		auto abs_data = Layer->abs_data;
		auto module = proj->code;
		auto func = (*module->functions)[fname];
		auto &types = func->types;
		auto relies = new vector<unique_ptr<SpecNode>>();
		SpecNode* returns;

		vector<unique_ptr<SpecNode>> *name_args = new vector<unique_ptr<SpecNode>>();
		if(args->size() > 0) {
			for(auto a : *args) {
				name_args->push_back(unique_ptr<SpecNode>(autov::_name(a, types.get())));
			}
			name_args->push_back(unique_ptr<SpecNode>(autov::_st(abs_data)));

			returns = autov::_Some(autov::_Tuple(name_args));
		} else {
			name_args->push_back(unique_ptr<SpecNode>(autov::_st(abs_data)));
			returns = autov::_Some(autov::_Tuple(name_args));
		}

		if(func->alloca_vars.size() > 0 && final_return) {
			vector<unique_ptr<SpecNode>>* children = new vector<unique_ptr<SpecNode>>();
			children->push_back(unique_ptr<SpecNode>(new StringConst(fname)));
			children->push_back(unique_ptr<SpecNode>(autov::_init_st(abs_data)));
			children->push_back(unique_ptr<SpecNode>(autov::_st(abs_data)));
			
			returns = autov::_When(autov::_st(abs_data), new Expr(Layer->ops["free"], 
			unique_ptr<vector<unique_ptr<SpecNode>>>(children)), returns);
		}

		if(body->size() == 0) {
				return returns;
		}

		auto &inst = body->at(start);
	  auto remain_spec = ir_insts_to_spec(proj, Layer, fname, body, defs, args, in_loop, final_return, suffix, start + 1);


		if(auto f = dynamic_cast<IAssign*>(inst.get())){
			auto stmt = autov::_Let(f->assign, ir_value_to_spec(Layer, *(f->val), relies), remain_spec);
			for(auto &p : *relies) {
				stmt = new autov::Rely(std::move(p), unique_ptr<SpecNode>(stmt));
			}
			return stmt;
		} else if(auto f = dynamic_cast<IReturn*>(inst.get())) {
			if(f->val) {
				auto stmt = autov::_Let("__return__", new BoolConst(true), 
					autov::_Let("__retval__", ir_value_to_spec(Layer, *(f->val), relies), remain_spec));
				for(auto & p : *relies) {
					stmt = new autov::Rely(std::move(p), unique_ptr<SpecNode>(stmt));
				}
				return stmt;
			} else {
				return autov::_Let("__return__", new BoolConst(true), remain_spec);
			}
		} else if(auto f = dynamic_cast<IBreak*>(inst.get())) {
			return autov::_Let("__break__", new BoolConst(true), remain_spec);
		} else if(auto f = dynamic_cast<IRLoader::IContinue*>(inst.get())) {
			return autov::_Let("__continue__", new BoolConst(true), remain_spec);
		} else if(auto f = dynamic_cast<IRLoader::IUnaryOp*>(inst.get())) {
			return ir_op_to_spec(Layer, f, remain_spec);
		} else if(auto f = dynamic_cast<IRLoader::IBinOp*>(inst.get())) {
			return ir_op_to_spec(Layer, f, remain_spec);
		} else if(auto f = dynamic_cast<IRLoader::ISelect*>(inst.get())) {
			auto cond = ir_value_to_spec(Layer, *(f->cond), relies);
			auto stmt = autov::_Let(f->assign, 
			new autov::If(unique_ptr<SpecNode>(cond), 
			unique_ptr<SpecNode>(ir_value_to_spec(Layer, *f->true_val, relies)),
			unique_ptr<SpecNode>(ir_value_to_spec(Layer, *f->false_val, relies))), remain_spec);

			for(auto &p : *relies) {
				stmt = new autov::Rely(std::move(p), unique_ptr<SpecNode>(stmt));
			}
		} else if(auto f = dynamic_cast<IRLoader::ICall*>(inst.get())) {
			if(auto v = dynamic_cast<IRLoader::VGlobal*>(f->func.get())) {
				auto func = v->name;

				auto args = new vector<unique_ptr<SpecNode>>();
				for(auto & a : *f->args) {
					args->push_back(unique_ptr<SpecNode>(ir_value_to_spec(Layer, *a, relies)));
				}

				args->push_back(unique_ptr<SpecNode>(autov::_st(abs_data)));

				SpecNode* ret;
				if (dynamic_cast<IRLoader::TVoid*>(f->typ.get())) {
					ret = autov::_st(abs_data);
				} else {
					auto children = new vector<unique_ptr<SpecNode>>();
				  children->push_back(unique_ptr<SpecNode>(autov::_name(f->assign, types.get())));
					children->push_back(unique_ptr<SpecNode>(autov::_st(abs_data)));
					ret = autov::_Tuple(children);
				}
				auto stmt = autov::_When(ret, new Expr(func + "_spec", 
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
						wrapper_ret = new autov::Option(Layer->abs_data);
					} else {
						auto child = new vector<shared_ptr<SpecType>>();
						child->push_back(shared_ptr<SpecType>(ir_type_to_spec(f->typ.get())));
						child->push_back(Layer->abs_data);
				    wrapper_ret = new autov::Option(
							shared_ptr<SpecType>(
						    new autov::Tuple(shared_ptr<vector<shared_ptr<SpecType>>>(child))));
					}
					auto wrapper_body = new autov::Symbol("None");
					auto wrapper_args = new vector<shared_ptr<Arg>>();
					wrapper_args->push_back(shared_ptr<Arg>(new Arg("func_ptr", autov::Struct::Ptr)));
					int i;
					for(auto & a : *f->args) {
						wrapper_args->push_back(shared_ptr<Arg>(new Arg("arg" + std::to_string(i), ir_type_to_spec(a->type.get()))));
						i++;
					}
					wrapper_args->push_back(shared_ptr<Arg>(new Arg("st", (*types)["st"])));
					defs->push_back(unique_ptr<Definition>(new Definition(wrapped_name, 
						shared_ptr<SpecType>(wrapper_ret),
						unique_ptr<vector<shared_ptr<Arg>>>(wrapper_args),
						unique_ptr<SpecNode>(wrapper_body))));
				}
				auto args = new vector<unique_ptr<SpecNode>>();
				for(auto & a : *f->args) {
					args->push_back(unique_ptr<SpecNode>(ir_value_to_spec(Layer, *a, relies)));
				}

				args->push_back(unique_ptr<SpecNode>(autov::_st(abs_data)));

				SpecNode* ret;
				if (dynamic_cast<IRLoader::TVoid*>(f->typ.get())) {
					ret = autov::_st(abs_data);
				} else {
					auto children = new vector<unique_ptr<SpecNode>>();
				  children->push_back(unique_ptr<SpecNode>(autov::_name(f->assign, types.get())));
					children->push_back(unique_ptr<SpecNode>(autov::_st(abs_data)));
					ret = autov::_Tuple(children);
				}
				auto stmt = autov::_When(ret, new Expr(wrapped_name, 
				unique_ptr<vector<unique_ptr<SpecNode>>>(args)), remain_spec);
				for(auto &p : *relies) {
					stmt = new Rely(std::move(p) , unique_ptr<SpecNode>(stmt));
				}
				return stmt;
			}
		} else if(auto f = dynamic_cast<IRLoader::IGetElemPtr*>(inst.get())) {
			
			unique_ptr<vector<unique_ptr<IRValue>>> vec = unique_ptr<vector<unique_ptr<IRValue>>>(new vector<unique_ptr<IRValue>>());
			vec->push_back(make_unique<IRValue>(*f->val));
			for(auto &a : *f->index) {
				vec->push_back(make_unique<IRValue>(*a));
			}
			auto stmt = autov::_Let(f->assign, ir_expr_to_spec(Layer, autov::Op::OGetElementPtr, vec.get(), relies), remain_spec);
			for(auto &p : *relies) {
					stmt = new Rely(std::move(p) , unique_ptr<SpecNode>(stmt));
			}
			return stmt;
		} else if(auto f = dynamic_cast<IRLoader::ILoad*>(inst.get())) {
			if(dynamic_cast<TInt*>(f->typ.get())) {
				auto children = new vector<unique_ptr<SpecNode>>();
				children->push_back(unique_ptr<SpecNode>(autov::_name(f->assign, types.get())));
				children->push_back(unique_ptr<SpecNode>(autov::_st(abs_data)));

				auto subexprs = new vector<unique_ptr<SpecNode>>();
				subexprs->push_back(unique_ptr<SpecNode>(new IntConst(load_store_typ(f->typ.get()))));
				subexprs->push_back(unique_ptr<SpecNode>(ir_value_to_spec(Layer, *f->ptr, relies)));
				subexprs->push_back(unique_ptr<SpecNode>(autov::_st(abs_data)));

				auto stmt = autov::_When(autov::_Tuple(children), 
				new Expr(Layer->ops["load"], unique_ptr<vector<unique_ptr<SpecNode>>>(subexprs)), remain_spec);
				for(auto &p : *relies) {
					stmt = new Rely(std::move(p) , unique_ptr<SpecNode>(stmt));
				}
				return stmt;
			} else if(dynamic_cast<TPtr*>(f->typ.get())) {
				(*types)[f->assign + "_tmp"] = Int::INT;
				auto children = new vector<unique_ptr<SpecNode>>();
				children->push_back(unique_ptr<SpecNode>(autov::_name(f->assign, types.get())));
				children->push_back(unique_ptr<SpecNode>(autov::_st(abs_data)));
				auto subexprs = new vector<unique_ptr<SpecNode>>();
				subexprs->push_back(unique_ptr<SpecNode>(new IntConst(load_store_typ(f->typ.get()))));
				subexprs->push_back(unique_ptr<SpecNode>(ir_value_to_spec(Layer, *f->ptr, relies)));
				subexprs->push_back(unique_ptr<SpecNode>(autov::_st(abs_data)));

				auto subexprs2 = new vector<unique_ptr<SpecNode>>();
				subexprs2->push_back(unique_ptr<SpecNode>(autov::_name(f->assign + "_tmp", types.get())));
	
				auto stmt = autov::_When(autov::_Tuple(children), 
				new Expr(Layer->ops["load"], unique_ptr<vector<unique_ptr<SpecNode>>>(subexprs)), 
				autov::_Let(f->assign, new Expr(Layer->ops["int2ptr"], unique_ptr<vector<unique_ptr<SpecNode>>>(subexprs2)), remain_spec));

				for(auto &p : *relies) {
					stmt = new Rely(std::move(p) , unique_ptr<SpecNode>(stmt));
				}
				return stmt;
			} else if(dynamic_cast<TBool*>(f->typ.get())) {
				(*types)[f->assign + "_tmp"] = Int::INT;
				auto children = new vector<unique_ptr<SpecNode>>();
				children->push_back(unique_ptr<SpecNode>(autov::_name(f->assign, types.get())));
				children->push_back(unique_ptr<SpecNode>(autov::_st(abs_data)));
				auto subexprs = new vector<unique_ptr<SpecNode>>();
				subexprs->push_back(unique_ptr<SpecNode>(new IntConst(load_store_typ(f->typ.get()))));
				subexprs->push_back(unique_ptr<SpecNode>(ir_value_to_spec(Layer, *f->ptr, relies)));
				subexprs->push_back(unique_ptr<SpecNode>(autov::_st(abs_data)));

				auto subexprs2 = new vector<unique_ptr<SpecNode>>();
				subexprs2->push_back(unique_ptr<SpecNode>(autov::_name(f->assign + "_tmp", types.get())));
				subexprs2->push_back(unique_ptr<SpecNode>(new IntConst(0)));
	
				auto stmt = autov::_When(autov::_Tuple(children), 
				new Expr(Layer->ops["load"], unique_ptr<vector<unique_ptr<SpecNode>>>(subexprs)), 
				autov::_Let(f->assign, new Expr(Layer->ops["<>?"], unique_ptr<vector<unique_ptr<SpecNode>>>(subexprs2)), remain_spec));

				for(auto &p : *relies) {
					stmt = new Rely(std::move(p) , unique_ptr<SpecNode>(stmt));
				}
				return stmt;
			} else {
				LOG_DEBUG << "ILoad can only be assigned to int, ptr, or bool";
				assert(false);
			}
		} else if(auto f = dynamic_cast<IRLoader::IStore*>(inst.get())) {
			//TODO
		} else if(auto f = dynamic_cast<IRLoader::IAlloc*>(inst.get())) {
			if(auto typ = dynamic_cast<IRLoader::TPtr*>(f->typ.get())) {
				auto children = new vector<unique_ptr<SpecNode>>();
				children->push_back(unique_ptr<SpecNode>(autov::_name(f->assign, types.get())));
				children->push_back(unique_ptr<SpecNode>(autov::_st(abs_data)));

				auto subexprs = new vector<unique_ptr<SpecNode>>();
				subexprs->push_back(unique_ptr<SpecNode>(new StringConst(fname)));
				subexprs->push_back(unique_ptr<SpecNode>(new IntConst(load_store_typ(typ->subtype.get()))));
				subexprs->push_back(unique_ptr<SpecNode>(ir_value_to_spec(Layer, f->align, relies)));
				subexprs->push_back(unique_ptr<SpecNode>(autov::_st(abs_data)));
				auto stmt = autov::_When(autov::_Tuple(children),
				 new Expr(Layer->ops["alloc"], unique_ptr<vector<unique_ptr<SpecNode>>>(subexprs)), remain_spec);
				for(auto &p : *relies) {
					stmt = new Rely(std::move(p) , unique_ptr<SpecNode>(stmt));
				}
				return stmt;
			} else {
				LOG_DEBUG << "Not a pointer for alloc instruction\n";
				assert(false);
			}
		} else if(auto f = dynamic_cast<IRLoader::IIf*>(inst.get())) {
			auto cond = ir_value_to_spec(Layer, f->cond.get(), relies);
			auto then_body = ir_insts_to_spec(proj, Layer, fname, f->true_body.get(), defs, f->output.get(), in_loop, false, suffix, 0);
			auto else_body = ir_insts_to_spec(proj, Layer, fname, f->false_body.get(), defs, f->output.get(), in_loop, false, suffix, 0);

			SpecNode* val = new autov::If(unique_ptr<SpecNode>(cond), unique_ptr<SpecNode>(then_body), unique_ptr<SpecNode>(else_body));
			for(auto o : *f->need_init) {
				val = autov::_Let(o, default_val((*types)[o]), val);
			}
			SpecNode* remain;
			if(in_loop) {
				if(f->output->find("__continue__") != f->output->end()) {
					remain = new autov::If(unique_ptr<SpecNode>(_name("__continue__", types.get())), 
					unique_ptr<SpecNode>(returns), unique_ptr<SpecNode>(remain_spec));
				}

				if(f->output->find("__break__") != f->output->end()) {
					remain = new autov::If(unique_ptr<SpecNode>(_name("__break__", types.get())), 
					unique_ptr<SpecNode>(returns), unique_ptr<SpecNode>(remain_spec));
				}
			}

			if(f->output->find("__return__") != f->output->end()) {
					remain = new autov::If(unique_ptr<SpecNode>(_name("__return__", types.get())), 
					unique_ptr<SpecNode>(returns), unique_ptr<SpecNode>(remain_spec));
			}

			SpecNode* out;
			if(f->output->size() > 0) {
				auto vec = new vector<unique_ptr<SpecNode>>();
				for(auto o : *f->output) {
					vec->push_back(unique_ptr<SpecNode>(new Symbol(o)));
				}
				vec->push_back(unique_ptr<SpecNode>(autov::_st(abs_data)));
				out = autov::_Tuple(vec);
			} else {
				out = autov::_st(abs_data);
			}

			auto stmt = autov::_When(out, val, remain_spec);
			for(auto &p : *relies) {
					stmt = new Rely(std::move(p) , unique_ptr<SpecNode>(stmt));
			}
			return stmt;
		}  else if(auto f = dynamic_cast<IRLoader::ILoop*>(inst.get())) {

		}  else if(auto f = dynamic_cast<IRLoader::IInsertValue*>(inst.get())) {

		} else {
			LOG_DEBUG << "Instruction not supported converting to SpecNode\n";
			LOG_DEBUG << inst->to_coq();
			assert(false);
		}

		return nullptr;
	}

	vector<unique_ptr<autov::Definition>>* ir_to_spec(Project *proj, string fname, Layer *layer, string suffix = "") {
		auto abs_data = layer->abs_data;
		//TODO: need to implement finalize_project
		auto module = proj->code;
		auto func = (*module->functions)[fname];
		auto spec_name = func->fname + "_spec" + suffix;

		auto args = new vector<shared_ptr<Arg>>();
		for (auto &arg : *(func->args)) {
			args->push_back(shared_ptr<Arg>(new Arg(arg->name, ir_type_to_spec(arg->type.get()))));
		}

		args->push_back(shared_ptr<Arg>(new Arg("st", abs_data)));

		SpecType* rettype;
		auto *retval = new std::unordered_set<string>();
		auto *def = new vector<unique_ptr<SpecNode>>();
		if(dynamic_cast<TVoid*>(func->rettype.get())) {
			rettype = new Option(abs_data);
		} else {
			shared_ptr<SpecType> ret = ir_type_to_spec(func->rettype.get());
			vector<shared_ptr<SpecType>> *vec = new vector<shared_ptr<SpecType>>();
			vec->push_back(ret);
			vec->push_back(abs_data);
			rettype = new Option(shared_ptr<SpecType>(new Tuple(std::move(unique_ptr<vector<shared_ptr<SpecType>>>(vec)))));
			retval->insert("__retval__");
		}

		vector<shared_ptr<Inst>> *insts = new vector<shared_ptr<Inst>>();
		Inst *inst = new Inst();
		inst->emplace<autov::IRLoader::Function>(*func);
		insts->push_back(shared_ptr<Inst>(inst));

		for(auto &b : *(func->body)) {
			Inst *i = new Inst();
			i->emplace<IRInst>(*b);
			insts->push_back(shared_ptr<Inst>(i));
		}

		vector<shared_ptr<Inst>> before;
		vector<shared_ptr<Inst>> after;

		analyze_input_output(insts, &before, &after, false);

	
	  vector<unique_ptr<autov::Definition>>* defs = new vector<unique_ptr<autov::Definition>>();
		SpecNode* body = ir_insts_to_spec(proj, layer, func->fname, func->body.get(), defs, retval, false, true, suffix, 0);

		if(proj->cmds.InitRely.find(fname) != proj->cmds.InitRely.end()) {
			for(auto & f : *(proj->cmds.InitRely[fname])) {
				body = new autov::Rely(std::move(f->deep_copy()), std::move(unique_ptr<SpecNode>(body)));
			}
		}

		if(func->alloca_vars.size() > 0) {
			body = autov::_Let("init_st", autov::_st(abs_data), body);
			vector<unique_ptr<SpecNode>> *nodes = new vector<unique_ptr<SpecNode>>();
			nodes->push_back(unique_ptr<SpecNode>(new StringConst(fname)));
			nodes->push_back(unique_ptr<SpecNode>(_st(abs_data)));

			SpecNode* expr = new Expr(layer->ops["new_frame"], unique_ptr<vector<unique_ptr<SpecNode>>>(nodes));
			body = autov::_When(autov::_st(abs_data), expr, body);
		}

		defs->push_back(std::move(unique_ptr<autov::Definition>(new autov::Definition(spec_name, shared_ptr<SpecType>(rettype), std::move(unique_ptr<vector<shared_ptr<Arg>>>(args)), 
		std::move(unique_ptr<SpecNode>(body))))));

		return defs;
	}

	// get the size of a IR Type, otherwise return -1
	long load_store_typ(IRType *typ)
	{
		if (TInt *i = dynamic_cast<TInt *>(typ))
		{
			return i->szof();
		}
		else if (dynamic_cast<TPtr *>(typ))
		{
			return 8;
		}
		else if (dynamic_cast<TBool *>(typ))
		{
			return 1;
		}
		else if (TNamedStruct *ns = dynamic_cast<TNamedStruct *>(typ))
		{
			return (*(ns->structs))[ns->name]->szof();
		}
		else if (TStruct *ts = dynamic_cast<TStruct *>(typ))
		{
			return ts->szof();
		}
		else if (TArray *arr = dynamic_cast<TArray *>(typ))
		{
			return arr->subtype->szof();
		}
		else
		{
			return -1;
		}
	}

	// modify the sets inputs and outputs directly
	void get_input_output(IRValue *irval, std::unordered_set<string> &inputs, std::unordered_set<string> &outputs)
	{
		if (auto f = dynamic_cast<IRLoader::VLocal *>(irval))
		{
			if (dynamic_cast<TVoid *>(f->type.get()))
			{
				outputs.insert(f->name);
			}
			else
			{
				if (outputs.find(f->name) == outputs.end())
				{
					inputs.insert(f->name);
				}
			}
		}
		else if (auto f = dynamic_cast<IRLoader::VExpr *>(irval))
		{
			for (auto it = f->operands->begin(); it != f->operands->end(); ++it)
			{
				get_input_output(it->get(), inputs, outputs);
			}
		}
	}

	void get_input_output(vector<unique_ptr<IRValue>> *vec, std::unordered_set<string> &inputs, std::unordered_set<string> &outputs)
	{
		for (auto it = vec->begin(); it != vec->end(); ++it)
		{
			get_input_output(it->get(), inputs, outputs);
		}
	}

	void get_input_output(CFunction *cf, std::unordered_set<string> &inputs, std::unordered_set<string> &outputs)
	{
		for (auto arg = cf->args->begin(); arg != cf->args->end(); ++arg)
		{
			outputs.insert(arg->get()->name);
		}
	}

	void get_input_output(IRInst *it, std::unordered_set<string> &inputs, std::unordered_set<string> &outputs);

	void get_input_output(vector<unique_ptr<IRInst>> *vec, std::unordered_set<string> &inputs, std::unordered_set<string> &outputs)
	{
		for (auto it = vec->begin(); it != vec->end(); ++it)
		{
			get_input_output(it->get(), inputs, outputs);
		}
	}

	void get_input_output(IRInst *it, std::unordered_set<string> &inputs, std::unordered_set<string> &outputs)
	{
		if (auto f = dynamic_cast<IAssign *>(it))
		{
			get_input_output(f->val.get(), inputs, outputs);
			outputs.insert(f->assign);
		}
		else if (auto f = dynamic_cast<IReturn *>(it))
		{
			if (f->val != nullptr)
			{
				get_input_output(f->val.get(), inputs, outputs);
				outputs.insert("__retval__");
			}
		}
		else if (auto f = dynamic_cast<IBreak *>(it))
		{
			outputs.insert("__break__");
		}
		else if (auto f = dynamic_cast<IRLoader::IContinue *>(it))
		{
			outputs.insert("__continue__");
		}
		else if (auto f = dynamic_cast<IRLoader::IUnaryOp *>(it))
		{
			get_input_output(f->a.get(), inputs, outputs);
			outputs.insert(f->assign);
		}
		else if (auto f = dynamic_cast<IRLoader::IBinOp *>(it))
		{
			get_input_output(f->a.get(), inputs, outputs);
			get_input_output(f->b.get(), inputs, outputs);
			outputs.insert(f->assign);
		}
		else if (auto f = dynamic_cast<IRLoader::ISelect *>(it))
		{
			get_input_output(f->cond.get(), inputs, outputs);
			get_input_output(f->true_val.get(), inputs, outputs);
			get_input_output(f->false_val.get(), inputs, outputs);
			outputs.insert(f->assign);
		}
		else if (auto f = dynamic_cast<IRLoader::ICall *>(it))
		{
			for (auto it = f->args->begin(); it != f->args->end(); it++)
			{
				get_input_output(it->get(), inputs, outputs);
			}
			outputs.insert(f->assign);
		}
		else if (auto f = dynamic_cast<IRLoader::IIf *>(it))
		{
			get_input_output(f->cond.get(), inputs, outputs);
			get_input_output(f->true_body.get(), inputs, outputs);
			get_input_output(f->false_body.get(), inputs, outputs);
		}
		else if (auto f = dynamic_cast<IRLoader::ILoop *>(it))
		{
			get_input_output(f->body.get(), inputs, outputs);
		}
		else if (auto f = dynamic_cast<IRLoader::IGetElemPtr *>(it))
		{
			get_input_output(f->val.get(), inputs, outputs);
			get_input_output(f->index.get(), inputs, outputs);
			outputs.insert(f->assign);
		}
		else if (auto f = dynamic_cast<IRLoader::IExtractValue *>(it))
		{
			get_input_output(f->val.get(), inputs, outputs);
			outputs.insert(f->assign);
		}
		else if (auto f = dynamic_cast<IRLoader::ILoad *>(it))
		{
			get_input_output(f->ptr.get(), inputs, outputs);
			outputs.insert(f->assign);
		}
		else if (auto f = dynamic_cast<IRLoader::IStore *>(it))
		{
			get_input_output(f->ptr.get(), inputs, outputs);
			get_input_output(f->val.get(), inputs, outputs);
		}
		else if (auto f = dynamic_cast<IRLoader::IAlloc *>(it))
		{
			outputs.insert(f->assign);
		}
		else if (auto f = dynamic_cast<IRLoader::IInsertValue *>(it))
		{
			outputs.insert(f->assign);
		}
		else
		{
			LOG_DEBUG << "get_input_output not supported for this instruction";
			LOG_DEBUG << "current instruction:\n" + it->to_coq();
			assert(false);
		}
	}

	void get_input_output(vector<unique_ptr<IRInst>> *vec, shared_ptr<std::unordered_set<string>> *inputs_arr, shared_ptr<std::unordered_set<string>> *outputs_arr)
	{
		int i;
		for (auto it = vec->begin(); it != vec->end(); ++it, ++i)
		{
			get_input_output(it->get(), *(inputs_arr[i]), *(outputs_arr[i]));
		}

		// get a prefix sum of sets so that we can extract any inputs/outputs from insts[0..i]
		for (auto i = 1; i < sizeof(inputs_arr); ++i)
		{
			inputs_arr[i]->insert(inputs_arr[i - 1]->cbegin(), inputs_arr[i - 1]->cend());
		}
	}

	void get_input_output(Inst *vec, std::unordered_set<string> &inputs, std::unordered_set<string> &outputs)
	{
		if (std::holds_alternative<IRLoader::Function>(*vec))
		{
			auto &f = std::get<IRLoader::Function>(*vec);
			auto cf = dynamic_cast<CFunction*>(&f);
			get_input_output(cf, inputs, outputs);
		}
		else if (std::holds_alternative<IRValue>(*vec))
		{
			auto &f = std::get<IRValue>(*vec);
			get_input_output(&f, inputs, outputs);
		}
		else if (std::holds_alternative<IRInst>(*vec))
		{
			auto &f = std::get<IRInst>(*vec);
			get_input_output(&f, inputs, outputs);
		}
	}

	void get_input_output(vector<shared_ptr<Inst>> *vec, shared_ptr<std::unordered_set<string>> *inputs_arr, shared_ptr<std::unordered_set<string>> *outputs_arr)
	{
		int i;
		for (auto it = vec->begin(); it != vec->end(); ++it, ++i)
		{
			get_input_output(it->get(), *(inputs_arr[i]), *(outputs_arr[i]));
		}
	}

	void get_input_output(vector<shared_ptr<Inst>> *vec, std::unordered_set<string> &inputs, std::unordered_set<string> &outputs)
	{
		for (auto it = vec->begin(); it != vec->end(); ++it)
		{
			get_input_output(it->get(), inputs, outputs);
		}
	}

	void analyze_input_output(vector<unique_ptr<IRInst>> *insts, vector<shared_ptr<Inst>> *before, vector<shared_ptr<Inst>> *after, bool in_loop)
	{
		auto input_arr = new shared_ptr<std::unordered_set<string>>[insts->size()];
		auto output_arr = new shared_ptr<std::unordered_set<string>>[insts->size()];

		get_input_output(insts, input_arr, output_arr);

		int i = 0;
		for (auto it = insts->begin(); it != insts->end(); ++it, ++i)
		{
			auto input = *(input_arr[i]);	// input from insts[0..i]
			auto output = *(output_arr[i]); // output from insts[0..i]

			std::unordered_set<string> input_i;
			std::unordered_set<string> output_i;
			std::unordered_set<string> before_output;
			std::unordered_set<string> before_input;
			std::unordered_set<string> after_output;
			std::unordered_set<string> after_input;

			std::unordered_set<string> before_before_input;
			std::unordered_set<string> before_before_output;
			std::unordered_set<string> after_after_input;
			std::unordered_set<string> after_after_output;

			if (before->size() > 0)
			{
				get_input_output(before, before_before_input, before_before_output);
			}

			if (after->size() > 0)
			{
				get_input_output(after, after_after_input, after_after_output);
			}

			if (i >= 1)
			{
				boost::set_union(*(output_arr[i - 1]), before_before_output, std::inserter(before_output, before_output.begin()));
				boost::set_union(*(input_arr[i - 1]), before_before_input, std::inserter(before_input, before_input.begin()));
				boost::set_difference(input, *(input_arr[i - 1]), std::inserter(input_i, input_i.begin()));
				boost::set_difference(output, *(output_arr[i - 1]), std::inserter(output_i, output_i.begin()));
			}
			else
			{
				input_i = input;
				output_i = output;
				before_input = before_before_input;
				before_output = before_before_output;
			}
			auto &inst = *it;
			auto *input_inst = new std::unordered_set<string>();
			boost::set_intersection(before_output, input_i, std::inserter(*input_inst, input_inst->begin()));
			inst->input = shared_ptr<std::unordered_set<string>>(input_inst);

			if (in_loop)
			{
				if (output_i.find("__break__") == output_i.end() && output_i.find("__continue__") == output_i.end())
				{
					boost::set_difference(*(input_arr[insts->size() - 1]), *(input_arr[i]), std::inserter(after_input, after_input.begin()));
					boost::set_difference(*(output_arr[insts->size() - 1]), *(output_arr[i]), std::inserter(after_output, after_output.begin()));
					after_input.insert(after_after_input.begin(), after_after_input.end());
					after_output.insert(after_after_output.begin(), after_after_output.end());
					auto *output_inst = new std::unordered_set<string>();
					boost::set_intersection(output_i, after_input, std::inserter(*output_inst, output_inst->begin()));
					inst->output = shared_ptr<std::unordered_set<string>>(output_inst);
				}
				else
				{
					inst->output = shared_ptr<std::unordered_set<string>>(new std::unordered_set<string>(output_i));
					if (output_i.find("__break__") != output_i.end())
					{
						inst->output->insert("__break__");
					}

					if (output_i.find("__continue__") != output_i.end())
					{
						inst->output->insert("__continue__");
					}
				}
			}
			else
			{
				boost::set_difference(*(input_arr[insts->size() - 1]), *(input_arr[i]), std::inserter(after_input, after_input.begin()));
				boost::set_difference(*(output_arr[insts->size() - 1]), *(output_arr[i]), std::inserter(after_output, after_output.begin()));
				after_input.insert(after_after_input.begin(), after_after_input.end());
				after_output.insert(after_after_output.begin(), after_after_output.end());
				auto *output_inst = new std::unordered_set<string>();
				boost::set_intersection(output_i, after_input, std::inserter(*output_inst, output_inst->begin()));
				inst->output = shared_ptr<std::unordered_set<string>>(output_inst);
			}

			if (output_i.find("__return__") != output_i.end())
			{
				inst->output->insert("__return__");
			}

			if (output_i.find("__retval__") != output_i.end())
			{
				inst->output->insert("__retval__");
			}

			// If case and ILoop case
			if (auto f = dynamic_cast<IRLoader::IIf *>(inst.get()))
			{
				// Recompute each branch inputs/outputs
				auto vec_before = shared_ptr<vector<shared_ptr<Inst>>>(new vector<shared_ptr<Inst>>());
				vec_before->insert(vec_before->end(), before->begin(), before->end());
				for (auto it = insts->begin(); it != insts->end(); it++)
				{
					auto shared = shared_ptr<Inst>(new Inst(*(it->get())));
					vec_before->push_back(shared);
				}

				auto vec_after = shared_ptr<vector<shared_ptr<Inst>>>(new vector<shared_ptr<Inst>>());
				for (auto it = insts->begin(); it != insts->end(); it++)
				{
					vec_after->push_back(shared_ptr<Inst>(new Inst(*(it->get()))));
				}
				vec_after->insert(vec_after->end(), after->begin(), after->end());

				analyze_input_output(f->true_body.get(), vec_before.get(), vec_after.get(), in_loop);
				analyze_input_output(f->false_body.get(), vec_before.get(), vec_after.get(), in_loop);
				std::unordered_set<string> *need_init = new std::unordered_set<string>();
				boost::set_difference(*(inst->output), before_output, std::inserter(*need_init, need_init->begin()));
				f->need_init = std::move(unique_ptr<std::unordered_set<string>>(need_init));
			}
			else if (auto f = dynamic_cast<IRLoader::ILoop *>(inst.get()))
			{
				// compute loop inputs and outputs
				auto vec_before = shared_ptr<vector<shared_ptr<Inst>>>(new vector<shared_ptr<Inst>>());
				vec_before->insert(vec_before->end(), before->begin(), before->end());
				for (auto it = insts->begin(); it != insts->end(); it++)
				{
					auto shared = shared_ptr<Inst>(new Inst(*(it->get())));
					vec_before->push_back(shared);
				}

				auto vec_after = shared_ptr<vector<shared_ptr<Inst>>>(new vector<shared_ptr<Inst>>());
				for (auto it = insts->begin(); it != insts->end(); it++)
				{
					vec_after->push_back(shared_ptr<Inst>(new Inst(*(it->get()))));
				}
				vec_after->insert(vec_before->end(), after->begin(), after->end());
				analyze_input_output(f->body.get(), vec_before.get(), vec_after.get(), true);
				std::unordered_set<string> in;
				std::unordered_set<string> out;
				get_input_output(f->body.get(), in, out);

				std::unordered_set<string> loop_output;
				boost::set_intersection(out, after_input, std::inserter(loop_output, loop_output.begin()));

				std::unordered_set<string> *loop_args = new std::unordered_set<string>();
				boost::set_intersection(out, after_input, std::inserter(*loop_args, loop_args->begin()));
				f->loop_args = std::move(unique_ptr<std::unordered_set<string>>(loop_args));

				if (output_i.find("__return__") != output_i.end())
				{
					f->loop_args->insert("__return__");
				}

				if (output_i.find("__break__") != output_i.end())
				{
					f->loop_args->insert("__break__");
				}

				if (output_i.find("__retval__") != output_i.end())
				{
					f->loop_args->insert("__retval__");
				}
			}
		}
	}
  

	template <template<typename...> class PtrType>
	void analyze_input_output(vector<PtrType<Inst>> *insts, vector<shared_ptr<Inst>> *before, vector<shared_ptr<Inst>> *after, bool in_loop)
	{
		auto input_arr = new shared_ptr<std::unordered_set<string>>[insts->size()];
		auto output_arr = new shared_ptr<std::unordered_set<string>>[insts->size()];

		get_input_output(insts, input_arr, output_arr);

		int i = 0;
		for (auto it = insts->begin(); it != insts->end(); ++it, ++i)
		{
			if (std::holds_alternative<IRLoader::Function>(*(*it)))
			{
				continue;
			}
			if (std::holds_alternative<IRInst>(*(*it)))
			{
				auto input = *(input_arr[i]);	// input from insts[0..i]
				auto output = *(output_arr[i]); // output from insts[0..i]

				std::unordered_set<string> input_i;
				std::unordered_set<string> output_i;
				std::unordered_set<string> before_output;
				std::unordered_set<string> before_input;
				std::unordered_set<string> after_output;
				std::unordered_set<string> after_input;

				std::unordered_set<string> before_before_input;
				std::unordered_set<string> before_before_output;
				std::unordered_set<string> after_after_input;
				std::unordered_set<string> after_after_output;

				if (before->size() > 0)
				{
					get_input_output(before, before_before_input, before_before_output);
				}

				if (after->size() > 0)
				{
					get_input_output(after, after_after_input, after_after_output);
				}

				if (i >= 1)
				{
					boost::set_union(*(output_arr[i - 1]), before_before_output, std::inserter(before_output, before_output.begin()));
					boost::set_union(*(input_arr[i - 1]), before_before_input, std::inserter(before_input, before_input.begin()));
					boost::set_difference(input, *(input_arr[i - 1]), std::inserter(input_i, input_i.begin()));
					boost::set_difference(output, *(output_arr[i - 1]), std::inserter(output_i, output_i.begin()));
				}
				else
				{
					input_i = input;
					output_i = output;
					before_input = before_before_input;
					before_output = before_before_output;
				}
				auto &inst = std::get<IRInst>(*(*it));
				auto *input_inst = new std::unordered_set<string>();
				boost::set_intersection(before_output, input_i, std::inserter(*input_inst, input_inst->begin()));
				inst.input = shared_ptr<std::unordered_set<string>>(input_inst);

				if (in_loop)
				{
					if (output_i.find("__break__") == output_i.end() && output_i.find("__continue__") == output_i.end())
					{
						boost::set_difference(*(input_arr[insts->size() - 1]), *(input_arr[i]), std::inserter(after_input, after_input.begin()));
						boost::set_difference(*(output_arr[insts->size() - 1]), *(output_arr[i]), std::inserter(after_output, after_output.begin()));
						after_input.insert(after_after_input.begin(), after_after_input.end());
						after_output.insert(after_after_output.begin(), after_after_output.end());
						auto *output_inst = new std::unordered_set<string>();
						boost::set_intersection(output_i, after_input, std::inserter(*output_inst, output_inst->begin()));
						inst.output = shared_ptr<std::unordered_set<string>>(output_inst);
					}
					else
					{
						inst.output = shared_ptr<std::unordered_set<string>>(new std::unordered_set<string>(output_i));
						if (output_i.find("__break__") != output_i.end())
						{
							inst.output->insert("__break__");
						}

						if (output_i.find("__continue__") != output_i.end())
						{
							inst.output->insert("__continue__");
						}
					}
				}
				else
				{
					boost::set_difference(*(input_arr[insts->size() - 1]), *(input_arr[i]), std::inserter(after_input, after_input.begin()));
					boost::set_difference(*(output_arr[insts->size() - 1]), *(output_arr[i]), std::inserter(after_output, after_output.begin()));
					after_input.insert(after_after_input.begin(), after_after_input.end());
					after_output.insert(after_after_output.begin(), after_after_output.end());
					auto *output_inst = new std::unordered_set<string>();
					boost::set_intersection(output_i, after_input, std::inserter(*output_inst, output_inst->begin()));
					inst.output = shared_ptr<std::unordered_set<string>>(output_inst);
				}

				if (output_i.find("__return__") != output_i.end())
				{
					inst.output->insert("__return__");
				}

				if (output_i.find("__retval__") != output_i.end())
				{
					inst.output->insert("__retval__");
				}

				// If case and ILoop case
				if (auto f = dynamic_cast<IRLoader::IIf *>(&inst))
				{
					// Recompute each branch inputs/outputs
					auto vec_before = shared_ptr<vector<shared_ptr<Inst>>>(new vector<shared_ptr<Inst>>());
					vec_before->insert(vec_before->end(), before->begin(), before->end());
					vec_before->insert(vec_before->end(), insts->begin(), insts->end());

					auto vec_after = shared_ptr<vector<shared_ptr<Inst>>>(new vector<shared_ptr<Inst>>());
					vec_after->insert(vec_after->end(), insts->begin(), insts->end());
					vec_after->insert(vec_after->end(), after->begin(), after->end());
					analyze_input_output(f->true_body.get(), vec_before.get(), vec_after.get(), in_loop);
					analyze_input_output(f->false_body.get(), vec_before.get(), vec_after.get(), in_loop);

					std::unordered_set<string> *need_init = new std::unordered_set<string>();
					boost::set_difference(*(inst.output), before_output, std::inserter(*need_init, need_init->begin()));
					f->need_init = std::move(unique_ptr<std::unordered_set<string>>(need_init));
				}
				else if (auto f = dynamic_cast<IRLoader::ILoop *>(&inst))
				{
					// compute loop inputs and outputs
					auto vec_before = shared_ptr<vector<shared_ptr<Inst>>>(new vector<shared_ptr<Inst>>());
					vec_before->insert(vec_before->end(), before->begin(), before->end());
					vec_before->insert(vec_before->end(), insts->begin(), insts->end());

					auto vec_after = shared_ptr<vector<shared_ptr<Inst>>>(new vector<shared_ptr<Inst>>());
					vec_after->insert(vec_after->end(), insts->begin(), insts->end());
					vec_after->insert(vec_before->end(), after->begin(), after->end());
					analyze_input_output(f->body.get(), vec_before.get(), vec_after.get(), true);
					std::unordered_set<string> in;
					std::unordered_set<string> out;
					get_input_output(f->body.get(), in, out);

					std::unordered_set<string> loop_output;
					boost::set_intersection(out, after_input, std::inserter(loop_output, loop_output.begin()));

					std::unordered_set<string> *loop_args = new std::unordered_set<string>();
					boost::set_intersection(out, after_input, std::inserter(*loop_args, loop_args->begin()));
					f->loop_args = std::move(unique_ptr<std::unordered_set<string>>(loop_args));

					if (output_i.find("__return__") != output_i.end())
					{
						f->loop_args->insert("__return__");
					}

					if (output_i.find("__break__") != output_i.end())
					{
						f->loop_args->insert("__break__");
					}

					if (output_i.find("__retval__") != output_i.end())
					{
						f->loop_args->insert("__retval__");
					}
				}
			}
		}
	}


	template <typename T, template<typename...> class PtrType>
	void analyze_types(vector<PtrType<T>> *insts, unordered_map<string, shared_ptr<SpecType>> *types) {
		for(auto inst : *insts) {
			analyze_types(inst.get(), types);	
		}
	}


	template <typename T>
	void analyze_types(T *inst, unordered_map<string, shared_ptr<SpecType>> *types) {
			if(auto f = dynamic_cast<IAssign*>(inst)) {
				analyze_types(f->val.get(), types);
				(*types)[f->assign] = ir_type_to_spec(f->typ.get());
			} else if(auto f = dynamic_cast<IReturn*>(inst)) {
				//TODO
			}
	}
}