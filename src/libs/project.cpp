#include <memory>
#include <project.h>
#include <iostream>
#include <post_process.h>
#include <ir2spec.h>
#include <regex>
#include <rules.h>
#include <projection.h>
#include <chrono>
#include <cmd.h>
#include <symbolic.h>
#include <z3_rules.h>
#include <tuple>
#include <cmd.h>
#include "SpoqIR.h"
#include "SpoqIRModule.h"
#include "log.h"
#include "nodes.h"

//#define MT_TRANSFORM
#include <type_inference.h>
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
/** Auto-proof layers */
const string Project::INV_LAYER = "Invariants";
const string Project::LEMMA_LAYER = "Lemmas";
const string Project::RELATE_LAYER = "Relations";


void Project::add_sys_inv(string name, unique_ptr<SpecNode> inv) {
    //Expr* invexpr = instance_of(invelem, Expr);
    sys_invs[name] = std::move(inv);
    sys_inv_order[sys_inv_order.size()] = name;
}

void Project::add_symbol(string name, SymbolKind kind, string info, shared_ptr<loc_t> loc)
{
    // std::cout << "Adding symbol " << name << ", loc: " << std::get<0>(*loc) << ", " << std::get<1>(*loc) << ", " << std::get<2>(*loc) << std::endl;
    symbols[name] = SymbolInfo{kind, info, *loc, symbols.size()};
}

void Project::add_symbol(string name, SymbolKind kind, string info, shared_ptr<loc_t> loc, unsigned long order)
{
    // std::cout << "Adding symbol " << name << ", loc: " << std::get<0>(*loc) << ", " << std::get<1>(*loc) << ", " << std::get<2>(*loc) << std::endl;
    symbols[name] = SymbolInfo{kind, info, *loc, order};
}

// TODO: to remove
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

    // LOG_DEBUG << "Adding definition " << name;
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

    // LOG_DEBUG << "name: " << defs[name]->name;
    this->add_symbol(defs[name]->name, SymbolKind::Def, "", loc);

    // LOG_DEBUG << "Adding definition " << name;
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
        //Expr* invexpr = instance_of(invelem, Expr);
        loop_invs[name].push_back(unique_ptr<SpecNode>(invelem));
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
            // LOG_INFO << "STACKVAR:" << f->text << ":" << local_var->text << "->" << stack_var->text << "\n";
        } else if (op_str == "Abstract") {
            assert(cmd->elems->size() == 3 && dynamic_cast<Symbol *>(cmd->elems->at(0).get()) 
                   && dynamic_cast<Symbol *>(cmd->elems->at(1).get())
                   && dynamic_cast<Symbol *>(cmd->elems->at(2).get()) );
            auto func = dynamic_cast<Symbol *>(cmd->elems->at(0).get());
            auto arg = dynamic_cast<Symbol *>(cmd->elems->at(1).get());
            auto type = dynamic_cast<Symbol *>(cmd->elems->at(2).get());

            this->abs_var[func->text][arg->text] = type->text;
        } else if (op_str == "AbstractPattern") {
            assert(cmd->elems->size() == 2 && dynamic_cast<Symbol *>(cmd->elems->at(0).get()) 
                   && dynamic_cast<Symbol *>(cmd->elems->at(1).get()));

            this->abs_config.push_back(SpoqAbstraction());
            auto &abs = this->abs_config.back();
            abs.raw_spec_name = dynamic_cast<Symbol *>(cmd->elems->at(0).get())->text;
            abs.abs_spec_name = dynamic_cast<Symbol *>(cmd->elems->at(1).get())->text;
        } else if(op_str == "CheckInv"){
            //Check a primitive's invariant
            assert(cmd->elems->size() == 1 && dynamic_cast<Symbol *>(cmd->elems->at(0).get()));
            auto s = dynamic_cast<Symbol *>(cmd->elems->at(0).get());
            this->cmds.invs.insert(s->text);
        } else if(op_str == "Precondition") {
            //used for modular function precondition when doing z3 checking
            assert(cmd->elems->size() == 2 && dynamic_cast<Symbol *>(cmd->elems->at(0).get()) &&
                   dynamic_cast<SpecNode *>(cmd->elems->at(1).get()));
            auto s = dynamic_cast<Symbol *>(cmd->elems->at(0).get());
            auto expr = dynamic_cast<SpecNode *>(cmd->elems->at(1).get());

            cmd->elems->at(1).release();
            this->cmds.PreCond[s->text].push_back(unique_ptr<SpecNode>(expr));
        } else if(op_str == "Postcondition") {
            //used for modular function postcondition when doing z3 checking, automatically added when function checked by z3
            auto s1 = dynamic_cast<Symbol *>(cmd->elems->at(0).get());
            LOG_DEBUG << s1->text;
            assert(cmd->elems->size() == 2 && dynamic_cast<Symbol *>(cmd->elems->at(0).get()) &&
                   dynamic_cast<SpecNode *>(cmd->elems->at(1).get()));
            auto s = dynamic_cast<Symbol *>(cmd->elems->at(0).get());
            auto expr = dynamic_cast<SpecNode *>(cmd->elems->at(1).get());

            cmd->elems->at(1).release();
            this->cmds.PostCond[s->text].push_back(unique_ptr<SpecNode>(expr));
        } else if(op_str == "Preserve"){
            assert(cmd->elems->size() == 1 && dynamic_cast<Symbol *>(cmd->elems->at(0).get()));
            auto s = dynamic_cast<Symbol *>(cmd->elems->at(0).get());
            this->cmds.PreserveInv.insert(s->text);
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

bool Project::is_state_type(shared_ptr<SpecType> t) {
    return t == layers[0]->abs_data;
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
    : rules(this)
{
    add_struct(Struct::Ptr);
    add_indtype(Inductive::Nat);
    add_definition(make_ptr_offset(), make_shared<loc_t>(Project::LOC_GLOBALDEFS, "", ""));
    add_definition(make_bool_to_int(), make_shared<loc_t>(Project::LOC_GLOBALDEFS, "", ""));

}

// TODO: fix raw pointer of expr
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
        auto subs_defs_low = new vector<Definition*>();
        for (auto &def: *low_specs) {
            LOG_INFO << "Generate low definition " << def->name << ", Fixpoint: " << is_instance(def, Fixpoint) << std::endl;
            std::cout << string(*def) << std::endl;
            proj->deps[def->name] = proj->calc_dependencies(def->body.get());

            auto loc = make_shared<loc_t>(L->name, fname, Project::LOC_LOWSPEC);

            if (is_instance(def, Fixpoint)) {
                proj->add_definition(unique_ptr<Fixpoint>(static_cast<Fixpoint *>(def)), loc);
            } else
                proj->add_definition(unique_ptr<Definition>(def), loc);

            profile_clear();
            if(OPTS.new_trans) {
                spec_transformer_v2(proj, def, layer_id, false, true);
            } else {
                spec_transformer(proj, def, layer_id, false, true);
            }
            if(!def->body) {
                LOG_ERROR << "def is null";
            }
            profile_finalize();
            profile_print();


            if (OPTS.conditional_spec) {
                auto subs_defs = new vector<Definition*>();
                if(!is_instance(def, Fixpoint)) {
                    LOG_WARNING << "Clean-version conditional spec is not supported for now";
                    // rule_conditional_spec(proj, def, subs_defs);
                }


                for(auto sub_def : * subs_defs) {
                    proj->symbols[def->name].order = proj->symbols[sub_def->name].order + 1;
                    auto sub_name = sub_def->name;
                    LOG_DEBUG << "sub_name: " << sub_name;
                    auto high_name = sub_name.substr(0, sub_name.size() - 4);
                    subs_defs_low->push_back(sub_def);
                    //proj->add_definition(unique_ptr<Definition>(sub_def), loc);
                    //proj->update_symbol_loc(sub_name, make_shared<loc_t>(L->name, fname, Project::LOC_LOWSPEC));
                    name_map[sub_name] = high_name;
                }
            }


            if (def->name.rfind(suffix) == def->name.size() - suffix.size()) {
                std::string high_name = def->name.substr(0, def->name.size() - suffix.size());
                name_map[def->name] = high_name;
            }

            if (is_instance(def, Fixpoint))
                have_loop = true;
        }
        for(auto sub : *subs_defs_low) {
            low_specs->push_back(sub);
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
        LOG_DEBUG << "low_name:" << low_name;
        auto high_name = name_map[low_name];

        // If the high spec is provided, skip
        if (proj->defs.find(high_name) != proj->defs.end()) {
            auto _def = proj->defs[high_name].get();
            LOG_DEBUG << "High_name: " << high_name;
            proj->deps[high_name] = proj->calc_dependencies(_def->body.get());
            LOG_DEBUG << "proj.deps size :" << proj->deps[high_name].size();

            proj->deps[high_name] = proj->calc_dependencies(_def->body.get());

            if (_def->body) {
                if(_def->deleyed_type_inference) {
                    _def->infer_type(*proj);
                }
                LOG_INFO << "Provided: " << high_name << std::endl;
                proj->update_symbol_loc(high_name, make_shared<loc_t>(L->name, Project::LOC_SPEC, ""));
                continue;
            }
        }
        if (low_def->deleyed_type_inference) {
            low_def->infer_type(*proj);
            low_def->deleyed_type_inference = false;
        }
        // High spec begins from the low spec
        unique_ptr<SpecNode> high_body = low_def->body->deep_copy();

        if (have_loop || have_sub) {
            auto [new_high, __changed] = proj->rules.replace_spec_name(std::move(high_body), name_map);
            high_body = std::move(new_high);
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
        
        profile_clear();
        if (!no_trans) {
            if(OPTS.new_trans) {
                spec_transformer_v2(proj, high_def, layer_id, layer_id, true);
            } else {
                spec_transformer(proj, high_def, layer_id, layer_id, true);
            }
            std::cout << "Transformed: " << std::endl << string(*high_def) << std::endl;
        } else {
            LOG_INFO << "No transformation for " << high_name;
        }
        profile_print();
        profile_finalize();


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

static void collect_relations(Project *proj) {
    for (auto const &def: proj->defs) {
        if (!is_relation_defs(proj, def.first) && !is_sec_relation_defs(proj, def.first)) {
            continue;
        }
        if(is_relation_defs(proj, def.first)) {
            proj->relations.insert(def.first);
        } else {
            proj->sec_relations.insert(def.first);
        }
        auto rel_def = def.second.get();

        Definition *pure_rel = nullptr;
        auto l_args = make_unique<vector<shared_ptr<Arg>>>();
        for (auto &arg: *rel_def->args)
            l_args->push_back(arg);
        if (is_instance(rel_def, Fixpoint)) {
            throw std::runtime_error("[collect_relations] Fixpoint rel not supported for now\n");
        } else {
            pure_rel = new Definition(rel_def->name, rel_def->rettype, std::move(l_args),
                                      rel_def->body->deep_copy());
        }
        if (rel_def->deleyed_type_inference) {
            pure_rel->infer_type(*proj);
            rel_def->deleyed_type_inference = false;
        }
        spec_transformer(proj, pure_rel, 0, !is_instance(rel_def, Fixpoint), true);
        proj->defs[def.first].reset(pure_rel);
        std::cout << "Pure Relation: " << string(*(proj->defs[def.first])) << std::endl;
    }
}

static void collect_lemmas(Project *proj) {
    std::vector<string> invs;
    for (auto const &def: proj->defs) {
        if (is_invariant_defs(proj, def.first)) {
            invs.push_back(def.first);
            continue;
        }
        if (!is_lemma_defs(proj, def.first)) {
            continue;
        }
        proj->lemmas.insert(def.first);
        // Transform the lemma to unfolded 
        auto lemma_def = def.second.get();
        
        Definition *pure_lemma = nullptr;
        auto l_args = make_unique<vector<shared_ptr<Arg>>>();
        for (auto &arg: *lemma_def->args)
            l_args->push_back(arg);

        if (is_instance(lemma_def, Fixpoint)) {
            throw std::runtime_error("[collect_lemmas] Fixpoint lemma not supported for now\n");
        } else {
            pure_lemma = new Definition(lemma_def->name, lemma_def->rettype, std::move(l_args),
                                      lemma_def->body->deep_copy());
        }
        std::cout << "Pure Lemma: " << string(*pure_lemma) << std::endl;
        if (lemma_def->deleyed_type_inference) {
            std::cout << "Pure Lemma (infer_type): " << string(*pure_lemma) << std::endl;
            pure_lemma->infer_type(*proj);
            lemma_def->deleyed_type_inference = false;
        }
        profile_clear();
        spec_transformer(proj, pure_lemma, 0, !is_instance(lemma_def, Fixpoint), true);
        profile_finalize();
        profile_print();
        proj->defs[def.first].reset(pure_lemma);
        std::cout << "Pure Lemma (spec_transformer): " << string(*(proj->defs[def.first])) << std::endl;

    }
    /** TODO: support lemma selection command */
    for (auto const &inv: invs) {
        for (auto const &l : proj->lemmas) {
            proj->inv_lemmas[inv].insert(proj->defs[l].get());
        }
    }
}

void trans_inv(Project *proj) {
    auto known = make_shared<unordered_map<string, shared_ptr<SpecType>>>();
    (*known)["st"] = proj->layers.at(0)->abs_data;
    for(auto &[name, inv] : proj->sys_invs) {
        type_inference::infer_type(*proj, inv.get(), known, Bool::BOOL);
        auto new_node = spec_transformer_v2(proj, std::move(inv), 0, true, true);
        proj->sys_invs[name] = std::move(new_node);
    }
}

/**
 * @brief finalize the project
 * 
 */
void Project::finalize_project()
{
    std::set<string> loaded, deps;
    shared_ptr<IRModule> module;

    // Step1 : read the LLVM IR into Spoq

    // XXX: currently we only support one LAYER_CODE for all layers
    for (auto &L: this->layers) {
        if (L->code == "" || loaded.find(L->code) != loaded.end())
            continue;

        module = L->load_module();
        loaded.insert(L->code);
    }

    this->code = IRLoader::post_process(module);

    // Step2: reconstruct the control flow graph on LLVM IR

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
    collect_relations(this);
    collect_lemmas(this);
    trans_inv(this);

    for (int i = 0; i < this->layers.size(); i++) {
        if(this->layers[i]->name == "Bottom"){
            continue;
        }
        auto &L = this->layers[i];
        auto &prev_L = this->layers[i - 1];

        // Previously, if we manually gave high specs (and low specs) but delayed having their type inference done (due to low-level generated spec calls), they would never be inferred.
        // Now, before inferring the next layer, we check if there is a low/high spec in the previous layer that has not yet been inferred.
        // FIXME: Note that, if we define something other than 'prim_spec' and 'prim_spec_low', the mechanism here WOULD STILL FAIL.
        for (auto &p : prev_L->prims) {
            auto p_low = p + "_spec_low";
            auto p_high = p + "_spec";
            if (this->defs.find(p_low) != this->defs.end()) {
                if (this->defs[p_low]->deleyed_type_inference) {
                    this->defs[p_low]->infer_type(*this);
                }
            }
            if (this->defs.find(p_high) != this->defs.end()) {
                if (this->defs[p_high]->deleyed_type_inference) {
                    this->defs[p_high]->infer_type(*this);
                }
            }
        }

        for (auto &p: L->prims) {
            if (this->code->functions->find(p) == this->code->functions->end() ||
                this->code->functions->at(p)->body == nullptr)
                continue;

            auto [fname, low_specs, high_specs] = infer_spec_task(this, i, p);
        }
    }

    spec_prover(this);

    extern unsigned long z3_unknowns, z3_checks, z3_cache_hits, z3_global_hash_hit, z3_global_hash_total;
    extern std::chrono::duration<double> z3_accumulative_time;

    LOG_INFO << "Z3 unknowns: " << z3_unknowns << "/" << z3_checks << std::endl;
    LOG_INFO << "Z3 cache hits: " << z3_cache_hits << "/" << z3_checks << std::endl;
    LOG_INFO << "Z3 global hash hit: " << z3_global_hash_hit << "/" << z3_global_hash_total << std::endl;
    LOG_INFO << "Z3 accumulative time: " << z3_accumulative_time.count() << " (s)";

}


bool Project::finalize_project_v2() {

    LOG_DEBUG << "Finalizing project" << std::endl;

    if(!spoq_code.load_llvm_module(this->code_path)) return false;

    shared_ptr<SpecType> abs_data_type = nullptr;
    for (auto it = this->layers.begin(); it != this->layers.end(); it++) {
        auto &L = *it;
        if (L->abs_data == nullptr) {
            assert(abs_data_type != nullptr && "abs_data_type is not set nor can be inferred");
            L->abs_data = abs_data_type;
        } else {
            abs_data_type = L->abs_data;
        }
    }

    spoq_code.load_function_and_convert_all(this);
    // spoq_code.store_llvm_module();

    LOG_DEBUG << "LLVM IR read ok and coverted." << std::endl;

    prepare_abstraction();

    // Step2: reconstruct the control flow graph on LLVM IR
    std::set<string> deps;
    for (auto it = this->layers.rbegin(); it != this->layers.rend() - 1; it++) {
        auto &L = *it;

        for (auto &p: L->prims) {
            if (deps.find(p) != deps.end())
                deps.erase(p);
        }
        L->passthrough = vector<string>(deps.begin(), deps.end());

        for (auto &p: L->prims) {
            auto func = this->spoq_code.llvm_module->getFunction(p);
            if (func == nullptr || func->isDeclaration()) 
                continue;
            L->prim_deps[p] = SpoqIRModule::get_func_dependencies(func);

            if (this->cmds.AddDep.find(p) != this->cmds.AddDep.end()) {
                L->prim_deps[p].insert(this->cmds.AddDep[p].begin(), this->cmds.AddDep[p].end());
            }
            prim_deps[p] = L->prim_deps[p];
            for (auto &d: L->prim_deps[p])
                deps.insert(d);
        }
    }

    LOG_DEBUG << "pass through compute ok." << "\n";

    deps.insert(this->layers[0]->prims.begin(), this->layers[0]->prims.end());
    this->layers[0]->prims.assign(deps.begin(), deps.end());

    filter_only_trans(this);
    collect_relations(this);
    collect_lemmas(this);
    trans_inv(this);

    LOG_DEBUG << "filter and lemma ok" << "\n";
    LOG_DEBUG << "layer: " << this->layers.size() << "\n";
    
    for (int i = 1; i < this->layers.size(); i++) {
        auto &L = this->layers[i];
        auto &prev_L = this->layers[i - 1];

        // Previously, if we manually gave high specs (and low specs) but delayed having their type inference done (due to low-level generated spec calls), they would never be inferred.
        // Now, before inferring the next layer, we check if there is a low/high spec in the previous layer that has not yet been inferred.
        // FIXME: Note that, if we define something other than 'prim_spec' and 'prim_spec_low', the mechanism here WOULD STILL FAIL.
        for (auto &p : prev_L->prims) {
            auto p_low = p + "_spec_low";
            auto p_high = p + "_spec";
            if (this->defs.find(p_low) != this->defs.end()) {
                if (this->defs[p_low]->deleyed_type_inference) {
                    this->defs[p_low]->infer_type(*this);
                }
            }
            if (this->defs.find(p_high) != this->defs.end()) {
                if (this->defs[p_high]->deleyed_type_inference) {
                    this->defs[p_high]->infer_type(*this);
                }
            }
        }

        for (auto &p: L->prims) {
            auto func = this->spoq_code.llvm_module->getFunction(p);
            LOG_DEBUG << "primitive: " << p << "\n";
            if (func == nullptr || func->isDeclaration()) 
                continue;
            LOG_DEBUG << "primitive infer: " << p << "\n";

            auto [fname, low_specs, high_specs] = infer_spec_task_v2(this, i, p);
        }
    }

    LOG_DEBUG << "low spec ok" << "\n";

    auto start = std::chrono::high_resolution_clock::now();
    spec_prover(this);
    auto end = std::chrono::high_resolution_clock::now();
    auto proof_cost = std::chrono::duration_cast<std::chrono::duration<double>>(end - start);
    
    extern unsigned long z3_unknowns, z3_checks, z3_cache_hits, z3_global_hash_hit, z3_global_hash_total;
    extern std::chrono::duration<double> z3_accumulative_time;

    LOG_INFO << "Z3 unknowns: " << z3_unknowns << "/" << z3_checks << std::endl;
    LOG_INFO << "Z3 cache hits: " << z3_cache_hits << "/" << z3_checks << std::endl;
    LOG_INFO << "Z3 global hash hit: " << z3_global_hash_hit << "/" << z3_global_hash_total << std::endl;
    LOG_INFO << "Z3 accumulative time: " << z3_accumulative_time.count() << " (s)";
    LOG_INFO << "Automated verification time: " << proof_cost.count() << " (s)";
    return true;
}


std::tuple<string, vector<Definition *> *, vector<unique_ptr<Definition>> *>
Project::infer_spec_task_v2(Project* proj, int layer_id, string fname) {

    LOG_DEBUG << "Infer spec task: " << fname << std::endl;

    std::unordered_map<string, string> name_map; // low_name -> high_name
    bool have_loop = false, have_sub = false;

    vector<std::string> low_specs_name;
    bool ret = infer_low_spec_v2(proj, layer_id, fname, have_loop, have_sub, name_map, low_specs_name);
    if(!ret) {
        LOG_ERROR << "Failed to infer low spec for " << fname << std::endl;
        return std::make_tuple(fname, nullptr, nullptr);
    } else {
        LOG_DEBUG << "Infer low spec for " << fname << " ok" << std::endl;
    }

    // auto &L = proj->layers[layer_id];
    unsigned long symbol_order = proj->symbols.size();

    for (int i = 0; i < low_specs_name.size(); i++) {
        std::unique_ptr<Definition>& low_def = proj->defs[low_specs_name[i]];
        auto low_name = low_def->name;
        LOG_DEBUG << "low_name:" << low_name;
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
                proj->update_symbol_loc(high_name, make_shared<loc_t>(proj->layers[layer_id]->name, Project::LOC_SPEC, ""));
                continue;
            }
        }
        if (low_def->deleyed_type_inference) {
            low_def->infer_type(*proj);
            low_def->deleyed_type_inference = false;
        }
        // High spec begins from the low spec
        unique_ptr<SpecNode> high_body = low_def->body->deep_copy();

        if (have_loop || have_sub) {
            auto [new_high, __changed] = proj->rules.replace_spec_name(std::move(high_body), name_map);
            high_body = std::move(new_high);
        }

        auto high_args = make_unique<vector<shared_ptr<Arg>>>();
        for (auto &arg: *low_def->args)
            high_args->push_back(arg);

        Definition *high_def = nullptr;

        if (is_instance(low_def.get(), Fixpoint)) {
            // For Fixpoint, we need to add the definition in advance for z3_eval
            auto tmp_high_def = new Fixpoint(high_name, proj->defs[low_name]->rettype,
                                             make_unique<vector<shared_ptr<Arg>>>(*high_args));

            high_def = new Fixpoint(high_name, proj->defs[low_name]->rettype, std::move(high_args),
                                    std::move(high_body));
            proj->add_definition(unique_ptr<Fixpoint>(static_cast<Fixpoint *>(tmp_high_def)),
                                 make_shared<loc_t>(proj->layers[layer_id]->name, Project::LOC_SPEC, ""), i + symbol_order);
        } else {
            high_def = new Definition(high_name, proj->defs[low_name]->rettype, std::move(high_args),
                                      std::move(high_body));
        }

        // Transform the low spec to high spec
        bool no_trans = proj->cmds.NoHighSpec || proj->cmds.NoTrans.find(name_map[low_name]) != proj->cmds.NoTrans.end();

        LOG_DEBUG << "NO HIGH SPEC" << proj->cmds.NoHighSpec;
        
        profile_clear();
        if (!no_trans) {
            if(OPTS.new_trans) {
                spec_transformer_v2(proj, high_def, layer_id, layer_id, true);
            } else {
                spec_transformer(proj, high_def, layer_id, layer_id, true);
            }
            std::cout << "Transformed: " << std::endl << string(*high_def) << std::endl;
        } else {
            LOG_INFO << "No transformation for " << high_name;
        }
        profile_print();
        profile_finalize();

        //spec_prover(proj, high_def);

#ifndef MT_TRANSFORM
        proj->deps[high_name] = proj->calc_dependencies(high_def->body.get());
#endif
        if (is_instance(low_def.get(), Fixpoint))
            proj->add_definition(unique_ptr<Fixpoint>(static_cast<Fixpoint *>(high_def)),
                                 make_shared<loc_t>(proj->layers[layer_id]->name, Project::LOC_SPEC, ""), i + symbol_order);
        else
            proj->add_definition(unique_ptr<Definition>(high_def), make_shared<loc_t>(proj->layers[layer_id]->name, Project::LOC_SPEC, ""),
                                 i + symbol_order);

    }


    // return std::make_tuple(fname, low_specs, nullptr);
    return std::make_tuple(fname, nullptr, nullptr);
}

bool Project::infer_low_spec_v2(Project* proj, int layer_id, string fname, bool &have_loop,
                  bool &have_sub, std::unordered_map<string, string> &name_map,
                  std::vector<std::string>& low_specs) {

    auto low_name = fname + "_spec_low";
    if(proj->defs.find(low_name) == proj->defs.end()) {
        LOG_DEBUG << "low spec not found: " << low_name << "\n";
        std::string suffix = "_low";
        bool ret = proj->spoq_code.code_to_spec(proj, fname, layer_id, low_specs, name_map);
        if(!ret) { 
            LOG_ERROR << "fail to generate low spec for: " << fname << "\n";
            return false; 
        }
        auto subs_defs_low = new vector<Definition*>();
        for(auto &def_name: low_specs) {
            auto def = proj->defs[def_name].get();

            // spec transformer
            profile_clear();
            if(OPTS.new_trans) {
                spec_transformer_v2(proj, def, layer_id, false, true);
            } else {
                spec_transformer(proj, def, layer_id, false, true);
            }
            profile_finalize();
            profile_print();

            // conditional spec
            if (OPTS.conditional_spec) {
                auto subs_defs = new vector<Definition*>();
                if(!is_instance(def, Fixpoint)) {
                    LOG_WARNING << "Clean-version conditional spec is not supported for now";
                    // rule_conditional_spec(proj, def, subs_defs);
                }

                for(auto sub_def : * subs_defs) {
                    proj->symbols[def->name].order = proj->symbols[sub_def->name].order + 1;
                    auto sub_name = sub_def->name;
                    LOG_DEBUG << "sub_name: " << sub_name;
                    auto high_name = sub_name.substr(0, sub_name.size() - 4);
                    subs_defs_low->push_back(sub_def);
                    //proj->add_definition(unique_ptr<Definition>(sub_def), loc);
                    //proj->update_symbol_loc(sub_name, make_shared<loc_t>(L->name, fname, Project::LOC_LOWSPEC));
                    name_map[sub_name] = high_name;
                }
            }

            if (is_instance(def, Fixpoint))
                have_loop = true;
        }
        for(auto sub : *subs_defs_low) {
            low_specs.push_back(sub->name);
        }
        return true;
    } else {
        LOG_DEBUG << "low spec provided: " << low_name << "\n";
        // The name of the low spec may have three forms: `fname_loop\d+_low`,
        // `fname_\d+_low`, "fname_spec_low"
        std::regex pattern1(fname + "_loop_\\d+_low");
        std::regex pattern2(fname + "_\\d+_low");
        string low_name = fname + "_spec_low";

        unique_ptr<SpecNode> spec = std::move(proj->defs[low_name]->body);
        if(proj->cmds.InitRely.find(fname) != proj->cmds.InitRely.end()) {
            for(auto & f : proj->cmds.InitRely[fname])
                spec = std::make_unique<Rely>(f->deep_copy(), std::move(spec));
        }    
        proj->defs[low_name]->body = std::move(spec);

        // TODO: function types
        // auto func = this->code->functions->at(fname);
        // func->types = make_unique<unordered_map<string, shared_ptr<SpecType>>>();
        // func->types->emplace("st", this->layers[layer_id]->abs_data);
        // analyze_types(func->body.get(), func->types.get());

        // Since low spec might be provided and we don't know the name of the
        // low spec, we cannot directly get the spec Definition object from
        // `proj->defs`. Instead, we need to iterate through all the definitions
        // and check if the name matches the pattern.
        for (auto &spec_name : proj->def_order) {
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

                low_specs.push_back(spec_name);
                proj->symbols[spec_name].loc = std::make_tuple(proj->layers[layer_id]->name, fname, Project::LOC_LOWSPEC);

                name_map[spec_name] = high_name;
            }
        }
        return true;
    }
}

void Project::prepare_abstraction() {
    // TODO: complete the abstraction configruation and extract unique_ptr<Expr>
    
    for (auto &abs: this->abs_config) {
        auto& raw_def = this->defs[abs.raw_spec_name];
        assert(raw_def && "raw_def is null for abstraction");
        auto& abs_def = this->defs[abs.abs_spec_name];
        assert(abs_def && "abs_def is null for abstraction");

        if (auto expr = dynamic_cast<Expr*>(raw_def->body.get())) {
            abs.raw_expr = expr->deep_copy_down();
        } else {
            std::cout << "*raw_def: " << string(*raw_def) << std::endl;
            assert(false && "raw_def is not an Expr");
        }

        // abs.abs_expr = abs_def->body->deep_copy();
        if (auto expr = dynamic_cast<Expr*>(abs_def->body.get())) {
            abs.abs_expr = expr->deep_copy_down();
        } else {
            std::cout << "*abs_def: " << string(*abs_def) << std::endl;
            assert(false && "abs_def is not an Expr");
        }
        // TODO: support custom raw_core_name and abs_core_name
    }

    auto& context = this->spoq_code.llvm_module->getContext();
    std::regex arg_pattern(R"(arg_(\d+))");
    std::regex ret_pattern(R"(ret_(\d+))");
    for  (auto &pair: this->abs_var) {
        std::cout << "Function: " << pair.first << std::endl;
        auto func = spoq_code.llvm_module->getFunction(pair.first);
        if (func == nullptr || func->isDeclaration())  {
            std::cout << "[no function]Abstraction is not usedfor function: " << pair.first << std::endl;
            continue;
        }
        for(auto &var: pair.second) {
            std::smatch match;
            if (std::regex_match(var.first, match, arg_pattern)) {
                int number = std::stoi(match[1].str());
                if (func->arg_size() <= number) {
                    std::cout << "[arg number]Abstraction is not usedfor function: " << pair.first << " " << var.first << std::endl;
                    continue;
                }
            } else if (std::regex_match(var.first, match, ret_pattern)) {
                if (func->getReturnType()->isVoidTy()) {
                    std::cout << "[return type]Abstraction is not usedfor function: " << pair.first << " " << var.first << std::endl;
                    continue;
                }
            }
            llvm::MDString *meta_str = llvm::MDString::get(context, var.second);
            llvm::MDNode *meta_node = llvm::MDNode::get(context, meta_str);
            func->setMetadata(var.first, meta_node);
            LOG_DEBUG << "Abstraction: " << var.first << " " << var.second << " " << "[" << pair.first << "]" << std::endl;
        }
    }
}

}; // namespace autov