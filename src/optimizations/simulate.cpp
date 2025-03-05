#include <simulate.h>
// TODO: Implement simulation-aux functions, maybe integrated into prove_by_traverse in future
namespace autov
{

	std::pair<bool, z3::expr> check_relation(Project *proj, SpecNode *rel, SpecNode *st_spec, SpecNode *st_impl, shared_ptr<ProveState> state) {
		static const string rel_name_1 = "sec", rel_name_2 = "norm";
		bool succ;
		auto p = subst(rel->deep_copy(), rel_name_1, st_spec, succ);
		p = subst(p->deep_copy(), rel_name_2, st_impl, succ);
		auto rel_expr = z3_eval(proj, p.get(), state);
		z3::model model(z3ctx);
		auto z3_ret = z3_check_unsat(state, rel_expr->get_z3_value(), model, nullptr, Z3_VERIFY_TIMEOUT);
		return std::make_pair(z3_ret == Z3Result::True, rel_expr->get_z3_value());
	}
	/**
	 * 
	 * @brief Compute the simulation states and add inductive constraints 
	 * 
	 * @details
	 * The simulation relation can be visualized with the following diagram:
	 *			(spec)					  (spec_sim)
	 *       +----------+      rel      +-----------+
	 *       |    st    |      ~~~      |    st'    |
	 *       +----------+  (induction)  +-----------+
	 *             |                          |
	 *       (spec)|                    (spec)|
	 *             v                          v
	 *       +----------+      rel      +-----------+
	 *       | spec(st) |      ~~~      | spec(st') |
	 *       +----------+   (to-prove)  +-----------+ 
	 *
	 *  forward_simulation will utilize the induction (rel st st') 
	 *  to compute the unique witness, spec(st'), from current branch constraints.
	 * 
	 * Lemma 1 (skip None): (st ~ st') /\ (Some st1 = spec(st)) => (Some st1' = spec(st'))
	 * Lemma 2 (Inductive Simulation): (st ~ st') /\ (Some st1 = spec(st)) => (spec(st) ~ spec(st'))
	 * 
	 * @return [spec(st'), its following spec body] 
	 */
	std::pair<unique_ptr<SpecNode>, SpecNode *> forward_simulation(Project *proj, SpecNode *impl, shared_ptr<ProveState> state) {
		if (auto expr = instance_of(impl, Expr)) {
			if (auto e_op = std::get_if<Expr::ops>(&expr->op)) {
				if (*e_op == Expr::Some) {
					if (auto ret_Some = instance_of(expr->elems->at(0).get(), Expr)) {
						auto st_ret = expr->elems->at(0)->deep_copy();
						if (auto ret_op = std::get_if<Expr::ops>(&ret_Some->op)) {
							if (*ret_op == Expr::Tuple) {
								st_ret = ret_Some->elems->back()->deep_copy();
							}
						}
						return std::make_pair(std::move(st_ret), nullptr);
					}
				}
			}
		} else if (auto m = instance_of(impl, Match)) {
			set<string> used_fix;
			auto src = z3_eval(proj, m->src.get(), state, true, false, used_fix);
			if (auto expr = instance_of(m->src.get(), Expr)) {
				/** TODO: add post-conds and loop-invs */
			}
			auto abst_spec = abst_transition(proj, m->src.get()); 
			SpecNode *st_input = extract_st_from_expr(proj, m->src.get());
			for (auto pm = m->match_list->begin() ; pm != m->match_list->end(); pm++) {
				auto pat = (*pm)->pattern.get();
				resolve_pattern(proj, m, pat, src, state);
				if (!std::holds_alternative<std::nullptr_t>(abst_spec)) {
					SpecNode *st_ret = extract_st_from_expr(proj, pat);
					if (st_input && st_ret) {
						/** TODO: add lemmas and invariants here */
						return std::make_pair(st_ret->deep_copy(), (*pm)->body.get());
					}
				}
				// for non-abst func here, check state validity here
				auto res = z3_verify_state_sat(state, nullptr);
				if (res == Z3Result::True) {
					return forward_simulation(proj, (*pm)->body.get(), state);
				} else if (res == Z3Result::False) {
					continue;
				} else {
					LOG_WARNING << "forward_simulation: UNKNOWN Matched state!: " << string(*pat);
					break;
				}
			}

		} else if (auto i = instance_of(impl, If)) {
			auto cond = z3_eval(proj, i->cond.get(), state);
			auto res = z3_check(state, cond->get_z3_value());
			if (res == Z3Result::True) {
				state->conds->push_back(cond->get_z3_value());
				return forward_simulation(proj, i->then_body.get(), state);
			} else if (res == Z3Result::False) {
				state->conds->push_back(!cond->get_z3_value());
				return forward_simulation(proj, i->else_body.get(), state);
			}

		} else if (auto r = instance_of(impl, Rely)) {
			auto c = z3_eval(proj, r->prop.get(), state);
			state->conds->push_back(c->get_z3_value());
			return forward_simulation(proj, r->body.get(), state);
		}
		throw std::runtime_error("[forward_simulation] Deterministic simulation path cannot be solved for spec body: " + string(*impl));
	}

	/**
	 * @brief Try to prove: (rel st st') => (rel spec(st) spec(st'))
	 * P
	 * @details	The simulation proof will admits all invariants, lemmas, and post conditions without checking. 
	 * 			It should be performed after checking all of things above.
	 * 
	 * 			Theoretically, the simulation property can also be formulated as pre-/post- conds:
	 * 
	 * 				P_relate(st, spec) : Prop := 
	 * 					forall st', (rel st st') /\ (forall st_1, Some st_1 = spec(st)) /\ (forall st'_1, Some st'_1 = spec(st')) => (rel st_1 st'_1)
	 * 
	 * 			However, letting z3 solve the quantifiers above are not efficient enough. 
	 * 			So we compute the witness st_1 and st'_1 by traversing the spec(st) and spec(st') respectively.
	 * 
	 * 			Following previous works (CAL, CCA, etc.), we perform downward (forward) simulations here. 
	 * 
	 * @param proj
	 * @param spec		The top-level specification (as small-step semantics of the system)
	 * @param impl		The implementation of the system
	 * @param rel		The relation definition, takes two RData type variable as arguments
	 * @param state		A state stack that stores z3 constriants
	 * 
	 * @return true if the specification relation is proved
	 * @return false if the specification relation is not proved
	 */
	bool simulate_by_traverse(Project *proj, SpecNode *spec, SpecNode *impl, SpecNode *rel, shared_ptr<ProveState> state) {
		if (auto expr = instance_of(spec, Expr)) {
			if (auto e_op = std::get_if<Expr::ops>(&expr->op)) {
				if (*e_op == Expr::Some) {
					if (auto ret_Some = instance_of(expr->elems->at(0).get(), Expr)) {
						auto st_ret = expr->elems->at(0)->deep_copy();
						// if the return value is := Some (ret_val, st), then take the last 'st'
						if (auto ret_op = std::get_if<Expr::ops>(&ret_Some->op)) {
							if (*ret_op == Expr::Tuple) {
								st_ret = ret_Some->elems->back()->deep_copy();
							}
						}
						auto [st_sim, impl_rest] = forward_simulation(proj, impl, state);
						auto [is_relate, expr_relate] = check_relation(proj, rel, st_ret.get(), st_sim.get(), state);
						return is_relate;
					}
				}
				
			}
		} else if (auto m = instance_of(spec, Match)) {
			set<string> used_fix;
			auto src = z3_eval(proj, m->src.get(), state, true, false, used_fix);
			if (auto expr = instance_of(m->src.get(), Expr)) {
				/** TODO: formulate the post-conds and add them */
			}

			auto abst_spec = abst_transition(proj, m->src.get()); 
			SpecNode *st_input = extract_st_from_expr(proj, m->src.get());
			for (auto pm = m->match_list->begin() ; pm != m->match_list->end(); pm++) {
				auto new_state = state->copy();
				auto pat = (*pm)->pattern.get();
				resolve_pattern(proj, m, pat, src, new_state);
				
				if (!std::holds_alternative<std::nullptr_t>(abst_spec)) {
					SpecNode *st_ret = extract_st_from_expr(proj, pat);
					if (st_input && st_ret) {
						for (auto const &l : proj->lemmas) {
							/** TODO: add instantiated lemmas */
						}
						for (auto const &inv : proj->verified_invariants) {
							/** TODO: add instantiated invariants */
						}
						// build constraint (st_ret ~ st_sim)
						auto [st_sim, impl_rest] = forward_simulation(proj, impl, new_state);
						auto [is_relate, expr_relate] = check_relation(proj, rel, st_ret, st_sim.get(), new_state);
						
						if (is_relate) {
							new_state->conds->push_back(expr_relate);
						} else {
							LOG_WARNING << "[simulate_by_traverse] Simulation relation can not be proved for states\n" << string(*st_ret) << " and " << string(*st_sim.get()) << std::endl;
						}
						return simulate_by_traverse(proj, (*pm)->body.get(), impl_rest, rel, new_state);
					}
				}
				// instantiate the rest of implementation
				if (!simulate_by_traverse(proj, (*pm)->body.get(), impl, rel, new_state)) {
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
			if (!simulate_by_traverse(proj, i->then_body.get(), impl, rel, true_state) || 
				!simulate_by_traverse(proj, i->else_body.get(), impl, rel, false_state)) {
				return false;
			}
		} else if (auto r = instance_of(spec, Rely)) {
			// push cond
			auto c = z3_eval(proj, r->prop.get(), state);
			state->conds->push_back(c->get_z3_value());
			return simulate_by_traverse(proj, r->body.get(), impl, rel, state);
		} else {
			// pass
		}
		return true;
	}

	/**
	 * @brief Check hyperproperties for relational systems
	 * 
	 * @param proj		The project
	 * @param def		The definition of the systems (specs)
	 * @param rel		The relation type
	 * @return true		If the relation is proved
	 * @return false	If the relation is not proved
	 */
	bool check_hprop_by_path(Project *proj, Definition *spec) {
		auto vars = std::make_shared<unordered_map<string, shared_ptr<SpecValue>>>();
		auto conds = std::make_shared<vector<z3::expr>>();
		for (auto arg : *spec->args) {
			(*vars)[arg->name] = arg->type->declare(arg->name, 0);
			(*vars)[get_sim_name(arg->name)] = arg->type->declare(get_sim_name(arg->name), 0);
		}
		auto induction = std::make_shared<vector<z3::expr>>();
		auto state = std::make_shared<ProveState>(vars, conds, induction);
		
		auto impl = proj->rules.build_simulate_spec(spec->body->deep_copy());

		bool proved = false;
		for (auto &r : proj->relations) {
			auto last_arg = spec->args->back();
			auto st_sym_1 = make_shared<Symbol>(last_arg->name, last_arg->type);
			auto st_sym_2 = make_shared<Symbol>(get_sim_name(last_arg->name), last_arg->type);

			if (!proj->is_state_type(last_arg->type)) {
				LOG_ERROR << "[check_hprop_by_path] The last argument of the spec should be a state type!";
			}

			auto rel_body = proj->defs[r]->body.get();
			auto [_, rel_expr] = check_relation(proj, rel_body->deep_copy().get(), st_sym_1.get(), st_sym_2.get(), state);
			state->conds->push_back(rel_expr);
			spec->body->clear_z3_eval();
			impl->clear_z3_eval();
			proved |= simulate_by_traverse(proj, spec->body.get(), impl.get(), rel_body, state);
		}
		return proved;
	}
}