#pragma once
#include <string>
#include <vector>
#include <tuple>
#include <memory>
#include <irtypes.h>
#include <irvalues.h>
#include <instructions.h>

namespace autov::IRLoader {
using std::string;
using std::vector;
using std::unique_ptr;
using std::make_unique;
using std::shared_ptr;
using std::make_shared;
using std::tuple;

template <typename T, template<typename...> class PtrType>
static string join_type_by_semi_colon(const vector<PtrType<T>> *elems) {
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

template <typename T>
static string to_coq_typ_list(const vector<shared_ptr<T>> *lst) {
    string ret = join_type_by_semi_colon(lst);
    return "[[" + ret + "]]";
}

string to_coq_name(const string name);

static string to_coq_value_list(const vector<unique_ptr<IRValue>> *lst) {
    string ret = join_type_by_semi_colon(lst);
    return "[" + ret + "]";
}

string to_list(vector<int> *lst);
string to_coq_code_block(vector<unique_ptr<IRInst>> *lst);
#if 0
string add_indent(string text, int indent);
#endif
};