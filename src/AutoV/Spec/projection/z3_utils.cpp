#include <nodes.h>
#include <any>
#include <shortcuts.h>
#include <variant>
#include <unordered_set>
#include <log.h>
#include <boost/range/algorithm/set_algorithm.hpp>
#include <project.h>
#include <algorithm>
#include <boost/functional/hash.hpp>
#include <nodes.h>
#include <values.h>
#include <z3_rules.h>
#include <utils.h>


namespace autov
{
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

z3::solver Z3Solver = z3::solver(z3ctx);

unordered_map<size_t, Z3Result> Z3Cache;

size_t hash_unsigned_vector(const vector<unsigned> &v) {
    size_t hash = 0;
    for (const auto &i : v) {
        boost::hash_combine(hash, i);
    }
    return hash;
}

size_t hash_z3_state(std::shared_ptr<EvalState> state, z3::expr cond, int timeout) {
    std::vector<unsigned> hashes;
    for (auto &c : *state->conds) {
        hashes.push_back(c);
    }
    sort(hashes.begin(), hashes.end());
    hashes.push_back(cond.hash());
    hashes.push_back(timeout);
    return hash_unsigned_vector(hashes);
}

int complexity(shared_ptr<SpecNode> spec) {
    return spec->length;
}

Z3Result z3_check(shared_ptr<EvalState> state, z3::expr cond, int timeout) {
    auto hash = hash_z3_state(state, cond, 1000);
    if (Z3Cache.find(hash) != Z3Cache.end()) {
        return Z3Cache[hash];
    }
    Z3Solver.push();
    Z3Solver.add(cond);
    auto res = Z3Solver.check();
    Z3Solver.pop();
    if (res == z3::sat) {
        Z3Cache[hash] = Z3Result::True;
        return Z3Result::True;
    } else if (res == z3::unsat) {
        Z3Cache[hash] = Z3Result::False;
        return Z3Result::False;
    } else {
        Z3Cache[hash] = Z3Result::Unknown;
        return Z3Result::Unknown;
    }
}

shared_ptr<SpecValue> resolve_pattern(Project* proj, SpecNode* val, SpecNode* pat, shared_ptr<SpecValue> src,
                                      unordered_map<string, shared_ptr<SpecValue>> &vars,
                                      unordered_map<string, shared_ptr<SpecValue>> &assigns)
{
    auto typ = src->get_type();
    if (auto sym = instance_of(pat, Symbol)) {
        if (proj->is_ind_constr(sym->text)) {
            return dynamic_pointer_cast<Inductive>(typ)->construct(sym->text, {});
        }
        else {
            vars[sym->text] = typ->declare(sym->text, val->nid);
            assigns[sym->text] = src;
            return vars[sym->text];
        }
    } else if (auto con = instance_of(pat, Const)) {
        if (auto intc = std::get_if<long long>(&con->value)) {
            return make_shared<IntValue>(*intc);
        } else if (auto boolc = std::get_if<bool>(&con->value)) {
            return make_shared<BoolValue>(*boolc);
        } else if (auto strc = std::get_if<string>(&con->value)) {
            return make_shared<StringValue>(*strc);
        }
    }
    else if (auto expr = instance_of(pat, Expr))
    {
        if (op_eq(expr->op, "Some"))
        {
            auto v = resolve_pattern(proj, val, expr->elems->at(0).get(), dynamic_pointer_cast<IndValue>(src)->get("value"), vars, assigns);
            return dynamic_pointer_cast<Inductive>(typ)->construct("Some", {v});
        }
        else if (op_eq(expr->op, "Tuple"))
        {
            vector<shared_ptr<SpecValue>> elems;
            for (int i = 0; i < expr->elems->size(); i++)
            {
                elems.push_back(resolve_pattern(proj, val, expr->elems->at(i).get(), dynamic_pointer_cast<StructValue>(src)->get(i), vars, assigns));
            }
            return dynamic_pointer_cast<Struct>(typ)->construct(elems);
        }
        else if (op_eq(expr->op, "::"))
        {
            auto head = resolve_pattern(proj, val, expr->elems->at(0).get(), dynamic_pointer_cast<IndValue>(src)->get("head"), vars, assigns);
            auto tail = resolve_pattern(proj, val, expr->elems->at(1).get(), dynamic_pointer_cast<IndValue>(src)->get("tail"), vars, assigns);
            return dynamic_pointer_cast<Inductive>(typ)->construct("cons", {head, tail});
        }
        else
        {
            throw std::runtime_error("Unknown pattern: " + pat->operator std::string());
        }
    }
    else
    {
        throw std::runtime_error("Unknown pattern: " + pat->operator std::string());
    }
}

shared_ptr<SpecValue> z3_eval(Project* proj, SpecNode* val, shared_ptr<EvalState> state) {

    std::cout << "z3_eval: " << val->operator std::string() << std::endl;

    if (val->cached_eval) return val->cached_eval;

    auto _cache = [&](shared_ptr<SpecValue> return_val) {
        val->set_z3_eval(return_val);
        return return_val;
    };

    if (auto sym = instance_of(val, Symbol)) {
        if (sym->text != "None" && sym->text != "nil" && state->vars->find(sym->text) != state->vars->end()) {
            return _cache(state->vars->at(sym->text));
        } else if (proj->defs.find(sym->text) != proj->defs.end()) {
            auto df = proj->defs[sym->text].get();
            assert(df->args->size() == 0);
            if (auto c = instance_of(df->body.get(), Const)) {
                return _cache(z3_eval(proj, c, state));
            } else {
                return _cache(df->absf->call({}));
            }
        } else if (proj->decls.find(sym->text) != proj->decls.end()) {
            auto decl = proj->decls[sym->text].get();
            assert(!dynamic_pointer_cast<Function>(decl->type));
            return _cache(decl->absf->call({}));
        } else if (proj->is_ind_constr(sym->text)) {
            return _cache(dynamic_pointer_cast<Inductive>(sym->get_type())->construct(sym->text, {}));
        } else if (proj->symbols.find(sym->text) != proj->symbols.end() &&
                   proj->symbols[sym->text].kind == SymbolKind::StructElem) {
            return _cache(make_shared<StringValue>(sym->text));
        } else {
            throw std::runtime_error("Unknown symbol: " + sym->text);
        }
    } else if (auto con = instance_of(val, Const)) {
        if (auto intc = std::get_if<long long>(&con->value)) {
            return make_shared<IntValue>(*intc);
        } else if (auto boolc = std::get_if<bool>(&con->value)) {
            return make_shared<BoolValue>(*boolc);
        } else if (auto strc = std::get_if<string>(&con->value)) {
            return make_shared<StringValue>(*strc);
        }
    } else if (auto expr = instance_of(val, Expr)) {
        vector<shared_ptr<SpecValue>> elems;
        for (auto e = expr->elems->begin(); e != expr->elems->end(); e++) {
            elems.push_back(z3_eval(proj, e->get(), state));
        }
        if (op_eq(expr->op, Expr::binops::ADD)) return _cache(dynamic_pointer_cast<IntValue>(elems[0])->add(dynamic_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::MINUS)) return _cache(dynamic_pointer_cast<IntValue>(elems[0])->sub(dynamic_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, Expr::ops::NEG)) return _cache(dynamic_pointer_cast<IntValue>(elems[0])->neg());
        if (op_eq(expr->op, Expr::binops::MULT)) return _cache(dynamic_pointer_cast<IntValue>(elems[0])->mul(dynamic_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::DIV)) return _cache(dynamic_pointer_cast<IntValue>(elems[0])->div(dynamic_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::MOD)) return _cache(dynamic_pointer_cast<IntValue>(elems[0])->mod(dynamic_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::LSHIFT)) return _cache(dynamic_pointer_cast<IntValue>(elems[0])->shiftl(dynamic_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::RSHIFT)) return _cache(dynamic_pointer_cast<IntValue>(elems[0])->shiftr(dynamic_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::BAND)) return _cache(dynamic_pointer_cast<IntValue>(elems[0])->land(dynamic_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::BOR)) return _cache(dynamic_pointer_cast<IntValue>(elems[0])->lor(dynamic_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, "Z.lxor")) return _cache(dynamic_pointer_cast<IntValue>(elems[0])->lxor(dynamic_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, "Z.lnot")) return _cache(dynamic_pointer_cast<IntValue>(elems[0])->lnot());
        if (op_eq(expr->op, "Z.testbit")) return _cache(dynamic_pointer_cast<IntValue>(elems[0])->testbit(dynamic_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, "Z.setbit")) return _cache(dynamic_pointer_cast<IntValue>(elems[0])->setbit(dynamic_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, "Z.clearbit")) return _cache(dynamic_pointer_cast<IntValue>(elems[0])->clearbit(dynamic_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, "Z.xorb")) return _cache(dynamic_pointer_cast<IntValue>(elems[0])->xorb(dynamic_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::EQUAL)) return _cache(Prop::PROP->from_z3_value(elems[0]->get_z3_value() == elems[1]->get_z3_value()));
        if (op_eq(expr->op, Expr::binops::BEQ)) return _cache(dynamic_pointer_cast<IntValue>(elems[0])->eq(dynamic_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::SEQ)) return _cache(dynamic_pointer_cast<StringValue>(elems[0])->eq(dynamic_pointer_cast<StringValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::NOT_EQUAL)) return _cache(Prop::PROP->from_z3_value(elems[0]->get_z3_value() != elems[1]->get_z3_value()));
        if (op_eq(expr->op, Expr::binops::BNE)) return _cache(dynamic_pointer_cast<IntValue>(elems[0])->ne(dynamic_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::SNE)) return _cache(dynamic_pointer_cast<StringValue>(elems[0])->ne(dynamic_pointer_cast<StringValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::GT) || op_eq(expr->op, Expr::binops::BGT)) return _cache(dynamic_pointer_cast<IntValue>(elems[0])->gt(dynamic_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::GTE) || op_eq(expr->op, Expr::binops::BGE)) return _cache(dynamic_pointer_cast<IntValue>(elems[0])->ge(dynamic_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::LT) || op_eq(expr->op, Expr::binops::BLT)) return _cache(dynamic_pointer_cast<IntValue>(elems[0])->lt(dynamic_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::LTE) || op_eq(expr->op, Expr::binops::BLE)) return _cache(dynamic_pointer_cast<IntValue>(elems[0])->le(dynamic_pointer_cast<IntValue>(elems[1])));
        if (op_eq(expr->op, Expr::ops::NOT) || op_eq(expr->op, Expr::ops::BNOT)) return _cache(dynamic_pointer_cast<BoolValue>(elems[0])->negb());
        if (op_eq(expr->op, Expr::binops::AND) || op_eq(expr->op, Expr::binops::BAND)) return _cache(dynamic_pointer_cast<BoolValue>(elems[0])->andb(dynamic_pointer_cast<BoolValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::BOR) || op_eq(expr->op, Expr::binops::OR)) return _cache(dynamic_pointer_cast<BoolValue>(elems[0])->orb(dynamic_pointer_cast<BoolValue>(elems[1])));
        if (op_eq(expr->op, Expr::binops::IMPLIES)) return _cache(dynamic_pointer_cast<BoolValue>(elems[0])->implies(dynamic_pointer_cast<BoolValue>(elems[1])));
        else if (op_eq(expr->op,  "ZMap.get")) {
            if (auto e = instance_of(expr->elems->at(0).get(), Expr)) {
                if (op_eq(e->op, "ZMap.set")) {
                    auto z3_res = z3_check(state, z3_eval(proj, e->elems->at(1).get(), state)->get_z3_value() == elems[1]->get_z3_value());
                    if (z3_res == Z3Result::True) {
                        return _cache(z3_eval(proj, e->elems->at(2).get(), state));
                    } else if (z3_res == Z3Result::False) {
                        return _cache(dynamic_pointer_cast<ZMapValue>(z3_eval(proj, e->elems->at(0).get(), state))->get(dynamic_pointer_cast<IntValue>(elems[1])));
                    }
                }
            }
            return _cache(dynamic_pointer_cast<ZMapValue>(elems[0])->get(dynamic_pointer_cast<IntValue>(elems[1])));
        } else if (op_eq(expr->op, "ZMap.set")) {
            if (auto e = instance_of(expr->elems->at(0).get(), Expr)) {
                if (op_eq(e->op, "ZMap.set")) {
                    auto z3_res = z3_check(state, z3_eval(proj, e->elems->at(1).get(), state)->get_z3_value() == elems[1]->get_z3_value());
                    if (z3_res == Z3Result::True) {
                        elems[0] = z3_eval(proj, e->elems->at(0).get(), state);
                    }
                }
            }
            return _cache(dynamic_pointer_cast<ZMapValue>(elems[0])->set(dynamic_pointer_cast<IntValue>(elems[1]), elems[2]));
        // Record.get
        // Record.set
        }
        
        else if (op_eq(expr->op, Expr::binops::APPEND)) return _cache(dynamic_pointer_cast<List>(val->get_type())->construct("cons", {elems[0]}));
        else if (op_eq(expr->op, Expr::binops::CONCAT)) return _cache(dynamic_pointer_cast<IndValue>(elems[0])->concat(dynamic_pointer_cast<IndValue>(elems[1])));
        else if (op_eq(expr->op, Expr::ops::Some)) return _cache(dynamic_pointer_cast<Option>(val->get_type())->construct("Some", {elems[0]}));
        else if (op_eq(expr->op,Expr::ops::Tuple)) return _cache(dynamic_pointer_cast<Tuple>(val->get_type())->construct(elems));
        else if (op_eq(expr->op, "prop")) return _cache(elems[0]);
        else if (op_eq(expr->op,"ptr_to_int")) return _cache(dynamic_pointer_cast<FuncValue>(autov::ptr_to_int())->call(elems));
        else if (op_eq(expr->op,"int_to_ptr")) return _cache(dynamic_pointer_cast<FuncValue>(autov::int_to_ptr())->call(elems));
        else if (op_eq(expr->op, "z_to_nat")) return _cache(dynamic_pointer_cast<FuncValue>(autov::z_to_nat())->call(elems));
        else if (op_eq(expr->op,"zmap_init") || op_eq(expr->op, "ZMap.init")) return _cache(val->get_type()->from_z3_value(z3::const_array(z3ctx.int_sort(), elems[0]->get_z3_value())));
        
        else if (std::holds_alternative<unique_ptr<SpecNode>>(expr->op)) {
            if (auto sym = instance_of(std::get<unique_ptr<SpecNode>>(expr->op).get(), Symbol)) {
                auto info = proj->symbols[sym->text];
                if (info.kind == SymbolKind::StructConstr) {
                    return _cache(dynamic_pointer_cast<Struct>(val->get_type())->construct(elems));
                } else if (info.kind == SymbolKind::IndConstructor) {
                    return _cache(dynamic_pointer_cast<Inductive>(val->get_type())->construct(sym->text, elems));
                } else if (info.kind == SymbolKind::Def) {
                    auto df = proj->defs[sym->text].get();
                    return _cache(df->absf->call(elems));
                } else if (info.kind == SymbolKind::Decl) {
                    auto df = proj->decls[sym->text].get();
                    return _cache(df->absf->call(elems));
                } else {
                    throw std::runtime_error("Unsupported");
                }
            } else {
                auto op = z3_eval(proj, std::get<unique_ptr<SpecNode>>(expr->op).get(), state);
                if (auto func = dynamic_pointer_cast<FuncValue>(op)) {
                    return _cache(func->call(elems));
                }
            }
        }
    } else if (auto match = instance_of(val, Match)) {
        auto src = z3_eval(proj, match->src.get(), state);
        shared_ptr<SpecValue> match_val = nullptr;
        for (auto pm = match->match_list->rbegin(); pm != match->match_list->rend(); pm++) {
            unordered_map<string, shared_ptr<SpecValue>> vars;
            unordered_map<string, shared_ptr<SpecValue>> assigns;
            auto pat = resolve_pattern(proj, val, (*pm)->pattern.get(), src, vars, assigns);
            auto cond = pat->get_z3_value() == src->get_z3_value();
            for (auto v = vars.begin(); v != vars.end(); v++) {
                cond = z3::exists(v->second->get_z3_value(), cond);
            }
            auto z3_res = z3_check(state, cond);
            if (z3_res == Z3Result::False) continue;
            auto new_state = state->copy();
            for (auto v = assigns.begin(); v != assigns.end(); v++) {
                new_state->vars->emplace(v->first, v->second);
            }
            if (match_val == nullptr) {
                match_val = z3_eval(proj, (*pm)->body.get(), new_state);
            } else {
                auto then_val = z3_eval(proj, (*pm)->body.get(), new_state);
                match_val = match_val->get_type()->from_z3_value(z3::ite(cond, then_val->get_z3_value(), match_val->get_z3_value()));
            }
        }
        if (match_val == nullptr) {
            auto opt = dynamic_pointer_cast<Option>(val->get_type());
            return _cache(opt->construct("None", {}));
        } else {
            return _cache(match_val);
        }
    } else if (auto rely = instance_of(val, Rely)) {
        auto cond = z3_eval(proj, rely->prop.get(), state);
        auto res = z3_check(state, cond->get_z3_value());
        if (res == Z3Result::Unknown) {
            auto body = z3_eval(proj, rely->body.get(), state);
            auto none = dynamic_pointer_cast<Option>(val->get_type())->construct("None", {});
            auto z3_val = z3::ite(cond->get_z3_value(), body->get_z3_value(), none->get_z3_value());
            return _cache(rely->get_type()->from_z3_value(z3_val.simplify()));
        } else if (res == Z3Result::True) {
            return _cache(z3_eval(proj, rely->body.get(), state));
        } else {
            return _cache(dynamic_pointer_cast<Option>(val->get_type())->construct("None", {}));
        }
    }
    else if (auto iff = instance_of(val, If))
    {
        auto c = z3_eval(proj, iff->cond.get(), state);
        auto res = z3_check(state, c->get_z3_value());
        if (res == Z3Result::Unknown)
        {
            auto true_state = state->copy();
            true_state->conds->push_back(c->get_z3_value());
            auto True = z3_eval(proj, iff->then_body.get(), true_state);
            auto false_state = state->copy();
            false_state->conds->push_back(!c->get_z3_value());
            auto False = z3_eval(proj, iff->else_body.get(), false_state);
            auto z3_val = z3::ite(c->get_z3_value(), True->get_z3_value(), False->get_z3_value());
            return _cache(iff->get_type()->from_z3_value(z3_val.simplify()));
        }
        else if (res == Z3Result::True)
        {
            state->conds->push_back(c->get_z3_value());
            return _cache(z3_eval(proj, iff->then_body.get(), state));
        }
        else
        {
            state->conds->push_back(!c->get_z3_value());
            return _cache(z3_eval(proj, iff->else_body.get(), state));
        }
    }
    else if (auto forall = instance_of(val, Forall))
    {
        z3::expr_vector vars(z3ctx);
        for (auto v = forall->vars->begin(); v != forall->vars->end(); v++)
        {
            auto var = (*v)->type->declare((*v)->name, val->nid);
            state->vars->emplace((*v)->name, var);
            vars.push_back(var->get_z3_value());
        }
        auto body = z3_eval(proj, forall->body.get(), state);
        return _cache(make_shared<BoolValue>(z3::forall(vars, body->value)));
    }
    else if (auto exsts = instance_of(val, Exists))
    {
        z3::expr_vector vars(z3ctx);
        for (auto v = exsts->vars->begin(); v != exsts->vars->end(); v++)
        {
            auto var = (*v)->type->declare((*v)->name, val->nid);
            state->vars->emplace((*v)->name, var);
            vars.push_back(var->get_z3_value());
        }
        auto body = z3_eval(proj, exsts->body.get(), state);
        return _cache(make_shared<BoolValue>(z3::exists(vars, body->value)));
    }
    else
    {
        std::cout << val->operator std::string() << std::endl;
        throw std::runtime_error("Unknown node type: " + val->operator std::string());
    }
}

} // namespace autov

