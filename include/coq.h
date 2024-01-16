#pragma once
#include <string>
#include <vector>
#include <tuple>
#include <memory>
#include <instructions.h>

namespace autov::IRLoader {
using std::string;
using std::vector;
using std::unique_ptr;
using std::make_unique;
using std::shared_ptr;
using std::make_shared;
using std::tuple;

class IRType;
class TStructElem;

string to_coq_typ_list(vector<shared_ptr<IRType>> *lst);
string to_coq_typ_list(vector<shared_ptr<TStructElem>> *lst);
string to_coq_name(string name);
string to_coq_value_list(vector<shared_ptr<IRValue>> *lst);
string to_list(vector<shared_ptr<string>> *lst);
string add_indent(string text, int indent);
string to_coq_code_block(vector<shared_ptr<IRInst>> *lst);
};