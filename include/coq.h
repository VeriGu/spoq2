#pragma once
#include <string>
#include <vector>
#include <tuple>
#include <memory>

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

};