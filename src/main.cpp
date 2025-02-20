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


/**
 * @brief This is a brief main function here.
 */
int main(int argc, char *argv[])
{
    autov::log::init();
    autov::log::set_logging_level();

    OPTS.parse_options(argc, argv);

    std::unique_ptr<autov::Project> proj = std::make_unique<autov::Project>();

    autov::parser::parse(proj.get(), OPTS.config_file);

    // autov::analyze_fields_access(proj.get());

    // return 0;

    proj->finalize_project();

    autov::generate_proj(proj.get());

    return 0;
}
