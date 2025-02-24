#include "nodes.h"
#include <memory>
#include <shortcuts.h>
#include <values.h>

namespace autov {
SpecNode* _Let(string name, SpecNode* val, SpecNode* body) {
    auto vec = new vector<unique_ptr<PatternMatch>>();
    vec->push_back(make_unique<PatternMatch>(make_unique<Symbol>(name), unique_ptr<SpecNode>(body)));
    return new Match(unique_ptr<SpecNode>(val), unique_ptr<vector<unique_ptr<PatternMatch>>>(vec));
}

SpecNode* _When(SpecNode* pat, SpecNode* val, SpecNode* body) {
    auto somepat = new vector<unique_ptr<SpecNode>>();
    somepat->push_back(unique_ptr<SpecNode>(pat));
    PatternMatch *some = new PatternMatch(make_unique<Expr>(Expr::ops::Some, unique_ptr<vector<unique_ptr<SpecNode>>>(somepat)), unique_ptr<SpecNode>(body));
    PatternMatch *none = new PatternMatch(make_unique<Expr>(Expr::ops::None, make_unique<vector<unique_ptr<SpecNode>>>()), unique_ptr<SpecNode>(new Symbol("None")));

    auto pats = new vector<unique_ptr<PatternMatch>>();
    pats->push_back(unique_ptr<PatternMatch>(some));
    pats->push_back(unique_ptr<PatternMatch>(none));
    return new Match(unique_ptr<SpecNode>(val), unique_ptr<vector<unique_ptr<PatternMatch>>>(pats));
}

SpecNode* _Some(SpecNode* val) {
    auto vec = new vector<unique_ptr<SpecNode>>();
    vec->push_back(unique_ptr<SpecNode>(val));
    return new Expr(Expr::ops::Some, unique_ptr<vector<unique_ptr<SpecNode>>>(vec));
}

SpecNode* _Tuple(vector<unique_ptr<SpecNode>> *vec) {
    return new Expr(Expr::ops::Tuple, unique_ptr<vector<unique_ptr<SpecNode>>>(vec));
}

SpecNode* _List(vector<unique_ptr<SpecNode>> *vec) {
    return new Expr("List", unique_ptr<vector<unique_ptr<SpecNode>>>(vec));
}

SpecNode* _st(shared_ptr<SpecType> abs_data) {
    return new Symbol("st", abs_data);
}

SpecNode* _init_st(shared_ptr<SpecType> abs_data) {
    return new Symbol("init_st", abs_data);
}

SpecNode* _name(string name, unordered_map<string, shared_ptr<SpecType>> *types) {
    if (!types) {
        return new Symbol(name, autov::SpecType::UNKNOWN_TYPE);
    }

    if(types->find(name) != types->end()) {
        return new Symbol(name, (*types)[name]);
    } else {
        return new Symbol(name, autov::SpecType::UNKNOWN_TYPE);
    }
}

unique_ptr<SpecNode> Shortcut::_Some_u(unique_ptr<SpecNode> val) {
    auto vec = std::make_unique<vector<unique_ptr<SpecNode>>>();
    vec->push_back(std::move(val));
    auto expr = make_unique<Expr>(Expr::ops::Some, std::move(vec));
    return std::move(expr);
}

unique_ptr<SpecNode> Shortcut::_Tuple_u(unique_ptr<vector<unique_ptr<SpecNode>>> vec) {
    return make_unique<Expr>(Expr::ops::Tuple, std::move(vec));
}

unique_ptr<SpecNode> Shortcut::_Let_u(unique_ptr<SpecNode> sym, unique_ptr<SpecNode> val, unique_ptr<SpecNode> body) {
    auto vec = std::make_unique<vector<unique_ptr<PatternMatch>>>();
    vec->push_back(make_unique<PatternMatch>(std::move(sym), std::move(body)));
    return std::make_unique<Match>(std::move(val), std::move(vec));
}

unique_ptr<SpecNode> Shortcut::_When_u(unique_ptr<SpecNode> pat, unique_ptr<SpecNode> val, unique_ptr<SpecNode> body) {
    auto somepat = std::make_unique<vector<unique_ptr<SpecNode>>>();
    somepat->push_back(std::move(pat));

    auto none_symbol = make_unique<Symbol>("None");
    unique_ptr<PatternMatch> none = make_unique<PatternMatch>(
        make_unique<Expr>(Expr::ops::None, make_unique<vector<unique_ptr<SpecNode>>>()),
        std::move(none_symbol));

    unique_ptr<PatternMatch> some = make_unique<PatternMatch>(make_unique<Expr>(Expr::ops::Some, std::move(somepat)), std::move(body));

    auto pats = make_unique<vector<unique_ptr<PatternMatch>>>();

    pats->push_back(std::move(some));
    pats->push_back(std::move(none));

    return make_unique<Match>(std::move(val), std::move(pats));
}


}