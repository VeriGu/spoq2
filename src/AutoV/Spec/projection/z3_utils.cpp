#include <nodes.h>
#include <any>
#include <shortcuts.h>
#include <variant>
#include <unordered_set>
#include <log.h>
#include <boost/range/algorithm/set_algorithm.hpp>
#include <project.h>
#include <algorithm>
#include <boost/functional/hash.hpp>
#include <nodes.h>
#include <values.h>
#include <z3_rules.h>
#include <utils.h>
#include <chrono>
#include <rules.h>


namespace autov
{
using autov::Bool;
using autov::BoolConst;
using autov::Expr;
using autov::Function;
using autov::Int;
using autov::IntConst;
using autov::SpecType;
using autov::StringConst;
using autov::Struct;

using std::set;
using std::sort;

z3::solver Z3Solver = z3::solver(z3ctx);
z3::params Z3Params = z3::params(z3ctx);

unordered_map<size_t, Z3Result> Z3Cache;

size_t hash_unsigned_vector(const vector<unsigned> &v) {
    size_t hash = 0;
    for (const auto &i : v) {
        boost::hash_combine(hash, i);
    }
    return hash;
}

static size_t hash_z3_expr(z3::expr &e) {
    // Combine e.hash() and e.id()
    size_t hash = 0;
    boost::hash_combine(hash, e.hash());
    boost::hash_combine(hash, e.id());
    return hash;
}

size_t hash_z3_state(std::shared_ptr<EvalState> state, int timeout) {
    std::vector<unsigned> hashes;
    for (auto &c : *state->conds) {
        hashes.push_back(hash_z3_expr(c));
    }
    sort(hashes.begin(), hashes.end());
    hashes.push_back(timeout);
    return hash_unsigned_vector(hashes);
}

size_t hash_z3_state(std::shared_ptr<EvalState> state, z3::expr cond, int timeout) {
    std::vector<unsigned> hashes;
    for (auto &c : *state->conds) {
        hashes.push_back(hash_z3_expr(c));
    }
    sort(hashes.begin(), hashes.end());
    hashes.push_back(hash_z3_expr(cond));
    hashes.push_back(timeout);
    return hash_unsigned_vector(hashes);
}

int complexity(shared_ptr<SpecNode> spec) {
    return spec->length;
}

unsigned long z3_unknowns = 0;
unsigned long z3_checks = 0;
unsigned long z3_cache_hits = 0;
std::chrono::duration<double> z3_accumulative_time = std::chrono::duration<double>::zero();

// Defautl value of timeout is 50
Z3Result z3_check(shared_ptr<EvalState> state, z3::expr cond, int timeout, z3::model* ce) {
    auto start = std::chrono::high_resolution_clock::now();
    auto hash = hash_z3_state(state, cond, timeout);
    if (Z3Cache.find(hash) != Z3Cache.end()) {
        z3_cache_hits++;
        return Z3Cache[hash];
    }

    z3_checks++;

    Z3Params.set("timeout", (unsigned int)timeout);

    Z3Solver.set(Z3Params);

    Z3Solver.push();

    for (auto &c : *state->conds) {
        Z3Solver.add(c);
    }


    Z3Solver.push();
    //Z3Solver.add(!cond);
    z3::expr_vector not_cond_vec(z3ctx);
    not_cond_vec.push_back(!cond);
    auto not_res = Z3Solver.check(not_cond_vec);
    
    auto end = std::chrono::high_resolution_clock::now();
    z3_accumulative_time += std::chrono::duration_cast<std::chrono::duration<double>>(end - start);

    // std::cout << "-----------------Z3-----------------" << std::endl;
    // std::cout << "hash: " << hash << std::endl;
    // std::cout << "z3 check cond: " << cond << ", hash: " << cond.hash() << std::endl;
    // for (auto &c : *state->conds) {
    //     std::cout << "z3 check state conds: " << c << std::endl;
    // }
    // std::cout << "z3 check res: " << res << std::endl;
    // std::cout << "z3 check not_res: " << not_res << std::endl;
    // std::cout << "-----------------Z3-----------------" << std::endl;

    if (not_res == z3::unsat) {
        Z3Solver.pop();
        Z3Solver.pop();
        Z3Cache[hash] = Z3Result::True;
        return Z3Result::True;
    } else if (not_res == z3::sat) {
        //obtained the counter example
        auto model = Z3Solver.get_model();
        
        Z3Solver.pop();

        Z3Solver.push();
        Z3Solver.add(cond);
        auto res = Z3Solver.check();
        Z3Solver.pop();

        Z3Solver.pop();
        if(res == z3::unsat) {
            Z3Cache[hash] = Z3Result::False;
            return Z3Result::False;
        }
        return Z3Result::Sat;
    } else {
        Z3Solver.pop();
        Z3Solver.pop();
        Z3Cache[hash] = Z3Result::Unknown;
        z3_unknowns++;
        return Z3Result::Unknown;
    }
}

Z3Result z3_check(shared_ptr<EvalState> state, int timeout) {
    auto start = std::chrono::high_resolution_clock::now();
    auto hash = hash_z3_state(state, timeout);
    if (Z3Cache.find(hash) != Z3Cache.end()) {
        z3_cache_hits++;
        return Z3Cache[hash];
    }

    z3_checks++;

    Z3Params.set("timeout", (unsigned int)timeout);

    Z3Solver.set(Z3Params);

    Z3Solver.push();

    for (auto &c : *state->conds) {
        Z3Solver.add(c);
    }
    Z3Solver.push();
    auto res = Z3Solver.check();
    Z3Solver.pop();

    Z3Solver.pop();
    auto end = std::chrono::high_resolution_clock::now();
    z3_accumulative_time += std::chrono::duration_cast<std::chrono::duration<double>>(end - start);

    // std::cout << "-----------------Z3-----------------" << std::endl;
    // for (auto &c : *state->conds) {
    //     std::cout << "z3 check state conds: " << c << std::endl;
    // }
    // std::cout << "-----------------Z3-----------------" << std::endl;

    if (res == z3::unsat) {
        Z3Cache[hash] = Z3Result::False;
        return Z3Result::False;
    } else {
        Z3Cache[hash] = Z3Result::Unknown;
        z3_unknowns++;
        return Z3Result::Unknown;
    }
}

shared_ptr<SpecValue> resolve_pattern(Project* proj, SpecNode* val, SpecNode* pat, shared_ptr<SpecValue> src,
                                      unordered_map<string, shared_ptr<SpecValue>> &vars,
                                      unordered_map<string, shared_ptr<SpecValue>> &assigns)
{
    auto typ = src->get_type();
    if (auto sym = instance_of(pat, Symbol)) {
        if (proj->is_ind_constr(sym->text)) {
            return static_pointer_cast<Inductive>(typ)->construct(sym->text, {});
        } else {
            vars[sym->text] = typ->declare(sym->text, val->nid);
            assigns[sym->text] = src;
            return vars[sym->text];
        }
    } else if (auto con = instance_of(pat, Const)) {
        if (auto intc = std::get_if<unsigned long>(&con->value)) {
            return make_shared<IntValue>(*intc);
        } else if (auto boolc = std::get_if<bool>(&con->value)) {
            return make_shared<BoolValue>(*boolc);
        } else if (auto strc = std::get_if<string>(&con->value)) {
            return make_shared<StringValue>(*strc);
        }
    } else if (auto expr = instance_of(pat, Expr)) {
        if (op_eq(expr->op, Expr::Some)) {
            auto v = resolve_pattern(proj, val, expr->elems->at(0).get(), static_pointer_cast<IndValue>(src)->get("value"), vars, assigns);
            return static_pointer_cast<Inductive>(typ)->construct("Some", {v});
        } else if (op_eq(expr->op, Expr::Tuple)) {
            vector<shared_ptr<SpecValue>> elems;
            for (int i = 0; i < expr->elems->size(); i++)
            {
                elems.push_back(resolve_pattern(proj, val, expr->elems->at(i).get(), static_pointer_cast<StructValue>(src)->get(i), vars, assigns));
            }
            return static_pointer_cast<Struct>(typ)->construct(elems);
        } else if (op_eq(expr->op, Expr::CONCAT)) {
            auto head = resolve_pattern(proj, val, expr->elems->at(0).get(), static_pointer_cast<IndValue>(src)->get("head"), vars, assigns);
            auto tail = resolve_pattern(proj, val, expr->elems->at(1).get(), static_pointer_cast<IndValue>(src)->get("tail"), vars, assigns);
            return static_pointer_cast<Inductive>(typ)->construct("cons", {head, tail});
        } else if (op_eq(expr->op, Expr::None)) {
            auto t = dynamic_pointer_cast<Inductive>(src->get_type());

            return t->construct("None", {});
        } else if (std::holds_alternative<string>(expr->op)) {
            auto op = std::get<string>(expr->op);
            auto sym = proj->symbols.find(op);
            vector<shared_ptr<SpecValue>> args;

            if (sym != proj->symbols.end() && sym->second.kind == SymbolKind::IndConstructor) {
                auto ind_typ = static_pointer_cast<Inductive>(typ);

                for (int i = 0; i < ind_typ->constr.at(op)->size(); i++) {
                    auto &arg = ind_typ->constr.at(op)->at(i);
                    args.push_back(resolve_pattern(proj, val, expr->elems->at(i).get(),
                                                   static_pointer_cast<IndValue>(src)->get(arg->name), vars, assigns));
                }

                return ind_typ->construct(op, args);
            }
        } else {
            throw std::runtime_error("Unknown pattern(" + std::to_string(__LINE__) + "): " + string(*pat));
        }
    }

    throw std::runtime_error("Unknown pattern(" + std::to_string(__LINE__) + "): " + string(*pat));
}


//inv have only free variable st.
//state in inv and body can only be "st".
//forall v1,v2,... vk st, inv(st) /\ prim_body(v1,v2,...st) = (v1',v2'..st') -> inv(st')
bool check_invariant(Project* proj, Definition* prim, SpecNode* inv) {
    auto body = prim->body.get();
    auto args = prim->args.get();

    auto var = std::make_shared<unordered_map<string, shared_ptr<SpecValue>>>();
    auto conds = std::make_shared<vector<z3::expr>>();

    for (auto arg : *args) {
        (*var)[arg->name] = arg->type->declare(arg->name, 0); //current
        (*var)[arg->name + "'"] = arg->type->declare(arg->name + "'", 0); //after
    }

    //body have to be Some.
    auto eqelems = new vector<unique_ptr<SpecNode>>();
    eqelems->push_back(unique_ptr<SpecNode>(body));
    auto varelems = new vector<unique_ptr<SpecNode>>();
    for(auto arg : *args) {
        varelems->push_back(unique_ptr<SpecNode>(new Symbol(arg->name + "'")));
    }
    auto tupletype = instance_of(body->type.get(), Option)->elem_type;
    auto tuple = new Expr(Expr::ops::Tuple, unique_ptr<vector<unique_ptr<SpecNode>>>(varelems), tupletype);
    auto someelems = new vector<unique_ptr<SpecNode>>();
    someelems->push_back(unique_ptr<SpecNode>(tuple));

    eqelems->push_back(unique_ptr<SpecNode>(new Expr(Expr::ops::Some, unique_ptr<vector<unique_ptr<SpecNode>>>(someelems), body->type)));
    auto equa = new Expr(Expr::binops::EQUAL, unique_ptr<vector<unique_ptr<SpecNode>>>(eqelems));

    //the body and the inv share the same free variables.
    auto body_val = z3_eval(proj, equa, make_shared<EvalState>(
        
        make_shared<unordered_map<string, shared_ptr<SpecValue>>>(*var),
        make_shared<vector<z3::expr>>(*conds)));
    
    LOG_DEBUG << "Printing the Invariant: " << string(*inv);
    auto inv_before_val = z3_eval(proj, inv, make_shared<EvalState>(
        make_shared<unordered_map<string, shared_ptr<SpecValue>>>(*var), 
        make_shared<vector<z3::expr>>(*conds)));

    
    //substitute the st to st' in inv.
    SpecNode* after_inv = inv;
    bool succ = false;
    auto new_st = new Symbol("st'");
    after_inv = subst(after_inv, "st", new Symbol("st'"), succ);
    delete new_st; //since new_st is caller freed.
    LOG_DEBUG << "Printing the Invariant After: " << string(*after_inv);
    
    auto inv_after_val = z3_eval(proj, after_inv, make_shared<EvalState>(
        
        make_shared<unordered_map<string, shared_ptr<SpecValue>>>(*var),
        make_shared<vector<z3::expr>>(*conds)));
    
    
    auto state = make_shared<EvalState>(
        make_shared<unordered_map<string, shared_ptr<SpecValue>>>(*var), make_shared<vector<z3::expr>>(*conds));
    
    auto vc = z3::implies(body_val->get_z3_value() && inv_before_val->get_z3_value(), inv_after_val->get_z3_value());
    LOG_DEBUG << "Verification Condition: " << vc;
    //TODO: state also needs to add instantiated loop invariants.
    auto res = z3_check(state, vc, 20000);
    if(res == Z3Result::Unknown) {
        LOG_DEBUG << "solver return unknown when checking invariant for " << prim->name;
    } else if(res == Z3Result::Sat) {
        LOG_DEBUG << "solver return sat when checking invariant for " << prim->name;
    }
    return res == Z3Result::True;
}


//check the loop invariant is inductive or not
//the loop should be self-contained and have no function calls.
//inv(st) /\ N = 0 /\ st' = base_case(st) -> inv(st') //actually this step is always true, not necessary to check
//inv(st) /\ N > 0 /\ st' = loop_body(st) -> inv(st')
bool check_loop_inv(Project* proj, Definition *loop) {
    assert(proj->loop_invs.find(loop->name) != proj->loop_invs.end());
    std::vector<unique_ptr<SpecNode>>& invs = proj->loop_invs[loop->name];
    assert(instance_of(loop, Fixpoint));
    auto body = loop->body.get();
    auto args = loop->args.get();
    auto m = instance_of(body, Match);

    SpecNode* inv = new BoolConst(true);
    for(auto &in : invs) {
        auto elems = new vector<unique_ptr<SpecNode>>();
        elems->push_back(unique_ptr<SpecNode>(inv));
        elems->push_back(in->deep_copy());
        inv = new Expr(Expr::binops::AND, unique_ptr<vector<unique_ptr<SpecNode>>>(elems), Bool::BOOL);
    }

    //get the loop body
    auto base_case = m->match_list->at(0)->body.get();
    auto induct_body = m->match_list->back()->body.get();
    auto m2 = instance_of(induct_body, Match);
    
    auto loop_pattern = m2->match_list->at(0)->pattern.get();
    auto some_pat = instance_of(loop_pattern, Expr);
    auto tuple_pat = instance_of(some_pat->elems->at(0).get(), Expr);
    assert(op_eq(tuple_pat->op, Expr::ops::Tuple));

    auto loop_body = m2->match_list->at(0)->body.get();
    //subst the loop body with correct arguments
    for(int i = 0; i < tuple_pat->elems->size(); i++) {
        auto sym = instance_of(tuple_pat->elems->at(i).get(), Symbol);
        bool succ;
        auto newsym = new Symbol(args->at(i+1)->name, sym->type);
        loop_body = subst(loop_body->deep_copy().release(), sym->text, newsym, succ);
        delete newsym;
    }

    auto var = std::make_shared<unordered_map<string, shared_ptr<SpecValue>>>();
    auto conds = std::make_shared<vector<z3::expr>>();
    auto _N_ = Int::INT->declare(loop->args->at(0)->name, 0);
    //declare loop arguments
    for (auto arg : *args) {
        if (arg->name != "_N_") {
            (*var)[arg->name] = arg->type->declare(arg->name, 0); //current
        }
        if(arg->name == "st") {
            //(*var)[arg->name] = arg->type->declare(arg->name, 0); //current
            (*var)[arg->name + "_old"] = arg->type->declare(arg->name + "_old", 0); //initial
        }
    }
    //evaluate_inv_before
    auto inval_before = z3_eval(proj, inv, make_shared<EvalState>(var, conds));
    //evaluate_loop_body
    auto loop_body_val = z3_eval(proj, loop_body, make_shared<EvalState>(
        make_shared<unordered_map<string, shared_ptr<SpecValue>>>(*var), 
        std::make_shared<vector<z3::expr>>(*conds)));
    //evaluate base case
    auto base_case_val = z3_eval(proj, base_case, make_shared<EvalState>(
        make_shared<unordered_map<string, shared_ptr<SpecValue>>>(*var), 
        std::make_shared<vector<z3::expr>>(*conds)));

    auto rettype = loop->body->type;
    auto ret = instance_of(rettype.get(), Option);
    auto elems_type = ret->elem_type;
    auto tuple_type = instance_of(elems_type.get(), Tuple);
    auto tuple_elem_type = tuple_type->types;

    auto tuple_elems = make_unique<vector<unique_ptr<SpecNode>>>();
    for(int i = 1; i < args->size();i++) {
        tuple_elems->push_back(make_unique<Symbol>(args->at(i)->name + "'", tuple_elem_type->at(i-1)));
    }
    auto body_expr = new Expr(Expr::Tuple, std::move(tuple_elems), elems_type);
    auto option_elem = make_unique<vector<unique_ptr<SpecNode>>>();
    option_elem->push_back(unique_ptr<SpecNode>(body_expr));
    auto full_expr = new Expr(Expr::Some, std::move(option_elem), rettype); 
    LOG_DEBUG << "expr:" << string(*full_expr);

    auto full_val_var = make_shared<unordered_map<string, shared_ptr<SpecValue>>>(*var);
    

    for (auto arg : *args) {
        (*full_val_var)[arg->name + "'"] = arg->type->declare(arg->name + "'", 0);
    }
    
    auto full_val = z3_eval(proj, full_expr, 
    make_shared<EvalState>(
        full_val_var, 
        make_shared<vector<z3::expr>>(*conds)));

    SpecNode* after_inv = inv;
    //subst the loop body with correct arguments
    auto after_var = std::make_shared<unordered_map<string, shared_ptr<SpecValue>>>();
    for (auto arg : *args) {
        if (arg->name != "_N_") {
            (*after_var)[arg->name + "'"] = arg->type->declare(arg->name + "'", 0); //initial
        } 
        if(arg->name == "st") {
            //(*after_var)[arg->name + "'"] = arg->type->declare(arg->name + "'", 0); 
            (*after_var)[arg->name + "_old"] = arg->type->declare(arg->name + "_old", 0);
        }
    }

    for(auto arg : *loop->args) {
        auto sym = new Symbol(arg->name + "'", arg->type);
        bool succ;
        after_inv = subst(after_inv->deep_copy().release(), arg->name, sym, succ);
        delete sym;
    }
    //evaluate inv after
    auto inv_after = z3_eval(proj, after_inv, make_shared<EvalState>(
        after_var, 
        make_shared<vector<z3::expr>>(*conds)));
    

    //final expression, inv(a,b,c...) /\ spec(a,b,c) = a',b'c' => inv(a',b',c').
    //TODO: termination proof: ranking function(a,b,c) decreases every iteratiton.

    //auto n_invariant = Int::INT->declare("_N_",0)->get_z3_value() == (Int::INT->declare("_N_'",0)->get_z3_value() + 1);
    //auto n_invariant_base = Int::INT->declare("_N_",0)->get_z3_value() == (Int::INT->declare("_N_'",0)->get_z3_value());
    //auto n_eq0 = (_N_->get_z3_value() == 0);
    //auto n_gt0 = (_N_->get_z3_value() > 0);
    //auto vc_base = z3::implies(inval_before->get_z3_value() && n_eq0 && full_val->get_z3_value() == base_case_val->get_z3_value() && n_invariant_base, inv_after->get_z3_value());
    auto vc_induct = z3::implies(inval_before->get_z3_value() && full_val->get_z3_value() == loop_body_val->get_z3_value(), inv_after->get_z3_value());
    //LOG_DEBUG << "base_case query: " << vc_base;
    LOG_DEBUG << "inductive case query:" << vc_induct;

    Z3Params.set("timeout", (unsigned int)500);
    Z3Solver.set(Z3Params);
   //Z3Solver.push();
    // Z3Solver.add(!vc_base);
    // auto res = Z3Solver.check();
    // Z3Solver.pop();
    // if(res == z3::sat || res == z3::unknown) {
    //     LOG_DEBUG << "base case not able to decide: " << res;
    //     return false;
    // } 

    Z3Solver.push();
    Z3Solver.add(!vc_induct);
    auto res = Z3Solver.check();
    Z3Solver.pop();
    if(res == z3::sat || res == z3::unknown) {
        LOG_DEBUG << "inductive not able to decide: " << res;
        return false;
    }
    return res == z3::unsat;
}

//extract useful patterns in invariants to be triggers that when encountered, will instantiate the invariant.
//the quantifiers are integers in RMM.
//forall i, (st...granules @ i).(a) = b.
void extract_patterns_field(SpecNode* spec, set<string>& fields, set<string>& quantifiers) {
    if(auto expr = instance_of(spec, Expr)) {
        if(op_eq(expr->op, Expr::ops::GET)) {
            auto zmap = expr->elems->at(0).get();
            if(auto zmapexpr = instance_of(zmap, Expr)) {
                auto rec = instance_of(zmapexpr->elems->at(0).get(), Expr);
                auto index = instance_of(zmapexpr->elems->back().get(), Symbol);
                //the indices are quantified
                if(quantifiers.find(index->text) != quantifiers.end()) {
                    if(op_eq(zmapexpr->op, Expr::RecordGet)) {
                        //st.(a).(b) @ i
                        auto fieldnode = rec->elems->back().get();
                        auto fieldsym = instance_of(fieldnode, Symbol);
                        fields.insert(fieldsym->text);
                    } else if(op_eq(rec->op, Expr::RecordSet)) {
                        //(st.[a].[b] <: c) @ i
                        auto fieldnode = (rec->elems->end() - 1)->get();
                        auto fieldsym = instance_of(fieldnode, Symbol);
                        fields.insert(fieldsym->text);
                    }
                }
            }
            extract_patterns_field(expr->elems->at(0).get(), fields, quantifiers);
        } else {
            for(auto &elem : *expr->elems) {
                extract_patterns_field(elem.get(), fields, quantifiers);
            }
        }
    } else if(auto expr = instance_of(spec, If)) {
        extract_patterns_field(expr->cond.get(), fields, quantifiers);
        extract_patterns_field(expr->then_body.get(), fields, quantifiers);
        extract_patterns_field(expr->else_body.get(), fields, quantifiers);
    } else if(auto expr = instance_of(spec, RelyAnno)) {
        extract_patterns_field(expr->prop.get(), fields, quantifiers);
        extract_patterns_field(expr->body.get(), fields, quantifiers);
    } else if(auto expr = instance_of(spec, Match)) {
        extract_patterns_field(expr->src.get(), fields, quantifiers);
        for(auto &pm : *expr->match_list) {
            extract_patterns_field(pm->body.get(), fields, quantifiers);
        }
    } else if(auto expr = instance_of(spec, Symbol)) {
        //do nothing
    }
}

void pattern_matching(SpecNode* pattern, SpecNode* spec) {
    
}


//formulate all the loop invariant to the exprs as
//forall v1,v2,...vk,v1',v2'...vk', loop_spec(n, v1....vk,st) = Some (n', v1',v2',v3'....vk',st') -> invariant(v1',v2',....vk'，st',st)
SpecNode* formulate_loop_invariant(Project* proj, string fname) {
    auto &invs = proj->loop_invs[fname];
    auto def = proj->defs[fname].get();
    unique_ptr<vector<shared_ptr<Arg>>> vars = make_unique<vector<shared_ptr<Arg>>>();

    for(auto arg : *def->args) {
        vars->push_back(make_shared<Arg>(arg->name, arg->type));
        vars->push_back(make_shared<Arg>(arg->name + "'", arg->type));
    }
    

    auto lhselems = make_unique<vector<unique_ptr<SpecNode>>>();
    for(auto arg: *def->args) {
        lhselems->push_back(make_unique<Symbol>(arg->name));
    }


    auto lhsbody = new Expr(fname, std::move(lhselems));

    auto rhselems = make_unique<vector<unique_ptr<SpecNode>>>();
    int i = 0;
    for(auto arg: *def->args) {
        if(i != 0)
            rhselems->push_back(make_unique<Symbol>(arg->name + "'"));
        i++;
    }

    auto rhsbody = new Expr(Expr::ops::Some, std::move(rhselems));

    auto elems = make_unique<vector<unique_ptr<SpecNode>>>();
    elems->push_back(unique_ptr<SpecNode>(lhsbody));
    elems->push_back(unique_ptr<SpecNode>(rhsbody));
    auto eqbody = new Expr(Expr::binops::EQUAL, std::move(elems));


    SpecNode* aggreinv = new BoolConst(true);
    for(auto &inv : invs) {
        auto elems = new vector<unique_ptr<SpecNode>>();
        elems->push_back(unique_ptr<SpecNode>(aggreinv));
        elems->push_back(inv->deep_copy());
        aggreinv = new Expr(Expr::binops::AND, unique_ptr<vector<unique_ptr<SpecNode>>>(elems), Bool::BOOL);
    }

    auto bodyelems = new vector<unique_ptr<SpecNode>>();
    bodyelems->push_back(unique_ptr<SpecNode>(eqbody));
    bodyelems->push_back(unique_ptr<SpecNode>(aggreinv));
    auto expr = new Forall(std::move(vars), make_unique<Expr>(Expr::binops::IMPLIES, unique_ptr<vector<unique_ptr<SpecNode>>>(bodyelems)));


    return expr;
}


//state is path conditions relate to current value, state will be copied when going into if and rely
//vcs is global conditions instantiated to assume post conditions of loops.
void symbolic(Project* proj, SpecNode* val, shared_ptr<EvalState> state, vector<std::pair<shared_ptr<SpecValue>, shared_ptr<EvalState>>>& states) {
    //std::cout << "z3_eval: " << string(*val) << std::endl;

    auto _cache = [&](shared_ptr<SpecValue> return_val) {
        val->set_z3_eval(return_val);
        return return_val;
    };

    if (auto sym = instance_of(val, Symbol)) {
        if (sym->text != "None" && sym->text != "nil" && state->vars->find(sym->text) != state->vars->end()) {
            states.push_back(std::make_pair(_cache(state->vars->at(sym->text)), state));
        } else if (proj->defs.find(sym->text) != proj->defs.end()) {
            auto df = proj->defs[sym->text].get();
            assert(df->args->size() == 0);
            if (auto c = instance_of(df->body.get(), Const)) {
                return states.push_back(std::make_pair(_cache(z3_eval(proj, c, state)), state));
            }
        } else if (proj->decls.find(sym->text) != proj->decls.end()) {
            auto decl = proj->decls[sym->text].get();
            assert(!dynamic_pointer_cast<Function>(decl->type));
            states.push_back(std::make_pair(_cache(decl->absf()), state));
        } else if (proj->is_ind_constr(sym->text)) {
            states.push_back(std::make_pair(_cache(static_pointer_cast<Inductive>(sym->get_type())->construct(sym->text, {})), state));
        } else if (proj->symbols.find(sym->text) != proj->symbols.end() &&
                   proj->symbols[sym->text].kind == SymbolKind::StructElem) {
            states.push_back(std::make_pair(_cache(make_shared<StringValue>(sym->text)), state));
        } else {
            throw std::runtime_error("Unknown symbol: " + sym->text);
        }
    } else if (auto con = instance_of(val, Const)) {
        if (auto intc = std::get_if<unsigned long>(&con->value)) {
            states.push_back(std::make_pair(make_shared<IntValue>(*intc), state));
        } else if (auto boolc = std::get_if<bool>(&con->value)) {
            states.push_back(std::make_pair(make_shared<BoolValue>(*boolc), state));
        } else if (auto strc = std::get_if<string>(&con->value)) {
            states.push_back(std::make_pair(make_shared<StringValue>(*strc), state));
        }
    } else if (auto expr = instance_of(val, Expr)) {
        vector<shared_ptr<SpecValue>> elems;

        for (auto e = expr->elems->begin(); e != expr->elems->end(); e++) {
            elems.push_back(z3_eval(proj, e->get(), state));
        }

        if (op_eq(expr->op, Expr::None))
            states.push_back(std::make_pair(_cache(static_pointer_cast<Inductive>(val->get_type())->construct("None", {})),state));
        if (op_eq(expr->op, Expr::binops::ADD))
            states.push_back(std::make_pair(_cache(static_pointer_cast<IntValue>(elems[0])->add(static_pointer_cast<IntValue>(elems[1]))), state));
        if (op_eq(expr->op, Expr::binops::MINUS)) {
            if (expr->elems->size() == 2)
                  states.push_back(std::make_pair(_cache(static_pointer_cast<IntValue>(elems[0])->sub(static_pointer_cast<IntValue>(elems[1]))), state));
            else
                  states.push_back(std::make_pair(_cache(static_pointer_cast<IntValue>(elems[0])->neg()), state));
        }
        if (op_eq(expr->op, Expr::binops::MULT))
            states.push_back(std::make_pair(_cache(static_pointer_cast<IntValue>(elems[0])->mul(static_pointer_cast<IntValue>(elems[1]))), state));
        if (op_eq(expr->op, Expr::binops::DIV))
            states.push_back(std::make_pair(_cache(static_pointer_cast<IntValue>(elems[0])->div(static_pointer_cast<IntValue>(elems[1]))), state));
        if (op_eq(expr->op, Expr::binops::MOD))
            states.push_back(std::make_pair(_cache(static_pointer_cast<IntValue>(elems[0])->mod(static_pointer_cast<IntValue>(elems[1]))), state));
        if (op_eq(expr->op, Expr::binops::LSHIFT))
            states.push_back(std::make_pair(_cache(static_pointer_cast<IntValue>(elems[0])->shiftl(static_pointer_cast<IntValue>(elems[1]))), state));
        if (op_eq(expr->op, Expr::binops::RSHIFT))
            states.push_back(std::make_pair(_cache(static_pointer_cast<IntValue>(elems[0])->shiftr(static_pointer_cast<IntValue>(elems[1]))), state));
        if (op_eq(expr->op, Expr::binops::BITAND))
            states.push_back(std::make_pair(_cache(static_pointer_cast<IntValue>(elems[0])->land(static_pointer_cast<IntValue>(elems[1]))), state));
        if (op_eq(expr->op, Expr::binops::BITOR))
            states.push_back(std::make_pair(_cache(static_pointer_cast<IntValue>(elems[0])->lor(static_pointer_cast<IntValue>(elems[1]))), state));
        if (op_eq(expr->op, "Z.lxor"))
            states.push_back(std::make_pair(_cache(static_pointer_cast<IntValue>(elems[0])->lxor(static_pointer_cast<IntValue>(elems[1]))), state));
        if (op_eq(expr->op, "Z.lnot"))
            states.push_back(std::make_pair(_cache(static_pointer_cast<IntValue>(elems[0])->lnot()), state));
        if (op_eq(expr->op, "Z.testbit"))
            states.push_back(std::make_pair(_cache(static_pointer_cast<IntValue>(elems[0])->testbit(static_pointer_cast<IntValue>(elems[1]))), state));
        if (op_eq(expr->op, "Z.setbit"))
            states.push_back(std::make_pair(_cache(static_pointer_cast<IntValue>(elems[0])->setbit(static_pointer_cast<IntValue>(elems[1]))), state));
        if (op_eq(expr->op, "Z.clearbit"))
            states.push_back(std::make_pair(_cache(static_pointer_cast<IntValue>(elems[0])->clearbit(static_pointer_cast<IntValue>(elems[1]))), state));
        if (op_eq(expr->op, "Z.xorb"))
            states.push_back(std::make_pair(_cache(static_pointer_cast<IntValue>(elems[0])->xorb(static_pointer_cast<IntValue>(elems[1]))), state));
        if (op_eq(expr->op, Expr::binops::EQUAL))
            states.push_back(std::make_pair(_cache(Prop::PROP->from_z3_value((elems[0]->get_z3_value() == elems[1]->get_z3_value()).simplify())), state));
        if (op_eq(expr->op, Expr::binops::BEQ))
            states.push_back(std::make_pair(_cache(static_pointer_cast<IntValue>(elems[0])->eq(static_pointer_cast<IntValue>(elems[1]))), state));
        if (op_eq(expr->op, Expr::binops::SEQ))
            states.push_back(std::make_pair(_cache(static_pointer_cast<StringValue>(elems[0])->eq(static_pointer_cast<StringValue>(elems[1]))), state));
        if (op_eq(expr->op, Expr::binops::NOT_EQUAL))
            states.push_back(std::make_pair(_cache(Prop::PROP->from_z3_value(elems[0]->get_z3_value() != elems[1]->get_z3_value())), state));
        if (op_eq(expr->op, Expr::binops::BNE))
            states.push_back(std::make_pair(_cache(static_pointer_cast<IntValue>(elems[0])->ne(static_pointer_cast<IntValue>(elems[1]))), state));
        if (op_eq(expr->op, Expr::binops::SNE))
            states.push_back(std::make_pair(_cache(static_pointer_cast<StringValue>(elems[0])->ne(static_pointer_cast<StringValue>(elems[1]))), state));
        if (op_eq(expr->op, Expr::binops::GT) || op_eq(expr->op, Expr::binops::BGT))
            states.push_back(std::make_pair(_cache(static_pointer_cast<IntValue>(elems[0])->gt(static_pointer_cast<IntValue>(elems[1]))), state));
        if (op_eq(expr->op, Expr::binops::GTE) || op_eq(expr->op, Expr::binops::BGE))
            states.push_back(std::make_pair(_cache(static_pointer_cast<IntValue>(elems[0])->ge(static_pointer_cast<IntValue>(elems[1]))), state));
        if (op_eq(expr->op, Expr::binops::LT) || op_eq(expr->op, Expr::binops::BLT))
            states.push_back(std::make_pair(_cache(static_pointer_cast<IntValue>(elems[0])->lt(static_pointer_cast<IntValue>(elems[1]))), state));
        if (op_eq(expr->op, Expr::binops::LTE) || op_eq(expr->op, Expr::binops::BLE))
            states.push_back(std::make_pair(_cache(static_pointer_cast<IntValue>(elems[0])->le(static_pointer_cast<IntValue>(elems[1]))), state));
        if (op_eq(expr->op, Expr::ops::NOT) || op_eq(expr->op, Expr::ops::BNOT))
            states.push_back(std::make_pair(_cache(static_pointer_cast<BoolValue>(elems[0])->negb()), state));
        if (op_eq(expr->op, Expr::binops::AND) || op_eq(expr->op, Expr::binops::BAND))
            states.push_back(std::make_pair(_cache(static_pointer_cast<BoolValue>(elems[0])->andb(static_pointer_cast<BoolValue>(elems[1]))), state));
        if (op_eq(expr->op, Expr::binops::OR) || op_eq(expr->op, Expr::binops::BOR))
            states.push_back(std::make_pair(_cache(static_pointer_cast<BoolValue>(elems[0])->orb(static_pointer_cast<BoolValue>(elems[1]))), state));
        if (op_eq(expr->op, "xorb"))
            states.push_back(std::make_pair(_cache(static_pointer_cast<BoolValue>(elems[0])->xorb(static_pointer_cast<BoolValue>(elems[1]))), state));
        if (op_eq(expr->op, Expr::binops::IMPLIES))
            states.push_back(std::make_pair(_cache(static_pointer_cast<BoolValue>(elems[0])->implies(static_pointer_cast<BoolValue>(elems[1]))), state));
        else if (op_eq(expr->op, Expr::GET)) {
            if (auto e = instance_of(expr->elems->at(0).get(), Expr)) {
                if (op_eq(e->op, Expr::SET)) {
                    auto z3_res = z3_check(state, z3_eval(proj, e->elems->at(1).get(), state)->get_z3_value() == elems[1]->get_z3_value());
                    if (z3_res == Z3Result::True) {
                        vector<std::pair<shared_ptr<SpecValue>, shared_ptr<EvalState>>> retstates;
                        symbolic(proj, e->elems->at(2).get(), state, states);
                    } else if (z3_res == Z3Result::False) {
                        states.push_back(std::make_pair(_cache(static_pointer_cast<ZMapValue>(z3_eval(proj, e->elems->at(0).get(), state))->get(static_pointer_cast<IntValue>(elems[1]))), state));
                    }
                }
            }
            //std::cout << "expr: " << string(*expr) << std::endl;
            states.push_back(std::make_pair(_cache(static_pointer_cast<ZMapValue>(elems[0])->get(static_pointer_cast<IntValue>(elems[1]))), state));
        } else if (op_eq(expr->op, Expr::SET)) {
            if (auto e = instance_of(expr->elems->at(0).get(), Expr)) {
                if (op_eq(e->op, Expr::SET)) {
                    auto z3_res = z3_check(state, z3_eval(proj, e->elems->at(1).get(), state)->get_z3_value() == elems[1]->get_z3_value());
                    if (z3_res == Z3Result::True) {
                        elems[0] = z3_eval(proj, e->elems->at(0).get(), state);
                    }
                }
            }

            states.push_back(std::make_pair(_cache(static_pointer_cast<ZMapValue>(elems[0])->set(static_pointer_cast<IntValue>(elems[1]), elems[2])), state));
        } else if (op_eq(expr->op, Expr::RecordGet)) {
            // expr.elem[0]: record
            // expr.elem[1...n-2]: (sub)fields
            for (int i = 1; i < expr->elems->size(); i++) {
                elems[i] = static_pointer_cast<StructValue>(elems[i-1])->get(static_cast<Symbol *>(expr->elems->at(i).get())->text);
            }
            states.push_back(std::make_pair(_cache(elems.back()), state));
        } else if (op_eq(expr->op, Expr::RecordSet)) {
            // expr.elem[0]: record
            // expr.elem[1...n-2]: (sub)fields
            // expr.elem[n-1]: value

            // First read-off all the old fields, except the one to be updated
            for (int i = 1; i < expr->elems->size() - 2; i++) {
                elems[i] = static_pointer_cast<StructValue>(elems[i-1])->get(static_cast<Symbol *>(expr->elems->at(i).get())->text);
            }
            // Update the field
            elems[expr->elems->size() - 2] = elems.back();
            // Then update the record
            for (int i = expr->elems->size() - 2; i > 0; i--) {
                elems[i - 1] = static_pointer_cast<StructValue>(elems[i - 1])->set(static_cast<Symbol *>(expr->elems->at(i).get())->text, elems[i]);
            }

            states.push_back(std::make_pair(_cache(elems[0]), state));
        } else if (op_eq(expr->op, Expr::binops::APPEND))
            states.push_back(std::make_pair(_cache(static_pointer_cast<List>(val->get_type())->construct("cons", {elems[0], elems[1]})), state));
        else if (op_eq(expr->op, Expr::binops::CONCAT))
            states.push_back(std::make_pair(_cache(static_pointer_cast<IndValue>(elems[0])->concat(static_pointer_cast<IndValue>(elems[1]))), state));
        else if (op_eq(expr->op, Expr::ops::Some))
            states.push_back(std::make_pair(_cache(static_pointer_cast<Option>(val->get_type())->construct("Some", {elems[0]})), state));
        else if (op_eq(expr->op,Expr::ops::Tuple)) {
            states.push_back(std::make_pair(_cache(static_pointer_cast<Tuple>(val->get_type())->construct(elems)), state));
        }
        else if (op_eq(expr->op, "prop"))
            states.push_back(std::make_pair(_cache(elems[0]), state));
        else if (op_eq(expr->op,"ptr_to_int"))
            states.push_back(std::make_pair(_cache(static_pointer_cast<FuncValue>(autov::ptr_to_int())->call(elems)), state));
        else if (op_eq(expr->op,"int_to_ptr"))
            states.push_back(std::make_pair(_cache(static_pointer_cast<FuncValue>(autov::int_to_ptr())->call(elems)), state));
        else if (op_eq(expr->op, "z_to_nat"))
            states.push_back(std::make_pair(_cache(static_pointer_cast<FuncValue>(autov::z_to_nat())->call(elems)), state));
        else if (op_eq(expr->op,"zmap_init") || op_eq(expr->op, "ZMap.init"))
            states.push_back(std::make_pair(_cache(val->get_type()->from_z3_value(z3::const_array(z3ctx.int_sort(), elems[0]->get_z3_value()))), state));
        else if (std::holds_alternative<string>(expr->op)) {
            auto sym = std::get<string>(expr->op);
            auto info = proj->symbols[sym];
            if (info.kind == SymbolKind::StructConstr) {
                states.push_back(std::make_pair(_cache(static_pointer_cast<Struct>(val->get_type())->construct(elems)), state));
            } else if (info.kind == SymbolKind::IndConstructor) {
                states.push_back(std::make_pair(_cache(static_pointer_cast<Inductive>(val->get_type())->construct(sym, elems)), state));
            } else if (info.kind == SymbolKind::Def) {
                auto df = proj->defs[sym].get();
                if(auto loop = instance_of(df, Fixpoint)) {
                    if(proj->loop_invs.find(df->name) != proj->loop_invs.end()) {
                        auto& invs = proj->loop_invs[df->name];
                        //auto preconds = proj->cmds.InitRely[df->name];
                        auto var = std::make_shared<unordered_map<string, shared_ptr<SpecValue>>>();
                        auto conds = std::make_shared<vector<z3::expr>>();
                        //declare loop arguments
                        for (auto arg : *loop->args) {
                            if (arg->name != "_N_") {
                                (*var)[arg->name] = arg->type->declare(loop->name + "_" + arg->name, 0); //current
                                (*var)[arg->name + "_old"] = arg->type->declare(loop->name + "_" + arg->name + "_old", 0); //initial
                            }
                        }
                        
                        //ret_x == f(a,b,c,d)
                        //ret_x[0] = ret_x_0, ret_x[1] = ret_x_1....
                        //inv[a/ret_x_1,.....] = true
                        auto func_call = df->absf()->call(elems);
                        auto ret = func_call->get_type()->declare("ret", val->nid);

                        //ret_x = f(a,b,c,d)
                        auto eqformula = ret->get_z3_value() == func_call->get_z3_value();
            
                        auto some = instance_of(ret.get(), IndValue);

                        //ret_tuple
                        auto rettuple = instance_of(some->get("value").get(), StructValue);
                        
                        auto rettype = loop->rettype;
                        auto rettypesome = instance_of(rettype.get(), Option);
                        auto tupletype = instance_of(rettypesome->elem_type.get(), Tuple);

                        //after checks, we should assume that inv is hold after loop. i.e
                        //assume _N_ == 0 and I (postcond)
                        auto after_var = std::make_shared<unordered_map<string, shared_ptr<SpecValue>>>();
                        auto after_conds = std::make_shared<vector<z3::expr>>();
                        
                        ///aggregate all the invs together into one conjunctives
                        SpecNode* aggreinv = new BoolConst(true);
                        for(auto &inv : invs) {
                            auto elems = new vector<unique_ptr<SpecNode>>();
                            elems->push_back(unique_ptr<SpecNode>(aggreinv));
                            elems->push_back(inv->deep_copy());
                            aggreinv = new Expr(Expr::binops::AND, unique_ptr<vector<unique_ptr<SpecNode>>>(elems), Bool::BOOL);
                        }

                        SpecNode *before_inv = aggreinv;
                        //subst invariant inv[ret_x[0]/a' ret_x[1]/b' ret_x[2]/c' ret_x[3]/d']
                        for(auto arg : *loop->args) {
                            if (arg->name != "_N_") {
                                auto sym = new Symbol(loop->name + "_" + arg->name, arg->type);
                                bool succ;
                                before_inv = subst(before_inv->deep_copy().release(), arg->name, sym, succ);
                                delete sym;
                            }
                        }
                        auto vc = z3ctx.bool_val(true);
                        auto invval = z3_eval(proj, before_inv, make_shared<EvalState>(var, conds));
                        int i = 0;
                        for(auto arg : *loop->args) {
                            auto name = arg->name;
                            //instantiate variable to each element
                            auto z3_eq_expr = elems.at(i)->get_z3_value() == (*var)[name]->get_z3_value();
                            vc = vc && z3_eq_expr;
                        }
                        vc = vc && (*var)["st_old"]->get_z3_value() == elems.back()->get_z3_value();
                        auto res = z3_check(state, vc && invval->get_z3_value(),200);
                        if(res == Z3Result::False || res == Z3Result::Unknown || res == Z3Result::Sat) {
                            LOG_ERROR << "Precondition can't infer loop invariant";
                            return;
                        }
                    
                        states.push_back(std::make_pair(_cache(func_call), state));
                    } else {
                        LOG_ERROR << "no loop invariant specified";
                    }
                } else {
                    states.push_back(std::make_pair(_cache(df->absf()->call(elems)), state));
                }
            } else if (info.kind == SymbolKind::Decl) {
                auto df = proj->decls[sym].get();
                auto absf = static_pointer_cast<FuncValue>(df->absf());
                states.push_back(std::make_pair(_cache(absf->call(elems)), state));
            } else {
                std::cout << "expr: " << string(*expr) << std::endl;
                throw std::runtime_error("Unknown symbol: " + sym);
            }
        } else if (std::holds_alternative<unique_ptr<SpecNode>>(expr->op)) {
            auto op = z3_eval(proj, std::get<unique_ptr<SpecNode>>(expr->op).get(), state);
            if (auto func = dynamic_pointer_cast<FuncValue>(op))
                states.push_back(std::make_pair(_cache(func->call(elems)), state));
        }

        throw std::runtime_error("Unknown expression: " + string(*expr));
    } else if (auto match = instance_of(val, Match)) {
        auto src = z3_eval(proj, match->src.get(), state);
        shared_ptr<SpecValue> match_val = nullptr;
        for (auto pm = match->match_list->rbegin(); pm != match->match_list->rend(); pm++) {
            unordered_map<string, shared_ptr<SpecValue>> vars;
            unordered_map<string, shared_ptr<SpecValue>> assigns;
            auto pat = resolve_pattern(proj, val, (*pm)->pattern.get(), src, vars, assigns);
            z3::expr cond = z3ctx.bool_val(true);
            for (auto asgn : assigns) {
                auto asgn_val = asgn.second->get_z3_value();
                auto asgn_sym = vars[asgn.first]->get_z3_value();
                cond = (asgn_val == asgn_sym);
                cond = z3::exists(asgn_sym, cond);
            }

            auto z3_res = z3_check(state, cond);
            if (z3_res == Z3Result::False) {
                continue;
            }
            auto new_state = state->copy();
            for (auto v = assigns.begin(); v != assigns.end(); v++) {
                new_state->vars->emplace(v->first, v->second);
            }
            if (match_val == nullptr) {
                match_val = z3_eval(proj, (*pm)->body.get(), new_state);
            } else {
                auto then_val = z3_eval(proj, (*pm)->body.get(), new_state);
                /** Optimization: instantiate Exists: 
                 *      Original: (vars: v = src), if ((Exists v' (v' = src)) then Prop(v') else True)
                 *      --> v is the evidence of (Exists...)
                 *      --> (Exists v' (v' = src)) == True
                 *      --> Instantiate v' by v
                 *  * It's always sufficient to jsut have Prop(v) for proof!
                 */
                if (match_val->get_z3_value().is_true()) {
                    match_val = then_val;
                } else {
                    match_val = match_val->get_type()->from_z3_value(z3::ite(cond, then_val->get_z3_value(), match_val->get_z3_value()));
                }
            }
        }
        if (match_val == nullptr) {
            auto opt = static_pointer_cast<Option>(val->get_type());
            return states.push_back(std::make_pair(_cache(opt->construct("None", {})), state));
        } else {
            return states.push_back(std::make_pair(_cache(match_val), state));
        }
    } else if (auto rely = instance_of(val, Rely)) {
        vector<std::pair<shared_ptr<SpecValue>, shared_ptr<EvalState>>> condret;
        vector<std::pair<shared_ptr<SpecValue>, shared_ptr<EvalState>>> retstates;
        symbolic(proj, rely->prop.get(), state, condret);
        for(auto condstate : condret) {
            auto cond = condstate.first;
            auto condst = condstate.second;
            auto res = z3_check(condst, cond->get_z3_value());
            if (res == Z3Result::Unknown || res == Z3Result::Sat) {
                auto true_state = state->copy();
                true_state->conds->push_back(cond->get_z3_value());
                symbolic(proj, rely->body.get(), true_state, retstates);
                auto false_state = state->copy();
                false_state->conds->push_back(!cond->get_z3_value());

                auto none = static_pointer_cast<Option>(val->get_type())->construct("None", {});
                retstates.push_back(std::make_pair(none, false_state));
            } else if (res == Z3Result::True) {
                auto true_state = state->copy();
                true_state->conds->push_back(cond->get_z3_value());
                symbolic(proj, rely->body.get(), true_state, retstates);
            } else {
                auto none = static_pointer_cast<Option>(val->get_type())->construct("None", {});
                auto false_state = state->copy();
                false_state->conds->push_back(!cond->get_z3_value());
                retstates.push_back(std::make_pair(none, false_state));
            }
        }
        for(auto s: retstates) {
            states.push_back(s);
        }
    }
    else if (auto iff = instance_of(val, If))
    {
        vector<std::pair<shared_ptr<SpecValue>, shared_ptr<EvalState>>> condret;
        symbolic(proj, iff->cond.get(), state, condret);
        vector<std::pair<shared_ptr<SpecValue>, shared_ptr<EvalState>>> retstates;
        for(auto condstate : condret) {
            auto cond = condstate.first;
            auto condst = condstate.second;
            auto res = z3_check(condst, cond->get_z3_value());
            if (res == Z3Result::Unknown || res == Z3Result::Sat)
            {
                auto true_state = state->copy();
                true_state->conds->push_back(cond->get_z3_value());
                symbolic(proj, iff->then_body.get(), true_state, retstates);
                auto false_state = state->copy();
                false_state->conds->push_back(!cond->get_z3_value());
                symbolic(proj, iff->else_body.get(), false_state, retstates);
            }
            else if (res == Z3Result::True)
            {
                auto true_state = state->copy();
                true_state->conds->push_back(cond->get_z3_value());
                //vector<std::pair<shared_ptr<SpecValue>, shared_ptr<EvalState>>> retstates;
                symbolic(proj, iff->then_body.get(), true_state, retstates);
            }
            else
            {
                //vector<std::pair<shared_ptr<SpecValue>, shared_ptr<EvalState>>> retstates;
                auto false_state = state->copy();
                false_state->conds->push_back(!cond->get_z3_value());
                symbolic(proj, iff->else_body.get(), false_state, retstates);
            }
        }
        for(auto s: retstates) {
            states.push_back(s);
        }
    }
    else if (auto forall = instance_of(val, Forall))
    {
        z3::expr_vector vars(z3ctx);
        for (auto v = forall->vars->begin(); v != forall->vars->end(); v++)
        {
            auto var = (*v)->type->declare((*v)->name, val->nid);
            state->vars->emplace((*v)->name, var);
            vars.push_back(var->get_z3_value());
        }
        vector<std::pair<shared_ptr<SpecValue>, shared_ptr<EvalState>>> retstates;
        symbolic(proj, forall->body.get(), state, retstates);
        for(auto retstate: retstates) {
            auto st = retstate.second;
            auto body = retstate.first;
            states.push_back(std::make_pair(_cache(make_shared<BoolValue>(z3::forall(vars, body->value))),st));
        }
    }
    else if (auto exsts = instance_of(val, Exists))
    {
        z3::expr_vector vars(z3ctx);
        for (auto v = exsts->vars->begin(); v != exsts->vars->end(); v++)
        {
            auto var = (*v)->type->declare((*v)->name, val->nid);
            state->vars->emplace((*v)->name, var);
            vars.push_back(var->get_z3_value());
        }
        vector<std::pair<shared_ptr<SpecValue>, shared_ptr<EvalState>>> retstates;
        
        symbolic(proj, exsts->body.get(), state, retstates);
        for(auto retstate: retstates) {
            auto st = retstate.second;
            auto body = retstate.first;
            states.push_back(std::make_pair(_cache(make_shared<BoolValue>(z3::exists(vars, body->value))), state));
        }
    }

    throw std::runtime_error("Unknown node type: " + string(*val));

}


//needs to find a way to distinguish when to split state using symbolic and when not by directly using ite node of z3.
//ite is like a state merging.
shared_ptr<SpecValue> z3_eval(Project* proj, SpecNode* val, shared_ptr<EvalState> state) {
    //std::cout << "z3_eval: " << string(*val) << std::endl;

    if (val->cached_eval) return val->cached_eval;

    auto _cache = [&](shared_ptr<SpecValue> return_val) {
        val->set_z3_eval(return_val);
        return return_val;
    };

    if (auto sym = instance_of(val, Symbol)) {
        if (sym->text != "None" && sym->text != "nil" && state->vars->find(sym->text) != state->vars->end()) {
            return _cache(state->vars->at(sym->text));
        } else if (proj->defs.find(sym->text) != proj->defs.end()) {
            auto df = proj->defs[sym->text].get();
            assert(df->args->size() == 0);
            if (auto c = instance_of(df->body.get(), Const)) {
                return _cache(z3_eval(proj, c, state));
            } else {
                return _cache(df->absf()->call({}));
            }
        } else if (proj->decls.find(sym->text) != proj->decls.end()) {
            auto decl = proj->decls[sym->text].get();
            assert(!dynamic_pointer_cast<Function>(decl->type));
            return _cache(decl->absf());
        } else if (proj->is_ind_constr(sym->text)) {
            return _cache(static_pointer_cast<Inductive>(sym->get_type())->construct(sym->text, {}));
        } else if (proj->symbols.find(sym->text) != proj->symbols.end() &&
                   proj->symbols[sym->text].kind == SymbolKind::StructElem) {
            return _cache(make_shared<StringValue>(sym->text));
        } else {
            throw std::runtime_error("Unknown symbol: " + sym->text);
        }
    } else if (auto con = instance_of(val, Const)) {
        if (auto intc = std::get_if<unsigned long>(&con->value)) {
            return make_shared<IntValue>(*intc);
        } else if (auto boolc = std::get_if<bool>(&con->value)) {
            return make_shared<BoolValue>(*boolc);
        } else if (auto strc = std::get_if<string>(&con->value)) {
            return make_shared<StringValue>(*strc);
        }
    } else if (auto expr = instance_of(val, Expr)) {
        vector<shared_ptr<SpecValue>> elems;

        for (auto e = expr->elems->begin(); e != expr->elems->end(); e++) {
            elems.push_back(z3_eval(proj, e->get(), state));
        }

        if (op_eq(expr->op, Expr::None))
            return _cache(static_pointer_cast<Inductive>(val->get_type())->construct("None", {}));
        if (op_eq(expr->op, Expr::binops::ADD))
            return _cache(static_pointer_cast<IntValue>(elems[0])->add(static_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::MINUS)) {
            if (expr->elems->size() == 2)
                return _cache(static_pointer_cast<IntValue>(elems[0])->sub(static_pointer_cast<IntValue>(elems[1])));
            else
                return _cache(static_pointer_cast<IntValue>(elems[0])->neg());
        }
        if (op_eq(expr->op, Expr::binops::MULT))
            return _cache(static_pointer_cast<IntValue>(elems[0])->mul(static_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::DIV))
            return _cache(static_pointer_cast<IntValue>(elems[0])->div(static_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::MOD))
            return _cache(static_pointer_cast<IntValue>(elems[0])->mod(static_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::LSHIFT))
            return _cache(static_pointer_cast<IntValue>(elems[0])->shiftl(static_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::RSHIFT))
            return _cache(static_pointer_cast<IntValue>(elems[0])->shiftr(static_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::BITAND))
            return _cache(static_pointer_cast<IntValue>(elems[0])->land(static_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::BITOR))
            return _cache(static_pointer_cast<IntValue>(elems[0])->lor(static_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, "Z.lxor"))
            return _cache(static_pointer_cast<IntValue>(elems[0])->lxor(static_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, "Z.lnot"))
            return _cache(static_pointer_cast<IntValue>(elems[0])->lnot());
        if (op_eq(expr->op, "Z.testbit"))
            return _cache(static_pointer_cast<IntValue>(elems[0])->testbit(static_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, "Z.setbit"))
            return _cache(static_pointer_cast<IntValue>(elems[0])->setbit(static_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, "Z.clearbit"))
            return _cache(static_pointer_cast<IntValue>(elems[0])->clearbit(static_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, "Z.xorb"))
            return _cache(static_pointer_cast<IntValue>(elems[0])->xorb(static_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::EQUAL))
            return _cache(Prop::PROP->from_z3_value((elems[0]->get_z3_value() == elems[1]->get_z3_value()).simplify()));
        if (op_eq(expr->op, Expr::binops::BEQ))
            return _cache(static_pointer_cast<IntValue>(elems[0])->eq(static_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::SEQ))
            return _cache(static_pointer_cast<StringValue>(elems[0])->eq(static_pointer_cast<StringValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::NOT_EQUAL))
            return _cache(Prop::PROP->from_z3_value(elems[0]->get_z3_value() != elems[1]->get_z3_value()));
        if (op_eq(expr->op, Expr::binops::BNE))
            return _cache(static_pointer_cast<IntValue>(elems[0])->ne(static_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::SNE))
            return _cache(static_pointer_cast<StringValue>(elems[0])->ne(static_pointer_cast<StringValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::GT) || op_eq(expr->op, Expr::binops::BGT))
            return _cache(static_pointer_cast<IntValue>(elems[0])->gt(static_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::GTE) || op_eq(expr->op, Expr::binops::BGE))
            return _cache(static_pointer_cast<IntValue>(elems[0])->ge(static_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::LT) || op_eq(expr->op, Expr::binops::BLT))
            return _cache(static_pointer_cast<IntValue>(elems[0])->lt(static_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::LTE) || op_eq(expr->op, Expr::binops::BLE))
            return _cache(static_pointer_cast<IntValue>(elems[0])->le(static_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, Expr::ops::NOT) || op_eq(expr->op, Expr::ops::BNOT))
            return _cache(static_pointer_cast<BoolValue>(elems[0])->negb());
        if (op_eq(expr->op, Expr::binops::AND) || op_eq(expr->op, Expr::binops::BAND))
            return _cache(static_pointer_cast<BoolValue>(elems[0])->andb(static_pointer_cast<BoolValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::OR) || op_eq(expr->op, Expr::binops::BOR))
            return _cache(static_pointer_cast<BoolValue>(elems[0])->orb(static_pointer_cast<BoolValue>(elems[1])));
        if (op_eq(expr->op, "xorb"))
            return _cache(static_pointer_cast<BoolValue>(elems[0])->xorb(static_pointer_cast<BoolValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::IMPLIES))
            return _cache(static_pointer_cast<BoolValue>(elems[0])->implies(static_pointer_cast<BoolValue>(elems[1])));
        else if (op_eq(expr->op, Expr::GET)) {
            if (auto e = instance_of(expr->elems->at(0).get(), Expr)) {
                if (op_eq(e->op, Expr::SET)) {
                    auto z3_res = z3_check(state, z3_eval(proj, e->elems->at(1).get(), state)->get_z3_value() == elems[1]->get_z3_value());
                    if (z3_res == Z3Result::True) {
                        return _cache(z3_eval(proj, e->elems->at(2).get(), state));
                    } else if (z3_res == Z3Result::False) {
                        return _cache(static_pointer_cast<ZMapValue>(z3_eval(proj, e->elems->at(0).get(), state))->get(static_pointer_cast<IntValue>(elems[1])));
                    }
                }
            }
            //std::cout << "expr: " << string(*expr) << std::endl;
            return _cache(static_pointer_cast<ZMapValue>(elems[0])->get(static_pointer_cast<IntValue>(elems[1])));
        } else if (op_eq(expr->op, Expr::SET)) {
            if (auto e = instance_of(expr->elems->at(0).get(), Expr)) {
                if (op_eq(e->op, Expr::SET)) {
                    auto z3_res = z3_check(state, z3_eval(proj, e->elems->at(1).get(), state)->get_z3_value() == elems[1]->get_z3_value());
                    if (z3_res == Z3Result::True) {
                        elems[0] = z3_eval(proj, e->elems->at(0).get(), state);
                    }
                }
            }

            return _cache(static_pointer_cast<ZMapValue>(elems[0])->set(static_pointer_cast<IntValue>(elems[1]), elems[2]));
        } else if (op_eq(expr->op, Expr::RecordGet)) {
            // expr.elem[0]: record
            // expr.elem[1...n-2]: (sub)fields
            for (int i = 1; i < expr->elems->size(); i++) {
                elems[i] = static_pointer_cast<StructValue>(elems[i-1])->get(static_cast<Symbol *>(expr->elems->at(i).get())->text);
            }
            return _cache(elems.back());
        } else if (op_eq(expr->op, Expr::RecordSet)) {
            // expr.elem[0]: record
            // expr.elem[1...n-2]: (sub)fields
            // expr.elem[n-1]: value

            // First read-off all the old fields, except the one to be updated
            for (int i = 1; i < expr->elems->size() - 2; i++) {
                elems[i] = static_pointer_cast<StructValue>(elems[i-1])->get(static_cast<Symbol *>(expr->elems->at(i).get())->text);
            }
            // Update the field
            elems[expr->elems->size() - 2] = elems.back();
            // Then update the record
            for (int i = expr->elems->size() - 2; i > 0; i--) {
                elems[i - 1] = static_pointer_cast<StructValue>(elems[i - 1])->set(static_cast<Symbol *>(expr->elems->at(i).get())->text, elems[i]);
            }

            return _cache(elems[0]);
        } else if (op_eq(expr->op, Expr::binops::APPEND))
            return _cache(static_pointer_cast<List>(val->get_type())->construct("cons", {elems[0], elems[1]}));
        else if (op_eq(expr->op, Expr::binops::CONCAT))
            return _cache(static_pointer_cast<IndValue>(elems[0])->concat(static_pointer_cast<IndValue>(elems[1])));
        else if (op_eq(expr->op, Expr::ops::Some))
            return _cache(static_pointer_cast<Option>(val->get_type())->construct("Some", {elems[0]}));
        else if (op_eq(expr->op,Expr::ops::Tuple)) {
            return _cache(static_pointer_cast<Tuple>(val->get_type())->construct(elems));
        }
        else if (op_eq(expr->op, "prop"))
            return _cache(elems[0]);
        else if (op_eq(expr->op,"ptr_to_int"))
            return _cache(static_pointer_cast<FuncValue>(autov::ptr_to_int())->call(elems));
        else if (op_eq(expr->op,"int_to_ptr"))
            return _cache(static_pointer_cast<FuncValue>(autov::int_to_ptr())->call(elems));
        else if (op_eq(expr->op, "z_to_nat"))
            return _cache(static_pointer_cast<FuncValue>(autov::z_to_nat())->call(elems));
        else if (op_eq(expr->op,"zmap_init") || op_eq(expr->op, "ZMap.init"))
            return _cache(val->get_type()->from_z3_value(z3::const_array(z3ctx.int_sort(), elems[0]->get_z3_value())));
        else if (std::holds_alternative<string>(expr->op)) {
            auto sym = std::get<string>(expr->op);
            auto info = proj->symbols[sym];
            if (info.kind == SymbolKind::StructConstr) {
                return _cache(static_pointer_cast<Struct>(val->get_type())->construct(elems));
            } else if (info.kind == SymbolKind::IndConstructor) {
                return _cache(static_pointer_cast<Inductive>(val->get_type())->construct(sym, elems));
            } else if (info.kind == SymbolKind::Def) {
                auto df = proj->defs[sym].get();
                if(auto loop = instance_of(df, Fixpoint)) {
                    if(proj->loop_invs.find(df->name) != proj->loop_invs.end()) {
                        auto& invs = proj->loop_invs[df->name];
                        //auto preconds = proj->cmds.InitRely[df->name];
                        auto var = std::make_shared<unordered_map<string, shared_ptr<SpecValue>>>();
                        auto conds = std::make_shared<vector<z3::expr>>();
                        //declare loop arguments
                        for (auto arg : *loop->args) {
                            if (arg->name != "_N_") {
                                (*var)[arg->name] = arg->type->declare(loop->name + "_" + arg->name, 0); //current
                            }
                            if(arg->name == "st") {
                                (*var)[arg->name + "_old"] = arg->type->declare(loop->name + "_" + arg->name + "_old", 0); 
                            }
                        }
                        
                        //ret_x == f(a,b,c,d)
                        //ret_x[0] = ret_x_0, ret_x[1] = ret_x_1....
                        //inv[a/ret_x_1,.....] = true
                        auto func_call = df->absf()->call(elems);
                        // auto ret = func_call->get_type()->declare("ret", val->nid);

                        // //ret_x = f(a,b,c,d)
                        // auto eqformula = ret->get_z3_value() == func_call->get_z3_value();
            
                        // auto some = instance_of(ret.get(), IndValue);

                        // //ret_tuple
                        // auto rettuple = instance_of(some->get("value").get(), StructValue);
                        
                        // auto rettype = loop->rettype;
                        // auto rettypesome = instance_of(rettype.get(), Option);
                        // auto tupletype = instance_of(rettypesome->elem_type.get(), Tuple);

                        // //after checks, we should assume that inv is hold after loop. i.e
                        // //assume _N_ == 0 and I (postcond)
                        // auto after_var = std::make_shared<unordered_map<string, shared_ptr<SpecValue>>>();
                        // auto after_conds  = std::make_shared<vector<z3::expr>>();
                        
                        ///aggregate all the invs together into one conjunctives
                        SpecNode* aggreinv = new BoolConst(true);
                        for(auto &inv : invs) {
                            auto elems = new vector<unique_ptr<SpecNode>>();
                            elems->push_back(unique_ptr<SpecNode>(aggreinv));
                            elems->push_back(inv->deep_copy());
                            aggreinv = new Expr(Expr::binops::AND, unique_ptr<vector<unique_ptr<SpecNode>>>(elems), Bool::BOOL);
                        }

                        SpecNode *before_inv = aggreinv;
                        //subst invariant inv[ret_x[0]/a' ret_x[1]/b' ret_x[2]/c' ret_x[3]/d']

                        for(auto arg : *loop->args) {
                            // if (arg->name != "_N_") {
                            auto sym = new Symbol(loop->name + "_" + arg->name, arg->type);
                            bool succ;
                            before_inv = subst(before_inv->deep_copy().release(), arg->name, sym, succ);
                            delete sym;
                            // }
                        }
                        auto vc = z3ctx.bool_val(true);
                        auto invval = z3_eval(proj, before_inv, make_shared<EvalState>(var, conds));
                        int i = 0;
                        for(auto arg : *loop->args) {
                            auto name = arg->name;
                            //instantiate variable to each element
                            auto z3_eq_expr = elems.at(i)->get_z3_value() == (*var)[name]->get_z3_value();
                            vc = vc && z3_eq_expr;
                            i++;
                        }
                        vc = vc && (*var)["st_old"]->get_z3_value() == elems.back()->get_z3_value();
                        auto res = z3_check(state, vc && invval->get_z3_value(),200);
                        if(res == Z3Result::False || res == Z3Result::Unknown || res == Z3Result::Sat) {
                            LOG_ERROR << "Precondition can't infer loop invariant";
                            return nullptr;
                        }

                        return _cache(func_call);
                    } else {
                        LOG_ERROR << "no loop invariant specified";
                        //In this case, we merely treat it as a unintepreted function.
                        return _cache(df->absf()->call(elems));
                    }
                } else {
                    return _cache(df->absf()->call(elems));
                }
            } else if (info.kind == SymbolKind::Decl) {
                if(sym != "lens_v") {
                    auto df = proj->decls[sym].get();
                    auto absf = static_pointer_cast<FuncValue>(df->absf());
                    return _cache(absf->call(elems));
                } else {
                    auto id = static_cast<IntConst*>(expr->elems->at(0).get());
                    unsigned long idi = std::get<unsigned long>(id->value);
                    // auto arg_types = make_shared<vector<shared_ptr<SpecType>>>();
                    // //arg_types->push_back(expr->elems->at(0)->get_type());

                    // auto lens_type = make_shared<Function>(expr->type, arg_types);
                    // auto lens_v = make_unique<Declaration>("lens_v_" + std::to_string(idi), lens_type);
                    return expr->type->declare("lens_v_" + std::to_string(idi), 0);
                }
            } else {
                std::cout << "expr: " << string(*expr) << std::endl;
                throw std::runtime_error("Unknown symbol: " + sym);
            }
        } else if (std::holds_alternative<unique_ptr<SpecNode>>(expr->op)) {
            auto op = z3_eval(proj, std::get<unique_ptr<SpecNode>>(expr->op).get(), state);
            if (auto func = dynamic_pointer_cast<FuncValue>(op))
                return _cache(func->call(elems));
        }

        throw std::runtime_error("Unknown expression: " + string(*expr));
    } else if (auto match = instance_of(val, Match)) {
        auto src = z3_eval(proj, match->src.get(), state);
        shared_ptr<SpecValue> match_val = nullptr;
        for (auto pm = match->match_list->rbegin(); pm != match->match_list->rend(); pm++) {
            unordered_map<string, shared_ptr<SpecValue>> vars;
            unordered_map<string, shared_ptr<SpecValue>> assigns;
            auto pat = resolve_pattern(proj, val, (*pm)->pattern.get(), src, vars, assigns);
            z3::expr cond = z3ctx.bool_val(true);
            for (auto asgn : assigns) {
                auto asgn_val = asgn.second->get_z3_value();
                auto asgn_sym = vars[asgn.first]->get_z3_value();
                cond = (asgn_val == asgn_sym);
                cond = z3::exists(asgn_sym, cond);
            }

            auto z3_res = z3_check(state, cond);
            if (z3_res == Z3Result::False) {
                continue;
            }
            auto new_state = state->copy();
            for (auto v = assigns.begin(); v != assigns.end(); v++) {
                new_state->vars->emplace(v->first, v->second);
            }
            if (match_val == nullptr) {
                match_val = z3_eval(proj, (*pm)->body.get(), new_state);
            } else {
                auto then_val = z3_eval(proj, (*pm)->body.get(), new_state);
                /** Optimization: instantiate Exists: 
                 *      Original: (vars: v = src), if ((Exists v' (v' = src)) then Prop(v') else True)
                 *      --> v is the evidence of (Exists...)
                 *      --> (Exists v' (v' = src)) == True
                 *      --> Instantiate v' by v
                 *  * It's always sufficient to jsut have Prop(v) for proof!
                 */
                if (match_val->get_z3_value().is_true()) {
                    match_val = then_val;
                } else {
                    match_val = match_val->get_type()->from_z3_value(z3::ite(cond, then_val->get_z3_value(), match_val->get_z3_value()));
                }
            }
        }
        if (match_val == nullptr) {
            auto opt = static_pointer_cast<Option>(val->get_type());
            return _cache(opt->construct("None", {}));
        } else {
            return _cache(match_val);
        }
    } else if (auto rely = instance_of(val, Rely)) {
        auto cond = z3_eval(proj, rely->prop.get(), state);
        auto res = z3_check(state, cond->get_z3_value());
        if (res == Z3Result::Unknown || res == Z3Result::Sat) {
            auto body = z3_eval(proj, rely->body.get(), state);
            auto none = static_pointer_cast<Option>(val->get_type())->construct("None", {});

            auto z3_val = z3::ite(cond->get_z3_value(), body->get_z3_value(), none->get_z3_value());
            return _cache(rely->get_type()->from_z3_value(z3_val.simplify()));
        } else if (res == Z3Result::True) {
            return _cache(z3_eval(proj, rely->body.get(), state));
        } else {
            return _cache(static_pointer_cast<Option>(val->get_type())->construct("None", {}));
        }
    }
    else if (auto iff = instance_of(val, If))
    {
        auto c = z3_eval(proj, iff->cond.get(), state);
        auto res = z3_check(state, c->get_z3_value());
        if (res == Z3Result::Unknown || res == Z3Result::Sat)
        {
            auto true_state = state->copy();
            true_state->conds->push_back(c->get_z3_value());
            auto True = z3_eval(proj, iff->then_body.get(), true_state);
            auto false_state = state->copy();
            false_state->conds->push_back(!c->get_z3_value());
            auto False = z3_eval(proj, iff->else_body.get(), false_state);
            auto z3_val = z3::ite(c->get_z3_value(), True->get_z3_value(), False->get_z3_value());
            return _cache(iff->get_type()->from_z3_value(z3_val.simplify()));
        }
        else if (res == Z3Result::True)
        {
            state->conds->push_back(c->get_z3_value());
            return _cache(z3_eval(proj, iff->then_body.get(), state));
        }
        else
        {
            state->conds->push_back(!c->get_z3_value());
            return _cache(z3_eval(proj, iff->else_body.get(), state));
        }
    }
    else if (auto forall = instance_of(val, Forall))
    {
        z3::expr_vector vars(z3ctx);
        for (auto v = forall->vars->begin(); v != forall->vars->end(); v++)
        {
            auto var = (*v)->type->declare((*v)->name, val->nid);
            state->vars->emplace((*v)->name, var);
            vars.push_back(var->get_z3_value());
        }
        auto body = z3_eval(proj, forall->body.get(), state);
        return _cache(make_shared<BoolValue>(z3::forall(vars, body->get_z3_value())));
    }
    else if (auto exsts = instance_of(val, Exists))
    {
        z3::expr_vector vars(z3ctx);
        for (auto v = exsts->vars->begin(); v != exsts->vars->end(); v++)
        {
            auto var = (*v)->type->declare((*v)->name, val->nid);
            state->vars->emplace((*v)->name, var);
            vars.push_back(var->get_z3_value());
        }
        auto body = z3_eval(proj, exsts->body.get(), state);
        return _cache(make_shared<BoolValue>(z3::exists(vars, body->value)));
    }

    throw std::runtime_error("Unknown node type: " + string(*val));

}

} // namespace autov
