#include <coq.h>
#include <irtypes.h>
#include <utils.h>
#include <irvalues.h>
#include <instructions.h>
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

string to_coq_name(const string name) {
    string result;
    result.reserve(name.size());

    for (char c : name) {
        if (c == '%') {
            result += "v_";
        } else if (c == '@' || c == '.' || c == '-' || c == ':' || c == '!') {
            result += '_';
        } else {
            result += c;
        }
    }

    return result;
}

string to_list(vector<int> *lst) {
    string ret = "(";

    if (lst->size() == 0) {
        return "nil";
    }

    for (int i = 0; i < lst->size(); i++) {
        ret += std::to_string(lst->at(i)) + " :: ";
    }

    return ret + "nil)";
}

string to_list(const std::set<string> &lst) {
    string ret = "(";

    if (lst.size() == 0) {
        return "nil";
    }

    for (const auto &elem: lst) {
        ret += "\"" + elem + "\"" + " :: ";
    }

    return ret + "nil)";
}

} // namespace autov::IRLoader