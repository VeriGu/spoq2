#pragma once

#include <string>
#include <vector>
#include <map>
#include <unordered_map>
#include <sstream>
#include <memory>
#include <utils.h>
#include <z3/z3++.h>

namespace autov {
using std::string;
using std::vector;
using std::unique_ptr;
using std::make_unique;
using std::shared_ptr;
using std::make_shared;
using std::unordered_map;

extern z3::context z3ctx;
extern unordered_map<string, z3::sort> created_z3_types;

class SpecValue;

class SpecType {
public:
    static shared_ptr<SpecType> UNKNOWN_TYPE;

    string name;
    bool record;

    SpecType() = default;
    SpecType(string name) : name(name), record(false) {}
    SpecType(string name, bool record) : name(name), record(record) {}

    virtual z3::sort get_z3_type();
    virtual shared_ptr<SpecValue> from_z3_value(z3::expr value);
    virtual shared_ptr<SpecValue> declare(string name, int nid);

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

    virtual z3::sort get_z3_type();
    virtual shared_ptr<SpecValue> from_z3_value(z3::expr value);
    virtual shared_ptr<SpecValue> declare(string name, int nid);
};

class String : public SpecType {
public:
    static shared_ptr<String> STRING;
    String() : SpecType("string") {}

    virtual z3::sort get_z3_type();
    virtual shared_ptr<SpecValue> from_z3_value(z3::expr value);
    virtual shared_ptr<SpecValue> declare(string name, int nid);
};

class Bool : public SpecType {
public:
    static shared_ptr<Bool> BOOL;

    Bool() : SpecType("bool") {}

    virtual z3::sort get_z3_type();
    virtual shared_ptr<SpecValue> from_z3_value(z3::expr value);
    virtual shared_ptr<SpecValue> declare(string name, int nid);
};

class Array : public SpecType {
public:
    shared_ptr<SpecType> elem_type;
    Array() = default;
    Array(shared_ptr<SpecType> elem_type) : SpecType("list_" + string(*elem_type)), elem_type(elem_type) {}
    //Array(const Array& other) : SpecType(other.name), elem_type(std::make_unique<SpecType>(*other.elem_type)) {}

    virtual z3::sort get_z3_type();
    virtual shared_ptr<SpecValue> from_z3_value(z3::expr value);
    virtual shared_ptr<SpecValue> declare(string name, int nid);

    operator string() const {
        return "list_" + string(*elem_type);
    }
};

class Prop : public SpecType {
public:
    static shared_ptr<Prop> PROP;

    Prop() : SpecType("Prop") {}

    virtual z3::sort get_z3_type();
    virtual shared_ptr<SpecValue> from_z3_value(z3::expr value);
    virtual shared_ptr<SpecValue> declare(string name, int nid);
};

class Type : public SpecType {
public:
    static shared_ptr<Type> TYPE;

    Type() : SpecType("Type") {}

    virtual z3::sort get_z3_type();
    virtual shared_ptr<SpecValue> from_z3_value(z3::expr value);
    virtual shared_ptr<SpecValue> declare(string name, int nid);
};

class ZMap : public SpecType {
public:
    shared_ptr<SpecType> elem_type;
    ZMap() = default;
    ZMap(shared_ptr<SpecType> elem_type) : SpecType("ZMap_" + string(*elem_type)), elem_type(elem_type) {}

    operator string() const {
        return "(ZMap.t " + string(*elem_type) + ")";
    }

    virtual z3::sort get_z3_type();
    virtual shared_ptr<SpecValue> from_z3_value(z3::expr value);
    virtual shared_ptr<SpecValue> declare(string name, int nid);
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

    bool operator!=(const Arg& other) const {
        return name != other.name || type != other.type;
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

    virtual z3::sort get_z3_type();
    virtual shared_ptr<SpecValue> from_z3_value(z3::expr value);
    virtual shared_ptr<SpecValue> declare(string name, int nid);
};

class IndConstr {
public:
    string name;
    shared_ptr<vector<shared_ptr<Arg>>> args;
    IndConstr() = default;
    IndConstr(string name, shared_ptr<vector<shared_ptr<Arg>>> args) : name(name), args(args) {}

    operator string() const;
};

class Option;
class List;

class Inductive : public SpecType {
public:
    static shared_ptr<Inductive> Nat;

    shared_ptr<vector<shared_ptr<IndConstr>>> constrs;
    std::map<string, shared_ptr<vector<shared_ptr<Arg>>>> constr;
    std::map<string, shared_ptr<SpecType>> arg_type;
    shared_ptr<std::map<string, z3::func_decl>> z3_constructors;
    //shared_ptr<std::map<string, z3::func_decl>> z3_accessors;

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

   shared_ptr<SpecValue> construct(string constr, vector<shared_ptr<SpecValue>> args) {
        if (auto opt = dynamic_cast<Option*>(this)) {
            constr = constr + "_" + opt->elem_type->name;
        }
        else if (auto lst = dynamic_cast<List*>(this)) {
            constr = constr + "_" + lst->elem_type->name;
        }
        auto z3_args = vector<z3::expr>();
        for (int i = 0; i < args.size(); i++) {
            z3_args.push_back(args[i]->get_z3_value());
        }
        if (z3_args.size() == 0) {
            // TODO
        }
        else {
            // TODO
        }
    }

    virtual z3::sort get_z3_type();
    virtual shared_ptr<SpecValue> from_z3_value(z3::expr value);
    virtual shared_ptr<SpecValue> declare(string name, int nid);
};

extern Inductive Nat;

class Function : public SpecType {
public:
    shared_ptr<SpecType> rettype;
    shared_ptr<vector<shared_ptr<SpecType>>> args;
    Function(shared_ptr<SpecType> rettype, shared_ptr<vector<shared_ptr<SpecType>>> args);

    operator string() const;

    virtual z3::sort get_z3_type();
    virtual shared_ptr<SpecValue> from_z3_value(z3::expr value);
    virtual shared_ptr<SpecValue> declare(string name, int nid);
};

class Tuple : public Struct {
public:
    shared_ptr<vector<shared_ptr<SpecType>>> types;
    Tuple(shared_ptr<vector<shared_ptr<SpecType>>> types);

    operator string() const;

    shared_ptr<SpecValue> construct(vector<shared_ptr<SpecValue>> args) {
        auto elems = vector<z3::expr>();
        for (int i = 0; i < args.size(); i++) {
            elems.push_back(args[i]->get_z3_value());
        }
        // TODO
    }
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

    z3::func_decl concat_func() {
        return z3::function((name + "_concat").c_str(), get_z3_type(), get_z3_type(), get_z3_type());
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

/////////////////////
// Spec Value
////////////////////

class SpecValue {
public:
    shared_ptr<SpecType> typ;
    z3::expr value;

    SpecValue(shared_ptr<SpecType> typ, int value) : typ(typ), value(z3ctx.int_val(value)) {}
    SpecValue(shared_ptr<SpecType> typ, bool value) : typ(typ), value(z3ctx.bool_val(value)) {}
    SpecValue(shared_ptr<SpecType> typ, string value) : typ(typ), value(z3ctx.string_val(value.c_str())) {}
    SpecValue(shared_ptr<SpecType> typ, z3::expr value) : typ(typ), value(value) {}

    shared_ptr<SpecType> get_type() { return typ; }
    z3::expr get_z3_value() { return value; }

    operator string() const {
        return "Value(" + string(*typ) + ", " + value.to_string() + ")";
    }

    virtual ~SpecValue() = default;
};

extern z3::func_decl land_func;
extern z3::func_decl lor_func;
extern z3::func_decl lxor_func;
extern z3::func_decl lnot_func;
extern z3::func_decl testbit_func;
extern z3::func_decl setbit_func;
extern z3::func_decl clearbit_func;

class BoolValue : public SpecValue {
public:
    BoolValue(bool value) : SpecValue(Bool::BOOL, value) {}
    BoolValue(z3::expr value) : SpecValue(Bool::BOOL, value) {}

    shared_ptr<BoolValue> eq(shared_ptr<BoolValue> other) {
        return make_shared<BoolValue>((value == other->value).simplify());
    }
    shared_ptr<BoolValue> ne(shared_ptr<BoolValue> other) {
        return make_shared<BoolValue>((value != other->value).simplify());
    }
    shared_ptr<BoolValue> andb(shared_ptr<BoolValue> other) {
        return make_shared<BoolValue>((value && other->value).simplify());
    }
    shared_ptr<BoolValue> orb(shared_ptr<BoolValue> other) {
        return make_shared<BoolValue>((value || other->value).simplify());
    }
    shared_ptr<BoolValue> negb() {
        return make_shared<BoolValue>(!value);
    }
    shared_ptr<BoolValue> implies(shared_ptr<BoolValue> other) {
        return make_shared<BoolValue>(z3::implies(value, other->value).simplify());
    }
    shared_ptr<BoolValue> xorb(shared_ptr<BoolValue> other) {
        return make_shared<BoolValue>((value ^ other->value).simplify());
    }
};


class IntValue : public SpecValue {
public:
    IntValue(int value) : SpecValue(Int::INT, value) {}
    IntValue(z3::expr value) : SpecValue(Int::INT, value) {}

    shared_ptr<IntValue> neg() { return make_shared<IntValue>((-value).simplify()); }
    shared_ptr<IntValue> add(shared_ptr<IntValue> other) { return make_shared<IntValue>((value + other->value).simplify()); }
    shared_ptr<IntValue> sub(shared_ptr<IntValue> other) { return make_shared<IntValue>((value - other->value).simplify()); }
    shared_ptr<IntValue> mul(shared_ptr<IntValue> other) { return make_shared<IntValue>((value * other->value).simplify()); }
    shared_ptr<IntValue> div(shared_ptr<IntValue> other) { return make_shared<IntValue>((value / other->value).simplify()); }
    shared_ptr<IntValue> mod(shared_ptr<IntValue> other) { return make_shared<IntValue>((value % other->value).simplify()); }
    shared_ptr<IntValue> shiftl(shared_ptr<IntValue> other) { return make_shared<IntValue>((z3::shl(value, other->value)).simplify()); }
    shared_ptr<IntValue> shiftr(shared_ptr<IntValue> other) { return make_shared<IntValue>((z3::lshr(value, other->value)).simplify()); }
    shared_ptr<IntValue> xorb(shared_ptr<IntValue> other) { return make_shared<IntValue>((value ^ other->value).simplify()); }
    shared_ptr<IntValue> land(shared_ptr<IntValue> other) { return make_shared<IntValue>(land_func(value, other->value)); }
    shared_ptr<IntValue> lor(shared_ptr<IntValue> other) { return make_shared<IntValue>(lor_func(value, other->value)); }
    shared_ptr<IntValue> lxor(shared_ptr<IntValue> other) { return make_shared<IntValue>(lxor_func(value, other->value)); }
    shared_ptr<IntValue> lnot() { return make_shared<IntValue>(lnot_func(value)); }
    shared_ptr<IntValue> setbit(shared_ptr<IntValue> other) { return make_shared<IntValue>(setbit_func(value, other->value)); }
    shared_ptr<IntValue> clearbit(shared_ptr<IntValue> other) { return make_shared<IntValue>(clearbit_func(value, other->value)); }
    shared_ptr<IntValue> testbit(shared_ptr<IntValue> other) { return make_shared<IntValue>(testbit_func(value, other->value)); }
    shared_ptr<BoolValue> eq(shared_ptr<IntValue> other) { make_shared<BoolValue>((value == other->value).simplify()); }
    shared_ptr<BoolValue> ne(shared_ptr<IntValue> other) { make_shared<BoolValue>((value != other->value).simplify()); }
    shared_ptr<BoolValue> lt(shared_ptr<IntValue> other) { make_shared<BoolValue>((value < other->value).simplify()); }
    shared_ptr<BoolValue> le(shared_ptr<IntValue> other) { make_shared<BoolValue>((value <= other->value).simplify()); }
    shared_ptr<BoolValue> gt(shared_ptr<IntValue> other) { make_shared<BoolValue>((value > other->value).simplify()); }
    shared_ptr<BoolValue> ge(shared_ptr<IntValue> other) { make_shared<BoolValue>((value >= other->value).simplify()); }
};

class StringValue : public SpecValue {
public:
    StringValue(string value) : SpecValue(String::STRING, value) {}
    StringValue(z3::expr value) : SpecValue(String::STRING, value) {}

    shared_ptr<BoolValue> eq(shared_ptr<StringValue> other) { return make_shared<BoolValue>((value == other->value).simplify()); }
    shared_ptr<BoolValue> ne(shared_ptr<StringValue> other) { return make_shared<BoolValue>((value != other->value).simplify()); }
};

class ZMapValue : public SpecValue {
public:
    ZMapValue(shared_ptr<SpecType> typ, z3::expr value) : SpecValue(typ, value) {}

    shared_ptr<SpecValue> get(shared_ptr<IntValue> key) {
        return dynamic_cast<ZMap *>(typ.get())->elem_type->from_z3_value(value[key->value].simplify());
    }

    shared_ptr<ZMapValue> set(IntValue key, SpecValue value) {
        return make_shared<ZMapValue>(typ, z3::store(this->value, key.value, value.value).simplify());
    }

    shared_ptr<BoolValue> eq(shared_ptr<ZMapValue> other) {
        return make_shared<BoolValue>((value == other->value).simplify());
    }
};

class FuncValue : public SpecValue {
public:
    z3::func_decl z3_func;

    FuncValue(shared_ptr<Function> typ, z3::expr value) : SpecValue(typ, value), z3_func(z3ctx.function("unknown", 0, nullptr, z3ctx.bool_sort())) {
        vector<z3::sort> arg_types;
        for (const auto arg : *typ->args) {
            arg_types.push_back(arg->get_z3_type());
        }
        z3_func = z3ctx.function(z3ctx.str_symbol(this->value + "_call"), arg_types.size(), arg_types.data(), typ->rettype->get_z3_type());
    }
};

class StructValue : public SpecValue {
public:
    StructValue(shared_ptr<Struct> typ, z3::expr value) : SpecValue(typ, value) {}

    shared_ptr<SpecValue> get(string key);
    shared_ptr<SpecValue> get(int key);
    shared_ptr<StructValue> set(string key, shared_ptr<SpecValue> value);
    shared_ptr<StructValue> set(int key, shared_ptr<SpecValue> value);

    shared_ptr<BoolValue> eq(shared_ptr<StructValue> other) {
        return make_shared<BoolValue>((value == other->value).simplify());
    }
};

class IndValue : public SpecValue {
public:
    z3::func_decl constructor;

    IndValue(shared_ptr<Inductive> typ, z3::expr value, z3::func_decl constr) : SpecValue(typ, value), constructor(constr) {};
    
    shared_ptr<SpecValue> get(string key);
    // shared_ptr<IndValue> set(string key, shared_ptr<SpecValue> value);
    shared_ptr<IndValue> concat(shared_ptr<IndValue> other);

    shared_ptr<BoolValue> eq(shared_ptr<IndValue> other) {
        return make_shared<BoolValue>((value == other->value).simplify());
    }
};

} // namespace autov
