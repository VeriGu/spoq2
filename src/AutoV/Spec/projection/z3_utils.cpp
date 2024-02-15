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
#include <z3_utils.h>


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

unordered_map<string, bool> Z3Cache;

unsigned hash_unsigned_vector(const vector<unsigned> &v) {
    unsigned hash = 0;
    for (auto &i : v) {
        boost::hash_combine(hash, i);
    }
    return hash;
}

unsigned hash_z3_state(std::shared_ptr<EvalState> state, z3::expr cond, int timeout) {
    std::vector<unsigned> hashes;
    for (auto &c : state->conds) {
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

SpecValue& cache(shared_ptr<SpecNode> spec, SpecValue &value) {
    spec->set_z3_eval(value);
    return value;
}

Z3Result z3_check(shared_ptr<EvalState> state, z3::expr cond=z3ctx.bool_val(true), int timeout=100) {
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

/*
def resolve_pattern(pat: SpecNode, src: SpecValue, vars: dict[str, SpecValue], assigns: dict[str, SpecValue]) -> SpecValue:
    typ = src.get_type()
    if isinstance(pat, Symbol):
        if proj.is_ind_constr(pat.text):
            return typ.construct(pat.text, [])
        else:
            assert(not proj.is_known_symbol(pat.text))
            vars[pat.text] = typ.declare(pat.text, val.nid)
            assigns[pat.text] = src
            return vars[pat.text]
    elif isinstance(pat, Const):
        return pat.get_value()
    elif isinstance(pat, Expr):
        if pat.op == "Some":
            v = resolve_pattern(pat.elems[0], src.get("value"), vars, assigns)
            return typ.construct("Some", [v])
        elif pat.op == "Tuple":
            elems = [resolve_pattern(pat.elems[i], src.get(i), vars, assigns) for i in range(len(pat.elems))]
            return typ.construct(elems)
        elif pat.op == "::":
            head = resolve_pattern(pat.elems[0], src.get("head"), vars, assigns)
            tail = resolve_pattern(pat.elems[1], src.get("tail"), vars, assigns)
            return typ.construct("cons", [head, tail])
        elif proj.get_indtype_by_constr(pat.op) is not None:
            args = []
            for i, arg in enumerate(typ.constr[pat.op]):
                args.append(resolve_pattern(pat.elems[i], src.get(arg.name), vars, assigns))
            return typ.construct(pat.op, args)
        else:
            raise Exception("Unknown pattern: " + str(pat))
    else:
        raise Exception("Unknown pattern: " + str(pat))
*/

SpecValue resolve_pattern(SpecNode* pat, SpecValue* src, unordered_map<string, SpecValue> *vars, unordered_map<string, SpecValue> *assigns)
{
    auto typ = src->get_type();
    if (auto sym = dynamic_pointer_cast<Symbol>(pat)) {
        if (proj->is_ind_constr(sym->text)) {
            return typ->construct(sym->text, {});
        } else {
            assert(proj->is_known_symbol(sym->text));
            (*vars)[sym->text] = typ->declare(sym->text, val.nid);
            (*assigns)[sym->text] = src;
            return (*vars)[sym->text];
        }
    } else if (auto c = dynamic_pointer_cast<Const>(pat)) {
        return c->get_value();
    } else if (auto expr = dynamic_pointer_cast<Expr>(pat)) {
        if (expr->op == "Some") {
            auto v = resolve_pattern(expr->elems[0], src->get("value"), vars, assigns);
            return typ->construct("Some", {v});
        } else if (expr->op == "Tuple") {
            vector<SpecValue> elems;
            for (auto i = 0; i < expr->elems.size(); i++) {
                elems.push_back(resolve_pattern(expr->elems[i], src->get(i), vars, assigns));
            }
            return typ->construct(elems);
        } else if (expr->op == "::") {
            auto head = resolve_pattern(expr->elems[0], src->get("head"), vars, assigns);
            auto tail = resolve_pattern(expr->elems[1], src->get("tail"), vars, assigns);
            return typ->construct("cons", {head, tail});
        } else if (auto indtype = proj->get_indtype_by_constr(expr->op)) {
            vector<SpecValue> args;
            for (auto i = 0; i < indtype->constr[expr->op].size(); i++) {
                args.push_back(resolve_pattern(expr->elems[i], src->get(indtype->constr[expr->op][i].name), vars, assigns));
            }
            return typ->construct(expr->op, args);
        } else {
            throw Exception("Unknown pattern: " + str(pat));
        }
    } else {
        throw Exception("Unknown pattern: " + str(pat));
    }
}





SpecValue z3_eval(Project* proj, shared_ptr<SpecNode> val, shared_ptr<EvalState> state) {
    // state = copy_state(state)

    // if (val->z3_eval) return val->z3_eval;

    if (auto sym = dynamic_pointer_cast<Symbol>(val)) {
        if (sym->text != "None" && sym->text != "nil" && state->vars.find(sym->text) != state->vars.end()) {
            return cache(val, state->vars[sym->text]);
        } else if (proj->defs.find(sym->text) != proj->defs.end()) {
            auto df = proj->defs[sym->text];
            assert(df->args.size() == 0);
            if (auto c = dynamic_pointer_cast<Const>(df->body)) {
                return cache(val, z3_eval(proj, c, state));
            } else {
                return cache(val, df->absf->call({}));
            }
        } else if (proj->decls.find(sym->text) != proj->decls.end()) {
            auto decl = proj->decls[sym->text];
            assert(!dynamic_pointer_cast<Function>(decl->type));
            return cache(val, decl->absf);
        } else if (proj->is_ind_constr(sym->text)) {
            return cache(val, val->get_type()->construct(sym->text, {}));
        } else if (proj->symbols.find(sym->text) != proj->symbols.end()) {
            auto info = proj->symbols[sym->text];
            if (info.kind == SymbolKind::StructElem) {
                return cache(val, val);
            }
        } else {
            throw Exception("Unknown symbol: " + sym->text);
        }
    } else if (auto intc = dynamic_pointer_cast<IntConst>(val)) {
        return cache(val, IntValue(intc->value));
    } else if (auto boolc = dynamic_pointer_cast<BoolConst>(val)) {
        return cache(val, BoolValue(boolc->value));
    } else if (auto strc = dynamic_pointer_cast<StringConst>(val)) {
        return cache(val, StringValue(strc->value));
    } else if (auto expr = dynamic_pointer_cast<Expr>(val)) {
        vector<SpecValue> elems;
        for (auto &e : expr->elems) {
            elems.push_back(z3_eval(proj, e, state));
        }
        if (expr->op == '+') return cache(val, elems[0].add(elems[1]));
        else if (expr->op == '-') {
            if (elems.size() == 1)
                return cache(val, elems[0].neg());
            else
                return cache(val, elems[0].sub(elems[1]));
        }
                else if (expr->op == '*') return cache(val, elems[0].mul(elems[1]));
        else if (expr->op == '/') return cache(val, elems[0].div(elems[1]));
        else if (expr->op == 'mod') return cache(val, elems[0].mod(elems[1]));
        else if (expr->op == '<<') return cache(val, elems[0].shiftl(elems[1]));
        else if (expr->op == '>>') return cache(val, elems[0].shiftr(elems[1]));
        else if (expr->op == '&') return cache(val, elems[0].land(elems[1]));
        else if (expr->op == "|'") return cache(val, elems[0].lor(elems[1]));
        else if (expr->op == 'Z.lxor') return cache(val, elems[0].lxor(elems[1]));
        else if (expr->op == 'Z.lnot') return cache(val, elems[0].lnot(elems[1]));
        else if (expr->op == 'Z.testbit') return cache(val, elems[0].testbit(elems[1]));
        else if (expr->op == 'Z.setbit') return cache(val, elems[0].setbit(elems[1]));
        else if (expr->op == 'Z.clearbit') return cache(val, elems[0].clearbit(elems[1]));
        else if (expr->op == 'xorb') return cache(val, elems[0].xorb(elems[1]));
        else if (expr->op in ['=', '=?', '=s']) return cache(val, elems[0].eq(elems[1]));
        else if (expr->op in ['<>', '<>?', '<>s']) return cache(val, elems[0].ne(elems[1]));
        else if (expr->op in ['>', '>?']) return cache(val, elems[0].gt(elems[1]));
        else if (expr->op in ['>=', '>=?']) return cache(val, elems[0].ge(elems[1]));
        else if (expr->op in ['<', '<?']) return cache(val, elems[0].lt(elems[1]));
        else if (expr->op in ['<=', '<=?']) return cache(val, elems[0].le(elems[1]));
        else if (expr->op in ['~', '!']) return cache(val, elems[0].negb());
        else if (expr->op in ['&&', '/\\']) return cache(val, elems[0].andb(elems[1]));
        else if (expr->op in ['||', '\\/']) return cache(val, elems[0].orb(elems[1]));
        else if (expr->op == '->') return cache(val, elems[0].implies(elems[1]));
        else if (expr->op == 'ZMap.get') {
            if (auto e = dynamic_pointer_cast<Expr>(expr->elems[0])) {
                if (e->op == 'ZMap.set') {
                    auto z3_res = z3_check(state, z3_eval(proj, e->elems[1], state).eq(elems[1]).get_z3_value());
                    if (z3_res == True) {
                        return cache(val, z3_eval(state, e->elems[2], state));
                    } else if (z3_res == False) {
                        return cache(val, z3_eval(proj, e->elems[0], state).get(elems[1]));
                    }
                }
            }
            return cache(val, elems[0].get(elems[1]));
        } else if (expr->op == 'ZMap.set') {
            if (auto e = dynamic_pointer_cast<Expr>(expr->elems[0])) {
                if (e->op == 'ZMap.set') {
                    auto z3_res = z3_check(state, z3_eval(proj, e->elems[1], state).eq(elems[1]).get_z3_value());
                    if (z3_res == True) {
                        elems[0] = z3_eval(proj, e->elems[0], state);
                    }
                }
            }
            return cache(val, elems[0].set(elems[1], elems[2]));
        // Record.get
        // Record.set

        else if (expr->op == '::') return cache(val, elems[0].cons(elems[1]));
        else if (expr->op == '++') return cache(val, elems[0].concat(elems[1]));
        else if (expr->op == 'Some') return cache(val, val->get_type()->construct("Some", {elems[0]}));
        else if (expr->op == 'prop') return cache(val, elems[0]);
        else if (expr->op == 'Tuple') return cache(val, val->get_type()->construct(elems));
        else if (expr->op == 'ptr_to_int') return cache(val, ptr_to_int().call(elems));
        else if (expr->op == 'int_to_ptr') return cache(val, int_to_ptr().call(elems));
        else if (expr->op == 'z_to_nat') return cache(val, z_to_nat().call(elems));
        else if (expr->op == 'zmap_init' || expr->op == 'ZMap.init') return cache(val, val->get_type()->from_z3_value(z3.K(z3.IntSort(), elems[0].get_z3_value())));
        else if (auto sym = dynamic_pointer_cast<Symbol>(expr->op)) {
            auto info = proj->symbols[sym->text];
            if (info.kind == SymbolKind::StructConstr) {
                return cache(val, val->get_type()->construct(elems));
            } else if (info.kind == SymbolKind::IndConstr) {
                return cache(val, val->get_type()->construct(sym->text, elems));
            } else if (info.kind == SymbolKind::Def) {
                auto df = proj->defs[sym->text];
                return cache(val, df->absf->call(elems));
            } else if (info.kind == SymbolKind::Decl) {
                auto df = proj->decls[sym->text];
                return cache(val, df->absf->call(elems));
            } else {
                throw Exception("Unsupported");
            }
        } else {
            auto op = z3_eval(proj, expr->op, state);
            assert(op->kind == ValueKind::Function);
            return cache(val, op->call(elems));
        }
        }
        else if (auto match = dynamic_pointer_cast<Match>(val)) {
            SpecValue match_val = nullptr;
            for (auto pm = val->match_list.rbegin(); pm != val->match_list.rend(); pm++) {
                unordered_map<string, SpecValue> vars;
                unordered_map<string, SpecValue> assigns;
                auto pat = resolve_pattern(pm->pattern, src, &vars, &assigns);
                z3::expr cond;
                if (vars.size() == 0) {
                    cond = pat.get_z3_value() == src.get_z3_value();
                } else {
                    vector<z3::expr> vars_expr;
                    for (auto &v : vars) {
                        vars_expr.push_back(v.get_z3_value());
                    }
                    cond = z3::Exists(vars_expr, pat.get_z3_value() == src.get_z3_value());
                }
                auto z3_res = z3_check(state, cond);
                if (z3_res == False) continue;
                auto new_state = copy_state(state);
                for (auto &v : assigns) {
                    new_state->vars[v.first] = v.second;
                }
                if (match_val == nullptr) {
                    match_val = z3_eval(proj, pm->body, new_state);
                } else {
                    auto then_val = z3_eval(proj, pm->body, new_state);
                    match_val = match_val->get_type()->from_z3_value(z3.If(cond, then_val.get_z3_value(), match_val.get_z3_value()));
                }
            }
            if (match_val == nullptr) {
                assert(dynamic_pointer_cast<Option>(val->get_type()));
                return _cache(val->get_type()->construct("None", {}));
            } else {
                return _cache(match_val);
            }
        } else if (auto rely = dynamic_pointer_cast<Rely>(val)) {
            auto cond = z3_eval(proj, rely->prop, state);
            auto res = z3_check(state, cond.get_z3_value());
            if (res == None) {
                auto body = z3_eval(proj, rely->body, state);
                auto none = rely->get_type()->construct("None", {});
                auto z3_val = z3.If(cond.get_z3_value(), body.get_z3_value(), none.get_z3_value());
                return _cache(rely->get_type()->from_z3_value(z3.simplify(z3_val)));
            } else if (res == True) {
                                return _cache(z3_eval(proj, rely->body, state));
            } else {
                return _cache(rely->get_type()->construct("None", {}));
            }
        } else if (auto anno = dynamic_pointer_cast<Anno>(val)) {
            return _cache(z3_eval(proj, anno->body, state));
        } else if (auto iff = dynamic_pointer_cast<If>(val)) {
            auto c = z3_eval(proj, iff->cond, state);
            auto res = z3_check(state, c.get_z3_value());
            if (res == None) {
                auto true_state = copy_state(state);
                true_state->conds.push_back(c.get_z3_value());
                auto true = z3_eval(proj, iff->then_body, true_state);
                auto false_state = copy_state(state);
                false_state->conds.push_back(z3.Not(c.get_z3_value()));
                auto false = z3_eval(proj, iff->else_body, false_state);
                auto z3_val = z3.If(c.get_z3_value(), true.get_z3_value(), false.get_z3_value());
                return _cache(iff->get_type()->from_z3_value(z3.simplify(z3_val)));
            } else if (res == True) {
                state->conds.push_back(c.get_z3_value());
                return _cache(z3_eval(proj, iff->then_body, state));
            } else {
                state->conds.push_back(z3.Not(c.get_z3_value()));
                return _cache(z3_eval(proj, iff->else_body, state));
            }
        } else if (auto forall = dynamic_pointer_cast<Forall>(val)) {
            vector<z3::expr> vars;
            for (auto &v : forall->vars) {
                auto var = v.type->declare(v.name, val->nid);
                v.z3_val = var;
                state->vars[v.name] = var;
                vars.push_back(var.value);
            }
            auto body = z3_eval(proj, forall->body, state);
            return _cache(BoolValue(z3.ForAll(vars, body.value)));
        } else if (auto exsts = dynamic_pointer_cast<Exists>(val)) {
            vector<z3::expr> vars;
            for (auto &v : exsts->vars) {
                auto var = v.type->declare(v.name, val->nid);
                                                state->vars[v.name] = var;
                vars.push_back(var.value);
            }
                        auto body = z3_eval(proj, exsts->body, state);
            return _cache(BoolValue(z3.Exists(vars, body.value)));
        } else {
            throw Exception("Unknown node type: " + str(type(val)));
        }
    }
}
