#include <nodes.h>
#include <values.h>
#include <utils.h>
#include <shortcuts.h>
#include <project.h>
#include <cassert>

#define is_instance(v, T) (dynamic_cast<T *>(v) != nullptr)
#define instance_of(v, T) (dynamic_cast<T *>(v))

namespace autov {
/*
recursively subst [name] with [value] in [spec] until [name] is assigned by a value using Match in [spec]
e.g.
subst(let x := x + 1 in x, "x", 1) => let x := 1 + 1 in x
*/
SpecNode* subst(SpecNode *spec, string name, SpecNode *value) {
    if (auto s = instance_of(spec, Symbol)) {
        if (s->text != name)
            return spec;

        auto new_value = value->deep_copy();
        if (is_instance(new_value.get(), Symbol))
            new_value->set_type(s->type);
        new_value.release();
        return value;
    } else if (auto e = instance_of(spec, Expr)) {
        auto elems = make_unique<vector<unique_ptr<SpecNode>>>();

        for (auto &elem : *e->elems)
            elems->push_back(unique_ptr<SpecNode>(subst(elem.get(), name, value)));
        return std::visit([&](auto&& arg) -> Expr* {
            using T = std::decay_t<decltype(arg)>;
            if constexpr (std::is_same_v<T, std::unique_ptr<SpecNode>>) {
                auto op = arg.get();
                auto new_op = std::unique_ptr<SpecNode>(subst(op, name, value));
                return new Expr(std::move(new_op), std::move(elems), e->type);
            } else {
                return new Expr(arg, std::move(elems), e->type);
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

        auto src = subst(m->src.get(), name, value);
        auto matches = make_unique<vector<unique_ptr<PatternMatch>>>();

        for (auto &pm : *m->match_list) {
            if (!exists_in_pattern(pm->pattern.get())) {
                auto new_body = subst(pm->body.get(), name, value);
                matches->push_back(make_unique<PatternMatch>(pm->pattern->deep_copy(), unique_ptr<SpecNode>(new_body)));
            } else {
                matches->push_back(pm->deep_copy_down());
            }
        }
        return new Match(unique_ptr<SpecNode>(src), std::move(matches));
    } else if (auto r = instance_of(spec, Rely)) {
        return new Rely(unique_ptr<SpecNode>(subst(r->prop.get(), name, value)),
                        unique_ptr<SpecNode>(subst(r->body.get(), name, value)));
    } else if (auto r = instance_of(spec, Anno)) {
        return new Anno(unique_ptr<SpecNode>(subst(r->prop.get(), name, value)),
                              unique_ptr<SpecNode>(subst(r->body.get(), name, value)));
    } else if (auto i = instance_of(spec, If)) {
        return new If(unique_ptr<SpecNode>(subst(i->cond.get(), name, value)),
                      unique_ptr<SpecNode>(subst(i->then_body.get(), name, value)),
                      unique_ptr<SpecNode>(subst(i->else_body.get(), name, value)));
    } else if (auto fe = instance_of(spec, Forall)) {
       auto vars = new vector<shared_ptr<Arg>>(*fe->vars.get());

        return new Forall(unique_ptr<vector<shared_ptr<Arg>>>(vars),
                          unique_ptr<SpecNode>(subst(fe->body.get(), name, value)));
    } else if (auto fe = instance_of(spec, Exists)) {
       auto vars = new vector<shared_ptr<Arg>>(*fe->vars.get());

        return new Exists(unique_ptr<vector<shared_ptr<Arg>>>(vars),
                          unique_ptr<SpecNode>(subst(fe->body.get(), name, value)));
    } else if (is_instance(spec, Const)) {
        // pass
    } else
        throw std::runtime_error("Unknown SpecNode type: " + string(*spec->get_type()));
    return nullptr;
}

/*
recursively apply [f] to all nodes in [spec]
[f] must be a function from SpecNode to SpecNode
e.g. SpecNode(child_1, child_2, ...) => f(SpecNode(f(child_1), f(child_2), ..))
*/
SpecNode *rec_apply(SpecNode *spec, std::function<SpecNode*(SpecNode*)> f, bool apply_anno = true) {
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
        std::cout << "i->cond: " << string(*i->cond) << std::endl;
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
        throw std::runtime_error("Unknown SpecNode type: " + string(*spec->get_type()));

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

SpecNode *subst_expr(Project *proj, SpecNode *spec, SpecNode *expr, SpecNode *var) {
    if (*spec == *expr)
        return var->deep_copy().release();

    if (auto e = instance_of(spec, Expr)) {
        auto elems = make_unique<vector<unique_ptr<SpecNode>>>();

        for (auto &elem : *e->elems)
            elems->push_back(unique_ptr<SpecNode>(subst_expr(proj, elem.release(), expr, var)));
        e->elems.release();
        return std::visit([&](auto&& arg) -> Expr* {
            using T = std::decay_t<decltype(arg)>;
            if constexpr (std::is_same_v<T, std::unique_ptr<SpecNode>>) {
                auto op = arg.get();
                auto new_op = std::unique_ptr<SpecNode>(subst_expr(proj, op, expr, var));
                return new Expr(std::move(new_op), std::move(elems), e->type);
            } else {
                return new Expr(arg, std::move(elems), e->type);
            }
        }, e->op);
    } else if (auto m = instance_of(spec, Match)) {
        auto src = subst_expr(proj, m->src.release(), expr, var);
        auto matches = make_unique<vector<unique_ptr<PatternMatch>>>();

        for (auto &pm : *m->match_list) {
            auto vars = std::set<string>();
            get_vars_from_pattern(proj, pm->pattern.get(), vars);
            if (contains_vars(proj, expr, vars) || contains_vars(proj, var, vars))
                matches->push_back(pm->deep_copy_down());
            else
                matches->push_back(make_unique<PatternMatch>(pm->pattern->deep_copy(),
                                                             unique_ptr<SpecNode>(subst_expr(proj, pm->body.release(), expr, var))));
        }
        return new Match(unique_ptr<SpecNode>(src), std::move(matches));
    } else if (auto r = instance_of(spec, Rely)) {
        return new Rely(unique_ptr<SpecNode>(subst_expr(proj, r->prop.release(), expr, var)),
                        unique_ptr<SpecNode>(subst_expr(proj, r->body.release(), expr, var)));
    } else if (auto r = instance_of(spec, Anno)) {
        return new Anno(unique_ptr<SpecNode>(subst_expr(proj, r->prop.release(), expr, var)),
                        unique_ptr<SpecNode>(subst_expr(proj, r->body.release(), expr, var)));
    } else if (auto i = instance_of(spec, If)) {
        return new If(unique_ptr<SpecNode>(subst_expr(proj, i->cond.release(), expr, var)),
                      unique_ptr<SpecNode>(subst_expr(proj, i->then_body.release(), expr, var)),
                      unique_ptr<SpecNode>(subst_expr(proj, i->else_body.release(), expr, var)));
    } else if (auto fe = instance_of(spec, Forall)) {
        auto free_vars = std::set<string>();

        for (auto &v : *fe->vars)
            free_vars.insert(v->name);
        if (contains_vars(proj, expr, free_vars))
            return spec;
        return new Forall(make_unique<vector<shared_ptr<Arg>>>(*fe->vars),
                          unique_ptr<SpecNode>(subst_expr(proj, fe->body.release(), expr, var)));
    } else if (auto fe = instance_of(spec, Exists)) {
    } else if (auto fe = instance_of(spec, Forall)) {
        auto free_vars = std::set<string>();

        for (auto &v : *fe->vars)
            free_vars.insert(v->name);

        if (contains_vars(proj, expr, free_vars))
            return spec;
        return new Forall(make_unique<vector<shared_ptr<Arg>>>(*fe->vars),
                          unique_ptr<SpecNode>(subst_expr(proj, fe->body.release(), expr, var)));
    }
    return spec;
}

SpecNode *rule_unfold_specs(Project *proj, SpecNode *spec) {
    bool unfolded = false;

    std::function<SpecNode*(SpecNode*)> f = [&](SpecNode *node) -> SpecNode* {
        // if (unfolded)
        //     return node;
        if (auto e = instance_of(node, Expr)) {
            if (auto op = std::get_if<string>(&e->op)) {
                if (proj->defs.find(*op) == proj->defs.end())
                    return node;

                auto define = proj->defs[*op].get();

                std::cout << "======================================" << std::endl;
                std::cout << "Unfold definition: " << string(*define) << std::endl;
                std::cout << "======================================" << std::endl;

                auto body = define->body->deep_copy();
                assert(e->elems->size() == define->args->size());

                if (proj->symbols.find(define->name) != proj->symbols.end() &&
                    std::get<0>(proj->symbols[define->name].loc) != "")
                    unfolded = true;

                if (e->elems->size() == 0)
                    return body.release();
                else if (e->elems->size() == 1) {
                    return Match::raw_let(define->args->at(0)->name, std::move(e->elems->at(0)), std::move(body),
                                          define->args->at(0)->type);
                } else {
                    auto tuple_type_list = make_shared<vector<shared_ptr<SpecType>>>();
                    auto tuple_type = make_shared<Tuple>(tuple_type_list);
                    for (auto &e: *e->elems)
                        tuple_type_list->push_back(e->get_type());

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

    return rec_apply(spec, f);
}

SpecNode *rule_move_if_out_match(Project *proj, SpecNode *spec) {

    std::function<SpecNode*(SpecNode*)> f = [](SpecNode *node) -> SpecNode* {
        if (auto m = instance_of(node, Match))
            if (auto src = instance_of(m->src.get(), If)) {
                unique_ptr<Match> m1(static_cast<Match*>(m->deep_copy().release()));

                return new If(std::move(src->cond),
                                make_unique<Match>(std::move(src->then_body), std::move(m->match_list)),
                                make_unique<Match>(std::move(src->else_body), std::move(m1->match_list)));
            }

        return node;
    };

    return rec_apply(spec, f, false);
}

SpecNode *rule_move_if_out_expr(Project *proj, SpecNode *spec) {

    std::function<SpecNode*(SpecNode*)> f = [](SpecNode *node) -> SpecNode* {

        if (auto e = instance_of(node, Expr)) {
            for (size_t i = 0; i < e->elems->size(); i++) {
                if (auto elem = instance_of(e->elems->at(i).get(), If)) {
                    unique_ptr<Expr> e1 = e->deep_copy_down();
                    unique_ptr<Expr> e2 = e->deep_copy_down();
                    unique_ptr<vector<unique_ptr<SpecNode>>> elems1, elems2;

                    for (size_t j = 0; j < e->elems->size(); j++) {
                        if (j == i) {
                            elems1->push_back(unique_ptr<SpecNode>(std::move(elem->then_body)));
                            elems2->push_back(unique_ptr<SpecNode>(std::move(elem->else_body)));
                        } else {
                            elems1->push_back(unique_ptr<SpecNode>(std::move(e1->elems->at(j))));
                            elems2->push_back(unique_ptr<SpecNode>(std::move(e2->elems->at(j))));
                        }
                    }

                    return new If(std::move(elem->cond),
                                  make_unique<Expr>(std::move(e1->op), std::move(elems1), e->type),
                                  make_unique<Expr>(std::move(e2->op), std::move(elems2), e->type));
                }
            }
        }

        return node;
    };

    return rec_apply(spec, f, false);
}

SpecNode *rule_move_match_out_expr(Project *proj, SpecNode *spec) {

    std::function<SpecNode*(SpecNode*)> f = [&proj](SpecNode *node) -> SpecNode* {
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
                            auto expr = make_unique<Expr>(std::move(e->op), std::move(elems), e->type);
                            matches->push_back(make_unique<PatternMatch>(std::move(pm->pattern),
                                                                         std::move(expr)));
                        }
                        return new Match(std::move(elem->src), std::move(matches));
                    }
                }
            }
        }
        return node;   
    };

    return rec_apply(spec, f, false);
}

SpecNode *rule_move_rely_out_when(Project *proj, SpecNode *spec) {

    std::function<SpecNode*(SpecNode*)> f = [](SpecNode *node) -> SpecNode* {
        if (auto m = instance_of(node, Match)) {
            if (auto r = instance_of(m->src.get(), Rely)) {
                if (instance_of(m->type.get(), Option)) {
                    for (auto &pm : *m->match_list) {
                        if (static_cast<string>(*pm->pattern) == "None" && static_cast<string>(*pm->body) == "None")
                            return new Rely(std::move(r->prop),
                                            make_unique<Match>(std::move(r->body), std::move(m->match_list)));
                    }
                    return node;
                }
            }
        }
        return node;
    };

    return rec_apply(spec, f, false);
}

SpecNode *rule_move_when_out_when(Project *proj, SpecNode *spec) {

    std::function<SpecNode*(SpecNode*)> f = [](SpecNode *node) -> SpecNode* {
        if (auto m = instance_of(node, Match)) {
            if (auto src = instance_of(m->src.get(), Match)) {
                if (src->is_when() && is_instance(m->type.get(), Option)) {
                    for (auto &pm : *m->match_list) {
                        if (static_cast<string>(*pm->pattern) == "None" && static_cast<string>(*pm->body) == "None") {
                            auto pattern = dynamic_cast<Expr*>(src->match_list->at(0)->pattern.get());
                            auto match = make_unique<Match>(std::move(src->match_list->at(0)->body), std::move(m->match_list));
                            return Match::raw_when(std::move(pattern->elems->at(0)), std::move(src->src), std::move(match));
                        }
                    }
                    return node;
                }
            }
        }
        return node;
    };

    return rec_apply(spec, f, false);
}

SpecNode *rule_eliminate_if(Project *proj, SpecNode *spec) {

    std::function<SpecNode*(SpecNode*)> f = [](SpecNode *node) -> SpecNode* {
        if (auto i = instance_of(node, If)) {
            if (*i->then_body == *i->else_body)
                return i->then_body.release();
        }
        return node;
    };

    return rec_apply(spec, f, false);
}

SpecNode *rule_eliminate_let(Project *proj, SpecNode *spec) {

    std::function<SpecNode*(SpecNode*)> f = [&proj](SpecNode *node) -> SpecNode* {
        if (auto m = instance_of(node, Match)) {
            if (m->is_let()) {
                if (auto pattern = instance_of(m->match_list->at(0)->pattern.get(), Symbol)) {
                    string name = pattern->text;
                    if (!proj->is_known_symbol(name)) {
                        SpecNode *value = m->src.get();
                        SpecNode *body = m->match_list->at(0)->body.get();
                        return subst(body, name, value);
                    }
                }
            }
        }
        return node;
    };

    return rec_apply(spec, f, false);
}

//try to match [pattern] with [src], return true if match success, and [assign] will be
//filled with the matched variables, return [default] if not sure.
bool try_match(Project *proj, SpecNode *pattern, SpecNode *src, std::unordered_map<string, unique_ptr<SpecNode>> &assigns, bool def) {
    if(auto p = instance_of(pattern, autov::Const)) {
        if(auto s = instance_of(src, autov::Const)) {
            return p->value == s->value;
        }
    }
    string patter_constr, src_constr;
    if(auto p = instance_of(pattern, Symbol)) {
        patter_constr = p->text;
    } else if(auto p = instance_of(pattern, Expr)) {
        if(holds_alternative<string>(p->op)) {
            patter_constr = std::get<string>(p->op);
        }
    }

    if(auto p = instance_of(src, Symbol)) {
        src_constr = p->text;
    } else if(auto p = instance_of(src, Expr)) {
        if(holds_alternative<string>(p->op)) {
            src_constr = std::get<string>(p->op);
        }
    }

    if(patter_constr != "" && src_constr != "" && (proj->is_ind_constr(patter_constr) || proj->is_struct_constr(patter_constr))
    && (proj->is_ind_constr(src_constr) || proj->is_struct_constr(src_constr))) {
        if(patter_constr != src_constr)
            return false;
        else {
            if(is_instance(pattern, Symbol) && is_instance(src, Symbol))
                return true;
            else {
                if (auto p = instance_of(pattern, Expr)) {
                    if(auto s = instance_of(src, Expr)) {
                        for(int i = 0; i < p->elems->size(); ++i) {
                            if(!try_match(proj, p->elems->at(i).get(), s->elems->at(i).get(), assigns, def))
                                return false;
                        }
                        return true;
                    }
                }
            }
        }
    } 

    if(auto p = instance_of(pattern, Symbol)) {
        if(!proj->is_known_symbol(p->text)) {
            assigns[p->text] = src->deep_copy();
        }
    }

    return def;
}

SpecNode *rule_eliminate_match_simple(Project *proj, SpecNode *spec) {
    std::function<SpecNode*(SpecNode*)> f = [&] (SpecNode *node) -> SpecNode* {
        if(auto m = instance_of(node, Match)) {
            auto possible = false;
            for(int i = 0; i < m->match_list->size(); ++i) {
                std::unordered_map<string, unique_ptr<SpecNode>> assigns;
                if(try_match(proj, m->match_list->at(i)->pattern.get(), m->src.get(), assigns, true)) {
                    possible = true;
                    assigns.clear();
                    if(try_match(proj, m->match_list->at(i)->pattern.get(), m->src.get(), assigns, false)) {
                        unique_ptr<SpecNode> new_body = std::move(m->match_list->at(i)->body);
                        for(auto & [k,v] : assigns) {
                            new_body = Match::let(k, std::move(v), std::move(new_body), v->get_type());
                        }
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

    return rec_apply(spec, f, false);
}

SpecNode *rule_subst_match_src_with_content(Project *proj, SpecNode *spec) {
    std::function<SpecNode*(SpecNode*)> f = [&] (SpecNode *node) -> SpecNode* {
        if(auto s = instance_of(node, Match)) {
            unique_ptr<vector<unique_ptr<PatternMatch>>> matches = make_unique<vector<unique_ptr<PatternMatch>>>();
            for (auto & pm : *s->match_list) {
                std::set<string> vars;
                get_vars_from_pattern(proj, pm->pattern.get(), vars);
                if(!contains_vars(proj, s->src.get(), vars)) {
                    //pattern will be deep copyed in subst_expr
                    auto body = subst_expr(proj, pm->body.release(), s->src.get(), pm->pattern.get());
                    matches->push_back(make_unique<PatternMatch>(std::move(pm->pattern), unique_ptr<SpecNode>(body)));
                } else {
                    matches->push_back(std::move(pm));
                }
            }
            return new Match(std::move(s->src), std::move(matches));
        }
        return node;
    };

    return rec_apply(spec, f, false);
}


SpecNode* rule_simple_builtin_functions(Project* proj, SpecNode *spec){
    std::function<SpecNode*(SpecNode*)> f = [] (SpecNode *node) -> SpecNode* {
        if(auto s = instance_of(node, Expr)) {
            if(holds_alternative<string>(s->op) && std::get<string>(s->op) == "ptr_to_int") {
                if(auto e = instance_of(s->elems->at(0).get(), Expr)) {
                    if(holds_alternative<string>(e->op) && std::get<string>(e->op) == "int_to_ptr") {
                        return e->elems->at(0).release();
                    }
                }
            }
        }

        if(auto s = instance_of(node, Expr)) {
            if(holds_alternative<string>(s->op) && std::get<string>(s->op) == "int_to_ptr") {
                if(auto e = instance_of(s->elems->at(0).get(), Expr)) {
                    if(holds_alternative<string>(e->op) && std::get<string>(e->op) == "ptr_to_int") {
                        return e->elems->at(0).release();
                    }
                }
            }
        }

        return node;
    };

    return rec_apply(spec, f, false);
}


SpecNode* rule_eliminate_when(Project *proj, SpecNode *spec) {
     std::function<SpecNode*(SpecNode*)> f = [] (SpecNode *node) -> SpecNode* {
        SpecNode* src;
        SpecNode* when_body;
        if(auto m = instance_of(node, Match)) {
            if(m->is_when()) {
                src = m->src.get();
                auto pattern = dynamic_cast<Expr*>(m->match_list->at(0)->pattern.get());
                when_body = m->match_list->at(0)->body.get();
                std::function<SpecNode*(SpecNode*)> subst_when = [&] (SpecNode *node) -> SpecNode* {
                    if(auto m = instance_of(node, Symbol)) {
                        if(m->text == "None") {
                            return new Symbol("None", when_body->get_type());
                        } else {
                            return nullptr;
                        }
                    } else if(auto m = instance_of(node, Expr)) {
                        if(holds_alternative<Expr::ops>(m->op) && std::get<Expr::ops>(m->op) == Expr::ops::Some) {
                            auto vec = make_unique<vector<unique_ptr<PatternMatch>>>();
                            vec->push_back(make_unique<PatternMatch>(std::move(pattern->elems->at(0)), when_body->deep_copy()));
                            return new Match(std::move(m->elems->at(0)), std::move(vec));
                        }
                        return nullptr;
                    } else if(auto m = instance_of(node, Match)) {
                        auto vec = make_unique<vector<unique_ptr<PatternMatch>>>();
                        for(auto & pm : *m->match_list) {
                            auto subst_body = subst_when(pm->body.get());
                            if(subst_body == nullptr) {
                                return nullptr;
                            }
                            vec->push_back(unique_ptr<PatternMatch>(new PatternMatch(std::move(pm->pattern), unique_ptr<SpecNode>(subst_body))));
                        }
                        return new Match(std::move(m->src), std::move(vec));
                    } else if(auto m = instance_of(node, Rely)) {
                        auto body = subst_when(m->body.get());
                        if(body == nullptr)
                            return nullptr;
                        return new Rely(std::move(m->prop), unique_ptr<SpecNode>(body));
                    } else if(auto m = instance_of(node, Anno)) {
                        auto body = subst_when(m->body.get());
                        if(body == nullptr)
                            return nullptr;
                        return new Anno(std::move(m->prop), unique_ptr<SpecNode>(body));
                    } else if(auto m = instance_of(node, If)) {
                        auto then_body = subst_when(m->then_body.get());
                        auto else_body = subst_when(m->else_body.get());
                        if(then_body == nullptr || else_body == nullptr)
                            return nullptr;
                        return new If(std::move(m->cond), std::move(m->then_body), std::move(m->else_body));
                    } else if(auto m = instance_of(node, Forall)) {
                        return node;
                    } else if(auto m = instance_of(node, Exists)) {
                        return node;
                    } else if(auto m = instance_of(node, Const)) {
                        return nullptr;
                    } else {
                        throw std::runtime_error("Unknown node type:" + string(*node->type));
                    }
                };
                auto new_body = subst_when(src);
                if(new_body == nullptr)
                    return node;
                return new_body;
            } else {
                return node;
            }
        } else {
            return node;
        }
     };

     return rec_apply(spec, f, false);
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

SpecNode* rule_simplify_expr(Project *proj, SpecNode *spec) {
    std::function<SpecNode*(SpecNode*)> f = [] (SpecNode *node) -> SpecNode* {
        unique_ptr<SpecNode> expr = unique_ptr<SpecNode>(node);
        bool expr_is_changed = false;
        if(auto m = instance_of(node, If)) {
            if(auto c = instance_of(m->cond.get(), BoolConst)) {
                if(std::get<bool>(c->value)) {
                    return m->then_body.release();
                } else {
                    return m->else_body.release();
                }
            }
        }

        
        if(auto m = instance_of(node, Expr)) {
            if(holds_alternative<Expr::binops>(m->op)) {
                auto ops = std::get<Expr::binops>(m->op);
                using op = Expr::binops;
                std::set<op> vec = {op::EQUAL, op::NOT_EQUAL, op::LTE, op::GTE, op::GT, op::LT, op::BEQ, 
                op:: BNE, op::BLT, op::BGT, op::BGE, op::BLE};
                if(vec.find(ops) != vec.end() && m->elems->at(0)->get_type() == Int::INT
                && m->elems->at(1)->get_type() == Int::INT && !is_instance(m->elems->at(1).get(), Const)) {
                    auto elems = new vector<unique_ptr<SpecNode>>();
                    elems->push_back(std::move(m->elems->at(0)));
                    elems->push_back(std::move(m->elems->at(1)));
                    auto left = new Expr(op::MINUS, unique_ptr<vector<unique_ptr<SpecNode>>>(elems), Int::INT);
                    auto right = new IntConst(0);

                    auto elems2 = new vector<unique_ptr<SpecNode>>();
                    elems2->push_back(unique_ptr<SpecNode>(left));
                    elems2->push_back(unique_ptr<SpecNode>(right));
                    return new Expr(ops, unique_ptr<vector<unique_ptr<SpecNode>>>(elems2), node->get_type());
                }
                if((ops == op::ADD || ops == op::MINUS) && m->elems->size() == 2 && (!is_instance(m->elems->at(0).get(), IntConst) || !is_instance(m->elems->at(1).get(), IntConst))) {
                    auto factor = 1;
                    
                    for(auto i : PRIM_NUMS) {
                        while(1){
                            auto a = try_divide_const_factor(expr.get(), i);
                            if(a == nullptr){
                                break;
                            }
                            factor *= i;

                            expr = unique_ptr<SpecNode>(a);
                        }
                    }
                    if(factor > 1) {
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
                }
            } else if(holds_alternative<Expr::ops>(m->op)) {
                auto ops = std::get<Expr::ops>(m->op);
                using op = Expr::ops;
                using bop = Expr::binops;
                if(ops == op::NOT || ops == op::BNOT) {
                    if(auto elem0 = instance_of(m->elems->at(0).get(), Expr)) {
                        std::set<bop> vec = {bop::EQUAL, bop::NOT_EQUAL, bop::LTE, bop::GTE, bop::GT, bop::LT, bop::BEQ, 
                        bop:: BNE, bop::BLT, bop::BGT, bop::BGE, bop::BLE};
                        if(holds_alternative<bop>(elem0->op)) {
                            auto elem0op = std::get<bop>(elem0->op);
                            if(vec.find(elem0op) != vec.end()) {
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

    return rec_apply(spec, f, false);
}



} // namespace autov