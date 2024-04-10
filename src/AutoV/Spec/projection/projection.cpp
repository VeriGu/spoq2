#include <rules.h>
#include <z3_rules.h>
#include <projection.h>

namespace autov {

unsigned long mono_lens_id = 0;

static vector<rule_ret_t(*)(Project *, SpecNode *)> rules_group1 = {
    //rule_eliminiate_indifferent,
    rule_eliminate_let,
    rule_eliminate_when,
    rule_eliminate_if,
    rule_eliminate_match_simple,
    rule_subst_match_src_with_content,
    rule_simple_builtin_functions,
    rule_simple_record_get_set,
    rule_move_rely_out_when,
    rule_move_when_out_when,
    rule_move_if_out_match,
    rule_move_if_out_expr,
    //rule_unfold_specs,
    rule_move_match_out_expr,
};

static vector<rule_ret_t(*)(Project *, SpecNode *)> rules_group2 = {
    //rule_eliminiate_indifferent,
    rule_eliminate_let,
    rule_eliminate_match_simple,
    rule_move_if_out_expr,
    rule_simple_record_get_set,
};

static unordered_map<rule_ret_t(*)(Project *, SpecNode *), string> rule_names = {
    {rule_eliminate_let, "rule_eliminate_let"},
    {rule_eliminate_when, "rule_eliminate_when"},
    {rule_eliminate_if, "rule_eliminate_if"},
    {rule_eliminate_match_simple, "rule_eliminate_match_simple"},
    {rule_subst_match_src_with_content, "rule_subst_match_src_with_content"},
    {rule_simple_builtin_functions, "rule_simple_builtin_functions"},
    {rule_simple_record_get_set, "rule_simple_record_get_set"},
    {rule_move_rely_out_when, "rule_move_rely_out_when"},
    {rule_move_when_out_when, "rule_move_when_out_when"},
    {rule_move_if_out_match, "rule_move_if_out_match"},
    {rule_move_if_out_expr, "rule_move_if_out_expr"},
    {rule_move_match_out_expr, "rule_move_match_out_expr"},
    {rule_unfold_specs, "rule_unfold_specs"},
};

extern unordered_map<size_t, Z3Result> Z3Cache;

void spec_transformer(Project *proj, Definition *def) {
    LOG_INFO << "Transforming " << def->name;
    std::cout << string(*def) << std::endl;
    bool debug = (def->name.rfind("map_unmap_ns", 0) == 0);
    auto known = std::set<string>();
    auto fname = def->name;

    for (auto arg : *def->args) {
        known.insert(arg->name);
    }

    if (debug)
        std::cout << "debug" << std::endl;

    while(true) {
        auto new_spec = def->body.release();

        auto changed = false;
        auto new_spec1 = new_spec;

        // Group 1
        while (true) {
            auto this_changed = false;
            new_spec1 = new_spec;

            for (auto rule : rules_group1) {
                if (rule == rule_eliminate_let) {
                    auto prev_symbols = std::set<string>(known);
                    auto __changed = false;

                    new_spec1 = eliminiate_ambiguity(proj, new_spec1, prev_symbols, __changed);
                    this_changed |= __changed;
                    changed |= __changed;
                }

                auto [__spec, __changed] = rule(proj, new_spec1);
                new_spec1 = __spec;
                this_changed |= __changed;
                changed |= __changed;

                new_spec = new_spec1;

#if 1
                if (__changed && debug)
                    std::cout << "(group1) " << def->name << " new_spec " << rule_names[rule] << ": \n=========================\n"
                        << string(*new_spec) << "\n==============================" << std::endl;
#endif
            }

            if (!this_changed)
                break;
        }

#define UNFOLD
#ifdef UNFOLD
        // Unfold
        do {
            auto [__spec, __unfolded] = rule_unfold_specs(proj, new_spec1);
            new_spec = __spec;
            changed |= __unfolded;

            if (__unfolded) {
                auto prev_symbols = std::set<string>(known);
                bool __changed = false;

                new_spec = eliminiate_ambiguity(proj, new_spec, prev_symbols, __changed);
                changed |= __changed;
                if (__changed && debug)
                    std::cout << "(unfold) " << def->name << " new_spec: \n=========================\n"
                        << string(*new_spec) << "\n==============================" << std::endl;
            }
        } while (false);
#endif
        while (true) {
            auto this_changed = false;
            new_spec1 = new_spec;

            for (auto rule : rules_group2) {
                if (rule == rule_eliminate_let) {
                    auto prev_symbols = std::set<string>(known);
                    auto __changed = false;

                    new_spec1 = eliminiate_ambiguity(proj, new_spec1, prev_symbols, __changed);
                    this_changed |= __changed;
                    changed |= __changed;
                }

                auto [__spec, __changed] = rule(proj, new_spec1);
                new_spec1 = __spec;
                this_changed |= __changed;
                changed |= __changed;

                new_spec = new_spec1;

#if 1
                if (__changed && debug)
                    std::cout << "(group2) " << def->name << " new_spec " << rule_names[rule] << ": \n=========================\n"
                        << string(*new_spec) << "\n==============================" << std::endl;
#endif
            }

            auto [__spec, __changed] = rule_simplify_expr(proj, new_spec1);
            new_spec1 = __spec;
            this_changed |= __changed;
            changed |= __changed;

            new_spec = new_spec1;

            if (__changed && debug)
                std::cout << "(simplify_expr) " << def->name << " new_spec "<< ": \n=========================\n"
                            << string(*new_spec) << "\n==============================" << std::endl;

            if (!this_changed)
                break;
        }

#define APPLY_LENS
#ifdef APPLY_LENS
        // lens
        while (true) {
            auto this_changed = false;
            new_spec1 = new_spec;

            do {
                auto before = string(*new_spec1);

                auto [__spec, __changed] = rule_eliminiate_indifferent(proj, new_spec1, def->name);
                new_spec1 = __spec;
                this_changed |= __changed;
                changed |= __changed;

                if (__changed && debug) {
                    std::cout << "(indifferent) before: " << def->name << " new_spec: \n=========================\n"
                        << before << "\n==============================" << std::endl;
                    std::cout << "(indifferent) " << def->name << " new_spec: \n=========================\n"
                        << string(*new_spec1) << "\n==============================" << std::endl;
                }
            } while (false);

            do {
                auto before = string(*new_spec1);
                auto [__spec, __changed] = rule_simplify_lens(proj, new_spec1);
                new_spec1 = __spec;
                this_changed |= __changed;
                changed |= __changed;

                if (__changed && debug) {
                    std::cout << "(simple indifferent) before: " << def->name << " new_spec: \n=========================\n"
                        << before << "\n==============================" << std::endl;
                    std::cout << "(simple indifferent) " << def->name << " new_spec: \n=========================\n"
                        << string(*new_spec1) << "\n==============================" << std::endl;
                }
            } while (false);

            new_spec = new_spec1;
            if (!this_changed)
                break;
        }
#endif

        // Z3
        auto vars = std::make_shared<unordered_map<string, shared_ptr<SpecValue>>>();
        auto conds = std::make_shared<vector<z3::expr>>();
        for (auto arg : *def->args)
            (*vars)[arg->name] = arg->type->declare(arg->name, 0);

        if (debug)
            std::cout << "Before Z3 " << def->name << ": \n=========================\n"
                << string(*new_spec) << "\n==============================" << std::endl;
        auto [__spec, __changed] = rule_simple_by_z3(proj, new_spec1, make_shared<EvalState>(vars, conds));
        Z3Cache.clear();
        changed |= __changed;

        new_spec = __spec;

        if (__changed && debug)
            std::cout << "(Z3) " << def->name << " new_spec: \n=========================\n"
                << string(*new_spec) << "\n==============================\n";


        def->body.reset(new_spec);
        def->_str = "";
        if (!changed)
            break;
    }
}

} // namespace autov