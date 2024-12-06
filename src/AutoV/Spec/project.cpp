#include <project.h>
#include <iostream>
#include <post_process.h>
#include <ir2spec.h>
#include <regex>
#include <rules.h>
#include <projection.h>
#include <chrono>
#include <z3_rules.h>
//#define MT_TRANSFORM
#ifdef MT_TRANSFORM
#include <unistd.h>
#include <sys/wait.h>
#include <cstring>
#include <parser.h>
#include <ext/stdio_filebuf.h>
#define READ_END 0
#define WRITE_END 1

#endif

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
const string Project::INV_LAYER = "Invariants";

void Project::add_symbol(string name, SymbolKind kind, string info, shared_ptr<loc_t> loc)
{
    std::cout << "Adding symbol " << name << ", loc: " << std::get<0>(*loc) << ", " << std::get<1>(*loc) << ", " << std::get<2>(*loc) << std::endl;
    symbols[name] = SymbolInfo{kind, info, *loc, symbols.size()};
}

void Project::add_symbol(string name, SymbolKind kind, string info, shared_ptr<loc_t> loc, unsigned long order)
{
    std::cout << "Adding symbol " << name << ", loc: " << std::get<0>(*loc) << ", " << std::get<1>(*loc) << ", " << std::get<2>(*loc) << std::endl;
    symbols[name] = SymbolInfo{kind, info, *loc, order};
}

void Project::update_symbol_loc(string name, shared_ptr<loc_t> loc)
{
    symbols[name].loc = *loc;
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
    this->add_indtype(ind, make_shared<loc_t>(Project::LOC_DATATYPES, "", ""));
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

void Project::add_definition(unique_ptr<Definition> def, shared_ptr<loc_t> loc, unsigned long order) {
    string &name = def->name;
    auto def_ = def.get();

    if (defs.find(name) == defs.end())
        def_order.push_back(name);

    defs[name] = std::move(def);
    this->add_symbol(defs[name]->name, SymbolKind::Def, "", loc, order);


    LOG_DEBUG << "Adding definition " << name;
    try {
        def_->infer_type(*this);
    } catch (std::exception &e) {
        LOG_DEBUG << "Failed to infer type for " << name << ": " << e.what() <<". Delaying inference." << std::endl;
        def_->deleyed_type_inference = true;
    }
}

void Project::add_definition(unique_ptr<Definition> def, shared_ptr<loc_t> loc) {
    string &name = def->name;
    auto def_ = def.get();

    if (defs.find(name) == defs.end())
        def_order.push_back(name);

    defs[name] = std::move(def);
    this->add_symbol(defs[name]->name, SymbolKind::Def, "", loc);

    LOG_DEBUG << "Adding definition " << name;
    try {
        def_->infer_type(*this);
    } catch (std::exception &e) {
        LOG_DEBUG << "Failed to infer type for " << name << ": " << e.what() <<". Delaying inference." << std::endl;
        def_->deleyed_type_inference = true;
    }
}

void Project::update_definition_body(Definition *def) {
    if (defs.find(def->name) == defs.end())
        throw std::runtime_error("update_definition_body: Definition " + def->name + " not found");

    auto old_def = defs[def->name].get();

    def->body = std::move(old_def->body);
}

void Project::add_layer(std::unique_ptr<Layer> layer) {
    layers.push_back(std::move(layer));
}


void Project::add_loop_inv(unique_ptr<Expr> inv) {
    if (std::holds_alternative<string>(inv->op)) {
        string name = std::get<string>(inv->op);
         LOG_DEBUG << "Add Loop inv name" + name;
         LOG_DEBUG << "Add Loop Inv:" + string(*inv);
        SpecNode* invelem = inv->elems->at(0).release();
        Expr* invexpr = instance_of(invelem, Expr);
        loop_invs[name] = unique_ptr<Expr>(invexpr);
    } else {
        LOG_WARNING << "Illegal Invariant format" << string(*inv);
    }
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
        } else if (op_str == "TrySplit") {
            assert(cmd->elems->size() == 1 && dynamic_cast<Symbol *>(cmd->elems->at(0).get()));
            auto s = dynamic_cast<Symbol *>(cmd->elems->at(0).get());
            this->cmds.TrySplit.insert(s->text);
        } else if (op_str == "InitRely") {
            assert(cmd->elems->size() == 2 && dynamic_cast<Symbol *>(cmd->elems->at(0).get()) &&
                   dynamic_cast<Expr *>(cmd->elems->at(1).get()));
            auto s = dynamic_cast<Symbol *>(cmd->elems->at(0).get());
            auto expr = dynamic_cast<Expr *>(cmd->elems->at(1).get());

            cmd->elems->at(1).release();
            this->cmds.InitRely[s->text].push_back(unique_ptr<Expr>(expr));
        } else if (op_str == "PostEnsure") {
            assert(cmd->elems->size() == 2 && dynamic_cast<Symbol *>(cmd->elems->at(0).get()) && 
                   dynamic_cast<Expr *>(cmd->elems->at(1).get()));
            auto s = dynamic_cast<Symbol *>(cmd->elems->at(0).get());
            auto expr = dynamic_cast<Expr *>(cmd->elems->at(1).get());
            /* The symbol in config might be mismatched with that in generated spec. 
                We need a symbol matching/renaming because we cannot require users to manually match it */
            
            /* We also assume the ensure statement takes no other variables other than return value. 
                e.g. v_0.(pbase) = "granule" 
                instead of : v_0.(poffset) = v_n + x_n */
            cmd->elems->at(1).release();
            this->cmds.PostEnsure[s->text].push_back(unique_ptr<Expr>(expr));
            
            LOG_INFO << "Adding PostEnsure: " << s->text << " " << string(*expr) << "\n";
        } else if (op_str == "AddDep") {
            assert(cmd->elems->size() == 2 && dynamic_cast<Symbol *>(cmd->elems->at(0).get()) &&
                   dynamic_cast<Symbol *>(cmd->elems->at(1).get()));
            auto s = dynamic_cast<Symbol *>(cmd->elems->at(0).get());
            auto d = dynamic_cast<Symbol *>(cmd->elems->at(1).get());

            this->cmds.AddDep[s->text].push_back(d->text);
        } else if (op_str == "Axiom") {
            auto expr = dynamic_cast<Expr *>(cmd->elems->at(0).get());
            assert(cmd->elems->size() == 1);
            cmd->elems->at(0).release();
            this->axioms.push_back(unique_ptr<Expr>(expr));
        } else if (op_str == "OnlyTrans") {
            assert(cmd->elems->size() == 1 && dynamic_cast<Symbol *>(cmd->elems->at(0).get()));
            auto s = dynamic_cast<Symbol *>(cmd->elems->at(0).get());
            this->cmds.OnlyTrans.insert(s->text);
        } else if (op_str == "NoUnfoldAll") {
            this->cmds.NoUnfoldAll = true;
        } else if (op_str == "NoHighSpec") {
            assert(cmd->elems->size() == 1 && dynamic_cast<Const *>(cmd->elems->at(0).get()));
            auto s = dynamic_cast<Const *>(cmd->elems->at(0).get());

            if (string(*s) == "true")
                this->cmds.NoHighSpec = true;
        } else if (op_str == "StackVar") {
            assert(cmd->elems->size() == 3 && dynamic_cast<Symbol *>(cmd->elems->at(0).get()) 
                   && dynamic_cast<Symbol *>(cmd->elems->at(1).get())
                   && dynamic_cast<Symbol *>(cmd->elems->at(2).get()) );

            auto f = dynamic_cast<Symbol *>(cmd->elems->at(0).get());
            auto local_var = dynamic_cast<Symbol *>(cmd->elems->at(1).get());
            auto stack_var = dynamic_cast<Symbol *>(cmd->elems->at(2).get());
            // in function `f`, the allocated local_var should point to the st.(stack).(stack_var)
            this->cmds.StackMap[f->text][local_var->text]  = stack_var->text;
            LOG_INFO << "STACKVAR:" << f->text << ":" << local_var->text << "->" << stack_var->text << "\n";
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

#if 0
    unordered_map<SymbolKind, string> kind_str = {
        {SymbolKind::Struct, "Struct"},
        {SymbolKind::StructElem, "StructElem"},
        {SymbolKind::StructConstr, "StructConstr"},
        {SymbolKind::IndType, "IndType"},
        {SymbolKind::IndConstructor, "IndConstructor"},
        {SymbolKind::TypeDef, "TypeDef"},
        {SymbolKind::Decl, "Decl"},
        {SymbolKind::Def, "Def"},
    };

    for (const auto &[name, info] : symbols) {
        LOG_INFO << "Symbol: " << name << " " << kind_str[info.kind] << " " << info.info;
    }

    exit(0);
#endif
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
        else if(auto op = std::get_if<string>(&e->op)) {
            deps.insert(*op);
        }
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

static vector<Definition *> *infer_low_spec(Project *proj, int layer_id, string fname, bool &have_loop, bool &have_sub,
                                            std::unordered_map<string, string> &name_map) {
    vector<Definition *> *low_specs = nullptr;
    string low_name = fname + "_spec_low";
     auto &L = proj->layers[layer_id];

    // =========================================================================
    // Generate/collect low specs
    // =========================================================================
    if (proj->defs.find(low_name) == proj->defs.end()) {
        // Generate low spec if not provided
        string suffix = "_low";
        low_specs = ir_to_spec(proj, fname, L.get(), suffix);

        for (auto &def: *low_specs) {
            LOG_INFO << "Generate low definition " << def->name << ", Fixpoint: " << is_instance(def, Fixpoint) << std::endl;
            std::cout << string(*def) << std::endl;
            proj->deps[def->name] = proj->calc_dependencies(def->body.get());

            auto loc = make_shared<loc_t>(L->name, fname, Project::LOC_LOWSPEC);

            if (is_instance(def, Fixpoint)) {
                proj->add_definition(unique_ptr<Fixpoint>(static_cast<Fixpoint *>(def)), loc);
            } else
                proj->add_definition(unique_ptr<Definition>(def), loc);

            spec_transformer(proj, def, layer_id, false, true);

            if (def->name.rfind(suffix) == def->name.size() - suffix.size()) {
                std::string high_name = def->name.substr(0, def->name.size() - suffix.size());
                name_map[def->name] = high_name;
            }

            if (is_instance(def, Fixpoint))
                have_loop = true;
        }
    } else {
        // Otherwise, the loop/sub/low spec is provided.
        auto func = proj->code->functions->at(fname);
        // The name of the low spec may have three forms: `fname_loop\d+_low`, `fname_\d+_low`, "fname_spec_low"
        std::regex pattern1(fname + "_loop\\d+_low");
        std::regex pattern2(fname + "_\\d+_low");
        string low_name = fname + "_spec_low";

        func->types = make_unique<unordered_map<string, shared_ptr<SpecType>>>();
        func->types->emplace("st", L->abs_data);
        analyze_types(func->body.get(), func->types.get());

        low_specs = new vector<Definition *>();

        // Since low spec might be provided and we don't know the name of the low spec, we cannot directly get the
        // spec Definition object from `proj->defs`. Instead, we need to iterate through all the definitions and
        // check if the name matches the pattern.
        for (auto &spec_name : proj->def_order) {
            auto &spec = proj->defs[spec_name];
            bool is_loop = false, is_sub = false;

            if (std::regex_match(spec_name, pattern1)) {
                is_loop = true;
                have_loop = true;
            } else if (std::regex_match(spec_name, pattern2)) {
                is_sub = true;
                have_sub = true;
            }

            if (spec_name == low_name || is_loop || is_sub) {
                auto high_name = spec_name.substr(0, spec_name.size() - 4);

                low_specs->push_back(spec.get());
                proj->update_symbol_loc(spec_name, make_shared<loc_t>(L->name, fname, Project::LOC_LOWSPEC));

                name_map[spec_name] = high_name;
            }
        }
    }

    return low_specs;
}

#ifdef MT_TRANSFORM
static bool collect_transformed_defs(Project *proj, std::set<string> &transformed,
                                     vector<pid_t> &children, unordered_map<pid_t, int[2]> &pipes,
                                     unordered_map<pid_t, std::tuple<string, int>> &tasks,
                                     bool nohang) {
    int status;
    pid_t pid = waitpid(-1, &status, nohang ? WNOHANG : 0);

    if (pid == -1) {
        LOG_ERROR << "waitpid() failed";
        exit(EXIT_FAILURE);
    } else if (pid == 0) {
        return false;
    }

    auto &task = tasks[pid];
    auto &fname = std::get<0>(task);
    int layer_id = std::get<1>(task);
    auto &_L = proj->layers[layer_id];

    if (WIFEXITED(status)) {
        if (WEXITSTATUS(status) != 0) {
            LOG_ERROR << "Child process " << fname << " exited with status " << WEXITSTATUS(status);
            exit(EXIT_FAILURE);
        }
    } else if (WIFSIGNALED(status)) {
        LOG_ERROR << "Child process " << fname << " killed by signal " << WTERMSIG(status);
        exit(EXIT_FAILURE);
    } else {
        LOG_ERROR << "Child process " << fname << " exited abnormally";
        exit(EXIT_FAILURE);
    }

    LOG_INFO << "Reading result for " << fname << std::endl;
    // Read from pipe
    FILE* stream = fdopen(pipes[pid][READ_END], "r");
    __gnu_cxx::stdio_filebuf<char> filebuf(stream, std::ios::in);
    std::istream is(&filebuf);
    std::stringstream ss;
    ss << is.rdbuf();

    string specs = ss.str();

    if (!specs.empty() && specs.back() == '\0') {
        specs.erase(specs.length() - 1);
    }

    auto defs = std::any_cast<vector<Definition *>>(parser::parse_light(proj, specs));

    // clean the pipe
    is.clear();
    fclose(stream);
    pipes.erase(pid);

    // Find the child in the vector and remove it
    auto it = std::find(children.begin(), children.end(), pid);
    if (it != children.end()) {
        children.erase(it);
    } else {
        LOG_ERROR << "Child not found";
    }

    for (auto def : defs) {
        // check if def->name ends with "_low"
        shared_ptr<loc_t> loc;

        if (def->name.rfind("_low") == def->name.size() - 4) {
            loc = make_shared<loc_t>(_L->name, fname, Project::LOC_LOWSPEC);
        } else {
            loc = make_shared<loc_t>(_L->name, Project::LOC_SPEC, "");
            proj->deps[def->name] = proj->calc_dependencies(def->body.get());
        }

        if (is_instance(def, Fixpoint))
            proj->add_definition(unique_ptr<Fixpoint>(static_cast<Fixpoint *>(def)), loc);
        else
            proj->add_definition(unique_ptr<Definition>(def), loc);

        transformed.insert(fname);
    }

    return true;
}
#endif

static void merge_keep(Project *proj, std::set<string> &to_keep, string fname) {
    // if (proj->code->functions->find(fname) == proj->code->functions->end())
    //     throw std::runtime_error("Function " + fname + " not found");

    to_keep.insert(fname);
    to_keep.insert(proj->prim_deps[fname].begin(), proj->prim_deps[fname].end());

    for (auto &dep : proj->prim_deps[fname]) {
        merge_keep(proj, to_keep, dep);
    }
}

static void filter_only_trans(Project *proj) {
    if (proj->cmds.OnlyTrans.empty())
        return;

    std::set<string> to_keep;

    // Insert functions in OnlyTrans and their deps to to_keep
    for (auto &fname: proj->cmds.OnlyTrans) {
        merge_keep(proj, to_keep, fname);
    }

    for (auto &keep: to_keep) {
        LOG_DEBUG << "Keeping " << keep;
    }

    // Remove functions not in to_keep from layer definitions
    for (int i = 1; i < proj->layers.size(); i++) {
        auto &L = proj->layers[i];

        for (auto it = L->prims.begin(); it != L->prims.end();) {
            if (to_keep.find(*it) == to_keep.end()) {
                it = L->prims.erase(it);
            } else {
                it++;
            }
        }
    }

    // Remove layers have no prims
    for (auto it = proj->layers.begin() + 1; it != proj->layers.end();) {
        if ((*it)->prims.empty()) {
            it = proj->layers.erase(it);
        } else {
            it++;
        }
    }

    // print remianing layers and prims
    for (int i = 1; i < proj->layers.size(); i++) {
        auto &L = proj->layers[i];

        LOG_DEBUG << "Layer " << L->name << " prims: ";
        for (auto &prim: L->prims) {
            LOG_DEBUG << prim << " ";
        }
    }
}

#ifndef MT_TRANSFORM
static std::tuple<string, vector<Definition *> *, vector<unique_ptr<Definition>> *>
#else
static string
#endif
infer_spec_task(Project *proj, int layer_id, string fname) {
    auto &L = proj->layers[layer_id];
    vector<Definition *> *low_specs;
    unsigned long symbol_order = proj->symbols.size();
#ifdef MT_TRANSFORM
    vector<Definition *> high_specs;
#endif
    string low_name = fname + "_spec_low";
    std::unordered_map<string, string> name_map; // low_name -> high_name
    bool have_loop = false, have_sub = false;

    if (proj->code->functions->find(fname) == proj->code->functions->end())
        throw std::runtime_error("Function " + fname + " not found");

    // =========================================================================
    // Generate/collect low specs
    // =========================================================================
    low_specs = infer_low_spec(proj, layer_id, fname, have_loop, have_sub, name_map);

    // =========================================================================
    // Generate high specs
    // =========================================================================
    for (int i = 0; i < low_specs->size(); i++) {
        auto &low_def = (*low_specs)[i];
        auto low_name = low_def->name;
        //LOG_DEBUG << "low_name:" << low_name;
        auto high_name = name_map[low_name];

        // If the high spec is provided, skip
        if (proj->defs.find(high_name) != proj->defs.end()) {
            auto _def = proj->defs[high_name].get();
            LOG_DEBUG << "High_name: " << high_name;
            proj->deps[high_name] = proj->calc_dependencies(_def->body.get());
            LOG_DEBUG << "proj.deps size :" << proj->deps[high_name].size();

            proj->deps[high_name] = proj->calc_dependencies(_def->body.get());

            if (_def->body) {
                LOG_INFO << "Provided: " << high_name << std::endl;
                proj->update_symbol_loc(high_name, make_shared<loc_t>(L->name, Project::LOC_SPEC, ""));
                continue;
            }
        }
        if (low_def->deleyed_type_inference)
            low_def->infer_type(*proj);
        // High spec begins from the low spec
        unique_ptr<SpecNode> high_body = low_def->body->deep_copy();

        if (have_loop || have_sub) {
            auto [new_high, __changed] = replace_spec_name(proj, high_body.release(), name_map);

            high_body.reset(new_high);
        }

        auto high_args = make_unique<vector<shared_ptr<Arg>>>();
        for (auto &arg: *low_def->args)
            high_args->push_back(arg);

        Definition *high_def = nullptr;

        if (is_instance(low_def, Fixpoint)) {
            // For Fixpoint, we need to add the definition in advance for z3_eval
            auto tmp_high_def = new Fixpoint(high_name, proj->defs[low_name]->rettype,
                                             make_unique<vector<shared_ptr<Arg>>>(*high_args));

            high_def = new Fixpoint(high_name, proj->defs[low_name]->rettype, std::move(high_args),
                                    std::move(high_body));
            proj->add_definition(unique_ptr<Fixpoint>(static_cast<Fixpoint *>(tmp_high_def)),
                                 make_shared<loc_t>(L->name, Project::LOC_SPEC, ""), i + symbol_order);
        } else {
            high_def = new Definition(high_name, proj->defs[low_name]->rettype, std::move(high_args),
                                      std::move(high_body));
        }

        // Transform the low spec to high spec
        bool no_trans = proj->cmds.NoHighSpec || proj->cmds.NoTrans.find(name_map[low_name]) != proj->cmds.NoTrans.end();

        LOG_DEBUG << "NO HIGH SPEC:" << proj->cmds.NoHighSpec;
        
        if (!no_trans) {
            spec_transformer(proj, high_def, layer_id, layer_id, true);
            std::cout << "Transformed: " << std::endl << string(*high_def) << std::endl;
        } else {
            LOG_INFO << "No transformation for " << high_name;
        }

#ifndef MT_TRANSFORM
        proj->deps[high_name] = proj->calc_dependencies(high_def->body.get());
#endif
        if (is_instance(low_def, Fixpoint))
            proj->add_definition(unique_ptr<Fixpoint>(static_cast<Fixpoint *>(high_def)),
                                 make_shared<loc_t>(L->name, Project::LOC_SPEC, ""), i + symbol_order);
        else
            proj->add_definition(unique_ptr<Definition>(high_def), make_shared<loc_t>(L->name, Project::LOC_SPEC, ""),
                                 i + symbol_order);


#ifdef MT_TRANSFORM
        // TODO: prim_spec is not passed back to the main process
        high_specs.push_back(high_def);
#endif
    }


#ifndef MT_TRANSFORM
    return std::make_tuple(fname, low_specs, nullptr);
#else
    string out;

    for (auto &def: *low_specs) {
        out += string(*def) + "\n";
    }

    for (auto &def: high_specs) {
        out += string(*def) + "\n";
    }

    return out;
#endif
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

            L->prim_deps[p] = get_prim_dependencies(*this->code->functions->at(p)->body);
            if (this->cmds.AddDep.find(p) != this->cmds.AddDep.end()) {
                L->prim_deps[p].insert(this->cmds.AddDep[p].begin(), this->cmds.AddDep[p].end());
            }
            prim_deps[p] = L->prim_deps[p];
            for (auto &d: L->prim_deps[p])
                deps.insert(d);
        }
    }

    deps.insert(this->layers[0]->prims.begin(), this->layers[0]->prims.end());
    this->layers[0]->prims.assign(deps.begin(), deps.end());

    filter_only_trans(this);

#ifndef MT_TRANSFORM
    for (int i = 0; i < this->layers.size(); i++) {
        if(this->layers[i]->name == "Bottom"){
            continue;
        }
        auto &L = this->layers[i];

        for (auto &p: L->prims) {
            if (this->code->functions->find(p) == this->code->functions->end() ||
                this->code->functions->at(p)->body == nullptr)
                continue;

            auto [fname, low_specs, high_specs] = infer_spec_task(this, i, p);
        }
    }

    //check loop invariant
    if(cmds.CheckLoopInv) {
        //check all the loops that have invariants provided.
        for(auto &[string,inv] : loop_invs) {
            if(defs.find(string) != defs.end()){
                auto def = defs[string].get();
                if(is_instance(def, Fixpoint) && check_loop_inv(this, def, inv.get())) {
                    LOG_DEBUG << "loop invariant: " << string << " is inductive :)";
                } else {
                    LOG_ERROR << "loop invariant: " << string << "is not inductive! :(";
                }
            } else {
                LOG_ERROR << "no loop named:" << string;
            }
        }
    }


    //check system invariant
    if(cmds.CheckInv) {
        
    }
#else
    std::set<string> transformed;

    for (auto &p: this->layers[0]->prims)
        transformed.insert(p);

#define NR_PROCS 8
    std::set<string> untransformed;
    vector<pid_t> children;
    unordered_map<pid_t, int[2]> pipes;
    unordered_map<pid_t, std::tuple<string, int>> tasks;

    for (int i = 1; i < this->layers.size(); i++) {
        auto &L = this->layers[i];

        for (auto &p: L->prims) {
            if (this->code->functions->find(p) == this->code->functions->end() ||
                this->code->functions->at(p)->body == nullptr) {
                transformed.insert(p);
                continue;
            }

            for (auto &p: L->prims) {
                untransformed.insert(p);
            }
        }
    }

    while (!untransformed.empty()) {
        for (int i = 1; i < this->layers.size(); i++) {
            auto &L = this->layers[i];

            for (auto &p: L->prims) {
                if (this->code->functions->find(p) == this->code->functions->end() ||
                    this->code->functions->at(p)->body == nullptr) {
                    transformed.insert(p);
                    untransformed.erase(p);
                    continue;
                }

                // If p is transformed, skip
                if (untransformed.find(p) == untransformed.end())
                    continue;

                // Check if all dependencies are transformed
                bool all_deps_transformed = true;

                // Collect the results
                for (int child_no = 0; child_no < children.size(); child_no++) {
                    bool succ = collect_transformed_defs(this, transformed, children, pipes, tasks, children.size() != NR_PROCS);

                    if (!succ)
                        break;
                }

                for (auto &d: L->prim_deps[p]) {
                    if (transformed.find(d) == transformed.end()) {
                        all_deps_transformed = false;
                        break;
                    }
                }

                if (!all_deps_transformed)
                    continue;

                // At this point, p is not transformed and all dependencies are transformed

                // Check if we can fork a new process
                if (children.size() < NR_PROCS) {
                    int pipefd[2];

                    if (pipe(pipefd) == -1) {
                        LOG_ERROR << "pipe() failed";
                        exit(EXIT_FAILURE);
                    }
                    LOG_INFO << "Current number of children: " << children.size() << std::endl;
                    for (auto &child: children) {
                        if (tasks.find(child) == tasks.end()) {
                            throw std::runtime_error("Child not found in the task map");
                        }

                        LOG_INFO << "Child: " << child << ", task: " << std::get<0>(tasks[child]);
                    }
                    pid_t pid = fork();

                    if (pid == 0) {
                        LOG_INFO << "Transforming start: " << p;
                        auto specs = infer_spec_task(this, i, p);
                        LOG_INFO << "Transforming finish: " << p;

                        write(pipefd[WRITE_END], specs.c_str(), specs.size() + 1);  // Write to pipe
                        close(pipefd[WRITE_END]);  // Close write end
                        close(pipefd[READ_END]);  // Close read end

                        exit(0);
                    } else if (pid > 0) {
                        untransformed.erase(p);
                        children.push_back(pid);
                        pipes[pid][READ_END] = pipefd[READ_END];
                        pipes[pid][WRITE_END] = pipefd[WRITE_END];
                        tasks[pid] = std::make_tuple(p, i);
                        close(pipefd[WRITE_END]);
                    } else {
                        throw std::runtime_error("fork() failed");
                    }
                }

                // Collect the results
                // for (int child_no = 0; child_no < children.size(); child_no++) {
                //     collect_transformed_defs(this, transformed, children, pipes, tasks, children.size() != NR_PROCS);
                // }
            }
        }
    }

    LOG_INFO << "Waiting for children to finish" << std::endl;

    while (!children.empty()) {
        collect_transformed_defs(this, transformed, children, pipes, tasks, false);
    }

#endif

    extern unsigned long z3_unknowns, z3_checks, z3_cache_hits, z3_global_hash_hit, z3_global_hash_total;
    extern std::chrono::duration<double> z3_accumulative_time;

    LOG_INFO << "Z3 unknowns: " << z3_unknowns << "/" << z3_checks << std::endl;
    LOG_INFO << "Z3 cache hits: " << z3_cache_hits << "/" << z3_checks << std::endl;
    LOG_INFO << "Z3 global hash hit: " << z3_global_hash_hit << "/" << z3_global_hash_total << std::endl;
    LOG_INFO << "Z3 accumulative time: " << z3_accumulative_time.count() << " (s)";

}

}; // namespace autov