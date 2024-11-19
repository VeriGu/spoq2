#include <rules.h>
#include <z3_rules.h>
#include <projection.h>
#include <project.h>
#include <shortcuts.h>
#include <mutex>
namespace autov {

extern unordered_map<unsigned long, bool> converged_spec;

unsigned long mono_lens_id = 0;

static vector<rule_ret_t(*)(Project *, SpecNode *)> rules_group1 = {
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

std::mutex Z3mtx;

void spec_transformer(Project *proj, Definition *def, int layer_id, bool unfold, bool low_spec) {
    LOG_INFO << "Transforming " << def->name << ", unfold: " << unfold;
    // std::cout << string(*def) << std::endl;

    bool debug = unfold && (def->name.rfind("smc_rtt_create", 0) == 0);
    auto known = std::set<string>();
    auto fname = def->name;

    for (auto arg : *def->args) {
        known.insert(arg->name);
    }

    if (debug)
        std::cout << "debug" << std::endl;

    converged_spec.clear();

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

#if 0
                if (__changed && debug)
                    std::cout << "(group1) " << def->name << " new_spec " << rule_names[rule] << ": \n=========================\n"
                        << string(*new_spec) << "\n==============================" << std::endl;
#endif
            }

            if (!this_changed)
                break;
        }

        // `unfold` by default is true
        if (unfold) {
            // Unfold
            do {
                if (proj->cmds.NoUnfoldAll)
                    break;
                auto [__spec, __unfolded] = rule_unfold_specs(proj, new_spec1);
                new_spec = __spec;
                changed |= __unfolded;

                if (__unfolded) {
                    auto prev_symbols = std::set<string>(known);
                    bool __changed = false;

                    new_spec = eliminiate_ambiguity(proj, new_spec, prev_symbols, __changed);
                    changed |= __changed;
#if 1
                    if (__changed && debug)
                        std::cout << "(unfold) " << def->name << " new_spec: \n=========================\n"
                            << string(*new_spec) << "\n==============================" << std::endl;
#endif
                }
            } while (false);
        }

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
                std::cout << def->name << " new_spec simplify_expr" << ": \n=========================\n"
                    << string(*new_spec) << "\n==============================" << std::endl;
#if 1
            if (__changed && debug)
                std::cout << "(simplify_expr) " << def->name << " new_spec "<< ": \n=========================\n"
                            << string(*new_spec) << "\n==============================" << std::endl;
#endif
            if (!this_changed)
                break;
        }

// #define APPLY_LENS
#ifdef APPLY_LENS
        // lens
        while (true) {
            auto this_changed = false;
            new_spec1 = new_spec;

            do {
                auto before = string(*new_spec1);

                auto [__spec, __changed] = rule_keep_fields_of_interest(proj, new_spec1, def->name);
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
        //if (unfold) {
            auto vars = std::make_shared<unordered_map<string, shared_ptr<SpecValue>>>();
            auto conds = std::make_shared<vector<z3::expr>>();
            for (auto arg : *def->args)
                (*vars)[arg->name] = arg->type->declare(arg->name, 0);
#if 1
            if (debug)
                std::cout << "Before Z3 " << def->name << ": \n=========================\n"
                    << string(*new_spec) << "\n==============================" << std::endl;
#endif
            auto [__spec, __changed] = rule_simple_by_z3(proj, new_spec1, make_shared<EvalState>(vars, conds));
            Z3Cache.clear();

            changed |= __changed;

            new_spec = __spec;

            if (debug && def->name == "__find_next_level_idx_spec")
                std::cout << "(Z3) " << def->name << " new_spec: \n=========================\n"
                    << string(*new_spec) << "\n==============================\n";

        //}

        def->body.reset(new_spec);
        def->_str = "";
        if (!changed)
            break;
    }

    #define CONDITION_SPEC
    #ifdef CONDITION_SPEC
    if(!instance_of(def, Fixpoint) && low_spec) {
        rule_conditional_spec(proj, def);
    }
    #endif

    bool has_if = false;

    if (unfold && spec_is_pure(proj, def->body.get(), has_if)) {
        if (!has_if)
            return;

        auto rettype = static_cast<Option *>(def->rettype.get());
        auto ret_elem_type = rettype->elem_type.get();

        if (!is_instance(ret_elem_type, Tuple))
            return;

        auto arg_prime = make_unique<vector<shared_ptr<Arg>>>();
        auto name_prime = def->name + "'";

        int skip_state = spec_needs_state(proj, def->body.get()) ? 0 : 1;

        for (int i = 0; i < def->args->size() - skip_state; i++)
            arg_prime->push_back(def->args->at(i));

        auto tuple_elems_type = make_shared<vector<shared_ptr<SpecType>>>();
        shared_ptr<SpecType> prime_rettype;
        if (skip_state) {
            spec_remove_state(proj, def->body.get());

            assert(is_instance(def->rettype.get(), Option));

            auto _ret_tuple = static_cast<Option *>(def->rettype.get())->elem_type.get();

            assert(is_instance(_ret_tuple, Tuple));

            auto ret_tuple = static_cast<Tuple *>(_ret_tuple);
            for (int i = 0; i < ret_tuple->types->size(); i++) 
                tuple_elems_type->push_back(ret_tuple->types->at(i));

            shared_ptr<Option> new_option;
            if (ret_tuple->types->size() > 2) {
                auto new_tuple_elems_type = make_shared<vector<shared_ptr<SpecType>>>();

                for (int i = 0; i < ret_tuple->types->size() - 1; i++)
                    new_tuple_elems_type->push_back(ret_tuple->types->at(i));

                auto new_tuple = make_shared<Tuple>(new_tuple_elems_type);
                new_option = make_shared<Option>(new_tuple);
            } else {
                new_option = make_shared<Option>(ret_tuple->types->at(0));
            }

            prime_rettype = new_option;

            proj->skip_state_specs.insert(def->name);
            proj->skip_state_specs.insert(name_prime);
        } else {
            auto _ret_tuple = static_cast<Option *>(def->rettype.get())->elem_type.get();
            auto ret_tuple = static_cast<Tuple *>(_ret_tuple);
            for (int i = 0; i < ret_tuple->types->size(); i++) 
                tuple_elems_type->push_back(ret_tuple->types->at(i));

            prime_rettype = def->rettype;
        }
        auto def_prime = make_unique<Definition>(name_prime, prime_rettype, std::move(arg_prime), std::move(def->body));

        auto &L = proj->layers[layer_id];

        std::cout << "def_prime:\n" << string(*def_prime) << std::endl;

        proj->add_definition(std::move(def_prime), make_shared<loc_t>(L->name, Project::LOC_SPEC, ""), 0);

        auto new_body_elems = make_unique<vector<unique_ptr<SpecNode>>>();

        for (int i = 0; i < def->args->size() - skip_state; i++)
            new_body_elems->push_back(make_unique<Symbol>(def->args->at(i)->name));

        auto new_expr = new Expr(def->name + "'", move(new_body_elems));

        SpecNode *res;
        if (!skip_state) {
            auto res_tuple = new vector<unique_ptr<SpecNode>>();

            res_tuple->push_back(make_unique<Symbol>("ret",  tuple_elems_type->at(0)));
            res_tuple->push_back(make_unique<Symbol>("st'", tuple_elems_type->at(1)));

            res = _Tuple(res_tuple);
        } else {
            res = new Symbol("ret", tuple_elems_type->at(0));
        }

        //auto res = _Tuple(res_tuple);

        auto ret_tuple = new vector<unique_ptr<SpecNode>>();

        ret_tuple->push_back(make_unique<Symbol>("ret", tuple_elems_type->at(0)));
        ret_tuple->push_back(make_unique<Symbol>("st", tuple_elems_type->at(1)));

        auto ret = _Some(_Tuple(ret_tuple));

        auto new_body = _When(res, new_expr, ret);

        def->body = unique_ptr<SpecNode>(new_body);

        proj->cmds.NoUnfold.insert(name_prime);
    }
}

} // namespace autov