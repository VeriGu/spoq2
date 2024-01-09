#include <coq.h>
#include <irtypes.h>
#include <utils.h>
#include <irvalues.h>

namespace autov::IRLoader {
using std::string;
using std::vector;
using std::unique_ptr;
using std::make_unique;
using std::shared_ptr;
using std::make_shared;
using std::tuple;

static string join_type_by_semi_colon(const vector<shared_ptr<IRType>> *elems) {
    string ret = "";
    bool last = false;

    if (!elems || elems->size() == 0) {
        return " ";
    }

    for (const auto &elem: *elems) {
        ret += elem->to_coq() + (last ? "" : "; ");
    }

    return ret;
}

static string join_type_by_semi_colon(const vector<shared_ptr<TStructElem>> *elems) {
    string ret = "";
    bool last = false;

    if (!elems || elems->size() == 0) {
        return " ";
    }

    for (const auto &elem: *elems) {
        ret += elem->to_coq() + (last ? "" : "; ");
    }

    return ret;
}

string to_coq_typ_list(const vector<shared_ptr<IRType>> *lst) {
    string ret = join_type_by_semi_colon(lst);
    return "[[" + ret + "]]";
}

string to_coq_typ_list(const vector<shared_ptr<TStructElem>> *lst) {
    string ret = join_type_by_semi_colon(lst);
    return "[[" + ret + "]]";
}

} // namespace autov::IRLoader