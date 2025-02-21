#include <nodes.h>
#include <values.h>
#include <utils.h>
#include <shortcuts.h>
#include <project.h>
#include <cassert>
#include <utility>
#include <rules.h>
#include <z3_rules.h>
namespace autov {

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

void free_vars_map(Project *proj, SpecNode *spec, std::set<string> &free, std::map<string, Symbol*> &map) {
    if(auto s = instance_of(spec, Symbol)) {
        if(!proj->is_known_symbol(s->text)) {
            free.insert(s->text);
            map[s->text] = s;
        }
    }else if (auto m = instance_of(spec, Match)) {
        free_vars_map(proj, m->src.get(), free, map);
        for (auto &pm : *m->match_list) {
            free_vars_map(proj, pm->body.get(), free, map);
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
            for(auto sym : symbols) {
                free.erase(sym);
                map.erase(sym);
            }
        }
    } else if (auto fe = instance_of(spec, ForallExists)) {
        auto body = fe->body->deep_copy().release();
        auto vars = new vector<shared_ptr<Arg>>(*fe->vars.get());
        free_vars_map(proj, body, free, map);
        for(auto arg : *vars) {
            free.erase(arg->name);
            map.erase(arg->name);
        }

    } else if(auto e = instance_of(spec, Expr)) {
        for(int i = 0; i < e->elems->size(); i++) {
            free_vars_map(proj, e->elems->at(i).get(), free, map);
        }
    } else if(auto r = instance_of(spec, RelyAnno)) {
        free_vars_map(proj, r->prop.get(), free, map);
        free_vars_map(proj, r->body.get(), free, map);
    } else if(auto e = instance_of(spec, If)) {
        free_vars_map(proj, e->cond.get(), free, map);
        free_vars_map(proj, e->then_body.get(), free, map);
        free_vars_map(proj, e->else_body.get(), free, map);
    }
}

void get_vars_from_pattern(Project *proj, SpecNode *pattern, std::set<string> &vars) {
    if (auto s = instance_of(pattern, Symbol)) {
        if (!proj->is_known_symbol(s->text) && pattern->get_type() != SpecType::UNKNOWN_TYPE)
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

static vector<vector<FieldPath>> interest_path;
std::set<string> interest_list = {};

//static const std::set<string> interest_list = {};
static void collect_interest_path(Project *proj) {
    for (auto &i: interest_list) {
        vector<FieldPath> path;

        search_field_path(proj, i, proj->layers[0]->abs_data->name, path);
        if (path.size() != 0) {
            interest_path.push_back(path);
        }
    }
}

static bool contains_interest_fields(SpecNode *spec) {
    if (auto s = instance_of(spec, Symbol)) {
        if (std::find(interest_list.begin(), interest_list.end(), s->text) != interest_list.end()) {
            return true;
        }
        return false;
    } if (auto e = instance_of(spec, Expr)) {
        if (auto op = std::get_if<Expr::ops>(&e->op)) {
            if (*op == Expr::RecordSet) {
                // elems[0]: record
                // elems[1...n-1]: fields
                // elems[n]: value
                auto likely_contains = false;

                for (int i = 1; i < e->elems->size() - 1; i++) {
                    auto f = e->elems->at(i).get();
                    assert(is_instance(f, Symbol));
                    if (std::find(interest_list.begin(), interest_list.end(), static_cast<Symbol*>(f)->text) != interest_list.end()) {
                        return true;
                    }
                }

                // If the field is a ZMap, we need to check the subfields of the Record in the ZMap
                if (is_instance(e->elems->back()->get_type().get(), ZMap))
                    return contains_interest_fields(e->elems->back().get());

                return likely_contains;
            } else if (*op == Expr::SET) {
                auto v = e->elems->back().get();

                if (is_instance(v, Expr))
                    return contains_interest_fields(v);

                return false;
            }
            return false;
        }
        return false;
    } else if (auto m = instance_of(spec, Match)) {
        if (contains_interest_fields(m->src.get()))
            return true;
        for (auto &pm: *m->match_list) {
            if (contains_interest_fields(pm->body.get()))
                return true;
        }
        return false;
    } else if (auto i = instance_of(spec, If)) {
        if (contains_interest_fields(i->cond.get()) || contains_interest_fields(i->then_body.get()) ||
            contains_interest_fields(i->else_body.get()))
            return true;
        return false;
    }

    return false;
}

static bool op_is_lens(const std::variant<unique_ptr<SpecNode>, Expr::ops, Expr::binops, string> &op) {
    if (auto s = std::get_if<string>(&op))
        return *s == "lens";

    return false;
}

static bool rec_is_lens(SpecNode *spec) {
    if (auto e = instance_of(spec, Expr)) {
        if (e->is_lens)
            return true;

        if (auto op = std::get_if<string>(&e->op))
            return op_is_lens(*op);
        else if (auto op = std::get_if<Expr::ops>(&e->op)) {
            if (*op == Expr::RecordGet || *op == Expr::GET || *op == Expr::RecordSet || *op == Expr::SET)
                return rec_is_lens(e->elems->at(0).get());
        } else if (auto op = std::get_if<unique_ptr<SpecNode>>(&e->op)) {
            return rec_is_lens(op->get());
        }
    }

    return false;
}

static SpecNode* remove_expr_lens(Expr *e, bool &changed) {
    if (op_is_lens(e->op)) {
        auto ret = e->elems->at(1).release();

        changed = true;
        return ret;
    } else if (auto op = std::get_if<Expr::ops>(&e->op)) {
        if (*op == Expr::GET || *op == Expr::RecordGet) {
            auto rec = e->elems->at(0).get();

            if (auto rec_e = instance_of(rec, Expr)) {
                auto ret = remove_expr_lens(rec_e, changed);

                if (ret != rec_e)
                    e->elems->at(0).reset(ret);
            }
            return e;
        }
    }

    return e;
}

static bool expr_emits_lens(SpecNode *node) {
    auto e = instance_of(node, Expr);

    if (!e)
        return false;

    if (std::holds_alternative<string>(e->op)) {
        return op_is_lens(e->op);
    } else if (auto op = std::get_if<Expr::ops>(&e->op)) {
        if (*op == Expr::Some)
            return expr_emits_lens(e->elems->at(0).get());
    }

    return false;
}

#ifdef CONDITIONAL_SPEC
unsigned long number_of_conditionals_inside(Project* proj, SpecNode * spec) {
    auto num_of_conds = 0;
    
    if(auto ifnode = instance_of(spec, If)) {
            num_of_conds += 1;
            num_of_conds += number_of_conditionals_inside(proj, ifnode->then_body.get());
            num_of_conds += number_of_conditionals_inside(proj, ifnode->else_body.get());
    } else if(auto e = instance_of(spec, RelyAnno)) {
        num_of_conds += number_of_conditionals_inside(proj, e->body.get());
    } else if(auto m = instance_of(spec, Match)){
        num_of_conds = number_of_conditionals_inside(proj, m->src.get());
        for(auto &pm : *m->match_list) {
            num_of_conds += number_of_conditionals_inside(proj, pm->body.get());
        }
    }
    return num_of_conds;
}

unsigned long number_of_conditionals(Project* proj, SpecNode * spec) {
    auto num_of_conds = 0;
    
    if(auto ifnode = instance_of(spec, If)) {
            num_of_conds += 1;
            num_of_conds += number_of_conditionals(proj, ifnode->then_body.get());
            num_of_conds += number_of_conditionals(proj, ifnode->else_body.get());
    } else if(auto expr = instance_of(spec, Expr)) {
             if (auto op = std::get_if<string>(&expr->op)) {
                if (proj->defs.find(*op) == proj->defs.end())
                    return num_of_conds;

                if (proj->cmds.NoUnfold.find(*op) != proj->cmds.NoUnfold.end() &&
                    proj->cmds.Unfold.find(*op) == proj->cmds.Unfold.end())
                    return num_of_conds;

                auto define = proj->defs[*op].get();
                if (is_instance(define, Fixpoint))
                    return num_of_conds;


                for(auto &[k, op] : proj->layers[0]->ops) {
                    if(op == define->name) {                    
                        return num_of_conds;
                    }
                }

                // for(auto it = proj->layers[0]->prims.begin(); it != proj->layers[0]->prims.end(); it++) {
                //     if(define->name == *it) {
                //         return num_of_conds;
                //     }
                // }
                
                int n = number_of_conditionals(proj, define->body.get());
                num_of_conds += n;
             }
    } else if(auto e = instance_of(spec, RelyAnno)) {
        num_of_conds += number_of_conditionals(proj, e->body.get());
    } else if(auto m = instance_of(spec, Match)){
        num_of_conds = number_of_conditionals(proj, m->src.get());
        for(auto &pm : *m->match_list) {
            num_of_conds += number_of_conditionals(proj, pm->body.get());
        }
    }
    return num_of_conds;
}

std::pair<bool, std::pair<string,string>> rule_conditional_spec(Project* proj, Definition *def, vector<Definition*>* low_spec) {
    /* 
    first determine the number of branches and the size of the node,
    if the size is larger than 500, the number of branches is larger than 10 -> Let's split!
    */
    bool changed = false;
    auto num_of_conds = number_of_conditionals(proj, def->body.get());
    auto length = length_of_exp(def->body.get());
    def->length = length;
    //LOG_DEBUG << "length:" + std::to_string(def->body->length);
    LOG_DEBUG << "num_of_conds:" << std::to_string(num_of_conds);
    if(num_of_conds < 240) {
        return std::make_pair(changed,std::make_pair("",""));       
    }
    std::function<SpecNode*(SpecNode*)> f = [&](SpecNode *node) -> SpecNode* {
        if(auto ifnode = instance_of(node, If)) {
            //auto num_cond = number_of_conditionals(proj, node);
            auto length_then = length_of_exp(ifnode->then_body.get());
            auto num_then_conds = number_of_conditionals_inside(proj, ifnode->then_body.get());
            auto total_then_conds = number_of_conditionals(proj, ifnode->then_body.get());

            auto length_else = length_of_exp(ifnode->else_body.get());
            auto num_else_conds = number_of_conditionals_inside(proj, ifnode->else_body.get());
            auto total_else_conds = number_of_conditionals(proj, ifnode->else_body.get());
            LOG_DEBUG << "length then: " << std::to_string(length_then);
            LOG_DEBUG << "then conds: " << std::to_string(num_then_conds);
            LOG_DEBUG << "total then conds: " << std::to_string(total_then_conds);
            LOG_DEBUG << "length else: " << std::to_string(length_else);
            LOG_DEBUG << "else conds: " << std::to_string(num_else_conds);
            LOG_DEBUG << "total else conds: " << std::to_string(total_else_conds);
            LOG_DEBUG << "expr: " << string(*node);
            bool foldthen = true;
            bool foldelse = true;
            if(length_then < 45) {
                foldthen = false;;
            }
            if(num_then_conds > 0 || total_then_conds < 2) {
                foldthen = false;
            }
            if(length_else < 45) {
                 foldelse = false;;
            }
            if(num_else_conds > 0 || total_else_conds < 2) {
                foldelse = false;
            }
            // if(num_conds != 0) {
            //     return ifnode;
            // }
            
            auto cond = ifnode->cond.get();
            // auto conde =  instance_of(cond, Expr);

            auto elems = make_unique<vector<unique_ptr<SpecNode>>>();
            elems->push_back(cond->deep_copy());
            elems->push_back(make_unique<BoolConst>(true));

            auto neg_elems = make_unique<vector<unique_ptr<SpecNode>>>();
            neg_elems->push_back(cond->deep_copy());
            neg_elems->push_back(make_unique<BoolConst>(true));
            //auto negcond = new Expr(Expr::ops::NOT, std::move(elems));
            auto then_node = ifnode->then_body.get();
            auto else_node = ifnode->else_body.get();

            auto free_then = set<string>();
            auto free_then_map = std::map<string, Symbol*>();
            free_vars_map(proj, then_node, free_then, free_then_map);
            free_vars_map(proj, cond, free_then, free_then_map);
            
        
            auto free_else = set<string>();
            auto free_else_map = std::map<string, Symbol*>();
            free_vars_map(proj, else_node, free_else, free_else_map);
            free_vars_map(proj, cond, free_else, free_else_map);

            // auto new_expr_then = new Rely(make_unique<Expr>(Expr::binops::EQUAL, std::move(elems), Prop::PROP), unique_ptr<SpecNode>(then_node));
            // auto new_expr_else = new Rely(make_unique<Expr>(Expr::binops::NOT_EQUAL, std::move(neg_elems),Prop::PROP), unique_ptr<SpecNode>(else_node));
            
            //pick new name
            auto name = def->name;
            string suffix = "_spec_low";
            std::function<string(string)> pick_new_name = [&](string name) -> string {
                string prefix = name;
                if (name.rfind(suffix) == name.size() - suffix.size()) {
                    prefix = name.substr(0, name.size() - suffix.size());
                }
                int counter = 0;
                auto new_name = prefix + "_" + std::to_string(counter);
                while(proj->defs.find(new_name + "_low") != proj->defs.end()) {
                    counter += 1;
                    new_name = prefix + "_" + std::to_string(counter);
                }
                return new_name;
            };
            
            
            //auto expr_then = new Expr(new_then_name, unique_ptr<vector<unique_ptr<SpecNode>>>(vec_sym_then));
            if(foldthen){
                auto new_then_name = pick_new_name(name);
                auto vec_arg_then = new vector<shared_ptr<Arg>>();
                for(auto [name,sym] : free_then_map) {
                    if(!proj->is_known_symbol(name)) {
                        vec_arg_then->push_back(make_shared<Arg>(name, sym->type));
                    }
                }
                auto vec_sym_then = new vector<unique_ptr<SpecNode>>();
                for(auto [name,sym] : free_then_map) {
                    if(!proj->is_known_symbol(name)) {
                        vec_sym_then->push_back(make_unique<Symbol>(name, sym->type));
                    }
                }
                auto new_expr_then = new Rely(make_unique<Expr>(Expr::binops::EQUAL, std::move(elems), Prop::PROP), std::move(ifnode->then_body));
                auto new_def_then = new Definition(new_then_name + "_low", ifnode->type, unique_ptr<vector<shared_ptr<Arg>>>(vec_arg_then), unique_ptr<SpecNode>(new_expr_then));
                auto expr_then = new Expr(new_then_name, unique_ptr<vector<unique_ptr<SpecNode>>>(vec_sym_then));
                LOG_DEBUG << "create conditional1: \n"+string(*new_def_then);
                proj->add_definition(unique_ptr<Definition>(new_def_then), make_shared<loc_t>(proj->symbols[def->name].loc));
                low_spec->push_back(new_def_then);
                proj->symbols[def->name].order = proj->symbols[new_then_name + "_low"].order + 1;
                ifnode->then_body = unique_ptr<SpecNode>(expr_then);
            } 
            if(foldelse) {
                auto new_else_name = pick_new_name(name);
                auto vec_arg_else = new vector<shared_ptr<Arg>>();
                for(auto [name,sym] : free_else_map) {
                    if(!proj->is_known_symbol(name)) {
                        vec_arg_else->push_back(make_shared<Arg>(name, sym->type));
                    }
                }
                auto vec_sym_else = new vector<unique_ptr<SpecNode>>();
                for(auto [name,sym] : free_else_map) {
                    if(!proj->is_known_symbol(name)) {
                        vec_sym_else->push_back(make_unique<Symbol>(name, sym->type));
                    }
                }
                auto new_expr_else = new Rely(make_unique<Expr>(Expr::binops::NOT_EQUAL, std::move(neg_elems),Prop::PROP), std::move(ifnode->else_body));
                auto expr_else = new Expr(new_else_name, unique_ptr<vector<unique_ptr<SpecNode>>>(vec_sym_else));
                auto new_def_else = new Definition(new_else_name + "_low", ifnode->type, unique_ptr<vector<shared_ptr<Arg>>>(vec_arg_else), unique_ptr<SpecNode>(new_expr_else));
                LOG_DEBUG << "create conditional2: \n"+string(*new_def_else);
                proj->add_definition(unique_ptr<Definition>(new_def_else), make_shared<loc_t>(proj->symbols[def->name].loc));
                low_spec->push_back(new_def_else);
                proj->symbols[def->name].order = proj->symbols[new_else_name + "_low"].order + 1;
                ifnode->else_body = unique_ptr<SpecNode>(expr_else);
            } 
            changed = true;

            return ifnode;
        }
        return node;
    };

    auto changed_body = rec_apply(def->body.release(),f, false);
    def->body = unique_ptr<SpecNode>(changed_body);
    return std::make_pair(changed,std::make_pair("",""));      
}
#endif

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

static bool pattern_is_symbol(SpecNode *node) {
    if (auto p = instance_of(node, Symbol)) {
        return true;
    } else if (auto p = instance_of(node, Expr)) {
        if (auto op = std::get_if<Expr::ops>(&p->op))
            return *op == Expr::None;
    }
    return false;
}

//try to match [pattern] with [src], return true if match success, and [assign] will be
//filled with the matched variables, return [default] if not sure.
static bool try_match(Project *proj, SpecNode *pattern, SpecNode *src,
                      std::unordered_map<string, unique_ptr<SpecNode>> &assigns, bool def) {
    // if (string(*pattern) == "(LOCK_PROT lk)")
    //     std::cout << "try_match " << string(*src) << " with " << string(*pattern) << std::endl;

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
            if (pattern_is_symbol(pattern) && is_instance(src, Symbol))
                return true;
            else {
                if (auto p = instance_of(pattern, Expr)) {
                    if (auto op = std::get_if<Expr::ops>(&p->op)) {
                        if (*op != Expr::None) {
                            if (auto s = instance_of(src, Expr)) {
                                for (int i = 0; i < p->elems->size(); ++i) {
                                    if (!try_match(proj, p->elems->at(i).get(), s->elems->at(i).get(), assigns, def))
                                        return false;
                                }
                                return true;
                            }
                        }
                    } else if (auto op = std::get_if<string>(&p->op)) {
                        if (auto s = instance_of(src, Expr)) {
                            if (p->elems->size() != s->elems->size())
                                return false;
                            for (int i = 0; i < p->elems->size(); ++i) {
                                if (!try_match(proj, p->elems->at(i).get(), s->elems->at(i).get(), assigns, def))
                                    return false;
                            }
                            return true;
                        }
                    }
                }
            }
        }
    }

    if (auto p = instance_of(pattern, Symbol)) {
        if (!proj->is_known_symbol(p->text)) {
            assigns[p->text] = src->deep_copy();
            return true;
        }
    }

    return def;
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
        if(std::get<unsigned long>(m->value) != 0 && std::get<unsigned long>(m->value) % factor == 0) {
            return new IntConst(std::get<unsigned long>(m->value) / factor);
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


static bool is_const_zero(SpecNode *node) {
    if (auto m = instance_of(node, IntConst)) {
        return std::get<unsigned long>(m->value) == 0;
    } else if (auto m = instance_of(node, Const)) {
        return holds_alternative<unsigned long>(m->value) && std::get<unsigned long>(m->value) == 0;
    }

    return false;
}
/**
 * @brief Recursively substitutes [name] with [value] in [spec] until [name] is assigned by a value using Match in [spec].
 * 
 * @details Example usage:
 * ```
 * subst(let x := x + 1 in x, "x", 1) => let x := 1 + 1 in x
 * ```
 * The [value] is freed by the caller.
 * 
 * @param spec   The specification node in which substitution occurs.
 * @param name   The name to be replaced.
 * @param value  The value to replace occurrences of [name].
 * @param succ   A reference boolean that indicates success/failure of the substitution.
 * 
 * @return A unique pointer to the modified SpecNode.
 */
static std::unique_ptr<SpecNode> subst(
    std::unique_ptr<SpecNode> spec,
    const std::string& name,
    SpecNode* value,
    bool &succ
) {
    if (!spec) {
        return spec; 
    }

    if (auto s = instance_of(spec.get(), Symbol)) {
        if (s->text != name) {
            return spec;
        }
        auto new_value = value->deep_copy();
        if (is_instance(new_value.get(), Symbol)) {
            new_value->set_type(s->type);
        }
        succ = true;
        return new_value;
    } else if (auto e = instance_of(spec.get(), Expr)) {
        auto elems = make_unique<vector<unique_ptr<SpecNode>>>();
        for (auto &elem : *e->elems) {
            elems->push_back(subst(std::move(elem), name, value, succ));
        }
        return std::visit([&](auto &&arg) -> std::unique_ptr<SpecNode> {
            using T = std::decay_t<decltype(arg)>;
            if constexpr (std::is_same_v<T, std::unique_ptr<SpecNode>>) {
                // If op is a unique_ptr<SpecNode>, we substitute recursively
                auto new_op = subst(std::move(arg), name, value, succ);
                auto new_expr = std::make_unique<Expr>(std::move(new_op), std::move(elems), e->type);
                return new_expr;
            } else {
                // If op is something else (e.g. int, string, etc.)
                auto new_expr = std::make_unique<Expr>(arg, std::move(elems), e->type);
                return new_expr;
            }
        },
        e->op);
    } else if (auto m = instance_of(spec.get(), Match)) {
        std::function<bool(SpecNode*)> exists_in_pattern;

        exists_in_pattern = [&](SpecNode *pattern) -> bool {
            if (auto s = instance_of(pattern, Symbol)) {
                return s->text == name;
            } else if (auto e = instance_of(pattern, Expr)) {
                for (auto &elem : *e->elems) {
                    if (exists_in_pattern(elem.get())) {
                        return true;
                    }
                }
            }
            return false;
        };
        auto new_src = subst(std::move(m->src), name, value, succ);
        auto matches = make_unique<vector<unique_ptr<PatternMatch>>>();

        for (auto &pm : *(m->match_list)) {
            if (!exists_in_pattern(pm->pattern.get())) {
                auto new_body = subst(std::move(pm->body), name, value, succ);
                matches->push_back(std::make_unique<PatternMatch>(pm->pattern->deep_copy(), std::move(new_body)));
            } else {
                matches->push_back(pm->deep_copy_down());
            }
        }

        auto new_match = std::make_unique<Match>(std::move(new_src), std::move(matches));
        new_match->type = m->type;
        return new_match;
    } else if (auto r = instance_of(spec.get(), Rely)) {
        auto new_prop = subst(std::move(r->prop), name, value, succ);
        auto new_body = subst(std::move(r->body), name, value, succ);
        auto new_rely = std::make_unique<Rely>(std::move(new_prop), std::move(new_body));
        new_rely->type = r->type;
        return new_rely;
    } else if (auto r = instance_of(spec.get(), Anno)) {
        auto new_prop = subst(std::move(r->prop), name, value, succ);
        auto new_body = subst(std::move(r->body), name, value, succ);
        auto new_anno = std::make_unique<Anno>(std::move(new_prop), std::move(new_body));
        new_anno->type = r->type;
        return new_anno;
    } else if (auto i = instance_of(spec.get(), If)) {
        auto new_cond = subst(std::move(i->cond), name, value, succ);
        auto new_then = subst(std::move(i->then_body), name, value, succ);
        auto new_else = subst(std::move(i->else_body), name, value, succ);
        auto new_if = std::make_unique<If>(std::move(new_cond), std::move(new_then), std::move(new_else));
        new_if->type = i->type;
        return new_if;
    } else if (auto fe = instance_of(spec.get(), Forall)) {
        auto vars = std::make_unique<std::vector<std::shared_ptr<Arg>>>(*fe->vars);
        for (auto &v : *vars) {
            if (v->expr) {
                auto new_expr = subst(std::move(v->expr), name, value, succ);
                auto casted_expr = dynamic_cast<Expr*>(new_expr.release());
                if (casted_expr) {
                    v->expr = std::unique_ptr<Expr>(casted_expr);
                } else {
                    // v->expr.reset();
                    throw std::runtime_error("[subst] Failed to cast to Expr!");
                }
            }
        }
        auto new_body = subst(std::move(fe->body), name, value, succ);
        auto new_forall = std::make_unique<Forall>(std::move(vars), std::move(new_body));
        new_forall->type = fe->type;
        return new_forall;

    } else if (auto fe = instance_of(spec.get(), Exists)) {
        auto vars = std::make_unique<std::vector<std::shared_ptr<Arg>>>(*fe->vars);
        for (auto &v : *vars) {
            if (v->expr) {
                auto new_expr = subst(std::move(v->expr), name, value, succ);
                auto casted_expr = dynamic_cast<Expr*>(new_expr.release());
                if (casted_expr) {
                    v->expr = std::unique_ptr<Expr>(casted_expr);
                } else {
                    throw std::runtime_error("[subst] Failed to cast to Expr!");
                }
            }
        }
        auto new_body = subst(std::move(fe->body), name, value, succ);

        auto new_exists = std::make_unique<Exists>(
            std::move(vars), std::move(new_body)
        );
        new_exists->type = fe->type;
        return new_exists;
    } else if (is_instance(spec.get(), Const)) {
        // pass
    } else {
        throw std::runtime_error("Unknown SpecNode type: " + string(*spec->get_type()));
    }
    return spec;
}


/*
substitute [expr] with [var] in [spec]

[spec] is freed if substitution is successful
[expr] and [var] is freed by the caller
*/
std::unique_ptr<SpecNode> subst_expr(
    Project* proj,
    std::unique_ptr<SpecNode> spec,
    const std::unique_ptr<SpecNode>& expr,
    const std::unique_ptr<SpecNode>& var,
    bool& succ
) {
    if (*spec == *expr) {
        succ = true;
        return var->deep_copy();
    }

    if (auto e = instance_of(spec.get(), Expr)) {
        auto elems = make_unique<vector<unique_ptr<SpecNode>>>();

        for (auto &elem : *e->elems) {
            elems->push_back(subst_expr(proj, std::move(elem), expr, var, succ));
        }
        return std::visit(
            [&](auto&& arg) -> std::unique_ptr<Expr> {
                using T = std::decay_t<decltype(arg)>;
                if constexpr (std::is_same_v<T, std::unique_ptr<SpecNode>>) {
                    auto new_op = subst_expr(proj, std::move(arg), expr, var, succ);
                    return std::make_unique<Expr>(std::move(new_op), std::move(elems), e->type);
                } else {
                    return std::make_unique<Expr>(arg, std::move(elems), e->type);
                }
            },
            e->op
        );

    } else if (auto m = instance_of(spec.get(), Match)) {
        auto src = subst_expr(proj, std::move(m->src), expr, var, succ);
        auto matches = make_unique<vector<unique_ptr<PatternMatch>>>();

        for (auto &pm : *m->match_list) {
            auto vars = std::set<string>();
            get_vars_from_pattern(proj, pm->pattern.get(), vars);
            if (contains_vars(proj, expr.get(), vars) || contains_vars(proj, var.get(), vars)) {
                matches->push_back(pm->deep_copy_down());
            } else {
                auto body = subst_expr(proj, std::move(pm->body), expr, var, succ);
                matches->push_back(std::make_unique<PatternMatch>(pm->pattern->deep_copy(), std::move(body)));
            }
        }
        return std::make_unique<Match>(std::move(src), std::move(matches));

    } else if (auto r = instance_of(spec.get(), Rely)) {
        return std::make_unique<Rely>(
            subst_expr(proj, std::move(r->prop), expr, var, succ),
            subst_expr(proj, std::move(r->body), expr, var, succ)
        );
    } else if (auto r = instance_of(spec.get(), Anno)) {
        return std::make_unique<Anno>(
            subst_expr(proj, std::move(r->prop), expr, var, succ),
            subst_expr(proj, std::move(r->body), expr, var, succ)
        );
    } else if (auto i = instance_of(spec.get(), If)) {
        return std::make_unique<If>(
            subst_expr(proj, std::move(i->cond), expr, var, succ),
            subst_expr(proj, std::move(i->then_body), expr, var, succ),
            subst_expr(proj, std::move(i->else_body), expr, var, succ)
        );
    } else if (auto fe = instance_of(spec.get(), Forall)) {
        auto free_vars = std::set<string>();
        for (auto &v : *fe->vars)
            free_vars.insert(v->name);
        if (contains_vars(proj, expr.get(), free_vars))
            return spec;
        return std::make_unique<Forall>(
            std::make_unique<std::vector<std::shared_ptr<Arg>>>(*fe->vars),
            subst_expr(proj, std::move(fe->body), expr, var, succ)
        );
    } else if (auto fe = instance_of(spec.get(), Exists)) {
        auto free_vars = std::set<string>();
        for (auto &v : *fe->vars)
            free_vars.insert(v->name);
        if (contains_vars(proj, expr.get(), free_vars))
            return spec;
        return std::make_unique<Exists>(
            std::make_unique<std::vector<std::shared_ptr<Arg>>>(*fe->vars),
            subst_expr(proj, std::move(fe->body), expr, var, succ)
        );
    } 

    return spec;
}

/** free_vars should use a deep-copied version specs since it will be freed after use */
void free_vars(Project* proj, const std::unique_ptr<SpecNode>& spec, std::set<std::string>& free) {
    if (auto s = instance_of(spec.get(), Symbol)) {
        if (!proj->is_known_symbol(s->text)) {
            free.insert(s->text);
        }
    } else if (auto m = instance_of(spec.get(), Match)) {
        free_vars(proj, m->src, free);
        for (const auto& pm : *m->match_list) {
            free_vars(proj, pm->body, free);
            std::set<std::string> symbols;
            std::function<void(SpecNode*)> collect_symbols = [&](SpecNode* pattern) {
                if (auto s = instance_of(pattern, Symbol))
                    symbols.insert(s->text);
                else if (auto e = instance_of(pattern, Expr)) {
                    for (auto &elem : *e->elems)
                        collect_symbols(elem.get());
                }
            };

            collect_symbols(pm->pattern.get());
            for (const auto &sym : symbols) {
                free.erase(sym);
            }
        }

    } else if (auto fe = instance_of(spec.get(), ForallExists)) {
        auto body = fe->body->deep_copy();
        auto vars = std::make_unique<std::vector<std::shared_ptr<Arg>>>(*fe->vars);
        free_vars(proj, body, free);

        for (const auto &arg : *vars) {
            free.erase(arg->name);
        }

    } else if (auto e = instance_of(spec.get(), Expr)) {
        for (int i = 0 ; i < e->elems->size(); i++) {
            free_vars(proj, e->elems->at(i), free);
        }
    } else if (auto r = instance_of(spec.get(), RelyAnno)) {
        free_vars(proj, r->prop, free);
        free_vars(proj, r->body, free);
    } else if (auto i = instance_of(spec.get(), If)) {
        free_vars(proj, i->cond, free);
        free_vars(proj, i->then_body, free);
        free_vars(proj, i->else_body, free);
    }
}

std::unique_ptr<SpecNode> SpecRules::eliminate_ambiguity(
    std::unique_ptr<SpecNode> spec,
    std::set<std::string>& prev_symbols,
    bool& changed
) {
    if (!spec) {
        return spec;
    }
    if (auto e = instance_of(spec.get(), Expr)) {
        auto new_elems = std::make_unique<std::vector<std::unique_ptr<SpecNode>>>();
        for (auto &elem : *e->elems) {
            new_elems->push_back(eliminate_ambiguity(std::move(elem), prev_symbols, changed));
        }
        return std::visit([&](auto&& arg) -> std::unique_ptr<SpecNode> {
            using T = std::decay_t<decltype(arg)>;
            if constexpr (std::is_same_v<T, std::unique_ptr<SpecNode>>) {
                auto new_op = eliminate_ambiguity(std::move(arg), prev_symbols, changed);
                return std::make_unique<Expr>(std::move(new_op), std::move(new_elems), e->type);
            } else {
                return std::make_unique<Expr>(arg, std::move(new_elems), e->type);
            }
        }, e->op);
    } else if (auto m = instance_of(spec.get(), Match)) {
        auto src = eliminate_ambiguity(std::move(m->src), prev_symbols, changed);
        std::set<string> src_free;
        free_vars(proj, src->deep_copy(), src_free);
        auto matches = make_unique<vector<unique_ptr<PatternMatch>>>();
        for (auto &pm : *m->match_list) {
            std::unordered_map<string, shared_ptr<SpecType>> symbols;
            std::function<void(SpecNode*)> collect_symbols = [&](SpecNode *pattern) {
                if (auto s = instance_of(pattern, Symbol))
                    symbols[s->text] = s->get_type();
                else if (auto e = instance_of(pattern, Expr)) {
                    for (auto &elem : *e->elems)
                        collect_symbols(elem.get());
                }
            };
            collect_symbols(pm->pattern.get());

            auto _prev = std::set<string>(prev_symbols);
            auto pattern = pm->pattern->deep_copy();
            auto body = pm->body->deep_copy();

            std::set<string> body_free;
            free_vars(proj, pm->body->deep_copy(), body_free);

            for (auto [sym,_] : symbols) {
                body_free.erase(sym);   
            }

            std::set<string> ps;
            std::set_union(body_free.begin(), body_free.end(), _prev.begin(), _prev.end(),
                   std::inserter(ps, ps.end()));

            std::set<string> magic_variables;
            std::set_union(ps.begin(), ps.end(), src_free.begin(), src_free.end(),
                   std::inserter(magic_variables, magic_variables.end()));

            std::set<string> ps2 = std::set<string>(magic_variables);

            for (auto [sym,_] : symbols) {
                if (sym == "_")
                    continue;
                if (!proj->is_known_symbol(sym)) {
                    std::set<string> temp = std::set<string>(magic_variables);
                    for (auto [osym,_]: symbols) {
                        if (sym != osym) {
                            temp.insert(osym);
                        }
                    }
                    auto new_sym = pick_new_name(sym, temp);
                    magic_variables.insert(new_sym);
                }
            }

            body = eliminate_ambiguity(std::move(body), magic_variables, changed);

            for (auto [sym,typ] : symbols) {
                if (sym == "_")
                    continue;
                if (!proj->is_known_symbol(sym)) {
                    std::set<string> temp = std::set<string>(ps2);
                    for(auto [osym,_]: symbols) {
                        if(sym != osym) {
                            temp.insert(osym);
                        }
                    }
                    auto new_sym = pick_new_name(sym, temp);
                    ps2.insert(new_sym);

                    if (sym != new_sym) {
                        auto new_symbol = std::make_unique<Symbol>(new_sym, typ);
                        bool succ = false;
                        pattern = subst(std::move(pattern), sym, new_symbol.get(), succ);
                        changed |= succ;
                        body = subst(std::move(body), sym, new_symbol.get(), succ);
                        changed |= succ;
                    }
                }
            }
            matches->push_back(make_unique<PatternMatch>(std::move(pattern), std::move(body)));
        }

        return std::make_unique<Match>(std::move(src), std::move(matches));
    } else if (auto r = instance_of(spec.get(), Rely)) {
        auto new_prop = eliminate_ambiguity(std::move(r->prop), prev_symbols, changed);
        auto new_body = eliminate_ambiguity(std::move(r->body), prev_symbols, changed);
        return std::make_unique<Rely>(std::move(new_prop), std::move(new_body));

    } else if (auto r = instance_of(spec.get(), Anno)) {
        auto new_prop = eliminate_ambiguity(std::move(r->prop), prev_symbols, changed);
        auto new_body = eliminate_ambiguity(std::move(r->body), prev_symbols, changed);
        return std::make_unique<Anno>(std::move(new_prop), std::move(new_body));

    } else if (auto i = instance_of(spec.get(), If)) {
        auto cond = eliminate_ambiguity(std::move(i->cond), prev_symbols, changed);
        auto then_body = eliminate_ambiguity(std::move(i->then_body), prev_symbols, changed);
        auto else_body = eliminate_ambiguity(std::move(i->else_body), prev_symbols, changed);
        return std::make_unique<If>(std::move(cond), std::move(then_body), std::move(else_body));

    } else if (auto fe = instance_of(spec.get(), ForallExists)) {
        auto prev = std::set<string>(prev_symbols);
        auto body = fe->body->deep_copy();
        auto vars = std::make_unique<std::vector<std::shared_ptr<Arg>>>(*fe->vars);

        auto free = std::set<string>();
        free_vars(proj, body->deep_copy(), free);

        for (const auto& arg : *vars) {
            free.erase(arg->name);
        }

        std::set<string> ps;
            std::set_union(free.begin(), free.end(), prev_symbols.begin(), prev_symbols.end(),
                   std::inserter(ps, ps.end()));

        for (auto &v : *vars) {
            auto temp = std::set<string>(ps);
            for(auto sym : *vars) {
                if(v->name != sym->name){
                    temp.insert(sym->name);
                }
            }
            auto new_name = pick_new_name(v->name, temp);

            if (v->name != new_name) {
                auto new_symbol = std::make_unique<Symbol>(new_name, v->type);
                bool succ = false;

                auto updated_body = subst(std::move(body), v->name, new_symbol.get(), succ);
                changed |= succ;
                body = std::move(updated_body);
            }
            ps.insert(new_name);
        }

        for (auto &v : *vars) {
            if (v->expr) {
                auto e = v->expr->deep_copy();
                v->expr.reset(dynamic_cast<Expr*>(eliminate_ambiguity(std::move(e), ps, changed).release()));
            }
        }

        if (is_instance(fe, Forall)) {
            return std::make_unique<Forall>(std::move(vars),
                                            eliminate_ambiguity(std::move(body), prev, changed));
        } else {
            return std::make_unique<Exists>(std::move(vars),
                                            eliminate_ambiguity(std::move(body), prev, changed));
        }
    }
    return spec;
}


/** rec_apply:
 *      - Recursively apply [f] to all nodes in [spec]
 *      - Use smart pointer in params and return type to avoid memory leak. 
 *          Any release() to raw pointer should be comment with reasons
 * by Ganxiang Yang, Feb 16, 2025
 */
std::unique_ptr<SpecNode> SpecRules::rec_apply(std::unique_ptr<SpecNode> spec,
                                                     const std::function<std::unique_ptr<SpecNode>(std::unique_ptr<SpecNode>)>& f,
                                                     bool apply_anno = true) {
    if (!spec) {
        return spec;
    }

    if (is_instance(spec.get(), Symbol)) {
        return f(std::move(spec));
    } else if (is_instance(spec.get(), Const)) {
        return f(std::move(spec));
    } else if (auto e = instance_of(spec.get(), Expr)) {
        auto new_elems = make_unique<vector<unique_ptr<SpecNode>>>();
        if (e->elems) {
            for (auto &old_elems : *(e->elems)) {
                new_elems->push_back(rec_apply(std::move(old_elems), f, apply_anno));
            }
            e->elems->clear();
        }

        return std::visit([&](auto &&arg) -> std::unique_ptr<SpecNode> {
            using T = std::decay_t<decltype(arg)>;
            if constexpr (std::is_same_v<T, std::unique_ptr<SpecNode>>) {
                auto new_op = rec_apply(std::move(arg), f, apply_anno);
                return f(std::make_unique<Expr>(std::move(new_op), std::move(new_elems), e->type));
            } else {
                return f(std::make_unique<Expr>(arg, std::move(new_elems), e->type));
            }
        }, e->op);

        // throw std::runtime_error("Unknown SpecNode " + string(*spec.get()));
    } else if (auto m = instance_of(spec.get(), Match)) {
        auto new_src = rec_apply(std::move(m->src), f, apply_anno);
        auto new_matches = make_unique<vector<unique_ptr<PatternMatch>>>();
        if (m->match_list) {
            for (auto &pm : *(m->match_list)) {
                auto pm_copy = std::make_unique<PatternMatch>(std::move(pm->pattern), rec_apply(std::move(pm->body), f, apply_anno));
                new_matches->push_back(std::move(pm_copy));
            }
        }
        return f(std::make_unique<Match>(std::move(new_src), std::move(new_matches)));
    } else if (auto r = instance_of(spec.get(), Rely)) {
        auto new_prop = rec_apply(std::move(r->prop), f, apply_anno);
        auto new_body = rec_apply(std::move(r->body), f, apply_anno);
        return f(std::make_unique<Rely>(std::move(new_prop), std::move(new_body)));

    } else if (auto r = instance_of(spec.get(), Anno)) {
        auto new_prop = rec_apply(std::move(r->prop), f, apply_anno);
        auto new_body = rec_apply(std::move(r->body), f, apply_anno);
        return f(std::make_unique<Anno>(std::move(new_prop), std::move(new_body)));

    } else if (auto i = instance_of(spec.get(), If)) {
        auto new_cond = rec_apply(std::move(i->cond), f, apply_anno);
        auto new_then = rec_apply(std::move(i->then_body), f, apply_anno);
        auto new_else = rec_apply(std::move(i->else_body), f, apply_anno);
        return f(std::make_unique<If>(std::move(new_cond), std::move(new_then), std::move(new_else)));

    } else if (auto fe = instance_of(spec.get(), Forall)) {
        auto vars = make_unique<vector<shared_ptr<Arg>>>();
        if (fe->vars) {
            for (auto &v : *(fe->vars)) {
                if (v->expr) {
                    /** apply f to the hypos
                     *  this release will not leak since v->expr takes the ownership of the Expr object
                     *      by Ganxiang Yang, Feb 16, 2025
                     */
                    auto new_expr = rec_apply(std::move(v->expr), f, apply_anno);
                    auto e = dynamic_cast<Expr*>(new_expr.release());
                    if (e) {
                        v->expr = std::unique_ptr<Expr>(e);
                    } else {
                        throw std::runtime_error("rec_apply did not return an Expr type for the hypothesis!");
                    }
                }
                vars->push_back(v);
            }
            fe->vars->clear();
        }
        return f(std::make_unique<Forall>(std::move(vars), rec_apply(std::move(fe->body), f, apply_anno)));
    } else if (auto fe = instance_of(spec.get(), Exists)) {
        auto vars = make_unique<vector<shared_ptr<Arg>>>();
        if (fe->vars) {
            for (auto &v : *(fe->vars)) {
                vars->push_back(v);
            }
            fe->vars->clear();
        }
        return f(std::make_unique<Exists>(std::move(vars), rec_apply(std::move(fe->body), f, apply_anno)));

    } else {
        return f(std::move(spec));
    }
}

rule_ret_t SpecRules::rule_eliminate_let(std::unique_ptr<SpecNode> spec) {
    bool changed = false;
    auto f = [&](std::unique_ptr<SpecNode> node) -> std::unique_ptr<SpecNode> {
        if (!node) {
            return node;
        }
        if (auto m = instance_of(node.get(), Match)) {
            if (m->is_let()) {
                if (auto pattern = instance_of(m->match_list->at(0)->pattern.get(), Symbol)) {
                    std::string name = pattern->text;
                    if (!proj->is_known_symbol(name)) {
                        SpecNode* value = m->src.get();
                        auto body = std::move(m->match_list->at(0)->body);
                        bool succ = false;
                        auto new_e = subst(std::move(body), name, value, succ);
                        changed = true;
                        return new_e;
                    }
                
                }
            }
        }
        return node;
    };
    auto new_root = rec_apply(std::move(spec), f, false);
    return { std::move(new_root), changed };
}


/*
when X == (if c then (Some Y) else (Some Z)); body
=> if c then (match Y with X => body) else (match Z with X => body)
*/
rule_ret_t SpecRules::rule_eliminate_when(std::unique_ptr<SpecNode> spec) {
    bool changed = false;
    std::function<std::unique_ptr<SpecNode>(std::unique_ptr<SpecNode>)> f =
        [&](std::unique_ptr<SpecNode> node) -> std::unique_ptr<SpecNode> {
            if (auto m = instance_of(node.get(), Match)) {
                if (m->is_when()) {
                    auto pattern = dynamic_cast<Expr*>(m->match_list->at(0)->pattern.get());
                    auto &when_body = m->match_list->at(0)->body;

                    // an aux function to substitute the when body
                    std::function<std::unique_ptr<SpecNode>(std::unique_ptr<SpecNode>&)> subst_when =
                        [&](std::unique_ptr<SpecNode>& node) -> std::unique_ptr<SpecNode> {
                        if (auto m = instance_of(node.get(), Symbol)) {
                            if (m->text == "None") {
                                return std::make_unique<Symbol>("None", when_body->get_type());
                            } else {
                                return nullptr;
                            }
                        } else if (auto m = instance_of(node.get(), Expr)) {
                            if (holds_alternative<Expr::ops>(m->op) && std::get<Expr::ops>(m->op) == Expr::ops::Some) {
                                auto vec = std::make_unique<std::vector<std::unique_ptr<PatternMatch>>>();
                                vec->push_back(std::make_unique<PatternMatch>(pattern->elems->at(0)->deep_copy(), when_body->deep_copy()));
                                return std::make_unique<Match>(m->elems->at(0)->deep_copy(), std::move(vec));
                            }
                            return nullptr;
                        } else if (auto m = instance_of(node.get(), Match)) {
                            auto vec = std::make_unique<std::vector<std::unique_ptr<PatternMatch>>>();
                            for (auto& pm : *m->match_list) {
                                auto subst_body = subst_when(pm->body);
                                if (!subst_body) {
                                    return nullptr;
                                }
                                vec->push_back(std::make_unique<PatternMatch>(pm->pattern->deep_copy(), std::move(subst_body)));
                            }
                            return std::make_unique<Match>(m->src->deep_copy(), std::move(vec));
                        } else if (auto m = instance_of(node.get(), Rely)) {
                            auto body = subst_when(m->body);
                            if (!body) {
                                return nullptr;
                            }
                            return std::make_unique<Rely>(m->prop->deep_copy(), std::move(body));
                        } else if (auto m = instance_of(node.get(), Anno)) {
                            auto body = subst_when(m->body);
                            if (!body) {
                                return nullptr;
                            }
                            return std::make_unique<Anno>(m->prop->deep_copy(), std::move(body));
                        } else if (auto m = instance_of(node.get(), If)) {
                            auto then_body = subst_when(m->then_body);
                            auto else_body = subst_when(m->else_body);
                            if (!then_body || !else_body) {
                                return nullptr;
                            }
                            return std::make_unique<If>(m->cond->deep_copy(), std::move(then_body), std::move(else_body));
                        } else if (auto m = instance_of(node.get(), Forall)) {
                            return std::move(node);
                        } else if (auto m = instance_of(node.get(), Exists)) {
                            return std::move(node);
                        } else if (auto m = instance_of(node.get(), Const)) {
                            return nullptr;
                        } else {
                            throw std::runtime_error("Unknown node type:" + string(*node->type));
                        }
                    };
                    
                    auto new_body = subst_when(m->src);
                    if (!new_body) {
                        return node;
                    }
                    changed = true;
                    return std::move(new_body);
                } else {
                    return node;
                }
            } else {
                return node;
            }
        };
    auto new_spec = rec_apply(std::move(spec), f, false);
    return { std::move(new_spec), changed };
}

/*
if true then [then_body] else [else_body] ===> [then_body]
if false then [then_body] else [else_body] ===> [else_body]
if ... then [body] else [body] ===> [body]

The following simplification may not actually simplify the expression
if A then [then_body] else (if B then [then_body] else [else_body]) ===> if (A || B) then [then_body] else [else_body]
*/
rule_ret_t SpecRules::rule_eliminate_if(std::unique_ptr<SpecNode> spec) {
    bool changed = false;
    auto f = [&](std::unique_ptr<SpecNode> node) -> std::unique_ptr<SpecNode> {
        if (!node) {
            return node;
        }
        if (auto i = instance_of(node.get(), If)) {
            if (auto cond = instance_of(i->cond.get(), Const)) {
                if (auto val = std::get_if<bool>(&cond->value)) {
                    changed = true;
                    return (*val) ? std::move(i->then_body) : std::move(i->else_body);
                }
            } else if (auto cond = instance_of(i->cond.get(), Expr)) {
                if (auto op = std::get_if<Expr::binops>(&cond->op)) {
                    if (*op == Expr::SEQ) {
                        if (auto l = instance_of(cond->elems->at(0).get(), Const)) {
                            if (auto r = instance_of(cond->elems->at(1).get(), Const)) {
                                if (auto l_str = std::get_if<string>(&l->value)) {
                                    if (auto r_str = std::get_if<string>(&r->value)) {
                                        changed = true;
                                        return (*l_str == *r_str) ? std::move(i->then_body) : std::move(i->else_body);
                                    }
                                }
                            }
                        }
                    }
                }   
            }
        }
        return node;
    };
    auto new_root = rec_apply(std::move(spec), f, false);
    return { std::move(new_root), changed };
}

rule_ret_t SpecRules::rule_eliminate_match_simple(std::unique_ptr<SpecNode> spec) {
    bool changed = false;
    auto f = [&](std::unique_ptr<SpecNode> node) -> std::unique_ptr<SpecNode> {            
        if (auto m = instance_of(node.get(), Match)) {
            auto possible = false;
            for (int i = 0; i < m->match_list->size() ; ++i) {
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
                        changed = true;
                        return new_body;
                    }
                }
                if (possible)
                    break;
            }
            return node;
        } else {
            return node;
        }

    };
    auto new_spec = rec_apply(std::move(spec), f, false);
    return { std::move(new_spec), changed };
}

rule_ret_t SpecRules::rule_subst_match_src_with_content(std::unique_ptr<SpecNode> spec) {
    bool changed = false;
    auto f = [&](std::unique_ptr<SpecNode> node) -> std::unique_ptr<SpecNode> {
        if (auto s = instance_of(node.get(), Match)) {
            if (s->is_let()) {
                return node;
            }
            auto matches = std::make_unique<std::vector<std::unique_ptr<PatternMatch>>>();
            for (auto& pm : *s->match_list) {
                std::set<string> vars;
                get_vars_from_pattern(proj, pm->pattern.get(), vars);
                if (!contains_vars(proj, s->src.get(), vars)) {
                    bool succ = false;
                    auto body = subst_expr(proj, std::move(pm->body), s->src, pm->pattern, succ);
                    matches->push_back(std::make_unique<PatternMatch>(std::move(pm->pattern), std::move(body)));
                    changed |= succ;
                } else {
                    matches->push_back(std::move(pm));
                }
            }
            return std::make_unique<Match>(std::move(s->src), std::move(matches));
        }
        return node;
    };
    auto new_spec = rec_apply(std::move(spec), f, false);
    return { std::move(new_spec), changed };
}

rule_ret_t SpecRules::rule_simple_builtin_functions(std::unique_ptr<SpecNode> spec) {
    bool changed = false;
    auto f = [&](std::unique_ptr<SpecNode> node) -> std::unique_ptr<SpecNode> {
        if (auto s = instance_of(node.get(), Expr)) {
            if (holds_alternative<string>(s->op) && std::get<string>(s->op) == "ptr_to_int") {
                if (auto e = instance_of(s->elems->at(0).get(), Expr)) {
                    if (holds_alternative<string>(e->op) && std::get<string>(e->op) == "int_to_ptr") {
                        auto new_expr = std::move(e->elems->at(0));
                        changed = true;
                        return new_expr;
                    }
                }
            }
        }

        if (auto s = instance_of(node.get(), Expr)) {
            if (holds_alternative<string>(s->op) && std::get<string>(s->op) == "int_to_ptr") {
                if (auto e = instance_of(s->elems->at(0).get(), Expr)) {
                    if (holds_alternative<string>(e->op) && std::get<string>(e->op) == "ptr_to_int") {
                        auto new_expr = std::move(e->elems->at(0));
                        changed = true;
                        return new_expr;
                    }
                }
            }
        }
        return node;
    };
    auto new_root = rec_apply(std::move(spec), f, false);
    return { std::move(new_root), changed };
}

rule_ret_t SpecRules::rule_simple_record_get_set(std::unique_ptr<SpecNode> spec) {
    bool changed = false;
    auto f = [&](std::unique_ptr<SpecNode> node) -> std::unique_ptr<SpecNode> {
        auto e = instance_of(node.get(), Expr);
        if (!e) {
            return node;
        }

        auto op = std::get_if<Expr::ops>(&e->op);
        
        if (op && *op == Expr::RecordGet) {
            auto rec = e->elems->at(0).get();
            auto field = static_cast<Symbol *>(e->elems->at(1).get())->text;
            auto typ = proj->structs.at(proj->symbols.at(field).info);

            auto rec_e = instance_of(rec, Expr);

            if (!rec_e)
                return node;

            if (auto rec_op = std::get_if<string>(&rec_e->op)) {
                if (proj->is_struct_constr(*rec_op)) {
                    // (mkRec "a" b).(a) => "a"
                    for (int i = 0; i < typ->elems->size(); i++) {
                        if (typ->elems->at(i)->name == field) {
                            changed = true;
                            auto new_expr = std::move(rec_e->elems->at(i));
                            return new_expr;
                        }
                    }
                    throw std::runtime_error("rule_simple_record_get_set: field not found" + string(*node));
                }
            } else if (auto rec_op = std::get_if<Expr::ops>(&rec_e->op)) {
                if (*rec_op == Expr::RecordSet) {
                    auto set_field = static_cast<Symbol *>(rec_e->elems->at(1).get())->text;
                    if (field == set_field) {
                        changed = true;
                        if (rec_e->elems->size() == 3) {
                            // (st.[a] :< v1).(a) ==> v1
                            auto new_expr = std::move(rec_e->elems->at(2));
                            return new_expr;

                        } else {
                            // (st.[a].[b].[c] :< v1).(a) ==> Record.set (Record.get st a) b c v1 ==> (st.(a)).[b].[c] :< v1
                            auto new_get_elems = make_unique<vector<unique_ptr<SpecNode>>>();

                            new_get_elems->push_back(std::move(rec_e->elems->at(0)));
                            new_get_elems->push_back(std::move(rec_e->elems->at(1)));

                            auto new_get = make_unique<Expr>(Expr::RecordGet, std::move(new_get_elems));
                            auto new_set_elems = make_unique<vector<unique_ptr<SpecNode>>>();

                            new_set_elems->push_back(std::move(new_get));
                            for (int i = 2; i < rec_e->elems->size(); i++)
                                new_set_elems->push_back(std::move(rec_e->elems->at(i)));

                            auto new_set = std::make_unique<Expr>(Expr::RecordSet, std::move(new_set_elems));
                            return new_set;
                        }
                    } else {
                        // (st.[a].[b].[c] :< v1).(d) ==> st.(d)
                        auto new_get_elems = make_unique<vector<unique_ptr<SpecNode>>>();

                        new_get_elems->push_back(std::move(rec_e->elems->at(0)));
                        new_get_elems->push_back(make_unique<Symbol>(field));

                        changed = true;
                        auto new_get = std::make_unique<Expr>(Expr::RecordGet, std::move(new_get_elems));
                        return new_get;
                    }
                }
            }
        } else if (op && *op == Expr::RecordSet) {
            auto rec = e->elems->at(0).get();
            vector<string> fields;

            auto old_value = rec->deep_copy();
            for (int i = 1; i < e->elems->size() - 1; i++) {
                auto field = static_cast<Symbol *>(e->elems->at(i).get())->text;
                auto get_elems = make_unique<vector<unique_ptr<SpecNode>>>();

                fields.push_back(field);
                get_elems->push_back(std::move(old_value));
                get_elems->push_back(make_unique<Symbol>(field));

                old_value = make_unique<Expr>(Expr::RecordGet, std::move(get_elems));
            }

            auto value = e->elems->back().get();
            if (auto rec_e = instance_of(rec, Expr)) {
                auto rec_op = std::get_if<Expr::ops>(&rec_e->op);
                if (rec_op && *rec_op == Expr::RecordSet) {
                    auto obj = rec_e->elems->at(0).get();
                    vector<string> subfields;

                    for (int i = 1; i < rec_e->elems->size() - 1; i++) {
                        auto field = static_cast<Symbol *>(rec_e->elems->at(i).get())->text;
                        subfields.push_back(field);
                    }

                    if (fields.size() <= subfields.size() &&
                        fields == vector<string>(subfields.begin(), subfields.begin() + fields.size())) {
                        // (st.[a].[b] :< v1).[a] :< v2 ==> st.[a] :< v2
                        auto new_set_elems = make_unique<vector<unique_ptr<SpecNode>>>();

                        new_set_elems->push_back(obj->deep_copy());
                        for (int i = 1; i < e->elems->size(); i++)
                            new_set_elems->push_back(std::move(e->elems->at(i)));

                        auto new_set = std::make_unique<Expr>(Expr::RecordSet, std::move(new_set_elems));
                        changed = true;
                        return new_set;
                    } else if (fields.size() > subfields.size() &&
                            subfields == vector<string>(fields.begin(), fields.begin() + subfields.size())) {
                        // (st.[a] :< v1).[a].[b] :< v2 ===> st.[a] :< (v1.[b] :< v2) (i.e. Record.set st a (Record.set v1 b v2))
                        auto inner_set_elems = make_unique<vector<unique_ptr<SpecNode>>>();
                        auto new_set_elems = make_unique<vector<unique_ptr<SpecNode>>>();

                        inner_set_elems->push_back(std::move(rec_e->elems->back()));
                        for (int i = 1 + subfields.size(); i < e->elems->size(); i++)
                            inner_set_elems->push_back(std::move(e->elems->at(i)));

                        auto inner_set = make_unique<Expr>(Expr::RecordSet, std::move(inner_set_elems));

                        for (int i = 0; i < rec_e->elems->size() - 1; i++)
                            new_set_elems->push_back(std::move(rec_e->elems->at(i)));

                        new_set_elems->push_back(std::move(inner_set));

                        auto new_set = make_unique<Expr>(Expr::RecordSet, std::move(new_set_elems));
                        changed = true;
                        return new_set;

                    } else if (fields < subfields) {
                        // (st.[a].[b].[c] :< v1).[d] :< v2 ==> (st.[d] :< v2).[a].[b].[c] :< v1 (i.e.  Record.set (Record.set st d v2) a b c v1)
                        // (st.[a].[b].[d] :< v1).[a].[b].[c] :< v2 ==>(st.[a].[b].[c] :< v2).[a].[b].[d] :< v1
                        auto inner_set_elems = make_unique<vector<unique_ptr<SpecNode>>>();
                        auto new_set_elems = make_unique<vector<unique_ptr<SpecNode>>>();

                        inner_set_elems->push_back(obj->deep_copy());
                        for (int i = 1; i < e->elems->size(); i++)
                            inner_set_elems->push_back(std::move(e->elems->at(i)));

                        auto inner_set = make_unique<Expr>(Expr::RecordSet, std::move(inner_set_elems));

                        new_set_elems->push_back(std::move(inner_set));
                        for (int i = 1; i < rec_e->elems->size(); i++)
                            new_set_elems->push_back(std::move(rec_e->elems->at(i)));

                        auto new_set = make_unique<Expr>(Expr::RecordSet, std::move(new_set_elems));
                        changed = true;
                        return new_set;
                    }
                }
            }

            if (auto value_e = instance_of(value, Expr)) {
                auto value_op = std::get_if<Expr::ops>(&value_e->op);

                if (value_op && *value_op == Expr::RecordGet &&
                    dynamic_cast<Symbol *>(value_e->elems->at(1).get())->text == fields.back()) {
                        bool valid = true;
                        SpecNode *_value = value_e;

                        for (auto const &f: fields) {
                            auto _value_e = instance_of(_value, Expr);

                            if (!_value_e) {
                                valid = false;
                                break;
                            }

                            auto op = std::get_if<Expr::ops>(&_value_e->op);

                            if (*op != Expr::RecordGet ||
                                dynamic_cast<Symbol *>(_value_e->elems->at(1).get())->text != f) {
                                valid = false;
                                break;
                            }

                            _value = _value_e->elems->at(0).get();
                        }
                        if (valid && *value == *rec) {
                            auto new_expr = rec->deep_copy();
                            changed = true;
                            return new_expr;
                        } else {
                            return node;
                        }
                } else if (value_op && *value_op == Expr::RecordGet && *value_e->elems->at(0) == *old_value) {
                    auto new_elems = make_unique<vector<unique_ptr<SpecNode>>>();

                    new_elems->push_back(rec->deep_copy());

                    for (int i = 1; i < e->elems->size() - 1; i++)
                        new_elems->push_back(std::move(e->elems->at(i)));

                    for (int i = 1; i < value_e->elems->size(); i++)
                        new_elems->push_back(std::move(value_e->elems->at(i)));

                    auto new_expr = make_unique<Expr>(Expr::RecordSet, std::move(new_elems));
                    changed = true;
                    return new_expr;
                }
            }
        }
        return node;

    };
    auto new_root = rec_apply(std::move(spec), f, false);
    return { std::move(new_root), changed };
}

rule_ret_t SpecRules::rule_move_rely_out_when(std::unique_ptr<SpecNode> spec) {
    bool changed = false;
    auto f = [&](std::unique_ptr<SpecNode> node) -> std::unique_ptr<SpecNode> {
        if (auto m = instance_of(node.get(), Match)) {
            if (auto r = instance_of(m->src.get(), Rely)) {
                if (instance_of(m->type.get(), Option)) {
                    for (auto &pm : *m->match_list) {
                        if (string(*pm->pattern) == "None" && string(*pm->body) == "None") {
                            changed = true;
                            return std::make_unique<Rely>(std::move(r->prop),
                                                            std::make_unique<Match>(std::move(r->body), std::move(m->match_list)));
                        }
                    }
                    return node;
                }
            }
        }
        return node;
    };
    auto new_root = rec_apply(std::move(spec), f, false);
    return { std::move(new_root), changed };
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
rule_ret_t SpecRules::rule_move_when_out_when(std::unique_ptr<SpecNode> spec) {
    bool changed = false;

    auto f = [&](std::unique_ptr<SpecNode> node) -> std::unique_ptr<SpecNode> {
        if (auto m = instance_of(node.get(), Match)) {
            if (auto src = instance_of(m->src.get(), Match)) {
                if (src->is_when() && is_instance(m->type.get(), Option)) {
                    for (const auto &pm : *m->match_list) {
                        if (string(*pm->pattern) == "None" && string(*pm->body) == "None") {
                            auto pattern = dynamic_cast<Expr*>(src->match_list->at(0)->pattern.get());
                            auto match = make_unique<Match>(std::move(src->match_list->at(0)->body), std::move(m->match_list));
                            auto new_match = std::unique_ptr<Match>(
                                Match::raw_when(
                                    std::move(pattern->elems->at(0)),
                                    std::move(src->src),
                                    std::move(match)
                                )
                            );
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

    auto new_spec = rec_apply(std::move(spec), f, false);
    return { std::move(new_spec), changed };
}

/*
match (if c then A else B) with { ... } -> if c then (match A with { ... }) else (match B with { ... })
*/
rule_ret_t SpecRules::rule_move_if_out_match(std::unique_ptr<SpecNode> spec) {
    bool changed = false;

    auto f = [&](std::unique_ptr<SpecNode> node) -> std::unique_ptr<SpecNode> {
        if (auto m = instance_of(node.get(), Match)) {
            if (auto src = instance_of(m->src.get(), If)) {
                unique_ptr<Match> m1(static_cast<Match*>(m->deep_copy().release()));
                auto new_if = std::make_unique<If>(std::move(src->cond),
                                     make_unique<Match>(std::move(src->then_body), std::move(m->match_list)),
                                     make_unique<Match>(std::move(src->else_body), std::move(m1->match_list)));
                changed = true;
                return new_if;
            }
        }

        return node;
    };

    auto new_spec = rec_apply(std::move(spec), f, false);
    return { std::move(new_spec), changed };
}

rule_ret_t SpecRules::rule_move_if_out_expr(std::unique_ptr<SpecNode> spec) {
    bool changed = false;
    auto f = [&](std::unique_ptr<SpecNode> node) -> std::unique_ptr<SpecNode> {
        if (auto e = instance_of(node.get(), Expr)) {
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
                    auto new_if = std::make_unique<If>(
                        std::move(elem->cond),
                        std::make_unique<Expr>(std::move(e1->op), std::move(elems1), e->type),
                        std::make_unique<Expr>(std::move(e2->op), std::move(elems2), e->type)
                    );
                    changed = true;
                    return new_if;
                }
            }
        }
        return node;
    };
    auto new_spec = rec_apply(std::move(spec), f, false);
    return { std::move(new_spec), changed };
}

rule_ret_t SpecRules::rule_move_match_out_expr(std::unique_ptr<SpecNode> spec) {
    bool changed = false;
    auto f = [&](std::unique_ptr<SpecNode> node) -> std::unique_ptr<SpecNode> {
        if (auto e = instance_of(node.get(), Expr)) {
            for (size_t i = 0; i < e->elems->size(); i++) {
                if (auto elem = instance_of(e->elems->at(i).get(), Match)) {
                    bool movable = true;
                    for (const auto &pm : *elem->match_list) {
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
                        auto matches = std::make_unique<std::vector<std::unique_ptr<PatternMatch>>>();
                        for (auto &pm : *elem->match_list) {
                            auto elems = std::make_unique<std::vector<std::unique_ptr<SpecNode>>>();
                            for (size_t j = 0; j < e->elems->size(); j++) {
                                if (j == i)
                                    elems->push_back(std::move(pm->body));
                                else
                                    elems->push_back(e->elems->at(j)->deep_copy());
                            }
                            std::variant<std::unique_ptr<SpecNode>, Expr::ops, Expr::binops, std::string> new_op;
                            if (auto op = std::get_if<Expr::ops>(&e->op)) {
                                new_op = *op;
                            } else if (auto binop = std::get_if<Expr::binops>(&e->op)) {
                                new_op = *binop;
                            } else if (auto str = std::get_if<std::string>(&e->op)) {
                                new_op = *str;
                            } else if (auto expr = std::get_if<std::unique_ptr<SpecNode>>(&e->op)) {
                                new_op = (*expr)->deep_copy();
                            }

                            auto expr = std::make_unique<Expr>(std::move(new_op), std::move(elems), e->type);

                            matches->push_back(std::make_unique<PatternMatch>(std::move(pm->pattern),
                                                                                std::move(expr)));
                        }
                        auto new_match = std::make_unique<Match>(std::move(elem->src), std::move(matches));
                        changed = true;
                        return new_match;
                    }
                }
            }
        }
        return node;
    };

    auto new_spec = rec_apply(std::move(spec), f, false);
    return { std::move(new_spec), changed };

}

rule_ret_t SpecRules::rule_unfold_specs(std::unique_ptr<SpecNode> spec) {
    bool unfolded = false;
    bool changed = false;
    auto f = [&](std::unique_ptr<SpecNode> node) -> std::unique_ptr<SpecNode> {
        if (unfolded)
            return node;
        if (auto e = instance_of(node.get(), Expr)) {
            if (auto op = std::get_if<string>(&e->op)) {
                if (proj->defs.find(*op) == proj->defs.end())
                    return node;

                if (proj->cmds.NoUnfold.find(*op) != proj->cmds.NoUnfold.end() &&
                    proj->cmds.Unfold.find(*op) == proj->cmds.Unfold.end())
                    return node;

                auto define = proj->defs[*op].get();

                if (is_instance(define, Fixpoint))
                    return node;

                std::cout << "Unfold definition (smart): " << define->name << std::endl;
                if (define->deleyed_type_inference) {
                    define->infer_type(*proj);
                    define->deleyed_type_inference = false;
                }

                auto body = define->body->deep_copy();
                assert(e->elems->size() == define->args->size());

                if (proj->symbols.find(define->name) != proj->symbols.end() &&
                    std::get<0>(proj->symbols[define->name].loc) != "")
                    unfolded = true;

                changed = true;
                if (e->elems->size() == 0) {
                    return body;
                } else if (e->elems->size() == 1) {
                    return std::unique_ptr<SpecNode>(Match::raw_let(define->args->at(0)->name, 
                                                        std::move(e->elems->at(0)), 
                                                        std::move(body),
                                                        define->args->at(0)->type));
                } else {
                    auto tuple_type_list = std::make_shared<std::vector<std::shared_ptr<SpecType>>>();
                    for (auto &elem : *e->elems) {
                        tuple_type_list->push_back(elem->get_type());
                    }

                    auto tuple_type = std::make_shared<Tuple>(tuple_type_list);
                    auto src = std::make_unique<Expr>(Expr::Tuple, std::move(e->elems), tuple_type);

                    auto pattern_list = std::make_unique<std::vector<std::unique_ptr<SpecNode>>>();
                    for (auto &arg : *define->args) {
                        pattern_list->push_back(std::make_unique<Symbol>(arg->name, arg->type));
                    }

                    auto pattern = std::make_unique<Expr>(Expr::Tuple, std::move(pattern_list), tuple_type);
                    auto pm_list = std::make_unique<std::vector<std::unique_ptr<PatternMatch>>>();

                    pm_list->push_back(std::make_unique<PatternMatch>(std::move(pattern), std::move(body)));

                    return std::make_unique<Match>(std::move(src), std::move(pm_list));
                }
            }
        }

        return node;
    };
    auto new_spec = rec_apply(std::move(spec), f, false);
    return { std::move(new_spec), changed };
}

rule_ret_t SpecRules::rule_simplify_expr(std::unique_ptr<SpecNode> spec) {
    bool expr_is_changed = false;
    auto f = [&](std::unique_ptr<SpecNode> node) -> std::unique_ptr<SpecNode> {
        unique_ptr<SpecNode> expr = node->deep_copy();

        if (auto m = instance_of(node.get(), If)) {
            if (auto c = instance_of(m->cond.get(), BoolConst)) {
                if (std::get<bool>(c->value)) {
                    return std::move(m->then_body);
                } else {
                    return std::move(m->else_body);
                }
            }
        } else if (auto m = instance_of(node.get(), Expr)) {
            if (holds_alternative<Expr::binops>(m->op)) {
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

                    return std::make_unique<Expr>(ops, unique_ptr<vector<unique_ptr<SpecNode>>>(elems2), node->get_type());
                } else if (ops == op::ADD && is_const_zero(m->elems->at(0).get())) {
                    expr_is_changed = true;
                    return std::move(m->elems->at(1));
                } else if (ops == op::ADD && is_const_zero(m->elems->at(1).get())) {
                    expr_is_changed = true;
                    return std::move(m->elems->at(0));
                } else if (ops == op::MINUS && m->elems->size() == 2 && is_const_zero(m->elems->at(1).get())) {
                    expr_is_changed = true;
                    return std::move(m->elems->at(0));
                } else if ((ops == op::ADD || ops == op::MINUS) &&
                            m->elems->size() == 2 &&
                            (!is_instance(m->elems->at(0).get(), IntConst) ||
                            !is_instance(m->elems->at(1).get(), IntConst))) {
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
                        return make_unique<Expr>(op::MULT, std::move(elems), expr->get_type());
                    }

                    //here expr is not changed;
                } else if (ops == op::MINUS && m->elems->size() == 1) {
                    return expr;
                }

                bool all_intconst = true;
                for (auto & e : *m->elems) {
                    if (!is_instance(e.get(), IntConst)) {
                        if (is_instance(e.get(), Const) &&
                            holds_alternative<unsigned long>((static_cast<Const *>(e.get()))->value)) {
                            continue;
                        }
                        all_intconst = false;
                        break;
                    }
                }

                if(all_intconst) {
                    auto elem0 = instance_of(m->elems->at(0).get(), Const);
                    auto elem1 = instance_of(m->elems->at(1).get(), Const);

                    if(ops == op::ADD) {
                        expr_is_changed = true;
                        expr.reset(new IntConst(std::get<unsigned long>(elem0->value) + std::get<unsigned long>(elem1->value)));
                    } else if (ops == op::MINUS && m->elems->size() == 1) {
                        expr_is_changed = true;
                        expr.reset(new IntConst(-std::get<unsigned long>(elem0->value)));
                    } else if (ops == op::MINUS && m->elems->size() == 2) {
                        expr_is_changed = true;
                        long long res = std::get<unsigned long>(elem0->value) - std::get<unsigned long>(elem1->value);

                        if (res < 0) {
                            auto elems = make_unique<vector<unique_ptr<SpecNode>>>();
                            elems->push_back(make_unique<IntConst>((unsigned long)(-res)));

                            //return new Expr(op::MINUS, std::move(elems), Int::INT);
                            expr.reset(new Expr(op::MINUS, std::move(elems), Int::INT));
                        } else {
                            expr.reset(new IntConst(std::get<unsigned long>(elem0->value) - std::get<unsigned long>(elem1->value)));
                        }
                    } else if (ops == op::MULT) {
                        expr_is_changed = true;
                        expr.reset(new IntConst(std::get<unsigned long>(elem0->value) * std::get<unsigned long>(elem1->value)));
                    } else if(ops == op::DIV) {
                        expr_is_changed = true;
                        expr.reset(new IntConst(std::get<unsigned long>(elem0->value) / std::get<unsigned long>(elem1->value)));
                    } else if(ops == op::MOD) {
                        expr_is_changed = true;
                        expr.reset(new IntConst(std::get<unsigned long>(elem0->value) % std::get<unsigned long>(elem1->value)));
                    } else if(ops == op::BITAND) {
                        expr_is_changed = true;
                        expr.reset(new IntConst(std::get<unsigned long>(elem0->value) & std::get<unsigned long>(elem1->value)));
                    } else if(ops == op::BITOR) {
                        expr_is_changed = true;
                        expr.reset(new IntConst(std::get<unsigned long>(elem0->value) | std::get<unsigned long>(elem1->value)));
                    } else if(ops == op::LSHIFT) {
                        expr_is_changed = true;
                        expr.reset(new IntConst(std::get<unsigned long>(elem0->value) << std::get<unsigned long>(elem1->value)));
                    } else if(ops == op::RSHIFT) {
                        expr_is_changed = true;
                        expr.reset(new IntConst(std::get<unsigned long>(elem0->value) >> std::get<unsigned long>(elem1->value)));
                    } else if(ops == op::BEQ) {
                        expr_is_changed = true;
                        expr.reset(new BoolConst(std::get<unsigned long>(elem0->value) == std::get<unsigned long>(elem1->value)));
                    } else if(ops == op::BNE) {
                        expr_is_changed = true;
                        expr.reset(new BoolConst(std::get<unsigned long>(elem0->value) != std::get<unsigned long>(elem1->value)));
                    } else if(ops == op::BGT) {
                        expr_is_changed = true;
                        expr.reset(new BoolConst(std::get<unsigned long>(elem0->value) > std::get<unsigned long>(elem1->value)));
                    } else if(ops == op::BLT) {
                        expr_is_changed = true;
                        expr.reset(new BoolConst(std::get<unsigned long>(elem0->value) < std::get<unsigned long>(elem1->value)));
                    } else if(ops == op::BGE) {
                        expr_is_changed = true;
                        expr.reset(new BoolConst(std::get<unsigned long>(elem0->value) >= std::get<unsigned long>(elem1->value)));
                    } else if(ops == op::BLE) {
                        expr_is_changed = true;
                        expr.reset(new BoolConst(std::get<unsigned long>(elem0->value) <= std::get<unsigned long>(elem1->value)));
                    }

                    expr->_str.clear();
                }
            } else if (holds_alternative<Expr::ops>(m->op)) {
                auto ops = std::get<Expr::ops>(m->op);
                using op = Expr::ops;
                using bop = Expr::binops;
                if (ops == op::NOT || ops == op::BNOT) {
                    if (auto elem0 = instance_of(m->elems->at(0).get(), Expr)) {
                        std::set<bop> vec = {bop::EQUAL, bop::NOT_EQUAL, bop::LTE, bop::GTE, bop::GT, bop::LT, bop::BEQ,
                                            bop:: BNE, bop::BLT, bop::BGT, bop::BGE, bop::BLE};
                        if (holds_alternative<bop>(elem0->op)) {
                            auto elem0op = std::get<bop>(elem0->op);
                            if (vec.find(elem0op) != vec.end()) {
                                std::map<bop,bop> rev = {{bop::BEQ, bop::BNE}, {bop::EQUAL, bop::NOT_EQUAL},
                                                        {bop::LT, bop::GTE}, {bop::GTE, bop::LT}, {bop::GT, bop::LTE},
                                                        {bop::LTE, bop::GT}, {bop::BGT, bop::BLE}, {bop::BLE, bop::BGT},
                                                        {bop::BLT, bop::BGE}, {bop::BGE, bop::BLT}};
                                return make_unique<Expr>(rev[elem0op], std::move(elem0->elems), node->get_type());
                            }
                        }
                    }
                } else if (ops == Expr::RecordGet) {
                    if (auto record_expr = instance_of(m->elems->at(0).get(), Expr)) {
                        if (auto record_expr_op = std::get_if<Expr::ops>(&record_expr->op)) {
                            if (*record_expr_op == Expr::RecordSet) {
                                auto record_set_elems_size = record_expr->elems->size();
                                auto set_field = record_expr->elems->at(record_set_elems_size - 2).get();
                                auto get_field = m->elems->at(1).get();
                                assert(is_instance(set_field, Symbol));
                                assert(is_instance(get_field, Symbol));

                                if (*set_field == *get_field) {
                                    expr_is_changed = true;
                                    return std::move(record_expr->elems->at(record_set_elems_size - 1));
                                }
                            }
                        }
                    }
                }
            }
        }
        return expr;
    };
    auto new_spec = rec_apply(std::move(spec), f, false);
    return { std::move(new_spec), expr_is_changed };
}

rule_ret_t SpecRules::rule_keep_fields_of_interest(std::unique_ptr<SpecNode> spec) {
    bool changed = false;
    auto f = [&](std::unique_ptr<SpecNode> node) -> std::unique_ptr<SpecNode> {
        if (auto e = instance_of(node.get(), Expr)) {
            if (!std::holds_alternative<Expr::ops>(e->op) || std::get<Expr::ops>(e->op) != Expr::RecordSet)
                return node;

            // Only eliminate indifferent if the RecordSet is on the abs_data
            auto abs_data = proj->layers[0]->abs_data;

            if (e->elems->at(0)->get_type() != abs_data) {
                return node;
            }

            if (contains_interest_fields(node.get()))
                return node;

            auto new_elems = make_unique<vector<unique_ptr<SpecNode>>>();

            new_elems->push_back(make_unique<IntConst>(get_mono_lens_id()));
            new_elems->push_back(std::move(e->elems->at(0)));

            auto lens_name = "lens";
            auto new_e = std::make_unique<Expr>(lens_name, std::move(new_elems), abs_data);
            new_e->is_lens = true;
            changed = true;

            // Add the lens to the global scope
            if (!proj->is_known_symbol(lens_name)) {
                auto arg_types = std::make_shared<std::vector<std::shared_ptr<SpecType>>>();
                for (const auto &t : *new_e->elems) {
                    arg_types->push_back(t->get_type());
                }
                auto lens_type = std::make_shared<Function>(new_e->type, arg_types);
                auto lens = std::make_unique<Declaration>(lens_name, lens_type);
                proj->add_declaration(std::move(lens), std::make_shared<loc_t>(Project::LOC_GLOBALDEFS, "", ""));
            }

            return new_e;
        }
        return node;
    };

    auto new_root = rec_apply(std::move(spec), f, false);
    return { std::move(new_root), changed };
}

static std::unique_ptr<SpecNode> remove_expr_lens(std::unique_ptr<Expr> e, bool &changed) {
    if (op_is_lens(e->op)) {
        auto ret = std::move(e->elems->at(1));
        changed = true;
        return ret;
    } else if (auto op = std::get_if<Expr::ops>(&e->op)) {
        if (*op == Expr::GET || *op == Expr::RecordGet) {
            auto elem_copy = e->elems->at(0)->deep_copy();
            auto &rec = e->elems->at(0);
            if (auto rec_e = instance_of(rec.get(), Expr)) {
                auto ret = remove_expr_lens(std::unique_ptr<Expr>(static_cast<Expr*>(rec.release())), changed);

                e->elems->at(0) = std::move(elem_copy);
                if (ret.get() != rec_e)
                    e->elems->at(0) = std::move(ret);
                if (!e->elems->at(0)) {
                    throw std::runtime_error("remove_expr_lens: e->elems->at(0) is nullptr");
                }
            }
        }
    }
    return e;
}

rule_ret_t SpecRules::rule_simplify_lens(std::unique_ptr<SpecNode> spec) {
    bool changed = false;
    auto f = [&](std::unique_ptr<SpecNode> node) -> std::unique_ptr<SpecNode> {
        if (auto e = instance_of(node.get(), Expr)) {
            if (op_is_lens(e->op)) {
                if (auto ee = instance_of(e->elems->at(1).get(), Expr)) {
                    if (op_is_lens(ee->op)) {
                        // 1. lens y (lens x st) -> lens z st
                        e->elems = std::move(ee->elems);
                        e->elems->at(0).reset(new IntConst(get_mono_lens_id()));
                        changed = true;
                    } else if (auto op = std::get_if<Expr::ops>(&ee->op)) {
                        if (*op == Expr::RecordSet) {
                            auto rec = ee->elems->at(0).get();
                            if (auto rec_e = instance_of(rec, Expr)) {
                                bool __this_changed = false;
                                auto rec_expr = std::unique_ptr<Expr>(static_cast<Expr*>(ee->elems->at(0)->deep_copy().release()));
                                auto ret = remove_expr_lens(std::move(rec_expr), __this_changed);
                                changed |= __this_changed;

                                if (ret.get() != rec_e) {
                                    // 3.4. lens x (lens y st).[z] :< v ==> lens x st.[z] :< v
                                    ee->elems->at(0) = std::move(ret);
                                    e->elems->at(0) = std::make_unique<IntConst>(get_mono_lens_id());
                                    e->_str.clear();
                                }

                                // 3.3 lens (st.[y] :< v) ==> (lens st).[y] :< v
                                auto lens_elems = std::make_unique<std::vector<std::unique_ptr<SpecNode>>>();
                                auto lens_type = ee->elems->at(0)->get_type();

                                lens_elems->push_back(make_unique<IntConst>(get_mono_lens_id()));
                                lens_elems->push_back(ee->elems->at(0)->deep_copy());

                                auto lens_expr = make_unique<Expr>("lens", std::move(lens_elems), lens_type);

                                auto new_elems = make_unique<vector<unique_ptr<SpecNode>>>();
                                new_elems->push_back(std::move(lens_expr));
                                for (int i = 1; i < ee->elems->size(); i++)
                                    new_elems->push_back(std::move(ee->elems->at(i)));

                                auto new_expr = std::make_unique<Expr>(Expr::RecordSet, std::move(new_elems), lens_type);
                                changed = true;

                                return new_expr;
                            } else {
                                assert(is_instance(rec, Symbol));

                                auto lens_elems = std::make_unique<std::vector<std::unique_ptr<SpecNode>>>();
                                auto lens_type = ee->elems->at(0)->get_type();

                                lens_elems->push_back(std::make_unique<IntConst>(get_mono_lens_id()));
                                lens_elems->push_back(ee->elems->at(0)->deep_copy());
                                auto lens_expr = std::make_unique<Expr>("lens", std::move(lens_elems), lens_type);
                        
                                auto new_elems = std::make_unique<std::vector<std::unique_ptr<SpecNode>>>();
                                new_elems->push_back(std::move(lens_expr));
                                for (size_t i = 1; i < ee->elems->size(); ++i) {
                                    new_elems->push_back(std::move(ee->elems->at(i)));
                                }

                                auto new_expr = std::make_unique<Expr>(Expr::RecordSet, std::move(new_elems), lens_type);
                                
                                changed = true;

                                return new_expr;
                            }
                        }
                    }
                } else {
                    /** Abstracted Data: (lens id st) -> st */
                    auto new_ee = std::move(e->elems->at(1));
                    changed = true;
                    return new_ee;
                }
            } else if (auto op = std::get_if<Expr::ops>(&e->op)) {
                if (*op == Expr::RecordGet) {
                    auto field = static_cast<Symbol *>(e->elems->back().get());

                    if (interest_list.find(field->text) != interest_list.end()) {
                        // auto &rec = e->elems->at(0);
                        auto rec = e->elems->at(0).get();

                        if (auto rec_e = instance_of(rec, Expr)) {
                            bool __this_changed = false;
                            auto rec_expr = std::unique_ptr<Expr>(static_cast<Expr*>(e->elems->at(0)->deep_copy().release()));
                            auto ret = remove_expr_lens(std::move(rec_expr), __this_changed);
                            changed |= __this_changed;

                            if (ret.get() != rec_e) {
                                e->elems->at(0) = std::move(ret);
                            }
                        }
                    }
                }
            }
        } else if (auto m = instance_of(node.get(), Match)) {
            int none_cnt = 0;
            SpecNode *body = nullptr;
            for (auto &pm : *m->match_list) {
                if (auto s = instance_of(pm->body.get(), Symbol)) {
                    if (s->text == "None") {
                        none_cnt++;
                        continue;
                    }
                }
                body = pm->body.get();
            }

            if (m->match_list->size() - none_cnt > 1)
                return node;

            auto src = m->src.get();

            if (auto e = instance_of(src, Expr)) {
                if (auto op = std::get_if<Expr::ops>(&e->op)) {
                    if (*op == Expr::RecordGet) {
                        auto rec = e->elems->at(0).get();
                        if (rec_is_lens(rec)) {
                            // when _ == (lens st).(y); B ==> B
                            auto vars = std::set<std::string>();
                            auto pm = m->match_list->at(0).get();
                            get_vars_from_pattern(proj, pm->pattern.get(), vars);
                            if (contains_vars(proj, body, vars))
                                return node;

                            changed = true;
                            return std::move(pm->body);
                        }
                    }
                }
            }
        } else if (auto i = instance_of(node.get(), If)) {
            auto then_body = i->then_body.get();
            auto else_body = i->else_body.get();

            while (instance_of(then_body, RelyAnno))
                then_body = static_cast<RelyAnno*>(then_body)->body.get();

            while (instance_of(else_body, RelyAnno))
                else_body = static_cast<RelyAnno*>(else_body)->body.get();

            if (!expr_emits_lens(then_body) || !expr_emits_lens(else_body))
                return node;

            auto ret = then_body->deep_copy();
            changed = true;
            return ret;
        }
        return node;

    };

    auto new_root = rec_apply(std::move(spec), f, false);
    return { std::move(new_root), changed };
}

rule_ret_t SpecRules::replace_spec_name(std::unique_ptr<SpecNode> spec, unordered_map<string, string> &name_map) {
    bool changed = false;
    auto f = [&](std::unique_ptr<SpecNode> node) -> std::unique_ptr<SpecNode> {
            if (auto e = instance_of(node.get(), Expr)) {
                if (auto op = std::get_if<string>(&e->op)) {
                    if (name_map.find(*op) != name_map.end()) {
                        auto new_op = name_map[*op];
                        auto new_elems = std::make_unique<std::vector<std::unique_ptr<SpecNode>>>();

                        for (auto &elem : *e->elems)
                            new_elems->push_back(elem->deep_copy());

                        auto new_expr = std::make_unique<Expr>(new_op, std::move(new_elems), e->type);
                        changed = true;
                        return new_expr;
                    }
                }
            }
            return node;  
    };

    auto new_root = rec_apply(std::move(spec), f, false);
    return { std::move(new_root), changed };
}


std::unique_ptr<SpecNode> SpecRules::instantiate_prop(std::unique_ptr<SpecNode> spec, std::unique_ptr<SpecNode> instance_st, const std::string& st) {
    auto f = [&](std::unique_ptr<SpecNode> node) -> std::unique_ptr<SpecNode> {
        if (auto s = instance_of(node.get(), Symbol)) {
            if (s->text == st) {
                return instance_st->deep_copy();
            }
        }
        return node;  
    };

    return rec_apply(std::move(spec), f, false);
}


bool spec_is_pure(Project *proj, SpecNode *spec, bool &has_if) {
    if (auto e = instance_of(spec, Expr)) {
        if (auto op = std::get_if<Expr::ops>(&e->op)) {
            if (*op == Expr::None) {
                return true;
            } else if (*op == Expr::Some) {
                if (auto ee = instance_of(e->elems->at(0).get(), Expr)) {
                    if (auto ee_op = std::get_if<Expr::ops>(&ee->op)) {
                        if (*ee_op == Expr::Tuple) {

                            auto last_elem = ee->elems->back().get();

                            if (auto s = instance_of(last_elem, Symbol)) {
                                return s->text == "st";
                            }
                        }
                    }
                }
            }
        }

        return false;
    } else if (auto m = instance_of(spec, Match)) {
        for (auto &pm : *m->match_list) {
            if (!spec_is_pure(proj, pm->body.get(), has_if))
                return false;
        }

        return true;
    } else if (auto i = instance_of(spec, If)) {
        has_if = true;
        return spec_is_pure(proj, i->then_body.get(), has_if) && spec_is_pure(proj, i->else_body.get(), has_if);
    } else if (auto r = instance_of(spec, RelyAnno)) {
        return spec_is_pure(proj, r->body.get(), has_if);
    } else if (auto s = instance_of(spec, Symbol)) {
        return s->text == "st" || s->text == "None";
    } else if (auto c = instance_of(spec, Const)) {
        return true;
    } else if (auto fe = instance_of(spec, ForallExists)) {
        // pass
        return false;
    }

    throw std::runtime_error("spec_is_pure: unexpected node: " + string(*spec));
    return false;
}

/** spec_needs_state: st in spec can only appear in 
    1. parameter of a function call: check whether the function skip state
    2. Record get/set
    3. return value (should not be counted as usage)
*/
bool spec_needs_state(Project *proj, SpecNode *spec) {
    bool ret = false;
    if (auto e = instance_of(spec, Expr)) {
        /* First we need to handle the return value case: it will return an expression := (Some (X, st)), 
            which should not be countered in usage */
        if (auto op = std::get_if<Expr::ops>(&e->op)) {
            if (*op == Expr::Some) {
                if (auto ee = instance_of(e->elems->at(0).get(), Expr)) {
                    if (auto ee_op = std::get_if<Expr::ops>(&ee->op)) {
                        if (*ee_op == Expr::Tuple) {
                            // check X will not use st.
                            for (auto r = ee->elems->begin() ; r != ee->elems->end() - 1; r++)
                                if (spec_needs_state(proj, r->get()))
                                    return true;
                                    
                            auto last_elem = ee->elems->back().get();
                            if (auto s = instance_of(last_elem, Symbol))
                                if (s->text == "st")
                                    return false;
                        }
                    }
                }
            }
        } else if (auto op = std::get_if<unique_ptr<SpecNode>>(&e->op)) {
            if (spec_needs_state(proj, op->get()))
                return true;
        } else if (auto op = std::get_if<string>(&e->op)) {
            if (proj->defs.find(*op) != proj->defs.end())
                if (proj->skip_state_specs.find(*op) != proj->skip_state_specs.end())
                    return false;  // We have known the function skip states, so skip checking the parameters
        }

        for (auto &elem : *e->elems)
            if (spec_needs_state(proj, elem.get()))
                return true;

    } else if (auto m = instance_of(spec, Match)) {
        if (spec_needs_state(proj, m->src.get()))
            return true;

        for (auto &pm : *m->match_list)
            if (spec_needs_state(proj, pm->body.get()))
                return true;
    } else if (auto i = instance_of(spec, If)) {
        return spec_needs_state(proj, i->cond.get()) || spec_needs_state(proj, i->then_body.get()) || spec_needs_state(proj, i->else_body.get());
    } else if (auto r = instance_of(spec, RelyAnno)) {
        return spec_needs_state(proj, r->prop.get()) || spec_needs_state(proj, r->body.get());
    } else if (auto s = instance_of(spec, Symbol)) {
        /* st within return value will not reach this branch  */
        return s->text.find("st") == 0;
    } else if (auto s = instance_of(spec, Const)) {
        // pass
    } else {
        throw std::runtime_error("spec_needs_state: unexpected node (maybe forall / pattern match?): " + string(*spec));
    }
    return false;
}

void spec_remove_state(Project *proj, SpecNode *spec) {
    if (auto e = instance_of(spec, Expr)) {
        if (auto op = std::get_if<Expr::ops>(&e->op)) {
            if (*op == Expr::None)
                return;
            else if (*op == Expr::Some) {
                if (auto ee = instance_of(e->elems->at(0).get(), Expr)) {
                    if (auto ee_op = std::get_if<Expr::ops>(&ee->op)) {
                        if (*ee_op == Expr::Tuple) {

                            auto last_elem = ee->elems->back().get();

                            if (auto s = instance_of(last_elem, Symbol)) {
                                if (s->text == "st") {
                                    ee->elems->pop_back();
                                    ee->set_type(SpecType::UNKNOWN_TYPE);
                                    if (ee->elems->size() == 1) {
                                        e->elems = std::move(ee->elems);
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        return;
    } else if (auto m = instance_of(spec, Match)) {
        for (auto &pm : *m->match_list) {
            spec_remove_state(proj, pm->body.get());
        }

        return;
    } else if (auto i = instance_of(spec, If)) {
        spec_remove_state(proj, i->then_body.get());
        spec_remove_state(proj, i->else_body.get());

        return;
    } else if (auto r = instance_of(spec, RelyAnno)) {
        spec_remove_state(proj, r->body.get());

        return;
    } else if (auto s = instance_of(spec, Symbol)) {
        if (s->text == "None") {
            s->set_type(SpecType::UNKNOWN_TYPE);
            return;
        }
    }

    throw std::runtime_error("spec_remove_state: unexpected node: " + string(*spec));
    return ;
}

} // namespace autov
