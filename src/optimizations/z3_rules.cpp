#include <nodes.h>
#include <any>
#include <variant>
#include <unordered_set>
#include <project.h>
#include <algorithm>
#include <boost/functional/hash.hpp>
#include <values.h>
#include <rules.h>
#include <z3_rules.h>
#include <vector>
#include <boost/functional/hash.hpp>
#include <profile.h>
#include <cmd.h>

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
using autov::SpecValue;
using autov::IndValue;
using autov::StructValue;

using std::set;
using std::sort;
using std::unordered_map;
using std::shared_ptr;
using std::vector;

unordered_map<unsigned, unsigned> length_z3_map;
std::unique_ptr<SpecNode> subst_expr(
    Project* proj,
    std::unique_ptr<SpecNode> spec,
    const std::unique_ptr<SpecNode>& expr,
    const std::unique_ptr<SpecNode>& var,
    bool& succ
);

void resolve_pattern(Project* proj, SpecNode* spec, SpecNode* pat, shared_ptr<SpecValue> src, shared_ptr<EvalState> state)
{
    if (auto sym = instance_of(pat, Symbol)) {
        if (proj->is_ind_constr(sym->text)) {
            auto t = dynamic_pointer_cast<Inductive>(src->get_type());
            state->conds->push_back(src->get_z3_value() == t->construct(sym->text, {})->get_z3_value());
        }
        else {
            ((*state->vars))[sym->text] = src;
        }
    } else if (auto con = instance_of(pat, Const)) {
        if (auto v = std::get_if<unsigned long>(&con->value))
            state->conds->push_back(src->get_z3_value() == z3ctx.int_val((long)*v));
        else if (auto v = std::get_if<bool>(&con->value))
            state->conds->push_back(src->get_z3_value() == z3ctx.bool_val(*v));
        else if (auto v = std::get_if<string>(&con->value))
            state->conds->push_back((src->get_z3_value() == z3ctx.string_val(*v)).simplify());
        else
            throw std::runtime_error("Unknown const type: " + string(*pat));
    } else if (auto con = instance_of(pat, IntConst)) {
        state->conds->push_back(src->get_z3_value() == z3ctx.int_val((long)std::get<unsigned long>(con->value)));
    } else if (auto con = instance_of(pat, BoolConst)) {
        state->conds->push_back(src->get_z3_value() == z3ctx.bool_val(std::get<bool>(con->value)));
    } else if (auto con = instance_of(pat, StringConst)) {
        state->conds->push_back(src->get_z3_value() == z3ctx.string_val(std::get<string>(con->value)));
    } else if (auto expr = instance_of(pat, Expr)) {
        if (op_eq(expr->op, Expr::Some)) {
            auto t = dynamic_pointer_cast<Option>(src->get_type());
            auto v = t->elem_type->declare("v", spec->nid);
            if (auto tuple_type = dynamic_pointer_cast<Tuple>(t->elem_type)) {
                auto tuple_elems = instance_of(expr->elems->at(0).get(), Expr)->elems.get(); // Seems like a bug here
                if (tuple_elems->size() == 2) {
                    // assume the tuple is (symbol, symbol)?
                    auto sym0 = instance_of(tuple_elems->at(0).get(), Symbol);
                    auto sym1 = instance_of(tuple_elems->at(1).get(), Symbol);
                    auto elem0 = sym0->type->declare(sym0->text, sym0->nid); // nid or id?
                    auto elem1 = sym1->type->declare(sym1->text, sym1->nid); // nid or id?
                    state->vars->emplace(sym0->text, elem0);
                    state->vars->emplace(sym1->text, elem1);
                }
            }
            auto value = dynamic_pointer_cast<IndValue>(src)->get("value");
            resolve_pattern(proj, spec, expr->elems->at(0).get(), value, state);
        } else if (op_eq(expr->op, Expr::Tuple)) {
            for (int i = 0; i < expr->elems->size(); i++) {
                resolve_pattern(proj, spec, expr->elems->at(i).get(), dynamic_pointer_cast<StructValue>(src)->get(i), state);
            }
        } else if (op_eq(expr->op, Expr::CONCAT)) {
            auto t = dynamic_pointer_cast<List>(src->get_type());
            auto hh = t->elem_type->declare("h", spec->nid);
            auto tt = t->declare("t", spec->nid);
            resolve_pattern(proj, spec, expr->elems->at(0).get(), dynamic_pointer_cast<IndValue>(src)->get("head"), state);
            resolve_pattern(proj, spec, expr->elems->at(1).get(), dynamic_pointer_cast<IndValue>(src)->get("tail"), state);
        } else if (op_eq(expr->op, Expr::None)) {
            auto t = dynamic_pointer_cast<Inductive>(src->get_type());
            auto v = t->construct("None", {});

            state->conds->push_back(src->get_z3_value() == v->get_z3_value());
        } else if (std::holds_alternative<string>(expr->op)) {
            auto op = std::get<string>(expr->op);
            auto sym = proj->symbols.find(op);
            if (sym != proj->symbols.end() && sym->second.kind == SymbolKind::IndConstructor) {
                auto t = dynamic_pointer_cast<Inductive>(src->get_type());
                std::vector<shared_ptr<SpecValue>> vars;
                for (int i = 0; i < t->constr[op]->size(); i++) {
                    auto arg = t->constr[op]->at(i);
                    resolve_pattern(proj, spec, expr->elems->at(i).get(), dynamic_pointer_cast<IndValue>(src)->get(arg->name), state);
                }
            } else
                throw std::runtime_error("Unknown pattern(" + std::to_string(__LINE__) + "): " + string(*pat));
        } else
            throw std::runtime_error("Unknown pattern(" + std::to_string(__LINE__) + "): " + string(*pat));
    } else
        throw std::runtime_error("Unknown pattern(" + std::to_string(__LINE__) + "): " + string(*pat));
}

void collect_exprs(SpecNode* expr, unordered_map<unsigned, std::pair<z3::expr, SpecNode*>>& subexprs) {
    if (auto expr_ = instance_of(expr, Expr)) {
        for (auto e = expr_->elems->begin(); e != expr_->elems->end(); e++) {
            collect_exprs(e->get(), subexprs);
        }
    }
    if (expr->cached_eval) {
        unsigned h = expr->cached_eval->get_z3_value().hash();
        if (subexprs.find(h) == subexprs.end() || expr->length < subexprs.find(h)->second.second->length) {
            SpecNode *expr_copy = expr->deep_copy().release();
            expr_copy->cached_eval = expr->cached_eval;
            subexprs.emplace(h, std::make_pair(expr_copy->cached_eval->get_z3_value(), expr_copy));
        }
    }
}

unsigned long length_of_exp(SpecNode* e) {
    if (auto sym = instance_of(e, Symbol)) return 1;
    if (auto con = instance_of(e, Const)) return 1;
    if (auto con = instance_of(e, IntConst)) return 1;
    if (auto con = instance_of(e, StringConst)) return 1;
    if (auto con = instance_of(e, BoolConst)) return 1;
    if (auto con = instance_of(e, Declaration)) return 1;
    if (auto rec = instance_of(e, RecordDef)) {
        unsigned l = 0;
        for (auto f = rec->fields->begin(); f != rec->fields->end(); f++) {
            l += length_of_exp(f->second.get());
        }
        return l;
    }
    if (auto exp = instance_of(e, Expr)) {
        unsigned l = 0;
        if(exp->elems){
            for (auto elem = exp->elems->begin(); elem != exp->elems->end(); elem++) {
                l += length_of_exp(elem->get());
            }
        }
        return l;
    }
    if (auto pm = instance_of(e, PatternMatch)) {
        return length_of_exp(pm->pattern.get()) + length_of_exp(pm->body.get());
    }
    if (auto m = instance_of(e, Match)) {
        unsigned l = length_of_exp(m->src.get());
        for (auto ml = m->match_list->begin(); ml != m->match_list->end(); ml++) {
            l += length_of_exp(ml->get());
        }
        return l;
    }
    if (auto r = instance_of(e, RelyAnno)) {
        return length_of_exp(r->prop.get()) + length_of_exp(r->body.get());
    }
    if (auto i = instance_of(e, If)) {
        return length_of_exp(i->cond.get()) + length_of_exp(i->then_body.get()) + length_of_exp(i->else_body.get());
    }
    if (auto f = instance_of(e, Forall)) {
        return length_of_exp(f->body.get());
    }
    if (auto f = instance_of(e, Exists)) {
        return length_of_exp(f->body.get());
    }
    else if (auto d = instance_of(e, Definition)) {
        return length_of_exp(d->body.get());
    }
    else throw std::runtime_error("Unknown node type: " + std::string(typeid(e).name()));
}

unsigned length_z3_val(z3::expr z3_val) {
    if (z3_val.is_var() || z3_val.is_const()) return 1;
    else if (z3_val.is_app()) {
        unsigned l_s = 0;
        for (int i = 0; i < z3_val.num_args(); i++) {
            l_s += length_z3_val(z3_val.arg(i));
        }
        return l_s;
    }
    else if (z3_val.is_quantifier()) {
        return length_z3_val(z3_val.body()) + 1;
    }
    else throw std::runtime_error("Unknown z3_val type");
}

static z3::sort bv64 = z3ctx.bv_sort(64);
static SpecNode* reconstruct_expr(z3::expr z3_val,
                           unordered_map<unsigned, std::pair<z3::expr, SpecNode*>>& subexprs,
                           shared_ptr<EvalState> state) {
    //std::cout << "reconstruct_expr: " << z3_val << std::endl;
    if (z3_val.is_const() && z3_val.is_int() && z3_val.is_numeral()) {
        int64_t _v;
        if (z3_val.is_numeral_i64(_v)) {
            long v = z3_val.get_numeral_int64();

            if (v < 0) {
                auto new_elems = make_unique<vector<unique_ptr<SpecNode>>>();

                new_elems->push_back(make_unique<IntConst>(-v));
                return new Expr(Expr::MINUS, std::move(new_elems), Int::INT);
            } else
                return new IntConst(z3_val.get_numeral_int64());
        } else {
            /** 
             * When simplifying the arithmetic operation, spoq may introduce implicit conversion from u64 to s64 in term transposition,
             * These terms should not be simplified to IntConst, but should be converted to constraints by z3.
             *  by Ganxiang Yang, Nov 29, 2024 */
            uint64_t __v;
            if (!z3_val.is_numeral_u64(__v)) {
                LOG_WARNING << "Large integer greater than 2^64 - 1 / Implicit conversion from u64 to s64: " << z3_val.to_string() << std::endl;
                return nullptr;
            }

            long v = z3_val.get_numeral_uint64();
            if (v > -100 && v < 0) {
                auto new_elems = make_unique<vector<unique_ptr<SpecNode>>>();

                new_elems->push_back(make_unique<IntConst>(-v));
                return new Expr(Expr::MINUS, std::move(new_elems), Int::INT);
            } else
                return new IntConst(z3_val.get_numeral_uint64());
        }
    } else if (z3_val.is_const() && z3_val.is_bool()) {
        return new BoolConst(z3_val.is_true());
    } else {
        auto candidates = vector<SpecNode*>();
        auto z3_val_hash = z3_val.hash();
        if (length_z3_map.find(z3_val_hash) == length_z3_map.end()) {
            length_z3_map.emplace(z3_val_hash, length_z3_val(z3_val));
        }
        auto z3_val_length = length_z3_map[z3_val_hash];

        std::vector<std::pair<z3::expr, SpecNode*>> sorted_subexprs;
        for (auto s = subexprs.begin(); s != subexprs.end(); ++s) {
            sorted_subexprs.push_back(s->second);
        }
        std::sort(sorted_subexprs.begin(), sorted_subexprs.end(), [](auto a, auto b) {
            return a.second->length < b.second->length;
        });

        for (auto e = sorted_subexprs.begin(); e != sorted_subexprs.end(); e++) {
            auto e_val = e->first;
            auto e_node = e->second;
            auto e_val_hash = e_val.hash();

            if (length_z3_map.find(e_val_hash) == length_z3_map.end()) {
                length_z3_map.emplace(e_val_hash, length_z3_val(e_val));
            }

            auto z3_e_val_length = length_z3_map[e_val_hash];

            if (z3_e_val_length > z3_val_length)
                continue;
            if (!__OPT_ON_ARITH) {
                if (z3::eq(e_val.get_sort(), z3_val.get_sort())) {
                    // LOG_INFO << "[PROFILE]" << "reconstruct: z3_check: equivalency check";
                    PROFILE_START(expr_rule_check);
                    PROFILE_START(z3_rule_check);
                    auto equiv_check_ret = z3_check(state, e_val == z3_val);
                    PROFILE_END(z3_rule_check);
                    PROFILE_END(expr_rule_check);

                    if (equiv_check_ret != Z3Result::Unknown) {
                        profile_log_rule_expr_solved(string(*e_node));
                    } else {
                        profile_log_rule_expr_unsolved(string(*e_node));
                    }

                    if (equiv_check_ret == Z3Result::True) {
                        candidates.push_back(e_node);
                    }
                }
            }
        }

        if (z3_val.is_arith() && z3_val.num_args() > 0) {
            auto elems = vector<SpecNode*>();
            for (int i = 0; i < z3_val.num_args(); i++) {
                auto e = reconstruct_expr(z3_val.arg(i), subexprs, state);
                if (e)
                    elems.push_back(e);
                else
                    return nullptr;
            }

            auto op = z3_val.decl().name().str();
            auto e = instance_of(elems[0], Expr);
            if (op == "+" || op == "-" || op == "*" || op == "/" || op == "mod") {
                static const auto z3_op_to_expr_binop = unordered_map<string, Expr::binops>{
                    {"+", Expr::ADD},
                    {"-", Expr::MINUS},
                    {"*", Expr::MULT},
                    {"/", Expr::DIV},
                    {"mod", Expr::MOD},
                };
                auto expr_elems = make_unique<vector<unique_ptr<SpecNode>>>();
                expr_elems->push_back(unique_ptr<SpecNode>(elems[0]));
                expr_elems->push_back(unique_ptr<SpecNode>(elems[1]));
                auto expr = new Expr(z3_op_to_expr_binop.at(op), std::move(expr_elems), Int::INT);
                for (int i = 2; i < elems.size(); i++) {
                    auto new_elems = make_unique<vector<unique_ptr<SpecNode>>>();
                    new_elems->push_back(unique_ptr<SpecNode>(expr));
                    new_elems->push_back(unique_ptr<SpecNode>(elems[i]));
                    expr = new Expr(z3_op_to_expr_binop.at(op), std::move(new_elems), Int::INT);
                }
                candidates.push_back(expr);
            } else if (op == "Not") {
#define rev_map(op0, op1) {op0, op1}, {op1, op0}
                static const auto rev = unordered_map<Expr::binops, Expr::binops>{
                    rev_map(Expr::BEQ, Expr::BNE),
                    rev_map(Expr::BGE, Expr::BLT),
                    rev_map(Expr::BLE, Expr::BGT),
                    rev_map(Expr::EQUAL, Expr::NOT_EQUAL),
                    rev_map(Expr::GT, Expr::LTE),
                    rev_map(Expr::LT, Expr::GTE),
                };

                if (std::holds_alternative<string>(e->op) && rev.find(std::get<Expr::binops>(e->op)) != rev.end()) {
                    auto new_args = make_unique<vector<unique_ptr<SpecNode>>>();
                    new_args->push_back(unique_ptr<SpecNode>(e->elems->at(0).release()));
                    new_args->push_back(unique_ptr<SpecNode>(e->elems->at(1).release()));
                    candidates.push_back(new Expr(rev.at(std::get<Expr::binops>(e->op)), std::move(new_args), Bool::BOOL));
                } else {
                    auto new_args = make_unique<vector<unique_ptr<SpecNode>>>();
                    new_args->push_back(unique_ptr<SpecNode>(elems[0]));
                    candidates.push_back(new Expr(Expr::BNOT, std::move(new_args), Bool::BOOL));
                }
            } else if (op == "<" || op == ">" || op == "<=" || op == ">=") {
                static const auto z3_op_to_expr_bool_op = unordered_map<string, Expr::binops>{
                    {"<", Expr::BLT},
                    {">", Expr::BGT},
                    {"<=", Expr::BLE},
                    {">=", Expr::BGE},
                };
                auto new_args = make_unique<vector<unique_ptr<SpecNode>>>();
                new_args->push_back(unique_ptr<SpecNode>(e->elems->at(0).release()));
                new_args->push_back(unique_ptr<SpecNode>(e->elems->at(1).release()));
                candidates.push_back(new Expr(z3_op_to_expr_bool_op.at(op), std::move(new_args), Bool::BOOL));
            }
        }

        std::sort(candidates.begin(), candidates.end(), [](auto a, auto b) {
            return a->length < b->length;
        });

        if (candidates.size() > 0) {
#if 0
            for (int i = 1; i < candidates.size(); i++)
                delete candidates[i];
#endif
            return candidates[0];
        } else
            return nullptr;
    }
}

static SpecNode* __simplify_zmap_init(Project* proj, Expr* expr, shared_ptr<EvalState> state) {
    auto elem0 = instance_of(expr->elems->at(0).get(), Expr); // ZMap

    if (!elem0)
        return nullptr;

    auto elem0_op = std::get_if<string>(&elem0->op);

    if (!elem0_op || (*elem0_op != "ZMap.init" && *elem0_op != "zmap_init"))
        return nullptr;

    // elem0 is ZMap.init, regardless of the second argument, return the default value
    auto expr_op = std::get_if<Expr::ops>(&expr->op);
    if (!expr_op || *expr_op != Expr::GET)
        return nullptr;

    assert(elem0->elems->size() == 1);
    //std::cout << "simplfy " << string(*expr) << " to " << string(*elem0->elems->at(0)) << std::endl;
    return elem0->elems->at(0).release();
}

SpecNode* reconstruct_zmap(Project* proj, SpecNode* spec, shared_ptr<EvalState> state) {
    auto expr = instance_of(spec, Expr);
    auto elem0 = instance_of(expr->elems->at(0).get(), Expr); // ZMap
    auto elem1 = expr->elems->at(1).get(); // index

    if (elem0 && elem0->elems->size() > 1 && is_instance(elem0->elems->at(1).get(), Symbol))
        return nullptr;

    if (auto ret = __simplify_zmap_init(proj, expr, state))
        return ret;

    // If not potential ZMap.gss, ZMap.set2, ZMap.gso, skip Z3 checks and early return
    auto expr_op = std::get_if<Expr::ops>(&expr->op);
    if (!expr_op)
        return nullptr;

    auto elem0_op = std::get_if<Expr::ops>(&elem0->op);
    if (!elem0_op)
        return nullptr;

    if (!(*expr_op == Expr::GET && *elem0_op == Expr::SET) &&   // ZMap.gss
        !(*expr_op == Expr::SET && *elem0_op == Expr::SET) &&   // ZMap.set2
        !(*expr_op == Expr::GET && *elem0_op == Expr::SET))     // ZMap.gso
        return nullptr;

    PROFILE_START(z3_eval);
    auto idx = z3_eval(proj, elem1, state);
    auto res = z3_eval(proj, elem0->elems->at(1).get(), state);
    PROFILE_END(z3_eval);

    PROFILE_START(expr_rule_check);
    PROFILE_START(z3_rule_check);
    auto z3_res = z3_check(state, res->get_z3_value() == idx->get_z3_value());
    PROFILE_END(z3_rule_check);
    PROFILE_END(expr_rule_check);

    if (z3_res == Z3Result::True) {
        if (*elem0_op == Expr::SET) {
            if (*expr_op == Expr::SET) {
                // ZMap.set2
                auto new_elems = make_unique<vector<unique_ptr<SpecNode>>>();

                new_elems->push_back(std::move(elem0->elems->at(0)));
                new_elems->push_back(std::move(elem0->elems->at(1)));
                new_elems->push_back(std::move(expr->elems->at(2)));

                return new Expr(Expr::SET, std::move(new_elems), expr->get_type());
            } else if (*expr_op == Expr::GET) {
                // ZMap.gss
                if (auto elem2 = instance_of(elem0->elems->at(2).get(), Expr)) {
                    return elem0->elems->at(2).release(); // XXX: fail safe way: elem2->deep_copy().release();
                } else
                    return nullptr;
            }
        }
    } else if (z3_res == Z3Result::False) {
        if (*expr_op == Expr::GET && *elem0_op == Expr::SET)  {
            // ZMap.gso
            auto new_elems = make_unique<vector<unique_ptr<SpecNode>>>();

            new_elems->push_back(std::move(elem0->elems->at(0)));
            new_elems->push_back(std::move(expr->elems->at(1)));

            return new Expr(Expr::GET, std::move(new_elems), expr->get_type());
        }
    }
    return nullptr;
}

unordered_map<size_t, bool> converged_spec;
unordered_map<size_t, string> spec_hash_collisions;
unsigned long z3_global_hash_hit = 0;
unsigned long z3_global_hash_total = 0;
#define Z3_OPT_CACHE

smart_rule_ret_t SpecRules::simple_rely_by_z3(std::unique_ptr<RelyAnno> spec, std::shared_ptr<EvalState> state) {
    bool changed = false;
    auto orig_prop = std::string(*spec->prop);

    bool is_rely = is_instance(spec.get(), Rely);
    auto ret = this->rule_simple_by_z3(std::move(spec->prop), state);
    changed |= ret.second;

    auto cond = std::move(ret.first);
    if (cond == nullptr) {
        return { nullptr, changed }; 
    }

    PROFILE_START(z3_eval);
    auto c = z3_eval(proj, cond.get(), state);
    PROFILE_END(z3_eval);


    if (__OPT_ON_RELY) {
        state->conds->push_back(c->get_z3_value());
        auto rule_ret = this->rule_simple_by_z3(std::move(spec->body), state);
        state->conds->pop_back();
        changed |= rule_ret.second;
        auto body = std::move(rule_ret.first);
        if (body == nullptr) {
            return { nullptr, changed };
        }

        if (is_rely) {
            return { make_unique<Rely>(std::move(cond), std::move(body)), changed };
        } else {
            return { make_unique<Anno>(std::move(cond), std::move(body)), changed };
        }
    } else {
        PROFILE_START(rely_rule_check);
        PROFILE_START(z3_rule_check);
        auto res = z3_check(state, c->get_z3_value());
        PROFILE_END(z3_rule_check);
        PROFILE_END(rely_rule_check);

        if (res == Z3Result::Unknown) {
            profile_log_rule_rely_unsolved(string(orig_prop));

            state->conds->push_back(c->get_z3_value());
            auto ret = this->rule_simple_by_z3(std::move(spec->body), state);
            state->conds->pop_back();
            changed |= ret.second;
            auto body = std::move(ret.first);
            if (body == nullptr) {
                return { nullptr, changed };
            }

            if (is_rely) {
                return { make_unique<Rely>(std::move(cond), std::move(body)), changed };
            } else {
                return { make_unique<Anno>(std::move(cond), std::move(body)), changed };
            }

        } else if (res == Z3Result::True) {
            profile_log_rule_rely_solved(string(orig_prop));
            auto body_ret = this->rule_simple_by_z3(std::move(spec->body), state);
            changed |= body_ret.second;
            return { std::move(body_ret.first), true };
        } else {
            profile_log_rule_rely_solved(string(orig_prop));
            return std::make_pair(nullptr, true);

        }
    }
}

smart_rule_ret_t SpecRules::simple_if_by_z3(std::unique_ptr<If> spec, std::shared_ptr<EvalState> state) {
    bool changed = false;
    auto orig_cond = string(*spec->cond);

    auto cond_ret = this->rule_simple_by_z3(std::move(spec->cond), state);
    if (cond_ret.first == nullptr) {
        throw std::runtime_error("If condition is false3: " + orig_cond);
        // return std::make_pair(nullptr, cond_ret.second);
    }
    PROFILE_START(z3_eval);
    auto c = z3_eval(proj, cond_ret.first.get(), state);
    PROFILE_END(z3_eval);

    PROFILE_START(if_rule_check);
    PROFILE_START(z3_rule_check);
    auto res = z3_check(state, c->get_z3_value());
    PROFILE_END(z3_rule_check);
    PROFILE_END(if_rule_check);

    if (res == Z3Result::Unknown) {
        profile_log_rule_if_unsolved(string(orig_cond));
        auto unknown_value = c->get_z3_value();

        state->conds->push_back(unknown_value);
        auto then_ret = this->rule_simple_by_z3(std::move(spec->then_body), state);

        state->conds->back() = !unknown_value;
        auto else_ret = this->rule_simple_by_z3(std::move(spec->else_body), state);

        changed |= then_ret.second || else_ret.second;

        if (then_ret.first) {
            then_ret.first = subst_expr(proj, std::move(then_ret.first), cond_ret.first, 
                                                std::make_unique<BoolConst>(true), changed);
        } 
        if (else_ret.first) {
            else_ret.first = subst_expr(proj, std::move(else_ret.first), cond_ret.first, 
                                                std::make_unique<BoolConst>(false), changed);
        }

        if (then_ret.first == nullptr && else_ret.first == nullptr) {
            return std::make_pair(nullptr, changed);
        } else if (then_ret.first == nullptr && is_instance(else_ret.first->get_type().get(), Option)) {
            auto elems = make_unique<vector<unique_ptr<SpecNode>>>();
            elems->push_back(std::move(cond_ret.first));
            elems->push_back(unique_ptr<SpecNode>(new BoolConst(false)));
            auto cond = make_unique<Expr>(Expr::EQUAL, std::move(elems), Prop::PROP);
            return { make_unique<Rely>(std::move(cond), std::move(else_ret.first)), changed };

        } else if (else_ret.first == nullptr && is_instance(then_ret.first->get_type().get(), Option)) {
            auto elems = make_unique<vector<unique_ptr<SpecNode>>>();
            elems->push_back(std::move(cond_ret.first));
            elems->push_back(unique_ptr<SpecNode>(new BoolConst(true)));
            auto cond = make_unique<Expr>(Expr::EQUAL, std::move(elems), Prop::PROP);
            return { make_unique<Rely>(std::move(cond), std::move(then_ret.first)), changed };

        }

        if (!then_ret.first) {
            return { std::move(else_ret.first), true };
        } 
        
        if (!else_ret.first) {
            return { std::move(then_ret.first), true };
        }
        return {
            make_unique<If>(std::move(cond_ret.first), std::move(then_ret.first), std::move(else_ret.first)),
            changed
        };

    } else if (res == Z3Result::True) {
        profile_log_rule_if_solved(string(orig_cond));
        auto ret = this->rule_simple_by_z3(std::move(spec->then_body), state);
        return { std::move(ret.first), true };
    } else {
        profile_log_rule_if_solved(string(orig_cond));
        auto ret = this->rule_simple_by_z3(std::move(spec->else_body), state);
        return { std::move(ret.first), true };
    }
}


smart_rule_ret_t SpecRules::simple_match_by_z3(std::unique_ptr<Match> spec, std::shared_ptr<EvalState> state) {
    string orig_src = string(*spec->src);
    auto src_ret = this->rule_simple_by_z3(std::move(spec->src->deep_copy()), state);

    if (src_ret.first == nullptr) {
        return std::make_pair(nullptr, true);
    }

    PROFILE_START(z3_eval);
    auto src_val = z3_eval(proj, src_ret.first.get(), state);
    PROFILE_END(z3_eval);
    auto match_list = make_unique<vector<unique_ptr<PatternMatch>>>();

    bool changed = src_ret.second;

    for (auto pm = spec->match_list->begin(); pm != spec->match_list->end(); pm++) {
        auto new_state = state->copy();
        resolve_pattern(proj, spec.get(), (*pm)->pattern.get(), src_val, new_state);
        if (!__OPT_ON_MATCH) {
            // skip unnecessary reconstruct check        
        }
        auto body_ret = this->rule_simple_by_z3(std::move((*pm)->body), new_state);
        changed |= body_ret.second;
        if (body_ret.first) {
            match_list->push_back(make_unique<PatternMatch>(std::move((*pm)->pattern), std::move(body_ret.first)));
        }

    }

    if (auto src_opt = dynamic_pointer_cast<Option>(src_ret.first->get_type())) {
        if (auto spec_opt = dynamic_pointer_cast<Option>(spec->get_type())) {
            bool has_some = false;
            bool has_none = false;

            for (auto pm = match_list->begin(); pm != match_list->end(); pm++) {
                if (auto expr = instance_of((*pm)->pattern.get(), Expr)) {
                    if (op_eq(expr->op, Expr::Some))
                        has_some = true;
                    else if (op_eq(expr->op, Expr::None))
                        has_none = true;
                } else if (auto sym = instance_of((*pm)->pattern.get(), Symbol)) {
                    if (sym->text == "None") {
                        has_none = true;
                    } else if (sym->text == "_") {
                        has_some = true;
                        has_none = true;
                    }
                }
            }
            if (!has_some || !has_none) {
                changed = true;
                match_list->push_back(make_unique<PatternMatch>(make_unique<Symbol>("_", src_opt), make_unique<Symbol>("None", spec->get_type())));
            }
        }
    }
    
    if (match_list->size() == 0) {
        return std::make_pair(nullptr, true);
    } else {
        bool only_none = true;

        for (auto pm = match_list->begin(); pm != match_list->end(); pm++) {
            auto body = (*pm)->body.get();
            while (auto rely = dynamic_cast<Rely*>(body)) {
                body = rely->body.get();
            }
            auto sym = instance_of(body, Symbol);
            if (!sym || sym->text != "None") {
                only_none = false;
                break;
            }
        }

        auto typ = spec->get_type();
        if (only_none) {
            return { std::make_unique<Symbol>("None", typ), changed };
        } else {
            return { std::make_unique<Match>(std::move(src_ret.first), std::move(match_list)), changed };
        }
    }
}

smart_rule_ret_t SpecRules::simple_expr_by_z3(std::unique_ptr<Expr> spec, std::shared_ptr<EvalState> state) {
    auto elems = std::make_unique<std::vector<std::unique_ptr<SpecNode>>>();
    bool changed = false;

    if (auto op = std::get_if<Expr::ops>(&spec->op)) {
        if (*op == Expr::None) {
            return { std::move(spec), false };
        }
    }

    for (auto elem = spec->elems->begin(); elem != spec->elems->end(); elem++) {
        auto ret = this->rule_simple_by_z3(std::move(*elem), state);
        changed |= ret.second;

        if (!ret.first) {
            return { nullptr, true };
        }
        elems->push_back(std::move(ret.first));
    }
    auto new_spec = std::make_unique<Expr>(std::move(spec->op), std::move(elems), spec->get_type());

    PROFILE_START(z3_eval);
    auto exp_val = z3_eval(proj, new_spec.get(), state);
    PROFILE_END(z3_eval);

    std::unordered_map<unsigned, std::pair<z3::expr, SpecNode*>> subexprs;
    collect_exprs(new_spec.get(), subexprs);
    if ((new_spec->get_type() == Int::INT || new_spec->get_type() == Bool::BOOL)
        && length_of_exp(new_spec.get()) <= 20) {
        /** FIXME: tiny leak (< 1 MB) here */
        auto _expr = reconstruct_expr(exp_val->get_z3_value(), subexprs, state);

        unique_ptr<SpecNode> expr;
        if (_expr) {
            expr.reset(_expr);
        }

        for (auto& [_, sub] : subexprs) {
            if (sub.second != _expr) {
                delete sub.second;
            }
        }
        subexprs.clear();

        if (expr && length_of_exp(expr.get()) < length_of_exp(new_spec.get())) {
            return { std::move(expr), true };
        }
    }

    for (auto& [_, sub] : subexprs) {
        delete sub.second;
    }
    subexprs.clear();

    if (auto op = std::get_if<Expr::ops>(&new_spec->op)) {
        if (*op == Expr::SET || *op == Expr::GET) {
            /** FIXME: tiny leak (< 1 MB) here */
            auto new_zmap = reconstruct_zmap(proj, new_spec->deep_copy().release(), state);

            if (new_zmap) {
                return { std::unique_ptr<SpecNode>(new_zmap), true };
            }
        }
    }

    return { std::move(new_spec), changed };
}

smart_rule_ret_t SpecRules::rule_simple_by_z3(std::unique_ptr<SpecNode> spec, std::shared_ptr<EvalState> state) {
    bool changed = false;

#ifdef Z3_OPT_CACHE
    z3_global_hash_total++;
    size_t spec_hash = boost::hash<std::string>()(std::string(*spec));
    if (converged_spec.find(spec_hash) != converged_spec.end()) {
        z3_global_hash_hit++;
        return { std::move(spec), false };
    }
#endif

    state = state->copy();
    if (is_instance(spec.get(), Symbol) || is_instance(spec.get(), Const)) {
        return { std::move(spec), false };
    }
    else if (auto expr = instance_of(spec.get(), Expr)) {
        return simple_expr_by_z3(std::unique_ptr<Expr>(static_cast<Expr*>(spec.release())), state);
    }
    else if (auto match = instance_of(spec.get(), Match)) {
        return simple_match_by_z3(std::unique_ptr<Match>(static_cast<Match*>(spec.release())), state);
    }
    else if (auto rely = instance_of(spec.get(), RelyAnno)) {
        return simple_rely_by_z3(std::unique_ptr<RelyAnno>(static_cast<RelyAnno*>(spec.release())), state);
    }
    else if (auto if_ = instance_of(spec.get(), If)) {
        return simple_if_by_z3(std::unique_ptr<If>(static_cast<If*>(spec.release())), state);
    }
    else if (auto forall = instance_of(spec.get(), Forall)) {
        for (auto& v : *forall->vars) {
            if (v->type) {
                auto var = v->type->declare(v->name, forall->nid);
                (*state->vars)[v->name] = var;
            } else {
                assert(v->expr);
            }
        }
        forall->clear_z3_eval();
        auto res = this->rule_simple_by_z3(std::move(forall->body), state);
        return { std::make_unique<Forall>(std::move(forall->vars), std::move(res.first)), res.second };
    }
    else if (auto exists = instance_of(spec.get(), Exists)) {
        for (auto& v : *exists->vars) {
            assert(v->type);
            (*state->vars)[v->name] = v->type->declare(v->name, exists->nid);
        }
        exists->clear_z3_eval();
        auto res = this->rule_simple_by_z3(std::move(exists->body), state);
        return { std::make_unique<Exists>(std::move(exists->vars), std::move(res.first)), res.second };
    }
    else {
        throw std::runtime_error("Unknown node type: " + std::string(typeid(*spec).name()));
    }

#ifdef Z3_OPT_CACHE
    if (!changed) {
        converged_spec.emplace(spec_hash, true);
    }
#endif
    return { std::move(spec), changed };
}

} // namespace autov
