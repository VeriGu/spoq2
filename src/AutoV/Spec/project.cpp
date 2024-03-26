#include <project.h>
#include <iostream>
#include <post_process.h>
#include <ir2spec.h>
#include <regex>
#include <rules.h>
#include <projection.h>
#include <chrono>

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
    symbols[name] = SymbolInfo{kind, info, *loc, symbols.size()};
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
    if (std::holds_alternative<string>(cmd->op)) {
        string op_str = std::get<string>(cmd->op);

        if (op_str == "Unfold") {
            assert(cmd->elems->size() == 1 && dynamic_cast<Symbol *>(cmd->elems->at(0).get()));
            auto s = dynamic_cast<Symbol *>(cmd->elems->at(0).get());
            this->cmds.Unfold.insert(s->text);
        } else if (op_str == "NoUnfold") {
            assert(cmd->elems->size() == 1 && dynamic_cast<Symbol *>(cmd->elems->at(0).get()));
            auto s = dynamic_cast<Symbol *>(cmd->elems->at(0).get());
            this->cmds.NoUnfold.insert(s->text);
        } else if (op_str == "NoTrans") {
            assert(cmd->elems->size() == 1 && dynamic_cast<Symbol *>(cmd->elems->at(0).get()));
            auto s = dynamic_cast<Symbol *>(cmd->elems->at(0).get());
            this->cmds.NoTrans.insert(s->text);
        } else if (op_str == "InitRely") {
            assert(cmd->elems->size() == 2 && dynamic_cast<Symbol *>(cmd->elems->at(0).get()) &&
                   dynamic_cast<Expr *>(cmd->elems->at(1).get()));
            auto s = dynamic_cast<Symbol *>(cmd->elems->at(0).get());
            auto expr = dynamic_cast<Expr *>(cmd->elems->at(1).get());

            cmd->elems->at(1).release();
            this->cmds.InitRely[s->text].push_back(unique_ptr<Expr>(expr));
        } else if (op_str == "Axiom") {
            auto expr = dynamic_cast<Expr *>(cmd->elems->at(0).get());
            assert(cmd->elems->size() == 1);
            cmd->elems->at(0).release();
            this->axioms.push_back(unique_ptr<Expr>(expr));
        } else {
            LOG_WARNING << "Unknown command " << op_str;
        }
    } else {
        LOG_WARNING << "Unknown command" << string(*cmd);
    }
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

std::set<string> Project::calc_dependencies(SpecNode *expr) {
    std::set<string> deps;

    if (auto i = instance_of(expr, If)) {
        deps.merge(calc_dependencies(i->cond.get()));
        deps.merge(calc_dependencies(i->then_body.get()));
        deps.merge(calc_dependencies(i->else_body.get()));
    } else if (auto m = instance_of(expr, Match)) {
        deps.merge(calc_dependencies(m->src.get()));

        for (auto &match: *m->match_list)
            deps.merge(calc_dependencies(match->body.get()));
    } else if (auto ra = instance_of(expr, RelyAnno)) {
        deps.merge(calc_dependencies(ra->prop.get()));
        deps.merge(calc_dependencies(ra->body.get()));
    } else if (auto wa = instance_of(expr, ForallExists)) {
        deps.merge(calc_dependencies(wa->body.get()));
    } else if (auto e = instance_of(expr, Expr)) {
        for (auto &elem: *e->elems)
            deps.merge(calc_dependencies(elem.get()));
        if (auto op = std::get_if<unique_ptr<SpecNode>>(&e->op))
            deps.merge(calc_dependencies(op->get()));
    } else if (auto s = instance_of(expr, Symbol)) {
        auto text = s->text;

        if (this->symbols.find(text) != this->symbols.end()) {
            auto &info = this->symbols.at(text);

            if (info.kind == SymbolKind::Def || info.kind == SymbolKind::Decl)
                deps.insert(text);
        }
    }

    return deps;
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

static std::tuple<string, vector<Definition *> *, vector<unique_ptr<Definition>> *>
infer_spec_task(Project *proj, int layer_id, string fname) {
    auto &L = proj->layers[layer_id];
    vector<Definition *> *low_specs;
    string low_name = fname + "_spec_low";
    std::unordered_map<string, string> name_map;
    bool have_loop;

    if (proj->code->functions->find(fname) != proj->code->functions->end()) {
        if (proj->defs.find(low_name) == proj->defs.end()) {
            string suffix = "_low";
            low_specs = ir_to_spec(proj, fname, L.get(), suffix);

            for (auto &def: *low_specs) {
                LOG_INFO << "Add definition " << def->name;
                proj->deps[fname] = proj->calc_dependencies(def->body.get());
                proj->add_definition(unique_ptr<Definition>(def), make_shared<loc_t>(L->name, fname, Project::LOC_LOWSPEC));

                if (def->name.rfind(suffix) == def->name.size() - suffix.size()) {
                    std::string high_name = def->name.substr(0, def->name.size() - suffix.size());
                    name_map[def->name] = high_name;
                }

                if (is_instance(def, Fixpoint))
                    have_loop = true;
            }
        } else {
            auto func = proj->code->functions->at(fname);
            std::regex pattern(fname + "_loop\\d+_low");

            func->types = make_unique<unordered_map<string, shared_ptr<SpecType>>>();
            func->types->emplace("st", L->abs_data);
            analyze_types(func->body.get(), func->types.get());

            low_specs = new vector<Definition *>();

            for (auto& pair : proj->defs) {
                const std::string& spec_name = pair.first;
                if (spec_name == fname + "_spec_low" || std::regex_match(spec_name, pattern)) {
                    low_specs->push_back(pair.second.get());
                }
            }
        }
    } else {
        throw std::runtime_error("Function " + fname + " not found");
    }

    for (auto &def: *low_specs) {
        // If the high spec is provided, skip
        if (proj->defs.find(name_map[def->name]) != proj->defs.end())
            continue;

        auto high_name = name_map[def->name];
        unique_ptr<SpecNode> high_body = def->body->deep_copy();

        if (have_loop) {
            auto [new_high, __changed] = replace_spec_name(proj, high_body.release(), name_map);

            high_body.reset(new_high);
        }

        auto high_args = make_unique<vector<shared_ptr<Arg>>>();
        for (auto &arg: *def->args)
            high_args->push_back(arg);

        auto high_def = new Definition(high_name, proj->defs[def->name]->rettype, std::move(high_args), std::move(high_body));

        // if (high_name == "__granule_refcount_dec_spec")
        //     std::cout << "Transforming: " << high_name << std::endl;
        spec_transformer(proj, high_def);
        std::cout << "Transformed: " << std::endl << string(*high_def) << std::endl;
        proj->deps[high_name] = proj->calc_dependencies(high_def->body.get());
        proj->add_definition(unique_ptr<Definition>(high_def), make_shared<loc_t>(L->name, Project::LOC_SPEC, ""));

    }

    return std::make_tuple(fname, low_specs, nullptr);
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

    // auto new_store_RData = new Definition(*this->defs["store_RData"]);
    // spec_transformer(this, new_store_RData);
    // std::cout << "new_store_RData:\n" << string(*new_store_RData) << std::endl;

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

    for (int i = 1; i < this->layers.size(); i++) {
        auto &L = this->layers[i];

        for (auto &p: L->prims) {
            if (this->code->functions->at(p)->body == nullptr)
                continue;

            auto [fname, low_specs, high_specs] = infer_spec_task(this, i, p);
#if 0
            std::string filename = "./low_test/" + fname + "Low.v";

            std::remove(filename.c_str());

            for (auto &low_spec: *low_specs) {
                std::ofstream file(filename, std::ios::app);

                if (!file) {
                    throw std::runtime_error("Failed to open file " + filename);
                }

                file << string(*low_spec) << std::endl;

                if (!file) {
                    throw std::runtime_error("Failed to write to file " + filename);
                }

                file.close();

                std::cout << "Inferred: " << filename << std::endl;
            }
#endif
        }
    }

    extern unsigned long z3_unknowns, z3_checks;
    extern std::chrono::duration<double> z3_accumulative_time;

    LOG_INFO << "Z3 unknowns: " << z3_unknowns << "/" << z3_checks << std::endl;
    LOG_INFO << "Z3 accumulative time: " << z3_accumulative_time.count() << " (s)";

}

}; // namespace autov