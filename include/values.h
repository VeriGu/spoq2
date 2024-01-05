#pragma once

#include <string>
#include <vector>
#include <map>
#include <unordered_map>
#include <sstream>
#include <memory>

namespace autov {
using std::string;
using std::vector;
using std::unique_ptr;
using std::make_unique;
using std::shared_ptr;
using std::make_shared;
using std::unordered_map;

class SpecType {
public:
    static shared_ptr<SpecType> UNKNOWN_TYPE;

    string name;
    bool record;

    SpecType() = default;
    SpecType(string name) : name(name), record(false) {}
    SpecType(string name, bool record) : name(name), record(record) {}


    bool operator==(const SpecType& other) const {
        return name == other.name;
    }

    bool operator!=(const SpecType& other) const {
        return name != other.name;
    }

    virtual ~SpecType() = default;

    virtual operator string() const {
        return name;
    }
};

class Int : public SpecType {
public:
    static shared_ptr<Int> INT;

    Int() : SpecType("Z") {}
};

class String : public SpecType {
public:
    static shared_ptr<String> STRING;
    String() : SpecType("string") {}
};

class Bool : public SpecType {
public:
    static shared_ptr<Bool> BOOL;

    Bool() : SpecType("bool") {}
};

class Array : public SpecType {
public:
    shared_ptr<SpecType> elem_type;
    Array() = default;
    Array(shared_ptr<SpecType> elem_type) : SpecType("list_" + string(*elem_type)), elem_type(elem_type) {}
    //Array(const Array& other) : SpecType(other.name), elem_type(std::make_unique<SpecType>(*other.elem_type)) {}

    operator string() const {
        return "list_" + string(*elem_type);
    }
};

class Prop : public SpecType {
public:
    static shared_ptr<Prop> PROP;

    Prop() : SpecType("Prop") {}
};

class Type : public SpecType {
public:
    static shared_ptr<Type> TYPE;

    Type() : SpecType("Type") {}
};

class ZMap : public SpecType {
public:
    shared_ptr<SpecType> elem_type;
    ZMap() = default;
    ZMap(shared_ptr<SpecType> elem_type) : SpecType("ZMap_" + string(*elem_type)), elem_type(elem_type) {}

    operator string() const {
        return "(ZMap.t " + string(*elem_type) + ")";
    }
};

class Arg {
public:
    string name;
    shared_ptr<SpecType> type;
    Arg() = default;
    Arg(string name, shared_ptr<SpecType> type) : name(name), type(type) {}

    bool operator==(const Arg& other) const {
        return name == other.name && type == other.type;
    }

    operator string() const {
        return "(" + name + ": " + string(*type) + ")";
    }
};

class Struct : public SpecType {
public:
    static shared_ptr<Struct> Ptr;

    shared_ptr<vector<shared_ptr<Arg>>> elems;
    std::map<string, shared_ptr<SpecType>> elems_map;
    Struct() = default;
    Struct(string name, shared_ptr<vector<shared_ptr<Arg>>> elems) : SpecType(name), elems(elems) {
        for (const auto elem : *elems) { // Fix: Use emplace instead of assignment to insert elements into elems_map
            elems_map.emplace(elem->name, elem->type);
        }
    }

    string define() const;
};

class IndConstr {
public:
    string name;
    shared_ptr<vector<shared_ptr<Arg>>> args;
    IndConstr() = default;
    IndConstr(string name, shared_ptr<vector<shared_ptr<Arg>>> args) : name(name), args(args) {}

    operator string() const;
};

class Inductive : public SpecType {
public:
    static shared_ptr<Inductive> Nat;

    shared_ptr<vector<shared_ptr<IndConstr>>> constrs;
    std::map<string, shared_ptr<vector<shared_ptr<Arg>>>> constr;
    std::map<string, shared_ptr<SpecType>> arg_type;
    Inductive() = default;
    Inductive(string name, shared_ptr<vector<shared_ptr<IndConstr>>> constrs) : SpecType(name), constrs(constrs) {
        for (const auto c : *constrs) {
            constr.emplace(c->name, c->args); // Fix: Use emplace instead of assignment to insert elements into constr
            for (const auto arg : *c->args) {
                arg_type.emplace(arg->name, arg->type); // Fix: Use emplace instead of assignment to insert elements into arg_type
            }
        }
    }

    string define() const;
};

extern Inductive Nat;

class Function : public SpecType {
public:
    shared_ptr<SpecType> rettype;
    shared_ptr<vector<shared_ptr<SpecType>>> args;
    Function(shared_ptr<SpecType> rettype, shared_ptr<vector<shared_ptr<SpecType>>> args);

    operator string() const;
};

class Tuple : public Struct {
public:
    shared_ptr<vector<shared_ptr<SpecType>>> types;
    Tuple(shared_ptr<vector<shared_ptr<SpecType>>> types);

    operator string() const;
};

class List : public Inductive {
public:
    shared_ptr<SpecType> elem_type;
    List(shared_ptr<SpecType> elem_type) :
        Inductive(
            "List_" + string(*elem_type),
            make_shared<vector<shared_ptr<IndConstr>>>(
                std::initializer_list<shared_ptr<IndConstr>>{
                    make_shared<IndConstr>(
                        "cons_"  + string(elem_type->name),
                        make_shared<vector<shared_ptr<Arg>>>(
                            std::initializer_list<shared_ptr<Arg>>{
                                make_shared<Arg>("head_" + string(elem_type->name), elem_type),
                                make_shared<Arg>("tail_" + string(elem_type->name), make_shared<SpecType>(elem_type->name))
                            }
                        )
                    ),
                    make_shared<IndConstr>("nil_" + string(elem_type->name), make_shared<vector<shared_ptr<Arg>>>(vector<shared_ptr<Arg>>()))
                }
            )
        ),
        elem_type(elem_type) {}

    operator string() const {
        return "list " + string(*elem_type);
    }
};

class Option : public Inductive {
public:
    shared_ptr<SpecType> elem_type;
    Option(shared_ptr<SpecType> elem_type) :
        Inductive(
            "Option_" + string(*elem_type),
            make_shared<vector<shared_ptr<IndConstr>>>(
                std::initializer_list<shared_ptr<IndConstr>>{
                    make_shared<IndConstr>(
                        "Some_"  + string(elem_type->name),
                        make_shared<vector<shared_ptr<Arg>>>(
                            std::initializer_list<shared_ptr<Arg>>{
                                make_shared<Arg>("value_" + string(elem_type->name), elem_type)
                            }
                        )
                    ),
                    make_shared<IndConstr>("None_" + string(elem_type->name), make_shared<vector<shared_ptr<Arg>>>(vector<shared_ptr<Arg>>()))
                }
            )
        ),
        elem_type(elem_type) {}

    operator string() const {
        return "(option " + string(*elem_type) + ")";
    }

};

} // namespace autov
