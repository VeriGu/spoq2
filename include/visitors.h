#include <nodes.h>
#include <rules.h>
static const std::string match_body_sym = "NoneConditionAccumulatorTemporaryMatchBody";

namespace autov {
    class NoneConditionAccumulator {
        // An accumulated conjunction of conditions which may or may not lead to None.
        std::unique_ptr<SpecNode> accumulated_cond = nullptr;
        // When a match is added to the condition, subsequent conditions must be placed within the pattern match body.
        // This pointer is needed to know what node to replace.
        SpecNode* last_pattern_match = nullptr; 
        Project* proj = nullptr;
        std::string def_name = "";
        public:
        // The function to call when we encounter a None condition.
        // It will receive the accumulated conditions as an argument.
        // For example, if None always happens, it will receive True.
        std::optional<std::function<void(std::unique_ptr<SpecNode>)>> discharge_none = std::nullopt;

        void visit_none();
        const NoneConditionAccumulator add_condition(std::unique_ptr<SpecNode> cond);
        NoneConditionAccumulator add_inverse_condition(std::unique_ptr<SpecNode> cond);

        // Copy Constructor
        NoneConditionAccumulator(const NoneConditionAccumulator& other) {
            if (other.accumulated_cond) {
                this->accumulated_cond =  other.accumulated_cond->deep_copy();
            } else {
                this->accumulated_cond = nullptr;
            }
            this->discharge_none = other.discharge_none;
            this->last_pattern_match = nullptr; // Cannot copy the weak pointer.
            this->proj = other.proj;
            this->def_name = other.def_name;
        }
        // Move Constructor
        NoneConditionAccumulator(NoneConditionAccumulator&& other) noexcept {
            this->accumulated_cond = std::move(other.accumulated_cond);
            this->discharge_none = other.discharge_none;
            this->last_pattern_match = other.last_pattern_match;
            this->proj = other.proj;
            this->def_name = other.def_name;
        }
        NoneConditionAccumulator(Project* proj, std::string def_name) {
            this->accumulated_cond = make_unique<BoolConst>(true);
            this->proj = proj;
            this->def_name = def_name;
        };
        // Default Constructor
        NoneConditionAccumulator() {
            this->accumulated_cond = make_unique<BoolConst>(true);
        };

        // Conversion to bool:
        operator bool() const {
            return discharge_none.has_value();
        }
        
    };
}