#include <string>
#include <vector>
#include <map>
#include <unordered_map>
#include <utils.h>
#include <values.h>
#include <sstream>
#include <z3++.h>

namespace autov {
using std::string;
using std::vector;
using std::unique_ptr;
using std::make_unique;
using std::shared_ptr;
using std::make_shared;
using std::unordered_map;


z3::context z3ctx;
unordered_map<string, z3::sort> created_z3_types;

// Struct Ptr = Struct(
//     "Ptr",
//     make_shared<vector<shared_ptr<Arg>>>(
//         std::initializer_list<shared_ptr<Arg>>{
//             make_shared<Arg>("pbase", make_shared<Int>()),
//             make_shared<Arg>("poffset", make_shared<Int>())
//         }
//     )
// );

shared_ptr<Struct> Struct::Ptr = make_shared<Struct>(
    "Ptr",
    make_shared<vector<shared_ptr<Arg>>>(
        std::initializer_list<shared_ptr<Arg>>{
            make_shared<Arg>("pbase", make_shared<String>()),
            make_shared<Arg>("poffset", make_shared<Int>())
        }
    )
);

// Inductive Nat = Inductive(
//     "nat",
//     make_shared<vector<shared_ptr<IndConstr>>>(
//         std::initializer_list<shared_ptr<IndConstr>>{
//             make_shared<IndConstr>("O", make_shared<vector<shared_ptr<Arg>>>()),
//             make_shared<IndConstr>("S", make_shared<vector<shared_ptr<Arg>>>(1,
//                 make_shared<Arg>("pred", make_shared<SpecType>(SpecType("nat")))
//             ))
//         }
//     )
// );

shared_ptr<Inductive> Inductive::Nat = make_shared<Inductive>(
    "nat",
    make_shared<vector<shared_ptr<IndConstr>>>(
        std::initializer_list<shared_ptr<IndConstr>>{
            make_shared<IndConstr>("O", make_shared<vector<shared_ptr<Arg>>>()),
            make_shared<IndConstr>("S", make_shared<vector<shared_ptr<Arg>>>(1,
                make_shared<Arg>("pred", make_shared<SpecType>(SpecType("nat")))
            ))
        }
    )
);

//SpecType UNKNOWN_TYPE = SpecType("UNKNOWN_TYPE");
shared_ptr<SpecType> SpecType::UNKNOWN_TYPE = make_shared<SpecType>("UNKNOWN_TYPE");

shared_ptr<Int> Int::INT = make_shared<Int>();
shared_ptr<String> String::STRING = make_shared<String>();
shared_ptr<Bool> Bool::BOOL = make_shared<Bool>();
shared_ptr<Prop> Prop::PROP = make_shared<Prop>();
shared_ptr<Type> Type::TYPE = make_shared<Type>();

// ----------------------------------------------------------------------------
// Struct
// ----------------------------------------------------------------------------
std::string Struct::define() const {
    std::string res = "Record " + name + " :=\n";
    std::string args = "";

    res += "  mk" + name + " {\n";
    res += add_indent(join_elems_semi_colon(*elems), 4) + "\n";
    res += "}.\n";
    return res;
}

// ----------------------------------------------------------------------------
// IndConstr
// ----------------------------------------------------------------------------
IndConstr::operator std::string() const {
    std::string res = name + " ";
    res += join_elems_space(*args);
    return res;
}

// ----------------------------------------------------------------------------
// Inductive
// ----------------------------------------------------------------------------
std::string Inductive::define() const {
    std::string res = "Inductive " + name + ": Type :=\n | ";

    res += join_constrs_pipe(*constrs) + ".\n";
    return res;
}

// ----------------------------------------------------------------------------
// Function
// ----------------------------------------------------------------------------
Function::Function(shared_ptr<SpecType> rettype, shared_ptr<vector<shared_ptr<SpecType>>> args) {
    this->name = "Func_" + join_underline(*args) + "_" + std::string(*rettype);
    this->rettype = rettype;
    this->args = args;
}

Function::operator string() const {
    std::string res = "";

    for (const auto arg : *args) {
        res += string(*arg) + " -> ";
        if (arg != args->back()) {
            res += "(";
        }
    }

    return res + std::string(*rettype) + string(args->size() - 1, ')');
}

// ----------------------------------------------------------------------------
// Tuple
// ----------------------------------------------------------------------------
Tuple::Tuple(shared_ptr<vector<shared_ptr<SpecType>>> types) :
    Struct("Tuple_" + join_underline(*types), make_shared<std::vector<shared_ptr<Arg>>>()),
    types(types) {
    for (int i = 0; i < types->size(); i++) {
        elems->push_back(make_shared<Arg>("elem_" + std::to_string(i), (*types)[i]));
    }
}

Tuple::operator string() const {
    std::string res = "(";

    for (int i = 0; i < types->size(); i++) {
        if (i != 0) {
            res += " * ";
        }
        res += std::string(*(*types)[i]);
    }
    return res + ")";
}

// ----------------------------------------------------------------------------
// List
// ----------------------------------------------------------------------------


} // namespace autov