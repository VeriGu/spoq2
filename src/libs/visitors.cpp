#include <project.h>
#include <visitors.h>
#include <utils.h>

namespace autov {
    void NoneConditionAccumulator::visit_none() {
        if (discharge_none.has_value()) {
            (*discharge_none)(std::move(accumulated_cond));
        }
    }

    const NoneConditionAccumulator NoneConditionAccumulator::add_condition(std::unique_ptr<SpecNode> cond) {
        if (accumulated_cond) {
            // if(string(*cond).find("when") != string::npos){
                // LOG_DEBUG << "Adding condition ";
                // LOG_DEBUG << "Condition: " <<string(*cond);
                // LOG_DEBUG << "Current accumulated condition: " << string(*accumulated_cond);
                // LOG_DEBUG << "...";
            // }
            
            auto current_free_vars = std::set<string>();
            free_vars(proj, accumulated_cond.get(), current_free_vars);

            // auto node_to_replace = make_unique<Symbol>(match_body_sym);
            unique_ptr<SpecNode> temp_held_match_body = make_unique<Symbol>(match_body_sym);
            if(last_pattern_match){
                if (auto lpm = dynamic_cast<PatternMatch*>(last_pattern_match)) {
                    lpm->body.swap(temp_held_match_body);
                    //  LOG_DEBUG << "last_pattern_match is a PatternMatch, adding condition to the pattern match body.";
                } else if (auto if_node = dynamic_cast<If*>(last_pattern_match)) {
                    // The if node is something like if (last_cond) then (previous_cond) else false
                    if_node->then_body.swap(temp_held_match_body);
                } else if (auto and_node = dynamic_cast<Expr*>(last_pattern_match)) {
                    // Currently 2/17/26 an AND node is strictly a binary operation.
                    // Therefore, the new condition must either be added onto elem 1 or 0, we choose 1.
                    // LOG_DEBUG << "last_pattern_match is an AND node, adding condition to the second element of the conjunction.";
                    and_node->elems->at(1).swap(temp_held_match_body);
                } else {
                    LOG_ERROR << "last_pattern_match's body is neither a PatternMatch nor an AND nor an If expression. This should never happen.";
                    assert(false);
                }
                // LOG_DEBUG << "Current Condition after LPM swap: " << string(*accumulated_cond);
                // Now, a child of last_pattern_match is the match_body_sym symbol,
                // and temp_held_match_body holds the original body of last_pattern_match.
            }
            auto new_accumulator = NoneConditionAccumulator(*this);
            // new_accumulator has copied the current state of the condition,
            // this includes the symbol of which has replaced the body of last_pattern_match.
            if(last_pattern_match){
                // last_pattern_match is a pointer into this.accumulated_cond.
                if (auto lpm = dynamic_cast<PatternMatch*>(last_pattern_match)) {
                    lpm->body = temp_held_match_body->deep_copy();
                    // lpm->body = move(temp_held_match_body);
                } else if (auto and_node = dynamic_cast<Expr*>(last_pattern_match)) {
                    and_node->elems->at(1) = temp_held_match_body->deep_copy();
                    // and_node->elems->at(1) = move(temp_held_match_body);
                } else if (auto if_node = dynamic_cast<If*>(last_pattern_match)) {
                    if_node->then_body = temp_held_match_body->deep_copy();
                } else {
                    LOG_ERROR << "last_pattern_match's body is neither a PatternMatch nor an AND nor an If expression. This should never happen.";
                    assert(false);
                }
            }
            // LOG_DEBUG << "LPM swap back: " << string(*accumulated_cond);
            // LOG_DEBUG << "temp held body: " << string(*temp_held_match_body);

            // set last_pattern_match on the new_accumulator.
            // Needed if the new condition is a match.
            bool is_match = false;
            if(auto m = instance_of(cond.get(), Match)){
                is_match = true;
            }

            auto elems = make_unique<vector<unique_ptr<SpecNode>>>();
            elems->push_back(std::move(cond));
            if(last_pattern_match){
                elems->push_back(std::move(temp_held_match_body));
                auto new_predicate = make_unique<Expr>(Expr::AND, std::move(elems), Bool::BOOL);
                // Using an If instead of an AND makes it easier to have a program that we can split into smaller z3 queries later.
                // auto new_predicate = make_unique<If>(std::move(cond), std::move(temp_held_match_body), make_unique<BoolConst>(false));
                bool success = false;
                // LOG_DEBUG << "New Predicate to add to pattern match body: " << string(*new_predicate);
                // LOG_DEBUG << "Original new accumulator condition: " << string(*new_accumulator.accumulated_cond);
                // If the new condition is not a match, we want the new last_pattern_match value to be the location of the substitution.
                // If it is a match, we want the new last_pattern_match to point inside the new match,
                // So we have to search the new match after substitution.
                new_accumulator.accumulated_cond = subst(move(new_accumulator.accumulated_cond), match_body_sym, new_predicate.get(), success, &new_accumulator.last_pattern_match);
                // LOG_DEBUG << "New accumulator condition after substitution: " << string(*new_accumulator.accumulated_cond);
                // LOG_DEBUG << "Adding condition with pattern match. New condition: " << string(*new_accumulator.accumulated_cond);
                // assert(string(*new_accumulator.accumulated_cond).find(match_body_sym) == string::npos);
                assert(success);
                assert(new_accumulator.last_pattern_match); // We can never stop adding to the inner conjunction.
                // LOG_DEBUG << "New last_pattern_match: " << string(*new_accumulator.last_pattern_match);
            } else{
                elems->push_back(std::move(new_accumulator.accumulated_cond));
                new_accumulator.accumulated_cond = make_unique<Expr>(Expr::AND, std::move(elems), Bool::BOOL);
                // new_accumulator.accumulated_cond = make_unique<If>(std::move(cond), std::move(new_accumulator.accumulated_cond), make_unique<BoolConst>(false));
                new_accumulator.last_pattern_match = new_accumulator.accumulated_cond.get();
            }

            if(is_match && new_accumulator.last_pattern_match){
                if(auto and_node = dynamic_cast<Expr*>(new_accumulator.last_pattern_match)){
                    auto m = dynamic_cast<Match*>(and_node->elems->at(0).get());
                    assert(m);
                    new_accumulator.last_pattern_match = nullptr;
                    auto true_const = make_unique<BoolConst>(true);
                    for(auto &pm : *m->match_list){
                        if(pm->body.get()->deep_eq(true_const.get())){
                            new_accumulator.last_pattern_match = pm.get();
                            break; 
                        }
                    }
                } else if(auto if_node = dynamic_cast<If*>(new_accumulator.last_pattern_match)){
                    auto m = dynamic_cast<Match*>(if_node->cond.get());
                    new_accumulator.last_pattern_match = nullptr;
                    auto true_const = make_unique<BoolConst>(true);
                    for(auto &pm : *m->match_list){
                        if(pm->body.get()->deep_eq(true_const.get())){
                            new_accumulator.last_pattern_match = pm.get();
                            break;
                        }
                    }
                }
                if(!new_accumulator.last_pattern_match){
                    LOG_ERROR << "Failed to find pattern match with true body for condition: " << string(*cond);
                    assert(false);
                }
            }

            assert(!is_match || (new_accumulator.last_pattern_match != nullptr));
            assert(!is_match || dynamic_cast<PatternMatch*>(new_accumulator.last_pattern_match));
            
            // LOG_DEBUG << "New condition added: " << string(*new_accumulator.accumulated_cond);
            auto updated_free_vars = std::set<string>();
            free_vars(proj, new_accumulator.accumulated_cond.get(), updated_free_vars);
            auto temp_free_vars = std::set<string>();
            std::set_difference(updated_free_vars.begin(), updated_free_vars.end(), current_free_vars.begin(), current_free_vars.end(), inserter(temp_free_vars, temp_free_vars.begin()));
            auto arg_set = std::set<string>();
            for (auto &arg : *(proj->defs[new_accumulator.def_name]->args)){
                arg_set.insert(arg->name);
            }
            auto new_free_vars = std::set<string>();
            std::set_difference(temp_free_vars.begin(), temp_free_vars.end(), arg_set.begin(), arg_set.end(), inserter(new_free_vars, new_free_vars.begin()));
            assert(new_free_vars.empty());
            
            
            return new_accumulator;
        } else {
            // If this is a null accumulator, just return another null accumulator
            return NoneConditionAccumulator(*this);
        }
    }

    NoneConditionAccumulator NoneConditionAccumulator::add_inverse_condition(std::unique_ptr<SpecNode> cond) {
        return this->add_condition(make_unique<Expr>(Expr::NOT, std::move(cond), Bool::BOOL));
    }
}