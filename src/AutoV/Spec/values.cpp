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
        return Inductive::created_z3_types[name];
    } else if (Struct::created_z3_types.find(name) != Struct::created_z3_types.end()) {
        return Struct::created_z3_types[name];
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
    return make_shared<IntValue>(shared_from_this(), value);
}

shared_ptr<SpecValue> Int::declare(string name, int nid) {
    auto sname = name + "." + std::to_string(nid);

    return make_shared<IntValue>(shared_from_this(), z3ctx.constant(sname.c_str(), get_z3_type()));
}

// ----------------------------------------------------------------------------
// String
// ----------------------------------------------------------------------------
z3::sort String::get_z3_type() {
    return z3ctx.string_sort();
}

shared_ptr<SpecValue> String::from_z3_value(z3::expr value) {
    return make_shared<StringValue>(shared_from_this(), value);
}

shared_ptr<SpecValue> String::declare(string name, int nid) {
    auto sname = name + "." + std::to_string(nid);

    return make_shared<StringValue>(shared_from_this(), z3ctx.constant(sname.c_str(), get_z3_type()));
}

// ----------------------------------------------------------------------------
// Bool
// ----------------------------------------------------------------------------
z3::sort Bool::get_z3_type() {
    return z3ctx.bool_sort();
}

shared_ptr<SpecValue> Bool::from_z3_value(z3::expr value) {
    return make_shared<BoolValue>(shared_from_this(), value);
}

shared_ptr<SpecValue> Bool::declare(string name, int nid) {
    auto sname = name + "." + std::to_string(nid);

    return make_shared<BoolValue>(shared_from_this(), z3ctx.constant(sname.c_str(), get_z3_type()));
}

// ----------------------------------------------------------------------------
// Prop
// ----------------------------------------------------------------------------
z3::sort Prop::get_z3_type() {
    return z3ctx.bool_sort();
}

shared_ptr<SpecValue> Prop::from_z3_value(z3::expr value) {
    return make_shared<BoolValue>(shared_from_this(), value);
}

shared_ptr<SpecValue> Prop::declare(string name, int nid) {
    auto sname = name + "." + std::to_string(nid);

    return make_shared<BoolValue>(shared_from_this(), z3ctx.constant(sname.c_str(), get_z3_type()));
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

z3::sort Struct::get_z3_type() {
    if (Struct::created_z3_types.find(name) != Struct::created_z3_types.end()) {
        return Struct::created_z3_types[name];
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
    Struct::created_z3_types[name] = z3type;
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

    if(auto s = dynamic_cast<Struct*>(typ.get())) {
        int i = 0;
        bool found = false;
        for(auto arg : *s->elems) {
            if(arg->name == field) {
                found = true;
                break;
            }
            i++;
        }

        if(!found) {
            LOG_ERROR << "Not a struct type";
            assert(false);
        }

        auto elem_typ = s->elems_map[field];
        z3::sort z3type = s->get_z3_type();
        assert(z3type.is_datatype());
        z3::func_decl_vector css = z3type.constructors();
        z3::func_decl cs = css[0];  //one constructor: mk{fname}
        z3::func_decl accessor = cs.accessors()[i]; //get the ith accessor

        return elem_typ->from_z3_value(accessor(get_z3_value()));
    }

    LOG_ERROR << "Not a struct type";
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
        int i;
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
        bool found = false;
        for(auto [arg, type]: type->arg_type) {
            if(arg == accessor) {
                found = true;
                break;
            }
            i++;
        }
        auto acc = constructor.accessors()[i];
        return type->arg_type[accessor]->from_z3_value(acc(val));
    }
}

// shared_ptr<IndValue> IndValue::set(string key, shared_ptr<SpecValue> value) {
//     //this sames not used by before
//     return nullptr;
// }

shared_ptr<IndValue> IndValue::concat(shared_ptr<IndValue> other) {
    assert(is_instance(typ.get(), List));
    assert(is_instance(other.get(), List));

    if(auto type = instance_of(typ.get(), List)) {
        z3::func_decl f = type->concat_func();
        return dynamic_pointer_cast<IndValue>(type->from_z3_value(f(get_z3_value(), other->get_z3_value())));
    }
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

shared_ptr<SpecValue> Tuple::construct(vector<shared_ptr<SpecValue>> args) {
    auto elems = vector<z3::expr>();
    for (int i = 0; i < args.size(); i++) {
        elems.push_back(args[i]->get_z3_value());
    }
    // TODO
}

// ----------------------------------------------------------------------------
// List
// ----------------------------------------------------------------------------


} // namespace autov