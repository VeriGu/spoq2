#include <nodes.h>
#include <values.h>
#include <utils.h>
#include <shortcuts.h>
#include <project.h>
#include <cassert>
#include <utility>
#include <rules.h>
#include <z3_rules.h>

namespace autov
{

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

// string get_state_str(Project *proj, Definition *def) {
// 	for (auto arg : *def->args) {
// 		if (arg->type == proj->layers[0]->abs_data) {
// 			return arg->name;
// 		}
// 	}
// 	// default value
// 	return "st";
// }

/** TODO: 
 * 		FIXME: clean state for duplicated vars / overwrite vars instead of emplace()
 * */
void prove_by_traverse(Project *proj, SpecNode *spec, SpecNode *inv, shared_ptr<EvalState> state) {
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
					auto c = z3_eval(proj, p, state);
					z3::model model(z3ctx);
					auto z3_ret = z3_check_unsat(state, c->get_z3_value(), model, 2000);

					std::cout << "----------------------------------" << std::endl;
					std::cout << "prove_by_traverse: Final State\n" << string(*ret_st) << std::endl;
					std::cout << "prove_by_traverse: Goal Query\n" << c->get_z3_value() << std::endl;
					std::cout << "----------------------------------" << std::endl;
					if (z3_ret == Z3Result::Sat) {
						LOG_WARNING << "[prove_by_traverse] Invariant is not satisfied for state\n" << string(*ret_st) << std::endl;
						LOG_WARNING << model;
					} else if (z3_ret == Z3Result::Unknown) {
						LOG_WARNING << "[prove_by_traverse] Invariant is unknown for state\n" << string(*ret_st) << std::endl;
					} else {
						LOG_INFO << "[prove_by_traverse] Invariant is proved for state\n" << string(*ret_st) << std::endl;
					}
                }
            }
        }
    } else if (auto m = instance_of(spec, Match)) {
        auto src = z3_eval(proj, m->src.get(), state);
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
					auto& invs = proj->loop_invs[loop->name];
                    //auto preconds = proj->cmds.InitRely[df->name];
                    auto var = std::make_shared<unordered_map<string, shared_ptr<SpecValue>>>();
                    auto conds = std::make_shared<vector<z3::expr>>();
                    //declare loop arguments
                    for (auto arg : *loop->args) {
                        if (arg->name != "_N_") {
                                (*var)[loop->name + "_" + arg->name] = arg->type->declare(loop->name + "_" + arg->name, 0); //current
                        }
                        if(arg->name == "st") {
                                (*var)[loop->name + "_" + arg->name + "_old"] = arg->type->declare(loop->name + "_" + arg->name + "_old", 0); 
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

                    SpecNode *before_inv = aggreinv;
                    //subst invariant inv[ret_x[0]/a' ret_x[1]/b' ret_x[2]/c' ret_x[3]/d']
                    for(auto arg : *loop->args) {
                            // if (arg->name != "_N_") {
                        auto sym = new Symbol(loop->name + "_" + arg->name, arg->type);
                        bool succ;
                        before_inv = subst(before_inv->deep_copy().release(), arg->name, sym, succ);
                        delete sym;
                            // }
                    }
					auto sym = new Symbol(loop->name + "_" + "st_old", loop->args->back()->type);
					bool succ;
					before_inv = subst(before_inv->deep_copy().release(), "st_old", sym, succ);
					delete sym;
                    auto vc = z3ctx.bool_val(true);
                    auto invval = z3_eval(proj, before_inv, make_shared<EvalState>(var, conds));
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
					LOG_INFO << "[Checking Loop Invariant] eq formula" << vc;
					LOG_INFO << "[Checking Loop Invariant] invariant" << invval->get_z3_value();
                    auto res = z3_check(state, z3::implies(vc, invval->get_z3_value()),500);
                    if(res == Z3Result::False || res == Z3Result::Unknown || res == Z3Result::Sat) {
                        LOG_ERROR << "Precondition can't infer loop invariant";
                        
                    }
                    LOG_INFO << "[Checking Loop Invariant] Precondition implies invariant";
                    //add loop post condition
                   
                    auto fname = loop->name;
                    auto loop_post_cond = formulate_loop_invariant(proj, fname, expr->elems.get());
					for (auto arg : *loop->args) {
                        if (arg->name != "_N_") {
                                (*state->vars)[loop->name + "_" + arg->name + "'"] = arg->type->declare(loop->name + "_" + arg->name + "'", 0); //current
                        }
                    }
					LOG_DEBUG << "[Checking Loop Invariant] Adding loop postcondition: " << string(*loop_post_cond);
                    auto loop_post_val = z3_eval(proj, loop_post_cond, state);
                    state->conds->push_back(loop_post_val->get_z3_value());
				}
			}
			}
			}
		}
		std::cout << "Match src: " << string(*m->src.get()) << std::endl;
		std::cout << "Match src: (val)" << src->get_z3_value() << std::endl;
		for (auto pm = m->match_list->begin() ; pm != m->match_list->end(); pm++) {
			auto new_state = state->copy();
			resolve_pattern(proj, m, (*pm)->pattern.get(), src, new_state);
			prove_by_traverse(proj, (*pm)->body.get(), inv, new_state);
		}
    } else if (auto i = instance_of(spec, If)) {
		// push cond
		auto c = z3_eval(proj, i->cond.get(), state);
		auto true_state = state->copy();
		auto false_state = state->copy();
		true_state->conds->push_back(c->get_z3_value());
		false_state->conds->push_back(!c->get_z3_value());
        prove_by_traverse(proj, i->then_body.get(), inv, true_state);
        prove_by_traverse(proj, i->else_body.get(), inv, false_state);
    } else if (auto r = instance_of(spec, Rely)) {
		// push cond
		auto c = z3_eval(proj, r->prop.get(), state);
		state->conds->push_back(c->get_z3_value());
        prove_by_traverse(proj, r->body.get(), inv, state);
    } else {
		// pass
	}
}
/** check_inv_by_path: 
 * 1. Push initial invariant 
 * 2. Traverse the spec, push control point constriants
 * 3. Arrive return point, push return value constraints, check
 * */ 
void check_inv_by_path(Project *proj, Definition *def, SpecNode *inv) {
	auto vars = std::make_shared<unordered_map<string, shared_ptr<SpecValue>>>();
	auto conds = std::make_shared<vector<z3::expr>>();
	for (auto arg : *def->args) {
		(*vars)[arg->name] = arg->type->declare(arg->name, 0);
	}
	auto state = std::make_shared<EvalState>(vars, conds);

	auto c = z3_eval(proj, inv, state);
	state->conds->push_back(c->get_z3_value());
	std::cout << "inv body: " << string(*inv) << std::endl;
	std::cout << "inv value: " << c->get_z3_value() << std::endl;
		
	/** TODO: substitute spec_transformer with a spec_walker that detects proved specs that no need for unfolding */
	prove_by_traverse(proj, def->body.get(), inv, state);
}

}