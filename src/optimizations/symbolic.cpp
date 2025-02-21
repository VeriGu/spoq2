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
#include <variant>
#include <type_inference.h>

namespace autov
{

bool is_invariant_defs(Project *proj, const string &name) {
    return proj->symbols[name].loc == autov::loc_t("Invariants", "Spec", "");
}

bool is_lemma_defs(Project *proj, const string &name) {
    return proj->symbols[name].loc == autov::loc_t("Lemmas", "Spec", "");
}

void print_field(const field_t &f) {
    std::cout << "[print_field] Field: ";
    for (auto &i : f) {
        std::cout << i << ", ";
    }
    std::cout << std::endl;
}

void print_path(const path_t &p) {
    std::cout << "[print_path] Path: ";
    for (auto &i : p) {
        std::cout << i << ", ";
    }
    std::cout << std::endl;
}

inline bool contains_field(const field_t &f_check, const field_t &f_interested) {
    return std::search(f_check.begin(), f_check.end(), f_interested.begin(), f_interested.end()) != f_check.end();
}

bool has_subfield(const std::set<field_t> &fields, const field_t &f) {
    for (auto &f_check : fields) {
        if (contains_field(f_check, f)) {
            return true;
        }
    }
    return false;
}

bool has_proper_subfield(const std::set<field_t> &fields, const field_t &f) {
    for (auto &f_check : fields) {
        if (f_check.size() != f.size() && contains_field(f_check, f)) {
            return true;
        }
    }
    return false;
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

/** get_access_field
 *      return the access field chain of the given expr
 *         e.g. (x).(y).(z) -> [z, y, x]
 *      fields is used when it composed of other unsolved expressions
 *         e.g. (x)@(y) -> fields.add(Analyse(y))
 */
field_t get_access_field(Project* proj, SpecNode* node, std::set<field_t> &fields, field_t &trace) {
    if (auto s = instance_of(node, Symbol)) {
        if (proj->symbols.find(s->text) != proj->symbols.end() &&
                                proj->symbols[s->text].kind == SymbolKind::StructElem) {
            // we reach the leaf field, add the current access trace to the set
            trace.push_back(s->text);
        }
        return trace;
    } else if (is_instance(node, Const)) {
        return trace;
    } else if (auto e = instance_of(node, Expr)) {
        if (holds_alternative<Expr::ops>(e->op)) {
            if (std::get<Expr::ops>(e->op) == Expr::GET) {
                // (x)@(y) :: F(y) should be evaluated independently
                rec_analyze_used_fields(proj, e->elems->at(1).get(), fields);
                return get_access_field(proj, e->elems->at(0).get(), fields, trace);
            } else if (std::get<Expr::ops>(e->op) == Expr::RecordGet) {
                get_access_field(proj, e->elems->at(1).get(), fields, trace);
                return get_access_field(proj, e->elems->at(0).get(), fields, trace);
            }
        }
    }
    // met with non-tracable opration, stop here and let rec_analyze_used_fields solve it
    rec_analyze_used_fields(proj, node, fields);
    return trace;
}

void rec_analyze_used_fields(Project* proj, SpecNode* node, std::set<field_t> &fields) {
    field_t empty_trace = {};
    if (auto wa = instance_of(node, ForallExists)) {
        for (auto const &var: *wa->vars) {
            if (var->expr) {
                rec_analyze_used_fields(proj, var->expr.get(), fields);
            }
        }
        rec_analyze_used_fields(proj, wa->body.get(), fields);
    } else if (auto r = instance_of(node, RelyAnno)) {
        rec_analyze_used_fields(proj, r->prop.get(), fields);
        rec_analyze_used_fields(proj, r->body.get(), fields);
    } else if (auto e = instance_of(node, Expr)) {
        if (holds_alternative<Expr::binops>(e->op)) {		
            for (int i = 0; i < e->elems->size(); i++) {
                rec_analyze_used_fields(proj, e->elems->at(i).get(), fields);
            }
        } else if (holds_alternative<Expr::ops>(e->op)) {
            if (std::get<Expr::ops>(e->op) == Expr::GET) {
                // (x)@(y):
                auto f = get_access_field(proj, e, fields, empty_trace);
                if (!f.empty()) {
                    fields.insert(f);
                }
            } else if (std::get<Expr::ops>(e->op) == Expr::SET) {
                rec_analyze_used_fields(proj, e->elems->at(1).get(), fields);
                // pass
            } else if (std::get<Expr::ops>(e->op) == Expr::RecordGet) {
                auto f = get_access_field(proj, e, fields, empty_trace);
                if (!f.empty()) {
                    fields.insert(f);
                }
            } else if (std::get<Expr::ops>(e->op) == Expr::RecordSet) { 
                // expr.elem[0]: record
                // expr.elem[1...n-2]: (sub)fields
                // expr.elem[n-1]: value
                auto fields_in_src = std::set<field_t>();
                auto fields_in_val = std::set<field_t>();
                field_t access_field = {};
                for (int i = e->elems->size() - 2; i > 0; i--) {
                    auto f = e->elems->at(i).get();
                    if (auto s = instance_of(f, Symbol)) {
                        access_field.push_back(s->text);
                    }
                }
                rec_analyze_used_fields(proj, e->elems->at(e->elems->size() - 1).get(), fields_in_val);
                rec_analyze_used_fields(proj, e->elems->at(0).get(), fields_in_src);
                
            } else {
                for (int i = 0; i < e->elems->size(); i++) {
                    rec_analyze_used_fields(proj, e->elems->at(i).get(), fields);
                }
            }
        } else if (holds_alternative<string>(e->op)) {
            for (int i = 0; i < e->elems->size(); i++) {
                rec_analyze_used_fields(proj, e->elems->at(i).get(), fields);
            }
        } else if (holds_alternative<unique_ptr<SpecNode>>(e->op)) {
            // pass
        }
    } else if (auto s = instance_of(node, Symbol)) {
        auto f = get_access_field(proj, s, fields, empty_trace);
        if (!f.empty()) {
            fields.insert(f);
        }

    } else if (auto c = instance_of(node, Const)) {
        // pass
    } else {
        throw std::runtime_error("[rec_analyze_used_fields] Unexpected node type: " + string(*node));
    }
}

void extract_vars_from_expr(Project *proj, SpecNode *pattern, std::set<string> &vars) {
    if (auto s = instance_of(pattern, Symbol)) {
        vars.insert(s->text);
    } else if (auto e = instance_of(pattern, Expr)) {
        if (auto *o = std::get_if<unique_ptr<SpecNode>>(&e->op))
            extract_vars_from_expr(proj, o->get(), vars);
        for (auto &elem : *e->elems)
            extract_vars_from_expr(proj, elem.get(), vars);
    }
}
/** collect_immi_symbols_in:
 *       compute each symbol's source expression of the given encoded path 
 * */
void collect_immi_symbols_in(Project *proj, SpecNode *spec, const path_t &path, int idx, std::map<string, path_node_t> &symbol_source) {
    /** TODO: skip abst func */
    if (auto s = instance_of(spec, Symbol)) {
        // pass
    } else if (auto e = instance_of(spec, Expr)) {
        // pass
    } else if (auto m = instance_of(spec, Match)) {
        // map: pattern -> m->src (source expression)
        /** TODO: only apply to _When stmt */
        for (auto &pm : *m->match_list) {
            auto pm_vars = std::set<string>();
            extract_vars_from_expr(proj, pm->pattern.get(), pm_vars);
            for (auto &v : pm_vars) {
                symbol_source[v].first = m->src.get();
                if (idx >= path.size()) {
                    symbol_source[v].second = path_t(path.begin(), path.end());
                } else {
                    symbol_source[v].second = path_t(path.begin(), path.begin() + (idx+1));
                }
            }
            collect_immi_symbols_in(proj, pm->body.get(), path, idx, symbol_source);
        }
    } else if (auto r = instance_of(spec, Rely)) {
        collect_immi_symbols_in(proj, r->body.get(), path, idx, symbol_source);
    } else if (auto r = instance_of(spec, Anno)) {
        collect_immi_symbols_in(proj, r->body.get(), path, idx, symbol_source);
    } else if (auto i = instance_of(spec, If)) {
        if (!path.empty() && idx < path.size()) {
            if (path.at(idx)) {
                collect_immi_symbols_in(proj, i->then_body.get(), path, idx+1, symbol_source);
            } else {
                collect_immi_symbols_in(proj, i->else_body.get(), path, idx+1, symbol_source);
            }
        }
        // |path| < #branch, pass
    } else {
        throw std::runtime_error("[collect_immi_symbols_in] Unexpected node type: " + string(*spec));
    }
}

/** backward_propagation_on_expr:
 *      Propagate interested-field update on Exprs.
 *      - Add used (but not tracked) fields to coi, 
 *      - When propagate to symbol, add them to to-be-solved symbol set
 */
void backward_propagation_on_expr(Project *proj, SpecNode *node, std::set<field_t> &coi, std::set<field_t> trace, std::set<string> &symbols) {
    if (auto e = instance_of(node, Expr)) {
        if (auto op = std::get_if<Expr::ops>(&e->op)) {
            if (*op == Expr::ops::RecordGet) {
                // Update coi set if necessary
                field_t access_field = {};
                std::set<field_t> used_fields = {};
                get_access_field(proj, e, used_fields, access_field);
                /** FP Elimination: if we are reading the same field duplicately to update its subfields.
                 *  e.g. st1.[f1] :< (st2.(f1) # (foo) == (bar))
                 *      1. spoq ensures st1 == st2 (last state)
                 *      2. f1 in trace, in this case (st.(f1)) should not be added to coi
                 */
                if (!has_subfield(trace, access_field) && coi_blacklist.find(access_field.front()) == coi_blacklist.end()) {
                    rec_analyze_used_fields(proj, e, coi);
                }
                
            } else if (*op == Expr::ops::GET) {
                for (int i = 0; i < e->elems->size(); i++) {
                    backward_propagation_on_expr(proj, e->elems->at(i).get(), coi, trace, symbols);
                }
            } else if (*op == Expr::ops::RecordSet) {
                // WRITE operation: 
                // expr.elem[0]: record
                // expr.elem[1...n-2]: (sub)fields
                // expr.elem[n-1]: value
                field_t set_field = {};
                for (int i = e->elems->size() - 2; i > 0; i--) {
                    auto f = e->elems->at(i).get();
                    if (auto s = instance_of(f, Symbol)) {
                        set_field.push_back(s->text);
                    }
                }
                if (has_subfield(coi, set_field)) {
                    // we are tracing the parent field of some interest field, keep tracing
                    trace.insert(set_field);
                    backward_propagation_on_expr(proj, e->elems->back().get(), coi, trace, symbols);
                }
                backward_propagation_on_expr(proj, e->elems->at(0).get(), coi, trace, symbols);
            } else if (*op == Expr::ops::SET) {
                field_t access_field_in_src = {};
                std::set<field_t> used_fields_in_src = {};
                get_access_field(proj, e->elems->at(0).get(), used_fields_in_src, access_field_in_src);
                if (!has_subfield(trace, access_field_in_src)) {
                    coi.insert(access_field_in_src); 
                }
                // continue walking on the structure tree
                backward_propagation_on_expr(proj, e->elems->at(1).get(), coi, trace, symbols);
            } 
        } else {
            for (int i = 0; i < e->elems->size(); i++) {
                backward_propagation_on_expr(proj, e->elems->at(i).get(), coi, trace, symbols);
            }
        }
    } else if (auto c = instance_of(node, Const)) {
        // pass
    } else if (auto s = instance_of(node, Symbol)) {
        // add to to-be-solved symbol set
        symbols.insert(s->text);
    } else if (auto m = instance_of(node, Match)) {
        LOG_WARNING << "[backward_propagation_on_expr] Unexpected node caused by imcomplete spec_transformation rule: " << string(*m);
        backward_propagation_on_expr(proj, m->src.get(), coi, trace, symbols);
    } else {
        throw std::runtime_error("[backward_propagation_on_expr] unknown node" + string(*node));
    }
}

/** collect_init_nodes_in:
 *      Find all essential values (return values & branch values), collect their Paths
 */
void collect_init_nodes_in(SpecNode *spec, path_t p, std::set<path_node_t> &init_nodes) {
    if (auto e = instance_of(spec, Expr)) {
        if (auto op = std::get_if<Expr::ops>(&e->op)) {
            if (*op == Expr::Some) {
                if (auto ret_Some = instance_of(e->elems->at(0).get(), Expr)) {
                    SpecNode *ret_st = ret_Some;
					// if the return value is := Some (ret_val, st), then take the last 'st'
                    if (auto ret_op = std::get_if<Expr::ops>(&ret_Some->op)) {
						if (*ret_op == Expr::Tuple) {
							ret_st = ret_Some->elems->back()->deep_copy().release();
						}
					}
                    init_nodes.insert({ret_st, p});
                }
            }
        }
    } else if (auto m = instance_of(spec, Match)) {
        for (auto &pm : *m->match_list) {
            collect_init_nodes_in(pm->body.get(), p, init_nodes);
        }
    } else if (auto i = instance_of(spec, If)) {
        init_nodes.insert({i->cond.get(), p});
        path_t p_then = p, p_else = p;
        p_then.push_back(1);
        p_else.push_back(0);
        collect_init_nodes_in(i->then_body.get(), p_then, init_nodes);
        collect_init_nodes_in(i->else_body.get(), p_else, init_nodes);
    } else if (auto r = instance_of(spec, RelyAnno)) {
        collect_init_nodes_in(r->body.get(), p, init_nodes);
    } else if (auto f = instance_of(spec, ForallExists)) {
        collect_init_nodes_in(f->body.get(), p, init_nodes);
    }
}

/* Collect accessed fields in invariants */
inline void analyze_invariant_fields(Project *proj, SpecNode *inv, string name) {
    rec_analyze_used_fields(proj, inv, proj->inv_fields[name]);
}

/** backward_propagation: 
 *  Step 1. Find propagation expression (e.g. return values)
 *  Step 2. From expression, (backward) infer needed values
 *  Step 3. Find the definition of needed values (if necessary), update them to expressions 
 * 
 * Repeat steps until find all the dependent fields (Fixpoint of COI)
 *      Propagation (coi update) terminates when no new expression is propagated along the path
 * 
 *  Give an expression and a set of interested fields, backward propagate to all the dependent fields (its definition)
 */
std::set<string> analyze_cone_of_influence(Project *proj, Definition *def, SpecNode *inv) {
    std::set<string> coi_ret = {};
    for (auto c : coi_whitelist) {
        coi_ret.insert(c);
    }

    auto args = def->args.get();
    auto spec = def->body.get();
    std::set<string> arg_symbols = {};
    for (int i = 0 ; i < args->size() ; i++) {
        arg_symbols.insert(args->at(i)->name);
    }

    // initial propagation set: return values
    std::set<path_node_t> nodes = {};
    path_t p = {};
    collect_init_nodes_in(spec, p, nodes);

    // initial propagation field: inv-related fields
    string inv_name = "invariant";
    analyze_invariant_fields(proj, inv, inv_name);
    auto f = proj->inv_fields[inv_name];
    std::set<field_t> coi_fields = f;
    std::cout << "[analyze_cone_of_influence] Initial COI fields: " << std::endl;
    for (auto &c : coi_fields) {
        print_field(c);
    }
    // Propagation (coi update) terminates when no new expression is propagated along the path
    std::deque<path_node_t> q(nodes.begin(), nodes.end());
    while (!q.empty()) {
        auto [expr, path] = q.front();
        q.pop_front();
        std::map<string, path_node_t> immediate_symbols = {};
        collect_immi_symbols_in(proj, spec, path, 0, immediate_symbols);

        std::set<string> symbols = {};
        backward_propagation_on_expr(proj, expr, coi_fields, {}, symbols);

        for (const auto &s : symbols) {
            if (arg_symbols.find(s) != arg_symbols.end()) {
                /** TODO: optimization: 
                 *          if a field belongs to an input parameter, 
                 *          then its access fields should not be added to coi set 
                 */
                continue;
            } else if (proj->symbols.find(s) != proj->symbols.end() || proj->is_ind_constr(s)) {
                continue;
            } else if (immediate_symbols.find(s) != immediate_symbols.end()) {
                q.push_back(immediate_symbols[s]);
            } else {
                throw std::runtime_error("[analyze_cone_of_influence] Unexpected symbol: " + s);
            }
        }   
    }
    for (auto &c : coi_fields) {
        if (coi_blacklist.find(c.front()) != coi_blacklist.end()) {
            continue;
        }
        coi_ret.insert(c.front());
        proj->coi[def->name][inv_name].insert(c.front());
    }
    return coi_ret;
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
    SpecNode* aggreinv = new BoolConst(true);
    for(auto &inv : invs) {
        auto elems = new vector<unique_ptr<SpecNode>>();
        elems->push_back(unique_ptr<SpecNode>(aggreinv));
        elems->push_back(inv->deep_copy());
        aggreinv = new Expr(Expr::binops::AND, unique_ptr<vector<unique_ptr<SpecNode>>>(elems), Bool::BOOL);
    }

	type_inference::infer_type(*proj, aggreinv, known, Bool::BOOL);

    SpecNode *before_inv = aggreinv;
    //subst invariant inv[ret_x[0]/a' ret_x[1]/b' ret_x[2]/c' ret_x[3]/d']
    for(auto arg : *loop->args) {
                        // if (arg->name != "_N_") {
        auto sym = new Symbol(loop->name + "_" + arg->name, arg->type);
        bool succ;
        before_inv = subst(before_inv, arg->name, sym, succ);
        delete sym;
                        // }
    }
	auto sym = new Symbol(loop->name + "_" + "st_old", loop->args->back()->type);
	bool succ;
	before_inv = subst(before_inv, "st_old", sym, succ);
	delete sym;
    auto vc = z3ctx.bool_val(true);
    set<string> used_fix;
    auto invval = z3_eval(proj, before_inv, make_shared<EvalState>(var, conds), false, true, used_fix);
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
	// for(auto &cond: *state->conds) {
	// 	LOG_DEBUG << "Cond:" << cond;
	// }
	z3::model model(z3ctx);
    auto res = z3_check_unsat(state, z3::implies(vc, invval->get_z3_value()), model, &proj->query_saver, 50000);
    if(res == Z3Result::False || res == Z3Result::Unknown || res == Z3Result::Sat) {
		if(res == Z3Result::Sat) {
			LOG_ERROR << "Solver return SAT";
			LOG_INFO << "model: " << model;
		}
        LOG_ERROR << "Precondition can't infer loop invariant";
        delete before_inv;
        delete aggreinv;
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
	SpecNode* aggrepres = new BoolConst(true);
	for(auto &inv : preconds) {
			auto elems = new vector<unique_ptr<SpecNode>>();
			elems->push_back(unique_ptr<SpecNode>(aggrepres));
			elems->push_back(inv->deep_copy());
			aggrepres = new Expr(Expr::binops::AND, unique_ptr<vector<unique_ptr<SpecNode>>>(elems), Bool::BOOL);
	}
    type_inference::infer_type(*proj, aggrepres, known, Bool::BOOL);
    SpecNode *before_inv = aggrepres;
                    
    for(auto arg : *def->args) {             
        auto sym = new Symbol(def->name + "_" + arg->name, arg->type);
        bool succ;
        before_inv = subst(before_inv->deep_copy().release(), arg->name, sym, succ);
        delete sym;
    }
    auto sym = new Symbol(def->name + "_" + "st_old", def->args->back()->type);
    bool succ;
    before_inv = subst(before_inv->deep_copy().release(), "st_old", sym, succ);
    delete sym;
    auto vc = z3ctx.bool_val(true);
    set<string> used_fix;
    auto invval = z3_eval(proj, before_inv, make_shared<EvalState>(var, conds), false, true, used_fix);
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
                        //LOG_INFO << "[Checking Precondition] eq formula" << vc;
                        //LOG_INFO << "[Checking Preconditon] invariant" << invval->get_z3_value();
                        // for(auto &cond: *state->conds) {
                        // 	LOG_DEBUG << "Cond:" << cond;
                        // }
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
}

/** prove_by_traverse:
 * 		works on specs with abstract functions, symbolically check inv path-by-path
 * 1. Normal invariant: instantiate SpecNode *inv
 * 2. Data-race-free: SpecNode *inv = NULL
 * */
bool prove_by_traverse(Project *proj, SpecNode *spec, SpecNode *inv, shared_ptr<ProveState> state) {
    if (auto expr = instance_of(spec, Expr)) {
        if (auto e_op = std::get_if<Expr::ops>(&expr->op)) {
            if (*e_op == Expr::Some) {
                if (auto ret_Some = instance_of(expr->elems->at(0).get(), Expr)) {
					SpecNode *ret_st = ret_Some;
					// if the return value is := Some (ret_val, st), then take the last 'st'
					if (auto ret_op = std::get_if<Expr::ops>(&ret_Some->op)) {
						if (*ret_op == Expr::Tuple) {
							ret_st = ret_Some->elems->back()->deep_copy().release();
						}
					}
					// Prove the return state maintains the invariant
					// construct new invariants
					auto p = instantiate_prop(inv->deep_copy().release(), ret_st);
                    set<string> used_fix;
					auto c = z3_eval(proj, p, state, false, true, used_fix);
					// for(auto &cond: *state->conds) {
					// 	LOG_DEBUG << "Cond:" << cond;
					// }
					z3::model model(z3ctx);
					auto z3_ret = z3_check_unsat(state, c->get_z3_value(), model, &proj->query_saver, 2000);

					// std::cout << "----------------------------------" << std::endl;
					// std::cout << "prove_by_traverse: Final State\n" << string(*ret_st) << std::endl;
					//std::cout << "prove_by_traverse: Goal Query\n" << c->get_z3_value() << std::endl;
					// std::cout << "----------------------------------" << std::endl;
					if (z3_ret == Z3Result::Sat) {
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
        set<string> used_fix;
        auto src = z3_eval(proj, m->src.get(), state, true, false, used_fix);
        state->inductions->clear();
		if(auto expr = instance_of(m->src.get(), Expr)) {
			if(holds_alternative<string>(expr->op)){
			auto op = std::get<string>(expr->op);
			auto info = proj->symbols[op];
			if (info.kind == SymbolKind::Def) {
			vector<shared_ptr<SpecValue>> elems;

			for (auto e = expr->elems->begin(); e != expr->elems->end(); e++) {
				elems.push_back(z3_eval(proj, e->get(), state));
			}
			if(proj->defs.find(op) != proj->defs.end()) {
				if(auto loop = instance_of(proj->defs[op].get(), Fixpoint)){
					check_states_implies_loop_inv(proj, state, op, elems);
                    LOG_INFO << "[Checking Loop Invariant] Precondition implies invariant";
                    auto fname = loop->name;
                    auto loop_post_cond = formulate_loop_invariant(proj, fname, expr->elems.get());
					for (auto arg : *loop->args) {
                        if (arg->name != "_N_") {
                                (*state->vars)[loop->name + "_" + arg->name + "'"] = arg->type->declare(loop->name + "_" + arg->name + "'", 0); //current
                        }
                    }
					//LOG_DEBUG << "[Checking Loop Invariant] Adding loop postcondition: " << string(*loop_post_cond);
                    auto loop_post_val = z3_eval(proj, loop_post_cond.get(), state, false, true, used_fix);
					auto post = loop_post_val->get_z3_value();
					for(auto arg : *loop->args) {
						if (arg->name != "_N_") {
                            post = z3::forall((*state->vars)[loop->name + "_" + arg->name + "'"]->get_z3_value(), post);
                        }
					}
                    //delete loop_post_cond;
					LOG_DEBUG << "[Checking Loop Invariant] Adding loop postcondition: " << op;
                    state->add_induction(post);
				} else {
					//normal Definition. Check the precondition and add post condition.
                    auto def = proj->defs[op].get();
					if(proj->cmds.PreCond.find(op) != proj->cmds.PreCond.end()) {
						check_states_implies_pre_condition(proj, state, op, elems);
					}

					if(proj->cmds.PostCond.find(op) != proj->cmds.PostCond.end()) {
						//add post condition
                        auto post_cond = formulate_post_condition(proj, op, expr->elems.get());
                        string tmpname = "__tmp__";
                        int i = 0;
                        auto rettype = instance_of(def->rettype.get(), Option);
                        if(auto rettupletype = instance_of(rettype->elem_type.get(), Tuple)) {
                            for(auto elemtype : *rettupletype->types) {
                                if(i != rettupletype->types->size() - 1) {
                                    (*state->vars)[def->name + tmpname + std::to_string(i)] = elemtype->declare(def->name + tmpname + std::to_string(i), 0); //after
                                } else {
                                    (*state->vars)[def->name + "_st'"] = elemtype->declare(def->name + "_st'", 0); //after
                                }
                                i++;
                            }
                        } else{
                            (*state->vars)[def->name + "_st'"] = rettype->elem_type->declare(def->name + "_st'", 0);
                        }

                        auto post_val = z3_eval(proj, post_cond.get(), state, false, false, used_fix);
                        auto post = post_val->get_z3_value();
                        if(auto rettupletype = instance_of(rettype->elem_type.get(), Tuple)) {
                            i = 0;
                            for(auto elemtype : *rettupletype->types) {
                                if(i != rettupletype->types->size() - 1) {
                                    post = z3::forall((*state->vars)[def->name + tmpname + std::to_string(i)]->get_z3_value(), post);
                                } else {
                                    post = z3::forall((*state->vars)[def->name + "_st'"]->get_z3_value(), post);
                                }
                                i++;
                            }
                        } else {
                            post = z3::forall((*state->vars)[def->name + "_st'"]->get_z3_value(), post);
                        }
                        //delete post_cond;
                        LOG_DEBUG << "[Adding Post Condition] Adding func postcondition: " << string(*post_cond);
					    LOG_DEBUG << "[Adding Post Condition] Adding func postcondition: " << post;
                        state->add_induction(post);
					}
                    //if it is a preserving function, directly add post condition
                    if(proj->cmds.PreserveInv.find(op) != proj->cmds.PreserveInv.end()) {
                        unique_ptr<SpecNode> post_cond = formulate_preserved_function(proj, op);
                        auto post_val = z3_eval(proj, post_cond.get(), state, false, true, used_fix);
                        //delete post_cond;
                        state->add_induction(post_val->get_z3_value());
                        LOG_DEBUG << "[Adding Post Condition] Adding preserved inv postcondition: " << op;
                    }
				}
			}
			}
			}
		}
		for (auto pm = m->match_list->begin() ; pm != m->match_list->end(); pm++) {
			auto new_state = state->copy();
			unordered_map<string, shared_ptr<SpecValue>> vars;
            unordered_map<string, shared_ptr<SpecValue>> assigns;
			auto pat = resolve_pattern(proj, spec, (*pm)->pattern.get(), src, vars, assigns);
            auto cond = pat->get_z3_value() == src->get_z3_value();
            //exists v1,v2..., constructor v1 v2 ... = src.
            for (auto v = vars.begin(); v != vars.end(); v++) {
                cond = z3::exists(v->second->get_z3_value(), cond);
            }

			new_state->conds->push_back(cond);

            for (auto v = assigns.begin(); v != assigns.end(); v++) {
                (*new_state->vars)[v->first] = v->second;
            }

			if (!prove_by_traverse(proj, (*pm)->body.get(), inv, new_state)) {
				return false;
			}
		}
    } else if (auto i = instance_of(spec, If)) {
		// push cond
		auto c = z3_eval(proj, i->cond.get(), state);
		auto true_state = state->copy();
		auto false_state = state->copy();
		true_state->conds->push_back(c->get_z3_value());
		false_state->conds->push_back(!c->get_z3_value());
		if (!prove_by_traverse(proj, i->then_body.get(), inv, true_state) || 
			!prove_by_traverse(proj, i->else_body.get(), inv, false_state)) {
			return false;
		}
    } else if (auto r = instance_of(spec, Rely)) {
		// push cond
		auto c = z3_eval(proj, r->prop.get(), state);
		state->conds->push_back(c->get_z3_value());
        return prove_by_traverse(proj, r->body.get(), inv, state);
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

/** check_inv_by_path: 
 * 1. Push initial invariant 
 * 2. Traverse the spec, push control point constriants
 * 3. Arrive return point, push return value constraints, check
 * */ 
bool check_inv_by_path(Project *proj, Definition *def, SpecNode *inv) {
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
	std::cout << "inv body: " << string(*inv) << std::endl;
	std::cout << "inv value: " << c->get_z3_value() << std::endl;
		
	/** TODO: substitute spec_transformer with a spec_walker that detects proved specs that no need for unfolding */
	bool ret = prove_by_traverse(proj, def->body.get(), inv, state);
	return ret;
}

/**
 * spec_prover:
 *  1. Prove invariants separately 
 *  2. For each inv, compute its coi and apply projection
 *  3. Prove inv path-by-path, recursively check abst function
 */
void spec_prover(Project *proj) {
    static const std::set<string> drf_init_coi = {"e_lock", };
    unique_ptr<SpecNode> conjoined_invs = make_unique<BoolConst>(true);
    //check system invariant
    if(proj->cmds.CheckInv) {
        for(auto &[name, inv]: proj->sys_invs) {
            for(auto prim : proj->cmds.invs) {
                // Prove invariants separately
                auto goal_def = proj->defs[prim].get();
                auto elems = new vector<unique_ptr<SpecNode>>();
                elems->push_back(std::move(conjoined_invs));
                elems->push_back(inv->deep_copy());
                conjoined_invs = make_unique<Expr>(Expr::binops::AND, unique_ptr<vector<unique_ptr<SpecNode>>>(elems));

                std::cout << "[spec_prover] Invariant: " << string(*conjoined_invs) << std::endl;
                //std::deque<Definition *> q = {goal_def};
                auto coi = analyze_cone_of_influence(proj, goal_def, inv.get());
                //spec_abstraction(proj, goal_def, coi);
                //goal_def->infer_type(*proj);
                // std::cout << "[spec_abstraction] coi set: " << std::endl;
                // for (auto &c : coi) {
                //     std::cout << c << std::endl;
                // }

                if (check_inv_by_path(proj, goal_def, inv.get())) {
                        LOG_DEBUG << "Invariant" << name << "Valid :D :" << prim;
                } else {
                        LOG_DEBUG << "Invariant" << name << "not Valid :(" << prim;
                        break;
                }
            }
        }
    }
    //check abstract function's pre/post condition.
    //TODO
    
    //check loop_invariant
    if(proj->cmds.CheckLoopInv) {
        //check all the loops that have invariants provided.
        for(auto &[string,inv] : proj->loop_invs) {
            if(proj->defs.find(string) != proj->defs.end()){
                auto def = proj->defs[string].get();
                LOG_DEBUG << "Checking Loop Invariant: " << def->name;
                if(is_instance(def, Fixpoint) && check_loop_inv(proj, def)) {
                    LOG_DEBUG << "loop invariant: " << string << " is inductive :)";
                } else {
                    LOG_ERROR << "loop invariant: " << string << "is not inductive! :(";
                }
            } else {
                LOG_ERROR << "no loop named:" << string;
            }
        }
    }

}

}