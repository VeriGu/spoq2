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
					auto z3_ret = z3_check(state, c->get_z3_value(), 2000);

					std::cout << "----------------------------------" << std::endl;
					std::cout << "prove_by_traverse: Final State\n" << string(*ret_st) << std::endl;
					std::cout << "prove_by_traverse: Goal Query\n" << c->get_z3_value() << std::endl;
					std::cout << "----------------------------------" << std::endl;
					if (z3_ret == Z3Result::False) {
						LOG_WARNING << "[prove_by_traverse] Invariant is violated for state\n" << string(*ret_st) << std::endl;
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