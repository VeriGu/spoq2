#include <symbolic.h>
#include <simulate.h>
#include <coi.h>
#include <rules.h>

// TODO: Implement simulation-aux functions, maybe integrated into prove_by_traverse in future
namespace autov
{
	int Z3_SIM_TIMEOUT = 1000;

	shared_ptr<SpecValue> formulate_relation(Project *proj, Definition *rel, SpecNode *st_spec, SpecNode *st_impl, shared_ptr<ProveState> state) {
		vector<string> names;
		vector<unique_ptr<SpecNode>> elems;
		names.push_back(rel->args->at(0)->name);
		elems.push_back(st_spec->deep_copy());
		names.push_back(rel->args->at(1)->name);
		elems.push_back(st_impl->deep_copy());
		
		auto p = subst_v2(proj, rel->body->deep_copy(), &names, &elems);
		return z3_eval(proj, p.get(), state);
	}

	std::pair<bool, z3::expr> check_relation(Project *proj, Definition *rel, SpecNode *st_spec, SpecNode *st_impl, shared_ptr<ProveState> state) {
		auto rel_expr = formulate_relation(proj, rel, st_spec, st_impl, state);
		z3::model model(z3ctx);
		auto z3_ret = z3_check_unsat(state, rel_expr->get_z3_value(), model, &proj->query_saver, Z3_VERIFY_TIMEOUT);
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
	bool forward_simulation(Project *proj, SpecNode *st_check, SpecNode *impl, Definition *rel, shared_ptr<ProveState> state, 
																   bool det = false, const path_t &path = {}, int i = 0) {
		if (auto expr = instance_of(impl, Expr)) {
			if (auto e_op = std::get_if<Expr::ops>(&expr->op)) {
				if (*e_op == Expr::Some) {
					unique_ptr<SpecNode> st_ret;
					if (auto ret_Some = instance_of(expr->elems->at(0).get(), Expr)) {
						st_ret = expr->elems->at(0)->deep_copy();
						if (auto ret_op = std::get_if<Expr::ops>(&ret_Some->op)) {
							if (*ret_op == Expr::Tuple) {
								st_ret = ret_Some->elems->back()->deep_copy();
							}
						}
						
						auto [is_relate, expr_relate] = check_relation(proj, rel, st_check, st_ret.get(), state);
						if (is_relate) {
							LOG_INFO << "[forward_simulation] Relation is proved between\n"  << string(*st_check) << "\nand\n" << string(*st_ret.get()) << std::endl;
						} else {
							LOG_WARNING << "[forward_simulation] Relation can not be proved between\n"  << string(*st_check) << "\nand\n" << string(*st_ret.get())  << std::endl;
							for(auto cond: *state->conds) {
								LOG_DEBUG << "Condition: " << cond;
							}
						}
						return is_relate;
					} else if(auto ret_Some = instance_of(expr->elems->at(0).get(), Symbol)) {
						st_ret = expr->elems->at(0)->deep_copy();
						
						auto [is_relate, expr_relate] = check_relation(proj, rel, st_check, st_ret.get(), state);
						if (is_relate) {
							LOG_INFO << "[forward_simulation] Relation is proved between\n"  << string(*st_check) << "\nand\n" << string(*st_ret.get()) << std::endl;
						} else {
							LOG_WARNING << "[forward_simulation] Relation can not be proved between\n"  << string(*st_check) << "\nand\n" << string(*st_ret.get())  << std::endl;
							for(auto cond: *state->conds) {
								LOG_DEBUG << "Condition: " << cond;
							}
						}
						return is_relate;
					}
				}
			}
		} else if (auto m = instance_of(impl, Match)) {
			set<string> used_fix;
			bool add_post_condition = false;
			unique_ptr<SpecNode> post_cond;
			unique_ptr<SpecNode> loop_post_cond;
			auto src = z3_eval(proj, m->src.get(), state, true, false, used_fix);
			if (auto expr = instance_of(m->src.get(), Expr)) {
				/** TODO: add post-conds and loop-invs */
				if (holds_alternative<string>(expr->op)){
					auto op = std::get<string>(expr->op);
					auto info = proj->symbols[op];
					if (info.kind == SymbolKind::Def) {
						if (proj->defs.find(op) != proj->defs.end()) {
                            auto def = proj->defs[op].get();
							if (auto loop = instance_of(proj->defs[op].get(), Fixpoint)){
								if(proj->loop_invs.find(op) != proj->loop_invs.end()) {
									if (proj->cmds.PreCond.find(op) != proj->cmds.PreCond.end()) {
										if (!check_states_implies_pre_condition(proj, state, op, expr->elems.get())){
											LOG_INFO << "[Checking Loop Invariant] Precondition not Satified";
											return false;
										};
									}
									LOG_INFO << "[Checking Loop Invariant] Precondition Satisfied";
									auto fname = loop->name;
									loop_post_cond = formulate_loop_invariant(proj, fname, expr->elems.get());
									add_post_condition = true;
									LOG_DEBUG << "[Checking Loop Invariant] Adding loop postcondition: " << op;
								} else {
									LOG_WARNING << "Loop Invariant not specified: " << op;
								}
							} else {
								if (proj->cmds.PreCond.find(op) != proj->cmds.PreCond.end()) {
									if (!check_states_implies_pre_condition(proj, state, op, expr->elems.get())){
										LOG_INFO << "[Checking Loop Invariant] Precondition not Satified";
										return false;
									};
								}
								if(proj->cmds.PostCond.find(op) != proj->cmds.PostCond.end()) {
									auto fname = def->name;
									post_cond = formulate_post_condition(proj, fname, expr->elems.get());
									add_post_condition = true;
								}
							}
						}
					}
				}
			}
			auto abst_spec = abst_transition(proj, m->src.get()); 
			SpecNode *st_input = extract_st_from_expr(proj, m->src.get());

			bool is_relate = true;
			SpecNode *impl_rest = nullptr;

			int cnt = 0;
			for (auto pm = m->match_list->begin() ; pm != m->match_list->end(); pm++) {
				auto pm_state = state->copy();
				auto pat = (*pm)->pattern.get();
				
				if (add_post_condition) {
					auto expr = instance_of(m->src.get(), Expr);
					auto op = std::get<string>(expr->op);
					if (auto loop = instance_of(proj->defs[op].get(), Fixpoint)){
						if(auto p = instance_of(pat, Expr)) {
							if(op_eq(p->op, Expr::Some)) {
								if(instance_of(p->elems->at(0)->type.get(), Tuple)) {
									auto tuple = p->elems->at(0).get();
									if(auto t = instance_of(tuple, Expr)) {
										vector<string> names;
										vector<unique_ptr<SpecNode>> elems;
										for(int i = 0; i < t->elems->size(); i++) {
											auto elem = t->elems->at(i).get();
											if(auto sym = instance_of(elem, Symbol)) {
												names.push_back(loop->name + "_" + loop->args->at(i)->name + "_new");
												elems.push_back(sym->deep_copy());
												(*pm_state->vars)[sym->text] = sym->type->declare(sym->text, 0);
											}
										}
										auto new_inv = subst_v2(proj, move(loop_post_cond), &names, &elems);
										LOG_DEBUG << "[Checking Loop Invariant] Adding loop postcondition: " << string(*new_inv);
										auto new_inv_z3 = z3_eval(proj, new_inv.get(), pm_state, true, false, used_fix);
										pm_state->conds->push_back(new_inv_z3->get_z3_value());
									}
								} else if(p->elems->at(0)->type == proj->layers[0]->abs_data){
									if(auto sym = instance_of(p->elems->at(0).get(), Symbol)) {
										(*pm_state->vars)[sym->text] = sym->type->declare(sym->text, 0);
									}
									auto new_inv = subst_v2(proj, move(loop_post_cond), loop->name + "_" + "st_new", p->elems->at(0)->deep_copy());
									LOG_DEBUG << "[Checking Loop Invariant] Adding loop postcondition: " << string(*new_inv);
									auto new_inv_z3 = z3_eval(proj, new_inv.get(), pm_state, true, false, used_fix);
									pm_state->conds->push_back(new_inv_z3->get_z3_value());
								}
							}
						}
					} else {
						//normal definition
						auto def = instance_of(proj->defs[op].get(), Definition);
						if(auto p = instance_of(pat, Expr)) {
							if(op_eq(p->op, Expr::Some)) {
								if(instance_of(p->elems->at(0)->type.get(), Tuple)) {
									auto tuple = p->elems->at(0).get();
									if(auto t = instance_of(tuple, Expr)) {
										vector<string> names;
										vector<unique_ptr<SpecNode>> elems;
										for(int i = 0; i < t->elems->size(); i++) {
											auto elem = t->elems->at(i).get();
											if(auto sym = instance_of(elem, Symbol)) {
												if(i + 1 == t->elems->size()) {
													names.push_back(def->name + "_st_new_");
													elems.push_back(sym->deep_copy());
												} else {
													names.push_back(def->name + "_ret_" + std::to_string(i));
													elems.push_back(sym->deep_copy());
												}
												(*pm_state->vars)[sym->text] = sym->type->declare(sym->text, 0);
											}
										}
										auto new_inv = subst_v2(proj, move(post_cond), &names, &elems);
										LOG_DEBUG << "Adding postcondition: " << string(*new_inv);
										auto new_inv_z3 = z3_eval(proj, new_inv.get(), pm_state, true, false, used_fix);
										pm_state->conds->push_back(new_inv_z3->get_z3_value());
									}
								} else if(p->elems->at(0)->type == proj->layers[0]->abs_data) {
									if(auto sym = instance_of(p->elems->at(0).get(), Symbol)) {
										(*pm_state->vars)[sym->text] = sym->type->declare(sym->text, 0);
									}
									auto new_inv = subst_v2(proj, move(post_cond), def->name + "_st_new_", p->elems->at(0)->deep_copy());

									LOG_DEBUG << "Adding postcondition: " << string(*new_inv);
									auto new_inv_z3 = z3_eval(proj, new_inv.get(), pm_state, true, false, used_fix);
									pm_state->conds->push_back(new_inv_z3->get_z3_value());
								}
							}
						}
					}
				} else {
					resolve_pattern(proj, m, pat, src, pm_state);
				}

				if (!std::holds_alternative<std::nullptr_t>(abst_spec)) {
					SpecNode *st_ret = extract_st_from_expr(proj, pat);
					if (st_input && st_ret) {
						/** TODO: add lemmas and invariants here */
						/** TODO: check weak induction pre-condition: 
						 * 		st_input ~ st_sim_input
						 */
					}
				}

				// for non-abst func here (match-as-branch), check state validity here
				Z3Result res = Z3Result::Unknown;
				if (det && m->src->is_determ_branch) {
					res = (path[i] == cnt++) ? Z3Result::True : Z3Result::False;	
				} else {
					res = z3_verify_state_sat(pm_state, nullptr, Z3_SAT_TIMEOUT);
				}

				if (res == Z3Result::False) {
					continue;
				} else {
					is_relate &= forward_simulation(proj, st_check, (*pm)->body.get(), rel, pm_state, det, path, i+1);
				}
			}
			return is_relate;

		} else if (auto iff = instance_of(impl, If)) {
			auto cond = z3_eval(proj, iff->cond.get(), state);
			Z3Result res = Z3Result::Unknown;

			if (det && iff->cond->is_determ_branch) {
				res = (path[i] == 1) ? Z3Result::True : Z3Result::False;
			} else {
				z3::model model(z3ctx);
				auto t_race = OPTS.race_timeout;
				OPTS.race_timeout = Z3_SIM_TIMEOUT / 1000;
				// res = z3_check(state, cond->get_z3_value(), Z3_SIM_TIMEOUT);
				res = z3_check_unsat(state, cond->get_z3_value(), model, &proj->query_saver);
				OPTS.race_timeout = t_race;
			}
			if (res == Z3Result::True) {
				state->conds->push_back(cond->get_z3_value());
				return forward_simulation(proj, st_check, iff->then_body.get(), rel, state, det, path, i+1);
			} else if (res == Z3Result::False) {
				state->conds->push_back(!cond->get_z3_value());
				return forward_simulation(proj, st_check, iff->else_body.get(), rel, state, det, path, i+1);
			} else {
				// O(N^2) simulation search 
				if (!det || !iff->cond->is_determ_branch) { 
					LOG_DEBUG << "Unsolved (try) If non-determ cond!" << string(*iff->cond.get());
				}
				auto then_state = state->copy();
				auto else_state = state->copy();
				then_state->conds->push_back(cond->get_z3_value());
				else_state->conds->push_back(!cond->get_z3_value());
				auto is_relate_then = forward_simulation(proj, st_check, iff->then_body.get(), rel, then_state, false, path, i+1);
				auto is_relate_else = forward_simulation(proj, st_check, iff->else_body.get(), rel, else_state, false, path, i+1);
				return (is_relate_then && is_relate_else);
			}

		} else if (auto r = instance_of(impl, Rely)) {
			auto c = z3_eval(proj, r->prop.get(), state);
			state->conds->push_back(c->get_z3_value());
			return forward_simulation(proj, st_check, r->body.get(), rel, state, det, path, i);
		} else {
			/** NOTE: In general we only prove relation between non-halt values (Some _) */
			return true;
		}
		return true;
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
						return forward_simulation(proj, st_ret.get(), impl, rel, state, det, p, 0);
					} else if(auto ret_Some = instance_of(expr->elems->at(0).get(), Symbol)) {
					   auto st_ret = expr->elems->at(0)->deep_copy();
						return forward_simulation(proj, st_ret.get(), impl, rel, state, det, p, 0);
					}
				}
				
			}
		} else if (auto m = instance_of(spec, Match)) {
			set<string> used_fix;
			bool add_post_condition = false;
			unique_ptr<SpecNode> post_cond;
			unique_ptr<SpecNode> loop_post_cond;
			auto src = z3_eval(proj, m->src.get(), state, true, false, used_fix);
			if (auto expr = instance_of(m->src.get(), Expr)) {
				if (holds_alternative<string>(expr->op)){
					auto op = std::get<string>(expr->op);
					auto info = proj->symbols[op];
					if (info.kind == SymbolKind::Def) {
						vector<shared_ptr<SpecValue>> elems;
						for (auto e = expr->elems->begin(); e != expr->elems->end(); e++) {
							elems.push_back(z3_eval(proj, e->get(), state));
						}
						if (proj->defs.find(op) != proj->defs.end()) {
							auto def = proj->defs[op].get();
                            if (auto loop = instance_of(proj->defs[op].get(), Fixpoint)){
								if(proj->loop_invs.find(op) != proj->loop_invs.end()) {
									if (proj->cmds.PreCond.find(op) != proj->cmds.PreCond.end()) {
										if (!check_states_implies_pre_condition(proj, state, op, expr->elems.get())){
											LOG_INFO << "[Checking Loop Invariant] Precondition not Satified";
											return false;
										};
									}
									LOG_INFO << "[Checking Loop Invariant] Precondition Satisfied";
									auto fname = loop->name;
									loop_post_cond = formulate_loop_invariant(proj, fname, expr->elems.get());
									add_post_condition = true;
									LOG_DEBUG << "[Checking Loop Invariant] Adding loop postcondition: " << op;
								} else {
									LOG_WARNING << "Loop Invariant not specified: " << op;
								}
							} else {
								if (proj->cmds.PreCond.find(op) != proj->cmds.PreCond.end()) {
									if (!check_states_implies_pre_condition(proj, state, op, expr->elems.get())){
										LOG_INFO << "[Checking Loop Invariant] Precondition not Satified";
										return false;
									};
								}
								LOG_INFO << "[Checking Loop Invariant] Satisfied";
								if(proj->cmds.PostCond.find(op) != proj->cmds.PostCond.end()) {
									auto fname = def->name;
									post_cond = formulate_post_condition(proj, fname, expr->elems.get());
									add_post_condition = true;
								}
							}
						}
					}
				}
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

				if (add_post_condition) {
					auto expr = instance_of(m->src.get(), Expr);
					auto op = std::get<string>(expr->op);
					if (auto loop = instance_of(proj->defs[op].get(), Fixpoint)){
						if(auto p = instance_of(pat, Expr)) {
							if(op_eq(p->op, Expr::Some)) {
								if(instance_of(p->elems->at(0)->type.get(), Tuple)) {
									auto tuple = p->elems->at(0).get();
									if(auto t = instance_of(tuple, Expr)) {
										vector<string> names;
										vector<unique_ptr<SpecNode>> elems;
										for(int i = 0; i < t->elems->size(); i++) {
											auto elem = t->elems->at(i).get();
											if(auto sym = instance_of(elem, Symbol)) {
												names.push_back(loop->name + "_" + loop->args->at(i)->name + "_new");
												elems.push_back(sym->deep_copy());
												(*new_state->vars)[sym->text] = sym->type->declare(sym->text, 0);
											}
										}
										auto new_inv = subst_v2(proj, move(loop_post_cond), &names, &elems);
										LOG_DEBUG << "Adding loop postcondition: " << string(*new_inv);
										auto new_inv_z3 = z3_eval(proj, new_inv.get(), new_state, true, false, used_fix);
										new_state->conds->push_back(new_inv_z3->get_z3_value());
									}
								} else if(p->elems->at(0)->type == proj->layers[0]->abs_data){
									if(auto sym = instance_of(p->elems->at(0).get(), Symbol)) {
										(*new_state->vars)[sym->text] = sym->type->declare(sym->text, 0);
									}
									auto new_inv = subst_v2(proj, move(loop_post_cond), loop->name + "_" + "st_new", p->elems->at(0)->deep_copy());
									LOG_DEBUG << "Adding loop postcondition: " << string(*new_inv);
									auto new_inv_z3 = z3_eval(proj, new_inv.get(), new_state, true, false, used_fix);
									new_state->conds->push_back(new_inv_z3->get_z3_value());
								}
							}
						}
					} else {
						//normal definition
						auto def = instance_of(proj->defs[op].get(), Definition);
						if(auto p = instance_of(pat, Expr)) {
							if(op_eq(p->op, Expr::Some)) {
								if(instance_of(p->elems->at(0)->type.get(), Tuple)) {
									auto tuple = p->elems->at(0).get();
									if(auto t = instance_of(tuple, Expr)) {
										vector<string> names;
										vector<unique_ptr<SpecNode>> elems;
										for(int i = 0; i < t->elems->size(); i++) {
											auto elem = t->elems->at(i).get();
											if(auto sym = instance_of(elem, Symbol)) {
												if(i + 1 == t->elems->size()) {
													names.push_back(def->name + "_st_new_");
													elems.push_back(sym->deep_copy());
												} else {
													names.push_back(def->name + "_ret_" + std::to_string(i));
													elems.push_back(sym->deep_copy());
												}
												(*new_state->vars)[sym->text] = sym->type->declare(sym->text, 0);
											}
										}
										auto new_inv = subst_v2(proj, move(post_cond), &names, &elems);
										LOG_DEBUG << "Adding postcondition: " << string(*new_inv);
										auto new_inv_z3 = z3_eval(proj, new_inv.get(), new_state, true, false, used_fix);
										new_state->conds->push_back(new_inv_z3->get_z3_value());
									}
								} else if(p->elems->at(0)->type == proj->layers[0]->abs_data) {
									if(auto sym = instance_of(p->elems->at(0).get(), Symbol)) {
										(*new_state->vars)[sym->text] = sym->type->declare(sym->text, 0);
									}
									auto new_inv = subst_v2(proj, move(post_cond), def->name + "_st_new_", p->elems->at(0)->deep_copy());
									LOG_DEBUG << "Adding postcondition: " << string(*new_inv);
									auto new_inv_z3 = z3_eval(proj, new_inv.get(), new_state, true, false, used_fix);
									new_state->conds->push_back(new_inv_z3->get_z3_value());
								}
							}
						}
					}
				} else {
					resolve_pattern(proj, m, pat, src, new_state);
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
	bool check_hprop_by_path(Project *proj, Definition* rel, Definition *spec, Definition *impl, bool det, Definition* endrel) {
		auto vars = std::make_shared<unordered_map<string, shared_ptr<SpecValue>>>();
		auto conds = std::make_shared<vector<z3::expr>>();
		for (auto arg : *spec->args) {
			(*vars)[arg->name] = arg->type->declare(arg->name, 0);
		}
		(*vars)[get_sim_name("st")] = proj->layers[0]->abs_data->declare(get_sim_name("st"), 0);
		auto induction = std::make_shared<vector<z3::expr>>();
		auto state = std::make_shared<ProveState>(vars, conds, induction);
		
		SpecNode* impl_body = nullptr, *spec_body = nullptr;

		auto l_args = make_unique<vector<shared_ptr<Arg>>>();
		for (auto arg : *spec->args) {
			l_args->push_back(arg);
		}
		auto spec_def = new Definition(spec->name, spec->rettype, std::move(l_args), spec->body->deep_copy());
		coi_reduction(proj, spec_def, rel->body.get());

		spec_body = spec_def->body.get();
		if (!impl) {
			impl_body = proj->rules.build_simulate_spec(spec_body->deep_copy()).release();
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
		// add invariants for both
		set<string> used_fixpoint;
		for (auto proved : proj->verified_invariants) {
			auto inv_for_spec = proj->sys_invs[proved].get();
			auto inv_for_impl = proj->rules.build_simulate_spec(proj->sys_invs[proved]->deep_copy()).release();
			// std::cout << "[check_hprop_by_path] Proved invariant: " << string(*inv_for_spec) << std::endl;
			// std::cout << "[check_hprop_by_path] Simulated invariant: " << string(*inv_for_impl) << std::endl;
			auto e_spec = z3_eval(proj, inv_for_spec, state, false, true, used_fixpoint);
			auto e_impl = z3_eval(proj, inv_for_impl, state, false, true, used_fixpoint);
			state->conds->push_back(e_spec->get_z3_value());
			state->conds->push_back(e_impl->get_z3_value());
		}
		for (auto const &l : proj->lemmas) {
			auto lemma_body = proj->defs[l]->body.get();
			auto lemma_expr = z3_eval(proj, lemma_body, state, false, true, used_fixpoint);
			state->add_induction(lemma_expr->get_z3_value());
		}
		for (auto const &a : proj->axioms) {
			auto axiom_body = proj->defs[a]->body.get();
			auto axiom_expr = z3_eval(proj, axiom_body, state, false, true, used_fixpoint);
			state->conds->push_back(axiom_expr->get_z3_value());
		}

		// add weak-step consistency relations
		for (auto const &wsr : proj->weak_step_relations) {
			auto wsr_def = proj->defs[wsr].get();
			auto wsr_expr = formulate_relation(proj, wsr_def, st_sym_1.get(), st_sym_2.get(), state);
			state->conds->push_back(wsr_expr->get_z3_value());
		}
		spec_body->clear_z3_eval();
		impl_body->clear_z3_eval();
		path_t p = {};
		/** TODO: set check for deterministic simulation */
		Definition* end_rel = nullptr;
		if(!endrel) {
			end_rel = rel;
		} else {
			end_rel = endrel;
		}
		return simulate_by_traverse(proj, spec_body, impl_body, end_rel, state, p, det);
	}


}