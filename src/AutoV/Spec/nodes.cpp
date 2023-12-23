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

unsigned long SpecNode::id = 1;

// ----------------------------------------------------------------------------
// PatternMatch
// ----------------------------------------------------------------------------
const std::string PatternMatch::to_string() const {
    std::ostringstream oss;
    std::string body = std::string(*(this->body));

    if (body.find("\n") != std::string::npos) {
        return "| " + std::string(*(this->pattern)) + " =>\n" + add_indent(body, 2);
    } else
        return "| " + std::string(*(this->pattern)) + " => " + body;
}

// ----------------------------------------------------------------------------
// Rely
// ----------------------------------------------------------------------------
const std::string Rely::to_string() const {
    std::ostringstream oss;
    std::string body = std::string(*(this->body));
    std::string prop = std::string(*(this->prop));

    if (body.find("\n") != std::string::npos) {
        return "rely (\n" + add_indent(prop, 2) + ");\n" + add_indent(body, 2);
    } else
        return "rely (" + std::string(*(this->prop)) + ");\n" + body;
}

// ----------------------------------------------------------------------------
// Anno
// ----------------------------------------------------------------------------
const std::string Anno::to_string() const {
    std::ostringstream oss;
    std::string body = std::string(*(this->body));
    std::string prop = std::string(*(this->prop));

    if (body.find("\n") != std::string::npos) {
        return "anno (\n" + add_indent(prop, 2) + ");\n" + add_indent(body, 2);
    } else
        return "anno (" + std::string(*(this->prop)) + ");\n" + body;
}

// ----------------------------------------------------------------------------
// If
// ----------------------------------------------------------------------------
const std::string If::to_string() const {
    std::ostringstream oss;
    std::string then_body = std::string(*(this->then_body));
    std::string else_body = std::string(*(this->else_body));
    std::string cond = std::string(*(this->cond));

    if (cond.find("\n") != std::string::npos) {
        cond = "(\n" + add_indent(cond, 2) + ")";
    }

    if (then_body.find("\n") != std::string::npos) {
        then_body = "(\n" + add_indent(then_body, 2) + ")";
    }

    if (else_body.find("\n") != std::string::npos) {
        else_body = "(\n" + add_indent(else_body, 2) + ")";
    }

    return "if " + cond + "\nthen " + then_body + "\nelse " + else_body;
}

// ----------------------------------------------------------------------------
// Forall
// ----------------------------------------------------------------------------
const std::string Forall::to_string() const {
    std::ostringstream oss;
    std::string body = std::string(*(this->body));
    std::string vars = join_elems_space(*this->vars);

    return "(forall " + vars + ", " + body;
}

// ----------------------------------------------------------------------------
// Exists
// ----------------------------------------------------------------------------
const std::string Exists::to_string() const {
    std::ostringstream oss;
    std::string body = std::string(*(this->body));
    std::string vars = join_elems_space(*this->vars);

    return "(exists " + vars + ", " + body;
}

// ----------------------------------------------------------------------------
// Definition
// ----------------------------------------------------------------------------
const std::string Definition::to_string() const {
    std::ostringstream oss;
    std::string body = std::string(*(this->body));
    //std::string args = join_elems_space(*(this->args));
    std::string args = "";

    return "Definition " + this->name + " : " + std::string(*this->rettype) + " " + args + " := " + body + ".";
}

// ----------------------------------------------------------------------------
// Fixpoint
// ----------------------------------------------------------------------------
const std::string Fixpoint::to_string() const {
    std::ostringstream oss;
    std::string body = std::string(*(this->body));
    //std::string args = join_elems_space(this->args);
    std::string args = "";

    return "Fixpoint " + this->name + " : " + std::string(*this->rettype) + " " + args + " := " + body + ".";
}

}; // namespace autov