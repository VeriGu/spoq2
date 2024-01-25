#pragma once
#include <string>
#include <vector>
#include <tuple>
#include <memory>
#include <irtypes.h>
#include <irvalues.h>
#include <instructions.h>
#include <set>

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

    for (typename vector<PtrType<T>>::const_iterator it = elems->begin(); it != elems->end(); it++) {
        last = (std::next(it) == elems->end());
        ret += (*it)->to_coq() + (last ? "" : "; ");
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
string to_list(const std::set<string> &lst);

template<typename T>
string to_coq_code_block(vector<unique_ptr<T>> *lst) {
    string ret = "(";

    if (lst->size() == 0) {
        return "nil";
    }

    for (int i = 0; i < lst->size(); i++) {
        ret += lst->at(i)->to_coq() + "\n :: ";
    }

    return ret + "nil)";
}

};