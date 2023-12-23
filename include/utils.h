#pragma once

#include <boost/algorithm/string.hpp>
#include <string>
#include <vector>
#include <sstream>
#include <memory>
#include <nodes.h>
#include <log.h>
#include <values.h>


namespace autov {
using std::string;
using std::vector;
using std::unique_ptr;
using std::make_unique;
using std::shared_ptr;
using std::make_shared;
using std::unordered_map;

vector<string> split(const string &s, char delimiter);


string add_indent(const string s, int indent);

//string join_elems_semi_colon(const vector<Arg> &elems);
string join_elems_semi_colon(const vector<shared_ptr<Arg>> &elems);

//string join_elems_space(const vector<Arg> &elems);
string join_elems_space(const vector<shared_ptr<Arg>> &elems);


//string join_elems_space(const vector<std::unique_ptr<SpecNode>> &elems);

//string join_constrs_pipe(const vector<IndConstr> &elems);
string join_constrs_pipe(const vector<shared_ptr<IndConstr>> &elems);

//string join_underline(const vector<SpecType> &elems);
string join_underline(const vector<shared_ptr<SpecType>> &elems);

} // namespace autov

