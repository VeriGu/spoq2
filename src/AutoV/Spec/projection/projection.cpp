#include <rules.h>
#include <z3_rules.h>
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
        auto new_spec1 = new_spec;
        while (true) {
            auto this_changed = false;
            new_spec1 = new_spec;
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

#if 1
                if (__changed) {
                    std::cout << "new_spec" << ": \n=========================\n"
                        << string(*new_spec) << "\n==============================" << std::endl;
                }
#endif
            }

            if (!this_changed)
                break;
        }

        while (true) {
            auto [__spec, __unfolded] = rule_unfold_specs(proj, new_spec1);
            new_spec1 = __spec;
            break;
        }
        auto vars = std::make_shared<unordered_map<string, shared_ptr<SpecValue>>>();
        auto conds = std::make_shared<vector<z3::expr>>();
        for (auto arg : *def->args) {
            (*vars)[arg->name] = arg->type->declare(arg->name, 0);
            std::cout << "arg: " << arg->name << " " << arg->type->operator string() << std::endl;
        }
        auto [__spec, __changed] = rule_simple_by_z3(proj, new_spec1, make_shared<EvalState>(vars, conds));
        //this_changed |= __changed;
        changed |= __changed;

        new_spec = __spec;

        if (__changed)
            std::cout << "(Z3) new_spec: \n=========================\n"
                << string(*new_spec) << "\n==============================\n";


        def->body.reset(new_spec);
        def->_str = "";
        if (!changed)
            break;
    }
}

} // namespace autov