#include <nodes.h>
#include <values.h>
#include <utils.h>
#include <shortcuts.h>
#include <project.h>
#include <cassert>
#include <utility>
#include <rules.h>
#include <z3_rules.h>
#include <symbolic.h>
#include <variant>
#include <coi.h>

namespace autov 
{

void print_field(const field_t &f) {
    std::cout << "[print_field] Field: ";
    for (auto &i : f) {
        std::cout << i << ", ";
    }
    std::cout << std::endl;
}

void print_path(const path_t &p) {
    std::cout << "[print_path] Path: ";
    for (auto &i : p) {
        std::cout << i << ", ";
    }
    std::cout << std::endl;
}

inline bool contains_field(const field_t &f_check, const field_t &f_interested) {
    return std::search(f_check.begin(), f_check.end(), f_interested.begin(), f_interested.end()) != f_check.end();
}

bool has_subfield(const std::set<field_t> &fields, const field_t &f) {
    for (auto &f_check : fields) {
        if (contains_field(f_check, f)) {
            return true;
        }
    }
    return false;
}

bool has_proper_subfield(const std::set<field_t> &fields, const field_t &f) {
    for (auto &f_check : fields) {
        if (f_check.size() != f.size() && contains_field(f_check, f)) {
            return true;
        }
    }
    return false;
}

void rec_analyze_used_fields(Project* proj, SpecNode* node, std::set<field_t> &fields);
/** get_access_field
 *      return the access field chain of the given expr
 *         e.g. (x).(y).(z) -> [z, y, x]
 *      fields is used when it composed of other unsolved expressions
 *         e.g. (x)@(y) -> fields.add(Analyse(y))
 */
field_t get_access_field(Project* proj, SpecNode* node, std::set<field_t> &fields, field_t &trace) {
    if (auto s = instance_of(node, Symbol)) {
        if (proj->symbols.find(s->text) != proj->symbols.end() &&
                                proj->symbols[s->text].kind == SymbolKind::StructElem) {
            // we reach the leaf field, add the current access trace to the set
            trace.push_back(s->text);
        }
        return trace;
    } else if (is_instance(node, Const)) {
        return trace;
    } else if (auto e = instance_of(node, Expr)) {
        if (holds_alternative<Expr::ops>(e->op)) {
            if (std::get<Expr::ops>(e->op) == Expr::GET) {
                // (x)@(y) :: F(y) should be evaluated independently
                rec_analyze_used_fields(proj, e->elems->at(1).get(), fields);
                return get_access_field(proj, e->elems->at(0).get(), fields, trace);
            } else if (std::get<Expr::ops>(e->op) == Expr::RecordGet) {
                get_access_field(proj, e->elems->at(1).get(), fields, trace);
                return get_access_field(proj, e->elems->at(0).get(), fields, trace);
            }
        }
    }
    // met with non-tracable opration, stop here and let rec_analyze_used_fields solve it
    rec_analyze_used_fields(proj, node, fields);
    return trace;
}

void rec_analyze_used_fields(Project* proj, SpecNode* node, std::set<field_t> &fields) {
    field_t empty_trace = {};
    if (auto wa = instance_of(node, ForallExists)) {
        for (auto const &var: *wa->vars) {
            if (var->expr) {
                rec_analyze_used_fields(proj, var->expr.get(), fields);
            }
        }
        rec_analyze_used_fields(proj, wa->body.get(), fields);
    } else if (auto r = instance_of(node, RelyAnno)) {
        rec_analyze_used_fields(proj, r->prop.get(), fields);
        rec_analyze_used_fields(proj, r->body.get(), fields);
    } else if (auto e = instance_of(node, Expr)) {
        if (holds_alternative<Expr::binops>(e->op)) {		
            for (int i = 0; i < e->elems->size(); i++) {
                rec_analyze_used_fields(proj, e->elems->at(i).get(), fields);
            }
        } else if (holds_alternative<Expr::ops>(e->op)) {
            if (std::get<Expr::ops>(e->op) == Expr::GET) {
                // (x)@(y):
                auto f = get_access_field(proj, e, fields, empty_trace);
                if (!f.empty()) {
                    fields.insert(f);
                }
            } else if (std::get<Expr::ops>(e->op) == Expr::SET) {
                rec_analyze_used_fields(proj, e->elems->at(1).get(), fields);
                // pass
            } else if (std::get<Expr::ops>(e->op) == Expr::RecordGet) {
                auto f = get_access_field(proj, e, fields, empty_trace);
                if (!f.empty()) {
                    fields.insert(f);
                }
            } else if (std::get<Expr::ops>(e->op) == Expr::RecordSet) { 
                // expr.elem[0]: record
                // expr.elem[1...n-2]: (sub)fields
                // expr.elem[n-1]: value
                auto fields_in_src = std::set<field_t>();
                auto fields_in_val = std::set<field_t>();
                field_t access_field = {};
                for (int i = e->elems->size() - 2; i > 0; i--) {
                    auto f = e->elems->at(i).get();
                    if (auto s = instance_of(f, Symbol)) {
                        access_field.push_back(s->text);
                    }
                }
                rec_analyze_used_fields(proj, e->elems->at(e->elems->size() - 1).get(), fields_in_val);
                rec_analyze_used_fields(proj, e->elems->at(0).get(), fields_in_src);
                
            } else {
                for (int i = 0; i < e->elems->size(); i++) {
                    rec_analyze_used_fields(proj, e->elems->at(i).get(), fields);
                }
            }
        } else if (holds_alternative<string>(e->op)) {
            for (int i = 0; i < e->elems->size(); i++) {
                rec_analyze_used_fields(proj, e->elems->at(i).get(), fields);
            }
        } else if (holds_alternative<unique_ptr<SpecNode>>(e->op)) {
            // pass
        }
    } else if (auto s = instance_of(node, Symbol)) {
        auto f = get_access_field(proj, s, fields, empty_trace);
        if (!f.empty()) {
            fields.insert(f);
        }

    } else if (auto c = instance_of(node, Const)) {
        // pass
    } else {
        throw std::runtime_error("[rec_analyze_used_fields] Unexpected node type: " + string(*node));
    }
}

void extract_vars_from_expr(Project *proj, SpecNode *pattern, std::set<string> &vars) {
    if (auto s = instance_of(pattern, Symbol)) {
        vars.insert(s->text);
    } else if (auto e = instance_of(pattern, Expr)) {
        if (auto *o = std::get_if<unique_ptr<SpecNode>>(&e->op))
            extract_vars_from_expr(proj, o->get(), vars);
        for (auto &elem : *e->elems)
            extract_vars_from_expr(proj, elem.get(), vars);
    }
}
/** collect_immi_symbols_in:
 *       compute each symbol's source expression of the given encoded path 
 * */
void collect_immi_symbols_in(Project *proj, SpecNode *spec, const path_t &path, int idx, std::map<string, path_node_t> &symbol_source) {
    /** TODO: skip abst func */
    if (auto s = instance_of(spec, Symbol)) {
        // pass
    } else if (auto e = instance_of(spec, Expr)) {
        // pass
    } else if (auto m = instance_of(spec, Match)) {
        // map: pattern -> m->src (source expression)
        /** TODO: only apply to _When stmt */
        for (auto &pm : *m->match_list) {
            auto pm_vars = std::set<string>();
            extract_vars_from_expr(proj, pm->pattern.get(), pm_vars);
            for (auto &v : pm_vars) {
                symbol_source[v].first = m->src.get();
                if (idx >= path.size()) {
                    symbol_source[v].second = path_t(path.begin(), path.end());
                } else {
                    symbol_source[v].second = path_t(path.begin(), path.begin() + (idx+1));
                }
            }
            collect_immi_symbols_in(proj, pm->body.get(), path, idx, symbol_source);
        }
    } else if (auto r = instance_of(spec, Rely)) {
        collect_immi_symbols_in(proj, r->body.get(), path, idx, symbol_source);
    } else if (auto r = instance_of(spec, Anno)) {
        collect_immi_symbols_in(proj, r->body.get(), path, idx, symbol_source);
    } else if (auto i = instance_of(spec, If)) {
        if (!path.empty() && idx < path.size()) {
            if (path.at(idx)) {
                collect_immi_symbols_in(proj, i->then_body.get(), path, idx+1, symbol_source);
            } else {
                collect_immi_symbols_in(proj, i->else_body.get(), path, idx+1, symbol_source);
            }
        }
        // |path| < #branch, pass
    } else {
        throw std::runtime_error("[collect_immi_symbols_in] Unexpected node type: " + string(*spec));
    }
}

/** backward_propagation_on_expr:
 *      Propagate interested-field update on Exprs.
 *      - Add used (but not tracked) fields to coi, 
 *      - When propagate to symbol, add them to to-be-solved symbol set
 */
void backward_propagation_on_expr(Project *proj, SpecNode *node, std::set<field_t> &coi, std::set<field_t> trace, std::set<string> &symbols) {
    if (auto e = instance_of(node, Expr)) {
        if (auto op = std::get_if<Expr::ops>(&e->op)) {
            if (*op == Expr::ops::RecordGet) {
                // Update coi set if necessary
                field_t access_field = {};
                std::set<field_t> used_fields = {};
                get_access_field(proj, e, used_fields, access_field);
                /** FP Elimination: if we are reading the same field duplicately to update its subfields.
                 *  e.g. st1.[f1] :< (st2.(f1) # (foo) == (bar))
                 *      1. spoq ensures st1 == st2 (last state)
                 *      2. f1 in trace, in this case (st.(f1)) should not be added to coi
                 */
                if (!has_subfield(trace, access_field) && coi_blacklist.find(access_field.front()) == coi_blacklist.end()) {
                    rec_analyze_used_fields(proj, e, coi);
                }
                
            } else if (*op == Expr::ops::GET) {
                for (int i = 0; i < e->elems->size(); i++) {
                    backward_propagation_on_expr(proj, e->elems->at(i).get(), coi, trace, symbols);
                }
            } else if (*op == Expr::ops::RecordSet) {
                // WRITE operation: 
                // expr.elem[0]: record
                // expr.elem[1...n-2]: (sub)fields
                // expr.elem[n-1]: value
                field_t set_field = {};
                for (int i = e->elems->size() - 2; i > 0; i--) {
                    auto f = e->elems->at(i).get();
                    if (auto s = instance_of(f, Symbol)) {
                        set_field.push_back(s->text);
                    }
                }
                if (has_subfield(coi, set_field)) {
                    // we are tracing the parent field of some interest field, keep tracing
                    trace.insert(set_field);
                    backward_propagation_on_expr(proj, e->elems->back().get(), coi, trace, symbols);
                }
                backward_propagation_on_expr(proj, e->elems->at(0).get(), coi, trace, symbols);
            } else if (*op == Expr::ops::SET) {
                field_t access_field_in_src = {};
                std::set<field_t> used_fields_in_src = {};
                get_access_field(proj, e->elems->at(0).get(), used_fields_in_src, access_field_in_src);
                if (!has_subfield(trace, access_field_in_src)) {
                    coi.insert(access_field_in_src); 
                }
                // continue walking on the structure tree
                backward_propagation_on_expr(proj, e->elems->at(1).get(), coi, trace, symbols);
            } 
        } else {
            for (int i = 0; i < e->elems->size(); i++) {
                backward_propagation_on_expr(proj, e->elems->at(i).get(), coi, trace, symbols);
            }
        }
    } else if (auto c = instance_of(node, Const)) {
        // pass
    } else if (auto s = instance_of(node, Symbol)) {
        // add to to-be-solved symbol set
        symbols.insert(s->text);
    } else if (auto m = instance_of(node, Match)) {
        LOG_WARNING << "[backward_propagation_on_expr] Unexpected node caused by imcomplete spec_transformation rule: " << string(*m);
        backward_propagation_on_expr(proj, m->src.get(), coi, trace, symbols);
    } else {
        throw std::runtime_error("[backward_propagation_on_expr] unknown node" + string(*node));
    }
}

/** collect_init_nodes_in:
 *      Find all essential values (return values & branch values), collect their Paths
 */
void collect_init_nodes_in(SpecNode *spec, path_t p, std::set<path_node_t> &init_nodes) {
    if (auto e = instance_of(spec, Expr)) {
        if (auto op = std::get_if<Expr::ops>(&e->op)) {
            if (*op == Expr::Some) {
                if (auto ret_Some = instance_of(e->elems->at(0).get(), Expr)) {
                    SpecNode *ret_st = ret_Some;
					// if the return value is := Some (ret_val, st), then take the last 'st'
                    if (auto ret_op = std::get_if<Expr::ops>(&ret_Some->op)) {
						if (*ret_op == Expr::Tuple) {
							ret_st = ret_Some->elems->back()->deep_copy().release();
						}
					}
                    init_nodes.insert({ret_st, p});
                }
            }
        }
    } else if (auto m = instance_of(spec, Match)) {
        for (auto &pm : *m->match_list) {
            collect_init_nodes_in(pm->body.get(), p, init_nodes);
        }
    } else if (auto i = instance_of(spec, If)) {
        init_nodes.insert({i->cond.get(), p});
        path_t p_then = p, p_else = p;
        p_then.push_back(1);
        p_else.push_back(0);
        collect_init_nodes_in(i->then_body.get(), p_then, init_nodes);
        collect_init_nodes_in(i->else_body.get(), p_else, init_nodes);
    } else if (auto r = instance_of(spec, RelyAnno)) {
        collect_init_nodes_in(r->body.get(), p, init_nodes);
    } else if (auto f = instance_of(spec, ForallExists)) {
        collect_init_nodes_in(f->body.get(), p, init_nodes);
    }
}

/* Collect accessed fields in invariants */
void analyze_invariant_fields(Project *proj, SpecNode *inv, std::set<field_t> &fields) {
    rec_analyze_used_fields(proj, inv, fields);
}

/** backward_propagation: 
 *  Step 1. Find propagation expression (e.g. return values)
 *  Step 2. From expression, (backward) infer needed values
 *  Step 3. Find the definition of needed values (if necessary), update them to expressions 
 * 
 * Repeat steps until find all the dependent fields (Fixpoint of COI)
 *      Propagation (coi update) terminates when no new expression is propagated along the path
 * 
 *  Give an expression and a set of interested fields, backward propagate to all the dependent fields (its definition)
 */
std::set<string> analyze_cone_of_influence(Project *proj, Definition *def, SpecNode *inv, std::set<string> whitelist, std::set<string> blacklist) {
    std::set<string> coi_ret = {};
    for (auto c : whitelist) {
        coi_ret.insert(c);
    }

    auto args = def->args.get();
    auto spec = def->body.get();
    std::set<string> arg_symbols = {};
    for (int i = 0 ; i < args->size() ; i++) {
        arg_symbols.insert(args->at(i)->name);
    }

    // initial propagation set: return values
    std::set<path_node_t> nodes = {};
    path_t p = {};
    collect_init_nodes_in(spec, p, nodes);

    // initial propagation field: inv-related fields
    std::set<field_t> coi_fields = {};
    analyze_invariant_fields(proj, inv, coi_fields);
    std::cout << "[analyze_cone_of_influence] Initial COI fields: " << std::endl;
    for (auto &c : coi_fields) {
        print_field(c);
    }
    // Propagation (coi update) terminates when no new expression is propagated along the path
    std::deque<path_node_t> q(nodes.begin(), nodes.end());
    while (!q.empty()) {
        auto [expr, path] = q.front();
        q.pop_front();
        std::map<string, path_node_t> immediate_symbols = {};
        collect_immi_symbols_in(proj, spec, path, 0, immediate_symbols);

        std::set<string> symbols = {};
        backward_propagation_on_expr(proj, expr, coi_fields, {}, symbols);

        for (const auto &s : symbols) {
            if (arg_symbols.find(s) != arg_symbols.end()) {
                /** TODO: optimization: 
                 *          if a field belongs to an input parameter, 
                 *          then its access fields should not be added to coi set 
                 */
                continue;
            } else if (proj->symbols.find(s) != proj->symbols.end() || proj->is_ind_constr(s)) {
                continue;
            } else if (immediate_symbols.find(s) != immediate_symbols.end()) {
                q.push_back(immediate_symbols[s]);
            } else {
                throw std::runtime_error("[analyze_cone_of_influence] Unexpected symbol: " + s);
            }
        }   
    }
    for (auto &c : coi_fields) {
        if (blacklist.find(c.front()) != blacklist.end()) {
            continue;
        }
        coi_ret.insert(c.front());
    }
    return coi_ret;
}

}