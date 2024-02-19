#pragma once

#include <z3/z3++.h>
#include <nodes.h>
#include <values.h>


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
    shared_ptr<unordered_map<string, SpecValue>> vars;
    shared_ptr<vector<z3::expr>> conds;

    EvalState() {
        vars = make_shared<unordered_map<string, SpecValue>>();
        conds = make_shared<vector<z3::expr>>();
    }

    EvalState(shared_ptr<unordered_map<string, SpecValue>> vars) {
        this->vars = vars;
        conds = make_shared<vector<z3::expr>>();
    }

    EvalState(shared_ptr<vector<z3::expr>> conds) {
        vars = make_shared<unordered_map<string, SpecValue>>();
        this->conds = conds;
    }

    EvalState(shared_ptr<unordered_map<string, SpecValue>> vars, shared_ptr<vector<z3::expr>> conds) {
        this->vars = vars;
        this->conds = conds;
    }

    shared_ptr<EvalState> copy() {
        auto vars = make_shared<unordered_map<string, SpecValue>>(*this->vars);
        auto conds = make_shared<vector<z3::expr>>(*this->conds);
        return make_shared<EvalState>(vars, conds);
    }
};

enum class Z3Result {
    True,
    False,
    Unknown
};


Z3Result z3_check(std::shared_ptr<EvalState> state, z3::expr cond=z3ctx.bool_val(true), int timeout=100);
shared_ptr<SpecValue> z3_eval(Project* proj, SpecNode* val, shared_ptr<EvalState> state);

} // namespace autov