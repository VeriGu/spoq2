#pragma once
#include <boost/program_options.hpp>
#include <iostream>
#include <profile.h>

namespace po = boost::program_options;

/** TODO: replace z3_eval on if with symbolic simple check */


class SpoqOption {

public:
    bool conditional_spec = false;
    bool lens = false;
    bool coi = false;
    bool coi_prune_path = true; 
    bool use_llvm_frontend = false;
    bool check_inv = false;
    bool check_loop_inv = false;
    bool check_pre_post = false;
    bool profile = false;
    bool new_trans = false;
    bool check_simulation = false;
    bool decompose_check_simulation = false;
    bool check_none = false;
    bool transform_io = false;
    bool race = false;
    int race_timeout = 120; // 2min as default
    bool z3_expr_cache = true; // enable z3 expr cache by default
    std::string target_spec   = "";  

    std::string query_path;
    std::string config_file;
    boost::program_options::variables_map vmap;


    bool __OPT_ON_RELY = false;
    bool __OPT_ON_MATCH = true;
    bool __OPT_ON_ARITH = true;
    bool __OPT_ON_INDUCTION = true;
    /**
     * @brief report the command line options
     * 
     */
    void report() {
        std::cout << "Command-line options:\n";
        std::cout << "  config_file: " << config_file << "\n";
        std::cout << "  cone of influence reduction: " << std::boolalpha << coi << "\n";
        std::cout << "  cone of influence prune path: " << std::boolalpha << coi_prune_path << "\n";
        std::cout << "  use_llvm_frontend: " << std::boolalpha << use_llvm_frontend << "\n";
        std::cout << "  new-trans: " << std::boolalpha << new_trans << "\n";
        std::cout << "  check-sys: " << std::boolalpha << check_inv << "\n";
        std::cout << "  check-loop: " << std::boolalpha << check_loop_inv << "\n";
        std::cout << "  check-pre-post: " << std::boolalpha << check_pre_post << "\n";
        std::cout << "  check-simulation: " << std::boolalpha << check_simulation << "\n";
        std::cout << "  check-simulation-with-decompose: " << std::boolalpha << decompose_check_simulation << "\n";
        std::cout << "  profile: " << std::boolalpha << profile << "\n";
        std::cout << "  conditional_spec: " << std::boolalpha << conditional_spec << "\n";
        std::cout << "  lens: " << std::boolalpha << lens << "\n";
        std::cout << "  check-none: " << std::boolalpha << check_none << "\n";
        std::cout << "  transform_io: " << std::boolalpha << transform_io << "\n";
        std::cout << "  race: " << std::boolalpha << race << "\n";
        std::cout << "  race timeout: " << std::boolalpha << race_timeout << "s\n";
        std::cout << "  Z3 expression cache: " << std::boolalpha << z3_expr_cache << "\n";

        std::cout << std::endl;
    }

    /**
     * @brief parse the command line options
     * 
     * @param argc 
     * @param argv 
     * @return true if the options are parsed successfully
     * @return false if the options are not parsed successfully
     */
    bool parse_options(int argc, char* argv[]) {
        po::options_description desc("Allowed options");
        desc.add_options()
            ("help,h", "produce help message")
            ("coi", po::bool_switch()->default_value(true), "use cone of influence reduction")
            ("no-coi", po::bool_switch()->default_value(false), "do not use coi (override --coi)")
            ("no-prune-path", po::bool_switch()->default_value(false), "do not use coi for pruning path")
            ("no-expr-cache", po::bool_switch()->default_value(false), "do not use Z3 expr caching")
            ("lens,l", po::bool_switch()->default_value(true), "use lens")
            ("no-lens", po::bool_switch()->default_value(false), "do not use lens (ovrride --lens)")
            ("new-trans", po::bool_switch()->default_value(false), "use new transformation") 
            ("llvm", po::bool_switch()->default_value(false), "use llvm frontend") 
            ("check-loop-inv", po::bool_switch()->default_value(false), "checking loop invariants")
            ("check-pre-post", po::bool_switch()->default_value(false), "checking pre/post conditions")
            ("check-sys-inv", po::bool_switch()->default_value(true), "checking system invariants")
            ("check-simulation", po::bool_switch()->default_value(false),"checking relational simulation")
            ("decom-check-simul",po::bool_switch()->default_value(false), "checking relational simulation")
            ("profile", po::bool_switch()->default_value(true), "use profile (default on)")
            ("no-profile", po::bool_switch()->default_value(false), "do not profile (override --profile)")
            ("conditional-spec,c", po::bool_switch()->default_value(false), "automatically generate conditional spec")
            ("query-path",po::value<std::string>(&query_path)->default_value("./llvm.container/z3_queries/"),"set query path")
            ("check-none", po::bool_switch()->default_value(false), "check none path")
            ("transform-io", po::bool_switch()->default_value(false), "transform io path")
            ("race", po::bool_switch()->default_value(false), "multi-solver support")
            ("race-timeout", po::value<int>(&race_timeout)->default_value(race_timeout), "Z3 CPU limit in seconds")
            ("target-transition",
             po::value<std::string>(&target_spec)->default_value(target_spec),
             "To-be-verified top-level transition function")
            ;

        po::positional_options_description p;
        p.add("input", 1); // The input .v config file is positional and is the first argument

        desc.add_options()
            ("input", po::value<std::string>(), "input .v config file(positional)");

        // Parse the command line arguments

        po::store(po::command_line_parser(argc, argv).options(desc).positional(p).run(), vmap);
        po::notify(vmap);

        if (vmap.count("help")) {
            std::cout << desc << std::endl;
            return false;
        }

        if (!vmap.count("input")) {
            std::cout << "Please provide a .v config file" << std::endl;
            return false;
        }

        this->coi = vmap["coi"].as<bool>();
        this->conditional_spec = vmap["conditional-spec"].as<bool>();
        this->lens = vmap["lens"].as<bool>();
        this->config_file = vmap["input"].as<std::string>();
        this->use_llvm_frontend = vmap["llvm"].as<bool>();
        this->check_inv = vmap["check-sys-inv"].as<bool>();
        this->check_loop_inv = vmap["check-loop-inv"].as<bool>();
        this->check_pre_post = vmap["check-pre-post"].as<bool>();
        this->new_trans = vmap["new-trans"].as<bool>();
        this->profile = vmap["profile"].as<bool>();
        this->check_none = vmap["check-none"].as<bool>();
        this->lens = !vmap["no-lens"].as<bool>();
        if (vmap["no-profile"].as<bool>()) {
            this->profile = false;
        } else {
            this->profile = vmap["profile"].as<bool>();
        }
        autov::__PROFILE_ON = this->profile;

        this->check_simulation = vmap["check-simulation"].as<bool>();
        this->decompose_check_simulation = vmap["decom-check-simul"].as<bool>();
        this->transform_io = vmap["transform-io"].as<bool>();
        this->race = vmap["race"].as<bool>();

        if (vmap.count("no-coi")) {
            this->lens = false;
        }
        if (vmap["no-coi"].as<bool>()) {
            this->coi = false;
        } else {
            this->coi = vmap["coi"].as<bool>();
        }
        if (vmap["no-prune-path"].as<bool>()) {
            this->coi_prune_path = false;
        }
        if (vmap["no-expr-cache"].as<bool>()) {
            this->z3_expr_cache = false;
        }

        report();

        return true;
    }
};

extern SpoqOption OPTS;
