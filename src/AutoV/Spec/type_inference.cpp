#include <nodes.h>
#include <log.h>
#include <values.h>
#include <utils.h>
#include <project.h>
#include <algorithm>

namespace autov::type_inference {
using std::string;
using std::vector;
using std::tuple;
using std::unique_ptr;
using std::make_unique;
using std::shared_ptr;
using std::make_shared;
using std::unordered_map;

static void infer_pattern(Project &proj, SpecNode *pattern, shared_ptr<unordered_map<string, shared_ptr<SpecType>>> known_types) {
    if (dynamic_cast<Symbol *>(pattern)) {
        auto sym = dynamic_cast<Symbol *>(pattern);

        if (!proj.is_known_symbol(sym->text) && pattern->type != SpecType::UNKNOWN_TYPE) {
            (*known_types)[sym->text] = pattern->type;
        }
    } else if (dynamic_cast<Expr *>(pattern)) {
        auto expr = dynamic_cast<Expr *>(pattern);

        if (holds_alternative<unique_ptr<SpecNode>>(expr->op)) {
            auto op = std::get<unique_ptr<SpecNode>>(expr->op).get();

            infer_pattern(proj, op, known_types);
        }

        for (const auto &elem : *expr->elems) {
            infer_pattern(proj, elem.get(), known_types);
        }
    } else if (dynamic_cast<Const *>(pattern)) {
        // Pass
    } else {
        throw std::runtime_error("unknown pattern type");
    }
}

void infer_type(Project &proj, SpecNode *spec, shared_ptr<unordered_map<string, shared_ptr<SpecType>>> known_types,
                shared_ptr<SpecType>final_type = nullptr) {
    vector<tuple<int, SpecNode *, int, shared_ptr<unordered_map<string, shared_ptr<SpecType>>>>> stack;

    if (final_type) {
        spec->type = final_type;
    }

    stack.push_back(std::make_tuple(0, spec, 0, known_types));

    while (stack.size()) {
        auto &top = stack.back();
        auto ln = std::get<0>(top);
        auto spec = std::get<1>(top);
        auto n = std::get<2>(top);
        auto known_types = std::get<3>(top);

        stack.pop_back();

        if (dynamic_cast<Symbol *>(spec)) {
            auto sym = dynamic_cast<Symbol *>(spec);

            if (known_types->find(sym->text) != known_types->end()) {
                sym->type = (*known_types)[sym->text];
            } else if (proj.is_ind_constr(sym->text)) {
                auto typ = proj.get_indtype_by_constr(sym->text);

                if (typ) {
                    sym->type = typ;
                }
            } else if (proj.symbols.find(sym->text) != proj.symbols.end()) {
                auto info = proj.symbols[sym->text];

                if (info.kind == SymbolKind::Def) {
                    sym->type = proj.defs.at(sym->text)->get_type();
                } else if (info.kind == SymbolKind::Decl) {
                    sym->type = proj.decls.at(sym->text)->get_type();
                }
            }

        } else if (dynamic_cast<Const *>(spec)) {
            // Const, pass
        } else if (dynamic_cast<Expr *>(spec)) {
            auto expr = dynamic_cast<Expr *>(spec);

            if (holds_alternative<Expr::binops>(expr->op)) {
                auto op = std::get<Expr::binops>(expr->op);

                switch (op) {
                case Expr::ADD: case Expr::MINUS: case Expr::MULT: case Expr::DIV: case Expr::MOD:
                case Expr::LSHIFT: case Expr::RSHIFT: case Expr::BITAND: case Expr::BITOR: {
                    // TODO:: Z.lnot, Z.lxor
                    if (n < expr->elems->size()) {
                        expr->elems->at(n)->type = Int::INT;
                        stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                        stack.push_back(std::make_tuple(__LINE__, expr->elems->at(n).get(), 0, known_types));
                    } else {
                        expr->type = Int::INT;
                    }
                    break;
                }
                case Expr::BEQ: case Expr::BNE: case Expr::BGT:
                case Expr::BGE: case Expr::BLT: case Expr::BLE: {
                    // TODO: Z.testbit
                    if (n < expr->elems->size()) {
                        expr->elems->at(n)->type = Int::INT;
                        stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                        stack.push_back(std::make_tuple(__LINE__, expr->elems->at(n).get(), 0, known_types));
                    } else {
                        expr->type = Bool::BOOL;
                    }
                    break;
                }
                case Expr::SEQ: case Expr::SNE: {
                    if (n < expr->elems->size()) {
                        expr->elems->at(n)->type = String::STRING;
                        stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                        stack.push_back(std::make_tuple(__LINE__, expr->elems->at(n).get(), 0, known_types));
                    } else {
                        expr->type = Bool::BOOL;
                    }
                    break;
                }
                case Expr::BAND: case Expr::BOR: {
                    // TODO: xorb
                    if (n < expr->elems->size()) {
                        expr->elems->at(n)->type = Bool::BOOL;
                        stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                        stack.push_back(std::make_tuple(__LINE__, expr->elems->at(n).get(), 0, known_types));
                    } else {
                        expr->type = Bool::BOOL;
                    }
                    break;
                }
                case Expr::LT: case Expr::LTE: case Expr::GT: case Expr::GTE: {
                    if (n < expr->elems->size()) {
                        expr->elems->at(n)->type = Int::INT;
                        stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                        stack.push_back(std::make_tuple(__LINE__, expr->elems->at(n).get(), 0, known_types));
                    } else {
                        expr->type = Prop::PROP;
                    }
                    break;
                }
                case Expr::EQUAL: case Expr::NOT_EQUAL: {
                    if (n < expr->elems->size()) {
                        stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                        stack.push_back(std::make_tuple(__LINE__, expr->elems->at(n).get(), 0, known_types));
                    } else if (n == 2) {
                        stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));

                        if (expr->elems->at(0)->type != SpecType::UNKNOWN_TYPE && expr->elems->at(1)->type == SpecType::UNKNOWN_TYPE) {
                            expr->elems->at(1)->type = expr->elems->at(0)->type;
                            stack.push_back(std::make_tuple(__LINE__, expr->elems->at(1).get(), 0, known_types));
                        }
                    } else if (n == 3) {
                        stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));

                        if (expr->elems->at(0)->type != SpecType::UNKNOWN_TYPE && expr->elems->at(1)->type == SpecType::UNKNOWN_TYPE) {
                            expr->elems->at(1)->type = expr->elems->at(0)->type;
                            stack.push_back(std::make_tuple(__LINE__, expr->elems->at(1).get(), 0, known_types));
                        }
                    } else {
                        expr->type = Prop::PROP;
                    }
                    break;
                }
                case Expr::IFONLYIF: case Expr::OR: case Expr::AND: case Expr::IMPLIES: {
                    if (n < expr->elems->size()) {
                        expr->elems->at(n)->type = Prop::PROP;
                        stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                        stack.push_back(std::make_tuple(__LINE__, expr->elems->at(n).get(), 0, known_types));
                    } else {
                        expr->type = Prop::PROP;
                    }
                    break;
                }
                case Expr::APPEND: {
                    if (n == 0) {
                        auto list_type = dynamic_pointer_cast<List>(expr->type);

                        if (list_type)
                            expr->elems->at(n)->type = list_type->elem_type;
                        stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                        stack.push_back(std::make_tuple(__LINE__, expr->elems->at(0).get(), 0, known_types));
                    } else if (n == 1) {
                        auto list_type = dynamic_pointer_cast<List>(expr->type);

                        if (list_type)
                            expr->elems->at(n)->type = list_type;
                        stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                        stack.push_back(std::make_tuple(__LINE__, expr->elems->at(1).get(), 0, known_types));
                    } else if (n == 2) {
                        auto elems0_type = expr->elems->at(0)->type;
                        auto elems1_type = expr->elems->at(1)->type;

                        stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                        if (elems0_type != SpecType::UNKNOWN_TYPE && elems1_type == SpecType::UNKNOWN_TYPE) {
                            expr->elems->at(1)->type = make_shared<List>(elems0_type);
                            stack.push_back(std::make_tuple(__LINE__, expr->elems->at(1).get(), 0, known_types));
                        }
                    } else if (n == 3) {
                        auto elems0_type = expr->elems->at(0)->type;
                        auto elems1_type = expr->elems->at(1)->type;

                        stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                        if (elems1_type != SpecType::UNKNOWN_TYPE && elems0_type == SpecType::UNKNOWN_TYPE) {
                            auto list_type = dynamic_pointer_cast<List>(elems1_type);

                            expr->elems->at(0)->type = list_type->elem_type;
                            stack.push_back(std::make_tuple(__LINE__, expr->elems->at(0).get(), 0, known_types));
                        }
                    } else {
                        expr->type = expr->elems->at(1)->type;
                    }

                    break;
                }
                case Expr::CONCAT: {
                    if (n == 0) {
                        auto list_type = dynamic_pointer_cast<List>(expr->type);

                        if (list_type)
                            expr->elems->at(0)->type = list_type->elem_type;
                        stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                        stack.push_back(std::make_tuple(__LINE__, expr->elems->at(0).get(), 0, known_types));
                    } else if (n == 1) {
                        auto list_type = dynamic_pointer_cast<List>(expr->type);

                        if (list_type)
                            expr->elems->at(1)->type = list_type->elem_type;
                        stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                        stack.push_back(std::make_tuple(__LINE__, expr->elems->at(1).get(), 0, known_types));
                    } else if (n == 2) {
                        auto elems0_type = expr->elems->at(0)->type;
                        auto elems1_type = expr->elems->at(1)->type;

                        stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                        if (elems0_type != SpecType::UNKNOWN_TYPE && elems1_type == SpecType::UNKNOWN_TYPE) {
                            expr->elems->at(1)->type = elems0_type;
                            stack.push_back(std::make_tuple(__LINE__, expr->elems->at(1).get(), 0, known_types));
                        }
                    } else if (n == 3) {
                        auto elems0_type = expr->elems->at(0)->type;
                        auto elems1_type = expr->elems->at(1)->type;

                        stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                        if (elems1_type != SpecType::UNKNOWN_TYPE && elems0_type == SpecType::UNKNOWN_TYPE) {
                            expr->elems->at(0)->type = elems1_type;
                            stack.push_back(std::make_tuple(__LINE__, expr->elems->at(0).get(), 0, known_types));
                        }
                    } else {
                        expr->type = expr->elems->at(0)->type;
                    }

                    break;
                }
                }
            } else if (holds_alternative<Expr::ops>(expr->op)) {
                auto op = std::get<Expr::ops>(expr->op);

                switch(op) {
                case Expr::Tuple: {
                    if (n < expr->elems->size()) {
                        if (dynamic_cast<Tuple *>(expr->type.get()))
                            expr->elems->at(n)->type = dynamic_pointer_cast<Tuple>(expr->type)->elems->at(n)->type;

                        stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                        stack.push_back(std::make_tuple(__LINE__, expr->elems->at(n).get(), 0, known_types));
                    } else {
                        auto tuple_type = make_shared<vector<shared_ptr<SpecType>>>();

                        for (const auto &elem : *expr->elems) {
                            tuple_type->push_back(elem->type);
                        }

                        expr->type = make_shared<Tuple>(tuple_type);
                    }
                    break;
                }
                case Expr::GET: {
                    if (n == 0) {
                        expr->elems->at(1)->type = Int::INT;
                        stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                        stack.push_back(std::make_tuple(__LINE__, expr->elems->at(1).get(), 0, known_types));
                    } else if (n == 1) {
                        if (expr->type != SpecType::UNKNOWN_TYPE) {
                            expr->elems->at(0)->type = make_shared<ZMap>(expr->type);
                        }
                        stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                        stack.push_back(std::make_tuple(__LINE__, expr->elems->at(0).get(), 0, known_types));
                    } else {
                        auto elem_type = dynamic_pointer_cast<ZMap>(expr->elems->at(0)->type);

                        expr->type = elem_type->elem_type;
                    }
                    break;
                }
                case Expr::SET: {
                    if (n == 0) {
                        expr->elems->at(1)->type = Int::INT;
                        stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                        stack.push_back(std::make_tuple(__LINE__, expr->elems->at(1).get(), 0, known_types));
                    } else if (n == 1) {
                        auto zmap_type = dynamic_pointer_cast<ZMap>(expr->type);

                        if (zmap_type) {
                            expr->elems->at(0)->type = expr->type;
                        }
                        stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                        stack.push_back(std::make_tuple(__LINE__, expr->elems->at(0).get(), 0, known_types));
                    } else if (n == 2) {
                        auto zmap_type = dynamic_pointer_cast<ZMap>(expr->elems->at(0)->type);

                        if (zmap_type) {
                            expr->elems->at(2)->type = zmap_type->elem_type;
                        }
                        stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                        stack.push_back(std::make_tuple(__LINE__, expr->elems->at(2).get(), 0, known_types));
                    } else if (n == 3) {
                        auto elems0_type = expr->elems->at(0)->type;
                        auto elems2_type = expr->elems->at(2)->type;

                        stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                        if (elems0_type != SpecType::UNKNOWN_TYPE && elems2_type == SpecType::UNKNOWN_TYPE) {
                            expr->elems->at(2)->type = dynamic_pointer_cast<ZMap>(elems0_type)->elem_type;
                            stack.push_back(std::make_tuple(__LINE__, expr->elems->at(2).get(), 0, known_types));
                        }
                    } else if (n == 4) {
                        auto elems0_type = expr->elems->at(0)->type;
                        auto elems2_type = expr->elems->at(2)->type;

                        stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                        if (elems2_type != SpecType::UNKNOWN_TYPE && elems0_type == SpecType::UNKNOWN_TYPE) {
                            expr->elems->at(0)->type = make_shared<ZMap>(elems2_type);
                            stack.push_back(std::make_tuple(__LINE__, expr->elems->at(0).get(), 0, known_types));
                        }
                    } else {
                        expr->type = expr->elems->at(0)->type;
                    }
                    break;
                }
                case Expr::RecordGet: {
                    auto field = dynamic_cast<Symbol *>(expr->elems->at(1).get())->text;
                    auto &info = proj.symbols.at(field);
                    auto rec = proj.structs.at(info.info);

                    assert(info.kind == SymbolKind::StructElem);

                    if (n == 0) {
                        expr->elems->at(0)->type = rec;
                        stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                        stack.push_back(std::make_tuple(__LINE__, expr->elems->at(0).get(), 0, known_types));
                    } else if (n == 1) {
                        expr->type = rec->elems_map.at(field);
                    }

                    break;
                }
                case Expr::RecordSet: {
                    auto field = dynamic_cast<Symbol *>(expr->elems->at(1).get())->text;
                    auto &info = proj.symbols.at(field);
                    auto rec = proj.structs.at(info.info);

                    assert(info.kind == SymbolKind::StructElem);

                    if (n == 0) {
                        expr->elems->at(0)->type = rec;
                        stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                        stack.push_back(std::make_tuple(__LINE__, expr->elems->at(0).get(), 0, known_types));
                    } else if (n == 1) {
                        shared_ptr<SpecType> T = static_pointer_cast<SpecType>(rec);

                        for (auto it = expr->elems->begin() + 1; it != expr->elems->end() - 1; it++) {
                            auto field = dynamic_cast<Symbol *>((*it).get())->text;

                            T = dynamic_pointer_cast<Struct>(T)->elems_map.at(field);
                        }

                        expr->elems->back()->type = T;
                        stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                        stack.push_back(std::make_tuple(__LINE__, expr->elems->back().get(), 0, known_types));
                    } else {
                        expr->type = rec;
                    }

                    break;
                }
                case Expr::Some: {
                    if (n == 0) {
                        auto option_type = dynamic_pointer_cast<Option>(expr->type);

                        if (option_type)
                            expr->elems->at(0)->type = option_type->elem_type;
                        stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                        stack.push_back(std::make_tuple(__LINE__, expr->elems->at(0).get(), 0, known_types));
                    } else {
                        expr->type = make_shared<Option>(expr->elems->at(0)->type);
                    }

                    break;
                }
                case Expr::None: {
                    // Pass
                    break;
                }
                case Expr::NOT: {
                    if (n == 0) {
                        expr->elems->at(0)->type = Prop::PROP;
                        stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                        stack.push_back(std::make_tuple(__LINE__, expr->elems->at(0).get(), 0, known_types));
                    } else {
                        expr->type = Prop::PROP;
                    }
                    break;
                }
                case Expr::BNOT: {
                    if (n == 0) {
                        expr->elems->at(0)->type = Bool::BOOL;
                        stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                        stack.push_back(std::make_tuple(__LINE__, expr->elems->at(0).get(), 0, known_types));
                    } else {
                        expr->type = Bool::BOOL;
                    }

                    break;
                }
                default: {
                    throw std::runtime_error("unknown expr op");
                }
                }

            } else if (holds_alternative<string>(expr->op)) {
                auto op = std::get<string>(expr->op);

                if (op == Project::LAYER_PTR2INT || op == "ptr_to_int") {
                    if (n == 0) {
                        expr->elems->at(0)->type = Struct::Ptr;
                        stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                        stack.push_back(std::make_tuple(__LINE__, expr->elems->at(0).get(), 0, known_types));
                    } else {
                        expr->type = Int::INT;
                    }
                } else if (op == Project::LAYER_INT2PTR || op == "int_to_ptr") {
                    if (n == 0) {
                        expr->elems->at(0)->type = Int::INT;
                        stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                        stack.push_back(std::make_tuple(__LINE__, expr->elems->at(0).get(), 0, known_types));
                    } else {
                        expr->type = Struct::Ptr;
                    }
                } else if (op == "z_to_nat") {
                    if (n == 0) {
                        expr->elems->at(0)->type = Int::INT;
                        stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                        stack.push_back(std::make_tuple(__LINE__, expr->elems->at(0).get(), 0, known_types));
                    } else {
                        expr->type = Inductive::Nat;
                    }
                } else if (op == "Z.lnot" || op == "Z.lxor" || op == "Z.setbit" || op == "Z.clearbit") {
                    if (n < expr->elems->size()) {
                        expr->elems->at(n)->type = Int::INT;
                        stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                        stack.push_back(std::make_tuple(__LINE__, expr->elems->at(n).get(), 0, known_types));
                    } else {
                        expr->type = Int::INT;
                    }
                } else if (op == "Z.testbit") {
                    if (n < expr->elems->size()) {
                        expr->elems->at(n)->type = Int::INT;
                        stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                        stack.push_back(std::make_tuple(__LINE__, expr->elems->at(n).get(), 0, known_types));
                    } else {
                        expr->type = Bool::BOOL;
                    }
                } else if (op == "xorb") {
                    if (n < expr->elems->size()) {
                        expr->elems->at(n)->type = Bool::BOOL;
                        stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                        stack.push_back(std::make_tuple(__LINE__, expr->elems->at(n).get(), 0, known_types));
                    } else {
                        expr->type = Bool::BOOL;
                    }
                } else if (op == "ZMap.get") {
                    if (n == 0) {
                        expr->elems->at(1)->type = Int::INT;
                        stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                        stack.push_back(std::make_tuple(__LINE__, expr->elems->at(1).get(), 0, known_types));
                    } else if (n == 1) {
                        if (expr->type != SpecType::UNKNOWN_TYPE) {
                            expr->elems->at(0)->type = make_shared<ZMap>(expr->type);
                        }
                        stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                        stack.push_back(std::make_tuple(__LINE__, expr->elems->at(0).get(), 0, known_types));
                    } else {
                        auto elem_type = dynamic_pointer_cast<ZMap>(expr->elems->at(0)->type);

                        expr->type = elem_type->elem_type;
                    }
                } else if (op == "ZMap.set") {
                    if (n == 0) {
                        expr->elems->at(1)->type = Int::INT;
                        stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                        stack.push_back(std::make_tuple(__LINE__, expr->elems->at(1).get(), 0, known_types));
                    } else if (n == 1) {
                        auto zmap_type = dynamic_pointer_cast<ZMap>(expr->type);

                        if (zmap_type) {
                            expr->elems->at(0)->type = expr->type;
                        }
                        stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                        stack.push_back(std::make_tuple(__LINE__, expr->elems->at(0).get(), 0, known_types));
                    } else if (n == 2) {
                        auto zmap_type = dynamic_pointer_cast<ZMap>(expr->elems->at(0)->type);

                        if (zmap_type) {
                            expr->elems->at(2)->type = zmap_type->elem_type;
                        }
                        stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                        stack.push_back(std::make_tuple(__LINE__, expr->elems->at(2).get(), 0, known_types));
                    } else if (n == 3) {
                        auto elems0_type = expr->elems->at(0)->type;
                        auto elems2_type = expr->elems->at(2)->type;

                        stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                        if (elems0_type != SpecType::UNKNOWN_TYPE && elems2_type == SpecType::UNKNOWN_TYPE) {
                            expr->elems->at(2)->type = dynamic_pointer_cast<ZMap>(elems0_type)->elem_type;
                            stack.push_back(std::make_tuple(__LINE__, expr->elems->at(2).get(), 0, known_types));
                        }
                    } else if (n == 4) {
                        auto elems0_type = expr->elems->at(0)->type;
                        auto elems2_type = expr->elems->at(2)->type;

                        stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                        if (elems2_type != SpecType::UNKNOWN_TYPE && elems0_type == SpecType::UNKNOWN_TYPE) {
                            expr->elems->at(0)->type = make_shared<ZMap>(elems2_type);
                            stack.push_back(std::make_tuple(__LINE__, expr->elems->at(0).get(), 0, known_types));
                        }
                    } else {
                        expr->type = expr->elems->at(0)->type;
                    }
                } else if (proj.symbols.find(op) != proj.symbols.end() || op.compare(0, 5, "llvm.") == 0) {
                    if (op.compare(0, 5, "llvm.") == 0) {
                        std::replace(op.begin(), op.end(), '.', '_');
                        expr->op = op;
                    }

                    if (n == 0) {
                        auto info = proj.symbols.at(op);
                        shared_ptr<SpecType> typ;

                        if (info.kind == SymbolKind::Def) {
                            typ = proj.defs.at(op)->get_type();
                        } else if (info.kind == SymbolKind::Decl) {
                            typ = proj.decls.at(op)->get_type();
                        } else if (info.kind == SymbolKind::StructConstr) {
                            auto st = proj.structs.at(info.info);
                            auto args = make_shared<vector<shared_ptr<SpecType>>>();

                            for (auto it = st->elems->begin(); it != st->elems->end(); it++) {
                                args->push_back((*it)->type);
                            }

                            typ = make_shared<Function>(st, args);
                        }  else if (info.kind == SymbolKind::IndConstructor) {
                            auto ind = proj.indtypes.at(info.info);
                            auto ind_args = ind->constr.at(op);
                            auto args = make_shared<vector<shared_ptr<SpecType>>>();

                            for (auto it = ind_args->begin(); it != ind_args->end(); it++) {
                                args->push_back((*it)->type);
                            }

                            typ = make_shared<Function>(ind, args);
                        } else {
                            throw std::runtime_error("Unknown symbol kind");
                        }

                        assert(dynamic_pointer_cast<Function>(typ));
                        spec->tmp = typ;
                    }

                    if (n < expr->elems->size()) {
                        auto typ = dynamic_pointer_cast<Function>(spec->tmp);

                        expr->elems->at(n)->type = typ->args->at(n);
                        stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                        stack.push_back(std::make_tuple(__LINE__, expr->elems->at(n).get(), 0, known_types));
                    } else {
                        auto typ = dynamic_pointer_cast<Function>(spec->tmp);

                        expr->type = typ->rettype;
                        spec->tmp.reset();
                    }
                } else {
                    // TODO: better error message
                    throw std::runtime_error("unknown expr op " + op);
                }
            } else if (holds_alternative<unique_ptr<SpecNode>>(expr->op)) {
                auto op = std::get<unique_ptr<SpecNode>>(expr->op).get();

                if (n == 0) {
                    stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                    stack.push_back(std::make_tuple(__LINE__, op, 0, known_types));
                } else {
                    int n_elem = n - 1;
                    auto typ = op->type;
                    auto typ_func = dynamic_pointer_cast<Function>(typ);

                    assert(typ_func != nullptr);

                    if (n_elem < expr->elems->size()) {
                        expr->elems->at(n_elem)->type = typ_func->args->at(n_elem);
                        stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                        stack.push_back(std::make_tuple(__LINE__, expr->elems->at(n_elem).get(), 0, known_types));
                    } else {
                        expr->type = typ_func->rettype;
                    }
                }
            }
        } else if (dynamic_cast<Match *>(spec)) {
            auto match = dynamic_cast<Match *>(spec);

            if (n == 0) {
                stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                stack.push_back(std::make_tuple(__LINE__, match->src.get(), 0, known_types));
            } else if ((n - 1) / 3 < match->match_list->size()) {
                int n_pm = (n - 1) / 3;
                int n_step = (n - 1) % 3;
                auto pm = match->match_list->at(n_pm).get();

                if (n_step == 0) {
                    pm->pattern->type = match->src->type;

                    stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                    stack.push_back(std::make_tuple(__LINE__, pm->pattern.get(), 0, known_types));
                } else if (n_step == 1) {
                    shared_ptr<unordered_map<string, shared_ptr<SpecType>>> known(new unordered_map<string, shared_ptr<SpecType>>(*known_types));

                    infer_pattern(proj, pm->pattern.get(), known);
                    if (spec->type != nullptr)
                        pm->body->type = spec->type;

                    stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                    stack.push_back(std::make_tuple(__LINE__, pm->body.get(), 0, known));
                } else {
                    spec->type = pm->body->type;

                    if (n_pm < match->match_list->size() - 1) {
                        stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                    }
                }
            }
        } else if (dynamic_cast<RelyAnno *>(spec)) {
            auto rely_anno = dynamic_cast<RelyAnno *>(spec);

            if (n == 0) {
                rely_anno->prop->type = Prop::PROP;

                stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                stack.push_back(std::make_tuple(__LINE__, rely_anno->prop.get(), 0, known_types));
            } else if (n == 1) {
                if (rely_anno->type != SpecType::UNKNOWN_TYPE) {
                    rely_anno->body->type = rely_anno->type;
                }

                stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                stack.push_back(std::make_tuple(__LINE__, rely_anno->body.get(), 0, known_types));
            } else {
                spec->type = rely_anno->body->type;
            }
        } else if (dynamic_cast<If *>(spec)) {
            auto if_ = dynamic_cast<If *>(spec);

            if (n == 0) {
                if_->cond->type = Bool::BOOL;

                stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                stack.push_back(std::make_tuple(__LINE__, if_->cond.get(), 0, known_types));
            } else if (n == 1) {
                if (if_->type != SpecType::UNKNOWN_TYPE) {
                    if_->then_body->type = if_->type;
                }

                stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                stack.push_back(std::make_tuple(__LINE__, if_->then_body.get(), 0, known_types));
            } else if (n == 2) {
                if (if_->then_body->type != SpecType::UNKNOWN_TYPE)
                    spec->type = if_->then_body->type;
                if (if_->type != SpecType::UNKNOWN_TYPE)
                    if_->else_body->type = if_->type;

                stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known_types));
                stack.push_back(std::make_tuple(__LINE__, if_->else_body.get(), 0, known_types));
            } else {
                assert(if_->else_body->type != SpecType::UNKNOWN_TYPE);
                assert(if_->then_body->type == if_->else_body->type || *if_->then_body->type == *if_->else_body->type);
                spec->type = if_->else_body->type;
            }
        } else if (dynamic_cast<ForallExists *>(spec)) {
            auto fe = dynamic_cast<ForallExists *>(spec);

            if (n == 0) {
                shared_ptr<unordered_map<string, shared_ptr<SpecType>>> known(new unordered_map<string, shared_ptr<SpecType>>(*known_types));

                for (const auto &var: *fe->vars) {
                    (*known)[var->name] = var->type;
                }

                fe->body->type = Prop::PROP;

                stack.push_back(std::make_tuple(__LINE__, spec, n + 1, known));
                stack.push_back(std::make_tuple(__LINE__, fe->body.get(), 0, known));
            } else {
                spec->type = Prop::PROP;
            }
        } else if (dynamic_cast<RecordDef *>(spec)) {
            //pass
        } else {
            throw std::runtime_error("unknown spec node: " + string(*spec));
        }
    }
}

bool check_well_typed(Project &proj, SpecNode *spec, std::set<string> &vars) {
    if (dynamic_cast<Symbol *>(spec)) {
        auto sym = dynamic_cast<Symbol *>(spec);
        bool well_typed;

        if (proj.is_known_symbol(sym->text))
            return true;

        well_typed = vars.find(sym->text) != vars.end();

        if (!well_typed) {
            LOG_ERROR << "Unknown symbol: " << sym->text;
            LOG_ERROR << "Symbol type: " << string(*sym->type);
        }

        assert(well_typed);
        return well_typed;
    } else if (spec->type == SpecType::UNKNOWN_TYPE) {
        LOG_ERROR << "Unknown type: " << string(*spec) << "\n";
        assert(false);
        return false;
    } else if (dynamic_cast<Expr *>(spec)) {
        auto expr = dynamic_cast<Expr *>(spec);
        bool well_typed;

        for (const auto &elem : *expr->elems) {
            well_typed = check_well_typed(proj, elem.get(), vars);
            if (!well_typed) {
                assert(false);
                return false;
            }
        }

        if (holds_alternative<unique_ptr<SpecNode>>(expr->op)) {
            auto expr_op = std::get<unique_ptr<SpecNode>>(expr->op).get();
            bool well_typed = check_well_typed(proj, expr_op, vars);

            assert(well_typed);
            return well_typed;
        }

        return true;
    } else if (dynamic_cast<Match *>(spec)) {
        auto match = dynamic_cast<Match *>(spec);
        bool well_typed;

        well_typed = check_well_typed(proj, match->src.get(), vars);
        if (!well_typed) {
            assert(false);
            return false;
        }

        for (const auto &pm : *match->match_list) {
            auto _vars = vars; // Copy the set of variables

            std::function<void(SpecNode *)> collect_symbols = [&](SpecNode *pattern) {
                if (auto symbol = dynamic_cast<Symbol *>(pattern)) {
                    _vars.insert(symbol->text);
                } else if (auto expr = dynamic_cast<Expr *>(pattern)) {
                    for (const auto &elem : *expr->elems) {
                        collect_symbols(elem.get());
                    }
                }
            };

            collect_symbols(pm->pattern.get());

            well_typed = check_well_typed(proj, pm->pattern.get(), _vars);
            if (!well_typed) {
                assert(false);
                return false;
            }

            well_typed = check_well_typed(proj, pm->body.get(), _vars);
            if (!well_typed) {
                assert(false);
                return false;
            }
        }
    } else if (dynamic_cast<RelyAnno *>(spec)) {
        auto rely_anno = dynamic_cast<RelyAnno *>(spec);
        bool well_typed;

        well_typed = check_well_typed(proj, rely_anno->prop.get(), vars);
        if (!well_typed) {
            assert(false);
            return false;
        }

        well_typed = check_well_typed(proj, rely_anno->body.get(), vars);
        if (!well_typed) {
            assert(false);
            return false;
        }
    } else if (dynamic_cast<If *>(spec)) {
        auto if_ = dynamic_cast<If *>(spec);
        bool well_typed;

        well_typed = check_well_typed(proj, if_->cond.get(), vars);
        if (!well_typed) {
            assert(false);
            return false;
        }

        well_typed = check_well_typed(proj, if_->then_body.get(), vars);
        if (!well_typed) {
            assert(false);
            return false;
        }

        well_typed = check_well_typed(proj, if_->else_body.get(), vars);
        if (!well_typed) {
            assert(false);
            return false;
        }
    } else if (dynamic_cast<ForallExists *>(spec)) {
        auto fe = dynamic_cast<ForallExists *>(spec);
        bool well_typed;
        auto _vars = vars; // Copy the set of variables

        for (const auto &var : *fe->vars) {
            _vars.insert(var->name);
        }

        well_typed = check_well_typed(proj, fe->body.get(), _vars);
        if (!well_typed) {
            assert(false);
            return false;
        }
    }

    return true;
}
} // namespace autov