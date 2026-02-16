#include <nodes.h>

namespace autov {
    class NoneConditionAccumulator {
        // An accumulated conjunction of conditions which may or may not lead to None.
        std::unique_ptr<SpecNode> accumulated_cond = nullptr;
        public:
        // The function to call when we encounter a None condition.
        // It will receive the accumulated conditions as an argument.
        // For example, if None always happens, it will receive True.
        std::optional<std::function<void(std::unique_ptr<SpecNode>)>> discharge_none = std::nullopt;

        void visit_none();
        NoneConditionAccumulator add_condition(std::unique_ptr<SpecNode> cond);
        NoneConditionAccumulator add_inverse_condition(std::unique_ptr<SpecNode> cond);

        // Copy Constructor
        NoneConditionAccumulator(const NoneConditionAccumulator& other) {
            this->accumulated_cond = other.accumulated_cond ? other.accumulated_cond->deep_copy() : nullptr;
            this->discharge_none = other.discharge_none;
        }
        // Move Constructor
        NoneConditionAccumulator(NoneConditionAccumulator&& other) noexcept {
            this->accumulated_cond = std::move(other.accumulated_cond);
            this->discharge_none = other.discharge_none;
        }
        // Default Constructor
        NoneConditionAccumulator() = default;

        // Conversion to bool:
        operator bool() const {
            return discharge_none.has_value();
        }
        
    };
}