#include <visitors.h>

namespace autov {
    void NoneConditionAccumulator::visit_none() {
        if (discharge_none.has_value()) {
            (*discharge_none)(std::move(accumulated_cond));
        }
    }

    NoneConditionAccumulator NoneConditionAccumulator::add_condition(std::unique_ptr<SpecNode> cond) {
        if (accumulated_cond) {
            auto new_accumulator = NoneConditionAccumulator(*this);
            auto elems = make_unique<vector<unique_ptr<SpecNode>>>();
            elems->push_back(std::move(new_accumulator.accumulated_cond));
            elems->push_back(std::move(cond));
            new_accumulator.accumulated_cond = make_unique<Expr>(Expr::AND, std::move(elems), Bool::BOOL);
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