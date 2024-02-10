#pragma once

#include <boost/algorithm/string.hpp>
#include <string>
#include <vector>
#include <sstream>
#include <memory>
#include <nodes.h>
#include <log.h>
#include <values.h>

#define is_instance(v, T) (dynamic_cast<T *>(v) != nullptr)
#define instance_of(v, T) (dynamic_cast<T *>(v))

namespace autov {
using std::string;
using std::vector;
using std::unique_ptr;
using std::make_unique;
using std::shared_ptr;
using std::make_shared;
using std::unordered_map;

static vector<string> split(const string &s, char delimiter) {
    vector<string> tokens;
    string token;
    std::istringstream tokenStream(s);

    while (std::getline(tokenStream, token, delimiter)) {
        tokens.push_back(token);
    }

    return tokens;
}

static string add_indent(const string s, int indent) {
    vector<string> ss = split(s, '\n');
    string result = "";

    for (int i = 0; i < ss.size(); i++) {
        result += string(indent, ' ') + ss[i];

        if (i != ss.size() - 1) {
            result += "\n";
        }
    }

    return result;
}

static string strip(const string& str) {
    string s = str;

    s.erase(s.begin(), std::find_if(s.begin(), s.end(), [](unsigned char ch) {
        return !std::isspace(ch);
    }));

    s.erase(std::find_if(s.rbegin(), s.rend(), [](unsigned char ch) {
        return !std::isspace(ch);
    }).base(), s.end());

    return s;
}

static string replace(string str, const string& from, const string& to) {
    size_t start_pos = 0;
    while((start_pos = str.find(from, start_pos)) != string::npos) {
        str.replace(start_pos, from.length(), to);
        start_pos += to.length(); // Handles case where 'to' is a substring of 'from'
    }
    return str;
}

template <template<typename...> class T>
std::string join(T<std::string> initList, const std::string& separator = "\\", bool reverse = false)
{
    std::string s;

    if(!reverse) {
      for(const auto& i : initList)
      {
          if(s.empty())
          {
              s = i;
          }
          else
          {
              s += separator + i;
          }
      }
    } else {
      for(auto i = initList.rbegin(); i != initList.rend(); ++i) 
      {
          if(s.empty())
          {
              s = *i;
          }
          else
          {
              s += separator + *i;
          }
      }
    }

    return s;
}

//string join_elems_semi_colon(const vector<Arg> &elems);
string join_elems_semi_colon(const vector<shared_ptr<Arg>> &elems);

//string join_elems_space(const vector<Arg> &elems);
string join_elems_space(const vector<shared_ptr<Arg>> &elems);
string join_elems_space(const vector<unique_ptr<SpecNode>> &elems, int elem_indent);

string join_elems_space(const vector<unique_ptr<SpecNode>> &elems);
string join_elems_comma(const vector<unique_ptr<SpecNode>> &elems);
string join_elems_comma(const vector<unique_ptr<SpecNode>> &elems, int elem_indent);
string join_elems_comma1(const vector<unique_ptr<SpecNode>> &elems, int elem_indent);

//string join_constrs_pipe(const vector<IndConstr> &elems);
string join_constrs_pipe(const vector<shared_ptr<IndConstr>> &elems);

//string join_underline(const vector<SpecType> &elems);
string join_underline(const vector<shared_ptr<SpecType>> &elems);

} // namespace autov

