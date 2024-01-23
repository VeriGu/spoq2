#include <instructions.h>
#include <coq.h>

namespace autov::IRLoader {

IAtomicRMW::IAtomicRMW(shared_ptr<IRType> typ, string assign, Op op, unique_ptr<IRValue> ptr,
                       unique_ptr<IRValue> val, Ordering order, int align) :
    assign(to_coq_name(assign)), typ(typ), op(op), ptr(std::move(ptr)), val(std::move(val)),
    order(order), align(align) {};

IBinOp::IBinOp(shared_ptr<IRType> typ, string assign, Op op, unique_ptr<IRValue> a, unique_ptr<IRValue> b) :
    typ(typ), assign(to_coq_name(assign)), op(op), a(std::move(a)), b(std::move(b)) {};

ICall::ICall(shared_ptr<IRType> typ, string assign, unique_ptr<IRValue> func,
             unique_ptr<vector<unique_ptr<IRValue>>> args, long lineno = 0) :
    typ(typ), assign(to_coq_name(assign)), func(std::move(func)), args(std::move(args)){
        this->lineno = lineno;
    };


string ICall::to_coq() const {
    if(dynamic_cast<TVoid *>(typ.get())) {
        return "(ICall " + typ->to_coq() + " None " + func->to_coq() + " "+ to_coq_value_list(args.get()) + ")";
    } else {
        return "(ICall " + typ->to_coq() + " (Some \"" + assign + "\") " + func->to_coq() + " "+ to_coq_value_list(args.get()) + ")";
    }
}

ICmpXchg::ICmpXchg(shared_ptr<IRType> typ, string assign, unique_ptr<IRValue> ptr, unique_ptr<IRValue> cmp,
                   unique_ptr<IRValue> val, Ordering succ_order, Ordering fail_order, int align) :
    typ(typ), assign(to_coq_name(assign)), ptr(std::move(ptr)), cmp(std::move(cmp)), val(std::move(val)),
    succ_order(succ_order), fail_order(fail_order), align(align) {};

IExtractElem::IExtractElem(shared_ptr<IRType> typ, string assign, unique_ptr<IRValue> val, unique_ptr<IRValue> index) :
    typ(typ), assign(to_coq_name(assign)), val(std::move(val)), index(std::move(index)) {};

IExtractValue::IExtractValue(shared_ptr<IRType> typ, string assign, unique_ptr<IRValue> val, unique_ptr<vector<int>> index) :
    typ(typ), assign(to_coq_name(assign)), val(std::move(val)), index(std::move(index)) {};

string IExtractValue::to_coq() const {
        return "(IExtractElem " + (*typ).to_coq() + " " + assign + " " + val->to_coq() + " " + to_list(index.get()) + ")";
    }

IFreeze::IFreeze(shared_ptr<IRType> typ, string assign, unique_ptr<IRValue> val) :
    typ(typ), assign(to_coq_name(assign)), val(std::move(val)) {};

IGetElemPtr::IGetElemPtr(shared_ptr<IRType> typ, string assign, unique_ptr<IRValue> val, unique_ptr<vector<unique_ptr<IRValue>>> index) :
    typ(typ), assign(to_coq_name(assign)), val(std::move(val)), index(std::move(index)) {};

string IGetElemPtr::to_coq() const {
        return "(IGetElemPtr " + typ->to_coq() + " " + assign + " " + val->type->to_coq() + " " +
                val->to_coq() + " " + to_coq_value_list(index.get()) + ")";
    }

IInsertElem::IInsertElem(shared_ptr<IRType> typ, string assign, unique_ptr<IRValue> target, unique_ptr<IRValue> val, unique_ptr<IRValue> idx) :
    typ(typ), assign(to_coq_name(assign)), target(std::move(target)), val(std::move(val)), idx(std::move(idx)) {};

IInsertValue::IInsertValue(shared_ptr<IRType> typ, string assign, unique_ptr<IRValue> target, unique_ptr<IRValue> val, unique_ptr<vector<int>> idx) :
    typ(typ), assign(to_coq_name(assign)), target(std::move(target)), val(std::move(val)), idx(std::move(idx)) {};

string IInsertValue::to_coq() const {
        return "(IInsertElem " + typ->to_coq() + " " + assign + " " + target->to_coq() + " " + val->to_coq() + " " + to_list(idx.get()) + ")";
}

ILoad::ILoad(shared_ptr<IRType> typ, string assign, unique_ptr<IRValue> ptr, int align) :
    typ(typ), assign(to_coq_name(assign)), ptr(std::move(ptr)), align(align) {};

IUnaryOp::IUnaryOp(shared_ptr<IRType> typ, string assign, Op op, unique_ptr<IRValue> a) :
    typ(typ), assign(to_coq_name(assign)), op(op), a(std::move(a)) {};

ISelect::ISelect(shared_ptr<IRType> typ, string assign, unique_ptr<IRValue> cond, unique_ptr<IRValue> true_val, unique_ptr<IRValue> false_val) :
    typ(typ), assign(to_coq_name(assign)), cond(std::move(cond)), true_val(std::move(true_val)), false_val(std::move(false_val)) {};

IShuffleVec::IShuffleVec(shared_ptr<IRType> typ, string assign, unique_ptr<vector<unique_ptr<IRValue>>> operands):
    typ(typ), assign(to_coq_name(assign)), operands(std::move(operands)) {};

string IShuffleVec::to_coq() const {
    return "(IShuffleVec " + typ->to_coq() + " " + assign + " " + to_coq_value_list(operands.get()) + ")";
}

IAssign::IAssign (shared_ptr<IRType> typ, string assign, unique_ptr<IRValue> val) :
    typ(typ), assign(to_coq_name(assign)), val(std::move(val)) {}

string IIf::to_coq() const {
    string true_block = to_coq_code_block(true_body.get());
    string false_block = to_coq_code_block(false_body.get());

    return "(IIf " + cond->to_coq() + "\n" + add_indent(true_block, 5) + "\n" +
            add_indent(false_block, 5) +  ")";
}

string ILoop::to_coq() const {
    string block = to_coq_code_block(body.get());

    return "(ILoop\n" + add_indent(block, 7) + ")";
}

};