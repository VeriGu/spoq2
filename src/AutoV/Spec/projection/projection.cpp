#include <rules.h>
#include <projection.h>

namespace autov {

static vector<rule_ret_t(*)(Project *, SpecNode *)> rules_group1 = {
    rule_eliminiate_indifferent,
    rule_eliminate_let,
    rule_eliminate_when,
    rule_eliminate_if,
    rule_eliminate_match_simple,
    rule_subst_match_src_with_content,
    rule_simple_builtin_functions,
    rule_move_rely_out_when,
    rule_move_when_out_when,
    rule_move_if_out_match,
    rule_move_if_out_expr,
    //rule_unfold_specs,
    rule_move_match_out_expr,
};

void spec_transformer(Project *proj, Definition *def) {
    LOG_INFO << "Transforming " << def->name;
    auto known = std::set<string>();

    for (auto arg : *def->args) {
        known.insert(arg->name);
    }

    while(true) {
        auto new_spec = def->body.release();

        auto changed = false;
        while (true) {
            auto this_changed = false;
            auto new_spec1 = new_spec;
            for (auto rule : rules_group1) {
                if (rule == rule_eliminate_let) {
                    auto prev_symbols = std::set<string>(known);
                    new_spec1 = eliminiate_ambiguity(proj, new_spec1, prev_symbols);
                }

                auto [__spec, __changed] = rule(proj, new_spec1);
                new_spec1 = __spec;
                this_changed |= __changed;
                changed |= __changed;

                new_spec = new_spec1;

#if 0
                if (__changed)
                    std::cout << "new_spec: " << string(*new_spec) << "\n";
#endif
            }

            if (!this_changed)
                break;
        }

        def->body.reset(new_spec);
        if (!changed)
            break;
    }
}

} // namespace autov