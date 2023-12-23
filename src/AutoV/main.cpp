#include <iostream>
#include <values.h>
#include <utils.h>
#include <nodes.h>
#include <log.h>
#include <parser.h>
#include <project.h>

int main(void)
{
    autov::log::init();
    autov::log::set_logging_level();

    LOG_DEBUG << "Hello world!";
    LOG_INFO << "Hello world!";
    LOG_WARNING << "Hello world!";
    LOG_ERROR << "Hello world!";

    std::unique_ptr<autov::Project> proj = std::make_unique<autov::Project>();

    autov::parser::parse(proj.get(), "/home/xuheng/vbbx/VeriFrame/RMMProof/proof_stack.v");
    return 0;
}