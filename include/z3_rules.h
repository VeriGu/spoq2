#pragma once

#include <z3++.h>
#include <nodes.h>
#include <values.h>
#include <rules.h>
#include <profile.h>
#include <symbolic.h>
#include <cmd.h>

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
    virtual ~EvalState() = default; // Make the class polymorphic

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

class ProveState : public EvalState {
public: 
    /** We separate the branch conditions (EvalState.conds) and 
     *              the inductive RData conditions (ProveState.inductions) to
     *      1. reduce quantifier instantiation cost
     * by Ganxiang Yang, Feb 10, 2025
     */
    shared_ptr<vector<z3::expr>> inductions;

    ProveState() {
        vars = make_shared<unordered_map<string, shared_ptr<SpecValue>>>();
        conds = make_shared<vector<z3::expr>>();
        inductions = make_shared<vector<z3::expr>>();
    }

    ProveState(shared_ptr<unordered_map<string, shared_ptr<SpecValue>>>& vars, shared_ptr<vector<z3::expr>>& conds, shared_ptr<vector<z3::expr>>& inductions) {
        this->vars = vars;
        this->conds = conds;
        this->inductions = inductions;
    }

    shared_ptr<ProveState> copy() {
        auto vars = make_shared<unordered_map<string, shared_ptr<SpecValue>>>(*this->vars);
        auto conds = make_shared<vector<z3::expr>>(*this->conds);
        auto inductions = make_shared<vector<z3::expr>>(*this->inductions);
        return make_shared<ProveState>(vars, conds, inductions);
    }

    void add_induction(z3::expr cond) {
        if (OPTS.__OPT_ON_INDUCTION) {
            this->inductions->push_back(cond);
        } else {
            this->conds->push_back(cond);
        }
    }

    void add_branch_cond(z3::expr cond) {
        this->conds->push_back(cond);
    } 

};

enum class Z3Result {
    True, //!cond unsat
    False, //cond unsat
    Sat, //!cond sat
    Unknown
};

#define Z3_TIMEOUT 1
#define Z3_VERIFY_TIMEOUT 5000
#define Z3_SIMULATE_TIMEOUT 500
#define Z3_SOLVE_RDATA_TIMEOUT 2000
#define Z3_SOLVE_SECURE_TIMEOUT 50
extern unordered_map<size_t, Z3Result> Z3Cache;
Z3Result z3_verify(shared_ptr<ProveState> state, z3::expr cond, QueryInfo *qinfo, int timeout = Z3_VERIFY_TIMEOUT);
Z3Result z3_verify_state_sat(shared_ptr<ProveState> state, QueryInfo *qinfo, int timeout = Z3_VERIFY_TIMEOUT);
Z3Result z3_check(std::shared_ptr<EvalState> state, z3::expr cond, int timeout=Z3_TIMEOUT);
Z3Result z3_check(shared_ptr<EvalState> state, int timeout=Z3_TIMEOUT);
Z3Result z3_check_unsat(std::shared_ptr<ProveState> state, z3::expr cond, z3::model& model, QueryInfo *qinfo, int timeout=Z3_TIMEOUT);
shared_ptr<SpecValue> z3_eval(Project* proj, SpecNode* val, shared_ptr<EvalState> state, bool check_loop = false);
shared_ptr<SpecValue> z3_eval(Project* proj, SpecNode* val, shared_ptr<EvalState> state, bool check_loop, bool unfold, set<string>& used_fixpoint);
rule_ret_t rule_simple_by_z3(Project* proj, SpecNode* spec, shared_ptr<EvalState> state);
void resolve_pattern(Project* proj, SpecNode* spec, SpecNode* pat, shared_ptr<SpecValue> src, shared_ptr<EvalState> state);
shared_ptr<SpecValue> resolve_pattern(Project* proj, SpecNode* val, SpecNode* pat, shared_ptr<SpecValue> src,
                                      unordered_map<string, shared_ptr<SpecValue>> &vars,
                                      unordered_map<string, shared_ptr<SpecValue>> &assigns);
bool check_loop_inv(Project* proj, Definition *loop);
bool check_invariant(Project* proj, Definition* prim, SpecNode* inv);
unique_ptr<SpecNode> formulate_loop_invariant(Project* proj, string fname, vector<unique_ptr<SpecNode>>* args);
unique_ptr<SpecNode> formulate_preserved_function(Project* proj, string fname);
unique_ptr<SpecNode> formulate_post_condition(Project* proj, string fname, vector<unique_ptr<SpecNode>>* args);
void symbolic(Project* proj, SpecNode* val, shared_ptr<EvalState> state, vector<std::pair<shared_ptr<SpecValue>, shared_ptr<EvalState>>>& states);
unsigned long length_of_exp(SpecNode* spec);
static inline bool op_eq(std::variant<unique_ptr<SpecNode>, Expr::ops, Expr::binops, string>& val,
                  std::variant<unique_ptr<SpecNode>, Expr::ops, Expr::binops, string> op) {
    return val == op;
}

} // namespace autov