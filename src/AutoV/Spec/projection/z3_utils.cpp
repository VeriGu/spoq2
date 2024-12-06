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
Z3Result z3_check(shared_ptr<EvalState> state, z3::expr cond, int timeout) {
    timeout = 50;
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
    Z3Solver.add(cond);
    auto res = Z3Solver.check();
    Z3Solver.pop();


    Z3Solver.push();
    //Z3Solver.add(!cond);
    z3::expr_vector not_cond_vec(z3ctx);
    not_cond_vec.push_back(!cond);
    auto not_res = Z3Solver.check(not_cond_vec);
    Z3Solver.pop();

    Z3Solver.pop();
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
        Z3Cache[hash] = Z3Result::True;
        return Z3Result::True;
    } else if (res == z3::unsat) {
        Z3Cache[hash] = Z3Result::False;
        return Z3Result::False;
    } else {
        Z3Cache[hash] = Z3Result::Unknown;
        z3_unknowns++;
        return Z3Result::Unknown;
    }
}

Z3Result z3_check(shared_ptr<EvalState> state, int timeout) {
    timeout = 50;
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

// bool analyze_loop_conditon(Project* proj, SpecNode* body, std::map<int, string>& indices, vector<unique_ptr<SpecNode>>* conds, bool& found) {
//     if(auto exp = instance_of(body, Rely)) {
//         auto res = analyze_loop_conditon(proj, exp->body.get(), indices, conds, found);
//         return res;
//     }else if(auto exp = instance_of(body, If)) {
//         auto tres = analyze_loop_conditon(proj, exp->then_body.get(), indices, conds, found);
//         if(tres && !found){
//             //condition is loop condition
//             conds->push_back(exp->deep_copy());
//             found = true;
//             return true;
//         }
//         auto eres = analyze_loop_conditon(proj, exp->else_body.get(), indices, conds, found);
//         if(eres && !found) {
//             //!condition is loop condition
//             auto elems = make_unique<vector<unique_ptr<SpecNode>>>();
//             elems->push_back(exp->deep_copy());
//             auto negexp = make_unique<SpecNode>(Expr::ops::NOT, std::move(elems));
//             conds->push_back(std::move(negexp));
//             found = true;
//             return true;
//         }
//         return false;
//     } else if(auto exp = instance_of(body, Match)) {
//         auto ml = exp->match_list.get();
//         for(auto &pm : *ml) {
//             auto res = analyze_loop_conditon(proj, pm->body.get(), indices, conds, found);
//             if(res) {
//                 return true;
//             }
//         }
//         return false;
//     } else if(auto exp = instance_of(body, Expr)) {
//         if(op_eq(exp->op, Expr::ops::Some)){
//             auto elems = exp->elems.get();
//             for(auto [index, name]: indices) {
//                 auto exit = instance_of(elems->at(index).get(), BoolConst);
//                 if (std::get<bool>(exit->value)) {
//                     //the loop will terminate
//                     return true;
//                 }
//             }
//         }
//         return false;
//     }
// }

// void analyze_loop_conditon(Project *proj, Definition* loop) {
//     auto body = loop->body.get();
//     std::map<int,string> indices;
//     int i = 0;
//     for(auto &arg:*loop->args) {
//         if(arg->name == "__break__" || arg->name == "__return__") {
//             indices[i] = arg->name;
//         }
//         i++;
//     }
    

//     auto loop_conditions = new vector<unique_ptr<SpecNode>>();
//     bool found = false;
//     analyze_loop_conditon(proj, body, indices, loop_conditions, found);
// }


// //check the loop invariant is inductive given precondition of the variables.
// bool check_rec_inv(Project* proj, Definition *loop, Expr* pre) {
//     if(proj->loop_invs.find(loop->name) != proj->loop_invs.end()) {
//          auto invs = proj->loop_invs[loop->name];
//          auto body = loop->body.get();
//          auto args = loop->args.get();
//          set<string> used_variable;

//          auto var = std::make_shared<unordered_map<string, shared_ptr<SpecValue>>>();
//          auto conds = std::make_shared<vector<z3::expr>>();
//          for(auto arg: *loop->args) {
//             (*var)[arg->name] = arg->type->declare(arg->name, 0); //current
//             used_variable.insert(arg->name + std::to_string(0));
//             (*var)[arg->name + "_old"] = arg->type->declare(arg->name + "_old", 0); //initial
//             used_variable.insert(arg->name + "_old" + std::to_string(0));
//          }
//          set<string> used = used_variable;
//          auto preval = vc_gen(proj, pre, make_shared<EvalState>(
//          make_shared<unordered_map<string, shared_ptr<SpecValue>>>(*var), 
//          std::make_shared<vector<z3::expr>>(*conds)), used);

//          conds->push_back(preval->get_z3_value());
//          auto loop_body_val = vc_gen(proj, body, make_shared<EvalState>(
//          make_shared<unordered_map<string, shared_ptr<SpecValue>>>(*var), 
//          std::make_shared<vector<z3::expr>>(*conds)), used);

//          auto rettype = loop->body->type;
//          auto ret = instance_of(rettype.get(), Option);
//          auto elems_type = ret->elem_type;
//          auto tuple_type = instance_of(elems_type.get(), Tuple);
//          auto tuple_elem_type = tuple_type->types;
//          auto tuple_elems = make_unique<vector<unique_ptr<SpecNode>>>();
//          for(int i = 1; i < args->size();i++) {
//             tuple_elems->push_back(make_unique<Symbol>(args->at(i)->name + "'", tuple_elem_type->at(i-1)));
//          }
//          auto body_expr = new Expr(Expr::Tuple, std::move(tuple_elems), elems_type);
//          auto option_elem = make_unique<vector<unique_ptr<SpecNode>>>();
//          option_elem->push_back(unique_ptr<SpecNode>(body_expr));
//          auto full_expr = new Expr(Expr::Some, std::move(option_elem), rettype); 
//          auto full_val = z3_eval(proj, full_expr, 
//          make_shared<EvalState>(
//          make_shared<unordered_map<string, shared_ptr<SpecValue>>>(*var), 
//          make_shared<vector<z3::expr>>(*conds)));
         
        
//         auto after_var = std::make_shared<unordered_map<string, shared_ptr<SpecValue>>>();
//         auto after_conds = std::make_shared<vector<z3::expr>>();
//         for (auto arg : *args) {
//             if (arg->name == "_N_") {
//                 (*after_var)[arg->name + "'"] = Int::INT->declare(arg->name + "'", 0); //current
//                 (*after_var)[arg->name + "_old"] = Int::INT->declare(arg->name + "_old", 0); //initial
//             } else {
//                 (*after_var)[arg->name + "'"] = arg->type->declare(arg->name + "'", 0); //initial
//                 (*after_var)[arg->name + "_old"] = arg->type->declare(arg->name + "_old", 0); //initial
//             }
//         }

//         auto after_invs = invs;
//         auto afterinvsvalue = z3ctx.bool_val(true);
//         for(auto &inv : invs) {
//             SpecNode* after_inv = inv.get();
//             for(auto arg : *loop->args) {
//                 auto sym = new Symbol(arg->name + "'", arg->type);
//                 bool succ;
//                 after_inv = subst(after_inv->deep_copy().release(), arg->name, sym, succ);
//                 delete sym;
//             }
//             auto invstate = make_shared<EvalState>(
//             std::make_shared<unordered_map<string, shared_ptr<SpecValue>>>(*after_var), 
//             std::make_shared<vector<z3::expr>>(*after_conds));
//             auto used = used_variable;
//             auto invvalue = vc_gen(proj, inv.get(), invstate, used);
//             afterinvsvalue = afterinvsvalue && invvalue->get_z3_value();
//         }

//         auto vc_induct = z3::implies(full_val->get_z3_value() == loop_body_val->get_z3_value(), afterinvsvalue);
//     } else {
//         return true;
//     }
// }
//check the loop invariant is inductive or not
//the loop should be self-contained and have no function calls.
//inv(st) /\ N = 0 /\ st' = base_case(st) -> inv(st') //actually this step is always true, not necessary to check
//inv(st) /\ N > 0 /\ st' = loop_body(st) -> inv(st')
//we need to analyze the loop condition C for the loop
bool check_loop_inv(Project* proj, Definition *loop, Expr* inv) {
    assert(instance_of(loop, Fixpoint));
    auto body = loop->body.get();
    auto args = loop->args.get();
    auto m = instance_of(body, Match);

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
        if (arg->name == "_N_") {
            // (*var)[arg->name] = Int::INT->declare(arg->name, 0); //current
            // (*var)[arg->name + "_old"] = Int::INT->declare(arg->name + "_old", 0); //initial
            // do nothing
        } else {
            (*var)[arg->name] = arg->type->declare(arg->name, 0); //current
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
    auto full_val = z3_eval(proj, full_expr, 
    make_shared<EvalState>(
        make_shared<unordered_map<string, shared_ptr<SpecValue>>>(*var), 
        make_shared<vector<z3::expr>>(*conds)));

    SpecNode* after_inv = inv;
    //subst the loop body with correct arguments
    auto after_var = std::make_shared<unordered_map<string, shared_ptr<SpecValue>>>();
    for (auto arg : *args) {
        if (arg->name == "_N_") {
            (*after_var)[arg->name + "'"] = Int::INT->declare(arg->name + "'", 0); //current
            (*after_var)[arg->name + "_old"] = Int::INT->declare(arg->name + "_old", 0); //initial
        } else {
            (*after_var)[arg->name + "'"] = arg->type->declare(arg->name + "'", 0); //initial
            (*after_var)[arg->name + "_old"] = arg->type->declare(arg->name + "_old", 0); //initial
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
    //termination proof: ranking function(a,b,c) decreases every iteratiton.
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

// bool z3_check_invariant(Project* proj, Definition *def, unique_ptr<vector<Definition*>> invs) {
//     auto vars = std::make_shared<unordered_map<string, shared_ptr<SpecValue>>>();
//     auto conds = std::make_shared<vector<z3::expr>>();
//     for (auto arg : *def->args) {
//         (*vars)[arg->name] = arg->type->declare(arg->name, 0);
//     }

//     auto val = z3_eval(proj, def->body.get(), make_shared<EvalState>(vars, conds));
//     auto rettype = def->body->type;
//     //should be Some (x1,x2,x3.....st);
//     auto ret = instance_of(rettype.get(), Option);
//     auto elems_type = ret->elem_type;
//     auto tuple_type = instance_of(elems_type.get(), Tuple);
//     auto tuple_elem_type = tuple_type->types;

//     for(auto typ: *tuple_elem_type) {

//     }

//     shared_ptr<BoolValue> invariant = nullptr;
//     for(auto inv : *invs) {
//         auto inv_vars = std::make_shared<unordered_map<string, shared_ptr<SpecValue>>>();
//         auto inv_conds = std::make_shared<vector<z3::expr>>();
//         auto st_name = def->args->back()->name;
//         (*inv_vars)[st_name] = def->args->back()->type->declare(st_name, 0);

//         auto inval = z3_eval(proj, inv->body.get(), make_shared<EvalState>(inv_vars, inv_conds));
//         if(invariant == nullptr) {
//             invariant = static_pointer_cast<BoolValue>(inval);
//         } else {
//             invariant = invariant->andb(static_pointer_cast<BoolValue>(inval));
//         }
//     }

//     //TODO: Add

//     return false;
// }



//this method should work from top low specs to bottom low specs.
//a symbolic evaluation step like z3 eval, however, we directly do symbolic evaluation
//here instead of using z3-simplfify rules to simplify low-spec since we don't necessarily
//need to generate the high spec.
//side verification conditions(loop verification conditions) that needs to be check will be checked online
//but should not added to path constraints @state
//@state keeps track of path constraits.
bool vc_gen(Project* proj, SpecNode* val, shared_ptr<EvalState> state, set<string>& used_names, vector<unique_ptr<Expr>> inv) {

    //an if or rely node will not have a stored z3_eval.
    auto _cache = [&](shared_ptr<SpecValue> return_val) {
        val->set_z3_eval(return_val);
        return return_val;
    };

    if(val->cached_eval) {
        goto CHECK;
    }

    if (auto sym = instance_of(val, Symbol)) {
        if (sym->text != "None" && sym->text != "nil" && state->vars->find(sym->text) != state->vars->end()) {
            _cache(state->vars->at(sym->text));
        } else if (proj->defs.find(sym->text) != proj->defs.end()) {
            // this only takes constant symbols
            auto df = proj->defs[sym->text].get();
            assert(df->args->size() == 0);
            if (auto c = instance_of(df->body.get(), Const)) {
                _cache(z3_eval(proj, c, state));
            }
        } else if (proj->decls.find(sym->text) != proj->decls.end()) {
            auto decl = proj->decls[sym->text].get();
            assert(!dynamic_pointer_cast<Function>(decl->type));
            _cache(decl->absf());
        } else if (proj->is_ind_constr(sym->text)) {
            _cache(static_pointer_cast<Inductive>(sym->get_type())->construct(sym->text, {}));
        } else if (proj->symbols.find(sym->text) != proj->symbols.end() &&
                   proj->symbols[sym->text].kind == SymbolKind::StructElem) {
            _cache(make_shared<StringValue>(sym->text));
        } else {
            throw std::runtime_error("Unknown symbol: " + sym->text);
        }
    } else if (auto con = instance_of(val, Const)) {
        if (auto intc = std::get_if<unsigned long>(&con->value)) {
            make_shared<IntValue>(*intc);
        } else if (auto boolc = std::get_if<bool>(&con->value)) {
            make_shared<BoolValue>(*boolc);
        } else if (auto strc = std::get_if<string>(&con->value)) {
            make_shared<StringValue>(*strc);
        }
    } else if (auto expr = instance_of(val, Expr)) {
        vector<shared_ptr<SpecValue>> elems;

        for (auto e = expr->elems->begin(); e != expr->elems->end(); e++) {
            elems.push_back(z3_eval(proj, e->get(), state->copy()));
        }

        if (op_eq(expr->op, Expr::None))
            _cache(static_pointer_cast<Inductive>(val->get_type())->construct("None", {}));
        if (op_eq(expr->op, Expr::binops::ADD))
            _cache(static_pointer_cast<IntValue>(elems[0])->add(static_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::MINUS)) {
            if (expr->elems->size() == 2)
                _cache(static_pointer_cast<IntValue>(elems[0])->sub(static_pointer_cast<IntValue>(elems[1])));
            else
                _cache(static_pointer_cast<IntValue>(elems[0])->neg());
        }
        if (op_eq(expr->op, Expr::binops::MULT))
            _cache(static_pointer_cast<IntValue>(elems[0])->mul(static_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::DIV))
            _cache(static_pointer_cast<IntValue>(elems[0])->div(static_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::MOD))
            _cache(static_pointer_cast<IntValue>(elems[0])->mod(static_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::LSHIFT))
            _cache(static_pointer_cast<IntValue>(elems[0])->shiftl(static_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::RSHIFT))
            _cache(static_pointer_cast<IntValue>(elems[0])->shiftr(static_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::BITAND))
            _cache(static_pointer_cast<IntValue>(elems[0])->land(static_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::BITOR))
            _cache(static_pointer_cast<IntValue>(elems[0])->lor(static_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, "Z.lxor"))
            _cache(static_pointer_cast<IntValue>(elems[0])->lxor(static_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, "Z.lnot"))
            _cache(static_pointer_cast<IntValue>(elems[0])->lnot());
        if (op_eq(expr->op, "Z.testbit"))
            _cache(static_pointer_cast<IntValue>(elems[0])->testbit(static_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, "Z.setbit"))
            _cache(static_pointer_cast<IntValue>(elems[0])->setbit(static_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, "Z.clearbit"))
            _cache(static_pointer_cast<IntValue>(elems[0])->clearbit(static_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, "Z.xorb"))
            _cache(static_pointer_cast<IntValue>(elems[0])->xorb(static_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::EQUAL))
            _cache(Prop::PROP->from_z3_value((elems[0]->get_z3_value() == elems[1]->get_z3_value()).simplify()));
        if (op_eq(expr->op, Expr::binops::BEQ))
            _cache(static_pointer_cast<IntValue>(elems[0])->eq(static_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::SEQ))
            _cache(static_pointer_cast<StringValue>(elems[0])->eq(static_pointer_cast<StringValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::NOT_EQUAL))
            _cache(Prop::PROP->from_z3_value(elems[0]->get_z3_value() != elems[1]->get_z3_value()));
        if (op_eq(expr->op, Expr::binops::BNE))
            _cache(static_pointer_cast<IntValue>(elems[0])->ne(static_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::SNE))
            _cache(static_pointer_cast<StringValue>(elems[0])->ne(static_pointer_cast<StringValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::GT) || op_eq(expr->op, Expr::binops::BGT))
            _cache(static_pointer_cast<IntValue>(elems[0])->gt(static_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::GTE) || op_eq(expr->op, Expr::binops::BGE))
            _cache(static_pointer_cast<IntValue>(elems[0])->ge(static_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::LT) || op_eq(expr->op, Expr::binops::BLT))
            _cache(static_pointer_cast<IntValue>(elems[0])->lt(static_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::LTE) || op_eq(expr->op, Expr::binops::BLE))
            _cache(static_pointer_cast<IntValue>(elems[0])->le(static_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, Expr::ops::NOT) || op_eq(expr->op, Expr::ops::BNOT))
            _cache(static_pointer_cast<BoolValue>(elems[0])->negb());
        if (op_eq(expr->op, Expr::binops::AND) || op_eq(expr->op, Expr::binops::BAND))
            _cache(static_pointer_cast<BoolValue>(elems[0])->andb(static_pointer_cast<BoolValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::OR) || op_eq(expr->op, Expr::binops::BOR))
            _cache(static_pointer_cast<BoolValue>(elems[0])->orb(static_pointer_cast<BoolValue>(elems[1])));
        if (op_eq(expr->op, "xorb"))
            _cache(static_pointer_cast<BoolValue>(elems[0])->xorb(static_pointer_cast<BoolValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::IMPLIES))
            _cache(static_pointer_cast<BoolValue>(elems[0])->implies(static_pointer_cast<BoolValue>(elems[1])));
        else if (op_eq(expr->op, Expr::GET)) {
            if (auto e = instance_of(expr->elems->at(0).get(), Expr)) {
                if (op_eq(e->op, Expr::SET)) {
                    auto z3_res = z3_check(state, z3_eval(proj, e->elems->at(1).get(), state)->get_z3_value() == elems[1]->get_z3_value());
                    if (z3_res == Z3Result::True) {
                        _cache(z3_eval(proj, e->elems->at(2).get(), state));
                    } else if (z3_res == Z3Result::False) {
                        _cache(static_pointer_cast<ZMapValue>(z3_eval(proj, e->elems->at(0).get(), state))->get(static_pointer_cast<IntValue>(elems[1])));
                    }
                }
            }
            //std::cout << "expr: " << string(*expr) << std::endl;
            _cache(static_pointer_cast<ZMapValue>(elems[0])->get(static_pointer_cast<IntValue>(elems[1])));
        } else if (op_eq(expr->op, Expr::SET)) {
            if (auto e = instance_of(expr->elems->at(0).get(), Expr)) {
                if (op_eq(e->op, Expr::SET)) {
                    auto z3_res = z3_check(state, z3_eval(proj, e->elems->at(1).get(), state)->get_z3_value() == elems[1]->get_z3_value());
                    if (z3_res == Z3Result::True) {
                        elems[0] = z3_eval(proj, e->elems->at(0).get(), state);
                    }
                }
            }

            _cache(static_pointer_cast<ZMapValue>(elems[0])->set(static_pointer_cast<IntValue>(elems[1]), elems[2]));
        } else if (op_eq(expr->op, Expr::RecordGet)) {
            // expr.elem[0]: record
            // expr.elem[1...n-2]: (sub)fields
            for (int i = 1; i < expr->elems->size(); i++) {
                elems[i] = static_pointer_cast<StructValue>(elems[i-1])->get(static_cast<Symbol *>(expr->elems->at(i).get())->text);
            }
            _cache(elems.back());
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

            _cache(elems[0]);
        } else if (op_eq(expr->op, Expr::binops::APPEND))
            _cache(static_pointer_cast<List>(val->get_type())->construct("cons", {elems[0], elems[1]}));
        else if (op_eq(expr->op, Expr::binops::CONCAT))
            _cache(static_pointer_cast<IndValue>(elems[0])->concat(static_pointer_cast<IndValue>(elems[1])));
        else if (op_eq(expr->op, Expr::ops::Some))
            _cache(static_pointer_cast<Option>(val->get_type())->construct("Some", {elems[0]}));
        else if (op_eq(expr->op,Expr::ops::Tuple)) {
            _cache(static_pointer_cast<Tuple>(val->get_type())->construct(elems));
        }
        else if (op_eq(expr->op, "prop"))
            _cache(elems[0]);
        else if (op_eq(expr->op,"ptr_to_int"))
            _cache(static_pointer_cast<FuncValue>(autov::ptr_to_int())->call(elems));
        else if (op_eq(expr->op,"int_to_ptr"))
            _cache(static_pointer_cast<FuncValue>(autov::int_to_ptr())->call(elems));
        else if (op_eq(expr->op, "z_to_nat"))
            _cache(static_pointer_cast<FuncValue>(autov::z_to_nat())->call(elems));
        else if (op_eq(expr->op,"zmap_init") || op_eq(expr->op, "ZMap.init"))
            _cache(val->get_type()->from_z3_value(z3::const_array(z3ctx.int_sort(), elems[0]->get_z3_value())));
        else if (std::holds_alternative<string>(expr->op)) {
            auto sym = std::get<string>(expr->op);
            auto info = proj->symbols[sym];
            if (info.kind == SymbolKind::StructConstr) {
                _cache(static_pointer_cast<Struct>(val->get_type())->construct(elems));
            } else if (info.kind == SymbolKind::IndConstructor) {
                _cache(static_pointer_cast<Inductive>(val->get_type())->construct(sym, elems));
            } else if (info.kind == SymbolKind::Def) {
                auto df = proj->defs[sym].get();
                if(auto loop = instance_of(df, Fixpoint)) {
                    if(proj->loop_invs.find(df->name) != proj->loop_invs.end()) {
                        auto invs = proj->loop_invs[df->name];
                        auto preconds = proj->cmds.InitRely[df->name];
                        auto var = std::make_shared<unordered_map<string, shared_ptr<SpecValue>>>();
                        auto conds = std::make_shared<vector<z3::expr>>();
                        //declare loop arguments
                        for (auto arg : *loop->args) {
                            if (arg->name == "_N_") {
                                //do nothing
                            } else {
                                (*var)[arg->name] = arg->type->declare(arg->name, 0); //current
                                (*var)[arg->name + "_old"] = arg->type->declare(arg->name + "_old", 0); //initial
                            }
                        }
                        
                        //check precondition holds
                        auto precondsval = z3ctx.bool_val(true);
                        auto state = make_shared<EvalState>(var, conds);
                        for(auto &precond : preconds) {
                            auto precondval = z3_eval(proj, precond.get(), state);
                            precondsval = precondsval && precondval->get_z3_value();
                        }

                        if(z3_check(state, precondsval, 500) == Z3Result::False) {
                            LOG_ERROR << "loop preconditon is false!";
                            return false;
                        }
 
                        //after checks, we should assume that inv is hold after loop. i.e
                        //assume _N_ == 0 and I (postcond)
                        auto after_var = std::make_shared<unordered_map<string, shared_ptr<SpecValue>>>();
                        auto after_conds = std::make_shared<vector<z3::expr>>();
                        //auto _N_ = Int::INT->declare(loop->args->at(0)->name, 0);
                        //declare loop arguments
                        for (auto arg : *loop->args) {
                            if (arg->name != "_N_") {
                                (*after_var)[arg->name] = arg->type->declare(arg->name, 0); //current
                                (*after_var)[arg->name + "_old"] = arg->type->declare(arg->name + "_old", 0); //initial
                            }
                        }
                        //ret_x == f(a,b,c,d), inv[ret_x[0]/a' ret_x[1]/b' ret_x[2]/c' ret_x[3]/d']




                    } else {
                        LOG_ERROR << "does not have a loop invariant: " << df->name;
                        return false;
                    }
                    _cache(df->absf()->call(elems));
                } else {
                    auto df = proj->defs[sym].get();
                    _cache(df->absf()->call(elems));
                }
                _cache(df->absf()->call(elems));
            } else if (info.kind == SymbolKind::Decl) {
                auto df = proj->decls[sym].get();
                auto absf = static_pointer_cast<FuncValue>(df->absf());
                _cache(absf->call(elems));
            } else {
                std::cout << "expr: " << string(*expr) << std::endl;
                throw std::runtime_error("Unknown symbol: " + sym);
            }
        } else if (std::holds_alternative<unique_ptr<SpecNode>>(expr->op)) {
            auto op = z3_eval(proj, std::get<unique_ptr<SpecNode>>(expr->op).get(), state);
            if (auto func = dynamic_pointer_cast<FuncValue>(op))
                _cache(func->call(elems));
        }

        throw std::runtime_error("Unknown expression: " + string(*expr));
    } else if (auto match = instance_of(val, Match)) {
        //a src should already be removed if expressions, so there is no control flow in the src.
        //a single state is sufficient.
        auto src = z3_eval(proj, match->src.get(), state);
        shared_ptr<SpecValue> match_val = nullptr;
        for (auto pm = match->match_list->rbegin(); pm != match->match_list->rend(); pm++) {
            unordered_map<string, shared_ptr<SpecValue>> vars;
            unordered_map<string, shared_ptr<SpecValue>> assigns;
            auto pat = resolve_pattern(proj, val, (*pm)->pattern.get(), src, vars, assigns);
            auto cond = pat->get_z3_value() == src->get_z3_value();
            for (auto v = vars.begin(); v != vars.end(); v++) {
                cond = z3::exists(v->second->get_z3_value(), cond);
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
                match_val = match_val->get_type()->from_z3_value(z3::ite(cond, then_val->get_z3_value(), match_val->get_z3_value()));
            }
        }
        if (match_val == nullptr) {
            auto opt = static_pointer_cast<Option>(val->get_type());
            _cache(opt->construct("None", {}));
        } else {
            _cache(match_val);
        }
    } else if (auto rely = instance_of(val, Rely)) {
        auto cond = z3_eval(proj, rely->prop.get(), state);
        auto res = z3_check(state, cond->get_z3_value());
        if (res == Z3Result::Unknown) {
            auto true_state = state->copy();
            true_state->conds->push_back(cond->get_z3_value());
            auto True = vc_gen(proj, rely->body.get(), true_state,  used_names, inv);
            return True;
        } else if (res == Z3Result::True) {
            _cache(z3_eval(proj, rely->body.get(), state));
        } else {
            _cache(static_pointer_cast<Option>(val->get_type())->construct("None", {}));
        }
    }
    else if (auto iff = instance_of(val, If))
    {
        auto c = z3_eval(proj, iff->cond.get(), state);
        auto res = z3_check(state, c->get_z3_value());
        if (res == Z3Result::Unknown)
        {
            auto true_state = state->copy();
            true_state->conds->push_back(c->get_z3_value());
            auto True = vc_gen(proj, iff->then_body.get(), true_state,  used_names, inv);
            auto false_state = state->copy();
            false_state->conds->push_back(!c->get_z3_value());
            auto False = vc_gen(proj, iff->else_body.get(), false_state, used_names, post_cond);
            return True && False;
            //auto z3_val = z3::ite(c->get_z3_value(), True->get_z3_value(), False->get_z3_value());
            //_cache(iff->get_type()->from_z3_value(z3_val.simplify()));
        }
        else if (res == Z3Result::True)
        {
            state->conds->push_back(c->get_z3_value());
            _cache(z3_eval(proj, iff->then_body.get(), state));
        }
        else
        {
            state->conds->push_back(!c->get_z3_value());
            _cache(z3_eval(proj, iff->else_body.get(), state));
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
        _cache(make_shared<BoolValue>(z3::forall(vars, body->value)));
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
        _cache(make_shared<BoolValue>(z3::exists(vars, body->value)));
    }


CHECK:
    //check the inv, the return value should only be 


}


//state is path conditions relate to current value, state will be copied when going into if and rely
//vcs is global conditions instantiated to assume post conditions of loops.
shared_ptr<SpecValue> z3_eval2(Project* proj, SpecNode* val, shared_ptr<EvalState> state, vector<z3::expr> &vcs) {
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
                auto df = proj->defs[sym].get();
                if(auto loop = instance_of(df, Fixpoint)) {
                    if(proj->loop_invs.find(df->name) != proj->loop_invs.end()) {
                        auto invs = proj->loop_invs[df->name];
                        auto preconds = proj->cmds.InitRely[df->name];
                        auto var = std::make_shared<unordered_map<string, shared_ptr<SpecValue>>>();
                        auto conds = std::make_shared<vector<z3::expr>>();
                        //declare loop arguments
                        for (auto arg : *loop->args) {
                            if (arg->name != "_N_") {
                                (*var)[arg->name] = arg->type->declare(arg->name, 0); //current
                                (*var)[arg->name + "_old"] = arg->type->declare(arg->name + "_old", 0); //initial
                            }
                        }
                        
                        //ret_x == f(a,b,c,d)
                        //ret_x[0] = ret_x_0, ret_x[1] = ret_x_1....
                        //inv[a/ret_x_1,.....] = true
                        auto func_call = df->absf()->call(elems);
                        auto ret = func_call->get_type()->declare("ret", val->nid);
                        auto eqformula = ret->get_z3_value() == func_call->get_z3_value();
                        vcs.push_back(eqformula);
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

                        
                        SpecNode *after_inv = aggreinv;
                        string name = "ret." + val->nid;
                        int i = 0;
                        //subst invariant inv[ret_x[0]/a' ret_x[1]/b' ret_x[2]/c' ret_x[3]/d']
                        for(auto arg : *loop->args) {
                            if (arg->name != "_N_") {
                                auto argname = name + "_" + std::to_string(i);
                                (*after_var)[argname] = arg->type->declare(argname, 0); //current
                                (*after_var)[arg->name + "_old"] = arg->type->declare(arg->name + "_old", 0); //initial
                                auto sym = new Symbol(argname, arg->type);
                                bool succ;
                                after_inv = subst(after_inv->deep_copy().release(), arg->name, sym, succ);
                                delete sym;
                            }
                            i++;
                        }

                        //invariant formula
                        auto invval = z3_eval2(proj, val, make_shared<EvalState>(after_var, after_conds), vcs);
                        vcs.push_back(invval->get_z3_value());
                        
                        //ret_x[i] = vars'[i]
                        i = 0;
                        for (auto arg : *loop->args) {
                            if (arg->name != "_N_") {
                                auto argname = name + "_" + std::to_string(i);
                                auto retelemfml = (*after_var)[argname]->get_z3_value() == rettuple->get(i-1)->get_z3_value();
                                vcs.push_back(retelemfml);
                            }
                            i++;
                        }
                        
                        return _cache(func_call);
                    } else {
                        LOG_ERROR << "no loop invariant specified";
                    }
                } else {
                    return _cache(df->absf()->call(elems));
                }
            } else if (info.kind == SymbolKind::Decl) {
                auto df = proj->decls[sym].get();
                auto absf = static_pointer_cast<FuncValue>(df->absf());
                return _cache(absf->call(elems));
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
            auto cond = pat->get_z3_value() == src->get_z3_value();
            for (auto v = vars.begin(); v != vars.end(); v++) {
                cond = z3::exists(v->second->get_z3_value(), cond);
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
                match_val = match_val->get_type()->from_z3_value(z3::ite(cond, then_val->get_z3_value(), match_val->get_z3_value()));
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
        if (res == Z3Result::Unknown) {
            auto true_state = state->copy();
            auto body = z3_eval(proj, rely->body.get(), true_state);
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
        if (res == Z3Result::Unknown)
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
        return _cache(make_shared<BoolValue>(z3::forall(vars, body->value)));
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
                return _cache(df->absf()->call(elems));
            } else if (info.kind == SymbolKind::Decl) {
                auto df = proj->decls[sym].get();
                auto absf = static_pointer_cast<FuncValue>(df->absf());
                return _cache(absf->call(elems));
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
            auto cond = pat->get_z3_value() == src->get_z3_value();
            for (auto v = vars.begin(); v != vars.end(); v++) {
                cond = z3::exists(v->second->get_z3_value(), cond);
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
                match_val = match_val->get_type()->from_z3_value(z3::ite(cond, then_val->get_z3_value(), match_val->get_z3_value()));
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
        if (res == Z3Result::Unknown) {
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
        if (res == Z3Result::Unknown)
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
        return _cache(make_shared<BoolValue>(z3::forall(vars, body->value)));
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
