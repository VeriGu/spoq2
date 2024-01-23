#include <irtypes.h>
#include <coq.h>

namespace autov::IRLoader {

shared_ptr<TBool> TBool::TBOOL = make_shared<TBool>();
shared_ptr<TInt> TInt::TI8 = make_shared<TInt>(IntType::TI8);
shared_ptr<TInt> TInt::TI16 = make_shared<TInt>(IntType::TI16);
shared_ptr<TInt> TInt::TI32 = make_shared<TInt>(IntType::TI32);
shared_ptr<TInt> TInt::TI64 = make_shared<TInt>(IntType::TI64);
shared_ptr<TInt> TInt::TI128 = make_shared<TInt>(IntType::TI128);
shared_ptr<TVoid> TVoid::TVOID = make_shared<TVoid>();
shared_ptr<TLabel> TLabel::TLABEL = make_shared<TLabel>();

string TFunction::to_coq(void) const {
    string ret = "(TFunction ";

    ret += rettype->to_coq() + " ";
    ret += to_coq_typ_list(arglist.get());

    return ret + ")";
}

string TStruct::to_coq(void) const {
    return "(TStruct " + std::to_string(size) + " " + to_coq_typ_list(elems.get()) + ")";
}

string VExpr::to_coq(void) const {
        string operands_str = to_coq_value_list(this->operands.get());

        if (op == Op::OGetElementPtr)
            return "(VExpr " + type->to_coq() + " " + op.to_coq(type.get()) + " " + operands_str + ")";
        return "(VExpr " + type->to_coq() + " " + op.to_coq(type.get()) + " " + operands_str + ")";
}

string VStruct::to_coq(void) const {
    return "(VStruct " + to_coq_value_list(contents.get()) + ")";
}

}; // namespace autov::IRLoader