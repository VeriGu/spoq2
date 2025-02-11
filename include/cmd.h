#pragma once
#include <boost/program_options.hpp>

extern boost::program_options::variables_map OPT_VM;

/** TODO: replace z3_eval on if with symbolic simple check */
static bool __OPT_ON_RELY = false;
static bool __OPT_ON_MATCH = true;
static bool __OPT_ON_ARITH = true;
struct OPTS_t {
    bool conditional_spec = false;
    bool lens = false;
};

extern struct OPTS_t OPTS;