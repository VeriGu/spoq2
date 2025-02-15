#include <iostream>
#include <values.h>
#include <utils.h>
#include <nodes.h>
#include <log.h>
#include <parser.h>
#include <project.h>
#include <fstream>
#include <cstdlib>
#include <gen_project.h>
#include <cmd.h>

namespace po = boost::program_options;

using std::string;

boost::program_options::variables_map OPT_VM;
struct OPTS_t OPTS;

/** 
 * @brief A sample comment.
 */
int main(int argc, char *argv[])
{
    autov::log::init();
    autov::log::set_logging_level();

    po::options_description desc("Allowed options");
    desc.add_options()
        ("help,h", "produce help message")
        ("lens,l", po::bool_switch()->default_value(true), "use lens")
        ("conditional-spec,c", po::bool_switch()->default_value(false), "automatically generate conditional spec");

    po::positional_options_description p;
    p.add("input", 1); // The input .v config file is positional and is the first argument

    desc.add_options()
        ("input", po::value<string>(), "input .v config file(postional)");

    // Parse the command line arguments

    po::store(po::command_line_parser(argc, argv).options(desc).positional(p).run(), OPT_VM);
    po::notify(OPT_VM);

    if (OPT_VM.count("help")) {
        std::cout << desc << std::endl;
        return 1;
    }

    if (!OPT_VM.count("input")) {
        std::cout << "Please provide a .v config file" << std::endl;
        return 1;
    }

    if (OPT_VM["conditional-spec"].as<bool>()) {
        OPTS.conditional_spec = true;
        LOG_INFO << "Generating conditional spec" << std::endl;
    }

    std::unique_ptr<autov::Project> proj = std::make_unique<autov::Project>();

    autov::parser::parse(proj.get(), OPT_VM["input"].as<string>());

    // autov::analyze_fields_access(proj.get());

    // return 0;

    proj->finalize_project();

    autov::generate_proj(proj.get());

    return 0;
}
