#include <irtypes.h>
#include <coq.h>

namespace autov::IRLoader {

string TFunction::to_coq(void) const {
    string ret = "(TFunction ";

    ret += rettype->to_coq() + " ";
    ret += to_coq_typ_list(arglist.get());

    return ret + ")";
}

string TStruct::to_coq(void) const {
    return "(TStruct " + std::to_string(size) + " " + to_coq_typ_list(elems.get()) + ")";
}

}; // namespace autov::IRLoader