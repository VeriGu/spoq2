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
#include <rules.h>
#include <chrono>
#include "z3_pcache.hpp"
#include <profile.h>
#include <cmd.h>
#include <symbolic.h>


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


// #define Z3_PCACHE
#ifdef Z3_PCACHE
SMTHashMapCache pcache("smt_cache.txt");
inline z3::check_result cache_to_check_result(int l) {
    if (l == 1) return z3::sat;
    else if (l == 0) return z3::unsat;
    return z3::unknown;
}
z3::check_result z3_pcache_check() { 
    auto stmt = Z3Solver.to_smt2();
    auto p = pcache.get(stmt);
    if(p.first != -1) return cache_to_check_result(p.first); 
    auto res = Z3Solver.check();
    pcache.put(stmt, res);
    return res;
}

z3::check_result z3_pcache_check(z3::expr_vector const &assumptions) {
    auto stmt = Z3Solver.to_smt2();
    unsigned n = assumptions.size();
    for (unsigned i = 0; i < n; i++) {
        stmt = stmt + "[" + assumptions[i].to_string() + "]";
    }
    auto p = pcache.get(stmt);
    if(p.first != -1) return cache_to_check_result(p.first);
    auto res = Z3Solver.check(assumptions);
    pcache.put(stmt, res);
    return res;
}
#endif

unordered_map<size_t, Z3Result> Z3Cache;

size_t hash_unsigned_vector(const vector<unsigned> &v) {
    size_t hash = 0;
    for (const auto &i : v) {
        boost::hash_combine(hash, i);
    }
    return hash;
}

static inline size_t hash_z3_expr(z3::expr &e) {
    return e.hash();
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

/** specialized z3 checker for automated proof
 *  1. only check !cond if UNSAT (True) or not
 *  2. automatically dump queries
 *  3. use local solver, which significantly speedup path-by-path verification
  */
Z3Result z3_verify(shared_ptr<ProveState> state, z3::expr cond, QueryInfo *qinfo, int timeout) {
    auto start = std::chrono::high_resolution_clock::now();
    // auto hash = hash_z3_state(state, cond, timeout);
    // z3_checks++;
    // if (Z3Cache.find(hash) != Z3Cache.end()) {
    //     z3_cache_hits++;
    //     return Z3Cache[hash];
    // }
    z3::solver solve(z3ctx);
    Z3Params.set("timeout", (unsigned int)timeout);
    solve.set(Z3Params);
    solve.push();
    for (auto &c : *state->conds) {
        solve.add(c);
    }
    for (auto &ind : *state->inductions) {
        solve.add(ind);
    }
    solve.push();
    
    solve.add(!cond);
    auto not_res = solve.check();
    if (qinfo)
        qinfo->dump(solve.to_smt2());

    solve.pop();
    solve.pop();
    auto end = std::chrono::high_resolution_clock::now();
    z3_accumulative_time += std::chrono::duration_cast<std::chrono::duration<double>>(end - start);

    if (not_res == z3::unsat) {
        // Z3Cache[hash] = Z3Result::True;
        return Z3Result::True;
    } else if (not_res == z3::sat) {
        auto ce = solve.get_model();
        // Z3Cache[hash] = Z3Result::False;
        return Z3Result::False;
    } else {
        // Z3Cache[hash] = Z3Result::Unknown;
        return Z3Result::Unknown;
    }
}

/** 
 * z3_verify without cond:
 *  used for check the satisfiability of current symbolic path 
 * Usage: 
 * 1. Check None-path for drf invariant
 * 2. TODO 
 * */
Z3Result z3_verify_state_sat(shared_ptr<ProveState> state, QueryInfo *qinfo, int timeout) {
    auto start = std::chrono::high_resolution_clock::now();
    Z3Params.set("relevancy", (unsigned int)2);
    Z3Params.set("case_split", (unsigned int)2);
    Z3Params.set("timeout", (unsigned int)timeout);

    Z3Solver.push();
    for (auto &c : *state->conds) {
        Z3Solver.add(c);
    }
    for (auto &ind : *state->inductions) {
        Z3Solver.add(ind);
    }
    Z3Solver.push();
    auto res = Z3Solver.check();
    if (qinfo)
        qinfo->dump(Z3Solver.to_smt2());
    Z3Solver.pop();
    Z3Solver.pop();
    auto end = std::chrono::high_resolution_clock::now();
    z3_accumulative_time += std::chrono::duration_cast<std::chrono::duration<double>>(end - start);

    if (res == z3::sat) {
        return Z3Result::True;
    } else if (res == z3::unsat) {
        return Z3Result::False;
    } else {
        return Z3Result::Unknown;
    }
}

// Defautl value of timeout is 50
Z3Result z3_check(shared_ptr<EvalState> state, z3::expr cond, int timeout) {
    auto start = std::chrono::high_resolution_clock::now();
    auto hash = hash_z3_state(state, cond, timeout);
    z3_checks++;
    if (Z3Cache.find(hash) != Z3Cache.end()) {
        z3_cache_hits++;
        return Z3Cache[hash];
    }

    Z3Params.set("timeout", (unsigned int)timeout);

    Z3Solver.set(Z3Params);

    Z3Solver.push();

    for (auto &c : *state->conds) {
        Z3Solver.add(c);
    }
    if (auto prover = instance_of(state.get(), ProveState)) {
        for (auto &ind : *prover->inductions) {
            Z3Solver.add(ind);
        }
    }
    Z3Solver.push();
    Z3Solver.add(cond);
#ifdef Z3_PCACHE
    auto res = z3_pcache_check();
#else
    auto res = Z3Solver.check();
#endif
    Z3Solver.pop();


    Z3Solver.push();
    //Z3Solver.add(!cond);
    z3::expr_vector not_cond_vec(z3ctx);
    not_cond_vec.push_back(!cond);
#ifdef Z3_PCACHE
    auto not_res = z3_pcache_check(not_cond_vec);
#else
    auto not_res = Z3Solver.check(not_cond_vec);
#endif
    Z3Solver.pop();

    Z3Solver.pop();
    auto end = std::chrono::high_resolution_clock::now();
    z3_accumulative_time += std::chrono::duration_cast<std::chrono::duration<double>>(end - start);

    // std::cout << "-----------------Z3-----------------" << std::endl;
    // std::cout << "state hash: " << hash << std::endl;
    // std::cout << "z3 check cond: " << cond << ", hash: " << cond.hash() << std::endl;
    // std::cout << "z3 check res: " << res << std::endl;
    // std::cout << "z3 check not_res: " << not_res << std::endl;
    // std::cout << "-----------------Z3-----------------" << std::endl;

    if (not_res == z3::unsat) {
        if (res == z3::unsat) {
            string msg = "Pre-condition is False! Condition is:\n";
            for (auto &c : *state->conds) {
                msg += c.to_string() + "\n";
            }
            msg += "Condition is:\n";
            msg += cond.to_string();
            LOG_WARNING << msg << std::endl;
            // throw std::runtime_error(msg);
        }
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
    auto start = std::chrono::high_resolution_clock::now();
    auto hash = hash_z3_state(state, timeout);
    z3_checks++;
    if (Z3Cache.find(hash) != Z3Cache.end()) {
        z3_cache_hits++;
        return Z3Cache[hash];
    }


    Z3Params.set("timeout", (unsigned int)timeout);

    Z3Solver.set(Z3Params);

    Z3Solver.push();

    for (auto &c : *state->conds) {
        Z3Solver.add(c);
    }
    Z3Solver.push();
#ifdef Z3_PCACHE
    auto res = z3_pcache_check();
#else
    auto res = Z3Solver.check();
#endif
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

shared_ptr<SpecValue> z3_eval(Project* proj, SpecNode* val, shared_ptr<EvalState> state) {

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
            if (!__OPT_ON_ARITH) {
                if (auto e = instance_of(expr->elems->at(0).get(), Expr)) {
                    if (op_eq(e->op, Expr::SET)) {
                        PROFILE_START(expr_eval_check);
                        PROFILE_START(eval_check);
                        auto z3_res = z3_check(state, z3_eval(proj, e->elems->at(1).get(), state)->get_z3_value() == elems[1]->get_z3_value());
                        PROFILE_END(eval_check);
                        PROFILE_END(expr_eval_check);
                        if (z3_res == Z3Result::True) {
                            profile_log_eval_expr_solved(string(*val));
                            return _cache(z3_eval(proj, e->elems->at(2).get(), state));
                        } else if (z3_res == Z3Result::False) {
                            profile_log_eval_expr_solved(string(*val));
                            return _cache(static_pointer_cast<ZMapValue>(z3_eval(proj, e->elems->at(0).get(), state))->get(static_pointer_cast<IntValue>(elems[1])));
                        } else {
                            profile_log_eval_expr_unsolved(string(*val));
                        }
                    }
                }
            }
            //std::cout << "expr: " << string(*expr) << std::endl;
            return _cache(static_pointer_cast<ZMapValue>(elems[0])->get(static_pointer_cast<IntValue>(elems[1])));
        } else if (op_eq(expr->op, Expr::SET)) {
            if (!__OPT_ON_ARITH) {
                if (auto e = instance_of(expr->elems->at(0).get(), Expr)) {
                    if (op_eq(e->op, Expr::SET)) {
                        PROFILE_START(expr_eval_check);
                        PROFILE_START(eval_check);
                        auto z3_res = z3_check(state, z3_eval(proj, e->elems->at(1).get(), state)->get_z3_value() == elems[1]->get_z3_value());
                        PROFILE_END(eval_check);
                        PROFILE_END(expr_eval_check);
                        if (z3_res == Z3Result::True) {
                            elems[0] = z3_eval(proj, e->elems->at(0).get(), state);
                        }
                        if (z3_res != Z3Result::Unknown) {
                            profile_log_eval_expr_solved(string(*val));
                        } else {
                            profile_log_eval_expr_unsolved(string(*val));
                        }
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
            if (!__OPT_ON_MATCH) {
                // LOG_INFO << "[PROFILE]" << "z3_eval: z3_check: match stands: " << string(*val);
                PROFILE_START(match_eval_check);
                PROFILE_START(eval_check);
                auto z3_res = z3_check(state, cond);
                PROFILE_END(eval_check);
                PROFILE_END(match_eval_check);
                if (z3_res == Z3Result::False) {
                    profile_log_eval_match_solved(string(*(match->src.get())));
                    continue;
                } else if (z3_res == Z3Result::True) {
                    profile_log_eval_match_solved(string(*(match->src.get())));
                } else {
                    profile_log_eval_match_unsolved(string(*(match->src.get())));
                }
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
        // LOG_INFO << "[PROFILE]" << "z3_eval: z3_check: rely stands: " << string(*val);
        PROFILE_START(rely_eval_check);
        PROFILE_START(eval_check);
        auto res = z3_check(state, cond->get_z3_value());
        PROFILE_END(eval_check);
        PROFILE_END(rely_eval_check);

        if (res == Z3Result::Unknown) {
            profile_log_eval_rely_unsolved(string(*rely->prop.get()));
            auto body = z3_eval(proj, rely->body.get(), state);
            auto none = static_pointer_cast<Option>(val->get_type())->construct("None", {});

            auto z3_val = z3::ite(cond->get_z3_value(), body->get_z3_value(), none->get_z3_value());
            return _cache(rely->get_type()->from_z3_value(z3_val.simplify()));
        } else if (res == Z3Result::True) {
            profile_log_eval_rely_solved(string(*rely->prop.get()));
            return _cache(z3_eval(proj, rely->body.get(), state));
        } else {
            profile_log_eval_rely_solved(string(*rely->prop.get()));
            return _cache(static_pointer_cast<Option>(val->get_type())->construct("None", {}));
        }
    }
    else if (auto iff = instance_of(val, If))
    {
        auto c = z3_eval(proj, iff->cond.get(), state);
        // LOG_INFO << "[PROFILE]" << "z3_eval: z3_check: if cond stands: " << string(*val);
        PROFILE_START(if_eval_check);
        PROFILE_START(eval_check);
        auto res = z3_check(state, c->get_z3_value());
        PROFILE_END(eval_check);
        PROFILE_END(if_eval_check);
        if (res == Z3Result::Unknown)
        {
            profile_log_eval_if_unsolved(string(*iff->cond.get()));
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
            profile_log_eval_if_solved(string(*iff->cond.get()));
            state->conds->push_back(c->get_z3_value());
            return _cache(z3_eval(proj, iff->then_body.get(), state));
        }
        else
        {
            profile_log_eval_if_solved(string(*iff->cond.get()));
            state->conds->push_back(!c->get_z3_value());
            return _cache(z3_eval(proj, iff->else_body.get(), state));
        }
    }
    else if (auto forall = instance_of(val, Forall))
    {
        z3::expr_vector vars(z3ctx);
        std::vector<z3::expr> hypos;
        for (auto v = forall->vars->begin(); v != forall->vars->end(); v++)
        {
            if ((*v)->type) {
                auto var = (*v)->type->declare((*v)->name, val->nid);
                (*state->vars)[(*v)->name] = var;
                vars.push_back(var->get_z3_value());
            } else {
                // bounded variable v is prop, push into state
                auto prop = z3_eval(proj, (*v)->expr.get(), state);
                hypos.push_back(prop->get_z3_value());
            }
        }
        /** bounded variables may have a newer nid over cached z3 values, so we need to clear cached value first  */
        forall->clear_z3_eval();
        auto body = z3_eval(proj, forall->body.get(), state);
        auto p = body->get_z3_value();

        for (const auto &h : hypos) {
            p = z3::implies(h, p);
        }
        return _cache(make_shared<BoolValue>(z3::forall(vars, p)));
        // return _cache(make_shared<BoolValue>(z3::forall(vars, body->value)));
    }
    else if (auto exsts = instance_of(val, Exists))
    {
        z3::expr_vector vars(z3ctx);
        for (auto v = exsts->vars->begin(); v != exsts->vars->end(); v++)
        {
            auto var = (*v)->type->declare((*v)->name, val->nid);
            (*state->vars)[(*v)->name] = var;
            vars.push_back(var->get_z3_value());
        }
        exsts->clear_z3_eval();
        auto body = z3_eval(proj, exsts->body.get(), state);
        return _cache(make_shared<BoolValue>(z3::exists(vars, body->value)));
    }

    throw std::runtime_error("Unknown node type: " + string(*val));

}
} // namespace autov
