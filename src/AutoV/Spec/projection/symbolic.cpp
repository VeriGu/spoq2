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

/* */
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
            } else if (std::get<Expr::ops>(e->op) == Expr::RecordGet) {
                auto f = get_access_field(proj, e, fields, empty_trace);
                if (!f.empty()) {
                    fields.insert(f);
                }
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
            std::cout << "[rec_analyze_used_fields] Symbol\n" << string(*s) << std::endl;
            print_field(f);
            fields.insert(f);
        }

    } else if (auto c = instance_of(node, Const)) {
        // pass
    } else {
        throw std::runtime_error("[rec_analyze_used_fields] Unexpected node type: " + string(*node));
    }
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
            get_vars_from_pattern(proj, pm->pattern.get(), pm_vars);
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
void backward_propagation_on_expr(Project *proj, SpecNode *node, std::set<field_t> &coi, std::set<string> &symbols) {
    if (auto e = instance_of(node, Expr)) {
        if (auto op = std::get_if<Expr::ops>(&e->op)) {
            if (*op == Expr::ops::RecordGet) {
                // Update coi set
                rec_analyze_used_fields(proj, e, coi);
                
            } else if (*op == Expr::ops::GET) {
                for (int i = 0; i < e->elems->size(); i++) {
                    backward_propagation_on_expr(proj, e->elems->at(i).get(), coi, symbols);
                }
            } else if (*op == Expr::ops::RecordSet) {
                // WRITE operation: 
                // expr.elem[0]: record
                // expr.elem[1...n-2]: (sub)fields
                // expr.elem[n-1]: value
                field_t f = {};
                for (int i = e->elems->size() - 2; i > 0; i--) {
                    auto field = e->elems->at(i).get();
                    if (auto s = instance_of(field, Symbol)) {
                        f.push_back(s->text);
                    }
                }
                if (has_subfield(coi, f)) {
                    backward_propagation_on_expr(proj, e->elems->back().get(), coi, symbols);
                }
                backward_propagation_on_expr(proj, e->elems->at(0).get(), coi, symbols);
            } else if (*op == Expr::ops::SET) {
                for (int i = 0; i < e->elems->size(); i++) {
                    backward_propagation_on_expr(proj, e->elems->at(i).get(), coi, symbols);
                }
            } 
        } else {
            for (int i = 0; i < e->elems->size(); i++) {
                backward_propagation_on_expr(proj, e->elems->at(i).get(), coi, symbols);
            }
        }
    } else if (auto c = instance_of(node, Const)) {
        // pass
    } else if (auto s = instance_of(node, Symbol)) {
        // add to to-be-solved symbol set
        symbols.insert(s->text);
    } else if (auto m = instance_of(node, Match)) {
        LOG_WARNING << "[backward_propagation_on_expr] Unexpected node caused by imcomplete spec_transformation rule: " << string(*m);
        backward_propagation_on_expr(proj, m->src.get(), coi, symbols);
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

    // Propagation (coi update) terminates when no new expression is propagated along the path
    std::deque<path_node_t> q(nodes.begin(), nodes.end());
    while (!q.empty()) {
        auto [expr, path] = q.front();
        q.pop_front();

        std::map<string, path_node_t> immediate_symbols = {};
        collect_immi_symbols_in(proj, spec, path, 0, immediate_symbols);

        std::set<string> symbols = {};
        backward_propagation_on_expr(proj, expr, coi_fields, symbols);

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
        coi_ret.insert(c.front());
        proj->coi[def->name][inv_name].insert(c.front());
    }
    std::cout << "[analyze_cone_of_influence] COI for " << inv_name << std::endl;
    for (auto &c: coi_fields) {
        print_field(c);
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

/** prove_by_traverse:
 * 		works on specs with abstract functions, symbolically check inv path-by-path
 * */
bool prove_by_traverse(Project *proj, SpecNode *spec, SpecNode *inv, shared_ptr<EvalState> state, std::deque<Definition *> &deps) {
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
					// Prove the return state maintains the invariant
					// construct new invariants
					auto p = instantiate_prop(inv->deep_copy().release(), ret_st);
					auto c = z3_eval(proj, p, state);
					auto z3_ret = z3_check(state, c->get_z3_value(), Z3_VERIFY_TIMEOUT);

					std::cout << "----------------------------------" << std::endl;
                    std::cout << "prove_by_traverse: Proving invariant for instantiate_prop\n" << string(*p) << std::endl;
					std::cout << "prove_by_traverse: Final State\n" << string(*ret_st) << std::endl;
					std::cout << "----------------------------------" << std::endl;
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
    
        auto src = z3_eval(proj, m->src.get(), state);
		for (auto pm = m->match_list->begin() ; pm != m->match_list->end(); pm++) {
			auto new_state = state->copy();
            auto pat = (*pm)->pattern.get();
			resolve_pattern(proj, m, pat, src, new_state);

            /** handle abstract functions, prove in separation */
            if (!std::holds_alternative<std::nullptr_t>(abst_spec)) {            
                SpecNode *st_ret = extract_st_from_expr(proj, pat);
                if (st_input && st_ret) {
                    auto p_input = instantiate_prop(inv->deep_copy().release(), st_input);
                    auto precond = z3_eval(proj, p_input, new_state);
                    auto z3_ret = z3_check(new_state, precond->get_z3_value(), Z3_VERIFY_TIMEOUT);
                    if (z3_ret == Z3Result::False || z3_ret == Z3Result::Unknown) {
                        LOG_WARNING << "[prove_by_traverse] Invariant is violated for pre-condition state\n" << string(*st_input) << std::endl;
                        // return false; // even pre-conditon is failed, the lemma may still strong enough to ensure post-cond inv
                    }
                    auto p_ret = instantiate_prop(inv->deep_copy().release(), st_ret);
                    auto postcond = z3_eval(proj, p_ret, new_state);
                    new_state->conds->push_back(postcond->get_z3_value());
                    /** add abstract sub-spec to prove queue */
                    if (std::holds_alternative<Definition *>(abst_spec)) {
                        deps.push_back(std::get<Definition *>(abst_spec));
                    }
                }
            }
			if (!prove_by_traverse(proj, (*pm)->body.get(), inv, new_state, deps)) {
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
		if (!prove_by_traverse(proj, i->then_body.get(), inv, true_state, deps) || 
			!prove_by_traverse(proj, i->else_body.get(), inv, false_state, deps)) {
			return false;
		}
    } else if (auto r = instance_of(spec, Rely)) {
		// push cond
		auto c = z3_eval(proj, r->prop.get(), state);
		state->conds->push_back(c->get_z3_value());
        return prove_by_traverse(proj, r->body.get(), inv, state, deps);
    } else {
		// pass
		return true;
	}
	return true;
}

static void lensify_spec(Project *proj, Definition *def, std::set<string> &coi) {
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
}
/**
 * spec_prover:
 *  1. Prove invariants separately 
 *  2. For each inv, compute its coi and apply projection
 *  3. Prove inv path-by-path, recursively check abst function
 */
void spec_prover(Project *proj, Definition *goal_def) {
    if (goal_def->name == "smc_granule_delegate_spec") {
        for (auto const &d: proj->defs) {
            if (!is_invariant_defs(proj, d.first)) {
                continue;
            }
            // Prove invariants separately
            proj->verified_specs.clear();
            auto inv = d.second->body.get();
            std::cout << "[spec_prover] Invariant: " << string(*inv) << std::endl;

            std::deque<Definition *> q = {goal_def};
            while (!q.empty()) {
                auto def = q.front();
                q.pop_front();
                if (proj->verified_specs.find(def->name) != proj->verified_specs.end() && proj->verified_specs[def->name]) {
                    continue;
                }
                std::cout << "[spec_prover] Try proving invariant for " << string(*def) << std::endl;
                if (is_instance(def, Fixpoint)) {
                    std::cout << "[spec_prover] Skip Fixpoint: " << def->name << std::endl;
                    proj->verified_specs[def->name] = true;
                    continue;
                }
                auto coi = analyze_cone_of_influence(proj, def, inv);
                // apply lens to high spec
                lensify_spec(proj, def, coi);
                auto vars = std::make_shared<unordered_map<string, shared_ptr<SpecValue>>>();
	            auto conds = std::make_shared<vector<z3::expr>>();
                for (auto arg : *def->args) {
                    (*vars)[arg->name] = arg->type->declare(arg->name, 0);
                }
                auto state = std::make_shared<EvalState>(vars, conds);
                // invariant by induction
                auto c = z3_eval(proj, inv, state);
                state->conds->push_back(c->get_z3_value());

                // lemmas, note that it only applies to the initial state (st), but that is enough for proving (for now)
                for (auto const &lemma_def : proj->inv_lemmas[d.first]) {
                    auto lemma = lemma_def->body.get();
                    auto lemma_expr = z3_eval(proj, lemma, state);
                    state->conds->push_back(lemma_expr->get_z3_value());
                }
	            
                /** TODO: optimize: no need to generate inv z3 epxr for duplicated times */
                /** TODO: feat: Lemma selection command */
                proj->verified_specs[def->name] = prove_by_traverse(proj, def->body.get(), inv, state, q);
                if (proj->verified_specs[def->name]) {
                    LOG_INFO << "[spec_prover] Invariant: " << d.first << " is verified for " << def->name << std::endl;
                } else {
                    LOG_WARNING << "[spec_prover] Invariant: " << d.first << " can not be verified for " << def->name << std::endl;
                }
            }
        }
    }
}

}