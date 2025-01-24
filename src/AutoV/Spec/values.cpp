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

unordered_map<string, z3::sort> Inductive::created_z3_types;
unordered_map<string, z3::sort> Struct::created_z3_types;

z3::func_decl land_func = z3ctx.function("land", z3ctx.int_sort(), z3ctx.int_sort(), z3ctx.int_sort());
z3::func_decl lor_func = z3ctx.function("lor", z3ctx.int_sort(), z3ctx.int_sort(), z3ctx.int_sort());
z3::func_decl lxor_func = z3ctx.function("lxor", z3ctx.int_sort(), z3ctx.int_sort(), z3ctx.int_sort());
z3::func_decl lnot_func = z3ctx.function("lnot", z3ctx.int_sort(), z3ctx.int_sort());
z3::func_decl testbit_func = z3ctx.function("testbit", z3ctx.int_sort(), z3ctx.int_sort(), z3ctx.bool_sort());
z3::func_decl setbit_func = z3ctx.function("setbit", z3ctx.int_sort(), z3ctx.int_sort(), z3ctx.int_sort());
z3::func_decl clearbit_func = z3ctx.function("clearbit", z3ctx.int_sort(), z3ctx.int_sort(), z3ctx.int_sort());

shared_ptr<Struct> Struct::Ptr = make_shared<Struct>(
    "Ptr",
    make_shared<vector<shared_ptr<Arg>>>(
        std::initializer_list<shared_ptr<Arg>>{
            make_shared<Arg>("pbase", make_shared<String>()),
            make_shared<Arg>("poffset", make_shared<Int>())
        }
    )
);

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

shared_ptr<SpecType> SpecType::UNKNOWN_TYPE = make_shared<SpecType>("UNKNOWN_TYPE");
shared_ptr<Int> Int::INT = make_shared<Int>();
shared_ptr<String> String::STRING = make_shared<String>();
shared_ptr<Bool> Bool::BOOL = make_shared<Bool>();
shared_ptr<Prop> Prop::PROP = make_shared<Prop>();
shared_ptr<Type> Type::TYPE = make_shared<Type>();

// ----------------------------------------------------------------------------
// SpecType
// ----------------------------------------------------------------------------
z3::sort SpecType::get_z3_type() {
    if (Inductive::created_z3_types.find(name) != Inductive::created_z3_types.end()) {
        return Inductive::created_z3_types.at(name);
    } else if (Struct::created_z3_types.find(name) != Struct::created_z3_types.end()) {
        return Struct::created_z3_types.at(name);
    }

    return z3ctx.uninterpreted_sort(name.c_str());
}

shared_ptr<SpecValue> SpecType::from_z3_value(z3::expr value) {
    return make_shared<SpecValue>(shared_from_this(), value);
}

shared_ptr<SpecValue> SpecType::declare(string name, int nid) {
    auto sname = name + "." + std::to_string(nid);

    return make_shared<SpecValue>(shared_from_this(), z3ctx.constant(sname.c_str(), get_z3_type()));
}

// ----------------------------------------------------------------------------
// Int
// ----------------------------------------------------------------------------
z3::sort Int::get_z3_type() {
    return z3ctx.int_sort();
}

shared_ptr<SpecValue> Int::from_z3_value(z3::expr value) {
    return make_shared<IntValue>(value);
}

shared_ptr<SpecValue> Int::declare(string name, int nid) {
    auto sname = name + "." + std::to_string(nid);

    return make_shared<IntValue>(z3ctx.constant(sname.c_str(), get_z3_type()));
}

// ----------------------------------------------------------------------------
// String
// ----------------------------------------------------------------------------
z3::sort String::get_z3_type() {
    return z3ctx.string_sort();
}

shared_ptr<SpecValue> String::from_z3_value(z3::expr value) {
    return make_shared<StringValue>(value);
}

shared_ptr<SpecValue> String::declare(string name, int nid) {
    auto sname = name + "." + std::to_string(nid);

    return make_shared<StringValue>(z3ctx.constant(sname.c_str(), get_z3_type()));
}

// ----------------------------------------------------------------------------
// Bool
// ----------------------------------------------------------------------------
z3::sort Bool::get_z3_type() {
    return z3ctx.bool_sort();
}

shared_ptr<SpecValue> Bool::from_z3_value(z3::expr value) {
    return make_shared<BoolValue>(value);
}

shared_ptr<SpecValue> Bool::declare(string name, int nid) {
    auto sname = name + "." + std::to_string(nid);

    return make_shared<BoolValue>(z3ctx.constant(sname.c_str(), get_z3_type()));
}

// ----------------------------------------------------------------------------
// Prop
// ----------------------------------------------------------------------------
z3::sort Prop::get_z3_type() {
    return z3ctx.bool_sort();
}

shared_ptr<SpecValue> Prop::from_z3_value(z3::expr value) {
    return make_shared<BoolValue>(value);
}

shared_ptr<SpecValue> Prop::declare(string name, int nid) {
    auto sname = name + "." + std::to_string(nid);

    return make_shared<BoolValue>(z3ctx.constant(sname.c_str(), get_z3_type()));
}

// ----------------------------------------------------------------------------
// ZMap
// ----------------------------------------------------------------------------
z3::sort ZMap::get_z3_type() {
    return z3ctx.array_sort(z3ctx.int_sort(), this->elem_type->get_z3_type());
}

shared_ptr<SpecValue> ZMap::from_z3_value(z3::expr value) {
    return make_shared<ZMapValue>(shared_from_this(), value);
}

shared_ptr<SpecValue> ZMap::declare(string name, int nid) {
    auto sname = name + "." + std::to_string(nid);

    return make_shared<ZMapValue>(shared_from_this(), z3ctx.constant(name.c_str(), z3ctx.array_sort(z3ctx.int_sort(), this->elem_type->get_z3_type())));
}

// ----------------------------------------------------------------------------
// Arg
// ----------------------------------------------------------------------------
std::string Arg::to_string() const {
    if (expr != nullptr) {
        return "(" + name + ": " + string(*expr) + ")";
    } else {
        return "(" + name + ": " + string(*type) + ")";
    }
}

// ----------------------------------------------------------------------------
// Struct
// ----------------------------------------------------------------------------
std::string Struct::define() const {
    std::string res = "Record " + name + " :=\n";
    std::string args;
    for(auto arg: *elems) {
        args += arg->name;
        args += ": ";
        args += string(*arg->type);

        if(arg != *elems->end()) {
            args += ";\n";
        }
    }

    res += "  mk" + name + " {\n";
    res += add_indent(args, 4) + "\n";
    res += "}.\n";
    return res;
}

z3::sort Struct::get_z3_type() {
    //std::cout << "Struct::get_z3_type " << name << std::endl;
    if (Struct::created_z3_types.find(name) != Struct::created_z3_types.end()) {
        return Struct::created_z3_types.at(name);
    }

    z3::constructors cs(z3ctx);
    vector<z3::sort> sorts;
    vector<z3::symbol> accs;

    for (auto arg : *elems) {
        sorts.push_back(this->elems_map[arg->name]->get_z3_type());
        accs.push_back(z3ctx.str_symbol(arg->name.c_str()));
    }

    auto mk_name = "mk" + this->name;
    cs.add(z3ctx.str_symbol(mk_name.c_str()), z3ctx.str_symbol(this->name.c_str()),
                            accs.size(), accs.data(), sorts.data());

    auto z3type = z3ctx.datatype(z3ctx.str_symbol(this->name.c_str()), cs);
    Struct::created_z3_types.emplace(name, z3type);
    return z3type;
}

shared_ptr<SpecValue> Struct::from_z3_value(z3::expr value) {
    return make_shared<StructValue>(shared_from_this(), value);
}

shared_ptr<SpecValue> Struct::declare(string name, int nid) {
    auto sname = name + "." + std::to_string(nid);

    return make_shared<StructValue>(shared_from_this(), z3ctx.constant(sname.c_str(), get_z3_type()));
}

shared_ptr<SpecValue> Struct::construct(vector<shared_ptr<SpecValue>> &elems) {
    auto z3type = this->get_z3_type();
    auto mkRData = z3type.constructors()[0];
    z3::expr_vector args(z3ctx);

    for (int i = 0; i < elems.size(); i++) {
        args.push_back(elems[i]->get_z3_value());
    }

    return from_z3_value(mkRData(args));
}

// ----------------------------------------------------------------------------
// StructValue
// ----------------------------------------------------------------------------
std::shared_ptr<SpecValue> StructValue::get(string key) {
    string field = key;

    if (auto s = dynamic_cast<Struct*>(typ.get())) {
        int i = 0;
        bool found = false;
        for(auto arg : *s->elems) {
            if(arg->name == field) {
                found = true;
                break;
            }
            i++;
        }

        if(!found)
            throw std::runtime_error("Field not found:" + field);

        auto elem_typ = s->elems_map[field];
        z3::sort z3type = s->get_z3_type();
        assert(z3type.is_datatype());
        z3::func_decl_vector css = z3type.constructors();
        z3::func_decl cs = css[0];  //one constructor: mk{fname}
        z3::func_decl accessor = cs.accessors()[i]; //get the ith accessor

        return elem_typ->from_z3_value(accessor(get_z3_value()));
    }

    throw std::runtime_error("Not a struct type");
}

shared_ptr<SpecValue> StructValue::get(int key) {
    assert(is_instance(typ.get(), Tuple));

    string field = "elem_" + std::to_string(key);
    return StructValue::get(field);
}

shared_ptr<StructValue> StructValue::set(string key, shared_ptr<SpecValue> value) {
    string field = key;
    if(auto s = dynamic_cast<Struct*>(typ.get())) {
        auto elem_typ = s->elems_map[field];
        z3::sort z3type = s->get_z3_type();
        assert(z3type.is_datatype());
        z3::func_decl_vector css = z3type.constructors();
        z3::func_decl cs = css[0];  //one constructor: mk{fname}

        z3::expr_vector elems(z3ctx);
        int i = 0;
        for(auto arg : *s->elems) {
            if(arg->name == field) {
                elems.push_back(value->get_z3_value());
            } else {
                elems.push_back(z3type.constructors()[0].accessors()[i](get_z3_value()));
            }
            i++;
        }

        return dynamic_pointer_cast<StructValue>(s->from_z3_value(cs(elems)));
    }

    throw std::runtime_error("Not a struct type");
}

shared_ptr<StructValue> StructValue::set(int key, shared_ptr<SpecValue> value) {
    assert(is_instance(typ.get(), Tuple));
    string field = "elem_" + std::to_string(key);
    return StructValue::set(field, value);
}

// ----------------------------------------------------------------------------
// IndValue
// ----------------------------------------------------------------------------

shared_ptr<SpecValue> IndValue::get(string key) {
    auto accessor = key;
    if(auto type = instance_of(typ.get(), Option)) {
        accessor = key + "_" + type->elem_type->name;
    }
    if(auto type = instance_of(typ.get(), List)) {
        accessor = key + "_" + type->elem_type->name;
    }
    assert(is_instance(typ.get(), Inductive));

    if(auto type = instance_of(typ.get(), Inductive)) {
        auto val = get_z3_value();
        int i = 0;

        for(auto [arg, type]: type->arg_type) {
            if(arg == accessor)
                break;
            i++;
        }

        auto acc = accessors[i];
        return type->arg_type[accessor]->from_z3_value(acc(val).simplify());
    }

    throw std::runtime_error("Not an inductive type");
}

// shared_ptr<IndValue> IndValue::set(string key, shared_ptr<SpecValue> value) {
//     //this sames not used by before
//     return nullptr;
// }

shared_ptr<IndValue> IndValue::concat(shared_ptr<IndValue> other) {
    assert(is_instance(typ.get(), List));
    assert(is_instance(other->typ.get(), List));

    if(auto type = instance_of(typ.get(), List)) {
        z3::func_decl f = type->concat_func();
        return dynamic_pointer_cast<IndValue>(type->from_z3_value(f(get_z3_value(), other->get_z3_value())));
    }

    throw std::runtime_error("Not a list type");
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

z3::sort Inductive::get_z3_type() {
    if (Inductive::created_z3_types.find(name) != Inductive::created_z3_types.end()) {
        return Inductive::created_z3_types.at(name);
    }

    z3::constructors cs(z3ctx);
    vector<z3::sort> sorts;
    vector<z3::symbol> accs;
    auto tname = z3ctx.str_symbol(name.c_str());
    auto tsort = z3ctx.datatype_sort(tname);

    for (auto constr : *constrs) {
        sorts.clear();
        accs.clear();
        for (auto arg : *constr->args) {
            auto arg_name = arg->name;

            if (arg->type->name == this->name)
                sorts.push_back(tsort);
            else
                sorts.push_back(arg->type->get_z3_type());
            accs.push_back(z3ctx.str_symbol(arg_name.c_str()));
        }
        cs.add(z3ctx.str_symbol(constr->name.c_str()), z3ctx.str_symbol(this->name.c_str()),
                                accs.size(), accs.data(), sorts.data());
    }

    auto z3type = z3ctx.datatype(tname, cs);
    Inductive::created_z3_types.emplace(name, z3type);

    return z3type;
}

shared_ptr<SpecValue> Inductive::from_z3_value(z3::expr value) {
    return make_shared<IndValue>(shared_from_this(), value);
}

shared_ptr<SpecValue> Inductive::declare(string name, int nid) {
    auto sname = name + "." + std::to_string(nid);

    return make_shared<IndValue>(shared_from_this(), z3ctx.constant(sname.c_str(), get_z3_type()));
}

shared_ptr<SpecValue> Inductive::construct(string constr, vector<shared_ptr<SpecValue>> args) {
    if (auto opt = dynamic_cast<Option*>(this)) {
        constr = constr + "_" + opt->elem_type->name;
    } else if (auto lst = dynamic_cast<List*>(this)) {
        constr = constr + "_" + lst->elem_type->name;
    }

    z3::expr_vector z3_args(z3ctx);
    for (int i = 0; i < args.size(); i++) {
        z3_args.push_back(args[i]->get_z3_value());
    }

    auto css = this->get_z3_type().constructors();

    for (int i = 0; i < css.size(); i++) {
        auto cs = css[i];
        if (cs.name().str() == constr) {
            if (z3_args.size() == 0) {
                return from_z3_value(cs());
            } else {
                return from_z3_value(cs(z3_args));
            }
        }
    }

    throw std::runtime_error("Constructor not found");
}

// ----------------------------------------------------------------------------
// Function
// ----------------------------------------------------------------------------
Function::Function(shared_ptr<SpecType> rettype, shared_ptr<vector<shared_ptr<SpecType>>> args) {
    this->name = "Func_" + join_underline(*args) + "_" + rettype->name;
    this->rettype = rettype;
    this->args = args;
}

Function::operator string() const {
    std::string res = "";

    for (const auto &arg : *args) {
        res += string(*arg) + " -> ";
        if (arg != args->back()) {
            res += "(";
        }
    }

    return res + std::string(*rettype) + string(args->size() - 1, ')');
}

shared_ptr<SpecValue> Function::from_z3_value(z3::expr value) {
    return make_shared<FuncValue>(shared_from_this(), value);
}

shared_ptr<SpecValue> Function::declare(string name, int nid) {
    auto sname = name + "." + std::to_string(nid);

    return make_shared<FuncValue>(shared_from_this(), z3ctx.constant(sname.c_str(), get_z3_type()));
}

// ----------------------------------------------------------------------------
// Tuple
// ----------------------------------------------------------------------------
Tuple::Tuple(shared_ptr<vector<shared_ptr<SpecType>>> types) :
    Struct("Tuple_" + join_underline(*types),
           make_shared<std::vector<shared_ptr<Arg>>>()),
    types(types) {
    if (types->size() == 1) {
        throw std::runtime_error("Tuple must have at least two element");
    }

    for (int i = 0; i < types->size(); i++) {
        elems->push_back(make_shared<Arg>("elem_" + std::to_string(i), (*types)[i]));
        elems_map.emplace("elem_" + std::to_string(i), (*types)[i]);
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

// XXX: Python doesn't have this. Do we need it here?
// shared_ptr<SpecValue> Tuple::construct(vector<shared_ptr<SpecValue>> args) {
//     auto elems = vector<z3::expr>();
//     for (int i = 0; i < args.size(); i++) {
//         elems.push_back(args[i]->get_z3_value());
//     }
//     // TODO
// }

// ----------------------------------------------------------------------------
// List
// ----------------------------------------------------------------------------

shared_ptr<SpecValue> int_to_ptr() {
    auto args = make_shared<vector<shared_ptr<SpecType>>>();
    args->push_back(Int::INT);
    return make_shared<Function>(Struct::Ptr, args)->declare("int_to_ptr", 0);
}

shared_ptr<SpecValue> ptr_to_int() {
    auto args = make_shared<vector<shared_ptr<SpecType>>>();
    args->push_back(Struct::Ptr);
    return make_shared<Function>(Int::INT, args)->declare("ptr_to_int", 0);
}

shared_ptr<SpecValue> z_to_nat() {
    auto args = make_shared<vector<shared_ptr<SpecType>>>();
    args->push_back(Int::INT);
    return make_shared<Function>(Inductive::Nat, args)->declare("z_to_nat", 0);
}
} // namespace autov