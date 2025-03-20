#include <nodes.h>
#include <values.h>
#include <utils.h>
#include <shortcuts.h>
#include <project.h>
#include <cassert>
#include <utility>
#include <rules.h>
#include <z3_rules.h>
#include <symbolic.h>
#include <simulate.h>
#include <coi.h>
#include <variant>
#include <type_inference.h>
#include <cmd.h>
#include <decompose.h>

namespace autov
{

bool is_invariant_defs(Project *proj, const string &name) {
    return proj->symbols[name].loc == autov::loc_t("Invariants", "Spec", "");
}

bool is_lemma_defs(Project *proj, const string &name) {
    return proj->symbols[name].loc == autov::loc_t("Lemmas", "Spec", "");
}

bool is_relation_defs(Project *proj, const string &name) {
    return proj->symbols[name].loc == autov::loc_t("Relations", "Spec", "");
}

bool is_sec_relation_defs(Project *proj, const string &name) {
    return proj->symbols[name].loc == autov::loc_t("SecureRelations", "Spec", "");
}

/** Separate prove-stage z3 translator from the specgen-stage one */
shared_ptr<SpecValue> z3_expr(Project* proj, SpecNode* val, shared_ptr<EvalState> state) {
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
                return _cache(z3_expr(proj, c, state));
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
            auto icon = instance_of(val, IntConst);
            return make_shared<IntValue>(*intc, icon->is_signed());
        } else if (auto boolc = std::get_if<bool>(&con->value)) {
            return make_shared<BoolValue>(*boolc);
        } else if (auto strc = std::get_if<string>(&con->value)) {
            return make_shared<StringValue>(*strc);
        }
    } else if (auto expr = instance_of(val, Expr)) {
        vector<shared_ptr<SpecValue>> elems;

        for (auto e = expr->elems->begin(); e != expr->elems->end(); e++) {
            elems.push_back(z3_expr(proj, e->get(), state));
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
            return _cache(static_pointer_cast<ZMapValue>(elems[0])->get(static_pointer_cast<IntValue>(elems[1])));
        } else if (op_eq(expr->op, Expr::SET)) {
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
                std::cout << "[z3_expr] expr: " << string(*expr) << std::endl;
                throw std::runtime_error("[z3_expr] Unknown symbol: " + sym);
            }
        } else if (std::holds_alternative<unique_ptr<SpecNode>>(expr->op)) {
            auto op = z3_expr(proj, std::get<unique_ptr<SpecNode>>(expr->op).get(), state);
            if (auto func = dynamic_pointer_cast<FuncValue>(op))
                return _cache(func->call(elems));
        }

        throw std::runtime_error("[z3_expr] Unknown expression: " + string(*expr));
    } else if (auto match = instance_of(val, Match)) {
        auto src = z3_expr(proj, match->src.get(), state);
        shared_ptr<SpecValue> match_val = nullptr;
        for (auto pm = match->match_list->rbegin(); pm != match->match_list->rend(); pm++) {
            unordered_map<string, shared_ptr<SpecValue>> vars;
            unordered_map<string, shared_ptr<SpecValue>> assigns;
            auto pat = resolve_pattern(proj, val, (*pm)->pattern.get(), src, vars, assigns);
            auto cond = pat->get_z3_value() == src->get_z3_value();
            for (auto v = vars.begin(); v != vars.end(); v++) {
                cond = z3::exists(v->second->get_z3_value(), cond);
            }
            auto new_state = state->copy();
            for (auto v = assigns.begin(); v != assigns.end(); v++) {
                new_state->vars->emplace(v->first, v->second);
            }
            if (match_val == nullptr) {
                match_val = z3_expr(proj, (*pm)->body.get(), new_state);
            } else {
                auto then_val = z3_expr(proj, (*pm)->body.get(), new_state);
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
        auto cond = z3_expr(proj, rely->prop.get(), state);
        PROFILE_START(rely_eval_check);
        PROFILE_START(eval_check);
        auto res = z3_check(state, cond->get_z3_value());
        PROFILE_END(eval_check);
        PROFILE_END(rely_eval_check);

        if (res == Z3Result::Unknown) {
            profile_log_eval_rely_unsolved(string(*rely->prop.get()));
            auto body = z3_expr(proj, rely->body.get(), state);
            auto none = static_pointer_cast<Option>(val->get_type())->construct("None", {});

            auto z3_val = z3::ite(cond->get_z3_value(), body->get_z3_value(), none->get_z3_value());
            return _cache(rely->get_type()->from_z3_value(z3_val.simplify()));
        } else if (res == Z3Result::True) {
            profile_log_eval_rely_solved(string(*rely->prop.get()));
            return _cache(z3_expr(proj, rely->body.get(), state));
        } else {
            profile_log_eval_rely_solved(string(*rely->prop.get()));
            return _cache(static_pointer_cast<Option>(val->get_type())->construct("None", {}));
        }
    }
    else if (auto iff = instance_of(val, If)) {
        auto c = z3_expr(proj, iff->cond.get(), state);
        PROFILE_START(if_eval_check);
        PROFILE_START(eval_check);
        auto res = z3_check(state, c->get_z3_value());
        PROFILE_END(eval_check);
        PROFILE_END(if_eval_check);
        if (res == Z3Result::Unknown) {
            profile_log_eval_if_unsolved(string(*iff->cond.get()));
            auto true_state = state->copy();
            true_state->conds->push_back(c->get_z3_value());
            auto True = z3_expr(proj, iff->then_body.get(), true_state);
            auto false_state = state->copy();
            false_state->conds->push_back(!c->get_z3_value());
            auto False = z3_expr(proj, iff->else_body.get(), false_state);
            auto z3_val = z3::ite(c->get_z3_value(), True->get_z3_value(), False->get_z3_value());
            return _cache(iff->get_type()->from_z3_value(z3_val.simplify()));
        }
        else if (res == Z3Result::True) {
            profile_log_eval_if_solved(string(*iff->cond.get()));
            state->conds->push_back(c->get_z3_value());
            return _cache(z3_expr(proj, iff->then_body.get(), state));
        }
        else {
            profile_log_eval_if_solved(string(*iff->cond.get()));
            state->conds->push_back(!c->get_z3_value());
            return _cache(z3_expr(proj, iff->else_body.get(), state));
        }
    }
    else if (auto forall = instance_of(val, Forall)) {
        z3::expr_vector vars(z3ctx);
        std::vector<z3::expr> hypos;
        for (auto v = forall->vars->begin(); v != forall->vars->end(); v++) {
            if ((*v)->type) {
                auto var = (*v)->type->declare((*v)->name, val->nid);
                (*state->vars)[(*v)->name] = var;
                vars.push_back(var->get_z3_value());
            } else {
                // bounded variable v is prop, push into state
                auto prop = z3_expr(proj, (*v)->expr.get(), state);
                hypos.push_back(prop->get_z3_value());
            }
        }
        /** bounded variables may have a newer nid over cached z3 values, so we need to clear cached value first  */
        forall->clear_z3_eval();
        auto body = z3_expr(proj, forall->body.get(), state);
        auto p = body->get_z3_value();

        for (const auto &h : hypos) {
            p = z3::implies(h, p);
        }
        return _cache(make_shared<BoolValue>(z3::forall(vars, p)));
    }
    else if (auto exsts = instance_of(val, Exists)) {
        z3::expr_vector vars(z3ctx);
        for (auto v = exsts->vars->begin(); v != exsts->vars->end(); v++) {
            auto var = (*v)->type->declare((*v)->name, val->nid);
            (*state->vars)[(*v)->name] = var;
            vars.push_back(var->get_z3_value());
        }
        exsts->clear_z3_eval();
        auto body = z3_expr(proj, exsts->body.get(), state);
        return _cache(make_shared<BoolValue>(z3::exists(vars, body->value)));
    }
    throw std::runtime_error("[z3_expr] Unknown node type: " + string(*val));
}

SpecNode *extract_st_from_expr(Project *proj, SpecNode *expr) {
    if (auto sym = instance_of(expr, Symbol)) {
        if (!proj->is_ind_constr(sym->text)) {
            if (sym->get_type() == proj->layers[0]->abs_data) {
                return sym;
            }
        }
    } else if (auto e = instance_of(expr, Expr)) {
        if (op_eq(e->op, Expr::Some)) {
            return extract_st_from_expr(proj, e->elems->at(0).get());
        } else if (op_eq(e->op, Expr::Tuple)) {
            for (int i = 0 ; i < e->elems->size() ; i++) {
                auto st = extract_st_from_expr(proj, e->elems->at(i).get());
                if (st) {
                    return st;
                }
            }
        } else if (std::holds_alternative<string>(e->op)) {
            auto sym = std::get<string>(e->op);
            auto info = proj->symbols[sym];
            if (info.kind == SymbolKind::Def || info.kind == SymbolKind::Decl) {
                auto last = e->elems->back().get();
                return extract_st_from_expr(proj, last);
            }
        } else {
            if (e->get_type() == SpecType::UNKNOWN_TYPE) {
                throw std::runtime_error("[extract_st_from_expr] Type inferrence failed before proof! " + string(*e));
            }
            if (e->get_type() == proj->layers[0]->abs_data) {
                return e;
            }
        }
    } 
    return nullptr;
}

using abst_t = std::variant<Definition*, Declaration *, std::nullptr_t>;
abst_t abst_transition(Project *proj, SpecNode *spec) {
    if (auto expr = instance_of(spec, Expr)) {
        if (std::holds_alternative<string>(expr->op)) {
            auto sym = std::get<string>(expr->op);
            auto info = proj->symbols[sym];
            if (info.kind == SymbolKind::Def) {
                return proj->defs[sym].get();
            } else if (info.kind == SymbolKind::Decl) {
                return proj->decls[sym].get();
            }
        }
    }
    return nullptr;
}

bool check_drf_by_traverse(Project *proj, SpecNode *spec, shared_ptr<ProveState> state) {
    if (auto s = instance_of(spec, Symbol)) {
        if (s->text == "None") {
            std::cout << "[check_drf_by_traverse] Checking None path: " << string(*spec) << std::endl;
            auto res = z3_verify_state_sat(state, &proj->query_saver);
            if (res == Z3Result::True) {
                LOG_ERROR << "[check_drf_by_traverse] A None path is proved to be sat! DRF failed!" << std::endl;
                return false;
            } else if (res == Z3Result::Unknown) {
                LOG_WARNING << "[check_drf_by_traverse] A None path is unknown!" << std::endl;
            }
        }
    } else if (auto e = instance_of(spec, Expr)) {
        // pass
    } else if (auto m = instance_of(spec, Match)) {
        auto src = z3_expr(proj, m->src.get(), state);
        auto verify_fail = false;
		for (auto pm = m->match_list->begin() ; pm != m->match_list->end(); pm++) {
            auto new_state = state->copy();
            auto pat = (*pm)->pattern.get();
			resolve_pattern(proj, m, pat, src, new_state);
            verify_fail |= !check_drf_by_traverse(proj, (*pm)->body.get(), new_state);
        }
        return !verify_fail;
    } else if (auto i = instance_of(spec, If)) {
		// push cond
		auto c = z3_expr(proj, i->cond.get(), state);
		auto res = Z3Result::Unknown;
        res = z3_check(state, c->get_z3_value());

        auto true_state = state->copy();
		auto false_state = state->copy();
        
		true_state->conds->push_back(c->get_z3_value());
		false_state->conds->push_back(!c->get_z3_value());
        if (res == Z3Result::True) {
            return check_drf_by_traverse(proj, i->then_body.get(), true_state);
        } else if (res == Z3Result::False) {
            return check_drf_by_traverse(proj, i->else_body.get(), false_state); 
        } else {
            auto verify_fail = false;
            verify_fail |= !check_drf_by_traverse(proj, i->then_body.get(), true_state);
            verify_fail |= !check_drf_by_traverse(proj, i->else_body.get(), false_state);
            return !verify_fail;
        }
    } else if (auto r = instance_of(spec, Rely)) {
		// push cond
		auto c = z3_expr(proj, r->prop.get(), state);
        auto res = z3_check(state, c->get_z3_value());
        if (res == Z3Result::False || res == Z3Result::Unknown) {
            LOG_WARNING << "[check_drf_by_traverse] Rely condition is violated: " << string(*r->prop.get()) << std::endl;
        } else {
            LOG_INFO << "[check_drf_by_traverse] Rely condition is proved: " << string(*r->prop.get()) << std::endl;
        }
		state->conds->push_back(c->get_z3_value());
        return check_drf_by_traverse(proj, r->body.get(), state);
    } else {
        // pass
        return true;
    }
    return true;
}

bool check_states_implies_loop_inv(Project* proj, shared_ptr<ProveState> state, string fname, vector<shared_ptr<SpecValue>>& elems) {
    auto& invs = proj->loop_invs[fname];
    auto loop = instance_of(proj->defs[fname].get(), Fixpoint);
    //auto preconds = proj->cmds.InitRely[df->name];
    auto var = std::make_shared<unordered_map<string, shared_ptr<SpecValue>>>();
    auto conds = std::make_shared<vector<z3::expr>>();
    //declare loop arguments
	auto known = make_shared<unordered_map<string, shared_ptr<SpecType>>>();
    for (auto arg : *loop->args) {
        if (arg->name != "_N_") {
            (*var)[loop->name + "_" + arg->name] = arg->type->declare(loop->name + "_" + arg->name, 0); //current
			(*known)[arg->name] = arg->type;
        }
        if(arg->name == "st") {
            (*var)[loop->name + "_" + arg->name + "_old"] = arg->type->declare(loop->name + "_" + arg->name + "_old", 0);
			(*known)[arg->name + "_old"] = arg->type;
        }
    }
                        
                        
    ///aggregate all the invs together into one conjunctives
    unique_ptr<SpecNode> aggreinv = make_unique<BoolConst>(true);
    for(auto &inv : invs) {
        auto elems = new vector<unique_ptr<SpecNode>>();
        elems->push_back(std::move(aggreinv));
        elems->push_back(inv->deep_copy());
        aggreinv = make_unique<Expr>(Expr::binops::AND, unique_ptr<vector<unique_ptr<SpecNode>>>(elems), Bool::BOOL);
    }

	type_inference::infer_type(*proj, aggreinv.get(), known, Bool::BOOL);

    auto before_inv = std::move(aggreinv);
    //subst invariant inv[ret_x[0]/a' ret_x[1]/b' ret_x[2]/c' ret_x[3]/d']
    for(auto arg : *loop->args) {
                        // if (arg->name != "_N_") {
        auto sym = make_unique<Symbol>(loop->name + "_" + arg->name, arg->type);
        bool succ;
        before_inv = subst(std::move(before_inv), arg->name, sym.get(), succ);
    }
	auto sym = make_unique<Symbol>(loop->name + "_" + "st_old", loop->args->back()->type);
	bool succ;
	before_inv = subst(std::move(before_inv), "st_old", sym.get(), succ);

    auto vc = z3ctx.bool_val(true);
    set<string> used_fix;
    auto invval = z3_eval(proj, before_inv.get(), make_shared<EvalState>(var, conds), false, true, used_fix);
    int i = 0;
    for(auto arg : *loop->args) {
		if(i != 0) {
			auto name = arg->name;
			//instantiate variable to each element
			auto z3_eq_expr = elems.at(i)->get_z3_value() == (*var)[loop->name + "_" + name]->get_z3_value();
			vc = vc && z3_eq_expr;
		}
		i++;
    }

    vc = vc && (*var)[loop->name + "_st_old"]->get_z3_value() == elems.back()->get_z3_value();
	//LOG_INFO << "[Checking Loop Invariant] eq formula" << vc;
	//LOG_INFO << "[Checking Loop Invariant] invariant" << invval->get_z3_value();
	for(auto &cond: *state->conds) {
		LOG_DEBUG << "Cond:" << cond;
	}
    for(auto ind: *state->inductions) {
        LOG_DEBUG << "Current Induction:" << ind;
    }
    auto final_vc = z3::implies(vc, invval->get_z3_value());
    LOG_DEBUG << "final vc: " << final_vc;
	z3::model model(z3ctx);
    auto res = z3_check_unsat(state, final_vc , model, &proj->query_saver, 50000);
    if(res == Z3Result::False || res == Z3Result::Unknown || res == Z3Result::Sat) {
		if(res == Z3Result::Sat) {
			LOG_ERROR << "Solver return SAT";
			LOG_INFO << "model: " << model;
		}
        LOG_ERROR << "Precondition can't infer loop invariant: " << fname;
        return false;
    }
    return true;
}

bool check_states_implies_pre_condition(Project* proj, shared_ptr<ProveState> state, string fname, vector<shared_ptr<SpecValue>>& elems) {
    auto &preconds = proj->cmds.PreCond[fname];
    auto def = proj->defs[fname].get();
    auto var = std::make_shared<unordered_map<string, shared_ptr<SpecValue>>>();
    auto conds = std::make_shared<vector<z3::expr>>();
	auto known = make_shared<unordered_map<string, shared_ptr<SpecType>>>();
	//Check Precondition
    for (auto arg : *def->args) {
        (*var)[def->name + "_" + arg->name] = arg->type->declare(def->name + "_" + arg->name, 0); //current
        (*known)[arg->name] = arg->type;
        if(arg->name == "st") {
            (*var)[def->name + "_" + arg->name + "_old"] = arg->type->declare(def->name + "_" + arg->name + "_old", 0);
            (*known)[arg->name + "_old"] = arg->type;
        }
    }
	unique_ptr<SpecNode> aggrepres = make_unique<BoolConst>(true);
	for(auto &inv : preconds) {
			auto elems = new vector<unique_ptr<SpecNode>>();
			elems->push_back(std::move(aggrepres));
			elems->push_back(inv->deep_copy());
			aggrepres = make_unique<Expr>(Expr::binops::AND, unique_ptr<vector<unique_ptr<SpecNode>>>(elems), Bool::BOOL);
	}
    type_inference::infer_type(*proj, aggrepres.get(), known, Bool::BOOL);
    unique_ptr<SpecNode> before_inv = std::move(aggrepres);
                    
    for(auto arg : *def->args) {             
        auto sym = make_unique<Symbol>(def->name + "_" + arg->name, arg->type);
        bool succ;
        before_inv = subst(std::move(before_inv), arg->name, sym.get(), succ);
    }
    auto sym = make_unique<Symbol>(def->name + "_" + "st_old", def->args->back()->type);
    bool succ;
    before_inv = subst(std::move(before_inv), "st_old", sym.get(), succ);
    auto vc = z3ctx.bool_val(true);
    set<string> used_fix;
    auto invval = z3_eval(proj, before_inv.get(), make_shared<EvalState>(var, conds), false, true, used_fix);
    int i = 0;
    for(auto arg : *def->args) {
        if(i != 0) {
            auto name = arg->name;
            //instantiate variable to each element
            auto z3_eq_expr = elems.at(i)->get_z3_value() == (*var)[def->name + "_" + name]->get_z3_value();
            vc = vc && z3_eq_expr;
        }
        i++;
    }

    vc = vc && (*var)[def->name + "_st_old"]->get_z3_value() == elems.back()->get_z3_value();

    z3::model model(z3ctx);
    auto res = z3_check_unsat(state, z3::implies(vc, invval->get_z3_value()), model, &proj->query_saver, 50000);
    if(res == Z3Result::False || res == Z3Result::Unknown || res == Z3Result::Sat) {
            if(res == Z3Result::Sat) {
                LOG_ERROR << "Solver return SAT";
                LOG_INFO << "model: " << model;
            }
            LOG_ERROR << "Conds can't infer function precondition:" << def->name;
            return false;
    }
    LOG_INFO << "[Checking Precondition] Conds imply function precondition" << def->name;
    return true;
}


z3::expr formulate_loop_invariant_z3(Project* proj, std::string fname, SpecNode* fun_call, shared_ptr<ProveState> state){
    auto expr = instance_of(fun_call, Expr);
    auto loop = proj->defs[fname].get();
    auto loop_post_cond = formulate_loop_invariant(proj, fname, expr->elems.get());
    for (auto arg : *loop->args) {
        if (arg->name != "_N_") {
            (*state->vars)[loop->name + "_" + arg->name + "_new_"] = arg->type->declare(loop->name + "_" + arg->name + "_new_", 0); //current
        }
    }
    //LOG_DEBUG << "[Checking Loop Invariant] Adding loop postcondition: " << string(*loop_post_cond);
    set<string> used_fix;
    auto loop_post_val = z3_eval(proj, loop_post_cond.get(), state, false, true, used_fix);
    auto post = loop_post_val->get_z3_value();
    for(auto arg : *loop->args) {
        if (arg->name != "_N_") {
            post = z3::forall((*state->vars)[loop->name + "_" + arg->name + "_new_"]->get_z3_value(), post);
        }
    }
    return post;
}

z3::expr formulate_post_cond_z3(Project* proj, std::string fname, SpecNode* func_call, shared_ptr<ProveState> state) {
    auto def = proj->defs[fname].get();
    auto expr = instance_of(func_call, Expr);
    auto post_cond = formulate_post_condition(proj, fname, expr->elems.get());
    string tmpname = "_ret_";
    int i = 0;
    auto rettype = instance_of(def->rettype.get(), Option);
    if (auto rettupletype = instance_of(rettype->elem_type.get(), Tuple)) {
        for(auto elemtype : *rettupletype->types) {
            if (i != rettupletype->types->size() - 1) {
                (*state->vars)[def->name + tmpname + std::to_string(i)] = elemtype->declare(def->name + tmpname + std::to_string(i), 0); //after
            } else {
                (*state->vars)[def->name + "_st_new_"] = elemtype->declare(def->name + "_st_new_", 0); //after
            }
            i++;
        }
    } else{
        (*state->vars)[def->name + "_st_new_"] = rettype->elem_type->declare(def->name + "_st_new_", 0);
    }
    set<string> used_fix;
    auto post_val = z3_eval(proj, post_cond.get(), state, false, false, used_fix);
    auto post = post_val->get_z3_value();
    if (auto rettupletype = instance_of(rettype->elem_type.get(), Tuple)) {
        i = 0;
        for(auto elemtype : *rettupletype->types) {
            if (i != rettupletype->types->size() - 1) {
                post = z3::forall((*state->vars)[def->name + tmpname + std::to_string(i)]->get_z3_value(), post);
            } else {
                post = z3::forall((*state->vars)[def->name + "_st_new_"]->get_z3_value(), post);
            }
            i++;
        }
    } else {
        post = z3::forall((*state->vars)[def->name + "_st_new_"]->get_z3_value(), post);
    }
    return post;
}

/** prove_by_traverse:
 * 		works on specs with abstract functions, symbolically check inv path-by-path
 *      It is a general function that can check pre condition implies post condition or system invariant is preserved
 * */
bool prove_by_traverse(Project *proj, SpecNode *spec, SpecNode *inv, shared_ptr<ProveState> state, std::unordered_set<string> used_abs_funcs, ProveMode mode, string fname) {
    if (auto expr = instance_of(spec, Expr)) {
        if (auto e_op = std::get_if<Expr::ops>(&expr->op)) {
            if (*e_op == Expr::Some) {
                if (auto ret_Some = instance_of(expr->elems->at(0).get(), Expr)) {
					auto ret_st = expr->elems->at(0)->deep_copy();
					// if the return value is := Some (ret_val, st), then take the last 'st'
					if (auto ret_op = std::get_if<Expr::ops>(&ret_Some->op)) {
						if (*ret_op == Expr::Tuple) {
							ret_st = ret_Some->elems->back()->deep_copy();
						}
					}
					// Prove the return state maintains the invariant
					// construct new invariants
                    auto ret_st_str = string(*ret_st);
                    unique_ptr<SpecNode> prop;
                    if(mode == ProveMode::SYS) {
					    prop = proj->rules.instantiate_prop(inv->deep_copy(), std::move(ret_st));
                    } else if(mode == ProveMode::PREPOST){
                        vector<string> names;
                        vector<unique_ptr<SpecNode>> elems;
                        auto name = "_ret_";
                        for(int i = 0; i < ret_Some->elems->size(); i++) {
                            if(i != ret_Some->elems->size()-1){
                                names.push_back(name + std::to_string(i));
                                elems.push_back(ret_Some->elems->at(i)->deep_copy());
                            }
                        }
                        names.push_back("st");
                        elems.push_back(std::move(ret_st));
                        
                        prop = subst_v2(proj, inv->deep_copy(), &names, &elems);
                    } else if(mode == ProveMode::LOOP) {
                        vector<string> names;
                        vector<unique_ptr<SpecNode>> elems;
                        auto loop = proj->defs[fname].get();
                        for(int i = 0; i < ret_Some->elems->size(); i++) {
                            if(i != ret_Some->elems->size()-1){
                                auto arg_name = loop->args->at(i)->name;
                                names.push_back(arg_name);
                                elems.push_back(ret_Some->elems->at(i)->deep_copy());
                            }
                        }
                        names.push_back("st");
                        elems.push_back(std::move(ret_st));
                        
                        prop = subst_v2(proj, inv->deep_copy(), &names, &elems);
                    }
					//auto c = z3_expr(proj, p.get(), state);
                    //auto z3_ret = z3_verify(state, c->get_z3_value(), &proj->query_saver);
					//auto p = instantiate_prop(inv->deep_copy().release(), ret_st);
                    set<string> used_fix;
					auto c = z3_eval(proj, prop.get(), state, false, true, used_fix);
					// for(auto &cond: *state->conds) {
					// 	LOG_DEBUG << "Cond:" << cond;
					// }
					z3::model model(z3ctx);
					auto z3_ret = z3_check_unsat(state, c->get_z3_value(), model, &proj->query_saver, Z3_VERIFY_TIMEOUT);

					// std::cout << "----------------------------------" << std::endl;
					// std::cout << "prove_by_traverse: Final State\n" << ret_st_str << std::endl;
					// std::cout << "prove_by_traverse: Goal Query\n" << c->get_z3_value() << std::endl;
					// std::cout << "----------------------------------" << std::endl;
					if (z3_ret == Z3Result::Sat) {
						LOG_WARNING << "[prove_by_traverse] Condition is violated for state\n" << ret_st_str << std::endl;
						return false;
					} else if (z3_ret == Z3Result::Unknown) {
						LOG_WARNING << "[prove_by_traverse] Condition is unknown for state\n" << ret_st_str << std::endl;
						return false;
					} else {
						LOG_INFO << "[prove_by_traverse] Condition is proved for state\n" << ret_st_str << std::endl;
						return true;
					}
                }
            }
        }
    } else if (auto m = instance_of(spec, Match)) {
        set<string> used_fix;
        auto src = z3_eval(proj, m->src.get(), state, true, false, used_fix);
        
		if (auto expr = instance_of(m->src.get(), Expr)) {
			if (holds_alternative<string>(expr->op)){
                auto op = std::get<string>(expr->op);
                auto info = proj->symbols[op];
                if (info.kind == SymbolKind::Def) {
                    used_abs_funcs.insert(op);
                    vector<shared_ptr<SpecValue>> elems;

                    for (auto e = expr->elems->begin(); e != expr->elems->end(); e++) {
                        elems.push_back(z3_eval(proj, e->get(), state));
                    }
                    if (proj->defs.find(op) != proj->defs.end()) {
                        if (auto loop = instance_of(proj->defs[op].get(), Fixpoint)){
                            if (!check_states_implies_loop_inv(proj, state, op, elems)){
                                return false;
                            }
                            // state->inductions->clear();
                            LOG_INFO << "[Checking Loop Invariant] Precondition implies invariant";
                            auto fname = loop->name;
                            auto post = formulate_loop_invariant_z3(proj, fname, expr, state);
                            LOG_DEBUG << "[Checking Loop Invariant] Adding loop postcondition: " << op;
                            LOG_DEBUG << "[Checking Loop Invariant] Adding loop postcondition: " << post;
                            state->conds->push_back(post);
                        } else {
                            //normal Definition. Check the precondition and add post condition.
                            auto def = proj->defs[op].get();
                            if (proj->cmds.PreCond.find(op) != proj->cmds.PreCond.end()) {
                                if (!check_states_implies_pre_condition(proj, state, op, elems)){
                                    return false;
                                };
                            }
                            if(proj->cmds.PostCond.find(op) != proj->cmds.PostCond.end()) {
                                auto fname = def->name;
                                auto post = formulate_post_cond_z3(proj, fname, expr, state);
                                state->conds->push_back(post);
                            }
                            //if it is a preserving function, directly add post condition
                            if (proj->cmds.PreserveInv.find(op) != proj->cmds.PreserveInv.end()) {
                                unique_ptr<SpecNode> post_cond = formulate_preserved_function(proj, op);
                                auto post_val = z3_eval(proj, post_cond.get(), state->copy(), false, true, used_fix);
                                //delete post_cond;
                                state->conds->push_back(post_val->get_z3_value());
                            }
                        }
                    }
                }
			}
		}

        auto abst_spec = abst_transition(proj, m->src.get()); 
        SpecNode *st_input = extract_st_from_expr(proj, m->src.get());
        auto verify_success = true;

		for (auto pm = m->match_list->begin() ; pm != m->match_list->end(); pm++) {
			auto new_state = state->copy();
            auto pat = (*pm)->pattern.get();
            resolve_pattern(proj, m, pat, src, new_state);

            if (!std::holds_alternative<std::nullptr_t>(abst_spec)) {            
                SpecNode *st_ret = extract_st_from_expr(proj, pat);
                if (st_input && st_ret) {
                    auto p_input = proj->rules.instantiate_prop(inv->deep_copy(), st_input->deep_copy());
                    auto precond = z3_expr(proj, p_input.get(), new_state);
                    auto z3_ret = z3_verify(new_state, precond->get_z3_value(), &proj->query_saver);
                    if (z3_ret == Z3Result::Unknown || z3_ret == Z3Result::False) {
                        LOG_WARNING << "[prove_by_traverse] Pre-cond Invariant is violated for state\n" << string(*st_input) << std::endl;
                        // return false; // even pre-conditon is failed, the lemma may still strong enough to ensure post-cond inv
                    } else {
                    }
                    auto p_ret = proj->rules.instantiate_prop(inv->deep_copy(), st_ret->deep_copy());
                    auto postcond = z3_expr(proj, p_ret.get(), new_state);
                    new_state->inductions->clear();
                    new_state->add_induction(postcond->get_z3_value());

                    for (auto const &l : proj->lemmas) {
                        auto lemma_body = proj->defs[l]->body.get();
                        auto lemma = proj->rules.instantiate_prop(lemma_body->deep_copy(), st_ret->deep_copy());
                        auto lemma_expr = z3_expr(proj, lemma.get(), new_state);
                        new_state->add_induction(lemma_expr->get_z3_value());
                    }
                }
            }
            verify_success &= prove_by_traverse(proj, (*pm)->body.get(), inv, new_state, used_abs_funcs, mode, fname);
			// if (!prove_by_traverse(proj, (*pm)->body.get(), inv, new_state, used_abs_funcs)) {
				// return false;
			// }
		}
        return verify_success;
    } else if (auto i = instance_of(spec, If)) {
		// push cond
		auto c = z3_eval(proj, i->cond.get(), state);
		auto true_state = state->copy();
		auto false_state = state->copy();
		true_state->conds->push_back(c->get_z3_value());
		false_state->conds->push_back(!c->get_z3_value());
        auto verify_success = true;
        verify_success &= prove_by_traverse(proj, i->then_body.get(), inv, true_state, used_abs_funcs, mode, fname);
        verify_success &= prove_by_traverse(proj, i->else_body.get(), inv, false_state, used_abs_funcs, mode, fname);
        return verify_success;
		// if (!prove_by_traverse(proj, i->then_body.get(), inv, true_state, used_abs_funcs) || 
			// !prove_by_traverse(proj, i->else_body.get(), inv, false_state, used_abs_funcs)) {
			// return false;
		// }
    } else if (auto r = instance_of(spec, Rely)) {
		// push cond
		auto c = z3_eval(proj, r->prop.get(), state);
		state->conds->push_back(c->get_z3_value());
        return prove_by_traverse(proj, r->body.get(), inv, state, used_abs_funcs, mode, fname);
    } else {
		// pass
		return true;
	}
	return true;
}

void spec_abstraction(Project *proj, Definition *def, std::set<string> &coi) {
    set_interest_list(coi);

    auto spec = std::move(def->body);
    while (true) {
        bool changed = false;
        do {
            auto [__spec, __changed] = proj->rules.rule_keep_fields_of_interest(std::move(spec));
            spec = std::move(__spec);
            changed |= __changed;
        } while (false);

        do {
            auto [__spec, __changed] = proj->rules.rule_simplify_lens(std::move(spec));
            spec = std::move(__spec);
            changed |= __changed;
        } while (false);

        if (!changed) {
            break;
        }
    }
    def->body = std::move(spec);
    def->_str.clear();

    std::cout << "[spec_abstraction] Abstracted (Lensified) spec:\n" << string(*def) << std::endl;
}

static string query_saver_dir(const string &spec_name, const string &inv_name) {
    return OPTS.query_path + spec_name + "/" + inv_name;
}

/** check_inv_by_path: 
 * 1. Push initial invariant 
 * 2. Traverse the spec, push control point constriants
 * 3. Arrive return point, push return value constraints, check
 * */ 
bool check_inv_by_path(Project *proj, Definition *def, SpecNode *inv, std::unordered_set<string> &used_abs_funcs) {
	auto vars = std::make_shared<unordered_map<string, shared_ptr<SpecValue>>>();
	auto conds = std::make_shared<vector<z3::expr>>();
	for (auto arg : *def->args) {
		(*vars)[arg->name] = arg->type->declare(arg->name, 0);
	}
    auto induction = std::make_shared<vector<z3::expr>>();
	auto state = std::make_shared<ProveState>(vars, conds, induction);

    set<string> used_fixpoint;
	auto c = z3_eval(proj, inv, state, false, true, used_fixpoint);
	state->conds->push_back(c->get_z3_value());
	
    // instantiate parameter-related invariants
    for (auto const &l : proj->lemmas) {
        auto lemma_body = proj->defs[l]->body.get();
        auto lemma_expr = z3_expr(proj, lemma_body, state);
        state->add_induction(lemma_expr->get_z3_value());
    }

    //also add proved invariant
    for(auto proved: proj->verified_invariants) {
        auto pinv = proj->sys_invs[proved].get();
        auto c = z3_eval(proj, pinv, state, false, true, used_fixpoint);
        state->conds->push_back(c->get_z3_value());
    }

    def->body->clear_z3_eval();
	bool ret = prove_by_traverse(proj, def->body.get(), inv, state, used_abs_funcs, ProveMode::SYS, def->name);
	return ret;
}

//this version will treat loop as recursive functions.
bool check_loop_inv_v2(Project* proj, Definition *loop, std::unordered_set<string>& used_abs) {
    auto vars = std::make_shared<unordered_map<string, shared_ptr<SpecValue>>>();
	auto conds = std::make_shared<vector<z3::expr>>();

    if(proj->loop_invs.find(loop->name) == proj->loop_invs.end()) {
        LOG_ERROR << "loop invariant not specified: " << loop->name;
    }
    std::vector<unique_ptr<SpecNode>>& invs = proj->loop_invs[loop->name];
    assert(instance_of(loop, Fixpoint));
    auto body = loop->body.get();
    auto args = loop->args.get();

    unique_ptr<SpecNode> inv = make_unique<BoolConst>(true);
    for(auto &in : invs) {
        auto elems = new vector<unique_ptr<SpecNode>>();
        elems->push_back(std::move(inv));
        elems->push_back(in->deep_copy());
        inv = make_unique<Expr>(Expr::binops::AND, unique_ptr<vector<unique_ptr<SpecNode>>>(elems), Bool::BOOL);
    }

    for(auto arg : *loop->args) {
        (*vars)[arg->name] = arg->type->declare(arg->name, 0);
    }
    auto induction = std::make_shared<vector<z3::expr>>();
    auto state = make_shared<ProveState>(vars, conds, induction);
    set<string> used_fixpoint;
    auto c = z3_eval(proj, inv.get(), state, false, true, used_fixpoint);
    state->conds->push_back(c->get_z3_value());
    bool res = prove_by_traverse(proj, loop->body.get(), inv.get(), state, used_abs, ProveMode::LOOP, loop->name);

    //must remove name of itself
    used_abs.erase(loop->name);
    return res;
}


//check precondition implies post condition
bool check_pre_post(Project* proj, Definition *def, std::unordered_set<string>& used_abs) {
    auto vars = std::make_shared<unordered_map<string, shared_ptr<SpecValue>>>();
	auto conds = std::make_shared<vector<z3::expr>>();

    for(auto arg : *def->args) {
        (*vars)[arg->name] = arg->type->declare(arg->name, 0);
    }

    auto &preconds = proj->cmds.PreCond[def->name];
    auto &postconds = proj->cmds.PostCond[def->name];


    unique_ptr<SpecNode> precond = make_unique<BoolConst>(true);
    for(auto &in : preconds) {
        auto elems = new vector<unique_ptr<SpecNode>>();
        elems->push_back(std::move(precond));
        elems->push_back(in->deep_copy());
        precond = make_unique<Expr>(Expr::binops::AND, unique_ptr<vector<unique_ptr<SpecNode>>>(elems), Bool::BOOL);
    }

    unique_ptr<SpecNode> postcond = make_unique<BoolConst>(true);
    for(auto &in : postconds) {
        auto elems = new vector<unique_ptr<SpecNode>>();
        elems->push_back(std::move(postcond));
        elems->push_back(in->deep_copy());
        postcond = make_unique<Expr>(Expr::binops::AND, unique_ptr<vector<unique_ptr<SpecNode>>>(elems), Bool::BOOL);
    }
    auto induction = std::make_shared<vector<z3::expr>>();
    auto state = make_shared<ProveState>(vars, conds, induction);
    set<string> used_fixpoint;
    auto c = z3_eval(proj, precond.get(), state, false, true, used_fixpoint);

    bool res = prove_by_traverse(proj, def->body.get(), postcond.get(), state, used_abs, ProveMode::PREPOST, def->name);

    return res;
}

bool simulate(Project* proj, bool det) {
    if (!proj->relations.empty()) {
        unique_ptr<SpecNode> relation = make_unique<BoolConst>(true);
        for (auto &r : proj->relations) {
            auto elems = make_unique<vector<unique_ptr<SpecNode>>>();
            elems->push_back(proj->defs[r]->body->deep_copy());
            elems->push_back(std::move(relation));
            relation = make_unique<Expr>(Expr::AND, std::move(elems), Bool::BOOL);
        }
        auto rel = proj->defs[*proj->relations.begin()].get();
        auto rel_def = make_unique<Definition>("_relate_RData",rel->rettype, make_unique<vector<shared_ptr<Arg>>>(*rel->args), relation->deep_copy());
        for(auto prim : proj->cmds.invs) {
            auto def = proj->defs[prim].get();
            proj->query_saver = QueryInfo(query_saver_dir(def->name, "relate_RData"));
            proj->query_saver.save_config("./test/rcsm-llvm/test_verify.v");

            if (check_hprop_by_path(proj, rel_def.get(), def, nullptr, det)) {
                LOG_DEBUG << "Relate Other " << def->name << " is valid :D";
            } else {
                LOG_DEBUG << "Relate Other " << def->name << " is not valid :(";
                return false;
            }    
        }
    }

    if (!proj->sec_relations.empty()) {
        unique_ptr<SpecNode> sec_relation = make_unique<BoolConst>(true);
        for (auto &r : proj->sec_relations) {
            auto elems = make_unique<vector<unique_ptr<SpecNode>>>();
            elems->push_back(proj->defs[r]->body->deep_copy());
            elems->push_back(std::move(sec_relation));
            sec_relation = make_unique<Expr>(Expr::AND, std::move(elems), Bool::BOOL);
        }
        auto rel = proj->defs[*proj->sec_relations.begin()].get();
        auto rel_def = make_unique<Definition>("_relate_secret",rel->rettype, make_unique<vector<shared_ptr<Arg>>>(*rel->args), sec_relation->deep_copy());
        for(auto prim : proj->cmds.invs) {
            auto def = proj->defs[prim].get();
            proj->query_saver = QueryInfo(query_saver_dir(def->name, "relate_secure"));
            proj->query_saver.save_config("./test/rcsm-llvm/test_verify.v");
            bool det = false;
            if (check_hprop_by_path(proj, rel_def.get(), def, nullptr, false)) {
                LOG_DEBUG << "Relate Secure" << def->name << " is valid :D";
                return true;
            } else {
                LOG_DEBUG << "Relate Secure" << def->name << " is not valid :(";
                return false;
            }    
        }
    }
    return true;
}

/**
 * spec_prover:
 *  1. Prove invariants separately 
 *  2. For each inv, compute its coi and apply projection
 *  3. Prove inv path-by-path, recursively check abst function
 */
void spec_prover(Project *proj) {
    std::unordered_map<string, double> inv_costs;

    unique_ptr<SpecNode> conjoined_invs = make_unique<BoolConst>(true);
    std::unordered_set<string> used_abstract_funcs;
    //check system invariant incrementally. The invariant dependent on another should be defined
    //after the other invariant.
    LOG_DEBUG << "check invariant: " << OPTS.check_inv;
    if(OPTS.check_inv) {
        for(auto &[name, inv]: proj->sys_invs) {
            auto begin = std::chrono::high_resolution_clock::now();
            bool valid = false;
            for(auto prim : proj->cmds.invs) {
                // Prove invariants separately
                auto goal_def = proj->defs[prim].get();
                if (goal_def == nullptr) continue;
                auto elems = new vector<unique_ptr<SpecNode>>();
                elems->push_back(std::move(conjoined_invs));
                elems->push_back(inv->deep_copy());
                //conjoined_invs = make_unique<Expr>(Expr::binops::AND, unique_ptr<vector<unique_ptr<SpecNode>>>(elems));
                proj->query_saver = QueryInfo(query_saver_dir(goal_def->name, name));
                proj->query_saver.save_config("./test/rcsm-llvm/test_verify.v");
                std::cout << "[spec_prover] Invariant: " << string(*inv) << std::endl;
                //std::deque<Definition *> q = {goal_def};

                auto l_args = make_unique<vector<shared_ptr<Arg>>>();
                for (auto arg : *goal_def->args) {
                    l_args->push_back(arg);
                }
                auto spec_def = new Definition(goal_def->name, goal_def->rettype, std::move(l_args), goal_def->body->deep_copy());
                auto coi = analyze_cone_of_influence(proj, spec_def, inv.get(), autov::coi_whitelist, autov::coi_blacklist);
                spec_abstraction(proj, spec_def, coi);
                spec_def->infer_type(*proj);
                std::cout << "[spec_abstraction] coi set: " << std::endl;
                for (auto &c : coi) {
                    std::cout << c << std::endl;
                }
                proj->verifying_invariant = name;
                if (check_inv_by_path(proj, spec_def, inv.get(), used_abstract_funcs)) {
                    valid = true;
                    LOG_DEBUG << "Invariant " << name << " Valid :D :" << prim;
                } else {
                    LOG_DEBUG << "Invariant " << name << " not Valid :(" << prim;
                }
            }
            auto end = std::chrono::high_resolution_clock::now();
            inv_costs[name] = std::chrono::duration<double>(end - begin).count();
            if(valid)
                proj->verified_invariants.insert(name);
        }
    }

    //check loop_invariant, only check what's needed.
    if(OPTS.check_loop_inv || OPTS.check_pre_post) {
        //check all the loops that have invariants provided.
        while(used_abstract_funcs.size() > 0) {
            auto func = *(used_abstract_funcs.begin());
            used_abstract_funcs.erase(used_abstract_funcs.begin());
            if(proj->defs.find(func) != proj->defs.end()){
                auto def = proj->defs[func].get();
                LOG_DEBUG << "Checking Loop Invariant: " << def->name;
                if(is_instance(def, Fixpoint) && OPTS.check_loop_inv) {
                    if(check_loop_inv_v2(proj, def, used_abstract_funcs))
                        LOG_DEBUG << "loop invariant: " << func << " is inductive :)";
                    else
                        LOG_ERROR << "loop invariant: " << func << "is not inductive! :(";
                } else if(is_instance(def, Definition) && OPTS.check_pre_post){
                    if(check_pre_post(proj, def, used_abstract_funcs))
                        LOG_ERROR << "Precondition imply post condition :) " << func;
                    else
                        LOG_ERROR << "Precondition does not imply post condition :( " << func;
                }
            } else {
                LOG_ERROR << "no definition named:" << func;
            }
        }
    }

    Z3Cache.clear();
    PROFILE_START(simulation_det);
    if (OPTS.check_simulation) {
        if(simulate(proj, true)) {
            LOG_DEBUG << "Det Relational Property Valid! :D";
        } else {
            LOG_DEBUG << "Det Relational Property not Valid! :D";
        }
    }
    PROFILE_END(simulation_det);
    Z3Cache.clear();
    
    PROFILE_START(simulation_non_det);
    if (OPTS.check_simulation) {
        if(simulate(proj, false)) {
            LOG_DEBUG << "Nondet Relational Property Valid! :D";
        } else {
            LOG_DEBUG << "Nondet Relational Property not Valid! :D";
        }
    }
    PROFILE_END(simulation_non_det);
    
    PROFILE_START(decom_simulation);
    if(OPTS.decompose_check_simulation) {
        //overloading the command CheckInv
        for(auto prim : proj->cmds.invs) {
            if(decompose(proj, proj->defs[prim].get())) {
                LOG_DEBUG << "Decom Relational Property for " << prim << "is Valid! :D";
            } else {
                LOG_DEBUG << "Decom Relational Property for " << prim << "is not Valid! :D";
            }
        }
    }
    PROFILE_END(decom_simulation);

    for (auto &inv : inv_costs) {
        LOG_INFO << "Invariant " << inv.first << " takes " << inv.second << " (s)";
    }
    profile_print_simulation();
}
}