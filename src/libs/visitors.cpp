#include <visitors.h>
#include <utils.h>


namespace autov {
    void NoneConditionAccumulator::visit_none() {
        if (discharge_none.has_value()) {
            (*discharge_none)(std::move(accumulated_cond));
        }
    }

    NoneConditionAccumulator NoneConditionAccumulator::add_condition(std::unique_ptr<SpecNode> cond) {
        if (accumulated_cond) {
            // if(string(*cond).find("(((st.(heap)).(blocks)) @ (spvn ((int_to_ptr byte).(pbase))))") != string::npos){

            //     LOG_DEBUG << "Adding condition ";
            //     LOG_DEBUG << "Condition: " <<string(*cond);
            //     LOG_DEBUG << "Current accumulated condition: " << string(*accumulated_cond);
            //     LOG_DEBUG << "...";
            //     int x = 5;
            // } else if(string(*cond).find("(Some byte) => true") != string::npos){
            //     LOG_DEBUG << "Adding condition ";
            //     LOG_DEBUG << "Condition: " <<string(*cond);
            //     LOG_DEBUG << "Current accumulated condition: " << string(*accumulated_cond);
            //     LOG_DEBUG << "...";
            //     int x = 5;
            // }
            auto node_to_replace = make_unique<Symbol>(match_body_sym);
            unique_ptr<SpecNode> temp_held_match_body = nullptr;
            if(last_pattern_match){
                if (auto lpm = dynamic_cast<PatternMatch*>(last_pattern_match)) {
                    temp_held_match_body = std::move(lpm->body);
                    lpm->body = move(node_to_replace);
                   
                } else if (auto and_node = dynamic_cast<Expr*>(last_pattern_match)) {
                    // Currently 2/17/26 an AND node is strictly a binary operation.
                    // Therefore, the new condition must either be added onto elem 1 or 0, we choose 1.
                    temp_held_match_body = std::move(and_node->elems->at(1));
                    and_node->elems->at(1) = std::move(node_to_replace);
                } else {
                    LOG_ERROR << "last_pattern_match's body is neither a PatternMatch nor an AND expression. This should never happen.";
                    assert(false);
                }
            }
            auto new_accumulator = NoneConditionAccumulator(*this);
            if(last_pattern_match){
                if (auto lpm = dynamic_cast<PatternMatch*>(last_pattern_match)) {
                    lpm->body = temp_held_match_body->deep_copy();
                } else if (auto and_node = dynamic_cast<Expr*>(last_pattern_match)) {
                    and_node->elems->at(1) = temp_held_match_body->deep_copy();
                }
            }

            // set last_pattern_match on the new_accumulator.
            // Needed if the new condition is a match.
            bool is_match = false;
            if(auto m = instance_of(cond.get(), Match)){
                is_match = true;
                auto true_const = make_unique<BoolConst>(true);
                for(auto &pm : *m->match_list){
                    if(pm->body.get()->deep_eq(true_const.get())){
                        new_accumulator.last_pattern_match = pm.get();
                        break;
                    }
                }
                if(!new_accumulator.last_pattern_match){
                    LOG_ERROR << "Failed to find pattern match with true body for condition: " << string(*cond);
                    assert(false);
                }

            }

            auto elems = make_unique<vector<unique_ptr<SpecNode>>>();
            elems->push_back(std::move(cond));
            if(last_pattern_match){
                elems->push_back(std::move(temp_held_match_body));
                auto new_predicate = make_unique<Expr>(Expr::AND, std::move(elems), Bool::BOOL);
                bool success = false;
                // LOG_DEBUG << "New Predicate to add to pattern match body: " << string(*new_predicate);
                // LOG_DEBUG << "Original new accumulator condition: " << string(*new_accumulator.accumulated_cond);
                new_accumulator.accumulated_cond = subst(move(new_accumulator.accumulated_cond), match_body_sym, new_predicate.get(), success, &new_accumulator.last_pattern_match);
                // LOG_DEBUG << "New accumulator condition after substitution: " << string(*new_accumulator.accumulated_cond);
                // LOG_DEBUG << "Adding condition with pattern match. New condition: " << string(*new_accumulator.accumulated_cond);
                // assert(string(*new_accumulator.accumulated_cond).find(match_body_sym) == string::npos);
                assert(success);
                assert(new_accumulator.last_pattern_match); // We can never stop adding to the inner conjunction.
            } else{
                elems->push_back(std::move(new_accumulator.accumulated_cond));
                new_accumulator.accumulated_cond = make_unique<Expr>(Expr::AND, std::move(elems), Bool::BOOL);
            }
            assert(!is_match || (new_accumulator.last_pattern_match != nullptr));
            return new_accumulator;
        } else {
            // If this is a null accumulator, just return another null accumulator
            return NoneConditionAccumulator();
        }
    }

    NoneConditionAccumulator NoneConditionAccumulator::add_inverse_condition(std::unique_ptr<SpecNode> cond) {
        return this->add_condition(make_unique<Expr>(Expr::NOT, std::move(cond), Bool::BOOL));
    }
}