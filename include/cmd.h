#pragma once
#include <boost/program_options.hpp>
#include <iostream>

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
            ("llvm", po::bool_switch()->default_value(false), "use llvm frontend") 
            ("conditional-spec,c", po::bool_switch()->default_value(false), "automatically generate conditional spec");
        
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
            std::cout << desc << std::endl;
            std::cout << "Please provide a .v config file" << std::endl;
            return false;
        }

        this->conditional_spec = vmap["conditional-spec"].as<bool>();
        this->lens = vmap["lens"].as<bool>();
        this->config_file = vmap["input"].as<std::string>();
        this->use_llvm_frontend = vmap["llvm"].as<bool>();

        report();

        return true;
    }
};

static class SpoqOption OPTS;