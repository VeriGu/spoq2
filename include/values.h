#pragma once

#include <iostream>
#include <string>
#include <vector>
#include <map>
#include <unordered_map>
#include <sstream>
#include <memory>
#include <z3++.h>

namespace autov {
using std::string;
using std::vector;
using std::unique_ptr;
using std::make_unique;
using std::shared_ptr;
using std::make_shared;
using std::unordered_map;
using std::enable_shared_from_this;
using std::static_pointer_cast;

extern z3::context z3ctx;

class SpecValue;

class SpecType : public enable_shared_from_this<SpecType> {
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

    shared_ptr<SpecType> getptr() {
        return shared_from_this();
    }

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

    shared_ptr<Int> getptr() {
        return static_pointer_cast<Int>(shared_from_this());
    }

    virtual z3::sort get_z3_type() override;
    virtual shared_ptr<SpecValue> from_z3_value(z3::expr value) override;
    virtual shared_ptr<SpecValue> declare(string name, int nid) override;
};

class String : public SpecType {
public:
    static shared_ptr<String> STRING;
    String() : SpecType("string") {}

    shared_ptr<String> getptr() {
        return static_pointer_cast<String>(shared_from_this());
    }

    virtual z3::sort get_z3_type() override;
    virtual shared_ptr<SpecValue> from_z3_value(z3::expr value) override;
    virtual shared_ptr<SpecValue> declare(string name, int nid) override;
};

class Bool : public SpecType {
public:
    static shared_ptr<Bool> BOOL;

    Bool() : SpecType("bool") {}

    shared_ptr<Bool> getptr() {
        return static_pointer_cast<Bool>(shared_from_this());
    }

    virtual z3::sort get_z3_type() override;
    virtual shared_ptr<SpecValue> from_z3_value(z3::expr value) override;
    virtual shared_ptr<SpecValue> declare(string name, int nid) override;
};

class Array : public SpecType {
public:
    shared_ptr<SpecType> elem_type;
    Array() = default;
    Array(shared_ptr<SpecType> elem_type) : SpecType("list_" + elem_type->name), elem_type(elem_type) {}
    //Array(const Array& other) : SpecType(other.name), elem_type(std::make_unique<SpecType>(*other.elem_type)) {}

    shared_ptr<Array> getptr() {
        return static_pointer_cast<Array>(shared_from_this());
    }

    // XXX: unused?
    // virtual z3::sort get_z3_type();
    // virtual shared_ptr<SpecValue> from_z3_value(z3::expr value);
    // virtual shared_ptr<SpecValue> declare(string name, int nid);

    operator string() const {
        return "list_" + string(*elem_type);
    }
};

class Prop : public SpecType {
public:
    static shared_ptr<Prop> PROP;

    Prop() : SpecType("Prop") {}

    shared_ptr<Prop> getptr() {
        return static_pointer_cast<Prop>(shared_from_this());
    }

    virtual z3::sort get_z3_type() override;
    virtual shared_ptr<SpecValue> from_z3_value(z3::expr value) override;
    virtual shared_ptr<SpecValue> declare(string name, int nid) override;
};

class Type : public SpecType {
public:
    static shared_ptr<Type> TYPE;

    Type() : SpecType("Type") {}

    shared_ptr<Type> getptr() {
        return static_pointer_cast<Type>(shared_from_this());
    }

    virtual z3::sort get_z3_type() override {
        throw std::runtime_error("Type.get_z3_type not implemented");
    }
    virtual shared_ptr<SpecValue> from_z3_value(z3::expr value) override {
        throw std::runtime_error("Type.from_z3_value not implemented");
    }
    virtual shared_ptr<SpecValue> declare(string name, int nid) override {
        throw std::runtime_error("Type.declare not implemented");
    }
};

class ZMap : public SpecType {
public:
    shared_ptr<SpecType> elem_type;
    ZMap() = default;
    ZMap(shared_ptr<SpecType> elem_type) : SpecType("ZMap_" + elem_type->name), elem_type(elem_type) {}

    shared_ptr<ZMap> getptr() {
        return static_pointer_cast<ZMap>(shared_from_this());
    }

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

    shared_ptr<Arg> getptr() {
        return shared_ptr<Arg>(this);
    }

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
    static unordered_map<string, z3::sort> created_z3_types;

    shared_ptr<vector<shared_ptr<Arg>>> elems;
    std::map<string, shared_ptr<SpecType>> elems_map;
    Struct() = default;
    Struct(string name, shared_ptr<vector<shared_ptr<Arg>>> elems) : SpecType(name), elems(elems) {
        for (const auto &elem : *elems) { // Fix: Use emplace instead of assignment to insert elements into elems_map
            elems_map.emplace(elem->name, elem->type);
        }
    }

    shared_ptr<Struct> getptr() {
        return static_pointer_cast<Struct>(shared_from_this());
    }

    string define() const;

    virtual z3::sort get_z3_type() override;
    virtual shared_ptr<SpecValue> from_z3_value(z3::expr value) override;
    virtual shared_ptr<SpecValue> declare(string name, int nid) override;
    shared_ptr<SpecValue> construct(vector<shared_ptr<SpecValue>> &elems);
};

class IndConstr {
public:
    string name;
    shared_ptr<vector<shared_ptr<Arg>>> args;
    IndConstr() = default;
    IndConstr(string name, shared_ptr<vector<shared_ptr<Arg>>> args) : name(name), args(args) {}

    shared_ptr<IndConstr> getptr() {
        return shared_ptr<IndConstr>(this);
    }

    operator string() const;
};

class Option;
class List;

class Inductive : public SpecType {
public:
    static shared_ptr<Inductive> Nat;
    static unordered_map<string, z3::sort> created_z3_types;

    shared_ptr<vector<shared_ptr<IndConstr>>> constrs;
    std::map<string, shared_ptr<vector<shared_ptr<Arg>>>> constr;
    std::map<string, shared_ptr<SpecType>> arg_type;
    shared_ptr<std::map<string, z3::func_decl>> z3_constructors;
    //shared_ptr<std::map<string, z3::func_decl>> z3_accessors;

    Inductive() = default;
    Inductive(string name, shared_ptr<vector<shared_ptr<IndConstr>>> constrs) : SpecType(name), constrs(constrs) {
        for (const auto &c : *constrs) {
            constr.emplace(c->name, c->args);
            for (const auto &arg : *c->args) {
                arg_type.emplace(arg->name, arg->type);
            }
        }
    }

    shared_ptr<Inductive> getptr() {
        return static_pointer_cast<Inductive>(shared_from_this());
    }

    string define() const;

    shared_ptr<SpecValue> construct(string constr, vector<shared_ptr<SpecValue>> args);

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

    shared_ptr<Function> getptr() {
        return static_pointer_cast<Function>(shared_from_this());
    }

    //virtual z3::sort get_z3_type();
    virtual shared_ptr<SpecValue> from_z3_value(z3::expr value);
    virtual shared_ptr<SpecValue> declare(string name, int nid);
};

class Tuple : public Struct {
public:
    shared_ptr<vector<shared_ptr<SpecType>>> types;
    Tuple(shared_ptr<vector<shared_ptr<SpecType>>> types);

    operator string() const;

    shared_ptr<Tuple> getptr() {
        return static_pointer_cast<Tuple>(shared_from_this());
    }
};

class List : public Inductive {
public:
    shared_ptr<SpecType> elem_type;
    List(shared_ptr<SpecType> elem_type) :
        Inductive(
            "List_" + elem_type->name,
            make_shared<vector<shared_ptr<IndConstr>>>(
                std::initializer_list<shared_ptr<IndConstr>>{
                    make_shared<IndConstr>(
                        "cons_" + elem_type->name,
                        make_shared<vector<shared_ptr<Arg>>>(
                            std::initializer_list<shared_ptr<Arg>>{
                                make_shared<Arg>("head_" + elem_type->name, elem_type),
                                make_shared<Arg>("tail_" + elem_type->name, make_shared<SpecType>("List_" + elem_type->name))
                            }
                        )
                    ),
                    make_shared<IndConstr>("nil_" + elem_type->name, make_shared<vector<shared_ptr<Arg>>>(vector<shared_ptr<Arg>>()))
                }
            )
        ),
        elem_type(elem_type) {}

    shared_ptr<List> getptr() {
        return static_pointer_cast<List>(shared_from_this());
    }

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
            "Option_" + elem_type->name,
            make_shared<vector<shared_ptr<IndConstr>>>(
                std::initializer_list<shared_ptr<IndConstr>>{
                    make_shared<IndConstr>(
                        "Some_"  + elem_type->name,
                        make_shared<vector<shared_ptr<Arg>>>(
                            std::initializer_list<shared_ptr<Arg>>{
                                make_shared<Arg>("value_" + elem_type->name, elem_type)
                            }
                        )
                    ),
                    make_shared<IndConstr>("None_" + elem_type->name, make_shared<vector<shared_ptr<Arg>>>(vector<shared_ptr<Arg>>()))
                }
            )
        ),
        elem_type(elem_type) {}

    shared_ptr<Option> getptr() {
        return static_pointer_cast<Option>(shared_from_this());
    }

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

    SpecValue(shared_ptr<SpecType> typ, unsigned long value) : typ(typ), value(z3ctx.int_val((unsigned long)value)) {}
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
    IntValue(unsigned long value) : SpecValue(Int::INT, value) {}
    IntValue(z3::expr value) : SpecValue(Int::INT, value) {}

    shared_ptr<IntValue> neg() { return make_shared<IntValue>((-value).simplify()); }
    shared_ptr<IntValue> add(shared_ptr<IntValue> other) { return make_shared<IntValue>((value + other->value).simplify()); }
    shared_ptr<IntValue> sub(shared_ptr<IntValue> other) { return make_shared<IntValue>((value - other->value).simplify()); }
    shared_ptr<IntValue> mul(shared_ptr<IntValue> other) { return make_shared<IntValue>((value * other->value).simplify()); }
    shared_ptr<IntValue> div(shared_ptr<IntValue> other) { return make_shared<IntValue>((value / other->value).simplify()); }
    shared_ptr<IntValue> mod(shared_ptr<IntValue> other) { return make_shared<IntValue>((value % other->value).simplify()); }
    shared_ptr<IntValue> shiftl(shared_ptr<IntValue> other) { return make_shared<IntValue>(( value * z3::pw(2, other->value)).simplify()); }
    shared_ptr<IntValue> shiftr(shared_ptr<IntValue> other) { return make_shared<IntValue>(( value / z3::pw(2, other->value)).simplify()); }
    shared_ptr<IntValue> xorb(shared_ptr<IntValue> other) { return make_shared<IntValue>((value ^ other->value).simplify()); }
    shared_ptr<IntValue> land(shared_ptr<IntValue> other) { return make_shared<IntValue>(land_func(value, other->value)); }
    shared_ptr<IntValue> lor(shared_ptr<IntValue> other) { return make_shared<IntValue>(lor_func(value, other->value)); }
    shared_ptr<IntValue> lxor(shared_ptr<IntValue> other) { return make_shared<IntValue>(lxor_func(value, other->value)); }
    shared_ptr<IntValue> lnot() { return make_shared<IntValue>(lnot_func(value)); }
    shared_ptr<IntValue> setbit(shared_ptr<IntValue> other) { return make_shared<IntValue>(setbit_func(value, other->value)); }
    shared_ptr<IntValue> clearbit(shared_ptr<IntValue> other) { return make_shared<IntValue>(clearbit_func(value, other->value)); }
    shared_ptr<IntValue> testbit(shared_ptr<IntValue> other) { return make_shared<IntValue>(testbit_func(value, other->value)); }
    shared_ptr<BoolValue> eq(shared_ptr<IntValue> other) { return make_shared<BoolValue>((value == other->value).simplify()); }
    shared_ptr<BoolValue> ne(shared_ptr<IntValue> other) { return make_shared<BoolValue>((value != other->value).simplify()); }
    shared_ptr<BoolValue> lt(shared_ptr<IntValue> other) { return make_shared<BoolValue>((value < other->value).simplify()); }
    shared_ptr<BoolValue> le(shared_ptr<IntValue> other) { return make_shared<BoolValue>((value <= other->value).simplify()); }
    shared_ptr<BoolValue> gt(shared_ptr<IntValue> other) { return make_shared<BoolValue>((value > other->value).simplify()); }
    shared_ptr<BoolValue> ge(shared_ptr<IntValue> other) { return make_shared<BoolValue>((value >= other->value).simplify()); }
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

    shared_ptr<ZMapValue> set(shared_ptr<IntValue> key, shared_ptr<SpecValue> value) {
        return make_shared<ZMapValue>(typ, z3::store(this->value, key->value, value->value).simplify());
    }

    shared_ptr<BoolValue> eq(shared_ptr<ZMapValue> other) {
        return make_shared<BoolValue>((value == other->value).simplify());
    }
};

class FuncValue : public SpecValue {
public:
    z3::func_decl z3_func;

    FuncValue(shared_ptr<SpecType> typ, z3::expr value) : SpecValue(typ, value), z3_func(z3ctx.function("unknown", 0, nullptr, z3ctx.bool_sort())) {
        vector<z3::sort> arg_types;
        auto ftyp = static_pointer_cast<Function>(typ);
        for (const auto &arg : *ftyp->args) {
            arg_types.push_back(arg->get_z3_type());
        }
        auto __func_call_str =  this->value.to_string() + "_call";
        auto func_call_str = __func_call_str.c_str();
        z3_func = z3ctx.function(z3ctx.str_symbol(func_call_str), arg_types.size(), arg_types.data(), ftyp->rettype->get_z3_type());
    }

    shared_ptr<SpecValue> call(vector<shared_ptr<SpecValue>> args) {
        vector<z3::expr> z3_args;
        for (const auto &arg : args) {
            z3_args.push_back(arg->get_z3_value());
        }
        return static_pointer_cast<Function>(typ)->rettype->from_z3_value(z3_func(z3_args.size(), z3_args.data()));
    }
};

class StructValue : public SpecValue {
public:
    StructValue(shared_ptr<SpecType> typ, z3::expr value) : SpecValue(typ, value) {}

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

    IndValue(shared_ptr<SpecType> typ, z3::expr value) : SpecValue(typ, value), constructor(value.get_sort().constructors()[0]) {};

    shared_ptr<SpecValue> get(string key);
    // shared_ptr<IndValue> set(string key, shared_ptr<SpecValue> value);
    shared_ptr<IndValue> concat(shared_ptr<IndValue> other);

    shared_ptr<BoolValue> eq(shared_ptr<IndValue> other) {
        return make_shared<BoolValue>((value == other->value).simplify());
    }
};

shared_ptr<SpecValue> int_to_ptr();
shared_ptr<SpecValue> ptr_to_int();
shared_ptr<SpecValue> z_to_nat();

} // namespace autov
