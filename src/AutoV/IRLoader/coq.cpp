#include <coq.h>
#include <irtypes.h>
#include <utils.h>
#include <irvalues.h>
#include <algorithm>
#include <string>

namespace autov::IRLoader {
using std::string;
using std::vector;
using std::unique_ptr;
using std::make_unique;
using std::shared_ptr;
using std::make_shared;
using std::tuple;
using std::replace;

template <typename T>
static string join_type_by_semi_colon(const vector<shared_ptr<T>> *elems) {
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

string to_coq_value_list(const vector<shared_ptr<IRValue>> *lst) {
    string ret = join_type_by_semi_colon(lst);
    return "[" + ret + "]";
}

string to_coq_typ_list(const vector<shared_ptr<IRType>> *lst) {
    string ret = join_type_by_semi_colon(lst);
    return "[[" + ret + "]]";
}

string to_coq_typ_list(const vector<shared_ptr<TStructElem>> *lst) {
    string ret = join_type_by_semi_colon(lst);
    return "[[" + ret + "]]";
}

string to_coq_name(string name) {

    replace(name.begin(), name.end(), "@", "_");

    size_t pos;
    while((pos = name.find("%")) != string::npos) {
        name.replace(pos, 1, "v_");
    }

    replace(name.begin(), name.end(), ".", "_");

    replace(name.begin(), name.end(), '-', '_');

    replace(name.begin(), name.end(), ':', '_');
    
    return name;
}

} // namespace autov::IRLoader