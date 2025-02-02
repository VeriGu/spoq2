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
SpecNode *subst_expr(Project *proj, SpecNode *spec, SpecNode *expr, SpecNode *var, bool &succ);

// It is probably bad to merge relys if all conditions are conjuncted
rule_ret_t merge_rely(Project* proj, SpecNode* spec, shared_ptr<EvalState> state) {
    bool changed = false;
    if (auto expr = instance_of(spec, Expr)) {
        // do nothing
    }
    else if (auto sym = instance_of(spec, Symbol)) {
        (*state->vars)[sym->text] = sym->type->declare(sym->text, sym->nid);
    }
    else if (auto match = instance_of(spec, Match)) {
        for (auto pm = match->match_list->begin(); pm != match->match_list->end(); pm++) {
            if (auto sym = instance_of((*pm)->pattern.get(), Symbol)) {
                (*state->vars)[sym->text] = sym->type->declare(sym->text, match->nid);
            }
            else {
                auto expr = instance_of((*pm)->pattern.get(), Expr);
                if (!expr) throw std::runtime_error("Pattern match must be a symbol or an expression");
                for (auto e = expr->elems->begin(); e != expr->elems->end(); e++) {
                    if (auto sym = instance_of(e->get(), Symbol)) {
                        (*state->vars)[sym->text] = sym->type->declare(sym->text, match->nid);
                    }
                    else {
                        auto ee = instance_of(e->get(), Expr);
                        if (ee && is_instance(ee->type.get(), Tuple)) {
                            for (auto ele = ee->elems->begin(); ele != ee->elems->end(); ele++) {
                                if (auto sym = instance_of(ele->get(), Symbol)) {
                                    (*state->vars)[sym->text] = sym->type->declare(sym->text, match->nid);
                                }
                            }
                        }
                    }
                }
            }
            auto ret = merge_rely(proj, (*pm)->body.release(), state);
            changed |= ret.second;
            (*pm)->body.reset(ret.first);
        }
    }
    else if (auto if_ = instance_of(spec, If)) {
        auto merged_then = merge_rely(proj, if_->then_body.release(), state);
        auto merged_else = merge_rely(proj, if_->else_body.release(), state);
        changed |= merged_then.second || merged_else.second;
        if_->then_body.reset(merged_then.first);
        if_->else_body.reset(merged_else.first);
    }
    else if (auto rely = instance_of(spec, Rely)) {
        vector<z3::expr> conds;
        auto cond = z3_eval(proj, rely->prop.get(), make_shared<EvalState>(state->vars));
        conds.push_back(cond->get_z3_value());
        int i = -1;
        auto spec1 = rely;
        while (auto rely1 = dynamic_cast<Rely*>(spec1)) {
            if (auto rely2 = dynamic_cast<Rely*>(rely1->body.get())) {
                PROFILE_START(z3_eval);
                auto cond = z3_eval(proj, rely2->prop.get(), make_shared<EvalState>(state->vars));
                PROFILE_END(z3_eval);
                conds.push_back(cond->get_z3_value());
                spec1 = rely2;
            }
            else break;
        }

        while (auto rely1 = dynamic_cast<Rely*>(rely)) {
            if (auto rely2 = dynamic_cast<Rely*>(rely1->body.get())) {
                i += 1;
                PROFILE_START(z3_eval);
                auto cond = z3_eval(proj, rely1->prop.get(), make_shared<EvalState>(state->vars));
                PROFILE_END(z3_eval);

                auto tmp_conds = std::make_shared<vector<z3::expr>>();
                tmp_conds->insert(tmp_conds->end(), conds.begin(), conds.begin() + i);
                tmp_conds->insert(tmp_conds->end(), conds.begin() + i + 1, conds.end());
                auto res = z3_check(make_shared<EvalState>(state->vars, tmp_conds), cond->get_z3_value());

                if (res == Z3Result::Unknown) {
                    auto new_conds = new vector<unique_ptr<SpecNode>>();
                    new_conds->push_back(unique_ptr<SpecNode>(rely1->prop.release()));
                    new_conds->push_back(unique_ptr<SpecNode>(rely2->prop.release()));
                    rely1->prop.reset(new Expr(Expr::AND, unique_ptr<vector<unique_ptr<SpecNode>>>(new_conds), Prop::PROP));
                    rely1->body.reset(rely2->body.release());
                    delete rely2;
                }
                else if (res == Z3Result::True) {
                    rely1->prop.reset(rely2->prop.release());
                    rely1->body.reset(rely2->body.release());
                    delete rely2;
                }
                else {
                    rely1->prop.reset(new Expr("false", make_unique<vector<unique_ptr<SpecNode>>>(), Prop::PROP));
                    rely1->body.reset(rely2->body.release());
                    delete rely2;
                }
                changed = true;
            }
        }
        auto ret = merge_rely(proj, rely->body.release(), state);
        changed |= ret.second;
        rely->body.reset(ret.first);
    }
    else {
        throw std::runtime_error("Unknown node type: " + std::string(typeid(spec).name()));
    }
    return std::make_pair(spec, changed);
}

rule_ret_t remove_rely_by_z3(Project* proj, SpecNode* spec, shared_ptr<EvalState> state) {
    return merge_rely(proj, spec, state);
}

rule_ret_t simple_rely_by_z3(Project* proj, RelyAnno* spec, shared_ptr<EvalState> state) {
    bool changed = false;
    auto orig_prop = string(*spec->prop);
    bool is_rely = is_instance(spec, Rely);
    auto ret = rule_simple_by_z3(proj, spec->prop.release(), state);
    changed |= ret.second;
    auto cond = ret.first;
    if (cond == nullptr) {
        delete spec;
        //throw std::runtime_error("Rely condition is false: " + orig_prop);
        return std::make_pair(nullptr, changed);
    }
    PROFILE_START(z3_eval);
    auto c = z3_eval(proj, cond, state);
    PROFILE_END(z3_eval);

    // LOG_INFO << "[PROFILE]" << "simple_rely_by_z3: z3_check: " << string(*cond);
    PROFILE_START(rely_rule_check);
    PROFILE_START(z3_rule_check);
    auto res = z3_check(state, c->get_z3_value());
    PROFILE_END(z3_rule_check);
    PROFILE_END(rely_rule_check);

    if (res == Z3Result::Unknown) {
        profile_log_rule_rely_unsolved(string(orig_prop));
        state->conds->push_back(c->get_z3_value());
        auto ret = rule_simple_by_z3(proj, spec->body.release(), state);
        state->conds->pop_back(); // newly added. Old code might have bug here
        changed |= ret.second;
        auto body = ret.first;
        if (body == nullptr) {
            delete cond;
            delete spec;
            //throw std::runtime_error("Rely condition is false1: " + orig_prop);
            return std::make_pair(nullptr, changed);
        }

        if (is_rely)
            return std::make_pair(new Rely(unique_ptr<SpecNode>(cond), unique_ptr<SpecNode>(body)), changed);
        else
            return std::make_pair(new Anno(unique_ptr<SpecNode>(cond), unique_ptr<SpecNode>(body)), changed);
    } else if (res == Z3Result::True) {
        profile_log_rule_rely_solved(string(orig_prop));
        auto ret = rule_simple_by_z3(proj, spec->body.release(), state);
        delete cond;
        delete spec;
        return ret;
    } else {
        profile_log_rule_rely_solved(string(orig_prop));
        delete cond;
        delete spec;
        //throw std::runtime_error("Rely condition is false2: " + orig_prop);
        return std::make_pair(nullptr, true);
    }
}

rule_ret_t simple_if_by_z3(Project* proj, If* spec, shared_ptr<EvalState> state) {
    bool changed = false;
    // auto orig_then = string(*spec->then_body);
    // auto orig_else = string(*spec->else_body);
    auto orig_cond = string(*spec->cond);
    //bool debug = false && orig_cond == "((((st_1.(stack)).(stack_wi)).(e_g_llt)) >? (0))";

    auto cond_ret = rule_simple_by_z3(proj, spec->cond.release(), state);
    // if (debug)
    //     std::cout << "simple_if_by_z3: orig_cond: " << orig_cond << std::endl;
    if (cond_ret.first == nullptr) {
        delete spec;
        throw std::runtime_error("If condition is false3: " + orig_cond);
        //std::cout << "simple_if_by_z3: nullptr orig_cond: " << orig_cond << std::endl;
        return std::make_pair(nullptr, cond_ret.second);
    }
    // // std::cout << "simple_if_by_z3: cond_ret.first: " << string(*cond_ret.first) << std::endl;
    // if (orig_cond == "(((33686424 - ((33686424 + (((768 * (v_vmid)) + (752)))))) <=? (0)) && (((33686424 + (((768 * (v_vmid)) + (752)))) <? (33701016))))")
    //     std::cout << "here." << std::endl;

    // if (debug)
    //     std::cout << "cond_ret: " << string(*cond_ret.first) << std::endl;
    PROFILE_START(z3_eval);
    auto c = z3_eval(proj, cond_ret.first, state);
    PROFILE_END(z3_eval);
    // if (debug) {
    //     std::cout << "simple_if_by_z3: c: " << c->get_z3_value().simplify() << ", hash: " << c->get_z3_value().hash() << std::endl;
    //     for (const auto &cond: *state->conds) {
    //         std::cout << "simple_if_by_z3: cond: " << cond.simplify() << std::endl;
    //     }
    // }
    // LOG_INFO << "[PROFILE]" << "simple_if_by_z3: z3_check: " << orig_cond;
    PROFILE_START(if_rule_check);
    PROFILE_START(z3_rule_check);
    auto res = z3_check(state, c->get_z3_value());
    PROFILE_END(z3_rule_check);
    PROFILE_END(if_rule_check);

    if (res == Z3Result::Unknown) {
        profile_log_rule_if_unsolved(string(orig_cond));
        //std::cout << "simple_if_by_z3: unknown condition: " << orig_cond << std::endl;
        auto unknown_value = c->get_z3_value();
        //auto then_state = state->copy();

        //then_state->conds->push_back(unknown_value);
        state->conds->push_back(unknown_value);
        // for (const auto &cond: *state->conds) {
        //     std::cout << "simple_if_by_z3: then cond: " << cond << std::endl;
        // }
        auto then_ret = rule_simple_by_z3(proj, spec->then_body.release(), state);
        // std::cout << "simple_if_by_z3: orig then_body: " << string(orig_then) << std::endl;
        // std::cout << "simple_if_by_z3: then_ret.first: " << string(*then_ret.first) << std::endl;

        //auto else_state = state->copy();
        //else_state->conds->push_back(!unknown_value);
        state->conds->back() = !unknown_value;

        // for (const auto &cond: *state->conds) {
        //     std::cout << "simple_if_by_z3: else cond: " << cond << std::endl;
        // }
        auto else_ret = rule_simple_by_z3(proj, spec->else_body.release(), state);
        // std::cout << "simple_if_by_z3: orig else_body: " << string(orig_else) << std::endl;
        // std::cout << "simple_if_by_z3: else_ret.first: " << string(*else_ret.first) << std::endl;

        changed |= then_ret.second || else_ret.second;

        // Replace conditions in then and else bodies
        if (then_ret.first != nullptr) {
            auto true_const = new BoolConst(true);
            then_ret.first = subst_expr(proj, then_ret.first, cond_ret.first, true_const, changed);
            delete true_const;
        } else {
            // std::cout << "simple_if_by_z3: then_ret.first is nullptr" << std::endl;
            // std::cout << "simple_if_by_z3: orig_then: " << orig_then << std::endl;
        }

        if (else_ret.first != nullptr) {
            auto false_const = new BoolConst(false);
            else_ret.first = subst_expr(proj, else_ret.first, cond_ret.first, false_const, changed);
            delete false_const;
        } else {
            // std::cout << "simple_if_by_z3: else_ret.first is nullptr" << std::endl;
            // std::cout << "simple_if_by_z3: orig_else: " << orig_else << std::endl;
        }

        if (then_ret.first == nullptr && else_ret.first == nullptr) {
            delete cond_ret.first;
            //throw std::runtime_error("If condition is false4: " + orig_cond);
            return std::make_pair(nullptr, changed);
        } else if (then_ret.first == nullptr && is_instance(else_ret.first->get_type().get(), Option)) {
            auto elems = make_unique<vector<unique_ptr<SpecNode>>>();
            elems->push_back(unique_ptr<SpecNode>(cond_ret.first));
            elems->push_back(unique_ptr<SpecNode>(new BoolConst(false)));
            auto cond = make_unique<Expr>(Expr::EQUAL, std::move(elems), Prop::PROP);
            delete spec;
            return std::make_pair(new Rely(std::move(cond), unique_ptr<SpecNode>(else_ret.first)), changed);
        } else if (else_ret.first == nullptr && is_instance(then_ret.first->get_type().get(), Option)) {
            auto elems = make_unique<vector<unique_ptr<SpecNode>>>();
            elems->push_back(unique_ptr<SpecNode>(cond_ret.first));
            elems->push_back(unique_ptr<SpecNode>(new BoolConst(true)));
            auto cond = make_unique<Expr>(Expr::EQUAL, std::move(elems), Prop::PROP);
            delete spec;
            return std::make_pair(new Rely(std::move(cond), unique_ptr<SpecNode>(then_ret.first)), changed);
        }

        if (then_ret.first == nullptr) {
            delete cond_ret.first;
            delete spec;
            return std::make_pair(else_ret.first, true);
        }

        if (else_ret.first == nullptr) {
            delete cond_ret.first;
            delete spec;
            return std::make_pair(then_ret.first, true);
        }

        return std::make_pair(new If(unique_ptr<SpecNode>(cond_ret.first), unique_ptr<SpecNode>(then_ret.first), unique_ptr<SpecNode>(else_ret.first)), changed);
    } else if (res == Z3Result::True) {
        profile_log_rule_if_solved(string(orig_cond));
        //std::cout << "simple_if_by_z3: condition is true: " << orig_cond << std::endl;
        auto ret = rule_simple_by_z3(proj, spec->then_body.release(), state);
        delete cond_ret.first;
        delete spec;
        return std::make_pair(ret.first, true);
    } else {
        profile_log_rule_if_solved(string(orig_cond));
        // std::cout << "simple_if_by_z3: condition is false: " << c->get_z3_value() << std::endl;
        // std::cout << "simple_if_by_z3: condition is false: " << orig_cond << std::endl;
        // for (const auto &cond: *state->conds) {
        //     std::cout << "simple_if_by_z3: cond lead to False: " << cond << std::endl;
        // }
        auto ret = rule_simple_by_z3(proj, spec->else_body.release(), state);
        delete cond_ret.first;
        delete spec;
        return std::make_pair(ret.first, true);
    }
}

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

rule_ret_t simple_match_by_z3(Project* proj, Match* spec, shared_ptr<EvalState> state) {
    string orig_src = string(*spec->src);
    auto src_ret = rule_simple_by_z3(proj, spec->src.release(), state);

    if (src_ret.first == nullptr) {
        delete spec;
        //throw std::runtime_error("Match source is false: " + orig_src);
        return std::make_pair(nullptr, true);
    }
    PROFILE_START(z3_eval);
    auto src_val = z3_eval(proj, src_ret.first, state);
    PROFILE_END(z3_eval);
    auto match_list = make_unique<vector<unique_ptr<PatternMatch>>>();

    bool changed = src_ret.second;

    for (auto pm = spec->match_list->begin(); pm != spec->match_list->end(); pm++) {
        auto new_state = state->copy();

        resolve_pattern(proj, spec, (*pm)->pattern.get(), src_val, new_state);
        // std::cout << "simple_match_by_z3: pattern: " << string(*(*pm)->pattern) << std::endl;
        // for (auto const &cond: *new_state->conds) {
        //     std::cout << "simple_match_by_z3: cond: " << cond << std::endl;
        // }
        PROFILE_START(match_rule_check);
        PROFILE_START(z3_rule_check);
        auto check_ret = z3_check(new_state);
        PROFILE_END(z3_rule_check);
        PROFILE_END(match_rule_check);
        if (check_ret == Z3Result::False) {
            profile_log_rule_match_solved(string((orig_src)));
            changed = true;
            //std::cout << "pattern false" << std::endl;
            continue;
        } else if (check_ret == Z3Result::True) {
            profile_log_rule_match_solved(string(orig_src));
        } else {
            profile_log_rule_match_unsolved(string(orig_src));
        }
        //std::cout << "pattern true/unkown" << std::endl;
        auto body_ret = rule_simple_by_z3(proj, (*pm)->body.release(), new_state);
        changed |= body_ret.second;
        if (body_ret.first) {
            match_list->push_back(make_unique<PatternMatch>(unique_ptr<SpecNode>((*pm)->pattern.release()), unique_ptr<SpecNode>(body_ret.first)));
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
        delete spec;
        //throw std::runtime_error("Match list is empty: " + orig_src);
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
        delete spec;
        if (only_none) {
            return std::make_pair(new Symbol("None", typ), changed);
        } else {
            auto ret = new Match(unique_ptr<SpecNode>(src_ret.first), std::move(match_list));
            return std::make_pair(ret, changed);
        }
    }
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
            //if (v > -100 && v < 0) {
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

            // if (!z3_val.is_numeral_u64(__v)) {
            //     z3_val = (-z3_val).simplify();
            //     //std::cout << "neg z3_val: " << z3_val << std::endl;
            // }
            // // Large integer greater than 2^64 - 1
            // if (!z3_val.is_numeral_u64(__v)) {
            //     //std::cout << "z3_val (greater than 2^64 - 1): " << z3_val << std::endl;
            //     auto bv_expr = z3::to_expr(z3_val.ctx(), Z3_mk_int2bv(z3_val.ctx(), 64, z3_val));

            //     // std::cout << "bv_expr: " << bv_expr.simplify() << std::endl;
            //     // std::cout << "bv_expr: " << Z3_get_numeral_string(z3_val.ctx(), bv_expr.simplify()) << std::endl;
            //     uint64_t v = std::stoull(Z3_get_numeral_string(z3_val.ctx(), bv_expr.simplify()));

            //     //std::cout << "new IntConst: " << v << std::endl;
            //     return new IntConst(v);
            // }

                //std::cout << "new IntConst: " << v << std::endl;
                // return new IntConst(v);
            // }
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

/*
 * The passed-in spec will be freed in this function,
 * unless it is used in the return value.
 */
rule_ret_t simple_expr_by_z3(Project* proj, Expr* spec, shared_ptr<EvalState> state) {
    auto elems = make_unique<vector<unique_ptr<SpecNode>>>();
    bool changed = false;
    //auto orig_spec_str = string(*spec);
    Expr *orig_spec = spec;
    string orin_spec_str = string(*spec);
    if (auto op = std::get_if<Expr::ops>(&spec->op)) {
        if (*op == Expr::None)
            return std::make_pair(spec, false);
    }

    for (auto elem = spec->elems->begin(); elem != spec->elems->end(); elem++) {
        auto ret = rule_simple_by_z3(proj, elem->release(), state);
        changed |= ret.second;
        if (ret.first == nullptr) {
            delete orig_spec;
            //throw std::runtime_error("simple_expr_by_z3: elem is nullptr: " + orig_spec_str);
            return std::make_pair(nullptr, true);
        }
        elems->push_back(unique_ptr<SpecNode>(ret.first));
    }
    spec = new Expr(std::move(spec->op), std::move(elems), spec->get_type());
    delete orig_spec;

    PROFILE_START(z3_eval);
    auto exp_val = z3_eval(proj, spec, state);
    PROFILE_END(z3_eval);

    unordered_map<unsigned, std::pair<z3::expr, SpecNode*>> subexprs;
    collect_exprs(spec, subexprs);
    if ((spec->get_type() == Int::INT || spec->get_type() == Bool::BOOL)
         && length_of_exp(spec) <= 20) {
        auto _expr = reconstruct_expr(exp_val->get_z3_value(), subexprs, state);
        unique_ptr<SpecNode> expr;
        if (_expr) {
            expr = _expr->deep_copy();
        }

        for (auto s = subexprs.begin(); s != subexprs.end(); ++s)
            if (s->second.second != _expr) {
                delete s->second.second;
            }

        if (expr && length_of_exp(expr.get()) < length_of_exp(spec)) {
            delete spec;
            return std::make_pair(expr.release(), true);
        }
    }

    auto elem0 = instance_of(spec->elems->at(0).get(), Expr);

    // div (+ a b) c ==> (div a c) + (div b c)
    if (std::holds_alternative<Expr::binops>(spec->op) && std::get<Expr::binops>(spec->op) == Expr::DIV &&
        elem0 && std::holds_alternative<Expr::binops>(elem0->op) && std::get<Expr::binops>(elem0->op) == Expr::ADD) {
        auto ea = elem0->elems->at(0)->deep_copy();
        auto eb = elem0->elems->at(1)->deep_copy();
        auto ed = spec->elems->at(1)->deep_copy();
        PROFILE_START(z3_eval);
        auto a = z3_eval(proj, ea.get(), state);
        auto b = z3_eval(proj, eb.get(), state);
        auto d = z3_eval(proj, ed.get(), state);
        PROFILE_END(z3_eval);

        PROFILE_START(expr_rule_check);
        PROFILE_START(z3_rule_check);
        auto expr_check_ret = (z3_check(state, a->get_z3_value() >= 0) == Z3Result::True &&
            z3_check(state, b->get_z3_value() >= 0) == Z3Result::True &&
            z3_check(state, d->get_z3_value() > 0) == Z3Result::True &&
            (z3_check(state, a->get_z3_value() % d->get_z3_value() == 0) == Z3Result::True ||
             z3_check(state, b->get_z3_value() % d->get_z3_value() == 0) == Z3Result::True));
        PROFILE_END(z3_rule_check);
        PROFILE_END(expr_rule_check);
        if (expr_check_ret) {
            profile_log_rule_expr_solved(string(orin_spec_str));
        } else {
            profile_log_rule_expr_unsolved(string(orin_spec_str));
        }

        if (expr_check_ret) {
            // if (debug) {
            //     std::cout << "a: " << a->get_z3_value() << std::endl;
            //     std::cout << "b: " << b->get_z3_value() << std::endl;
            //     std::cout << "d: " << d->get_z3_value() << std::endl;
            // }
            auto elems1 = make_unique<vector<unique_ptr<SpecNode>>>();
            elems1->push_back(std::move(ea));
            elems1->push_back(ed->deep_copy());
            auto expr1 = new Expr(Expr::DIV, std::move(elems1), Int::INT);
            auto elems2 = make_unique<vector<unique_ptr<SpecNode>>>();
            elems2->push_back(std::move(eb));
            elems2->push_back(std::move(ed));
            auto expr2 = new Expr(Expr::DIV, std::move(elems2), Int::INT);
            auto new_elems = make_unique<vector<unique_ptr<SpecNode>>>();
            new_elems->push_back(unique_ptr<SpecNode>(expr1));
            new_elems->push_back(unique_ptr<SpecNode>(expr2));
            auto expr = new Expr(std::move(elem0->op), std::move(new_elems), Int::INT);
            delete spec;
            return std::make_pair(expr, true);
        }
    } else if (auto op = std::get_if<Expr::ops>(&spec->op)) {
        if ((*op == Expr::SET || *op == Expr::GET)) {
            auto new_zmap = reconstruct_zmap(proj, spec, state);

            if (new_zmap) {
                delete spec;
                return std::make_pair(new_zmap, true);
            }
        }
    }

    return std::make_pair(spec, changed);
}

unordered_map<size_t, bool> converged_spec;
unordered_map<size_t, string> spec_hash_collisions;
unsigned long z3_global_hash_hit = 0;
unsigned long z3_global_hash_total = 0;
#define Z3_OPT_CACHE

rule_ret_t rule_simple_by_z3(Project* proj, SpecNode* spec, shared_ptr<EvalState> state)
{
    rule_ret_t ret;
#ifdef Z3_OPT_CACHE
    z3_global_hash_total++;
    size_t spec_hash = boost::hash<string>()(string(*spec));


#ifdef DEBUG
    if (converged_spec.find(spec_hash) != converged_spec.end()) {
        if (spec_hash_collisions.find(spec_hash) != spec_hash_collisions.end() && string(*spec) != spec_hash_collisions[spec_hash]) {
            std::cout << "Collision: " << spec_hash_collisions[spec_hash] << " vs " << string(*spec) << std::endl;
            throw std::runtime_error("Collision: " + spec_hash_collisions[spec_hash] + " vs " + string(*spec));
        }
    }
#endif

    if (converged_spec.find(spec_hash) != converged_spec.end()) {
        z3_global_hash_hit++;
        return std::make_pair(spec, false);
    }
#endif

    state = state->copy();
    if (is_instance(spec, Symbol)) {
        ret = std::make_pair(spec, false);
    } else if (is_instance(spec, Const)) {
        ret = std::make_pair(spec, false);
    } else if (auto expr = instance_of(spec, Expr)) {
        auto orig = string(*spec);
        ret = simple_expr_by_z3(proj, expr, state);
    } else if (auto match = instance_of(spec, Match)) {
        ret = simple_match_by_z3(proj, match, state);
    } else if (auto rely = instance_of(spec, RelyAnno)) {
        ret = simple_rely_by_z3(proj, rely, state);
    } else if (auto if_ = instance_of(spec, If)) {
        ret = simple_if_by_z3(proj, if_, state);
    } else if (auto forall = instance_of(spec, Forall)) {
        for (auto v : *forall->vars)
        {
            if (v->type) {
                auto var = v->type->declare(v->name, forall->nid);
                (*state->vars)[v->name] = var;
            } else {
                assert(v->expr);
            }
        }
        forall->clear_z3_eval();
        auto res = rule_simple_by_z3(proj, forall->body.release(), state);
        auto new_forall = new Forall(std::move(forall->vars), unique_ptr<SpecNode>(res.first));
        delete spec;
        ret = std::make_pair(new_forall, res.second);
    } else if (auto exists = instance_of(spec, Exists)) {
        for (auto v : *exists->vars)
        {
            assert(v->type);
            (*state->vars)[v->name] = v->type->declare(v->name, exists->nid);
        }
        exists->clear_z3_eval();
        auto res = rule_simple_by_z3(proj, exists->body.release(), state);
        auto new_exists = new Exists(std::move(exists->vars), unique_ptr<SpecNode>(res.first));
        delete spec;
        ret = std::make_pair(new_exists, res.second);
    } else {
        throw std::runtime_error("Unknown node type: " + std::string(typeid(spec).name()));
    }

#ifdef Z3_OPT_CACHE
    if (!ret.second) {
        converged_spec.emplace(spec_hash, true);
    }
#endif

    return ret;
}

bool rule_check_pure_by_z3(Project* proj, SpecNode* spec, shared_ptr<StructValue> in_st)
{
    auto st_type_name = in_st->get_type()->name;

    if (auto rely = instance_of(spec, Rely)) {
        auto res = rule_check_pure_by_z3(proj, rely->body.release(), in_st);
        delete spec;
        return res;
    }

    else if (auto expr = instance_of(spec, Expr)) {
        if (auto opt = dynamic_pointer_cast<Option>(expr->type)) {
            if (auto tuple = dynamic_pointer_cast<Tuple>(opt->elem_type)) {
                auto st_idx = -1;
                for (int idx = 0; idx < tuple->elems->size(); idx++) {
                    auto et = tuple->elems->at(idx);
                    if (et->type->name == st_type_name) {
                        st_idx = idx;
                        break;
                    }
                }
                if (st_idx == -1) {
                    throw std::runtime_error("No returning state found");
                }
                auto st_eval = instance_of(expr->elems->at(0).get(), Expr)->elems->at(st_idx)->cached_eval;
                return (st_eval->value == in_st->value);
            }
            else if (auto sym = dynamic_pointer_cast<Symbol>(opt->elem_type)) {
                if (sym->text == "None") {
                    return true;
                }
            }
        }
        return false;
    }
    else if (auto if_ = instance_of(spec, If)) {
        auto then_res = rule_check_pure_by_z3(proj, if_->then_body.get(), in_st);
        auto else_res = rule_check_pure_by_z3(proj, if_->else_body.get(), in_st);
        return then_res && else_res;
    }

    else if (auto match = instance_of(spec, Match)) {
        for (auto pm = match->match_list->begin(); pm != match->match_list->end(); pm++) {
            if (!rule_check_pure_by_z3(proj, (*pm)->body.get(), in_st))
                return false;
        }
        return true;
    }

    else if (auto sym = instance_of(spec, Symbol)) {
        if (sym->text == "None") return true;
        else throw std::runtime_error("rule_check_pure_by_z3: Unexpected symbol: " + sym->text);
    }

    else throw std::runtime_error("rule_check_pure_by_z3: Unexpected node type: " + std::string(typeid(spec).name()));
}

} // namespace autov
