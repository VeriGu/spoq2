#pragma once
#include <boost/program_options.hpp>
#include <iostream>
#include <profile.h>

namespace po = boost::program_options;

/** TODO: replace z3_eval on if with symbolic simple check */
static bool __OPT_ON_RELY = false;
static bool __OPT_ON_MATCH = true;
static bool __OPT_ON_ARITH = true;
static bool __OPT_ON_INDUCTION = true;

class SpoqOption {

public:
    bool conditional_spec = false;
    bool lens = false;
    bool use_llvm_frontend = false;
    bool check_inv = false;
    bool check_loop_inv = false;
    bool check_pre_post = false;
    bool profile = false;
    bool new_trans = false;
    bool check_simulation = false;
    bool decompose_check_simulation = false;
    std::string config_file;
    boost::program_options::variables_map vmap;

    /**
     * @brief report the command line options
     * 
     */
    void report() {
        std::cout << "Command-line options:\n";
        std::cout << "  conditional_spec: " << std::boolalpha << conditional_spec << "\n";
        std::cout << "  lens: " << std::boolalpha << lens << "\n";
        std::cout << "  config_file: " << config_file << "\n";
        std::cout << "  use_llvm_frontend: " << std::boolalpha << use_llvm_frontend << "\n";
        std::cout << "  check-sys: " << std::boolalpha << check_inv << "\n";
        std::cout << "  check-loop: " << std::boolalpha << check_loop_inv << "\n";
        std::cout << "  new-trans: " << std::boolalpha << new_trans << "\n";
        std::cout << "  check-pre-post: " << std::boolalpha << check_pre_post << "\n";
        std::cout << "  profile: " << std::boolalpha << profile << "\n";
        std::cout << "  check-simulation: " << std::boolalpha << check_simulation << "\n";
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
            ("lens,l", po::bool_switch()->default_value(true), "use lens")
            ("no-lens", po::bool_switch()->default_value(false), "do not use lens (ovrride --lens)")
            ("new-trans", po::bool_switch()->default_value(false), "use new transformation") 
            ("llvm", po::bool_switch()->default_value(false), "use llvm frontend") 
            ("conditional-spec,c", po::bool_switch()->default_value(false), "automatically generate conditional spec")
            ("check-sys-inv", po::bool_switch()->default_value(true), "checking system invariants")
            ("check-loop-inv", po::bool_switch()->default_value(false), "checking loop invariants")
            ("check-pre-post", po::bool_switch()->default_value(false), "checking pre/post conditions")
            ("check-simulation", po::bool_switch()->default_value(false),"checking relational simulation")
            ("check-pre-post", po::bool_switch()->default_value(false), "checking pre/post conditions")
            ("profile", po::bool_switch()->default_value(true), "use profile (default on)")
            ("no-profile", po::bool_switch()->default_value(false), "do not profile (override --profile)")
            ("decom-check-simul",po::bool_switch()->default_value(false), "checking relational simulation");

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

        this->conditional_spec = vmap["conditional-spec"].as<bool>();
        this->lens = vmap["lens"].as<bool>();
        this->config_file = vmap["input"].as<std::string>();
        this->use_llvm_frontend = vmap["llvm"].as<bool>();
        this->check_inv = vmap["check-sys-inv"].as<bool>();
        this->check_loop_inv = vmap["check-loop-inv"].as<bool>();
        this->check_pre_post = vmap["check-pre-post"].as<bool>();
        this->new_trans = vmap["new-trans"].as<bool>();
        this->profile = vmap["profile"].as<bool>();

        this->lens = !vmap["no-lens"].as<bool>();
        this->profile = !vmap["no-profile"].as<bool>();
        autov::__PROFILE_ON = this->profile;

        this->check_simulation = vmap["check-simulation"].as<bool>();
        this->decompose_check_simulation = vmap["decom-check-simul"].as<bool>();

        if (vmap.count("no-lens")) {
            this->lens = false;
        }
 
        report();

        return true;
    }
};

extern SpoqOption OPTS;
