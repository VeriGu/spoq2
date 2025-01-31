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
    True, //!cond unsat
    False, //cond unsat
    Sat, //!cond sat
    Unknown
};
/*
simple_if_by_z3 timeout 2000:
18:14:35 [INF]: Z3 unknowns: 7651/11677
18:14:35 [INF]: Z3 cache hits: 1330/11677
18:14:35 [INF]: Z3 accumulative time: 671.194 (s)
build/spoq testcase/proof_debug_of.v  683.27s user 2.70s system 100% cpu 11:25.72 total
*/

/*
simple_if_by_z3 timeout 50:
18:35:13 [INF]: Z3 unknowns: 7199/11227
18:35:13 [INF]: Z3 cache hits: 1780/11227
18:35:13 [INF]: Z3 accumulative time: 304.648 (s)
build/spoq testcase/proof_debug_of.v  316.46s user 1.86s system 100% cpu 5:18.22 total
*/

#define Z3_TIMEOUT 50
Z3Result z3_check(std::shared_ptr<EvalState> state, z3::expr cond, int timeout=Z3_TIMEOUT);
Z3Result z3_check(shared_ptr<EvalState> state, int timeout=Z3_TIMEOUT);
Z3Result z3_check_unsat(std::shared_ptr<EvalState> state, z3::expr cond, z3::model& model, int timeout=Z3_TIMEOUT);
shared_ptr<SpecValue> z3_eval(Project* proj, SpecNode* val, shared_ptr<EvalState> state, bool add_loop_post = false, bool check_loop = false);
rule_ret_t rule_simple_by_z3(Project* proj, SpecNode* spec, shared_ptr<EvalState> state);
void resolve_pattern(Project* proj, SpecNode* spec, SpecNode* pat, shared_ptr<SpecValue> src, shared_ptr<EvalState> state);
shared_ptr<SpecValue> resolve_pattern(Project* proj, SpecNode* val, SpecNode* pat, shared_ptr<SpecValue> src,
                                      unordered_map<string, shared_ptr<SpecValue>> &vars,
                                      unordered_map<string, shared_ptr<SpecValue>> &assigns);
bool check_loop_inv(Project* proj, Definition *loop);
bool check_invariant(Project* proj, Definition* prim, SpecNode* inv);
SpecNode* formulate_loop_invariant(Project* proj, string fname, vector<unique_ptr<SpecNode>>* args);
void symbolic(Project* proj, SpecNode* val, shared_ptr<EvalState> state, vector<std::pair<shared_ptr<SpecValue>, shared_ptr<EvalState>>>& states);
unsigned long length_of_exp(SpecNode* spec);
static inline bool op_eq(std::variant<unique_ptr<SpecNode>, Expr::ops, Expr::binops, string>& val,
                  std::variant<unique_ptr<SpecNode>, Expr::ops, Expr::binops, string> op) {
    return val == op;
}
} // namespace autov