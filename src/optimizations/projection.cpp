#include <rules.h>
#include <z3_rules.h>
#include <projection.h>
#include <project.h>
#include <shortcuts.h>
#include <mutex>
#include <cmd.h>
#include <symbolic.h>
#include <profile.h>
#include <type_inference.h>
#include <rules.h>
namespace autov {

extern unordered_map<unsigned long, bool> converged_spec;
extern unordered_map<size_t, Z3Result> Z3Cache;

unsigned long mono_lens_id = 0;
std::mutex Z3mtx;
extern bool force_simpl;
extern int unfold_count;
extern class UnfoldPolicy UNFOLD_POLICY;

inline std::string ruleid_to_string(RuleID rule) {
    switch (rule) {
        case RuleID::rule_eliminate_let: return "rule_eliminate_let";
        case RuleID::rule_eliminate_when: return "rule_eliminate_when";
        case RuleID::rule_eliminate_if: return "rule_eliminate_if";
        case RuleID::rule_eliminate_match_simple: return "rule_eliminate_match_simple";
        case RuleID::rule_subst_match_src_with_content: return "rule_subst_match_src_with_content";
        case RuleID::rule_simple_builtin_functions: return "rule_simple_builtin_functions";
        case RuleID::rule_simple_record_get_set: return "rule_simple_record_get_set";
        case RuleID::rule_move_rely_out_when: return "rule_move_rely_out_when";
        case RuleID::rule_move_when_out_when: return "rule_move_when_out_when";
        case RuleID::rule_move_if_out_match: return "rule_move_if_out_match";
        case RuleID::rule_move_if_out_expr: return "rule_move_if_out_expr";
        case RuleID::rule_move_match_out_expr: return "rule_move_match_out_expr";
        case RuleID::rule_unfold_specs: return "rule_unfold_specs";
        default: return "Unknown RuleID";
    }
}


unique_ptr<SpecNode> spec_transformer_v2(Project *proj, unique_ptr<SpecNode> node, int layer_id, bool unfold, bool low_spec) {
                LOG_DEBUG << "Transforming node" << string(*node);
    std::map<string, Symbol*> fvars;
    std::set<string> free;
    free_vars_map(proj, node.get(), free, fvars);
    auto vars = std::make_shared<unordered_map<string, shared_ptr<SpecValue>>>();
    auto conds = std::make_shared<vector<z3::expr>>();
    for (auto [name, sym] : fvars) {
        (*vars)[name] = sym->type->declare(name, 0);
    }

    converged_spec.clear();
    unique_ptr<SpecNode> spec = std::move(node);
    while(true) {
        profile_clear_epoch();
        auto known = std::set<string>();
        for (auto [arg, _] : fvars) {
            known.insert(arg);
        }
        LOG_DEBUG << "start partial_eval" << "\n";
        spec = partial_eval(proj, std::move(spec), 0, make_shared<EvalState>(vars, conds), known, unfold);
        LOG_DEBUG << "end partial_eval" << "\n";
        bool changed = false;
        assert(spec);
        //type_inference::check_well_typed(*proj, spec.get(), known);
        

        if(unfold && !proj->cmds.NoUnfoldAll) {
            auto [spec1, __changed] = proj->rules.rule_unfold_specs(std::move(spec), true);
            //LOG_DEBUG <<  "------------------after unfold:----------------------\n" << string(*__spec);
            changed |= __changed;
            //type_inference::check_well_typed(*proj, __spec.get(), known);
            spec = std::move(spec1);
        }

        known = std::set<string>();
        for (auto [arg, _] : fvars) {
            known.insert(arg);
        }
        bool um_changed = false;
        spec = proj->rules.eliminate_ambiguity(std::move(spec), known, um_changed);
        changed |= um_changed;

        //type_inference::check_well_typed(*proj, __tmp_spec.get(), known);

    
        auto [__tmp_spec1, le_changed] = proj->rules.rule_eliminate_let(std::move(spec), true);
        changed |= le_changed;
        //type_inference::check_well_typed(*proj, __tmp_spec1.get(), known);
        LOG_DEBUG << "----------------after_let_elimination:---------------------\n" << string(*__tmp_spec1);


        auto [__tmp_spec2, we_changed] = proj->rules.rule_eliminate_when(std::move(__tmp_spec1), true);
        //LOG_DEBUG << "----------------after_when_elimination:---------------------\n" << string(*__tmp_spec2);
        changed |= we_changed;
        //type_inference::check_well_typed(*proj, __tmp_spec2.get(), known)
        auto [__tmp_spec3, z3_changed] = proj->rules.rule_simple_by_z3(std::move(__tmp_spec2), make_shared<EvalState>(vars, conds));
        //LOG_DEBUG << "--------------------after_z3---------------------------\n:" << string(*__tmp_spec3);
        changed |= z3_changed;
        // auto [__tmp_spec4, em_changed] = proj->rules.rule_eliminate_match_simple(std::move(__tmp_spec2), true);
        // changed |= em_changed;
        profile_update_epoch();
        //type_inference::check_well_typed(*proj, __tmp_spec3.get(), known);
        spec = std::move(__tmp_spec3);
        if(!changed) {
                break;
        }
    }
    return spec;
}

void spec_transformer_v2(Project *proj, Definition *def, int layer_id, bool unfold, bool low_spec, int max_iter) {
    LOG_INFO << "Transforming " << def->name << ", unfold: " << unfold;
    // LOG_INFO << "Transforming " << def->name << "def: " << string(*def);
    proj->query_saver = query_saver_dir(def->name, "transforms" + std::to_string(layer_id) + std::to_string(max_iter));
    auto fname = def->name;
    auto vars = std::make_shared<unordered_map<string, shared_ptr<SpecValue>>>();
    auto conds = std::make_shared<vector<z3::expr>>();
    auto &preconds = proj->cmds.PreCond[fname];

    for (auto arg : *def->args) {
        (*vars)[arg->name] = arg->type->declare(arg->name, 0);
    }
    unique_ptr<SpecNode> aggrepres = make_unique<BoolConst>(true);
	for(auto &inv : preconds) {
        auto elems = new vector<unique_ptr<SpecNode>>();
        elems->push_back(std::move(aggrepres));
        elems->push_back(inv->deep_copy());
        aggrepres = make_unique<Expr>(Expr::binops::AND, unique_ptr<vector<unique_ptr<SpecNode>>>(elems), Bool::BOOL);
	}
    // LOG_DEBUG << "ADDING PreConditions: " << string(*aggrepres);

    auto llvm_func = proj->spoq_code.llvm_module->getFunction(fname);
    size_t idx = 0;
    for (auto arg: *def->args) {
        auto st = Struct::Ptr;
        auto argt = arg->type;
        if(st.get() == argt.get()) {
            if(llvm_func) {
                // auto larg = llvm_func->getArg(idx);
                LOG_DEBUG << "Arg: " << arg->name << " type: " << arg->type->name;
            }
        }    
        idx++;
    }
    auto state = make_shared<EvalState>(vars, conds);

    set<string> fix_string;
    auto precond_z3 = z3_eval(proj, aggrepres.get(), state, false, true, fix_string);
    state->conds->push_back(precond_z3->get_z3_value());
    
    converged_spec.clear();
    UNFOLD_POLICY.set_skip(true);
    int cur_iter = 0;
    while(cur_iter < max_iter) {
            cur_iter++;
            profile_clear_epoch();
            auto known = std::set<string>();
            for (auto arg : *def->args) {
                known.insert(arg->name);
            }

            auto log_fn_name = "changedline_vuln_spec";
            bool log_spec = false;
            if(def->name == log_fn_name){
                auto s = string(*def->body);
                LOG_DEBUG << "Starting transformation iteration " << cur_iter << ".";//  Current spec " << s << "\n\n";
                auto dumpfile = def->name + "_transform_" + std::to_string(cur_iter);
                std::ofstream ofs(dumpfile);
                ofs << s;
                ofs.close();
            }else {
                LOG_DEBUG << def->name << " transformation iteration " << cur_iter << ".";//  Current spec " << s << "\n\n";
            }
            auto spec = std::move(def->body);
            
            // Trying to figure out where we're getting a new unknown symbol from.
            auto current_free_vars = std::set<string>();
            free_vars(proj, spec.get(), current_free_vars);
            for (auto &arg : *(def->args)){
                current_free_vars.insert(arg->name);
            }
            auto updated_free_vars = std::set<string>();
            auto new_free_vars = std::set<string>();


            // LOG_DEBUG << "start partial eval" << " " << force_simpl << "\n";
            spec = partial_eval(proj, std::move(spec), 0, make_shared<EvalState>(vars, conds), known, unfold);
            if(def->name == log_fn_name)
                LOG_DEBUG << "spec after partial eval: " << (log_spec ? string(*spec.get()) : "") << "\n";

            // updated_free_vars = std::set<string>();
            // new_free_vars = std::set<string>();
            // free_vars(proj, spec.get(), updated_free_vars);
            // std::set_difference(updated_free_vars.begin(), updated_free_vars.end(), current_free_vars.begin(), current_free_vars.end(), inserter(new_free_vars, new_free_vars.begin()));
            // assert(new_free_vars.empty());
            // LOG_DEBUG << "end partial eval" << "\n";
            //profile_print_transrule();
            // LOG_DEBUG << def->name << "------------------after_partial_eval:----------------------\n" << string(*spec);
            assert(spec);
            bool changed = false;
            bool __unfold = false;
            // type_inference::check_well_typed(*proj, spec.get(), known);
            
            force_simpl = false;
            changed = false;
            bool still_unfolding;
            bool um_changed, le_changed, me_changed, we_changed, cb_changed, hoist_changed = false;
            do {
                still_unfolding = false;
            if(unfold && !proj->cmds.NoUnfoldAll) {
                assert(spec);
                auto [_spec, unfolded] = proj->rules.rule_unfold_specs(std::move(spec), true);
                __unfold = unfolded;
                if(def->name == log_fn_name)
                    LOG_DEBUG << "Unfolded within " << def->name <<  ".  Changed: " << unfolded;
                changed |= unfolded;
                still_unfolding |= unfolded;
                spec = std::move(_spec);
                // type_inference::check_well_typed(*proj, spec.get(), known);
            }
            // LOG_DEBUG << "end unfold , start eliminate" << "\n";
            
            known = std::set<string>();
            for (auto arg : *def->args) {
                known.insert(arg->name);
            }
            assert(spec);
            um_changed = false;
            if (still_unfolding){
                spec = proj->rules.eliminate_ambiguity(std::move(spec), known, um_changed);
            }
            changed |= um_changed;
            still_unfolding |= um_changed;
            if(def->name == log_fn_name)
            LOG_DEBUG << "spec after post unfolding ea: " << (log_spec ? string(*spec.get()) : "") << "\n";
            // free var check
            // updated_free_vars = std::set<string>();
            // new_free_vars = std::set<string>();
            // free_vars(proj, spec.get(), updated_free_vars);
            // std::set_difference(updated_free_vars.begin(), updated_free_vars.end(), current_free_vars.begin(), current_free_vars.end(), inserter(new_free_vars, new_free_vars.begin()));
            // assert(new_free_vars.empty());
            // type_inference::check_well_typed(*proj, spec.get(), known);
            // LOG_DEBUG << "end eliminate, start let" << "\n";
            assert(spec);
            auto [__tmp_spec1, _le_changed] = proj->rules.rule_eliminate_let(std::move(spec), true);
            le_changed = _le_changed;
            changed |= le_changed;
            spec = std::move(__tmp_spec1);
            if(def->name == log_fn_name)
            LOG_DEBUG << "spec after eliminate_let: " << (log_spec ? string(*spec.get()) : "") << "\n";
            assert(spec);
            // free var check
            // updated_free_vars = std::set<string>();
            // new_free_vars = std::set<string>();
            // free_vars(proj, spec.get(), updated_free_vars);
            // std::set_difference(updated_free_vars.begin(), updated_free_vars.end(), current_free_vars.begin(), current_free_vars.end(), inserter(new_free_vars, new_free_vars.begin()));
            // assert(new_free_vars.empty());
            // type_inference::check_well_typed(*proj, spec.get(), known);
            // LOG_DEBUG << def->name << "----------------after_let_elimination:---------------------\n";

            // LOG_DEBUG << "end let, start when" << "\n";

            assert(spec);
            auto [__tmp_spec2, _we_changed] = proj->rules.rule_eliminate_when(std::move(spec), true);
            we_changed = _we_changed;
            spec = std::move(__tmp_spec2);
            assert(spec);
            if(def->name == log_fn_name)
                LOG_DEBUG << "spec after eliminate_when: " << (log_spec ? string(*spec.get()) : "") << "\n";
            changed |= we_changed;
            // This eliminate_match_simple is a loadbearing transformation rule due to the appearance of a _ => ... branch in struct_static
            auto [__tmp_spec3, _me_changed] = proj->rules.rule_eliminate_match_simple(std::move(spec), true);
            me_changed = _me_changed;
            spec = std::move(__tmp_spec3);
            assert(spec);
            // free var check
            // updated_free_vars = std::set<string>();
            // new_free_vars = std::set<string>();
            // free_vars(proj, spec.get(), updated_free_vars);
            // std::set_difference(updated_free_vars.begin(), updated_free_vars.end(), current_free_vars.begin(), current_free_vars.end(), inserter(new_free_vars, new_free_vars.begin()));
            // assert(new_free_vars.empty());
            // LOG_DEBUG << "----------------after_when_elimination:---------------------\n";
            // changed |= me_changed;
            if(def->name == log_fn_name)
                LOG_DEBUG << "spec after eliminate_match_simple: " << (log_spec ? string(*spec.get()) : "") << "\n";
                
                spec = partial_eval(proj, std::move(spec), 0, make_shared<EvalState>(vars, conds), known, unfold);
                if(def->name == log_fn_name)
                    LOG_DEBUG << "spec after partial eval: " << (log_spec ? string(*spec.get()) : "") << "\n";
            // free var check
            // updated_free_vars = std::set<string>();
            // new_free_vars = std::set<string>();
            // free_vars(proj, spec.get(), updated_free_vars);
            // std::set_difference(updated_free_vars.begin(), updated_free_vars.end(), current_free_vars.begin(), current_free_vars.end(), inserter(new_free_vars, new_free_vars.begin()));
            // assert(new_free_vars.empty());

                std::tie(spec, cb_changed) = proj->rules.simple_const_bool(std::move(spec));
                if(def->name == log_fn_name)
                    LOG_DEBUG << "spec after simple_const_bool: " << (log_spec ? string(*spec.get()) : "") << "\n";
            changed |= cb_changed;
            } while(still_unfolding);
            std::tie(spec, hoist_changed) = proj->rules.hoist_match_from_branch(std::move(spec));
            if(def->name == log_fn_name)
                    LOG_DEBUG << "spec after hoist: " << (log_spec ? string(*spec.get()) : "") << "\n";
            changed |= hoist_changed;
            if (hoist_changed) {
                spec = proj->rules.eliminate_ambiguity(std::move(spec), known, um_changed);
            }
            if(def->name == log_fn_name)
                    LOG_DEBUG << "spec after post-hoist ea: " << (log_spec ? string(*spec.get()) : "") << "\n";

            // auto [__tmp_spec4, hoist_changed] = proj->rules.hoist_match_from_branch(std::move(spec));
            // spec = std::move(__tmp_spec4);
            // assert(spec);
            // changed |= hoist_changed;
            // type_inference::check_well_typed(*proj, spec.get(), known);
            bool z3_changed = false;
            if (force_simpl || !__unfold) {
                auto start = std::chrono::high_resolution_clock::now();
                // LOG_DEBUG << "start z3" << "\n";
                force_simpl = true;
                std::tie(spec, z3_changed) = proj->rules.rule_simple_by_z3(std::move(spec), state->copy());
                assert(spec);
                if(def->name == log_fn_name)
                    LOG_DEBUG << "spec after simple_by_z3: " << (log_spec ? string(*spec.get()) : "") << "\n";
// free var check
            updated_free_vars = std::set<string>();
            new_free_vars = std::set<string>();
            free_vars(proj, spec.get(), updated_free_vars);
            std::set_difference(updated_free_vars.begin(), updated_free_vars.end(), current_free_vars.begin(), current_free_vars.end(), inserter(new_free_vars, new_free_vars.begin()));
            assert(new_free_vars.empty());
                // LOG_DEBUG << "end z3" << "\n";
                auto end = std::chrono::high_resolution_clock::now();
                auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(end - start);
                LOG_DEBUG << "spec transformer for " << def->name << " Z3 time: " << duration.count() / 1000.0 << " seconds\n";
                LOG_DEBUG << "z3_changed: " << z3_changed << ", me_changed: " << me_changed << ", we_changed: " << we_changed << ", le_changed: " << le_changed << ",um_changed: " << um_changed;
            }
            changed |= z3_changed;
            profile_update_epoch();
            type_inference::check_well_typed(*proj, spec.get(), known);
            assert(spec);
            def->body = std::move(spec);
            if(!changed) {
                if (UNFOLD_POLICY.skip) {
                    // Dealy some branch-irrelevant spec to the last
                    UNFOLD_POLICY.set_skip(false);
                    profile_print_transrule();
                } else if (UNFOLD_POLICY.require_loop_unroll(def->name, proj->cmds.LoopUnroll)) {
                    LOG_DEBUG << "we start greedily unfolding for " << UNFOLD_POLICY.current_unfold << " times for " << def->name << "\n";
                } else {
                    LOG_DEBUG << "finish spec transformer for " << def->name << ", iterations " << cur_iter << ".";
                   break;
                }
            }
    }
}


void spec_transformer(Project *proj, Definition *def, int layer_id, bool unfold, bool low_spec) {
    LOG_INFO << "Transforming " << def->name << ", unfold: " << unfold;

    auto known = std::set<string>();
    auto fname = def->name;

    for (auto arg : *def->args) {
        known.insert(arg->name);
    }

    converged_spec.clear();
    /** Rules with smart pointers */
    while (true) {
        auto new_spec = std::move(def->body);
        auto changed = false;

        // group 1
        while (true) {
            auto this_changed = false;
            // tmp spec should only be used in rule group loop
            auto tmp_spec = std::move(new_spec);
            for (auto &r : proj->rules.rules_group1) {
                if (r.id == RuleID::rule_eliminate_let) {
                    auto prev_symbols = std::set<string>(known);
                    auto __changed = false;
                    tmp_spec = proj->rules.eliminate_ambiguity(std::move(tmp_spec), prev_symbols, __changed);

                    this_changed |= __changed;
                    changed |= __changed;
                }
                auto orig_spec_str = string(*tmp_spec.get());
                auto [__spec, __changed] = r.call(std::move(tmp_spec));
                tmp_spec = std::move(__spec);
                this_changed |= __changed;
                changed |= __changed;
                if(__changed) {
                    std::cout << "group1 rule:" << ruleid_to_string(r.id) << def->name << " new_spec: \n=========================\n"
                        << string(*tmp_spec.get()) << "\n==============================\n";
                }
                auto new_spec_str = string(*tmp_spec.get());
            }
            new_spec = std::move(tmp_spec);
            if (!this_changed)
                break;
        }


        if (unfold && !proj->cmds.NoUnfoldAll) {
            auto [__spec, __unfolded] = proj->rules.rule_unfold_specs(std::move(new_spec),true);
            new_spec = std::move(__spec);
            changed |= __unfolded;

            if (__unfolded) {
                auto prev_symbols = std::set<std::string>(known);
                bool __changed = false;
                new_spec = proj->rules.eliminate_ambiguity(std::move(new_spec), prev_symbols, __changed);
                changed |= __changed;
            }
        }

        // group 2
        while (true) {
            auto this_changed = false;
            // tmp spec should only be used in rule group loop
            auto tmp_spec = std::move(new_spec);
            for (auto &r : proj->rules.rules_group2) {
                if (r.id == RuleID::rule_eliminate_let) {
                    auto prev_symbols = std::set<string>(known);
                    auto __changed = false;
                    tmp_spec = proj->rules.eliminate_ambiguity(std::move(tmp_spec), prev_symbols, __changed);

                    this_changed |= __changed;
                    changed |= __changed;
                }
                auto [__spec, __changed] = r.call(std::move(tmp_spec));
                tmp_spec = std::move(__spec);
                this_changed |= __changed;
                changed |= __changed;
                if(__changed) {
                    std::cout << "group2 rule:" << ruleid_to_string(r.id) << def->name << " new_spec: \n=========================\n"
                        << string(*tmp_spec.get()) << "\n==============================\n";
                }

            }
            auto [__spec, __changed] = proj->rules.rule_simplify_expr(std::move(tmp_spec), true);
            this_changed |= __changed;
            changed |= __changed;
            new_spec = std::move(__spec);

            if (!this_changed)
                break;
        }
        // z3
        // if (unfold) {
            auto vars = std::make_shared<unordered_map<string, shared_ptr<SpecValue>>>();
            auto conds = std::make_shared<vector<z3::expr>>();
            for (auto arg : *def->args) {
                (*vars)[arg->name] = arg->type->declare(arg->name, 0);
            }
            profile_clear_epoch();
            auto [__spec, __changed] = proj->rules.rule_simple_by_z3(std::move(new_spec), make_shared<EvalState>(vars, conds));
            profile_update_epoch();
            
            changed |= __changed;
            new_spec = std::move(__spec);
            
            std::cout << "(Z3) " << def->name << " new_spec: \n=========================\n"
                    << string(*new_spec.get()) << "\n==============================\n";
        // }

        def->body = std::move(new_spec);
        def->_str.clear();

        if (!changed)
            break;
    }
    Z3Cache.clear();

// #define PRIME_SPEC
#ifdef PRIME_SPEC
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

        auto new_expr = new Expr(def->name + "'",std::move(new_body_elems));

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
#endif

}

} // namespace autov