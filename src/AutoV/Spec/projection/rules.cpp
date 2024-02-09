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
                if (auto o = instance_of(m->type.get(), Option)) {
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


} // namespace autov