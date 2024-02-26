#include <nodes.h>
#include <values.h>
#include <utils.h>
#include <shortcuts.h>
#include <project.h>
#include <cassert>
#include <utility>
#include <rules.h>

namespace autov {
/*
recursively subst [name] with [value] in [spec] until [name] is assigned by a value using Match in [spec]
e.g.
subst(let x := x + 1 in x, "x", 1) => let x := 1 + 1 in x

[spec] is freed is subsitution is successful
[value] is freed by the caller
*/
static SpecNode* subst(SpecNode *spec, string name, SpecNode *value, bool &succ) {
    if (auto s = instance_of(spec, Symbol)) {
        if (s->text != name)
            return spec;

        auto new_value = value->deep_copy();
        if (is_instance(new_value.get(), Symbol))
            new_value->set_type(s->type);
        delete s;
        succ = true;
        return new_value.release();
    } else if (auto e = instance_of(spec, Expr)) {
        auto elems = make_unique<vector<unique_ptr<SpecNode>>>();

        for (auto &elem : *e->elems)
            elems->push_back(unique_ptr<SpecNode>(subst(elem.release(), name, value, succ)));
        return std::visit([&](auto&& arg) -> Expr* {
            using T = std::decay_t<decltype(arg)>;
            if constexpr (std::is_same_v<T, std::unique_ptr<SpecNode>>) {
                auto op = arg.release();
                auto new_op = std::unique_ptr<SpecNode>(subst(op, name, value, succ));
                auto new_expr = new Expr(std::move(new_op), std::move(elems), e->type);
                delete e;
                return new_expr;
            } else {
                auto new_expr = new Expr(arg, std::move(elems), e->type);
                delete e;
                return new_expr;
            }
        }, e->op);
    } else if (auto m = instance_of(spec, Match)) {
        std::function<bool(SpecNode*)> exists_in_pattern;

        exists_in_pattern = [&](SpecNode *pattern) -> bool {
            if (auto s = instance_of(pattern, Symbol)) {
                return s->text == name;
            } else if (auto e = instance_of(pattern, Expr)) {
                for (auto &elem : *e->elems)
                    if (exists_in_pattern(elem.get()))
                        return true;
            }
            return false;
        };

        auto src = subst(m->src.release(), name, value, succ);
        auto matches = make_unique<vector<unique_ptr<PatternMatch>>>();

        for (auto &pm : *m->match_list) {
            if (!exists_in_pattern(pm->pattern.get())) {
                auto new_body = subst(pm->body.release(), name, value, succ);
                matches->push_back(make_unique<PatternMatch>(pm->pattern->deep_copy(), unique_ptr<SpecNode>(new_body)));
            } else {
                matches->push_back(pm->deep_copy_down());
            }
        }
        auto new_match = new Match(unique_ptr<SpecNode>(src), std::move(matches));
        delete m;
        return new_match;
    } else if (auto r = instance_of(spec, Rely)) {
        auto new_rely = new Rely(unique_ptr<SpecNode>(subst(r->prop.release(), name, value, succ)),
                                 unique_ptr<SpecNode>(subst(r->body.release(), name, value, succ)));
        delete r;
        return new_rely;
    } else if (auto r = instance_of(spec, Anno)) {
        auto new_anno = new Anno(unique_ptr<SpecNode>(subst(r->prop.release(), name, value, succ)),
                                 unique_ptr<SpecNode>(subst(r->body.release(), name, value, succ)));
        delete r;
        return new_anno;
    } else if (auto i = instance_of(spec, If)) {
        auto new_if = new If(unique_ptr<SpecNode>(subst(i->cond.release(), name, value, succ)),
                             unique_ptr<SpecNode>(subst(i->then_body.release(), name, value, succ)),
                             unique_ptr<SpecNode>(subst(i->else_body.release(), name, value, succ)));
        delete i;
        return new_if;
    } else if (auto fe = instance_of(spec, Forall)) {
        auto vars = new vector<shared_ptr<Arg>>(*fe->vars.get());

        auto new_forall = new Forall(unique_ptr<vector<shared_ptr<Arg>>>(vars),
                                     unique_ptr<SpecNode>(subst(fe->body.release(), name, value, succ)));
        delete fe;
        return new_forall;
    } else if (auto fe = instance_of(spec, Exists)) {
        auto vars = new vector<shared_ptr<Arg>>(*fe->vars.get());

        auto new_exists = new Exists(unique_ptr<vector<shared_ptr<Arg>>>(vars),
                                     unique_ptr<SpecNode>(subst(fe->body.release(), name, value, succ)));
        delete fe;
        return new_exists;
    } else if (is_instance(spec, Const)) {
        // pass
    } else
        throw std::runtime_error("Unknown SpecNode type: " + string(*spec->get_type()));
    return spec;
}

static string pick_new_name(string sym, std::set<string> &prev) {
    string new_sym = sym;

    while (prev.find(new_sym) != prev.end()) {
        auto frags = split(new_sym, '_');

        if (frags.size() > 1) {
            try {
                int n = std::stoi(frags.back());
                frags.pop_back();
                new_sym = join(frags, "_") + "_" + std::to_string(n + 1);
            } catch (...) {
                new_sym = sym + "_0";
            }
        }
        else
            new_sym = sym + "_0";
    }
    return new_sym;
}

/*
[spec] is freed if substitution is successful
*/
SpecNode *eliminiate_ambiguity(Project *proj, SpecNode *spec, std::set<string> &prev_symbols) {
    if (auto e = instance_of(spec, Expr)) {
        auto elems = make_unique<vector<unique_ptr<SpecNode>>>();

        for (auto &elem : *e->elems)
            elems->push_back(unique_ptr<SpecNode>(eliminiate_ambiguity(proj, elem.release(), prev_symbols)));

        return std::visit([&](auto&& arg) -> Expr* {
            using T = std::decay_t<decltype(arg)>;
            if constexpr (std::is_same_v<T, std::unique_ptr<SpecNode>>) {
                auto op = arg.release();
                auto new_op = std::unique_ptr<SpecNode>(eliminiate_ambiguity(proj, op, prev_symbols));
                auto new_expr = new Expr(std::move(new_op), std::move(elems), e->type);
                delete e;
                return new_expr;
            } else {
                auto new_expr = new Expr(arg, std::move(elems), e->type);
                delete e;
                return new_expr;
            }
        }, e->op);
    } else if (auto m = instance_of(spec, Match)) {
        auto src = eliminiate_ambiguity(proj, m->src.release(), prev_symbols);
        auto matches = make_unique<vector<unique_ptr<PatternMatch>>>();

        for (auto &pm : *m->match_list) {
            std::set<string> symbols;
            std::function<void(SpecNode*)> collect_symbols = [&](SpecNode *pattern) {
                if (auto s = instance_of(pattern, Symbol))
                    symbols.insert(s->text);
                else if (auto e = instance_of(pattern, Expr)) {
                    for (auto &elem : *e->elems)
                        collect_symbols(elem.get());
                }
            };
            collect_symbols(pm->pattern.get());
            auto prev = std::set<string>(prev_symbols);
            auto pattern = pm->pattern->deep_copy().release();
            auto body = pm->body->deep_copy().release();

            for (auto &sym : symbols) {
                if (sym == "_")
                    continue;
                if (!proj->is_known_symbol(sym)) {
                    auto new_sym = pick_new_name(sym, prev);
                    prev.insert(new_sym);
                    if (sym != new_sym) {
                        auto new_symbol = new Symbol(new_sym, SpecType::UNKNOWN_TYPE);
                        bool succ;
                        pattern = subst(pattern, sym, new_symbol, succ);
                        body = subst(body, sym, new_symbol, succ);
                        delete new_symbol;
                    }
                }
            }
            body = eliminiate_ambiguity(proj, body, prev);
            matches->push_back(make_unique<PatternMatch>(unique_ptr<SpecNode>(pattern), unique_ptr<SpecNode>(body)));
        }

        auto new_match = new Match(unique_ptr<SpecNode>(src), std::move(matches));
        delete m;
        return new_match;
    }
    else if (auto r = instance_of(spec, Rely)) {
        auto new_rely = new Rely(unique_ptr<SpecNode>(eliminiate_ambiguity(proj, r->prop.release(), prev_symbols)),
                                 unique_ptr<SpecNode>(eliminiate_ambiguity(proj, r->body.release(), prev_symbols)));
        delete r;
        return new_rely;
    } else if (auto r = instance_of(spec, Anno)) {
        auto new_anno = new Anno(unique_ptr<SpecNode>(eliminiate_ambiguity(proj, r->prop.release(), prev_symbols)),
                                 unique_ptr<SpecNode>(eliminiate_ambiguity(proj, r->body.release(), prev_symbols)));
        delete r;
        return new_anno;
    } else if (auto i = instance_of(spec, If)) {
        auto new_if = new If(unique_ptr<SpecNode>(eliminiate_ambiguity(proj, i->cond.release(), prev_symbols)),
                             unique_ptr<SpecNode>(eliminiate_ambiguity(proj, i->then_body.release(), prev_symbols)),
                             unique_ptr<SpecNode>(eliminiate_ambiguity(proj, i->else_body.release(), prev_symbols)));
        delete i;
        return new_if;
    } else if (auto fe = instance_of(spec, ForallExists)) {
        auto prev = std::set<string>(prev_symbols);
        auto body = fe->body->deep_copy().release();
        auto vars = new vector<shared_ptr<Arg>>(*fe->vars.get());

        for (auto &v : *vars) {
            auto new_name = pick_new_name(v->name, prev_symbols);

            if (v->name != new_name) {
                auto new_symbol = new Symbol(new_name, SpecType::UNKNOWN_TYPE);
                bool succ;
                body = subst(body, v->name, new_symbol, succ);
                delete new_symbol;
            }
            prev.insert(new_name);
        }

        if (is_instance(fe, Forall)) {
            auto new_fe = new Forall(unique_ptr<vector<shared_ptr<Arg>>>(vars),
                                     unique_ptr<SpecNode>(eliminiate_ambiguity(proj, body, prev)));
            delete fe;
            return new_fe;
        } else {
            auto new_fe = new Exists(unique_ptr<vector<shared_ptr<Arg>>>(vars),
                                     unique_ptr<SpecNode>(eliminiate_ambiguity(proj, body, prev)));
            delete fe;
            return new_fe;
        }
    }

    return spec;
}

/*
recursively apply [f] to all nodes in [spec]
[f] must be a function from SpecNode to SpecNode
e.g. SpecNode(child_1, child_2, ...) => f(SpecNode(f(child_1), f(child_2), ..))
*/
static SpecNode *rec_apply(SpecNode *spec, std::function<SpecNode*(SpecNode*)> f, bool apply_anno = true) {
    if (is_instance(spec, Symbol))
        return f(spec);
    else if(is_instance(spec, Const))
        return f(spec);
    else if (auto e = instance_of(spec, Expr)) {
        auto elems = make_unique<vector<unique_ptr<SpecNode>>>();

        for (auto &elem : *e->elems)
            elems->push_back(unique_ptr<SpecNode>(rec_apply(elem.release(), f, apply_anno)));

        e->elems.release();
        return std::visit([&](auto&& arg) -> SpecNode* {
            using T = std::decay_t<decltype(arg)>;
            if constexpr (std::is_same_v<T, std::unique_ptr<SpecNode>>) {
                auto op = arg.release();
                auto new_op = std::unique_ptr<SpecNode>(rec_apply(op, f, apply_anno));
                return f(new Expr(std::move(new_op), std::move(elems), e->type));
            } else {
                return f(new Expr(arg, std::move(elems), e->type));
            }
        }, e->op);
    } else if (auto m = instance_of(spec, Match)) {
        auto src = rec_apply(m->src.release(), f, apply_anno);
        auto matches = make_unique<vector<unique_ptr<PatternMatch>>>();

        for (auto &pm : *m->match_list) {
            matches->push_back(make_unique<PatternMatch>(pm->pattern->deep_copy(),
                                                         unique_ptr<SpecNode>(rec_apply(pm->body.release(),
                                                                                        f,
                                                                                        apply_anno))));
        }

        return f(new Match(unique_ptr<SpecNode>(src), std::move(matches)));
    } else if (auto r = instance_of(spec, Rely)) {
        return f(new Rely(unique_ptr<SpecNode>(rec_apply(r->prop.release(), f, apply_anno)),
                          unique_ptr<SpecNode>(rec_apply(r->body.release(), f, apply_anno))));
    } else if (auto r = instance_of(spec, Anno)) {
        return f(new Anno(unique_ptr<SpecNode>(rec_apply(r->prop.release(), f, apply_anno)),
                        unique_ptr<SpecNode>(rec_apply(r->body.release(), f, apply_anno))));
    } else if (auto i = instance_of(spec, If)) {
        return f(new If(unique_ptr<SpecNode>(rec_apply(i->cond.release(), f, apply_anno)),
                      unique_ptr<SpecNode>(rec_apply(i->then_body.release(), f, apply_anno)),
                      unique_ptr<SpecNode>(rec_apply(i->else_body.release(), f, apply_anno))));
    } else if (auto fe = instance_of(spec, Forall)) {
        return f(new Forall(make_unique<vector<shared_ptr<Arg>>>(*fe->vars),
                          unique_ptr<SpecNode>(rec_apply(fe->body.release(), f, apply_anno))));
    } else if (auto fe = instance_of(spec, Exists)) {
        return f(new Exists(make_unique<vector<shared_ptr<Arg>>>(*fe->vars),
                          unique_ptr<SpecNode>(rec_apply(fe->body.release(), f, apply_anno))));
    } else
        throw std::runtime_error("Unknown SpecNode " + string(*spec));
}

static void get_vars_from_pattern(Project *proj, SpecNode *pattern, std::set<string> &vars) {
    if (auto s = instance_of(pattern, Symbol)) {
        if (proj->is_known_symbol(s->text) && pattern->get_type() != SpecType::UNKNOWN_TYPE)
            vars.insert(s->text);
    } else if (auto e = instance_of(pattern, Expr)) {
        if (auto *o = std::get_if<unique_ptr<SpecNode>>(&e->op))
            get_vars_from_pattern(proj, o->get(), vars);
        for (auto &elem : *e->elems)
            get_vars_from_pattern(proj, elem.get(), vars);
    }
}

static bool contains_vars(Project *proj, SpecNode *spec, std::set<string>vars) {
    if (auto s = instance_of(spec, Symbol))
        return vars.find(s->text) != vars.end();
    else if (auto e = instance_of(spec, Expr)) {
        if (auto *o = std::get_if<unique_ptr<SpecNode>>(&e->op))
            if (contains_vars(proj, o->get(), vars))
                return true;
        for (auto &elem : *e->elems)
            if (contains_vars(proj, elem.get(), vars))
                return true;
    } else if (auto m = instance_of(spec, Match)) {
        if (contains_vars(proj, m->src.get(), vars))
            return true;
        for (auto &pm : *m->match_list) {
            auto pm_vars = std::set<string>();
            std::set<string> diff;

            get_vars_from_pattern(proj, pm->pattern.get(), pm_vars);
            std::set_difference(vars.begin(), vars.end(), pm_vars.begin(), pm_vars.end(), std::inserter(diff, diff.begin()));
            if (contains_vars(proj, pm->body.get(), diff))
                return true;
        }
    } else if (auto r = instance_of(spec, Rely)) {
        if (contains_vars(proj, r->prop.get(), vars) || contains_vars(proj, r->body.get(), vars))
            return true;
    } else if (auto r = instance_of(spec, Anno)) {
        if (contains_vars(proj, r->prop.get(), vars) || contains_vars(proj, r->body.get(), vars))
            return true;
    } else if (auto i = instance_of(spec, If)) {
        if (contains_vars(proj, i->cond.get(), vars) || contains_vars(proj, i->then_body.get(), vars) || contains_vars(proj, i->else_body.get(), vars))
            return true;
    } else if (auto fe = instance_of(spec, Forall)) {
        if (contains_vars(proj, fe->body.get(), vars))
            return true;
    } else if (auto fe = instance_of(spec, Exists)) {
        if (contains_vars(proj, fe->body.get(), vars))
            return true;
    }

    return false;
}

/*
substitute [expr] with [var] in [spec]

[spec] is freed if substitution is successful
[expr] and [var] is freed by the caller
*/
static SpecNode *subst_expr(Project *proj, SpecNode *spec, SpecNode *expr, SpecNode *var, bool &succ) {
    if (*spec == *expr) {
        succ = true;
        return var->deep_copy().release();
    }

    if (auto e = instance_of(spec, Expr)) {
        auto elems = make_unique<vector<unique_ptr<SpecNode>>>();

        for (auto &elem : *e->elems)
            elems->push_back(unique_ptr<SpecNode>(subst_expr(proj, elem.release(), expr, var, succ)));
        e->elems.release();
        return std::visit([&](auto&& arg) -> Expr* {
            using T = std::decay_t<decltype(arg)>;
            if constexpr (std::is_same_v<T, std::unique_ptr<SpecNode>>) {
                auto op = arg.release();
                auto new_op = std::unique_ptr<SpecNode>(subst_expr(proj, op, expr, var, succ));
                auto new_expr = new Expr(std::move(new_op), std::move(elems), e->type);
                delete e;
                return new_expr;
            } else {
                auto new_expr = new Expr(arg, std::move(elems), e->type);
                delete e;
                return new_expr;
            }
        }, e->op);
    } else if (auto m = instance_of(spec, Match)) {
        auto src = subst_expr(proj, m->src.release(), expr, var, succ);
        auto matches = make_unique<vector<unique_ptr<PatternMatch>>>();

        for (auto &pm : *m->match_list) {
            auto vars = std::set<string>();
            get_vars_from_pattern(proj, pm->pattern.get(), vars);
            if (contains_vars(proj, expr, vars) || contains_vars(proj, var, vars))
                matches->push_back(pm->deep_copy_down());
            else
                matches->push_back(make_unique<PatternMatch>(pm->pattern->deep_copy(),
                                                             unique_ptr<SpecNode>(subst_expr(proj, pm->body.release(), expr, var, succ))));
        }
        auto new_match = new Match(unique_ptr<SpecNode>(src), std::move(matches));
        delete m;
        return new_match;
    } else if (auto r = instance_of(spec, Rely)) {
        auto new_rely = new Rely(unique_ptr<SpecNode>(subst_expr(proj, r->prop.release(), expr, var, succ)),
                                 unique_ptr<SpecNode>(subst_expr(proj, r->body.release(), expr, var, succ)));
        delete r;
        return new_rely;
    } else if (auto r = instance_of(spec, Anno)) {
        auto new_anno = new Anno(unique_ptr<SpecNode>(subst_expr(proj, r->prop.release(), expr, var, succ)),
                                 unique_ptr<SpecNode>(subst_expr(proj, r->body.release(), expr, var, succ)));
        delete r;
        return new_anno;
    } else if (auto i = instance_of(spec, If)) {
        auto new_if = new If(unique_ptr<SpecNode>(subst_expr(proj, i->cond.release(), expr, var, succ)),
                             unique_ptr<SpecNode>(subst_expr(proj, i->then_body.release(), expr, var, succ)),
                             unique_ptr<SpecNode>(subst_expr(proj, i->else_body.release(), expr, var, succ)));
        delete i;
        return new_if;
    } else if (auto fe = instance_of(spec, Forall)) {
        auto free_vars = std::set<string>();

        for (auto &v : *fe->vars)
            free_vars.insert(v->name);
        if (contains_vars(proj, expr, free_vars))
            return spec;
        auto new_forall = new Forall(make_unique<vector<shared_ptr<Arg>>>(*fe->vars),
                                     unique_ptr<SpecNode>(subst_expr(proj, fe->body.release(), expr, var, succ)));
        delete fe;
        return new_forall;
    } else if (auto fe = instance_of(spec, Exists)) {
    } else if (auto fe = instance_of(spec, Forall)) {
        auto free_vars = std::set<string>();

        for (auto &v : *fe->vars)
            free_vars.insert(v->name);

        if (contains_vars(proj, expr, free_vars))
            return spec;
        auto new_forall = new Forall(make_unique<vector<shared_ptr<Arg>>>(*fe->vars),
                                     unique_ptr<SpecNode>(subst_expr(proj, fe->body.release(), expr, var, succ)));
        delete fe;
        return new_forall;
    }
    return spec;
}

rule_ret_t rule_unfold_specs(Project *proj, SpecNode *spec) {
    bool unfolded = false;
    bool changed = false;

    std::function<SpecNode*(SpecNode*)> f = [&](SpecNode *node) -> SpecNode* {
        if (unfolded)
            return node;
        if (auto e = instance_of(node, Expr)) {
            if (auto op = std::get_if<string>(&e->op)) {
                if (proj->defs.find(*op) == proj->defs.end())
                    return node;

                auto define = proj->defs[*op].get();

                // std::cout << "======================================" << std::endl;
                // std::cout << "Unfold definition: " << string(*define) << std::endl;
                // std::cout << "======================================" << std::endl;

                auto body = define->body->deep_copy();
                assert(e->elems->size() == define->args->size());

                if (proj->symbols.find(define->name) != proj->symbols.end() &&
                    std::get<0>(proj->symbols[define->name].loc) != "")
                    unfolded = true;

                changed = true;
                if (e->elems->size() == 0)
                    return body.release();
                else if (e->elems->size() == 1) {
                    return Match::raw_let(define->args->at(0)->name, std::move(e->elems->at(0)), std::move(body),
                                          define->args->at(0)->type);
                } else {
                    auto tuple_type_list = make_shared<vector<shared_ptr<SpecType>>>();

                    for (auto &e: *e->elems)
                        tuple_type_list->push_back(e->get_type());

                    auto tuple_type = make_shared<Tuple>(tuple_type_list);
                    auto src = make_unique<Expr>(Expr::Tuple, std::move(e->elems), tuple_type);

                    auto pattern_list = make_unique<vector<unique_ptr<SpecNode>>>();

                    for (auto &arg: *define->args)
                        pattern_list->push_back(make_unique<Symbol>(arg->name, arg->type));

                    auto pattern = make_unique<Expr>(Expr::Tuple, std::move(pattern_list), tuple_type);
                    auto pm_list = make_unique<vector<unique_ptr<PatternMatch>>>();

                    pm_list->push_back(make_unique<PatternMatch>(std::move(pattern), std::move(body)));

                    return new Match(std::move(src), std::move(pm_list));
                }
            }
        }

        return node;
    };

    return std::make_pair(rec_apply(spec, f), changed);
}

class FieldPath {
public:
    string name;
    shared_ptr<SpecType> type;

    FieldPath(string name, shared_ptr<SpecType> type) : name(name), type(type) {}
};

static void search_field_path(Project *proj, string name, string parent, vector<FieldPath> &path) {
    shared_ptr<Struct> parent_t = proj->structs.at(parent);

    for (auto &f: *parent_t->elems) {
        if (f->name == name) {
            path.push_back(FieldPath(f->name, f->type));
            return;
        }

        auto type = f->type;

        if (auto z = instance_of(type.get(), ZMap)) {
            type = z->elem_type;
        } else if (auto z = instance_of(type.get(), List)) {
            type = z->elem_type;
        }

        if (!is_instance(type.get(), Struct)) {
            continue;
        }

        //std::cout << "Going to search " << type->name << " for " << name << std::endl;
        if (proj->structs.find(type->name) != proj->structs.end()) {
            search_field_path(proj, name, type->name, path);
            if (path.size() != 0) {
                return path.push_back(FieldPath(f->name, f->type));;
            }
        }
    }

    return;
}

static const std::set<string> interest_list = {"e_lock", "e_refcount", "log"};
static vector<vector<FieldPath>> collect_interest_path(Project *proj) {
    vector<vector<FieldPath>> interest_path;

    for (auto &i: interest_list) {
        vector<FieldPath> path;

        search_field_path(proj, i, proj->layers[0]->abs_data->name, path);
        if (path.size() != 0) {
            interest_path.push_back(path);
        }
    }

    return interest_path;
}

static vector<vector<FieldPath>> interest_path;

rule_ret_t rule_eliminiate_indifferent(Project *proj, SpecNode *spec, string fname) {
    bool changed = false;
    std::function<SpecNode*(SpecNode*)> f = [&](SpecNode *node) -> SpecNode* {
        if (auto e = instance_of(node, Expr)) {
            if (!std::holds_alternative<Expr::ops>(e->op) || std::get<Expr::ops>(e->op) != Expr::RecordSet)
                return node;

            // Only eliminate indifferent if the RecordSet is on the abs_data
            auto abs_data = proj->layers[0]->abs_data;

            if (e->elems->at(0)->get_type() != abs_data) {
                return node;
            }

            for (auto &elem: *e->elems) {
                if (auto s = instance_of(elem.get(), Symbol)) {
                    if (std::find(interest_list.begin(), interest_list.end(), s->text) == interest_list.end()) {
                        auto new_elems = make_unique<vector<unique_ptr<SpecNode>>>();

                        new_elems->push_back(std::move(e->elems->at(0)));

                        auto lens_name = fname + "_lens";
                        auto new_e = new Expr(lens_name, std::move(new_elems), e->type);
                        new_e->is_lens = true;
                        delete e;
                        changed = true;

                        if (!proj->is_known_symbol(lens_name)) {
                            auto arg_types = make_shared<vector<shared_ptr<SpecType>>>();

                            for (auto &t: *new_e->elems) {
                                arg_types->push_back(t->get_type());
                            }

                            auto lens_type = make_shared<Function>(new_e->type, arg_types);

                            auto lens = make_unique<Declaration>(lens_name, lens_type);

                            proj->add_declaration(std::move(lens), make_shared<loc_t>(Project::LOC_GLOBALDEFS, "", ""));
                        }
                        return new_e;
                    }
                }
            }
         }

        return node;
    };

    // if (interest_path.size() == 0) {
    //     interest_path = collect_interest_path(proj);
    // }

    return std::make_pair(rec_apply(spec, f), changed);
}

rule_ret_t rule_move_if_out_match(Project *proj, SpecNode *spec) {
    bool changed = false;

    std::function<SpecNode*(SpecNode*)> f = [&](SpecNode *node) -> SpecNode* {
        if (auto m = instance_of(node, Match))
            if (auto src = instance_of(m->src.get(), If)) {
                unique_ptr<Match> m1(static_cast<Match*>(m->deep_copy().release()));
                auto new_if = new If(std::move(src->cond),
                                     make_unique<Match>(std::move(src->then_body), std::move(m->match_list)),
                                     make_unique<Match>(std::move(src->else_body), std::move(m1->match_list)));

                delete m;
                changed = true;
                return new_if;
            }

        return node;
    };

    return std::make_pair(rec_apply(spec, f, false), changed);
}

rule_ret_t rule_move_if_out_expr(Project *proj, SpecNode *spec) {
    bool changed = false;

    std::function<SpecNode*(SpecNode*)> f = [&](SpecNode *node) -> SpecNode* {

        if (auto e = instance_of(node, Expr)) {
            for (size_t i = 0; i < e->elems->size(); i++) {
                if (auto elem = instance_of(e->elems->at(i).get(), If)) {
                    unique_ptr<Expr> e1 = e->deep_copy_down();
                    unique_ptr<Expr> e2 = e->deep_copy_down();
                    auto elems1 = make_unique<vector<unique_ptr<SpecNode>>>();
                    auto elems2 = make_unique<vector<unique_ptr<SpecNode>>>();

                    for (size_t j = 0; j < e->elems->size(); j++) {
                        if (j == i) {
                            elems1->push_back(std::move(elem->then_body));
                            elems2->push_back(std::move(elem->else_body));
                        } else {
                            elems1->push_back(std::move(e1->elems->at(j)));
                            elems2->push_back(std::move(e2->elems->at(j)));
                        }
                    }

                    auto new_if = new If(std::move(elem->cond),
                                        make_unique<Expr>(std::move(e1->op), std::move(elems1), e->type),
                                        make_unique<Expr>(std::move(e2->op), std::move(elems2), e->type));
                    delete e;
                    changed = true;
                    return new_if;
                }
            }
        }

        return node;
    };

    return std::make_pair(rec_apply(spec, f, false), changed);
}

rule_ret_t rule_move_match_out_expr(Project *proj, SpecNode *spec) {
    bool changed = false;

    std::function<SpecNode*(SpecNode*)> f = [&](SpecNode *node) -> SpecNode* {
        if (auto e = instance_of(node, Expr)) {
            for (size_t i = 0; i < e->elems->size(); i++) {
                if (auto elem = instance_of(e->elems->at(i).get(), Match)) {
                    bool movable = true;
                    for (auto &pm : *elem->match_list) {
                        std::set<string> vars;
                        get_vars_from_pattern(proj, pm->pattern.get(), vars);
                        for (size_t j = 0; j < e->elems->size(); j++) {
                            if (j == i)
                                continue;
                            if (contains_vars(proj, e->elems->at(j).get(), vars)) {
                                movable = false;
                                break;
                            }
                        }
                        if (!movable)
                            break;
                    }
                    if (movable) {
                        auto matches = make_unique<vector<unique_ptr<PatternMatch>>>();

                        for (auto &pm : *elem->match_list) {
                            auto elems = make_unique<vector<unique_ptr<SpecNode>>>();
                            for (size_t j = 0; j < e->elems->size(); j++) {
                                if (j == i)
                                    elems->push_back(std::move(pm->body));
                                else
                                    elems->push_back(e->elems->at(j)->deep_copy());
                            }
                            auto expr = unique_ptr<Expr>();

                            if (auto op = std::get_if<unique_ptr<SpecNode>>(&e->op))
                                expr = make_unique<Expr>(op->get()->deep_copy(), std::move(elems), e->type);
                            else
                                expr = make_unique<Expr>(std::move(e->op), std::move(elems), e->type);
                            matches->push_back(make_unique<PatternMatch>(std::move(pm->pattern),
                                                                         std::move(expr)));
                        }
                        auto new_match = new Match(std::move(elem->src), std::move(matches));
                        delete e;
                        changed = true;
                        return new_match;
                    }
                }
            }
        }
        return node;
    };

    return std::make_pair(rec_apply(spec, f, false), changed);
}

rule_ret_t rule_move_rely_out_when(Project *proj, SpecNode *spec) {
    bool changed = false;
    std::function<SpecNode*(SpecNode*)> f = [&](SpecNode *node) -> SpecNode* {
        if (auto m = instance_of(node, Match)) {
            if (auto r = instance_of(m->src.get(), Rely)) {
                if (instance_of(m->type.get(), Option)) {
                    for (auto &pm : *m->match_list) {
                        if (string(*pm->pattern) == "None" && string(*pm->body) == "None") {
                            auto new_rely = new Rely(std::move(r->prop),
                                                     make_unique<Match>(std::move(r->body), std::move(m->match_list)));
                            delete m;
                            changed = true;
                            return new_rely;
                        }
                    }
                    return node;
                }
            }
        }
        return node;
    };

    return std::make_pair(rec_apply(spec, f, false), changed);
}

/*
match (
  when [src->match_list->at(0)->pattern->elems] == [src->src];
  [src->match_list->at(0)->body]
) with
  [match_list]
end

===>

when [src->match_list->at(0)->pattern->elems] == [src->src];
match [src->match_list->at(0)->body] with
  [match_list]
end
*/
rule_ret_t rule_move_when_out_when(Project *proj, SpecNode *spec) {
    bool changed = false;

    std::function<SpecNode*(SpecNode*)> f = [&](SpecNode *node) -> SpecNode* {
        if (auto m = instance_of(node, Match)) {
            if (auto src = instance_of(m->src.get(), Match)) {
                if (src->is_when() && is_instance(m->type.get(), Option)) {
                    for (auto &pm : *m->match_list) {
                        if (string(*pm->pattern) == "None" && string(*pm->body) == "None") {
                            auto pattern = dynamic_cast<Expr*>(src->match_list->at(0)->pattern.get());
                            auto match = make_unique<Match>(std::move(src->match_list->at(0)->body), std::move(m->match_list));
                            auto new_match = Match::raw_when(std::move(pattern->elems->at(0)), std::move(src->src), std::move(match));
                            delete m;
                            changed = true;
                            return new_match;
                        }
                    }
                    return node;
                }
            }
        }
        return node;
    };

    return std::make_pair(rec_apply(spec, f, false), changed);
}

/*
if true then [then_body] else [else_body] ===> [then_body]
if false then [then_body] else [else_body] ===> [else_body]
if ... then [body] else [body] ===> [body]
if A then [then_body] else (if B then [then_body] else [else_body]) ===> if (A || B) then [then_body] else [else_body]
*/
rule_ret_t rule_eliminate_if(Project *proj, SpecNode *spec) {
    bool changed = false;
    std::function<SpecNode*(SpecNode*)> f = [&](SpecNode *node) -> SpecNode* {
        if (auto i = instance_of(node, If)) {
            if (auto cond = instance_of(i->cond.get(), Const)) {
                if (auto val = std::get_if<bool>(&cond->value)) {
                    SpecNode *new_node;

                    if (*val)
                        new_node = i->then_body.release();
                    else
                        new_node = i->else_body.release();

                    delete i;
                    changed = true;
                    return new_node;
                }
            }

            if (*i->then_body == *i->else_body) {
                auto new_node = i->then_body.release();

                delete i;
                changed = true;
                return new_node;
            }

            if (auto ei = instance_of(i->else_body.get(), If)) {
                if (*i->then_body == *ei->then_body) {
                    auto cond_elems = make_unique<vector<unique_ptr<SpecNode>>>();

                    cond_elems->push_back(std::move(i->cond));
                    cond_elems->push_back(std::move(ei->cond));

                    auto new_cond = new Expr(Expr::binops::BOR, std::move(cond_elems), Bool::BOOL);
                    auto new_if = new If(unique_ptr<SpecNode>(new_cond),
                                         unique_ptr<SpecNode>(ei->then_body.release()),
                                         unique_ptr<SpecNode>(ei->else_body.release()));

                    delete i;
                    changed = true;
                    return new_if;
                }
            }
        }
        return node;
    };

    return std::make_pair(rec_apply(spec, f, false), changed);
}

rule_ret_t rule_eliminate_let(Project *proj, SpecNode *spec) {
    bool changed = false;

    std::function<SpecNode*(SpecNode*)> f = [&](SpecNode *node) -> SpecNode* {
        if (auto m = instance_of(node, Match)) {
            if (m->is_let()) {
                if (auto pattern = instance_of(m->match_list->at(0)->pattern.get(), Symbol)) {
                    string name = pattern->text;
                    if (!proj->is_known_symbol(name)) {
                        SpecNode *value = m->src.get();
                        SpecNode *body = m->match_list->at(0)->body.release();
                        bool succ = false;

                        auto new_e = subst(body, name, value, succ);
                        delete m;
                        changed = true;

                        return new_e;
                    }
                }
            }
        }
        return node;
    };

    return std::make_pair(rec_apply(spec, f, false), changed);
}

static string get_constr(SpecNode *node) {
    if (auto p = instance_of(node, Symbol)) {
        return p->text;
    } else if (auto p = instance_of(node, Expr)) {
        if (holds_alternative<string>(p->op)) {
            return std::get<string>(p->op);
        } else if (auto op = std::get_if<Expr::ops>(&p->op)) {
            if (*op == Expr::Some)
                return "Some";
            else if (*op == Expr::None)
                return "None";
            else if (*op == Expr::Tuple)
                return "Tuple";
        }
    }

    return "";
}

//try to match [pattern] with [src], return true if match success, and [assign] will be
//filled with the matched variables, return [default] if not sure.
static bool try_match(Project *proj, SpecNode *pattern, SpecNode *src,
                      std::unordered_map<string, unique_ptr<SpecNode>> &assigns, bool def) {
    //std::cout << "try_match " << string(*src) << " with " << string(*pattern) << std::endl;
    if (auto p = instance_of(pattern, Const)) {
        if(auto s = instance_of(src, Const)) {
            return p->value == s->value;
        }
    }

    string patter_constr, src_constr;

    patter_constr = get_constr(pattern);
    src_constr = get_constr(src);

    if (patter_constr != "" && src_constr != "" &&
        (proj->is_ind_constr(patter_constr) || proj->is_struct_constr(patter_constr)) &&
        (proj->is_ind_constr(src_constr) || proj->is_struct_constr(src_constr))) {
        if (patter_constr != src_constr)
            return false;
        else {
            if (is_instance(pattern, Symbol) && is_instance(src, Symbol))
                return true;
            else {
                if (auto p = instance_of(pattern, Expr)) {
                    if (auto s = instance_of(src, Expr)) {
                        for (int i = 0; i < p->elems->size(); ++i) {
                            // std::cout << "    try_match elem" << string(*p->elems->at(i)) <<
                            //     " with " << string(*s->elems->at(i)) << std::endl;
                            if (!try_match(proj, p->elems->at(i).get(), s->elems->at(i).get(), assigns, def))
                                return false;
                        }
                        return true;
                    }
                }
            }
        }
    }

    if (auto p = instance_of(pattern, Symbol)) {
        if(!proj->is_known_symbol(p->text)) {
            assigns[p->text] = src->deep_copy();
            return true;
        }
    }

    return def;
}

rule_ret_t rule_eliminate_match_simple(Project *proj, SpecNode *spec) {
    bool changed = false;

    std::function<SpecNode*(SpecNode*)> f = [&] (SpecNode *node) -> SpecNode* {
        if (auto m = instance_of(node, Match)) {
            auto possible = false;
            for (int i = 0; i < m->match_list->size(); ++i) {
                std::unordered_map<string, unique_ptr<SpecNode>> assigns;
                if (try_match(proj, m->match_list->at(i)->pattern.get(), m->src.get(), assigns, true)) {
                    possible = true;
                    assigns.clear();
                    if (try_match(proj, m->match_list->at(i)->pattern.get(), m->src.get(), assigns, false)) {
                        unique_ptr<SpecNode> new_body = std::move(m->match_list->at(i)->body);
                        for (auto & [k,v] : assigns) {
                            auto t = v->get_type();
                            new_body = Match::let(k, std::move(v), std::move(new_body), t);
                        }
                        delete m;
                        changed = true;
                        return new_body.release();
                    }
                }
                if(possible)
                    break;
            }
            return node;
        } else {
            return node;
        }
    };

    return std::make_pair(rec_apply(spec, f, false), changed);
}

rule_ret_t rule_subst_match_src_with_content(Project *proj, SpecNode *spec) {
    bool changed = false;

    std::function<SpecNode*(SpecNode*)> f = [&] (SpecNode *node) -> SpecNode* {
        if (auto s = instance_of(node, Match)) {
            unique_ptr<vector<unique_ptr<PatternMatch>>> matches = make_unique<vector<unique_ptr<PatternMatch>>>();
            for (auto & pm : *s->match_list) {
                std::set<string> vars;
                get_vars_from_pattern(proj, pm->pattern.get(), vars);
                if (!contains_vars(proj, s->src.get(), vars)) {
                    //pattern will be deep copyed in subst_expr
                    bool succ = false;
                    auto body = subst_expr(proj, pm->body.release(), s->src.get(), pm->pattern.get(), succ);
                    matches->push_back(make_unique<PatternMatch>(std::move(pm->pattern), unique_ptr<SpecNode>(body)));
                    changed |= succ;
                } else {
                    matches->push_back(std::move(pm));
                }
            }
            auto new_match = new Match(std::move(s->src), std::move(matches));
            delete s;
            return new_match;
        }
        return node;
    };

    return std::make_pair(rec_apply(spec, f, false), changed);
}

rule_ret_t rule_simple_builtin_functions(Project* proj, SpecNode *spec) {
    bool changed = false;

    std::function<SpecNode*(SpecNode*)> f = [&] (SpecNode *node) -> SpecNode* {
        if(auto s = instance_of(node, Expr)) {
            if(holds_alternative<string>(s->op) && std::get<string>(s->op) == "ptr_to_int") {
                if(auto e = instance_of(s->elems->at(0).get(), Expr)) {
                    if(holds_alternative<string>(e->op) && std::get<string>(e->op) == "int_to_ptr") {
                        auto new_expr = e->elems->at(0).release();
                        delete s;
                        changed = true;
                        return new_expr;
                    }
                }
            }
        }

        if(auto s = instance_of(node, Expr)) {
            if(holds_alternative<string>(s->op) && std::get<string>(s->op) == "int_to_ptr") {
                if(auto e = instance_of(s->elems->at(0).get(), Expr)) {
                    if(holds_alternative<string>(e->op) && std::get<string>(e->op) == "ptr_to_int") {
                        auto new_expr = e->elems->at(0).release();
                        delete s;
                        changed = true;
                        return new_expr;
                    }
                }
            }
        }

        return node;
    };

    return std::make_pair(rec_apply(spec, f, false), changed);
}

/*
when X == (if c then (Some Y) else (Some Z)); body
=> if c then (match Y with X => body) else (match Z with X => body)
*/
rule_ret_t rule_eliminate_when(Project *proj, SpecNode *spec) {
    bool changed = false;

     std::function<SpecNode*(SpecNode*)> f = [&] (SpecNode *node) -> SpecNode* {
        SpecNode* when_body;
        if(auto m = instance_of(node, Match)) {
            if(m->is_when()) {
                auto pattern = dynamic_cast<Expr*>(m->match_list->at(0)->pattern.get());
                when_body = m->match_list->at(0)->body.get();
                std::function<SpecNode*(unique_ptr<SpecNode> &)> subst_when = [&] (unique_ptr<SpecNode> &node) -> SpecNode* {
                    if(auto m = instance_of(node.get(), Symbol)) {
                        if(m->text == "None") {
                            auto new_sym = new Symbol("None", when_body->get_type());
                            return new_sym;
                        } else {
                            return nullptr;
                        }
                    } else if(auto m = instance_of(node.get(), Expr)) {
                        if(holds_alternative<Expr::ops>(m->op) && std::get<Expr::ops>(m->op) == Expr::ops::Some) {
                            auto vec = make_unique<vector<unique_ptr<PatternMatch>>>();
                            vec->push_back(make_unique<PatternMatch>(pattern->elems->at(0)->deep_copy(), when_body->deep_copy()));
                            auto new_match = new Match(std::move(m->elems->at(0)), std::move(vec));
                            return new_match;
                        }
                        return nullptr;
                    } else if(auto m = instance_of(node.get(), Match)) {
                        auto vec = make_unique<vector<unique_ptr<PatternMatch>>>();
                        for(auto & pm : *m->match_list) {
                            auto subst_body = subst_when(pm->body);
                            if(subst_body == nullptr) {
                                return nullptr;
                            }
                            vec->push_back(make_unique<PatternMatch>(std::move(pm->pattern), unique_ptr<SpecNode>(subst_body)));
                        }
                        auto new_match = new Match(std::move(m->src), std::move(vec));
                        return new_match;
                    } else if(auto m = instance_of(node.get(), Rely)) {
                        auto body = subst_when(m->body);
                        if(body == nullptr)
                            return nullptr;
                        auto new_rely = new Rely(std::move(m->prop), unique_ptr<SpecNode>(body));
                        return new_rely;
                    } else if(auto m = instance_of(node.get(), Anno)) {
                        auto body = subst_when(m->body);
                        if(body == nullptr)
                            return nullptr;
                        auto new_anno = new Anno(std::move(m->prop), unique_ptr<SpecNode>(body));
                        return new_anno;
                    } else if(auto m = instance_of(node.get(), If)) {
                        auto then_body = subst_when(m->then_body);
                        auto else_body = subst_when(m->else_body);
                        if(then_body == nullptr || else_body == nullptr)
                            return nullptr;
                        auto new_if = new If(std::move(m->cond), unique_ptr<SpecNode>(then_body), unique_ptr<SpecNode>(else_body));
                        return new_if;
                    } else if(auto m = instance_of(node.get(), Forall)) {
                        return node.release();
                    } else if(auto m = instance_of(node.get(), Exists)) {
                        return node.release();
                    } else if(auto m = instance_of(node.get(), Const)) {
                        return nullptr;
                    } else {
                        throw std::runtime_error("Unknown node type:" + string(*node->type));
                    }
                };
                auto new_body = subst_when(m->src);
                if(new_body == nullptr)
                    return node;
                delete m;
                changed = true;
                return new_body;
            } else {
                return node;
            }
        } else {
            return node;
        }
     };

     return std::make_pair(rec_apply(spec, f, false), changed);
}

rule_ret_t replace_spec_name(Project *proj, SpecNode *spec, unordered_map<string, string> &name_map) {
    bool changed = false;

    std::function<SpecNode*(SpecNode*)> f = [&] (SpecNode *node) -> SpecNode* {
        if (auto e = instance_of(node, Expr)) {
            if (auto op = std::get_if<string>(&e->op)) {
                if (name_map.find(*op) != name_map.end()) {
                    auto new_op = name_map[*op];
                    auto new_elems = make_unique<vector<unique_ptr<SpecNode>>>();

                    for (auto &elem : *e->elems)
                        new_elems->push_back(elem->deep_copy());

                    auto new_expr = new Expr(new_op, std::move(new_elems), e->type);

                    delete e;
                    changed = true;
                    return new_expr;
                }
            }
        }

        return node;
    };

    return std::make_pair(rec_apply(spec, f, false), changed);
}

static vector<int> get_prime() {
    vector<int> vec;
    for(int i = 2; i < 1000; ++i) {
        auto is_prim = true;
        for(int j = 2; j * j <= i; ++j) {
            if(i % j == 0) {
                is_prim = false;
                break;
            }
        }
        if(is_prim) {
            vec.push_back(i);
        }
    }
    return vec;
}

static vector<int> PRIM_NUMS = get_prime();

SpecNode* try_divide_const_factor(SpecNode *expr, int factor) {
    if(auto m = instance_of(expr, IntConst)) {
        if(std::get<long long>(m->value) != 0 && std::get<long long>(m->value) % factor == 0) {
            return new IntConst(std::get<long long>(m->value) / factor);
        }
    } else if(auto m = instance_of(expr, Expr)) {
        if(holds_alternative<Expr::binops>(m->op)) {
            auto op = std::get<Expr::binops>(m->op);
            if((op == Expr::binops::ADD || op == Expr::binops::MINUS) && m->elems->size() == 2) {
                auto a = unique_ptr<SpecNode>(try_divide_const_factor(m->elems->at(0).get(), factor));
                auto b = unique_ptr<SpecNode>(try_divide_const_factor(m->elems->at(1).get(), factor));
                if(a == nullptr || b == nullptr) {
                    return nullptr;
                }
                auto elems = make_unique<vector<unique_ptr<SpecNode>>>();
                elems->push_back(std::move(a));
                elems->push_back(std::move(b));
                return new Expr(op, std::move(elems), m->get_type());
            } else if(op == Expr::binops::MULT) {
                auto a = unique_ptr<SpecNode>(try_divide_const_factor(m->elems->at(0).get(), factor));
                if(a != nullptr) {
                    auto elems = make_unique<vector<unique_ptr<SpecNode>>>();
                    elems->push_back(std::move(a));
                    elems->push_back(std::move(m->elems->at(1)));
                    return new Expr(op, std::move(elems), m->get_type());
                } 
                auto b = unique_ptr<SpecNode>(try_divide_const_factor(m->elems->at(1).get(), factor));
                if(b != nullptr) {
                    auto elems = make_unique<vector<unique_ptr<SpecNode>>>();
                    elems->push_back(std::move(m->elems->at(0)));
                    elems->push_back(std::move(b));
                    return new Expr(op, std::move(elems), m->get_type());
                }
                return nullptr;
            }
        }
    }

    return nullptr;
}

rule_ret_t rule_simplify_expr(Project *proj, SpecNode *spec) {
    bool expr_is_changed = false;

    std::function<SpecNode*(SpecNode*)> f = [&] (SpecNode *node) -> SpecNode* {
        unique_ptr<SpecNode> expr = unique_ptr<SpecNode>(node);

        if (auto m = instance_of(node, If)) {
            if (auto c = instance_of(m->cond.get(), BoolConst)) {
                if (std::get<bool>(c->value)) {
                    return m->then_body.release();
                } else {
                    return m->else_body.release();
                }
            }
        } else if (auto m = instance_of(node, Expr)) {
            if(holds_alternative<Expr::binops>(m->op)) {
                auto ops = std::get<Expr::binops>(m->op);
                using op = Expr::binops;
                std::set<op> vec = {op::EQUAL, op::NOT_EQUAL, op::LTE, op::GTE, op::GT, op::LT, op::BEQ,
                                    op:: BNE, op::BLT, op::BGT, op::BGE, op::BLE};

                if (vec.find(ops) != vec.end() && m->elems->at(0)->get_type() == Int::INT &&
                    m->elems->at(1)->get_type() == Int::INT && !is_instance(m->elems->at(1).get(), Const)) {
                    auto elems = new vector<unique_ptr<SpecNode>>();
                    elems->push_back(std::move(m->elems->at(0)));
                    elems->push_back(std::move(m->elems->at(1)));
                    auto left = new Expr(op::MINUS, unique_ptr<vector<unique_ptr<SpecNode>>>(elems), Int::INT);
                    auto right = new IntConst(0);

                    auto elems2 = new vector<unique_ptr<SpecNode>>();
                    elems2->push_back(unique_ptr<SpecNode>(left));
                    elems2->push_back(unique_ptr<SpecNode>(right));

                    return new Expr(ops, unique_ptr<vector<unique_ptr<SpecNode>>>(elems2), node->get_type());
                } else if ((ops == op::ADD || ops == op::MINUS) && m->elems->size() == 2 &&
                           (!is_instance(m->elems->at(0).get(), IntConst) || !is_instance(m->elems->at(1).get(), IntConst))) {
                    auto factor = 1;
                    for (auto i : PRIM_NUMS) {
                        while (1) {
                            auto a = try_divide_const_factor(expr.get(), i);

                            if(a == nullptr){
                                break;
                            }
                            factor *= i;

                            expr = unique_ptr<SpecNode>(a);
                        }
                    }

                    if (factor > 1) {
                        auto elems = make_unique<vector<unique_ptr<SpecNode>>>();
                        elems->push_back(make_unique<IntConst>(factor));
                        elems->push_back(std::move(expr));
                        //here node is already deleted since expr is pointing to another place.
                        return new Expr(Expr::binops::MULT, std::move(elems), expr->get_type());
                    }

                    //here expr is not changed;
                }

                bool all_intconst = true;
                for (auto & e : *m->elems) {
                    if(!is_instance(e.get(), IntConst)) {
                        all_intconst = false;
                        break;
                    }
                }

                if(all_intconst) {
                    auto elem0 = instance_of(m->elems->at(0).get(), IntConst);
                    auto elem1 = instance_of(m->elems->at(1).get(), IntConst);

                    if(ops == op::ADD) {
                        expr_is_changed = true;
                        expr.reset(new IntConst(std::get<long long>(elem0->value) + std::get<long long>(elem1->value)));
                    } else if (ops == op::MINUS && m->elems->size() == 1) {
                        expr_is_changed = true;
                        expr.reset(new IntConst(-std::get<long long>(elem0->value)));
                    } else if (ops == op::MINUS && m->elems->size() == 2) {
                        expr_is_changed = true;
                        expr.reset(new IntConst(std::get<long long>(elem0->value) - std::get<long long>(elem1->value)));
                    } else if (ops == op::MULT) {
                        expr_is_changed = true;
                        expr.reset(new IntConst(std::get<long long>(elem0->value) * std::get<long long>(elem1->value)));
                    } else if(ops == op::DIV) {
                        expr_is_changed = true;
                        expr.reset(new IntConst(std::get<long long>(elem0->value) / std::get<long long>(elem1->value)));
                    } else if(ops == op::MOD) {
                        expr_is_changed = true;
                        expr.reset(new IntConst(std::get<long long>(elem0->value) + std::get<long long>(elem1->value)));
                    } else if(ops == op::BITAND) {
                        expr_is_changed = true;
                        expr.reset(new IntConst(std::get<long long>(elem0->value) & std::get<long long>(elem1->value)));
                    } else if(ops == op::BITOR) {
                        expr_is_changed = true;
                        expr.reset(new IntConst(std::get<long long>(elem0->value) | std::get<long long>(elem1->value)));
                    } else if(ops == op::LSHIFT) {
                        expr_is_changed = true;
                        expr.reset(new IntConst(std::get<long long>(elem0->value) << std::get<long long>(elem1->value)));
                    } else if(ops == op::RSHIFT) {
                        expr_is_changed = true;
                        expr.reset(new IntConst(std::get<long long>(elem0->value) >> std::get<long long>(elem1->value)));
                    } else if(ops == op::BEQ) {
                        expr_is_changed = true;
                        expr.reset(new BoolConst(std::get<long long>(elem0->value) == std::get<long long>(elem1->value)));
                    } else if(ops == op::BNE) {
                        expr_is_changed = true;
                        expr.reset(new BoolConst(std::get<long long>(elem0->value) != std::get<long long>(elem1->value)));
                    } else if(ops == op::BGT) {
                        expr_is_changed = true;
                        expr.reset(new BoolConst(std::get<long long>(elem0->value) > std::get<long long>(elem1->value)));
                    } else if(ops == op::BLT) {
                        expr_is_changed = true;
                        expr.reset(new BoolConst(std::get<long long>(elem0->value) < std::get<long long>(elem1->value)));
                    } else if(ops == op::BGE) {
                        expr_is_changed = true;
                        expr.reset(new BoolConst(std::get<long long>(elem0->value) >= std::get<long long>(elem1->value)));
                    } else if(ops == op::BLE) {
                        expr_is_changed = true;
                        expr.reset(new BoolConst(std::get<long long>(elem0->value) <= std::get<long long>(elem1->value)));
                    }

                    expr->_str = "";
                }
            } else if(holds_alternative<Expr::ops>(m->op)) {
                auto ops = std::get<Expr::ops>(m->op);
                using op = Expr::ops;
                using bop = Expr::binops;
                if(ops == op::NOT || ops == op::BNOT) {
                    if(auto elem0 = instance_of(m->elems->at(0).get(), Expr)) {
                        std::set<bop> vec = {bop::EQUAL, bop::NOT_EQUAL, bop::LTE, bop::GTE, bop::GT, bop::LT, bop::BEQ,
                                             bop:: BNE, bop::BLT, bop::BGT, bop::BGE, bop::BLE};
                        if (holds_alternative<bop>(elem0->op)) {
                            auto elem0op = std::get<bop>(elem0->op);
                            if (vec.find(elem0op) != vec.end()) {
                                std::map<bop,bop> rev = {{bop::BEQ, bop::BNE}, {bop::EQUAL, bop::NOT_EQUAL},
                                                         {bop::LT, bop::GTE}, {bop::GTE, bop::LT}, {bop::GT, bop::LTE},
                                                         {bop::LTE, bop::GT}, {bop::BGT, bop::BLE}, {bop::BLE, bop::BGT},
                                                         {bop::BLT, bop::BGE}, {bop::BGE, bop::BLT}};
                                return new Expr(rev[elem0op], std::move(elem0->elems), node->get_type());
                            }
                        }
                    }
                }
            }
        }

        //haven't care about the annotation
        return expr.release();
    };

    return std::make_pair(rec_apply(spec, f, false), expr_is_changed);
}
} // namespace autov