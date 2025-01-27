#pragma once
#include <boost/program_options.hpp>

extern boost::program_options::variables_map OPT_VM;

struct OPTS_t {
    bool conditional_spec = false;
    bool lens = true;
};

extern struct OPTS_t OPTS;