#include <project.h>
#include <nodes.h>
#include <values.h>
#include <utils.h>
#include <type_inference.h>

namespace autov {
using std::string;
using std::vector;
using std::unique_ptr;
using std::make_unique;
using std::shared_ptr;
using std::make_shared;
using std::unordered_map;
using std::holds_alternative;

unsigned long SpecNode::id = 1;

// ----------------------------------------------------------------------------
// Symbol
// ----------------------------------------------------------------------------

void Symbol::infer_type(Project &proj, unordered_map<string, shared_ptr<SpecType>> &known_types,
                optional<shared_ptr<SpecType>> &result_type) {
    vector<optional<shared_ptr<SpecType>>> candidate_types;

    if (result_type.has_value()) {
        candidate_types.push_back(result_type);
    }

    if (proj.is_ind_constr(text)) {
        auto typ = proj.get_indtype_by_constr(text);

        candidate_types.push_back(typ);
    } else if (known_types.find(text) != known_types.end()) {
        candidate_types.push_back(known_types[text]);
    }

    if (type != SpecType::UNKNOWN_TYPE) {
        candidate_types.push_back(type);
    }

    if (proj.symbols.find(text) != proj.symbols.end()) {
        auto &info = proj.symbols[text];

        if (info.kind == SymbolKind::Def)
            candidate_types.push_back(proj.defs[text]->get_type());
        else if (info.kind == SymbolKind::Decl)
            candidate_types.push_back(proj.decls[text]->get_type());
    }

    if (candidate_types.size()) {
        for (auto &candidate_type : candidate_types) {
            assert(candidate_type == candidate_types[0]);
        }
        type = *candidate_types[0];
    }
}

// ----------------------------------------------------------------------------
// Expr
// ----------------------------------------------------------------------------

const unordered_map<Expr::binops, string> Expr::binops_to_str_map = {
    {MULT, "*"},
    {DIV, "/"},
    {MOD, "mod"},
    {ADD, "+"},
    {MINUS, "-"},
    {BITAND, "&"},
    {BITOR, "|'"},
    {BEQ, "=?"},
    {BNE, "<>?"},
    {BGT, ">?"},
    {BGE, ">=?"},
    {BLT, "<?"},
    {BLE, "<=?"},
    {BAND, "&&"},
    {BOR, "||"},
    {LSHIFT, "<<"},
    {RSHIFT, ">>"},
    {SEQ, "=s"},
    {SNE, "<>s"},
    {APPEND, "::"},
    {CONCAT, "++"},
    {EQUAL, "="},
    {NOT_EQUAL, "<>"},
    {LT, "<"},
    {LTE, "<="},
    {GT, ">"},
    {GTE, ">="},
    {IFONLYIF, "<->"},
    {OR, "\\/"},
    {AND, "/\\"},
    {IMPLIES, "->"},
    // {Zlnot, "Z.lnot"},
    // {Zlxor, "Z.lxor"},
    // {Ztestbit, "Z.testbit"},
    // {xorb, "xorb"}
};

const string Expr::to_string() const {
    const auto &op = this->op;

    if (holds_alternative<binops>(op)) {
        auto &op = std::get<binops>(this->op);

        if (this->elems->size() == 1) {
            if (string(*this->elems->at(0)).size() > 160)
                return "(" + binops_to_str_map.at(op) + "\n" + add_indent(string(*elems->at(0)), 2) + ")";
            else
                return "(" + binops_to_str_map.at(op) + " " + string(*elems->at(0)) + ")";
        } else {
            string snd_str = "(" + string(*elems->at(1)) + ")";
            string fst_str;
            auto& elem = *this->elems->at(0);

            if (typeid(elem) == typeid(Match))
                fst_str = "(" + string(*elems->at(0)) + ")";
            else
                fst_str = string(*elems->at(0));

            if (snd_str.size() + fst_str.size() > 160)
                return "(" + fst_str + " " + binops_to_str_map.at(op) + "\n" + add_indent(snd_str, 2) + ")";
            else
                return "(" + fst_str + " " + binops_to_str_map.at(op) + " " + snd_str + ")";
        }
    } else if (holds_alternative<ops>(op)) {
        auto op = std::get<ops>(this->op);

        if (op == Tuple) {
            string str = "(" + join_elems_comma(*elems) + ")";

            if (str.size() > 160)
                return "(\n" + join_elems_comma1(*elems, 2) + "\n)";
            else
                return str;
        } else if (op == GET) {
            if (string(*elems->at(1)).size() > 160)
                return "(" + string(*elems->at(0)) + " @\n" + add_indent(string(*elems->at(1)), 2) + ")";
            else
                return "(" + string(*elems->at(0)) + " @ " + string(*elems->at(1)) + ")";
        } else if (op == SET) {
            string str = "(" + string(*elems->at(0)) + " # " + string(*elems->at(1)) + " == " + string(*elems->at(2)) + ")";

            if (str.size() > 160)
                return "(" + string(*elems->at(0)) + " #\n" + add_indent(string(*elems->at(1)), 2) + " ==\n" +
                        add_indent(string(*elems->at(2)), 2) + ")";
            else
                return str;
        } else if (op == RecordGet) {
            return "(" + string(*elems->at(0)) + ".(" + string(*elems->at(1)) + "))";
        } else if (op == RecordSet) {
            string str = "(" + string(*elems->at(0));

            for (auto it = elems->begin() + 1; it != elems->end() - 1; it++) {
                str += ".[" + string(**it) + "]";
            }

            if (str.size() + string(" :< ").size() + string(*elems->back()).size() + string(")").size() > 160)
                return str + " :<\n" + add_indent(string(*elems->back()), 2) + ")";
            else
                return str + " :< " + string(*elems->back()) + ")";
        } else if (op == Some) {
            return "(Some " + string(*elems->at(0)) + ")";
        } else if (op == None) {
            return "None";
        } else if (op == NOT) {
            return "(~ " + string(*elems->at(0)) + ")";
        } else if (op == BNOT) {
            return "(! " + string(*elems->at(0)) + ")";
        } else {
            throw std::runtime_error("Unknown op");
        }
    } else {
        string op_str = holds_alternative<string>(op) ? std::get<string>(op) : string(*std::get<unique_ptr<SpecNode>>(op));
        string str = "(" + op_str;

        if (elems->size()) {
            //LOG_INFO << "op_str: " << op_str;
            //LOG_INFO << "join_elems_space(*elems): " << join_elems_space(*elems);
            str += " " + join_elems_space(*elems) + ")";
        } else {
            str += ")";
        }

        if (str.size() > 160) {
            //LOG_INFO << "str: " << str;
            return "(" + op_str + "\n" + join_elems_space(*elems, 2) + ")"; }
        else
            return str;
    }

    // Unreachable
    assert(false);
    return "";
}

void Expr::infer_type(Project &proj, unordered_map<string, shared_ptr<SpecType>> &known_types,
                      optional<shared_ptr<SpecType>> &result_type) {
#if 0
    if (holds_alternative<binops>(op)) {
        auto op = std::get<binops>(this->op);

        switch (op) {
        case ADD: case MINUS: case MULT: case DIV: case MOD:
        case LSHIFT: case RSHIFT: case BITAND: case BITOR: {
            /*
            * TODO: Z.lnot Z.lxor
            */
           optional<shared_ptr<SpecType>> int_type = Int::INT;

            for (auto &e: *elems) {
                e->infer_type(proj, known_types, int_type);
            }
            type = Int::INT;
            break;
        }
        case BEQ: case BNE: case BGT: case BGE: case BLT: case BLE: {
            optional<shared_ptr<SpecType>> int_type = Int::INT;

            for (auto &e: *elems) {
                e->infer_type(proj, known_types, int_type);
            }
            type = Bool::BOOL;
            break;
        }
        case BAND: case BOR: {
            optional<shared_ptr<SpecType>> bool_type = Bool::BOOL;

            for (auto &e: *elems) {
                e->infer_type(proj, known_types, bool_type);
            }
            type = Bool::BOOL;
            break;
        }
        case SEQ: case SNE: {
            optional<shared_ptr<SpecType>> string_type = String::STRING;

            for (auto &e: *elems) {
                e->infer_type(proj, known_types, string_type);
            }
            type = Bool::BOOL;
            break;
        }
        case LT: case LTE: case GT: case GTE: {
            optional<shared_ptr<SpecType>> int_type = Int::INT;

            for (auto &e: *elems) {
                e->infer_type(proj, known_types, int_type);
            }

            type = Prop::PROP;
            break;
        }
        case EQUAL: case NOT_EQUAL: {
            optional<shared_ptr<SpecType>> none;
            shared_ptr<SpecType> elems0_type, elems1_type;

            elems->at(0)->infer_type(proj, known_types, none);
            elems->at(1)->infer_type(proj, known_types, none);

            elems0_type = elems->at(0)->get_type();
            elems1_type = elems->at(1)->get_type();

            if (elems0_type != SpecType::UNKNOWN_TYPE && elems1_type == SpecType::UNKNOWN_TYPE) {
                auto elem_type = dynamic_pointer_cast<List>(elems0_type)->elem_type;
                optional<shared_ptr<SpecType>> opt_elem_type = elem_type;

                elems->at(1)->infer_type(proj, known_types, opt_elem_type);
            } else if (elems0_type == SpecType::UNKNOWN_TYPE && elems1_type != SpecType::UNKNOWN_TYPE) {
                auto elem_type = dynamic_pointer_cast<List>(elems1_type)->elem_type;
                optional<shared_ptr<SpecType>> opt_elem_type = elem_type;

                elems->at(0)->infer_type(proj, known_types, opt_elem_type);
            }

            type = Prop::PROP;
            break;
        }
        case IFONLYIF: case OR: case AND: case IMPLIES: {
            optional<shared_ptr<SpecType>> prop = Prop::PROP;

            for (auto &e: *elems) {
                e->infer_type(proj, known_types, prop);
            }

            type = Prop::PROP;
            break;
        }
        case APPEND: {
            if (result_type.has_value()) {
                auto elem_type = dynamic_pointer_cast<List>(result_type.value())->elem_type;
                std::optional<std::shared_ptr<SpecType>> opt_elem_type = elem_type;

                elems->at(0)->infer_type(proj, known_types, opt_elem_type);
                elems->at(1)->infer_type(proj, known_types, result_type);
            } else {
                optional<shared_ptr<SpecType>> none;
                shared_ptr<SpecType> elems0_type, elems1_type;

                elems->at(0)->infer_type(proj, known_types, none);
                elems->at(1)->infer_type(proj, known_types, none);

                elems0_type = elems->at(0)->get_type();
                elems1_type = elems->at(1)->get_type();

                if (elems0_type != SpecType::UNKNOWN_TYPE && elems1_type == SpecType::UNKNOWN_TYPE) {
                    auto elem_type = make_shared<List>(dynamic_pointer_cast<List>(elems0_type)->elem_type);
                    optional<shared_ptr<SpecType>> opt_elem_type = elem_type;

                    elems->at(1)->infer_type(proj, known_types, opt_elem_type);
                } else if (elems0_type == SpecType::UNKNOWN_TYPE && elems1_type != SpecType::UNKNOWN_TYPE) {
                    auto elem_type = dynamic_pointer_cast<List>(elems1_type)->elem_type;
                    optional<shared_ptr<SpecType>> opt_elem_type = elem_type;

                    elems->at(0)->infer_type(proj, known_types, opt_elem_type);
                }
            }

            type = make_shared<List>(elems->at(0)->get_type());
            break;
        }
        case CONCAT: {
            if (result_type.has_value()) {
                elems->at(0)->infer_type(proj, known_types, result_type);
                elems->at(1)->infer_type(proj, known_types, result_type);
            } else {
                optional<shared_ptr<SpecType>> none;
                shared_ptr<SpecType> elems0_type, elems1_type;

                elems->at(0)->infer_type(proj, known_types, none);
                elems->at(1)->infer_type(proj, known_types, none);

                elems0_type = elems->at(0)->get_type();
                elems1_type = elems->at(1)->get_type();

                if (elems0_type != SpecType::UNKNOWN_TYPE && elems1_type == SpecType::UNKNOWN_TYPE) {
                    auto elem_type = dynamic_pointer_cast<List>(elems0_type)->elem_type;
                    optional<shared_ptr<SpecType>> opt_elem_type = elem_type;

                    elems->at(1)->infer_type(proj, known_types, opt_elem_type);
                } else if (elems0_type == SpecType::UNKNOWN_TYPE && elems1_type != SpecType::UNKNOWN_TYPE) {
                    auto elem_type = dynamic_pointer_cast<List>(elems1_type)->elem_type;
                    optional<shared_ptr<SpecType>> opt_elem_type = elem_type;

                    elems->at(0)->infer_type(proj, known_types, opt_elem_type);
                }
            }

            type = elems->at(0)->get_type();
            break;
        }
        default:
            throw std::runtime_error("Unknown binop");
        }
    } else if (holds_alternative<ops>(op)) {
        auto op = std::get<ops>(this->op);

        switch (op) {
        case Tuple: {
            auto tuple_result_type = dynamic_cast<autov::Tuple *>((*result_type).get());
            auto tuple_type = make_shared<vector<shared_ptr<SpecType>>>();

            if (tuple_result_type) {
                auto e_it = elems->begin();
                auto t_it = tuple_result_type->types->begin();
                for (; e_it != elems->end() && t_it != tuple_result_type->types->end(); e_it++, t_it++) {
                    optional<shared_ptr<SpecType>> opt_elem_type = (*t_it);
                    (*e_it)->infer_type(proj, known_types, opt_elem_type);
                }
            } else {
                optional<shared_ptr<SpecType>> none;
                for (auto it = elems->begin(); it != elems->end(); it++) {
                    (*it)->infer_type(proj, known_types, none);
                }
            }

            for (const auto &e: *elems) {
                tuple_type->push_back(e->get_type());
            }

            type = make_shared<autov::Tuple>(tuple_type);

            break;
        }
        case GET: {
            optional<shared_ptr<SpecType>> int_type = Int::INT;
            shared_ptr<ZMap> this_type;

            elems->at(1)->infer_type(proj, known_types, int_type);

            if (result_type.has_value()) {
                optional<shared_ptr<SpecType>> zmap_type = make_shared<ZMap>(*result_type);

                elems->at(0)->infer_type(proj, known_types, zmap_type);
            } else {
                optional<shared_ptr<SpecType>> none;

                elems->at(0)->infer_type(proj, known_types, none);
            }

            this_type = dynamic_pointer_cast<ZMap>(elems->at(0)->get_type());
            type = this_type->elem_type;

            break;
        }
        case SET: {
            optional<shared_ptr<SpecType>> int_type = Int::INT;

            elems->at(1)->infer_type(proj, known_types, int_type);

            if (result_type.has_value()) {
                auto zmap_type = dynamic_pointer_cast<ZMap>(*result_type);
                optional<shared_ptr<SpecType>> opt_elem_type = zmap_type->elem_type;

                elems->at(0)->infer_type(proj, known_types, result_type);
                elems->at(2)->infer_type(proj, known_types, opt_elem_type);
            } else {
                optional<shared_ptr<SpecType>> none;
                shared_ptr<SpecType> elems0_type, elems2_type;

                elems->at(0)->infer_type(proj, known_types, none);
                elems->at(2)->infer_type(proj, known_types, none);

                elems0_type = elems->at(0)->get_type();
                elems2_type = elems->at(2)->get_type();

                if (elems0_type != SpecType::UNKNOWN_TYPE && elems2_type == SpecType::UNKNOWN_TYPE) {
                    auto elem_type = dynamic_pointer_cast<ZMap>(elems0_type)->elem_type;
                    optional<shared_ptr<SpecType>> opt_elem_type = elem_type;

                    elems->at(2)->infer_type(proj, known_types, opt_elem_type);
                } else if (elems0_type == SpecType::UNKNOWN_TYPE && elems2_type != SpecType::UNKNOWN_TYPE) {
                    optional<shared_ptr<SpecType>> opt_elem_type = make_shared<ZMap>(elems2_type);

                    elems->at(0)->infer_type(proj, known_types, opt_elem_type);
                }
            }
            type = elems->at(0)->get_type();

            break;
        }
        case RecordGet: {
            auto field = dynamic_cast<Symbol *>(elems->at(1).get())->text;
            auto &info = proj.symbols.at(field);
            auto rec = optional<shared_ptr<SpecType>>(proj.structs.at(info.info));

            assert(info.kind == SymbolKind::StructElem);

            elems->at(0)->infer_type(proj, known_types, rec);
            type = dynamic_cast<Struct *>(rec->get())->elems_map.at(field);

            break;
        }
        case RecordSet: {
            auto field = dynamic_cast<Symbol *>(elems->at(1).get())->text;
            auto &info = proj.symbols.at(field);
            auto rec = optional<shared_ptr<SpecType>>(proj.structs.at(info.info));
            shared_ptr<SpecType> T = proj.structs.at(info.info);
            optional<shared_ptr<SpecType>> opt_T;

            assert(info.kind == SymbolKind::StructElem);

            elems->at(0)->infer_type(proj, known_types, rec);
            for (auto it = elems->begin() + 1; it != elems->end() - 1; it++) {
                auto field = dynamic_cast<Symbol *>((*it).get())->text;

                T = dynamic_pointer_cast<Struct>(T)->elems_map.at(field);
            }

            opt_T = T;
            elems->back()->infer_type(proj, known_types, opt_T);
            type = *rec;

            break;
        }
        case Some: {
            if (result_type.has_value()) {
                auto opt_type = dynamic_pointer_cast<Option>(*result_type)->elem_type;
                auto opt_opt_type = optional<shared_ptr<SpecType>>(opt_type);
                elems->at(0)->infer_type(proj, known_types, opt_opt_type);
            } else {
                optional<shared_ptr<SpecType>> none;

                elems->at(0)->infer_type(proj, known_types, none);
            }

            type = make_shared<Option>(elems->at(0)->get_type());

            break;
        }
        case None: {
            break;
        }
        case NOT: {
            auto prop_type = optional<shared_ptr<SpecType>>(Prop::PROP);
            elems->at(0)->infer_type(proj, known_types, prop_type);
            type = Prop::PROP;

            break;
        }
        case BNOT: {
            auto bool_type = optional<shared_ptr<SpecType>>(Bool::BOOL);
            elems->at(0)->infer_type(proj, known_types, bool_type);
            type = Bool::BOOL;

            break;
        }
        default:
            throw std::runtime_error("Unknown op");
        }
    } else if (holds_alternative<string>(op)) {
        auto op = std::get<string>(this->op);

        if (op == Project::LAYER_PTR2INT) {
            auto ptr_type = optional<shared_ptr<SpecType>>(Struct::Ptr);

            elems->at(0)->infer_type(proj, known_types, ptr_type);
            type = Int::INT;
        } else if (op == Project::LAYER_INT2PTR) {
            auto int_type = optional<shared_ptr<SpecType>>(Int::INT);

            elems->at(0)->infer_type(proj, known_types, int_type);
            type = Struct::Ptr;
        } else if (op == "z_to_nat") {
            auto int_type = optional<shared_ptr<SpecType>>(Int::INT);

            elems->at(0)->infer_type(proj, known_types, int_type);
            type = Inductive::Nat;
        } else if (proj.symbols.find(op) != proj.symbols.end()) {
            auto &info = proj.symbols[op];
            shared_ptr<SpecType> typ;

            if (info.kind == SymbolKind::Def) {
                typ = proj.defs.at(op)->get_type();
            } else if (info.kind == SymbolKind::Decl) {
                type = proj.defs.at(op)->get_type();
            } else if (info.kind == SymbolKind::StructConstr) {
                auto st = proj.structs.at(info.info);
                auto args = make_shared<vector<shared_ptr<SpecType>>>();

                for (auto it = st->elems->begin(); it != st->elems->end(); it++) {
                    args->push_back((*it)->type);
                }

                typ = make_shared<Function>(st, args);
            } else if (info.kind == SymbolKind::IndConstructor) {
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

            for (int i = 0; i < elems->size(); i++) {
                auto arg_type = dynamic_pointer_cast<Function>(typ)->args->at(i);
                optional<shared_ptr<SpecType>> opt_arg_type = arg_type;

                elems->at(i)->infer_type(proj, known_types, opt_arg_type);
            }

            type = dynamic_pointer_cast<Function>(typ)->rettype;
        } else {
            throw std::runtime_error("Unknown symbol");
        }
    } else if (holds_alternative<unique_ptr<SpecNode>>(op)) {
        auto &op = std::get<unique_ptr<SpecNode>>(this->op);
        auto raw_op = op.get();
        optional<shared_ptr<SpecType>> none;
        shared_ptr<SpecType> typ;

        raw_op->infer_type(proj, known_types, none);
        typ = raw_op->get_type();

        assert(dynamic_pointer_cast<Function>(typ));

        for (int i = 0; i < elems->size(); i++) {
            auto arg_type = dynamic_pointer_cast<Function>(typ)->args->at(i);
            optional<shared_ptr<SpecType>> opt_arg_type = arg_type;

            elems->at(i)->infer_type(proj, known_types, opt_arg_type);
        }

        type = dynamic_pointer_cast<Function>(typ)->rettype;
    }
#endif
}

// ----------------------------------------------------------------------------
// PatternMatch
// ----------------------------------------------------------------------------
const string PatternMatch::to_string() const {
    std::ostringstream oss;
    string body = string(*(this->body));

    if (body.find("\n") != string::npos) {
        return "| " + string(*(this->pattern)) + " =>\n" + add_indent(body, 2);
    } else
        return "| " + string(*(this->pattern)) + " => " + body;
}

// ----------------------------------------------------------------------------
// Match
// ----------------------------------------------------------------------------
const string Match::to_string() const {
    string src = string(*(this->src));
    string arms;
    bool has_newline = src.find("\n") != string::npos;

    if (is_let()) {
        auto pm = (*match_list)[0].get();
        string body = string(*(pm->body));

        if (has_newline) {
            return "let " + string(*(pm->pattern)) + " := (\n" + add_indent(src, 4) + ") in\n" + body;
        } else
            return "let " + string(*(pm->pattern)) + " := " + src + " in\n" + body;
    } else if (is_when()) {
        auto pm = (*match_list)[0].get();
        string patt_str;
        string body_str = string(*(pm->body));
        auto pm_pattern_expr = dynamic_cast<Expr*>(pm->pattern.get());

        if (pm_pattern_expr) {
            auto pm_pattern_elems0 = pm_pattern_expr->elems->at(0).get();

            if (dynamic_cast<Symbol *>(pm_pattern_elems0)) {
                patt_str = string(*(pm_pattern_elems0));
            } else if (dynamic_cast<Expr *>(pm_pattern_elems0)) {
                auto elems = dynamic_cast<Expr *>(pm_pattern_elems0)->elems.get();

                patt_str = join_elems_comma(*elems);
            } else {
                throw std::runtime_error("Pattern is not an expression");
            }

        } else {
            throw std::runtime_error("Pattern is not an expression");
        }


        if (has_newline) {
            return "when " + patt_str + " == (\n" + add_indent(src, 4) + ");\n" + body_str;
        } else
            return "when " + patt_str + " == (" + src + ");\n" + body_str;
    }

    for (auto it = match_list->begin(); it != match_list->end(); it++) {
        if (it != match_list->begin())
            arms += "\n";

        arms += string(**it);
    }

    if (has_newline) {
        return "match (\n" + add_indent(src, 2) + "\n" + ") with\n" + arms + "\nend";
    } else
        return "match (" + src + ") with\n" + arms + "\nend";
}

void Match::infer_type(Project &proj, unordered_map<string, shared_ptr<SpecType>> &known_types,
                       optional<shared_ptr<SpecType>> &result_type) {
    throw std::runtime_error("infer_type for Match is Not implemented");
    // optional<shared_ptr<SpecType>> none;
    // vector<shared_ptr<SpecType>> pattern_types;

    // src->infer_type(proj, known_types, none);

    // for (auto it = match_list->begin(); it != match_list->end(); it++) {
    //     auto pm = (*it).get();
    //     auto pm_pattern = pm->pattern.get();
    //     auto pm_body = pm->body.get();

    //     pm_pattern->infer_type(proj, known_types, none);
    //     pm_body->infer_type(proj, known_types, result_type);

    //     pattern_types.push_back(pm_pattern->get_type());
    // }
}


// ----------------------------------------------------------------------------
// Rely
// ----------------------------------------------------------------------------
const string Rely::to_string() const {
    std::ostringstream oss;
    string body = string(*(this->body));
    string prop = string(*(this->prop));

    if (prop.find("\n") != string::npos) {
        return "rely (\n" + add_indent(prop, 2) + ");\n" + body;
    } else
        return "rely (" + string(*(this->prop)) + ");\n" + body;
}

void Rely::infer_type(Project &proj, unordered_map<string, shared_ptr<SpecType>> &known_types,
                      optional<shared_ptr<SpecType>> &result_type) {
#if 0
    optional<shared_ptr<SpecType>> prop = Prop::PROP;
    optional<shared_ptr<SpecType>> none;

    this->prop->infer_type(proj, known_types, prop);
    this->body->infer_type(proj, known_types, none);
    this->type = this->body->get_type();
#endif
}

// ----------------------------------------------------------------------------
// Anno
// ----------------------------------------------------------------------------
const string Anno::to_string() const {
    std::ostringstream oss;
    string body = string(*(this->body));
    string prop = string(*(this->prop));

    if (prop.find("\n") != string::npos) {
        return "anno (\n" + add_indent(prop, 2) + ");\n" + add_indent(body, 2);
    } else
        return "anno (" + string(*(this->prop)) + ");\n" + body;
}

void Anno::infer_type(Project &proj, unordered_map<string, shared_ptr<SpecType>> &known_types,
                optional<shared_ptr<SpecType>> &result_type) {
#if 0
    optional<shared_ptr<SpecType>> prop = Prop::PROP;
    optional<shared_ptr<SpecType>> none;

    this->prop->infer_type(proj, known_types, prop);
    this->body->infer_type(proj, known_types, none);
    this->type = this->body->get_type();
#endif
}

// ----------------------------------------------------------------------------
// If
// ----------------------------------------------------------------------------
const string If::to_string() const {
    std::ostringstream oss;
    string then_body = string(*(this->then_body));
    string else_body = string(*(this->else_body));
    string cond = string(*(this->cond));

    if (cond.find("\n") != string::npos) {
        cond = "(\n" + add_indent(cond, 2) + ")";
    }

    if (then_body.find("\n") != string::npos) {
        then_body = "(\n" + add_indent(then_body, 2) + ")";
    }

    if (else_body.find("\n") != string::npos) {
        else_body = "(\n" + add_indent(else_body, 2) + ")";
    }

    return "if " + cond + "\nthen " + then_body + "\nelse " + else_body;
}

void If::infer_type(Project &proj, unordered_map<string, shared_ptr<SpecType>> &known_types,
            optional<shared_ptr<SpecType>> &result_type) {
#if 0
    optional<shared_ptr<SpecType>> bool_type = Bool::BOOL;
    shared_ptr<SpecType> then_body_type, else_body_type;

    this->cond->infer_type(proj, known_types, bool_type);
    this->then_body->infer_type(proj, known_types, result_type);
    this->else_body->infer_type(proj, known_types, result_type);

    then_body_type = this->then_body->get_type();
    else_body_type = this->else_body->get_type();

    if (then_body_type != SpecType::UNKNOWN_TYPE && else_body_type == SpecType::UNKNOWN_TYPE) {
        this->else_body->infer_type(proj, known_types, result_type);
        else_body_type = this->else_body->get_type();
    } else if (then_body_type == SpecType::UNKNOWN_TYPE && else_body_type != SpecType::UNKNOWN_TYPE) {
        this->then_body->infer_type(proj, known_types, result_type);
        then_body_type = this->then_body->get_type();
    }

    assert(then_body_type == else_body_type);

    this->type = then_body_type;
#endif
}

// ----------------------------------------------------------------------------
// Forall
// ----------------------------------------------------------------------------
const string Forall::to_string() const {
    std::ostringstream oss;
    string body = string(*(this->body));
    string vars = join_elems_space(*this->vars);

    return "(forall " + vars + ", " + body;
}

void Forall::infer_type(Project &proj, unordered_map<string, shared_ptr<SpecType>> &known_types,
                        optional<shared_ptr<SpecType>> &result_type) {
#if 0
    auto known = unordered_map<string, shared_ptr<SpecType>>(known_types);
    optional<shared_ptr<SpecType>> prop_type = Prop::PROP;

    for (auto it = vars->begin(); it != vars->end(); it++) {
        known[(*it)->name] = (*it)->type;
    }

    this->body->infer_type(proj, known, prop_type);
#endif
}

// ----------------------------------------------------------------------------
// Exists
// ----------------------------------------------------------------------------
const string Exists::to_string() const {
    std::ostringstream oss;
    string body = string(*(this->body));
    string vars = join_elems_space(*this->vars);

    return "(exists " + vars + ", " + body;
}

void Exists::infer_type(Project &proj, unordered_map<string, shared_ptr<SpecType>> &known_types,
                        optional<shared_ptr<SpecType>> &result_type) {
#if 0
    auto known = unordered_map<string, shared_ptr<SpecType>>(known_types);
    optional<shared_ptr<SpecType>> prop_type = Prop::PROP;

    for (auto it = vars->begin(); it != vars->end(); it++) {
        known[(*it)->name] = (*it)->type;
    }

    this->body->infer_type(proj, known, prop_type);
#endif
}

// ----------------------------------------------------------------------------
// Definition
// ----------------------------------------------------------------------------
const string Definition::to_string() const {
    std::ostringstream oss;
    string body_str = string(*(this->body));
    string args_str = "";

    if (!rettype->record) {
        for (auto it = args->begin(); it != args->end(); it++) {
            args_str += string(**it);
            if (it < args->end() - 1)
                args_str += " ";
        }

        return "Definition " + this->name + " " + args_str + " : " + string(*this->rettype) + " :=\n" + add_indent(body_str, 2) + ".";
    } else {
        auto record_def = dynamic_cast<RecordDef *>(body.get());
        bool first = true;
        for (const auto& kv : *record_def->fields) {
            const auto& key = kv.first;
            const auto& value = kv.second;
            // Use key and value

            if (!first) {
                args_str += ";\n";
            }
            args_str += "    " + string(*key) + " := " + string(*value);
        }
    }

    return "Definition " + this->name + " : " + string(*this->rettype) + " :=\n  {|\n" + args_str + "\n  |}.";
}

void Definition::infer_type(Project &proj) {
    unordered_map<string, shared_ptr<SpecType>> known;
    std::set<string> vars;
    bool well_typed;

    for (auto it = args->begin(); it != args->end(); it++) {
        known[(*it)->name] = (*it)->type;
    }

    type_inference::infer_type(proj, body.get(), &known, rettype);

    for (auto it = args->begin(); it != args->end(); it++) {
        vars.insert((*it)->name);
    }

    well_typed = type_inference::check_well_typed(proj, body.get(), vars);
    assert(well_typed);
}

// ----------------------------------------------------------------------------
// Fixpoint
// ----------------------------------------------------------------------------
const string Fixpoint::to_string() const {
    std::ostringstream oss;
    string body_str = string(*(this->body));
    string args_str = "";

    for (auto it = args->begin(); it != args->end(); it++) {
        args_str += string(**it);
        if (it < args->end() - 1)
            args_str += " ";
    }

    return "Fixpoint " + this->name + " " + args_str + " : " + string(*this->rettype) + " :=\n" + add_indent(body_str, 2) + ".";

}

}; // namespace autov