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
using std::unordered_map;
using std::shared_ptr;

unordered_map<string, z3::expr> length_z3_map;


SpecNode* merge_rely(Project* proj, SpecNode* spec, shared_ptr<EvalState> state)
{
    if (auto expr = instance_of(spec, Expr)) {
        return spec;
    }
    if (auto sym = instance_of(spec, Symbol)) {
        (*state->vars)[sym->text] = sym->type->declare(sym->text, sym->nid);
        return spec;
    }
    else if (auto match = instance_of(spec, Match))
    {
        for (auto& pm : *match->match_list)
        {
            if (auto sym = instance_of(pm->pattern.get(), Symbol))
            {
                (*state->vars)[sym->text] = sym->type->declare(sym->text, match->nid);
            }
            else
            {
                //TODO
            }
            pm->body = merge_rely(proj, pm->body.get(), state);
        }
    }
    else if (auto if_ = instance_of(spec, If))
    {
        if_->then_body = merge_rely(proj, if_->then_body.get(), state);
        if_->else_body = merge_rely(proj, if_->else_body.get(), state);
    }
    else if (auto anno = instance_of(spec, Anno))
    {
        anno->body = merge_rely(proj, anno->body.get(), state);
    }
    else if (auto rely = instance_of(spec, Rely))
    {
        vector<z3::expr> conds;
        auto cond = z3_eval(proj, rely->prop.get(), make_shared<EvalState>(state->conds));
        conds.push_back(cond.get_z3_value());
        int i = -1;
        auto spec1 = rely;
        while (auto rely1 = dynamic_cast<Rely*>(spec1))
        {
            if (auto rely2 = dynamic_cast<Rely*>(rely1->body.get()))
            {
                auto cond = z3_eval(proj, rely2->prop.get(), make_shared<EvalState>(state->conds));
                conds.push_back(cond.get_z3_value());
                spec1 = rely2;
            }
            else break;
        }

        while (auto rely1 = dynamic_cast<Rely*>(rely))
        {
            if (auto rely2 = dynamic_cast<Rely*>(rely1->body.get()))
            {
                i += 1;
                auto cond = z3_eval(proj, rely1->prop.get(), make_shared<EvalState>(state->conds));
                auto res = z3_check(make_shared<EvalState>(state->conds), cond.get_z3_value());
                if (res == Z3Result::Unknown)
                {
                    rely1->prop = Expr("/\\", {rely1->prop.get(), rely1->body->prop.get()}, Prop());
                    rely1->body = rely1->body->body;
                }
                else if (res == Z3Result::True)
                {
                    rely1->prop = rely1->body->prop;
                    rely1->body = rely1->body->body;
                }
                else
                {
                    rely1->prop = Expr("false", {}, Prop());
                    rely1->body = rely1->body->body;
                }
            }
        }
        rely1->body = merge_rely(proj, rely1->body.get(), state);
    }
    else {
        throw std::runtime_error("Unknown node type: " + std::string(typeid(spec).name()));
    }
    return spec;
}

SpecNode* remove_rely_by_z3(Project* proj, SpecNode* spec, shared_ptr<EvalState> state)
{
    return merge_rely(proj, spec, state);
}


SpecNode* simple_rely_by_z3(Project* proj, Rely* spec, shared_ptr<EvalState> state)
{
    auto cond = rule_simple_by_z3(proj, spec->prop.get(), state);
    if (cond == nullptr) return nullptr;
    auto c = z3_eval(proj, cond, state);
    auto res = z3_check(state, c.get_z3_value(), 1000);
    if (res == Z3Result::Unknown)
    {
        state->conds->push_back(c.get_z3_value());
        auto body = rule_simple_by_z3(proj, spec->body.get(), state);
        if (body == nullptr) return nullptr;
        return new Rely(cond, body);
    }
    else if (res == Z3Result::True)
    {
        if (TR.ANNOTATE && false)
        {
            auto body = rule_simple_by_z3(proj, spec->body.get(), state);
            if (body == nullptr) return nullptr;
            return new Anno(cond, rule_simple_by_z3(proj, spec->body.get(), state));
        }
        else
        {
            return rule_simple_by_z3(proj, spec->body.get(), state);
        }
    }
    else
    {
        return nullptr;
    }
}

SpecNode* simple_anno_by_z3(Project* proj, Anno* spec, shared_ptr<EvalState> state)
{
    auto body = rule_simple_by_z3(proj, spec->body.get(), state);
    if (body == nullptr) return nullptr;
    return new Anno(spec->prop, body);
}

SpecNode* simple_if_by_z3(Project* proj, If* spec, shared_ptr<EvalState> state)
{
    auto cond = rule_simple_by_z3(proj, spec->cond.get(), state);
    if (cond == nullptr) return nullptr;
    auto c = z3_eval(proj, cond, state);
    auto res = z3_check(state, c.get_z3_value(), 1000);
    if (res == Z3Result::Unknown)
    {
        state->conds->push_back(c.get_z3_value());
        auto then_body = rule_simple_by_z3(proj, spec->then_body.get(), state);
        state->conds->back() = z3::expr(z3ctx, Z3_mk_not(z3ctx, c.get_z3_value()));
        auto else_body = rule_simple_by_z3(proj, spec->else_body.get(), state);
        if (then_body == nullptr && else_body == nullptr)
        {
            return nullptr;
        }
        else if (then_body == nullptr && dynamic_cast<Option*>(else_body->get_type()))
        {
            return new Rely(Expr("=", {cond, new BoolConst(false)}), else_body);
        }
        else if (else_body == nullptr && dynamic_cast<Option*>(then_body->get_type()))
        {
            return new Rely(Expr("=", {cond, new BoolConst(true)}), then_body);
        }
        if (then_body == nullptr) then_body = spec->then_body.get();
        if (else_body == nullptr) else_body = spec->else_body.get();
        return new If(cond, then_body, else_body);
    }
    else if (res == Z3Result::True)
    {
        if (TR.ANNOTATE && false)
        {
            return new Anno(Expr("=", {cond, new BoolConst(true)}, Prop()), rule_simple_by_z3(proj, spec->then_body.get(), state));
        }
        else
        {
            return rule_simple_by_z3(proj, spec->then_body.get(), state);
        }
    }
    else
    {
        if (TR.ANNOTATE && false)
        {
            return new Anno(Expr("=", {cond, new BoolConst(false)}, Prop()), rule_simple_by_z3(proj, spec->else_body.get(), state));
        }
        else
        {
            return rule_simple_by_z3(proj, spec->else_body.get(), state);
        }
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
void resolve_pattern(Project* proj, SpecNode* pat, SpecValue* src, shared_ptr<EvalState> new_state)
{
    if (auto sym = instance_of(pat, Symbol))
    {
        if (proj->is_ind_constr(sym->text))
        {
            auto t = src->get_type();
            new_state->conds->push_back(src->get_z3_value() == t.construct(sym->text, {}).get_z3_value());
        }
        else
        {
            (*new_state->vars)[sym->text] = src;
        }
    }
    else if (auto con = instance_of(pat, Const))
    {
        new_state->conds->push_back(src->get_z3_value() == StringValue(con->value).get_z3_value());
    }
    else if (auto expr = instance_of(pat, Expr))
    {
        if (expr->op == "Some")
        {
            auto t = src->get_type();
            assert(dynamic_cast<Option*>(t));
            auto v = t->elem_type->declare("v", spec->nid);
            if (auto tuple = dynamic_cast<Tuple*>(expr->elems[0].get()))
            {
                auto elem0 = tuple->elems[0]->type->declare(tuple->elems[0]->text, tuple->elems[0]->id);
                auto elem1 = tuple->elems[1]->type->declare(tuple->elems[1]->text, tuple->elems[1]->id);
                v = t->elem_type->construct({elem0, elem1});
                (*new_state->vars)[tuple->elems[0]->text] = elem0;
                (*new_state->vars)[tuple->elems[1]->text] = elem1;
            }
            resolve_pattern(proj, expr->elems[0].get(), src->get("value"), new_state);
            if (auto tuple = dynamic_cast<Tuple*>(expr->elems[0].get()))
            {
                auto new_elem0 = (*new_state->vars)[tuple->elems[0]->text];
                auto new_elem1 = (*new_state->vars)[tuple->elems[1]->text];
            }
        }
        else if (expr->op == "Tuple")
        {
            for (int i = 0; i < expr->elems.size(); i++)
            {
                resolve_pattern(proj, expr->elems[i].get(), src->get(i), new_state);
            }
        }
        else if (expr->op == "::")
        {
            auto t = src->get_type();
            assert(dynamic_cast<List*>(t));
            auto hh = t->element_type->declare("h", spec->nid);
            auto tt = t->declare("t", spec->nid);
            resolve_pattern(proj, expr->elems[0].get(), src->get("head"), new_state);
            resolve_pattern(proj, expr->elems[1].get(), src->get("tail"), new_state);
        }
        else if (auto sym = instance_of(pat, Symbol))
        {
            auto t = src->get_type();
            assert(dynamic_cast<Inductive*>(t));
            auto vars = [arg.type->declare(f"v{i}", spec->nid) for i, arg in enumerate(t->constr[pat->op])];
            for (int i = 0; i < t->constr[pat->op].size(); i++)
            {
                resolve_pattern(proj, pat->elems[i].get(), src->get(t->constr[pat->op][i].name), new_state);
            }
        }
    }
    else
    {
        throw std::runtime_error("Unknown pattern: " + std::string(typeid(pat).name()));
    }
}

/*
def simple_match_by_z3(proj, spec: Match, state={"vars": {}, "conds": []}):
    src = rule_simple_by_z3(proj, spec.src, state)
    if src is None: return None
    src_val = z3_eval(proj, src, state)
    match_list = []

    for pm in spec.match_list:
        new_state = copy_state(state)
        resolve_pattern(pm.pattern, src_val)
        if z3_check(new_state) is False:
            continue
        body = rule_simple_by_z3(proj, pm.body, new_state)
        if body is not None:
            match_list.append(PatternMatch(pm.pattern, body))

    if isinstance(src.get_type(), Option) and isinstance(spec.get_type(), Option):
        has_some = False
        has_none = False
        for pm in spec.match_list:
            if isinstance(pm.pattern, Expr) and pm.pattern.op == "Some":
                has_some = True
            elif isinstance(pm.pattern, Symbol) and pm.pattern.text == "None":
                has_none = True
            elif isinstance(pm.pattern, Symbol) and pm.pattern.text == "_":
                has_some = True
                has_none = True
        if (not has_some) or (not has_none):
            match_list.append(PatternMatch(Symbol("_", src.get_type()), Symbol("None", spec.get_type())))
    if len(match_list) == 0:
        return None
    else:
        def extract_rely_anno(spec):
            while isinstance(spec, Rely) or isinstance(spec, Anno):
                spec = spec.body
            return spec
        # Naively checking whether all patterns return None
        only_none = True
        for pm in match_list:
            body = extract_rely_anno(pm.body)
            if not (isinstance(body, Symbol) and body.text == "None"):
                only_none = False
                break
        if only_none:
            return Symbol("None", spec.get_type())
        else:
            return Match(src, match_list)
*/
SpecNode* simple_match_by_z3(Project* proj, Match* spec, shared_ptr<EvalState> state)
{
    auto src = rule_simple_by_z3(proj, spec->src.get(), state);
    if (src == nullptr) return nullptr;
    auto src_val = z3_eval(proj, src, state);
    vector<shared_ptr<PatternMatch>> match_list;

    for (auto pm : *spec->match_list)
    {
        shared_ptr<EvalState> new_state = copy_state(state);
        resolve_pattern(proj, pm->pattern.get(), src_val.get(), new_state);
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
def rule_simple_by_z3(proj, spec: SpecNode, state={"vars": {}, "conds": []}):
    state = copy_state(state)

    if isinstance(spec, Symbol):
        return spec

    elif isinstance(spec, Const):
        return spec

    elif isinstance(spec, Expr):
        return simple_expr_by_z3(proj, spec, state)
        
    elif isinstance(spec, Match):
        return simple_match_by_z3(proj, spec, state)

    elif isinstance(spec, Rely):
        return simple_rely_by_z3(proj, spec, state)

    elif isinstance(spec, Anno):
        return simple_anno_by_z3(proj, spec, state)
        
    elif isinstance(spec, If):
        return simple_if_by_z3(proj, spec, state)

    elif isinstance(spec, Forall):
        for v in spec.vars:
            state["vars"][v.name] = v.type.declare(v.name, spec.nid)
        spec = Forall(spec.vars, rule_simple_by_z3(proj, spec.body, state))
        spec.clear_z3_eval()
        return spec

    elif isinstance(spec, Exists):
        for v in spec.vars:
            state["vars"][v.name] = v.type.declare(v.name, spec.nid)
        spec = Exists(spec.vars, rule_simple_by_z3(proj, spec.body, state))
        spec.clear_z3_eval()
        return spec

    else:
        raise Exception("Unknown node type: " + str(type(spec)))
*/

SpecNode* rule_simple_by_z3(Project* proj, SpecNode* spec, shared_ptr<EvalState> state)
{
    if (auto sym = instance_of(spec, Symbol))
    {
        return spec;
    }
    else if (auto con = instance_of(spec, Const))
    {
        return spec;
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
            (*state->vars)[v->name] = v->type->declare(v->name, forall->nid);
        }
        forall->body = rule_simple_by_z3(proj, forall->body.get(), state);
        forall->clear_z3_eval();
        return forall;
    }
    else if (auto exists = instance_of(spec, Exists))
    {
        for (auto v : exists->vars)
        {
            (*state->vars)[v->name] = v->type->declare(v->name, exists->nid);
        }
        exists->body = rule_simple_by_z3(proj, exists->body.get(), state);
        exists->clear_z3_eval();
        return exists;
    }
    else
    {
        throw std::runtime_error("Unknown node type: " + std::string(typeid(spec).name()));
    }
}

/*
def rule_check_pure_by_z3(proj, spec: SpecNode, in_st: StructValue):
    st_type_name = in_st.type.name

    if isinstance(spec, Rely) or isinstance(spec, Anno):
        return rule_check_pure_by_z3(proj, spec.body, in_st)
    elif isinstance(spec, Expr):
        if isinstance(spec.type, Option):
            if isinstance(spec.type.elem_type, Tuple):
                spec = spec.elems[0]
                st_idx = -1
                for idx, et in enumerate(spec.type.elems):
                    if et.type.name == st_type_name:
                        st_idx = idx
                        break
                if st_idx == -1:
                    # Expr should always return a state?
                    raise Exception("No returning state found in:\n" + str(spec))
                st_eval = spec.elems[st_idx].z3_eval
                if st_eval.value.eq(in_st.value):
                    return True
                else:
                    return False
            elif isinstance(spec.type.elem_type, Symbol) and spec.text == "None":
                return True
            else:
                False
    elif isinstance(spec, If):
        then_res = rule_check_pure_by_z3(proj, spec.then_body, in_st)
        else_res = rule_check_pure_by_z3(proj, spec.else_body, in_st)
        return then_res and else_res
    elif isinstance(spec, Match):
        for pm in spec.match_list:
            if not rule_check_pure_by_z3(proj, pm.body, in_st):
                return False
        return True
    elif isinstance(spec, Symbol):
        if spec.text == "None":
            return True
        else:
            raise Exception("rule_check_pure_by_z3: Unexpected symbol: " + spec.text)
    else:
        raise Exception("rule_check_pure_by_z3: Unexpected node type: " + str(type(spec)))
*/

bool rule_check_pure_by_z3(Project* proj, SpecNode* spec, StructValue* in_st)
{
    auto st_type_name = in_st->type->name;

    if (auto rely = instance_of(spec, Rely) || auto anno = instance_of(spec, Anno))
    {
        return rule_check_pure_by_z3(proj, rely->body.get(), in_st);
    }
    else if (auto expr = instance_of(spec, Expr))
    {
        if (auto opt = dynamic_cast<Option*>(expr->type.get()))
        {
            if (auto tuple = dynamic_cast<Tuple*>(opt->elem_type.get()))
            {
                auto st_idx = -1;
                for (int idx = 0; idx < expr->type->elems.size(); idx++)
                {
                    if (expr->type->elems[idx]->type->name == st_type_name)
                    {
                        st_idx = idx;
                        break;
                    }
                }
                if (st_idx == -1)
                {
                    throw std::runtime_error("No returning state found in:\n" + str(expr));
                }
                auto st_eval = expr->elems[st_idx]->z3_eval;
                if (st_eval->value.eq(in_st->value))
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            else if (auto sym = dynamic_cast<Symbol*>(opt->elem_type.get()))
            {
                if (expr->text == "None")
                {
                    return true;
                }
                else
                {
                    throw std::runtime_error("rule_check_pure_by_z3: Unexpected symbol: " + expr->text);
                }
            }
        }
    }
    else if (auto if_ = instance_of(spec, If))
    {
        auto then_res = rule_check_pure_by_z3(proj, if_->then_body.get(), in_st);
        auto else_res = rule_check_pure_by_z3(proj, if_->else_body.get(), in_st);
        return then_res && else_res;
    }
    else if (auto match = instance_of(spec, Match))
    {
        for (auto pm : *match->match_list)
        {
            if (!rule_check_pure_by_z3(proj, pm->body.get(), in_st))
            {
                return false;
            }
        }
        return true;
    }
    else if (auto sym = instance_of(spec, Symbol))
    {
        if (sym->text == "None")
        {
            return true;
        }
        else
        {
            throw std::runtime_error("rule_check_pure_by_z3: Unexpected symbol: " + sym->text);
        }
    }
    else
    {
        throw std::runtime_error("rule_check_pure_by_z3: Unexpected node type: " + std::string(typeid(spec).name()));
    }
}

} // namespace autov