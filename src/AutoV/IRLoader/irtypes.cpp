#include <irtypes.h>
#include <coq.h>

namespace autov::IRLoader {

shared_ptr<TBool> TBool::TBOOL = make_shared<TBool>();
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

VLocal::VLocal(shared_ptr<IRType> type, string name) :
    IRValue(type), name(to_coq_name(name)) {}

string VExpr::to_coq(void) const {
        string operands_str = to_coq_value_list(this->operands.get());

        if (op == Op::OGetElementPtr)
            return "(VExpr " + type->to_coq() + " " + op.to_coq(type.get()) + " " + operands_str + ")";
        return "(VExpr " + type->to_coq() + " " + op.to_coq() + " " + operands_str + ")";
}

string VStruct::to_coq(void) const {
    return "(VStruct " + to_coq_value_list(contens.get()) + ")";
}

}; // namespace autov::IRLoader