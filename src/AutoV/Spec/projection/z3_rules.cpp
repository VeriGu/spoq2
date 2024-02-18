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
#include <rules.h>
#include <z3_utils.h>
#include <vector>


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
using autov::SpecValue;
using autov::IndValue;
using autov::StructValue;

using std::set;
using std::sort;
using std::unordered_map;
using std::shared_ptr;
using std::vector;

unordered_map<string, z3::expr> length_z3_map;

rule_ret_t rule_simple_by_z3(Project* proj, SpecNode* spec, shared_ptr<EvalState> state);

rule_ret_t merge_rely(Project* proj, SpecNode* spec, shared_ptr<EvalState> state) {
    bool changed = false;
    if (auto expr = instance_of(spec, Expr)) {
        // do nothing
    }
    else if (auto sym = instance_of(spec, Symbol)) {
        state->vars->emplace(sym->text, sym->type->declare(sym->text, sym->nid));
    }
    else if (auto match = instance_of(spec, Match)) {
        for (auto pm = match->match_list->begin(); pm != match->match_list->end(); pm++) {
            if (auto sym = instance_of((*pm)->pattern.get(), Symbol)) {
                state->vars->emplace(sym->text, sym->type->declare(sym->text, match->nid));
            }
            else {
                auto expr = instance_of((*pm)->pattern.get(), Expr);
                if (!expr) throw std::runtime_error("Pattern match must be a symbol or an expression");
                for (auto e = expr->elems->begin(); e != expr->elems->end(); e++) {
                    if (auto sym = instance_of(e->get(), Symbol)) {
                        state->vars->emplace(sym->text, sym->type->declare(sym->text, match->nid));
                    }
                    else {
                        auto ee = instance_of(e->get(), Expr);
                        if (ee && is_instance(ee->type.get(), Tuple)) {
                            for (auto ele = ee->elems->begin(); ele != ee->elems->end(); ele++) {
                                if (auto sym = instance_of(ele->get(), Symbol)) {
                                    state->vars->emplace(sym->text, sym->type->declare(sym->text, match->nid));
                                }
                            }
                        }
                    }
                }
            }
            auto ret = merge_rely(proj, (*pm)->body.release(), state);
            changed |= ret.second;
            (*pm)->body.reset(ret.first);
        }
    }
    else if (auto if_ = instance_of(spec, If)) {
        auto merged_then = merge_rely(proj, if_->then_body.release(), state);
        auto merged_else = merge_rely(proj, if_->else_body.release(), state);
        changed |= merged_then.second || merged_else.second;
        if_->then_body.reset(merged_then.first);
        if_->else_body.reset(merged_else.first);
    }
    else if (auto anno = instance_of(spec, Anno)) {
        auto ret = merge_rely(proj, anno->body.release(), state);
        changed |= ret.second;
        anno->body.reset(ret.first);
    }
    else if (auto rely = instance_of(spec, Rely)) {
        vector<z3::expr> conds;
        auto cond = z3_eval(proj, rely->prop.get(), make_shared<EvalState>(state->vars));
        conds.push_back(cond->get_z3_value());
        int i = -1;
        auto spec1 = rely;
        while (auto rely1 = dynamic_cast<Rely*>(spec1)) {
            if (auto rely2 = dynamic_cast<Rely*>(rely1->body.get())) {
                auto cond = z3_eval(proj, rely2->prop.get(), make_shared<EvalState>(state->vars));
                conds.push_back(cond->get_z3_value());
                spec1 = rely2;
            }
            else break;
        }

        while (auto rely1 = dynamic_cast<Rely*>(rely)) {
            if (auto rely2 = dynamic_cast<Rely*>(rely1->body.get())) {
                i += 1;
                auto cond = z3_eval(proj, rely1->prop.get(), make_shared<EvalState>(state->vars));

                auto tmp_conds = std::make_shared<vector<z3::expr>>();
                tmp_conds->insert(tmp_conds->end(), conds.begin(), conds.begin() + i);
                tmp_conds->insert(tmp_conds->end(), conds.begin() + i + 1, conds.end());
                auto res = z3_check(make_shared<EvalState>(state->vars, tmp_conds), cond->get_z3_value());

                if (res == Z3Result::Unknown) {
                    auto new_conds = new vector<unique_ptr<SpecNode>>();
                    new_conds->push_back(unique_ptr<SpecNode>(rely1->prop.release()));
                    new_conds->push_back(unique_ptr<SpecNode>(rely2->prop.release()));
                    rely1->prop.reset(new Expr("/\\", unique_ptr<vector<unique_ptr<SpecNode>>>(new_conds), Prop::PROP));
                    rely1->body.reset(rely2->body.release());
                    delete rely2;
                }
                else if (res == Z3Result::True) {
                    rely1->prop.reset(rely2->prop.release());
                    rely1->body.reset(rely2->body.release());
                    delete rely2;
                }
                else {
                    rely1->prop.reset(new Expr("false", make_unique<vector<unique_ptr<SpecNode>>>(), Prop::PROP));
                    rely1->body.reset(rely2->body.release());
                    delete rely2;
                }
                changed = true;
            }
        }
        auto ret = merge_rely(proj, rely->body.release(), state);
        changed |= ret.second;
        rely->body.reset(ret.first);
    }
    else {
        throw std::runtime_error("Unknown node type: " + std::string(typeid(spec).name()));
    }
    return std::make_pair(spec, changed);
}

rule_ret_t remove_rely_by_z3(Project* proj, SpecNode* spec, shared_ptr<EvalState> state) {
    return merge_rely(proj, spec, state);
}

rule_ret_t simple_rely_by_z3(Project* proj, Rely* spec, shared_ptr<EvalState> state) {
    bool changed = false;
    auto ret = rule_simple_by_z3(proj, spec->prop.release(), state);
    changed |= ret.second;
    auto cond = ret.first;
    if (cond == nullptr) {
        delete spec;
        return std::make_pair(nullptr, changed);
    }
    auto c = z3_eval(proj, cond, state);
    auto res = z3_check(state, c->get_z3_value(), 1000);

    if (res == Z3Result::Unknown) {
        state->conds->push_back(c->get_z3_value());
        auto ret = rule_simple_by_z3(proj, spec->body.release(), state);
        state->conds->pop_back(); // newly added. Old code might have bug here
        changed |= ret.second;
        auto body = ret.first;
        if (body == nullptr) {
            delete cond;
            delete spec;
            return std::make_pair(nullptr, changed);
        }
        return std::make_pair(new Rely(unique_ptr<SpecNode>(cond), unique_ptr<SpecNode>(body)), changed);
    }
    else if (res == Z3Result::True) {
        auto ret = rule_simple_by_z3(proj, spec->body.release(), state);
        delete cond;
        delete spec;
        return ret;
    }
    else {
        delete cond;
        delete spec;
        return std::make_pair(nullptr, true);
    }
}

rule_ret_t simple_anno_by_z3(Project* proj, Anno* spec, shared_ptr<EvalState> state)
{
    auto ret = rule_simple_by_z3(proj, spec->body.release(), state);
    if (ret.first == nullptr) {
        delete spec;
        return std::make_pair(nullptr, ret.second);
    }
    spec->body.reset(ret.first);
    return std::make_pair(spec, ret.second);
}

rule_ret_t simple_if_by_z3(Project* proj, If* spec, shared_ptr<EvalState> state) {
    bool changed = false;
    auto cond_ret = rule_simple_by_z3(proj, spec->cond.release(), state);
    if (cond_ret.first == nullptr) {
        delete spec;
        return std::make_pair(nullptr, cond_ret.second);
    }
    auto c = z3_eval(proj, cond_ret.first, state);
    auto res = z3_check(state, c->get_z3_value(), 1000);
    if (res == Z3Result::Unknown) {
        state->conds->push_back(c->get_z3_value());
        auto then_ret = rule_simple_by_z3(proj, spec->then_body.release(), state);
        state->conds->back() = !c->get_z3_value();
        auto else_ret = rule_simple_by_z3(proj, spec->else_body.release(), state);
        changed |= then_ret.second || else_ret.second;
        if (then_ret.first == nullptr && else_ret.first == nullptr) {
            delete cond_ret.first;
            return std::make_pair(nullptr, changed);
        }
        else if (then_ret.first == nullptr && is_instance(else_ret.first->get_type().get(), Option)) {
            auto elems = make_unique<vector<unique_ptr<SpecNode>>>();
            elems->push_back(unique_ptr<SpecNode>(cond_ret.first));
            elems->push_back(unique_ptr<SpecNode>(new BoolConst(false)));
            auto cond = make_unique<Expr>("=", std::move(elems), Prop::PROP);
            delete spec;
            return std::make_pair(new Rely(std::move(cond), unique_ptr<SpecNode>(else_ret.first)), changed);
        }
        else if (else_ret.first == nullptr && is_instance(then_ret.first->get_type().get(), Option)) {
            auto elems = make_unique<vector<unique_ptr<SpecNode>>>();
            elems->push_back(unique_ptr<SpecNode>(cond_ret.first));
            elems->push_back(unique_ptr<SpecNode>(new BoolConst(true)));
            auto cond = make_unique<Expr>("=", std::move(elems), Prop::PROP);
            delete spec;
            return std::make_pair(new Rely(std::move(cond), unique_ptr<SpecNode>(then_ret.first)), changed);
        }

        if (then_ret.first == nullptr) {
            delete cond_ret.first;
            delete spec;
            return std::make_pair(else_ret.first, true);
        }
        if (else_ret.first == nullptr) {
            delete cond_ret.first;
            delete spec;
            return std::make_pair(then_ret.first, true);
        }
        return std::make_pair(new If(unique_ptr<SpecNode>(cond_ret.first), unique_ptr<SpecNode>(then_ret.first), unique_ptr<SpecNode>(else_ret.first)), changed);
    }
    else if (res == Z3Result::True) {
        auto ret = rule_simple_by_z3(proj, spec->then_body.release(), state);
        delete cond_ret.first;
        delete spec;
        return std::make_pair(ret.first, true);
    }
    else {
        auto ret = rule_simple_by_z3(proj, spec->else_body.release(), state);
        delete cond_ret.first;
        delete spec;
        return std::make_pair(ret.first, true);
    }
}

void resolve_pattern(Project* proj, SpecNode* spec, SpecNode* pat, shared_ptr<SpecValue> src, shared_ptr<EvalState> state)
{
    if (auto sym = instance_of(pat, Symbol)) {
        if (proj->is_ind_constr(sym->text)) {
            auto t = dynamic_pointer_cast<Inductive>(src->get_type());
            state->conds->push_back(src->get_z3_value() == t->construct(sym->text, {}).get_z3_value());
        }
        else {
            state->vars->emplace(sym->text, src);
        }
    }
    else if (auto con = instance_of(pat, IntConst)) {
        state->conds->push_back(src->get_z3_value() == z3ctx.int_val((long)std::get<long long>(con->value)));
    }
    else if (auto con = instance_of(pat, BoolConst)) {
        state->conds->push_back(src->get_z3_value() == z3ctx.bool_val(std::get<bool>(con->value)));
    }
    else if (auto con = instance_of(pat, StringConst)) {
        state->conds->push_back(src->get_z3_value() == z3ctx.string_val(std::get<string>(con->value)));
    }
    else if (auto expr = instance_of(pat, Expr))
    {
        if (std::holds_alternative<string>(expr->op) && std::get<string>(expr->op) == "Some") {
            auto t = dynamic_pointer_cast<Option>(src->get_type());
            auto v = t->elem_type->declare("v", spec->nid);
            if (auto tuple_type = dynamic_pointer_cast<Tuple>(t->elem_type)) {
                auto tuple_elems = instance_of(expr->elems->at(0).get(), Expr)->elems; // Seems like a bug here
                if (tuple_elems->size() == 2) {
                    // assume the tuple is (symbol, symbol)?
                    auto sym0 = instance_of(tuple_elems->at(0).get(), Symbol);
                    auto sym1 = instance_of(tuple_elems->at(1).get(), Symbol);
                    auto elem0 = sym0->type->declare(sym0->text, sym0->nid); // nid or id?
                    auto elem1 = sym1->type->declare(sym1->text, sym1->nid); // nid or id?
                    state->vars->emplace(sym0->text, elem0);
                    state->vars->emplace(sym1->text, elem1);
                }
            }
            resolve_pattern(proj, spec, expr->elems->at(0).get(), dynamic_pointer_cast<IndValue>(src)->get("value"), state);
        }
        else if (std::holds_alternative<string>(expr->op) && std::get<string>(expr->op) == "Tuple") {
            for (int i = 0; i < expr->elems->size(); i++) {
                resolve_pattern(proj, spec, expr->elems->at(i).get(), dynamic_pointer_cast<StructValue>(src)->get(i), state);
            }
        }
        else if (std::holds_alternative<string>(expr->op) && std::get<string>(expr->op) == "::") {
            auto t = dynamic_pointer_cast<List>(src->get_type());
            auto hh = t->elem_type->declare("h", spec->nid);
            auto tt = t->declare("t", spec->nid);
            resolve_pattern(proj, spec, expr->elems->at(0).get(), dynamic_pointer_cast<IndValue>(src)->get("head"), state);
            resolve_pattern(proj, spec, expr->elems->at(1).get(), dynamic_pointer_cast<IndValue>(src)->get("tail"), state);
        }
        else if (std::holds_alternative<string>(expr->op)) {
            auto op = std::get<string>(expr->op);
            auto sym = proj->symbols.find(op);
            if (sym != proj->symbols.end() && sym->second.kind == SymbolKind::IndConstructor) {
                auto t = dynamic_pointer_cast<Inductive>(src->get_type());
                std::vector<shared_ptr<SpecValue>> vars;
                for (int i = 0; i < t->constr[op]->size(); i++) {
                    auto arg = t->constr[op]->at(i);
                    resolve_pattern(proj, spec, expr->elems->at(i).get(), dynamic_pointer_cast<IndValue>(src)->get(arg->name), state);
                }
            }
            else throw std::runtime_error("Unknown pattern: " + string(*pat));
        }
        else throw std::runtime_error("Unknown pattern: " + string(*pat));
    }
    else throw std::runtime_error("Unknown pattern: " + string(*pat));
}

rule_ret_t simple_match_by_z3(Project* proj, Match* spec, shared_ptr<EvalState> state) {
    auto src_ret = rule_simple_by_z3(proj, spec->src.release(), state);
    if (src_ret.first == nullptr) {
        delete spec;
        return std::make_pair(nullptr, true);
    }
    auto src_val = z3_eval(proj, src_ret.first, state);
    auto match_list = make_unique<vector<unique_ptr<PatternMatch>>>();

    for (auto pm = spec->match_list->begin(); pm != spec->match_list->end(); pm++) {
        auto new_state = state->copy();
        resolve_pattern(proj, spec, (*pm)->pattern.get(), src_val, new_state);
        if (z3_check(new_state) == false) continue;
        auto body = rule_simple_by_z3(proj, pm->body.release(), new_state);
        if (body != nullptr) match_list->push_back(make_unique<PatternMatch>(pm->pattern, body));
    }

    {
        auto new_state = copy_state(state);
        resolve_pattern(proj, pm->pattern.get(), src_val, new_state);
        if (z3_check(new_state) == false) continue;
        auto body = rule_simple_by_z3(proj, pm->body.get(), new_state);
        if (body != nullptr) match_list.push_back(make_shared<PatternMatch>(pm->pattern, body));
    }

    if (auto opt = dynamic_cast<Option*>(src->get_type()))
    {
        if (auto opt1 = dynamic_cast<Option*>(spec->get_type()))
        {
            bool has_some = false;
            bool has_none = false;
            for (auto pm : *spec->match_list)
            {
                if (auto expr = dynamic_cast<Expr*>(pm->pattern.get()))
                {
                    if (expr->op == "Some") has_some = true;
                }
                else if (auto sym = dynamic_cast<Symbol*>(pm->pattern.get()))
                {
                    if (sym->text == "None") has_none = true;
                    else if (sym->text == "_")
                    {
                        has_some = true;
                        has_none = true;
                    }
                }
            }
            if (!has_some || !has_none)
            {
                match_list.push_back(make_shared<PatternMatch>(make_shared<Symbol>("_", src->get_type()), make_shared<Symbol>("None", spec->get_type())));
            }
        }
    }
    if (match_list.size() == 0) return nullptr;
    else
    {
        auto extract_rely_anno = [](SpecNode* spec) -> SpecNode*
        {
            while (auto rely = dynamic_cast<Rely*>(spec) || auto anno = dynamic_cast<Anno*>(spec))
            {
                spec = rely->body;
            }
            return spec;
        };
        bool only_none = true;
        for (auto pm : match_list)
        {
            auto body = extract_rely_anno(pm->body.get());
            if (!(dynamic_cast<Symbol*>(body) && body->text == "None"))
            {
                only_none = false;
                break;
            }
        }
        if (only_none) return new Symbol("None", spec->get_type());
        else return new Match(src, match_list);
    }
}




/*
def simple_expr_by_z3(proj, spec: Expr, state={"vars": {}, "conds": []}):
    spec = TR.transform_anno(proj, spec)
    if isinstance(spec, Anno):
        return simple_anno_by_z3(proj, spec, state)
    elems = [rule_simple_by_z3(proj, e, state) for e in spec.elems]
    if any([e is None for e in elems]):
        return None
    spec = TR.transform_anno(proj, Expr(spec.op, elems, spec.get_type()))

    annos = []
    while isinstance(spec, Anno):
        annos.append(spec.prop)
        spec = spec.body
    def reannotate(spec):
        nonlocal annos
        for anno in reversed(annos):
            spec = Anno(anno, spec)
        return spec
    
    exp_val = z3_eval(proj, spec, state)

    subexprs = {}
    def collect_exprs(expr: SpecNode):
        if isinstance(expr, Expr):
            for e in expr.elems:
                collect_exprs(e)
        if isinstance(expr, Anno):
            collect_exprs(expr.body)
        if expr.z3_eval is not None and isinstance(expr.z3_eval, SpecValue):
            h = hash(expr.z3_eval.get_z3_value())
            if h not in subexprs or expr.length < subexprs[h][1].length:
                subexprs[h] = (expr.z3_eval.get_z3_value(), expr)
    collect_exprs(spec)


    def length_of_exp(e):
        match e:
            case Symbol() | Const() | IntConst() | StringConst() | BoolConst() | Declaration():
                return 1
            case RecordDef(fields=fields):
                l = 0
                for n,v in fields:
                    l += length_of_exp(v)
                return l
            case Expr(elems=elems):
                return sum([length_of_exp(elem) for elem in elems])
            case PatternMatch(pattern=pattern, body=body):
                return length_of_exp(pattern) + length_of_exp(body)
            case Match(src=src, match_list=ml):
                return length_of_exp(src) + sum([length_of_exp(m) for m in ml])
            case Rely(prop=prop, body=body) | Anno(prop=prop, body=body):
                return length_of_exp(prop) + length_of_exp(body)
            case If(cond=cond,then_body=then_body, else_body=else_body):
                return length_of_exp(cond) + length_of_exp(then_body) + length_of_exp(else_body)
            case Forall(vars=vars,body=body):
                return length_of_exp(body)
            case Exists(vars=vars, body=body):
                return length_of_exp(body)
            case Definition(name=name, rettype=rettype, args=args,body=body):
                return length_of_exp(body)
    

    def length_z3_val(z3_val):
        if(z3.is_var(z3_val) or z3.is_const(z3_val)):
            return 1
        elif z3.is_app(z3_val):
            num = z3_val.num_args()
            l_s = 0
            for i in range(num):
                arg = z3_val.arg(i)
                l = length_z3_val(arg)
                l_s += l
            return l_s
        elif z3.is_quantifier(z3_val):
            return length_z3_val(z3_val.body()) + 1
        

    def reconstruct_expr(z3_val, try_subexpr=True):
        if not TR.RECONSTRUCT:
            return None

        if isinstance(z3_val, z3.IntNumRef):
            return IntConst(z3_val.as_long())
        if isinstance(z3_val, z3.BoolRef):
            if z3.is_true(z3_val):
                return BoolConst(True)
            if z3.is_false(z3_val):
                return BoolConst(False)
        '''
        For example:
        we want to simplify (100 * x + 1) / 100 ==> x
        z3 cannot simplify this expression directly, so we heuristically try to find a subexpression [x]
        that is equal to the original expression [(100 * x + 1) / 100)].
        At the same time, we try to avoid replacing [x] with a longer expression [(100 * x + 1) / 100)].

        So we first try finding a subexpression from the original expr; then we follow the expression structure of z3_val;
        at last, we try to find a subexpression from the original expr again without enforcing new_len < old_len.
        '''
        candidates = []
        if try_subexpr:
            z3_val_hash = z3_val.hash()
            if z3_val_hash not in length_z3_map.keys():
                length_z3_map[z3_val_hash] = length_z3_val(z3_val)
            z3_val_length = length_z3_map[z3_val_hash]

            for e_val, e in sorted(subexprs.values(), key=lambda x: x[1].length):
                e_val_hash = e_val.hash()
                if e_val_hash not in length_z3_map.keys():
                    length_z3_map[e_val_hash] = length_z3_val(z3_val)
                
                z3_e_val_length = length_z3_map[e_val_hash]

                if z3_e_val_length > z3_val_length: continue
                # if len(str(e_val)) == len(str(z3_val)) or\
                if (e_val.sort() == z3_val.sort() and z3_check(state, e_val == z3_val)):
                    candidates.append(e)
        if isinstance(z3_val, z3.ArithRef) and z3_val.num_args() > 0:
            elems = [reconstruct_expr(z3_val.arg(i)) for i in range(z3_val.num_args())]
            if all([e is not None for e in elems]):
                if str(z3_val.decl()) in ["+", "-", "*", "/", "mod"]:
                    expr = Expr(str(z3_val.decl()), [elems[0], elems[1]], Int())
                    for e in elems[2:]:
                        expr = Expr(str(z3_val.decl()), [expr, e], Int())
                    candidates.append(expr)
                elif str(z3_val.decl()) == 'Not':
                    if isinstance(elems[0], Expr) and\
                        elems[0].op in ['=?', '<>?', '>=?', '<=?', '>?', '<?', '=', '<>', '>', '<', '>=', '<=']:
                        rev = {'=?': '<>?', '<>?': '=?', '>=?': '<?', '<=?': '>?', '>?': '<=?', '<?': '>=?', 
                                '=': '<>', '<>': '=', '>': '<=', '<': '>=', '>=': '<', '<=': '>'}
                        candidates.append(Expr(rev[elems[0].op], elems[0].elems, Bool()))
                    candidates.append(Expr("!", [elems[0]], Bool()))
                elif str(z3_val.decl()) in ['<', '>', '<=', '>=']:
                    candidates.append(Expr(str(z3_val.decl()) + '?', [elems[0], elems[1]], Bool()))
        candidates.sort(key=lambda x: x.length)
        if len(candidates) > 0:
            return candidates[0].deepcopy()
        else:
            return None

    if spec.get_type() == Int() or spec.get_type() == Bool() and length_of_exp(spec) <= 20:
        expr = reconstruct_expr(exp_val.get_z3_value())
        if expr is not None and length_of_exp(expr) < length_of_exp(spec):
            if TR.ANNOTATE and str(spec) != str(expr) and expr.get_type() == Int():
                return reannotate(Anno(Expr("=", [spec, expr], Prop()), expr))
            else:
                return reannotate(expr)

    if spec.op == "/" and isinstance(spec.elems[0], Expr) and spec.elems[0].op == "+":
        ea = spec.elems[0].elems[0]
        eb = spec.elems[0].elems[1]
        ed = spec.elems[1]
        a = z3_eval(proj, spec.elems[0].elems[0], state)
        b = z3_eval(proj, spec.elems[0].elems[1], state)
        d = z3_eval(proj, spec.elems[1], state)
        if z3_check(state, a.get_z3_value() >= 0) and z3_check(state, b.get_z3_value() >= 0) and z3_check(state, d.get_z3_value() > 0) and\
            z3_check(state, a.get_z3_value() % d.get_z3_value() == 0) or z3_check(state, b.get_z3_value() % d.get_z3_value() == 0):
            expr = Expr(spec.elems[0].op, [Expr("/", [ea, ed], Int()), Expr("/", [eb, ed], Int())], Int())
            if TR.ANNOTATE and str(spec) != str(expr) and expr.get_type() == Int():
                return reannotate(Anno(Expr("=", [spec, expr], Prop()), expr))
            else:
                return reannotate(expr)

    def reconstruct_zmap():
        if not TR.RECONSTRUCT:
            return None
        if isinstance(spec.elems[0].elems[1], Symbol):
            return None
        idx = z3_eval(proj, spec.elems[1], state)
        z3_res = z3_check(state, z3_eval(proj, spec.elems[0].elems[1], state).eq(idx).get_z3_value())
        if z3_res == True:
            if isinstance(spec.elems[0], Expr) and spec.elems[0].op == "ZMap.set":
                if spec.op == "ZMap.set":  # ZMap.set2
                    return Expr("ZMap.set", [spec.elems[0].elems[0], spec.elems[0].elems[1], spec.elems[2]], spec.get_type())
                elif spec.op == "ZMap.get": # ZMap.gss
                    if isinstance(spec.elems[0].elems[2], Expr): return spec.elems[0].elems[2]
                    return None
        elif z3_res == False:
            if spec.op == "ZMap.get" and isinstance(spec.elems[0], Expr) and spec.elems[0].op == "ZMap.set": # ZMap.gso
                return Expr("ZMap.get", [spec.elems[0].elems[0], spec.elems[1]], spec.get_type())
        return None

    if spec.op == "ZMap.set" or spec.op == "ZMap.get":
        new_zmap = reconstruct_zmap()
        if new_zmap is not None:
            return reannotate(Anno(Expr("=", [spec, new_zmap], Prop()), new_zmap))

    def reconstruct_record():
        if not TR.RECONSTRUCT:
            return None
        if isinstance(spec.elems[0], Expr) and (spec.elems[0].op == "Record.set" or spec.elems[0].op == "Record.get"):
            if spec.op == "Record.set" and spec.op == "Record.set" and \
                len(spec.elems[0].elems) == len(spec.elems):
                spec2 = spec.elems[0]
                same = True
                for (f1, f2) in zip(spec.elems[1:-1], spec2.elems[1:-1]):
                    if f1.text != f2.text:
                        same = False
                        break
                if same:  # Record.set2
                    return Expr("Record.set", [spec2.elems[0]] + spec.elems[1:], spec.get_type())
            elif spec.op == "Record.get" and spec.op == "Record.set":
                spec2 = spec.elems[0]
                diff = False
                for i in range(1, min(len(spec.elems), len(spec2.elems))):
                    if spec2.elems[i].text != spec.elems[i].text:
                        diff = True
                        break

                if not diff and len(spec2.elems) == len(spec.elems): # Record.gss
                    if isinstance(spec2.elems[-1], Expr): return spec2.elems[-1]
                    return None
                elif diff: # Record.gso
                    return Expr("Record.get", [spec2.elems[0]] + spec.elems[1:], spec.get_type())
        return None

    # if spec.op == "Record.set" or spec.op == "Record.get":
    #     new_record = reconstruct_record()
    #     if new_record is not None:
    #         return reannotate(Anno(Expr("=", [spec, new_record], Prop()), new_record))
    return reannotate(spec)
*/

rule_ret_t simple_expr_by_z3(Project* proj, Expr* spec, shared_ptr<EvalState> state) {
    spec = TR.transform_anno(proj, spec);
    if (auto anno = dynamic_cast<Anno*>(spec)) {
        return rule_simple_by_z3(proj, anno->body.get(), state);
    }
    vector<shared_ptr<SpecNode>> elems;
    for (auto e : dynamic_cast<Expr*>(spec)->elems) {
        auto e1 = rule_simple_by_z3(proj, e.get(), state);
        if (e1 == nullptr) return {};
        elems.push_back(e1);
    }
    spec = TR.transform_anno(proj, Expr(spec->op, elems, spec->get_type()));

    vector<SpecNode*> annos;
    while (auto anno = dynamic_cast<Anno*>(spec)) {
        annos.push_back(anno->prop.get());
        spec = anno->body.get();
    }
    auto reannotate = [&](SpecNode* spec) {
        for (auto anno : annos) {
            spec = new Anno(anno, spec);
        }
        return spec;
    };

    auto exp_val = z3_eval(proj, spec, state);
    unordered_map<z3::expr, SpecNode*> subexprs;
    auto collect_exprs = [&](SpecNode* expr) {
        if (auto expr1 = dynamic_cast<Expr*>(expr)) {
            for (auto e : expr1->elems) {
                collect_exprs(e.get());
            }
        }
        if (auto anno = dynamic_cast<Anno*>(expr)) {
            collect_exprs(anno->body.get());
        }
        if (auto expr1 = dynamic_cast<Expr*>(expr)) {
            if (expr1->z3_eval && dynamic_cast<SpecValue*>(expr1->z3_eval) && expr1->length < subexprs[expr1->z3_eval]->length) {
                subexprs[expr1->z3_eval] = expr1;
            }
        }
    };
    collect_exprs(spec);

    auto length_of_exp = [](SpecNode* e) {
        if (auto sym = dynamic_cast<Symbol*>(e)) return 1;
        if (auto con = dynamic_cast<Const*>(e)) return 1;
        if (auto intcon = dynamic_cast<IntConst*>(e)) return 1;
        if (auto strcon = dynamic_cast<StringConst*>(e)) return 1;
        if (auto boolcon = dynamic
    

}



/*
def resolve_pattern(pat: SpecNode, src: SpecValue):
    nonlocal state, new_state
    if isinstance(pat, Symbol):
        if proj.is_ind_constr(pat.text):
            t = src.get_type()
            new_state["conds"].append(src.get_z3_value() == t.construct(pat.text, []).get_z3_value())
        else:
            new_state["vars"][pat.text] = src
    elif isinstance(pat, Const):
        new_state["conds"].append(src.get_z3_value() == StringValue(pat.value).get_z3_value())
    elif isinstance(pat, Expr):
        if pat.op == "Some":
            t = src.get_type()
            assert(isinstance(t, Option))
            v = t.elem_type.declare("v", spec.nid)
            #new_state["conds"].append(z3.Exists([v.get_z3_value()], src.get_z3_value() == t.construct("Some", [v]).get_z3_value()))
            if isinstance(t.elem_type, Tuple) and len(pat.elems[0].elems) == 2:
                elem0 = pat.elems[0].elems[0].type.declare(pat.elems[0].elems[0].text, pat.elems[0].elems[0].id)
                elem1 = pat.elems[0].elems[1].type.declare(pat.elems[0].elems[1].text, pat.elems[0].elems[1].id)
                v = t.elem_type.construct([elem0, elem1])
                new_state["vars"][pat.elems[0].elems[0].text] = elem0
                new_state["vars"][pat.elems[0].elems[1].text] = elem1
            if isinstance(spec.src, Expr):
                pass
                #new_state["conds"].append(src.get_z3_value() == t.construct("Some", [v]).get_z3_value())
            resolve_pattern(pat.elems[0], src.get("value"))
            if isinstance(t.elem_type, Tuple) and isinstance(t.elem_type, Tuple) and len(pat.elems[0].elems) == 2:
                new_elem0 = new_state["vars"][pat.elems[0].elems[0].text]
                new_elem1 = new_state["vars"][pat.elems[0].elems[1].text]
                pass
                #new_state["conds"].append(new_elem0.get_z3_value() == elem0.get_z3_value())
                #new_state["conds"].append(new_elem1.get_z3_value() == elem1.get_z3_value())
        elif pat.op == "Tuple":
            for i in range(len(pat.elems)):
                resolve_pattern(pat.elems[i], src.get(i))
        elif pat.op == "::":
            t = src.get_type()
            assert(isinstance(t, List))
            hh = t.element_type.declare("h", spec.nid)
            tt = t.declare("t", spec.nid)
            #new_state["conds"].append(z3.Exists([hh.get_z3_value(), tt.get_z3_value()], src.get_z3_value() == t.construct("Cons", [hh, tt])))
            resolve_pattern(pat.elems[0], src.get("head"))
            resolve_pattern(pat.elems[1], src.get("tail"))
        elif isinstance(pat.op, str) and pat.op in proj.symbols and proj.symbols[pat.op]["kind"] == "ind_constr":
            t = src.get_type()
            assert(isinstance(t, Inductive))
            vars = [arg.type.declare(f"v{i}", spec.nid) for i, arg in enumerate(t.constr[pat.op])]
            #new_state["conds"].append(z3.Exists([v.get_z3_value() for v in vars], src.get_z3_value() == t.construct(pat.op, vars).get_z3_value()))
            for i, arg in enumerate(t.constr[pat.op]):
                resolve_pattern(pat.elems[i], src.get(arg.name))
        else:
            raise Exception("Unknown pattern: " + str(pat))
    else:
        raise Exception("Unknown pattern: " + str(pat))
*/

rule_ret_t rule_simple_by_z3(Project* proj, SpecNode* spec, shared_ptr<EvalState> state)
{
    if (is_instance(spec, Symbol)) {
        return std::make_pair(spec, false);
    }
    else if (is_instance(spec, Const)) {
        return std::make_pair(spec, false);
    }
    else if (auto expr = instance_of(spec, Expr))
    {
        return simple_expr_by_z3(proj, expr, state);
    }
    else if (auto match = instance_of(spec, Match))
    {
        return simple_match_by_z3(proj, match, state);
    }
    else if (auto rely = instance_of(spec, Rely))
    {
        return simple_rely_by_z3(proj, rely, state);
    }
    else if (auto anno = instance_of(spec, Anno))
    {
        return simple_anno_by_z3(proj, anno, state);
    }
    else if (auto if_ = instance_of(spec, If))
    {
        return simple_if_by_z3(proj, if_, state);
    }
    else if (auto forall = instance_of(spec, Forall))
    {
        for (auto v : forall->vars)
        {
            state->vars->emplace(v->name, v->type->declare(v->name, forall->nid));
        }
        auto res = rule_simple_by_z3(proj, forall->body.release(), state);
        auto new_forall = new Forall(std::move(forall->vars), res.first);
        new_forall->clear_z3_eval();
        delete spec;
        return std::make_pair(new_forall, res.second);
    }
    else if (auto exists = instance_of(spec, Exists))
    {
        for (auto v : exists->vars)
        {
            state->vars->emplace(v->name, v->type->declare(v->name, forall->nid));
        }
        auto res = rule_simple_by_z3(proj, exists->body.release(), state);
        auto new_exists = new Exists(std::move(exists->vars), res.first);
        new_exists->clear_z3_eval();
        delete spec;
        return std::make_pair(new_exists, res.second);
    }
    else
    {
        throw std::runtime_error("Unknown node type: " + std::string(typeid(spec).name()));
    }
}

bool rule_check_pure_by_z3(Project* proj, SpecNode* spec, StructValue* in_st)
{
    auto st_type_name = in_st->type->name;

    if (auto rely = instance_of(spec, Rely)) {
        auto res = rule_check_pure_by_z3(proj, rely->body.release(), in_st);
        delete spec;
        return res;
    }

    else if (auto rely = instance_of(spec, Anno)) {
        auto res = rule_check_pure_by_z3(proj, rely->body.release(), in_st);
        delete spec;
        return res;
    }

    else if (auto expr = instance_of(spec, Expr)) {
        if (auto opt = dynamic_pointer_cast<Option>(expr->type)) {
            if (auto tuple = dynamic_pointer_cast<Tuple>(opt->elem_type)) {
                spec = expr->elems[0].get();
                auto st_idx = -1;
                for (int idx = 0; idx < expr->type->elems.size(); idx++) {
                    auto et = expr->type->elems[idx];
                    if (et->type->name == st_type_name) {
                        st_idx = idx;
                        break;
                    }
                }
                if (st_idx == -1) {
                    throw std::runtime_error("No returning state found in:\n" + str(expr));
                }
                auto st_eval = expr->elems[st_idx]->z3_eval;
                return st_eval->value.eq(in_st->value);
            }
        }
        else if (auto sym = dynamic_pointer_cast<Symbol>(expr->type->elem_type)) {
            if (expr->text == "None") {
                return true;
            }
        }
        return false;
    }

    else if (auto if_ = instance_of(spec, If)) {
        auto then_res = rule_check_pure_by_z3(proj, if_->then_body.get(), in_st);
        auto else_res = rule_check_pure_by_z3(proj, if_->else_body.get(), in_st);
        return then_res && else_res;
    }

    else if (auto match = instance_of(spec, Match)) {
        for (auto pm : *match->match_list) {
            if (!rule_check_pure_by_z3(proj, pm->body.get(), in_st))
                return false;
        }
        return true;
    }

    else if (auto sym = instance_of(spec, Symbol)) {
        if (sym->text == "None") return true;
        else throw std::runtime_error("rule_check_pure_by_z3: Unexpected symbol: " + sym->text);
    }

    else throw std::runtime_error("rule_check_pure_by_z3: Unexpected node type: " + std::string(typeid(spec).name()));
}

} // namespace autov
