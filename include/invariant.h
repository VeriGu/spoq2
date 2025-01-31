#pragma once

#include <values.h>
#include <nodes.h>
#include <utils.h>
#include <log.h>
#include <unordered_set>
#include <llvm.h>
#include <mutex>


namespace autov {

void rec_analyze_leaf_fields(Project* proj, SpecNode* node, std::set<string> &fields, bool inside_RGet) {
    if (auto wa = instance_of(node, ForallExists)) {
        for (auto const &var: *wa->vars) {
            if (var->expr != nullptr) {
                rec_analyze_leaf_fields(proj, var->expr.get(), fields, inside_RGet);
            }
        }
        rec_analyze_leaf_fields(proj, wa->body.get(), fields, inside_RGet);
    } else if (auto r = instance_of(node, RelyAnno)) {
        rec_analyze_leaf_fields(proj, r->prop.get(), fields, inside_RGet);
        rec_analyze_leaf_fields(proj, r->body.get(), fields, inside_RGet);
    } else if (auto e = instance_of(node, Expr)) {
        if (holds_alternative<Expr::binops>(e->op)) {				
            rec_analyze_leaf_fields(proj, e->elems->at(0).get(), fields, inside_RGet);
            rec_analyze_leaf_fields(proj, e->elems->at(1).get(), fields, inside_RGet);
        } else if (holds_alternative<Expr::ops>(e->op)) {
            // check GET and RecordGet
            if (std::get<Expr::ops>(e->op) == Expr::GET) {
                // (x)@(y) :: In any case, F(y) should be evaluated independently
                rec_analyze_leaf_fields(proj, e->elems->at(0).get(), fields, inside_RGet);
                rec_analyze_leaf_fields(proj, e->elems->at(1).get(), fields, false);
            } else if (std::get<Expr::ops>(e->op) == Expr::RecordGet) {
                // (x).(y) :: 
                if (inside_RGet) {
                    // ((x).(y) ... ).(z) :: F(node) = F(x), y should not be involved as F(node) since we will infer (z) soon.
                    rec_analyze_leaf_fields(proj, e->elems->at(0).get(), fields, inside_RGet);
                } else {
                    // We still need to check (x) since it might be x := (m @ n), in which (n) is interesting
                    rec_analyze_leaf_fields(proj, e->elems->at(0).get(), fields, true);
                    rec_analyze_leaf_fields(proj, e->elems->at(1).get(), fields, false);
                }
            } else {
                for (int i = 0; i < e->elems->size(); i++) {
                    rec_analyze_leaf_fields(proj, e->elems->at(i).get(), fields, inside_RGet);
                }
            }
        } else if (holds_alternative<string>(e->op)) {
            for (int i = 0; i < e->elems->size(); i++) {
                rec_analyze_leaf_fields(proj, e->elems->at(i).get(), fields, inside_RGet);
            }
        } else if (holds_alternative<unique_ptr<SpecNode>>(e->op)) {
            // pass
        }
    } else if (auto s = instance_of(node, Symbol)) {
        if (proj->symbols.find(s->text) != proj->symbols.end() &&
                                proj->symbols[s->text].kind == SymbolKind::StructElem) {
            fields.insert(s->text);
        }
    } else {
        throw std::runtime_error("rec_analyze_leaf_fields: Unexpected node type: " + string(*node));
    }
}

void rec_analyze(SpecNode *spec, std::set<string> &fields) {
    if (is_instance(spec, Symbol)) {
        return ;
    } else if (is_instance(spec, Const)) {
        return ;
    } else if (auto e = instance_of(spec, Expr)) {
        if (auto op = std::get_if<Expr::ops>(&e->op)) {
            if (*op == Expr::RecordSet) {
                // elems[0]: record
                // elems[1...n-1]: fields
                // elems[n]: value
                for (int i = 1; i < e->elems->size() - 1; i++) {
                    auto f = e->elems->at(i).get();
                    assert(is_instance(f, Symbol));
                    //std::cout << "Field: " << static_cast<Symbol*>(f)->text << std::endl;
                    fields.insert(static_cast<Symbol*>(f)->text);
                }
            } else if (*op == Expr::RecordGet) {
                // elems[0]: record
                // elems[1]: field
                auto f = e->elems->at(1).get();
                assert(is_instance(f, Symbol));
                //std::cout << "Field: " << static_cast<Symbol*>(f)->text << std::endl;
                fields.insert(static_cast<Symbol*>(f)->text);
            }
        } else if (auto op = std::get_if<unique_ptr<SpecNode>>(&e->op)) {
            rec_analyze(op->get(), fields);
        }

        for (auto &elem : *e->elems) {
            rec_analyze(elem.get(), fields);
        }
    } else if (auto m = instance_of(spec, Match)) {
        rec_analyze(m->src.get(), fields);

        for (auto &pm : *m->match_list) {
            rec_analyze(pm->pattern.get(), fields);
            rec_analyze(pm->body.get(), fields);
        }
    } else if (auto i = instance_of(spec, If)) {
        rec_analyze(i->cond.get(), fields);
        rec_analyze(i->then_body.get(), fields);
        rec_analyze(i->else_body.get(), fields);
    } else if (auto r = instance_of(spec, RelyAnno)) {
        rec_analyze(r->prop.get(), fields);
        rec_analyze(r->body.get(), fields);
    } else if (auto f = instance_of(spec, ForallExists)) {
        for (auto const &var: *f->vars) {
            if (var->expr != nullptr) {
                rec_analyze(var->expr.get(), fields);
            }
        }
        rec_analyze(f->body.get(), fields);
    }
}

void analyze_fields_access(Project *proj) {
    for (auto const &def: proj->defs) {
        if (!is_invariant_defs(proj, def.first)) {
            continue;
        }

        //std::cout << "Analyzing " << def.first << std::endl;
        std::set<string> fields;
        std::cout << "Fields accessed in " << def.first << ": ";
        rec_analyze_leaf_fields(proj, def.second->body.get(), fields, false);
        // rec_analyze(def.second->body.get(), fields);

        for (auto const &f: fields) {
            std::cout << f << ", ";
        }
        std::cout << std::endl;
    }
}
}