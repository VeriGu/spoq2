#include <project.h>
#include <iostream>

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

    defs[name] = std::move(def);
    this->add_symbol(defs[name]->name, SymbolKind::Def, "", loc);
}

void Project::add_layer(std::unique_ptr<Layer> layer) {
    layers.push_back(std::move(layer));
}

void Project::add_command(unique_ptr<Expr> cmd) {
    // Implementation goes here
}

void Project::add_command(unique_ptr<Expr> cmd, unique_ptr<Layer> layer) {
}


Project::Project()
{
    add_struct(shared_ptr<Struct>(&Ptr, [](Struct*){}));
    add_indtype(shared_ptr<Inductive>(&Nat, [](Inductive*){}));
}

}; // namespace autov