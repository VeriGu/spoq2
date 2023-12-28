#include <nodes.h>
#include <values.h>
#include <utils.h>

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

// ----------------------------------------------------------------------------
// Forall
// ----------------------------------------------------------------------------
const string Forall::to_string() const {
    std::ostringstream oss;
    string body = string(*(this->body));
    string vars = join_elems_space(*this->vars);

    return "(forall " + vars + ", " + body;
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