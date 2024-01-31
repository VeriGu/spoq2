#include <project.h>
#include <iostream>
#include <post_process.h>

namespace autov {


const string Project::LOC_DATATYPES = "DataTypes";
const string Project::LOC_LOWSPEC = "LowSpec";
const string Project::LOC_SPEC = "Spec";
const string Project::LOC_REFPROOF = "RefProof";
const string Project::LOC_GLOBALDEFS = "GlobalDefs";
const string Project::LOC_NODEFS = "NoDefs";
const string Project::PROJ_NAME = "PROJ_NAME";
const string Project::PROJ_BASE = "PROJ_BASE";
const string Project::LAYER_PRIMS = "LAYER_PRIMS";
const string Project::LAYER_CODE = "LAYER_CODE";
const string Project::LAYER_LOAD = "LAYER_LOAD";
const string Project::LAYER_STORE = "LAYER_STORE";
const string Project::LAYER_NEW_FRAME = "LAYER_NEW_FRAME";
const string Project::LAYER_ALLOC = "LAYER_ALLOC";
const string Project::LAYER_FREE = "LAYER_FREE";
const string Project::LAYER_GET_REG = "LAYER_GET_REG";
const string Project::LAYER_SET_REG = "LAYER_SET_REG";
const string Project::LAYER_GET_FLAG = "LAYER_GET_FLAG";
const string Project::LAYER_SET_FLAG = "LAYER_SET_FLAG";
const string Project::LAYER_PTR2INT = "LAYER_PTR2INT";
const string Project::LAYER_INT2PTR = "LAYER_INT2PTR";
const string Project::LAYER_PTR_EQB = "LAYER_PTR_EQB";
const string Project::LAYER_PTR_LTB = "LAYER_PTR_LTB";
const string Project::LAYER_PTR_GTB = "LAYER_PTR_GTB";
const string Project::LAYER_DATA = "LAYER_DATA";

void Project::add_symbol(string name, SymbolKind kind, string info, shared_ptr<loc_t> loc)
{
    symbols[name] = SymbolInfo{kind, info, *loc, name.length()};
}

void Project::add_struct(shared_ptr<Struct> s, shared_ptr<loc_t> loc)
{
    string name = s->name;

    structs[name] = s;
    for (const auto& field : *(structs[name]->elems)) {
        this->add_symbol(field->name, SymbolKind::StructElem, name, loc);
    }
    this->add_symbol("mk" + name, SymbolKind::StructConstr, name, loc);
    this->add_symbol(name, SymbolKind::Struct, "", loc);
}

void Project::add_struct(shared_ptr<Struct> s)
{
    this->add_struct(s, make_shared<loc_t>(Project::LOC_DATATYPES, "", ""));
}

void Project::add_indtype(shared_ptr<Inductive> ind, shared_ptr<loc_t> loc) {
    string name = ind->name;

    indtypes[name] = ind;
    for (const auto& constr : *(indtypes[name]->constrs)) {
        this->add_symbol(constr->name, SymbolKind::IndConstructor, name, loc);
    }
    this->add_symbol(name, SymbolKind::IndType, "", loc);
}

void Project::add_indtype(shared_ptr<Inductive> ind) {
    this->add_indtype(std::move(ind), make_shared<loc_t>(Project::LOC_DATATYPES, "", ""));
}

void Project::add_typedef(string name, shared_ptr<SpecType> t) {
    typedefs[name] = t;
    this->add_symbol(name, SymbolKind::TypeDef, "", make_shared<loc_t>(Project::LOC_DATATYPES, "", ""));
}

void Project::add_declaration(unique_ptr<Declaration> decl, shared_ptr<loc_t> loc) {
    string &name = decl->name;

    decls[name] = std::move(decl);
    this->add_symbol(decls[name]->name, SymbolKind::Decl, "", loc);
}

void Project::add_definition(unique_ptr<Definition> def, shared_ptr<loc_t> loc) {
    string &name = def->name;
    auto def_ = def.get();

    defs[name] = std::move(def);
    this->add_symbol(defs[name]->name, SymbolKind::Def, "", loc);

    LOG_DEBUG << "Adding definition " << name;
    def_->infer_type(*this);
}

void Project::add_layer(std::unique_ptr<Layer> layer) {
    layers.push_back(std::move(layer));
}

void Project::add_command(unique_ptr<Expr> cmd) {
    // Implementation goes here
}

void Project::add_command(unique_ptr<Expr> cmd, unique_ptr<Layer> layer) {
}

bool Project::is_ind_constr(string name) {
    static const std::unordered_set<std::string> ind_constr_symbols = {"None", "Some", "nil", "cons"};

    if (symbols.find(name) != symbols.end() && symbols[name].kind == SymbolKind::IndConstructor) {
        return true;
    } else if (ind_constr_symbols.find(name) != ind_constr_symbols.end()) {
        return true;
    } else {
        return false;
    }
}

bool Project::is_struct_constr(string name) {
    if (name.find("mk") == 0 and structs.find(name.substr(2)) != structs.end()) {
        return true;
    } else if (name == "Tuple") {
        return true;
    } else {
        return false;
    }
}

shared_ptr<SpecType> Project::get_indtype_by_constr(string name) {
    if (symbols.find(name) == symbols.end()) {
        return nullptr;
    }

    if (indtypes.find(symbols.at(name).info) == indtypes.end()) {
        return nullptr;
    }

    return indtypes.at(symbols.at(name).info);
}

bool Project::is_known_symbol(string name) {
    return (symbols.find(name) != symbols.end()) or is_ind_constr(name) or is_struct_constr(name);
}

static inline unique_ptr<Definition> make_ptr_offset(void) {
/*
 *        ptr_offset = Definition("ptr_offset", Ptr, [Arg("_ptr", Ptr), Arg("_offs", Int())],
                                Expr("mkPtr", [Expr("Record.get", [Symbol("_ptr", Ptr), Symbol("pbase")]),
                                               Expr("+", [Expr("Record.get", [Symbol("_ptr", Ptr), Symbol("poffset")]),
                                                          Symbol("_offs", Int())])]))
 */
    auto record_get1_elems = make_unique<vector<unique_ptr<SpecNode>>>();

    record_get1_elems->push_back(make_unique<Symbol>("_ptr", Struct::Ptr));
    record_get1_elems->push_back(make_unique<Symbol>("poffset"));

    auto record_get1 = make_unique<Expr>(Expr::RecordGet, std::move(record_get1_elems));

    auto plus_elems = make_unique<vector<unique_ptr<SpecNode>>>();

    plus_elems->push_back(std::move(record_get1));
    plus_elems->push_back(make_unique<Symbol>("_offs", Int::INT));

    auto plus = make_unique<Expr>(Expr::ADD, std::move(plus_elems));

    auto record_get2_elems = make_unique<vector<unique_ptr<SpecNode>>>();

    record_get2_elems->push_back(make_unique<Symbol>("_ptr", Struct::Ptr));
    record_get2_elems->push_back(make_unique<Symbol>("pbase"));

    auto record_get2 = make_unique<Expr>(Expr::RecordGet, std::move(record_get2_elems));

    auto mkPtr_elems = make_unique<vector<unique_ptr<SpecNode>>>();

    mkPtr_elems->push_back(std::move(record_get2));
    mkPtr_elems->push_back(std::move(plus));

    auto mkptr = make_unique<Expr>("mkPtr", std::move(mkPtr_elems));

    auto ptr_offset_args = make_unique<vector<shared_ptr<Arg>>>();

    ptr_offset_args->push_back(make_shared<Arg>("_ptr", Struct::Ptr));
    ptr_offset_args->push_back(make_shared<Arg>("_offs", Int::INT));

    return make_unique<Definition>("ptr_offset", Struct::Ptr, std::move(ptr_offset_args), std::move(mkptr));

}

static inline unique_ptr<Definition> make_bool_to_int(void) {
/*
        bool_to_int = Definition("bool_to_int", Int(), [Arg("_b", Bool())],
                                 If(Symbol("_b", Bool()), IntConst(1), IntConst(0)))
*/
    auto bool_to_int_args = make_unique<vector<shared_ptr<Arg>>>();

    bool_to_int_args->push_back(make_shared<Arg>("_b", Bool::BOOL));

    auto if_cond = make_unique<Symbol>("_b", Bool::BOOL);
    auto if_then = make_unique<IntConst>(1);
    auto if_else = make_unique<IntConst>(0);

    auto if_ = make_unique<If>(std::move(if_cond), std::move(if_then), std::move(if_else));

    return make_unique<Definition>("bool_to_int", Int::INT, std::move(bool_to_int_args), std::move(if_));
}

Project::Project()
{
    add_struct(Struct::Ptr);
    add_indtype(Inductive::Nat);
    add_definition(make_ptr_offset(), make_shared<loc_t>(Project::LOC_GLOBALDEFS, "", ""));
    add_definition(make_bool_to_int(), make_shared<loc_t>(Project::LOC_GLOBALDEFS, "", ""));
}

static std::set<string> get_prim_dependencies(const vector<unique_ptr<IRLoader::IRInst>> &insts) {
    std::set<string> deps;

    for (const auto &inst: insts) {
        if (auto i = dynamic_cast<IRLoader::IIf*>(inst.get())) {
            deps.merge(get_prim_dependencies(*i->true_body));
            deps.merge(get_prim_dependencies(*i->false_body));
        } else if (auto i = dynamic_cast<IRLoader::ILoop*>(inst.get())) {
            deps.merge(get_prim_dependencies(*i->body));
        } else if (auto i = dynamic_cast<IRLoader::ICall*>(inst.get())) {
            if (auto v = dynamic_cast<IRLoader::VGlobal*>(i->func.get()))
                deps.insert(v->name);
        }
    }

    return deps;
}

void Project::finalize_project()
{
    std::set<string> loaded, deps;
    shared_ptr<IRModule> module;

    // XXX: currently we only support one LAYER_CODE for all layers
    for (auto &L: this->layers) {
        if (L->code == "" || loaded.find(L->code) != loaded.end())
            continue;

        module = L->load_module();
        loaded.insert(L->code);
    }

    this->code = IRLoader::post_process(module);

    for (auto it = this->layers.rbegin(); it != this->layers.rend() - 1; it++) {
        auto &L = *it;

        for (auto &p: L->prims) {
            if (deps.find(p) != deps.end())
                deps.erase(p);
        }
        L->passthrough = vector<string>(deps.begin(), deps.end());

        for (auto &p: L->prims) {
            if (this->code->functions->find(p) == this->code->functions->end())
                continue;

            if (this->code->functions->at(p)->body == nullptr)
                continue;

            for (auto &d: get_prim_dependencies(*this->code->functions->at(p)->body))
                deps.insert(d);
        }
    }

    deps.insert(this->layers[0]->prims.begin(), this->layers[0]->prims.end());
    this->layers[0]->prims.assign(deps.begin(), deps.end());

}

}; // namespace autov