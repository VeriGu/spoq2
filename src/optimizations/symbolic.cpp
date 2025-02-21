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
#include <coi.h>
#include <variant>

namespace autov
{

bool is_invariant_defs(Project *proj, const string &name) {
    return proj->symbols[name].loc == autov::loc_t("Invariants", "Spec", "");
}

bool is_lemma_defs(Project *proj, const string &name) {
    return proj->symbols[name].loc == autov::loc_t("Lemmas", "Spec", "");
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
            return make_shared<IntValue>(*intc);
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



SpecNode *instantiate_prop(SpecNode *spec, SpecNode *instance_st, string st = "st") {
	std::function<SpecNode*(SpecNode*)> f = [&] (SpecNode *node) -> SpecNode* {
		if (auto s = instance_of(node, Symbol)) {
			if (s->text == st) {
				return instance_st;
			}
		}
		return node;
	};
	return rec_apply(spec, f, false);
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

/** prove_by_traverse:
 * 		works on specs with abstract functions, symbolically check inv path-by-path
 * */
bool prove_by_traverse(Project *proj, SpecNode *spec, SpecNode *inv, shared_ptr<ProveState> state, std::deque<Definition *> *deps) {
    if (auto e = instance_of(spec, Expr)) {
        if (auto e_op = std::get_if<Expr::ops>(&e->op)) {
            if (*e_op == Expr::Some) {
                if (auto ret_Some = instance_of(e->elems->at(0).get(), Expr)) {
					SpecNode *ret_st = ret_Some;
					// if the return value is := Some (ret_val, st), then take the last 'st'
					if (auto ret_op = std::get_if<Expr::ops>(&ret_Some->op)) {
						if (*ret_op == Expr::Tuple) {
							ret_st = ret_Some->elems->back()->deep_copy().release();
						}
					}
                    std::cout << "prove_by_traverse: Final state Visiting: " << string(*spec) << std::endl;
					// Prove the return state maintains the invariant
					// construct new invariants
					auto p = instantiate_prop(inv->deep_copy().release(), ret_st);
					auto c = z3_expr(proj, p, state);
                    auto z3_ret = z3_verify(state, c->get_z3_value(), &proj->query_saver);

					// std::cout << "----------------------------------" << std::endl;
					// std::cout << "prove_by_traverse: Final State\n" << string(*ret_st) << std::endl;
                    // std::cout << "prove_by_traverse: Instantiated Invariant\n" << string(*p) << std::endl;
					// std::cout << "----------------------------------" << std::endl;
					if (z3_ret == Z3Result::False) {
						LOG_WARNING << "[prove_by_traverse] Invariant is violated for state\n" << string(*ret_st) << std::endl;
						return false;
					} else if (z3_ret == Z3Result::Unknown) {
						LOG_WARNING << "[prove_by_traverse] Invariant is unknown for state\n" << string(*ret_st) << std::endl;
						return false;
					} else {
						LOG_INFO << "[prove_by_traverse] Invariant is proved for state\n" << string(*ret_st) << std::endl;
						return true;
					}
                }
            }
        }
    } else if (auto m = instance_of(spec, Match)) {
        /** TODO: support loop invariant */
        auto abst_spec = abst_transition(proj, m->src.get()); 
        SpecNode *st_input = extract_st_from_expr(proj, m->src.get());
    
        auto src = z3_expr(proj, m->src.get(), state);
        auto verify_fail = false;
		for (auto pm = m->match_list->begin() ; pm != m->match_list->end(); pm++) {
			auto new_state = state->copy();
            auto pat = (*pm)->pattern.get();
			resolve_pattern(proj, m, pat, src, new_state);

            /** handle abstract functions, prove in separation */
            if (!std::holds_alternative<std::nullptr_t>(abst_spec)) {            
                SpecNode *st_ret = extract_st_from_expr(proj, pat);
                if (st_input && st_ret) {
                    auto p_input = instantiate_prop(inv->deep_copy().release(), st_input);
                    auto precond = z3_expr(proj, p_input, new_state);
                    auto z3_ret = z3_verify(new_state, precond->get_z3_value(), &proj->query_saver);
                    if (z3_ret == Z3Result::Unknown || z3_ret == Z3Result::False) {
                        LOG_WARNING << "[prove_by_traverse] Invariant is violated for pre-condition state\n" << string(*st_input) << std::endl;
                        // return false; // even pre-conditon is failed, the lemma may still strong enough to ensure post-cond inv
                    }
                    auto p_ret = instantiate_prop(inv->deep_copy().release(), st_ret);
                    auto postcond = z3_expr(proj, p_ret, new_state);
                    // new_state->conds->push_back(postcond->get_z3_value());
                    new_state->inductions->clear();
                    new_state->add_induction(postcond->get_z3_value());

                    for (auto const &l : proj->lemmas) {
                        auto lemma_body = proj->defs[l]->body.get();
                        auto lemma = instantiate_prop(lemma_body->deep_copy().release(), st_ret);
                        auto lemma_expr = z3_expr(proj, lemma, new_state);
                        // auto lemma_expr = z3_expr(proj, instantiate_prop(lemma, st_ret), new_state);
                        new_state->add_induction(lemma_expr->get_z3_value());
                    }
                    /** add abstract sub-spec to prove queue */
                    if (deps && std::holds_alternative<Definition *>(abst_spec)) {
                        // deps->push_back(std::get<Definition *>(abst_spec));
                    }
                }
            }
            verify_fail |= !prove_by_traverse(proj, (*pm)->body.get(), inv, new_state, deps);
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
            return prove_by_traverse(proj, i->then_body.get(), inv, true_state, deps);
        } else if (res == Z3Result::False) {
            return prove_by_traverse(proj, i->else_body.get(), inv, false_state, deps); 
        } else {
            auto verify_fail = false;
            verify_fail |= !prove_by_traverse(proj, i->then_body.get(), inv, true_state, deps);
            verify_fail |= !prove_by_traverse(proj, i->else_body.get(), inv, false_state, deps);
            return !verify_fail;
        }
    } else if (auto r = instance_of(spec, Rely)) {
		// push cond
		auto c = z3_expr(proj, r->prop.get(), state);
        auto res = z3_check(state, c->get_z3_value());
        if (res == Z3Result::False || res == Z3Result::Unknown) {
            LOG_WARNING << "[prove_by_traverse] Rely condition is violated: " << string(*r->prop.get()) << std::endl;
        } else {
            LOG_INFO << "[prove_by_traverse] Rely condition is proved: " << string(*r->prop.get()) << std::endl;
        }
		state->conds->push_back(c->get_z3_value());
        return prove_by_traverse(proj, r->body.get(), inv, state, deps);
    } else {
		// pass
		return true;
	}
	return true;
}

static void spec_abstraction(Project *proj, Definition *def, std::set<string> &coi) {
    set_interest_list(coi);

    auto spec = def->body.release();
    while (true) {
        bool changed = false;
        auto tmp_spec = spec;
        do {
            auto [__spec, __changed] = rule_keep_fields_of_interest(proj, spec);
            tmp_spec = __spec;
            changed |= __changed;
        } while (false);

        do {
            auto [__spec, __changed] = rule_simplify_lens(proj, tmp_spec);
            tmp_spec = __spec;
            changed |= __changed;
        } while (false);

        spec = tmp_spec;
        if (!changed) {
            break;
        }
    }
    def->body.reset(spec);
    def->_str = "";
    std::cout << "[spec_abstraction] Abstracted (Lensified) spec:\n" << string(*def) << std::endl;
}

static string query_saver_dir(const string &spec_name, const string &inv_name) {
    return "./container/z3_queries/" + spec_name + "/" + inv_name;
}
/**
 * spec_prover:
 *  1. Prove invariants separately 
 *  2. For each inv, compute its coi and apply projection
 *  3. Prove inv path-by-path, recursively check abst function
 */
void spec_prover(Project *proj, Definition *goal_def) {
    static const std::set<string> drf_init_coi = {"e_lock", };
    if (verify_spec_names.find(goal_def->name) == verify_spec_names.end()) {
        return;
    }
    for (auto const &d: proj->defs) { 
        if (!is_invariant_defs(proj, d.first)) {
            continue;
        }
        // Prove invariants separately
        proj->verified_specs.clear();
        auto inv = d.second->body.get();
        std::cout << "[spec_prover] Invariant: " << string(*inv) << std::endl;

        std::deque<Definition *> q = {goal_def};
        auto coi = analyze_cone_of_influence(proj, goal_def, inv);
        std::cout << "[spec_abstraction] coi set: " << std::endl;
        for (auto &c : coi) {
            std::cout << c << std::endl;
        }

        while (!q.empty()) {
            auto def = q.front();
            q.pop_front();
            if (proj->verified_specs.find(def->name) != proj->verified_specs.end() && proj->verified_specs[def->name]) {
                LOG_INFO << "[spec_prover] Cache hit! Skip: " << def->name << std::endl;
                continue;
            }
            std::cout << "[spec_prover] Try proving invariant for " << string(*def) << std::endl;
            if (is_instance(def, Fixpoint)) {
                std::cout << "[spec_prover] Skip Fixpoint: " << def->name << std::endl;
                proj->verified_specs[def->name] = true;
                continue;
            }
            auto vars = std::make_shared<unordered_map<string, shared_ptr<SpecValue>>>();
            auto conds = std::make_shared<vector<z3::expr>>();
            for (auto arg : *def->args) {
                (*vars)[arg->name] = arg->type->declare(arg->name, 0);
            }
            auto induction = std::make_shared<vector<z3::expr>>();
            auto state = std::make_shared<ProveState>(vars, conds, induction);
            
            /** For the top high-spec we also examine the data-race-free invariant */
            if (def == goal_def) {
                auto drf_args = make_unique<vector<shared_ptr<Arg>>>();
                for (auto &arg: *goal_def->args)
                    drf_args->push_back(arg);
                auto drf_def = new Definition(goal_def->name, goal_def->rettype, std::move(drf_args), goal_def->body->deep_copy());
                
                auto drf_state = state->copy();
                auto drf_coi = drf_init_coi;
                spec_abstraction(proj, drf_def, drf_coi);
                drf_def->infer_type(*proj);
                proj->query_saver = QueryInfo(query_saver_dir(def->name, "drf"));
                if (!check_drf_by_traverse(proj, drf_def->body.get(), drf_state)) {
                    LOG_WARNING << "[spec_prover] DRF invariant is violated for " << drf_def->name << std::endl;
                }
                check_drf_by_traverse(proj, drf_def->body.get(), drf_state);
            }

            spec_abstraction(proj, def, coi);
            def->infer_type(*proj);
            // save queries as reproducible machine-checkable proofs
            proj->query_saver = QueryInfo(query_saver_dir(def->name, d.second->name));
            proj->query_saver.save_config("./test/rcsm/proof_rcsm.v");
            // invariant by induction
            auto c = z3_expr(proj, inv, state);
            state->add_induction(c->get_z3_value());

            // instantiate lemmas for initial state
            for (auto const &lemma_def : proj->inv_lemmas[d.first]) {
                auto lemma = lemma_def->body.get();
                auto lemma_expr = z3_expr(proj, lemma, state);
                state->add_induction(lemma_expr->get_z3_value());
            }
            
            /** TODO: feat: Lemma selection command */
            /** CRITICAL: must clear z3 expr cache here to apply coi correctly */
            def->body->clear_z3_eval();
            proj->verified_specs[def->name] = prove_by_traverse(proj, def->body.get(), inv, state, &q);
            if (proj->verified_specs[def->name]) {
                LOG_INFO << "[spec_prover] Invariant: " << d.first << " is verified for " << def->name << std::endl;
            } else {
                LOG_WARNING << "[spec_prover] Invariant: " << d.first << " can not be verified for " << def->name << std::endl;
            }
        }
    }
}

}