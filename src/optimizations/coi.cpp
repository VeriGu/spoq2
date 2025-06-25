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

/** 
 * Consider the record as a tree, then for a write field F and a interested field G, there can be only 4 cases on the structure tree
 *  1. F = G (F identical with G)
 *  2. G < F (G is a prefix-vector of F)
 *  3. F < G (F is a prefix-vector of G)
 *  4. F and G are disjoint
 * Only in the disjoint case (case 4) can we mask the write.
 */
bool is_prefix(const field_t &prefix, const field_t &full) {
    if (prefix.size() > full.size())
        return false;
    for (size_t i = 0; i < prefix.size(); i++) {
        if (prefix[i] != full[i])
            return false;
    }
    return true;
}

bool useless_write(const field_t &f_check, const field_t &f_interested) {
    if (!is_prefix(f_check, f_interested) && !is_prefix(f_interested, f_check))
        return true;
    return false;
}

bool is_irrelevant_field_update(const field_t &f_check, const std::set<field_t> &fields) {
    for (const auto &vec : fields) {
        if (contains_field(vec, f_check) || contains_field(f_check, vec)) {
            return false;
        }
    }
    return true;
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
    static std::map<string, bool> visited_fixpoint;

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
            // recursive coi analysis first
            if (std::holds_alternative<string>(e->op)) {
                auto sym = std::get<string>(e->op);
                auto info = proj->symbols[sym];
                if (info.kind == SymbolKind::Def) {
                    auto df = proj->defs[sym].get();
                    if (auto loop = instance_of(df, Fixpoint)) {
                        if (!visited_fixpoint[df->name]) {
                            // find the COI set fixpoint for recursive function
                            visited_fixpoint[df->name] = true;
                            for (auto next = analyze_cone_of_influence(proj, df, coi);
                                next != coi;                                           
                                coi.swap(next), next = analyze_cone_of_influence(proj, df, coi))       
                            {
                                /* terminate when we reach a fixed point */ 
                            }
                            visited_fixpoint[df->name] = false;
                        } else {
                            return;
                        }
                    } else {
                        std::set<field_t> coi_init(coi);
                        coi = analyze_cone_of_influence(proj, df, coi_init);
                    }
                }
            }
            // then propagate based on parameters
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
std::set<field_t> analyze_cone_of_influence(Project *proj, Definition *def, std::variant<SpecNode *, std::set<field_t>> coi_src, std::set<string> whitelist, std::set<string> blacklist) {
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
    if (std::holds_alternative<SpecNode *>(coi_src)) {
        SpecNode *inv = std::get<SpecNode *>(coi_src);
        analyze_invariant_fields(proj, inv, coi_fields);
    } else {
        const auto& fields = std::get<std::set<field_t>>(coi_src);
        coi_fields.insert(fields.begin(), fields.end());
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

    std::set<field_t> coi_ret = {};
    for (auto c : whitelist) {
        coi_ret.insert({c});
    }
    for (auto &c : coi_fields) {
        if (c.empty()) {
            continue;
        }
        if (blacklist.find(c.front()) != blacklist.end()) {
            continue;
        }
        coi_ret.insert(c);
    }
    return coi_ret;
}

rule_ret_t SpecRules::hide_write(std::unique_ptr<SpecNode> spec, std::set<field_t> coi_fields) {
    bool changed = false;
    auto f = [&](std::unique_ptr<SpecNode> node) -> std::unique_ptr<SpecNode> {
        if (auto e = instance_of(node.get(), Expr)) {
            if (auto op = std::get_if<Expr::ops>(&e->op)) {
                if (*op == Expr::ops::RecordSet) {
                    field_t set_field = {};
                    auto f = e->elems->at(e->elems->size() - 2).get();
                    if (auto s = instance_of(f, Symbol)) {
                        set_field.push_back(s->text);
                    }
                    if (is_irrelevant_field_update(set_field, coi_fields)) {
                        changed = true;
                        return e->elems->at(0).get()->deep_copy(); // hide the write, return the value
                    }
                }
            }
        }
        return node; // keep the original node if no change
    };
    auto new_root = rec_apply(std::move(spec), f, false);
    return { std::move(new_root), changed };
}

void coi_reduction(Project *proj, Definition *def, SpecNode *inv) {
    if (!OPTS.coi) 
        return;
    // std::cout << "[COI] Raw (original) spec:\n" << string(*def) << std::endl;
    auto coi_fields = analyze_cone_of_influence(proj, def, inv, autov::coi_whitelist, autov::coi_blacklist);

    auto vars = std::make_shared<unordered_map<string, shared_ptr<SpecValue>>>();
    auto conds = std::make_shared<vector<z3::expr>>();
    for (auto arg : *def->args) {
        (*vars)[arg->name] = arg->type->declare(arg->name, 0);
    }
    auto spec = std::move(def->body);

    while (true) {
        spec->clear_z3_eval();
        bool changed = false;
        
        do {
            auto [__spec, __changed] = proj->rules.hide_write(std::move(spec), coi_fields);
            spec = std::move(__spec);
            changed |= __changed;
        } while (false);

        do {
            auto [__spec, __changed] = proj->rules.rule_simple_by_z3(std::move(spec), make_shared<EvalState>(vars, conds));
            spec = std::move(__spec);
            changed |= __changed;
        } while (false);

        if (!changed) {
            break;
        }
    }

    def->body = std::move(spec);
    def->_str.clear();
    def->body->clear_z3_eval();
    def->infer_type(*proj);
    std::cout << "[COI] spec after COI-reduction:\n" << string(*def) << std::endl;
}

void collect_branch_conds(SpecNode *spec, path_t p, std::set<path_node_t> &init_nodes) {
    if (auto m = instance_of(spec, Match)) {
        if (!m->is_when()) {
            init_nodes.insert({m->src.get(), p});
        }
        for (auto &pm : *m->match_list) {
            collect_branch_conds(pm->body.get(), p, init_nodes);
        }
    } else if (auto i = instance_of(spec, If)) {
        init_nodes.insert({i->cond.get(), p});
        path_t p_then = p, p_else = p;
        p_then.push_back(1);
        p_else.push_back(0);
        collect_branch_conds(i->then_body.get(), p_then, init_nodes);
        collect_branch_conds(i->else_body.get(), p_else, init_nodes);
    } else if (auto r = instance_of(spec, RelyAnno)) {
        collect_branch_conds(r->body.get(), p, init_nodes);
    } else if (auto f = instance_of(spec, ForallExists)) {
        collect_branch_conds(f->body.get(), p, init_nodes);
    }
}

void mark_determ_branch(Project* proj, Definition* rel_def, Definition* spec_def) {
    // FIXME: move it to config file
    static std::set<string> rm_list_pub = { "g_norm", };
    static std::set<string> rm_list = {
        "meta_af", "meta_PA", "meta_sh", "meta_ns",
        "meta_desc_type", "meta_granule_offset", "meta_mem_attr", "meta_ripas",
        "pbase", "poffset", "e_lock", "e_refcount", "e_state",
    };
    // calculate public variables
    std::set<field_t> public_vars = {};
    analyze_invariant_fields(proj, rel_def->body.get(), public_vars);


    std::set<field_t> pv = {};
    for (auto &c : public_vars) {
        if (c.empty() || 
            rm_list_pub.find(c.front()) != rm_list_pub.end()) {
            continue;
        }
        pv.insert(c);
    }
    swap(public_vars, pv);
    LOG_DEBUG << "[mark_determ_branch] Public variables: ";
    for (auto &f : public_vars) {
        print_field(f);
    }

    // find all branch conds as propagation nodes
    std::set<path_node_t> conds = {};
    path_t p = {};
    collect_branch_conds(spec_def->body.get(), p, conds);

    auto args = spec_def->args.get();
    auto spec = spec_def->body.get();
    std::set<string> arg_symbols = {};
    for (int i = 0 ; i < args->size() ; i++) {
        arg_symbols.insert(args->at(i)->name);
    }

    for (auto &cond : conds) { 
        // each initial COI set: all fields used in each branch cond
        std::set<field_t> coi = {};
        std::set<field_t> bv = {};
        rec_analyze_used_fields(proj, cond.first, bv);
        coi.insert(bv.begin(), bv.end());

        std::deque<path_node_t> q = {cond};
        while (!q.empty()) {
            auto [expr, path] = q.front();
            q.pop_front();
            std::map<string, path_node_t> immediate_symbols = {};
            collect_immi_symbols_in(proj, spec, path, 0, immediate_symbols);

            std::set<string> symbols = {};
            backward_propagation_on_expr(proj, expr, coi, {}, symbols);

            for (const auto &s : symbols) {
                if (arg_symbols.find(s) != arg_symbols.end()) {
                    continue;
                } else if (proj->symbols.find(s) != proj->symbols.end() || proj->is_ind_constr(s)) {
                    continue;
                } else if (immediate_symbols.find(s) != immediate_symbols.end()) {
                    q.push_back(immediate_symbols[s]);
                } else {
                    throw std::runtime_error("[mark_determ_branch] Unexpected symbol: " + s);
                }
            }   
        }
        std::set<field_t> coi_ret = {};
        for (auto &c : coi) {
            if (c.empty() || 
                rm_list.find(c.front()) != rm_list.end()) {
                continue;
            }
            coi_ret.insert(c);
        }
        LOG_DEBUG << "Visiting branch: " << string(*cond.first);
        LOG_DEBUG << "Branch's COI set: ";
        for (auto &f : coi_ret) {
            print_field(f);
        }

        // examine all COI set elements of this branch are public variables
        for (auto &f : coi_ret) {
            bool f_is_pub = false;
            for (auto &pv : public_vars) {
                if (contains_field(f, pv)) {
                    f_is_pub = true;
                }
            }
            if (!f_is_pub) {
                cond.first->is_determ_branch = false;
                // LOG_WARNING << "[mark_determ_branch] Mark non-determ branch:\n" << string(*cond.first);
                // LOG_WARNING << "[mark_determ_branch] COI field not contained in public vars: ";
                // print_field(f);
            }
        }
    }
}

}