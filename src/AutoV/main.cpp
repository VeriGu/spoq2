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

using std::string;

const string base_file_dir = "testcase/";

int main(int argc, char *argv[])
{
    autov::log::init();
    autov::log::set_logging_level();

    LOG_DEBUG << "Hello world!";
    LOG_INFO << "Hello world!";
    LOG_WARNING << "Hello world!";
    LOG_ERROR << "Hello world!";

    if (argc != 2) {
        LOG_ERROR << "Usage: " << argv[0] << " <file>";
        return 1;
    }

    std::unique_ptr<autov::Project> proj = std::make_unique<autov::Project>();

    autov::parser::parse(proj.get(), argv[1]);

    proj->finalize_project();

    autov::generate_proj(proj.get());

    return 0;
}
