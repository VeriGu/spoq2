#include <symbolic.h>
#include <simulate.h>
#include <coi.h>
// TODO: Implement simulation-aux functions, maybe integrated into prove_by_traverse in future
namespace autov
{

	shared_ptr<SpecValue> formulate_relation(Project *proj, Definition *rel, SpecNode *st_spec, SpecNode *st_impl, shared_ptr<ProveState> state) {
		bool succ;
		auto p = subst(rel->body->deep_copy(), rel->args->at(0)->name, st_spec, succ);
		p = subst(std::move(p), rel->args->at(1)->name, st_impl, succ);
		return z3_eval(proj, p.get(), state);
	}

	std::pair<bool, z3::expr> check_relation(Project *proj, Definition *rel, SpecNode *st_spec, SpecNode *st_impl, shared_ptr<ProveState> state) {
		auto rel_expr = formulate_relation(proj, rel, st_spec, st_impl, state);
		z3::model model(z3ctx);
		auto z3_ret = z3_check_unsat(state, rel_expr->get_z3_value(), model, &proj->query_saver, Z3_SIMULATE_TIMEOUT);
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
	 * @return [result, its following spec body] 
	 * 		   We assume that abstract function will not occur in multiple branches. otherwise the return value should be std::pair<bool, std::set<SpecNode *>>
	 */
	std::pair<bool, SpecNode *> forward_simulation(Project *proj, SpecNode *st_check, SpecNode *impl, Definition *rel, shared_ptr<ProveState> state, 
																   bool det = false, const path_t &path = {}, int i = 0) {
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
						// double check here
						auto [is_relate, expr_relate] = check_relation(proj, rel, st_check, st_ret.get(), state);
						if (is_relate) {
							LOG_INFO << "[forward_simulation] Relation is proved between\n"  << string(*st_check) << "\nand\n" << string(*st_ret.get()) << std::endl;
						} else {
							LOG_WARNING << "[forward_simulation] Relation can not be proved between\n"  << string(*st_check) << "\nand\n" << string(*st_ret.get())  << std::endl;
						}
						return std::make_pair(is_relate, nullptr);
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

			bool is_relate = true;
			SpecNode *impl_rest = nullptr;

			int cnt = 0;
			for (auto pm = m->match_list->begin() ; pm != m->match_list->end(); pm++) {
				auto pm_state = state->copy();
				auto pat = (*pm)->pattern.get();
				resolve_pattern(proj, m, pat, src, pm_state);
				if (!std::holds_alternative<std::nullptr_t>(abst_spec)) {
					SpecNode *st_ret = extract_st_from_expr(proj, pat);
					if (st_input && st_ret) {
						/** TODO: add lemmas and invariants here */
						/** TODO: check weak induction pre-condition: 
						 * 		st_input ~ st_sim_input
						 */
						// check pre-condition here
						// add inductive assumption
						auto expr_relate = formulate_relation(proj, rel, st_check, st_ret, pm_state);
						pm_state->conds->push_back(expr_relate->get_z3_value());
						*state = *pm_state;
						return std::make_pair(true, (*pm)->body.get());
					}
				}

				// for non-abst func here (match-as-branch), check state validity here
				Z3Result res = Z3Result::Unknown;
				if (det) {
					res = (path[i] == cnt++) ? Z3Result::True : Z3Result::False;	
				} else {
					res = z3_verify_state_sat(pm_state, nullptr, Z3_SIMULATE_TIMEOUT);
				}

				if (res == Z3Result::False) {
					continue;
				} else {
					auto [is_relate_match, match_body] = forward_simulation(proj, st_check, (*pm)->body.get(), rel, pm_state, det, path, i+1);
					is_relate &= is_relate_match;
					
					if (impl_rest) {
						throw std::runtime_error("[forward_simulation] Multiple abstract function found in: " + string(*impl));
					} 
					impl_rest = match_body;
					*state = *pm_state;
				}
			}
			return std::make_pair(is_relate, impl_rest);

		} else if (auto iff = instance_of(impl, If)) {
			auto cond = z3_eval(proj, iff->cond.get(), state);
			Z3Result res = Z3Result::Unknown;
			if (det) {
				res = (path[i] == 1) ? Z3Result::True : Z3Result::False;
			} else {
				res = z3_check(state, cond->get_z3_value(), Z3_SIMULATE_TIMEOUT);
			}
			if (res == Z3Result::True) {
				state->conds->push_back(cond->get_z3_value());
				return forward_simulation(proj, st_check, iff->then_body.get(), rel, state, det, path, i+1);
			} else if (res == Z3Result::False) {
				state->conds->push_back(!cond->get_z3_value());
				return forward_simulation(proj, st_check, iff->else_body.get(), rel, state, det, path, i+1);
			} else {
				// O(N^2) simulation search 
				auto then_state = state->copy();
				auto else_state = state->copy();
				then_state->conds->push_back(cond->get_z3_value());
				else_state->conds->push_back(!cond->get_z3_value());
				auto [is_relate_then, rest_then] = forward_simulation(proj, st_check, iff->then_body.get(), rel, then_state, det, path, i+1);
				auto [is_relate_else, rest_else] = forward_simulation(proj, st_check, iff->else_body.get(), rel, else_state, det, path, i+1);
				
				// we should also copy the states and inductive conditions that added in recursive forward_simulation
				if (rest_then && rest_else) {
					throw std::runtime_error("[forward_simulation] Multiple abstract function found in:  " + string(*impl));
				} else if (rest_then) {
					*state = *then_state;
				} else if (rest_else) {
					*state = *else_state;
				}
				return std::make_pair((is_relate_then && is_relate_else), (rest_then ? rest_then : rest_else));
			}

		} else if (auto r = instance_of(impl, Rely)) {
			auto c = z3_eval(proj, r->prop.get(), state);
			state->conds->push_back(c->get_z3_value());
			return forward_simulation(proj, st_check, r->body.get(), rel, state, det, path, i);
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
	 * @param p			The path of current traverse
	 * @param det		Whether the simulation is deterministic (i.e. st st' takes same branch)
	 * 
	 * @return true if the specification relation is proved
	 * @return false if the specification relation is not proved
	 */
	bool simulate_by_traverse(Project *proj, SpecNode *spec, SpecNode *impl, Definition *rel, shared_ptr<ProveState> state, path_t p, bool det) {
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
						auto [is_relate, _] = forward_simulation(proj, st_ret.get(), impl, rel, state, det, p, 0);
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

			int cnt = 0;
			auto success = true;
			for (auto pm = m->match_list->begin() ; pm != m->match_list->end(); pm++) {
				path_t p_match = p;
				p_match.push_back(cnt++);

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
						path_t p_rest = {};
						auto [_, impl_rest] = forward_simulation(proj, st_ret, impl, rel, new_state, det, p_match, 0);
						return simulate_by_traverse(proj, (*pm)->body.get(), impl_rest, rel, new_state, p_rest, det);
					}
				}
				success &= simulate_by_traverse(proj, (*pm)->body.get(), impl, rel, new_state, p_match, det);
			}
			return success;
		} else if (auto i = instance_of(spec, If)) {
			// push cond
			auto c = z3_eval(proj, i->cond.get(), state);
			auto true_state = state->copy();
			auto false_state = state->copy();
			true_state->conds->push_back(c->get_z3_value());
			false_state->conds->push_back(!c->get_z3_value());
			path_t p_then = p, p_else = p;
			p_then.push_back(1);
			p_else.push_back(0);
			auto success = true;
			success &= simulate_by_traverse(proj, i->then_body.get(), impl, rel, true_state, p_then, det);
			success &= simulate_by_traverse(proj, i->else_body.get(), impl, rel, false_state, p_else, det);
			return success;
		} else if (auto r = instance_of(spec, Rely)) {
			// push cond
			auto c = z3_eval(proj, r->prop.get(), state);
			state->conds->push_back(c->get_z3_value());
			return simulate_by_traverse(proj, r->body.get(), impl, rel, state, p, det);
		} else {
			// pass
		}
		return true;
	}

	/**
	 * @brief Check relational property
	 * 
	 * @param proj		The project
	 * @param rel		The simulation relation
	 * @param spec		The first trace
	 * @param impl		The second trace
	 * @return true		If the relation is proved
	 * @return false	If the relation is not proved
	 */
	bool check_hprop_by_path(Project *proj, Definition* rel, Definition *spec, Definition *impl) {
		auto vars = std::make_shared<unordered_map<string, shared_ptr<SpecValue>>>();
		auto conds = std::make_shared<vector<z3::expr>>();
		for (auto arg : *spec->args) {
			(*vars)[arg->name] = arg->type->declare(arg->name, 0);
			(*vars)[get_sim_name(arg->name)] = arg->type->declare(get_sim_name(arg->name), 0);
		}
		auto induction = std::make_shared<vector<z3::expr>>();
		auto state = std::make_shared<ProveState>(vars, conds, induction);
		
		SpecNode* impl_body = nullptr, *spec_body = nullptr;

		spec_body = spec->body.get();
		if (!impl) {
			impl_body = proj->rules.build_simulate_spec(spec->body->deep_copy()).release();
		} else {
			impl_body = impl->body.get();
		}

		auto last_arg = spec->args->back();
		auto st_sym_1 = make_shared<Symbol>(last_arg->name, last_arg->type);
		auto st_sym_2 = make_shared<Symbol>(get_sim_name(last_arg->name), last_arg->type);
		if (!proj->is_state_type(last_arg->type)) {
			LOG_ERROR << "[check_hprop_by_path] The last argument of the spec should be a state type!";
		}
		auto rel_expr = formulate_relation(proj, rel, st_sym_1.get(), st_sym_2.get(), state);
		state->conds->push_back(rel_expr->get_z3_value());
		spec_body->clear_z3_eval();
		impl_body->clear_z3_eval();
		path_t p = {};
		bool det = false;
		// bool det = true;
		/** TODO: set check for deterministic simulation */
		return simulate_by_traverse(proj, spec_body, impl_body, rel, state, p, det);
	}
}