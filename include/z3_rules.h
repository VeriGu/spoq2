#pragma once

#include <z3++.h>
#include <nodes.h>
#include <values.h>
#include <rules.h>


namespace autov {

using autov::Bool;
using autov::BoolConst;
using autov::Expr;
using autov::Function;
using autov::Int;
using autov::IntConst;
using autov::SpecType;
using autov::StringConst;
using autov::Struct;

using std::set;
using std::sort;
using std::unordered_map;
using std::vector;

class EvalState {
public:
    shared_ptr<unordered_map<string, shared_ptr<SpecValue>>> vars;
    shared_ptr<vector<z3::expr>> conds;

    EvalState() {
        vars = make_shared<unordered_map<string, shared_ptr<SpecValue>>>();
        conds = make_shared<vector<z3::expr>>();
    }

    EvalState(shared_ptr<unordered_map<string, shared_ptr<SpecValue>>> vars) {
        this->vars = vars;
        conds = make_shared<vector<z3::expr>>();
    }

    EvalState(shared_ptr<vector<z3::expr>> conds) {
        vars = make_shared<unordered_map<string, shared_ptr<SpecValue>>>();
        this->conds = conds;
    }

    EvalState(shared_ptr<unordered_map<string, shared_ptr<SpecValue>>> vars, shared_ptr<vector<z3::expr>> conds) {
        this->vars = vars;
        this->conds = conds;
    }

    shared_ptr<EvalState> copy() {
        auto vars = make_shared<unordered_map<string, shared_ptr<SpecValue>>>(*this->vars);
        auto conds = make_shared<vector<z3::expr>>(*this->conds);
        return make_shared<EvalState>(vars, conds);
    }
};

enum class Z3Result {
    True,
    False,
    Unknown
};

// timeout 1000: Z3 unknowns: 4384
// timeout 100: Z3 unknowns: 4385, Z3 accumulative time: 99.2414 (s)
// timeout 50: Z3 unknowns: 4384, Z3 accumulative time: 58.9793 (s)
// timeout 25: Z3 unknowns: 4384
// timeout 13: Z3 unknowns: 4391, Z3 accumulative time: 30.1244 (s)
#define Z3_TIMEOUT 200
Z3Result z3_check(std::shared_ptr<EvalState> state, z3::expr cond, int timeout=Z3_TIMEOUT);
Z3Result z3_check(shared_ptr<EvalState> state, int timeout=Z3_TIMEOUT);
shared_ptr<SpecValue> z3_eval(Project* proj, SpecNode* val, shared_ptr<EvalState> state);
rule_ret_t rule_simple_by_z3(Project* proj, SpecNode* spec, shared_ptr<EvalState> state);

static inline bool op_eq(std::variant<unique_ptr<SpecNode>, Expr::ops, Expr::binops, string>& val,
                  std::variant<unique_ptr<SpecNode>, Expr::ops, Expr::binops, string> op) {
    return val == op;
}
} // namespace autov