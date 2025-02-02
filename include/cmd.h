#pragma once
#include <boost/program_options.hpp>

extern boost::program_options::variables_map OPT_VM;

#define OPTIMIZE_ON_RELY 1
/** TODO: replace z3_eval on if with symbolic simple check */
#define OPTIMIZE_ON_MATCH 1
#define OPTIMIZE_ON_ARITH 1

static bool __OPT_ON_RELY = true;
static bool __OPT_ON_MATCH = true;
static bool __OPT_ON_ARITH = true;
struct OPTS_t {
    bool conditional_spec = false;
    bool lens = true;
};

extern struct OPTS_t OPTS;