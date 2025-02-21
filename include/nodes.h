#pragma once

#include <string>
#include <vector>
#include <map>
#include <unordered_map>
#include <iostream>
#include <sstream>
#include <stdexcept>
#include <variant>
#include <memory>
#include <optional>

#include <values.h>
#include <log.h>
#include <cassert>

namespace autov {
using std::string;
using std::vector;
using std::unique_ptr;
using std::make_unique;
using std::shared_ptr;
using std::make_shared;
using std::dynamic_pointer_cast;
using std::unordered_map;
using std::holds_alternative;
using std::optional;

class Project;
class SpecValue;

class SpecNode {
public:
    static unsigned long id; // Initialized in nodes.cpp

    bool depend_on_interested_read = false;
    bool depend_on_interested_write = false;
    bool is_interested_read = false;
    bool is_interested_write = false;
    bool depends_on_state_read = false;
    shared_ptr<SpecType> type;
    unsigned long nid;
    int length;
    mutable string _str; // cached string representation
    shared_ptr<SpecType> tmp;
    shared_ptr<SpecValue> cached_eval;

    SpecNode() : type(SpecType::UNKNOWN_TYPE), nid(id++), length(1) {}
    SpecNode(shared_ptr<SpecType> type) : type(type), nid(id++), length(1) {}
    SpecNode(shared_ptr<SpecType> type, int length) : type(type), nid(id++), length(length) {}

    virtual bool operator==(const SpecNode& other) const {
        if (typeid(other) != typeid(*this)) {
            return false;
        }
        return this == &other;
    }

    virtual bool operator!=(const SpecNode& other) const {
        return !(*this == other);
    }

    operator string() const {
// #ifndef DEBUG
//         if (this->_str == "") {
//             this->_str = this->to_string();
//         }

//         return this->_str;
// #else
        return this->to_string();
//#endif
    }

    bool has_type() const {
        return this->type != SpecType::UNKNOWN_TYPE;
    }

    void set_type(shared_ptr<SpecType> type) {
        if (this->has_type() && this->type->name != type->name && type != SpecType::UNKNOWN_TYPE) {
            LOG_ERROR << "Overwriting type " << string(*this->type) << " with " << string(*type);
            throw std::invalid_argument("Overwriting type " + string(*this->type) + " with " + string(*type));
        }
        this->type = type;
    }

    shared_ptr<SpecType> get_type() const {
        if (!this->has_type()) {
            return SpecType::UNKNOWN_TYPE;
        }
        return this->type;
    }

    void set_z3_eval(shared_ptr<SpecValue> value) {
        this->cached_eval = value;
    }

    virtual void clear_z3_eval() = 0;

    virtual unique_ptr<SpecNode> deep_copy() const = 0;
    virtual void deep_copy(unique_ptr<SpecNode> &p) const = 0;

    virtual ~SpecNode() {}
private:
    virtual const string to_string() const = 0;
};


class Symbol : public SpecNode {
public:
    string text;

    Symbol() { throw std::invalid_argument("Symbol must have a name"); }
    Symbol(string text) : SpecNode(SpecType::UNKNOWN_TYPE), text(text) {}
    Symbol(string text, shared_ptr<SpecType> type) : SpecNode(type), text(text) {}

    bool operator==(const SpecNode& other) const {
        if (typeid(other) != typeid(Symbol)) {
            return false;
        }
        return this->text == ((Symbol&)other).text;
    }

    bool operator!=(const SpecNode& other) const {
        return !(*this == other);
    }

    operator string() const {
        return this->text;
    }

    unique_ptr<SpecNode> deep_copy() const {
        return make_unique<Symbol>(this->text, this->type);
    }

    void clear_z3_eval() {
        this->cached_eval = nullptr;
    }

    void deep_copy(unique_ptr<SpecNode> &p) const {
        p = make_unique<Symbol>(this->text, this->type);
    }

    void infer_type(Project &proj, unordered_map<string, shared_ptr<SpecType>> &known_types,
                    optional<shared_ptr<SpecType>> &result_type);

    ~Symbol() {}

private:
    const string to_string() const {
        return this->text;
    }
};

class Const : public SpecNode {
public:
    std::variant<unsigned long, string, bool> value;

    Const() { throw std::invalid_argument("Const must have a value"); }
    Const(const std::variant<unsigned long, string, bool>& value) : SpecNode(SpecType::UNKNOWN_TYPE), value(value) {}
    Const(const std::variant<unsigned long, string, bool>& value, shared_ptr<SpecType> type)
        : SpecNode(type), value(value) {
#if 0
        if (!std::holds_alternative<unsigned long>(this->value))
            return;
        long long v = std::get<unsigned long>(this->value);
        if (v > -100 && v < 0) {
            throw std::invalid_argument("Const must be positive, currrnt value: " + std::to_string(v));
        }
#endif
    }

    bool operator==(const SpecNode& other) const {
        if (typeid(other) != typeid(*this)) {
            return false;
        }
        return this->value == ((Const&)other).value;
    }

    bool operator!=(const SpecNode& other) const {
        return !(*this == other);
    }

    virtual operator string() const {
        return this->to_string();
    }

    unique_ptr<SpecNode> deep_copy() const {
        return make_unique<Const>(this->value, this->type);
    }

    void clear_z3_eval() {
        this->cached_eval = nullptr;
    }

    void deep_copy(unique_ptr<SpecNode> &p) const {
        p = make_unique<Const>(this->value, this->type);
    }

    virtual ~Const() {}
private:
    virtual const string to_string() const {
        if (this->type == SpecType::UNKNOWN_TYPE) {
            throw std::invalid_argument("Const must have a type");
        } else if (dynamic_cast<Int *>(this->type.get()) != nullptr) {
            // if (std::get_if<unsigned long>(&this->value) == nullptr) {
            //     if (std::get_if<string>(&this->value) != nullptr) {
            //         std::cout << ("Const must have an integer value, not a string: " + std::get<string>(this->value));
            //         return std::get<string>(this->value);
            //     } else {
            //         std::cout << ("Const must have an integer value, not a bool: " + std::to_string(std::get<bool>(this->value)));
            //         return std::to_string(std::get<bool>(this->value));
            //     }
            // }
            long long v = std::get<unsigned long>(this->value);
            if (v > -100 && v < 0) {
                return "(-" + std::to_string(-v) + ")";
            } else
                return std::to_string((unsigned long)v);
        } else if (dynamic_cast<String *>(this->type.get()) != nullptr) {
            return "\"" + std::get<string>(this->value) + "\"";
        } else if (dynamic_cast<Bool *>(this->type.get()) != nullptr) {
            return std::get<bool>(this->value) ? "true" : "false";
        } else if (this->type == Prop::PROP) {
            return std::get<bool>(this->value) ? "true" : "false";
        } else {
            throw std::invalid_argument("Const must have invalid type: " + string(*this->type));
        }
    }
};

class IntConst : public Const {
public:
    IntConst() { throw std::invalid_argument("IntConst must have a value"); }
    IntConst(unsigned long value) : Const(value, Int::INT) {}
    //IntConst(unsigned long value, SpecType type) : Const(value, type) {}
    
    unsigned long get_value() {
        return std::get<unsigned long>(this->value);
    }
    ~IntConst() {}
private:
    const string to_string() const {
        long long v = std::get<unsigned long>(this->value);
        if (v > -100 && v < 0) {
            return "(-" + std::to_string(-v) + ")";
        } else
            return std::to_string((unsigned long)v);
    }
};

class StringConst : public Const {
public:
    StringConst() { throw std::invalid_argument("StringConst must have a value"); }
    StringConst(string value) : Const(value, String::STRING) {}
    //StringConst(string value, SpecType type) : Const(value, type) {}

    ~StringConst() {}

private:
    const string to_string() const {
        return "\"" + std::get<string>(this->value) + "\"";
    }
};

class BoolConst : public Const {
public:
    BoolConst() { throw std::invalid_argument("BoolConst must have a value"); }
    BoolConst(bool value) : Const(value, Bool::BOOL) {}
    //BoolConst(bool value, SpecType type) : Const(value, type) {}

    ~BoolConst() {}

private:
    const string to_string() const {
        return std::get<bool>(this->value) ? "true" : "false";
    }
};

class RecordDef : public SpecNode {
public:
    unique_ptr<std::map<unique_ptr<Symbol>, unique_ptr<SpecNode>>> fields;

    RecordDef() { throw std::invalid_argument("RecordDef must have fields"); }
    RecordDef(unique_ptr<std::map<unique_ptr<Symbol>, unique_ptr<SpecNode>>> fields) :
        SpecNode(SpecType::UNKNOWN_TYPE), fields(std::move(fields)){
        this->length = calc_length();
    }
    RecordDef(unique_ptr<std::map<unique_ptr<Symbol>, unique_ptr<SpecNode>>> fields, shared_ptr<SpecType> type) :
        SpecNode(type), fields(std::move(fields)) {
        this->length = calc_length();
    }

    bool operator==(const SpecNode& other) const {
        if (typeid(other) != typeid(RecordDef)) {
            return false;
        }
        return this->fields == ((RecordDef&)other).fields;
    }

    bool operator!=(const SpecNode& other) const {
        return !(*this == other);
    }

    void clear_z3_eval() {
        this->cached_eval = nullptr;
        for (auto it = fields->begin(); it != fields->end(); it++) {
            it->second->clear_z3_eval();
        }
    }

    unique_ptr<SpecNode> deep_copy() const {
        throw std::invalid_argument("RecordDef cannot be deep copied");
    }

    void deep_copy(unique_ptr<SpecNode> &p) const {
        throw std::invalid_argument("RecordDef cannot be deep copied");
    }

    ~RecordDef() {}

private:
    const string to_string() const {
        std::ostringstream oss;
        bool first = true;

        oss << "{|\n";
        for (auto it = fields->begin(); it != fields->end(); it++) {
            if (!first) {
                oss << ";\n";
            }
            oss << "    " << string(*it->first) << " =: " << string(*(it->second));
            first = false;
        }
        oss << "|}\n";

        return oss.str();
    }
    int calc_length() const {
        int length = 0;

        for (auto it = fields->begin(); it != fields->end(); it++) {
            if (it == fields->begin()) {
                length += it->second->length;
            }
        }

        return length;
    }
};

extern unsigned long mono_lens_id;
class Expr : public SpecNode {
public:
    bool is_lens = false;

    enum ops {
        __NEG, // dummy, DO NOT USE outside the parser!!!
        SET, GET, NTH, // non-binop
        NOT, BNOT, // uni-op
        RecordSet, RecordGet, // Record
        Tuple,
        Some, None
    };

    enum binops {
        MULT, DIV, MOD,
        ADD, MINUS, BITAND, BITOR,
        BEQ, BNE, BGT, BGE, BLT, BLE, BAND, BOR, LSHIFT, RSHIFT, SEQ, SNE,
        APPEND, CONCAT,
        EQUAL, NOT_EQUAL, LT, LTE, GT, GTE, IFONLYIF, OR, AND, IMPLIES,
        // Zlnot, Zlxor, Ztestbit,
        // xorb
    };

    using op_t = std::variant<unique_ptr<SpecNode>, ops, binops, string>;
    using elems_t = unique_ptr<vector<unique_ptr<SpecNode>>>;
    op_t op;
    unique_ptr<vector<unique_ptr<SpecNode>>> elems;

    bool ends_with_lens(const std::string& str) {
        if (str.length() >= 4) {
            return str.rfind("lens") == str.length() - 4;
        }
        return false;
    }

    Expr() { throw std::invalid_argument("Expr must have an op and elems"); }
    Expr(op_t op, elems_t elems) :
        SpecNode(SpecType::UNKNOWN_TYPE), op(std::move(op)), elems(std::move(elems)) {
            this->length = calc_length();
        if (std::holds_alternative<string>(this->op)) {
            auto s = std::get<string>(this->op);

            if (s == "lens") {
                auto lens_id_node = static_cast<Const *>(this->elems->at(0).get());
                auto lens_id = std::get<unsigned long>(lens_id_node->value);

                if (lens_id > mono_lens_id) {
                    mono_lens_id = lens_id + 1;
                }
            }
        }
    }

    Expr(op_t op, elems_t elems, shared_ptr<SpecType> type) :
        SpecNode(type), op(std::move(op)), elems(std::move(elems)) {
            this->length = calc_length();

        if (std::holds_alternative<string>(this->op)) {
            auto s = std::get<string>(this->op);

            if (s == "lens") {
                auto lens_id_node = static_cast<Const *>(this->elems->at(0).get());
                auto lens_id = std::get<unsigned long>(lens_id_node->value);

                if (lens_id > mono_lens_id) {
                    mono_lens_id = lens_id + 1;
                }
            }
        }
    }

    bool operator==(const SpecNode& other) const {
        if (typeid(other) != typeid(Expr)) {
            return false;
        }

        if (auto e = std::get_if<unique_ptr<SpecNode>>(&this->op)) {
            if (auto e2 = std::get_if<unique_ptr<SpecNode> >(&((Expr&)other).op)) {
                return **e == **e2 && elems_eq((Expr&)other);
            }
            return false;
        }

        return this->op == ((Expr&)other).op && elems_eq((Expr&)other);
    }

    bool operator!=(const SpecNode& other) const {
        return !(*this == other);
    }

    unique_ptr<SpecNode> deep_copy() const {
        return deep_copy_down();
    }

    void deep_copy(unique_ptr<SpecNode> &p) const {
        p = deep_copy_down();
    }

    void clear_z3_eval() {
        this->cached_eval = nullptr;
        for (auto it = elems->begin(); it != elems->end(); it++) {
            it->get()->clear_z3_eval();
        }
    }

    unique_ptr<Expr> deep_copy_down() const {
        // deep copy elems
        unique_ptr<vector<unique_ptr<SpecNode>>> new_elems = make_unique<vector<unique_ptr<SpecNode>>>();

        for (auto it = elems->begin(); it != elems->end(); it++) {
            new_elems->push_back((*it)->deep_copy());
        }

        auto ret = unique_ptr<Expr>();
        if (std::holds_alternative<string>(this->op)) {
            ret = make_unique<Expr>(std::get<string>(this->op), std::move(new_elems), this->type);
        } else if (std::holds_alternative<ops>(this->op)) {
            ret = make_unique<Expr>(std::get<ops>(this->op), std::move(new_elems), this->type);
        } else if (std::holds_alternative<binops>(this->op)) {
            ret = make_unique<Expr>(std::get<binops>(this->op), std::move(new_elems), this->type);
        } else {
            ret = make_unique<Expr>(std::get<unique_ptr<SpecNode>>(this->op)->deep_copy(),
                                          std::move(new_elems), this->type);
        }

        ret->is_lens = this->is_lens;
        ret->length = this->length;
        return ret;
    }

    void deep_copy_down(unique_ptr<Expr> &p) const {
        p = deep_copy_down();
    }

    void infer_type(Project &proj, unordered_map<string, shared_ptr<SpecType>> &known_types,
                    optional<shared_ptr<SpecType>> &result_type);

    ~Expr() {}

private:
    const string to_string() const;
    static const unordered_map<binops, string> binops_to_str_map;

    int calc_length() const{
        int length = 0;

        for (auto it = elems->begin(); it != elems->end(); it++) {
                length += (*it)->length;
        }
        return length;
    }

    bool elems_eq(const Expr &other) const {
        if (this->elems->size() != other.elems->size()) {
            return false;
        }

        for (int i = 0; i < this->elems->size(); i++) {
            if (*(*this->elems)[i] != *(*other.elems)[i]) {
                return false;
            }
        }

        return true;
    }

};

class PatternMatch : public SpecNode {
public:
    unique_ptr<SpecNode> pattern;
    unique_ptr<SpecNode> body;

    PatternMatch() { throw std::invalid_argument("PatternMatch must have a pattern and body"); }
    PatternMatch(unique_ptr<SpecNode>pattern, unique_ptr<SpecNode>body) :
        SpecNode(body->get_type()), pattern(std::move(pattern)), body(std::move(body)) {
            this->length = calc_length();
        }

    bool operator==(const SpecNode& other) const {
        if (typeid(other) != typeid(PatternMatch)) {
            return false;
        }

        return *this->pattern == *((PatternMatch&)other).pattern &&
               *this->body == *((PatternMatch&)other).body;
    }

    bool operator!=(const SpecNode& other) const {
        return !(*this == other);
    }

    unique_ptr<SpecNode> deep_copy() const {
        return deep_copy_down();
    }


    void clear_z3_eval() {
        this->cached_eval = nullptr;
        this->pattern->clear_z3_eval();
        this->body->clear_z3_eval();
    }

    void deep_copy(unique_ptr<SpecNode> &p) const {
        p = deep_copy_down();
    }

    unique_ptr<PatternMatch> deep_copy_down() const {
        // deep copy pattern and body
        unique_ptr<SpecNode> new_pattern = this->pattern->deep_copy();
        unique_ptr<SpecNode> new_body = this->body->deep_copy();

        auto ret = make_unique<PatternMatch>(std::move(new_pattern), std::move(new_body));

        ret->length = this->length;

        return ret;
    }

    void deep_copy_down(unique_ptr<PatternMatch> &p) const {
        // deep copy pattern and body
        unique_ptr<SpecNode> new_pattern = this->pattern->deep_copy();
        unique_ptr<SpecNode> new_body = this->body->deep_copy();

        p = make_unique<PatternMatch>(std::move(new_pattern), std::move(new_body));
        p->length = this->length;
    }

    ~PatternMatch() {}

private:
    const string to_string() const;

    int calc_length() const{
        return body->length + pattern->length;
    }
};

class Match : public SpecNode {
public:
    unique_ptr<SpecNode> src;
    unique_ptr<vector<unique_ptr<PatternMatch>>> match_list;

    Match() { throw std::invalid_argument("Match must have a src and match_list"); }
    Match(unique_ptr<SpecNode> src, unique_ptr<vector<unique_ptr<PatternMatch>>> match_list) :
        SpecNode((*match_list)[0]->body->get_type()), src(std::move(src)), match_list(std::move(match_list)) {
        this->length = calc_length();
    }

    bool operator==(const SpecNode& other) const {
        if (typeid(other) != typeid(Match)) {
            return false;
        }

        if (*this->src != *((Match&)other).src) {
            return false;
        }

        if (this->match_list->size() != ((Match&)other).match_list->size()) {
            return false;
        }

        for (int i = 0; i < this->match_list->size(); i++) {
            if (*(*this->match_list)[i] != *(*((Match&)other).match_list)[i]) {
                return false;
            }
        }

        return true;
    }

    bool operator!=(const SpecNode& other) const {
        return !(*this == other);
    }

    void clear_z3_eval() {
        this->cached_eval = nullptr;
        this->src->clear_z3_eval();
        for (auto it = match_list->begin(); it != match_list->end(); it++) {
            it->get()->clear_z3_eval();
        }
    }

    unique_ptr<SpecNode> deep_copy() const {
        // deep copy src and match_list
        unique_ptr<SpecNode> new_src = this->src->deep_copy();
        unique_ptr<vector<unique_ptr<PatternMatch>>> new_match_list = make_unique<vector<unique_ptr<PatternMatch>>>();

        for (auto it = match_list->begin(); it != match_list->end(); it++) {
            new_match_list->push_back((*it)->deep_copy_down());
        }

        auto ret = make_unique<Match>(std::move(new_src), std::move(new_match_list));

        ret->length = this->length;

        return ret;
    }

    void deep_copy(unique_ptr<SpecNode> &p) const {
        // deep copy src and match_list
        unique_ptr<SpecNode> new_src = this->src->deep_copy();
        unique_ptr<vector<unique_ptr<PatternMatch>>> new_match_list = make_unique<vector<unique_ptr<PatternMatch>>>();

        for (auto it = match_list->begin(); it != match_list->end(); it++) {
            new_match_list->push_back((*it)->deep_copy_down());
        }

        p = make_unique<Match>(std::move(new_src), std::move(new_match_list));

        p->length = this->length;
    }

    bool is_let() const {
        if (match_list->size() == 1) {
            if (dynamic_cast<Symbol *>((*match_list)[0]->pattern.get()) != nullptr)
                return true;
            else if (dynamic_cast<Expr *>((*match_list)[0]->pattern.get()) != nullptr) {
                auto e = dynamic_cast<Expr *>((*match_list)[0]->pattern.get());
                auto patterns = dynamic_cast<Expr *>((*match_list)[0]->pattern.get());

                if (holds_alternative<Expr::ops>(e->op) && std::get<Expr::ops>(e->op) != Expr::Tuple) {
                    return false;
                }

                for (auto it = patterns->elems->begin(); it != patterns->elems->end(); it++) {
                    if (dynamic_cast<Symbol *>((*it).get()) == nullptr) {
                        return false;
                    }
                }

                return true;
            }
        }

        return false;
    }

    bool is_when() const {
        if (match_list->size() == 2) {
            auto pm = (*match_list)[0].get();
            auto none = (*match_list)[1].get();
            Expr *pattern = dynamic_cast<Expr *>(pm->pattern.get());
            Symbol *none_body;
            SpecNode *elem;
            Expr *elem_expr;

            if (pattern == nullptr)
                return false;
            if (!holds_alternative<Expr::ops>(pattern->op))
                return false;
            if (std::get<Expr::ops>(pattern->op) != Expr::Some)
                return false;

            auto none_pattern = none->pattern.get();
            none_body = dynamic_cast<Symbol *>(none->body.get());

            // Should only be called after this point since we know the other arm is "Some"
            auto pattern_is_none = [](SpecNode *pat) {
                if (dynamic_cast<Expr *>(pat) != nullptr) {
                    auto e = dynamic_cast<Expr *>(pat);

                    if (holds_alternative<Expr::ops>(e->op) && std::get<Expr::ops>(e->op) == Expr::None) {
                        return true;
                    }
                }  else if (dynamic_cast<Symbol *>(pat) != nullptr) {
                    auto s = dynamic_cast<Symbol *>(pat);

                    if (s->text == "_" || s->text == "None") {
                        return true;
                    }
                }

                return false;
            };

            if (none_body == nullptr) {
                return false;
            }

            bool is_none = pattern_is_none(none_pattern);

            if (!is_none || none_body->text != "None")
                return false;

            elem = pattern->elems->at(0).get();
            if (dynamic_cast<Symbol *>(elem))
                return true;

            elem_expr = dynamic_cast<Expr *>(elem);
            if (elem_expr != nullptr && holds_alternative<Expr::ops>(elem_expr->op) &&
                std::get<Expr::ops>(elem_expr->op) == Expr::Tuple) {
                if (elem_expr->elems->size() >= 3)
                    return false;

                for (auto it = elem_expr->elems->begin(); it != elem_expr->elems->end(); it++) {
                    if (dynamic_cast<Symbol *>((*it).get()) == nullptr) {
                        return false;
                    }
                }

                return true;
            }
        }

        return false;
    }

    void infer_type(Project &proj, unordered_map<string, shared_ptr<SpecType>> &known_types,
                    optional<shared_ptr<SpecType>> &result_type);

    static Match* raw_when(unique_ptr<SpecNode> pattern, unique_ptr<SpecNode> value, unique_ptr<SpecNode> body) {
        auto vec = make_unique<vector<unique_ptr<SpecNode>>>();
        vec->push_back(std::move(pattern));

        unique_ptr<Expr> some = make_unique<Expr>(Expr::Some, std::move(vec));
        auto body_type = body->get_type();
        unique_ptr<PatternMatch> some_arm = make_unique<PatternMatch>(std::move(some), std::move(body));
        unique_ptr<PatternMatch> none_arm = make_unique<PatternMatch>(make_unique<Expr>(Expr::None,  make_unique<vector<unique_ptr<SpecNode>>>()), make_unique<Symbol>("None", body_type));
        unique_ptr<vector<unique_ptr<PatternMatch>>> match_list = make_unique<vector<unique_ptr<PatternMatch>>>();

        match_list->push_back(std::move(some_arm));
        match_list->push_back(std::move(none_arm));

        return new Match(std::move(value), std::move(match_list));
    }

    static unique_ptr<Match> when(unique_ptr<SpecNode> pattern, unique_ptr<SpecNode> value, unique_ptr<SpecNode> body) {
        return unique_ptr<Match>(raw_when(std::move(pattern), std::move(value), std::move(body)));
    }

    static Match* raw_let(string name, unique_ptr<SpecNode> value, unique_ptr<SpecNode> body,
                          shared_ptr<SpecType>typ = SpecType::UNKNOWN_TYPE) {
        unique_ptr<PatternMatch> pm = make_unique<PatternMatch>(make_unique<Symbol>(name, typ), std::move(body));
        unique_ptr<vector<unique_ptr<PatternMatch>>> match_list = make_unique<vector<unique_ptr<PatternMatch>>>();

        match_list->push_back(std::move(pm));

        return new Match(std::move(value), std::move(match_list));
    }

    static unique_ptr<Match> let(string name, unique_ptr<SpecNode> value, unique_ptr<SpecNode> body, shared_ptr<SpecType>typ = SpecType::UNKNOWN_TYPE) {
        return unique_ptr<Match>(raw_let(name, std::move(value), std::move(body), typ));
    }

private:
    const string to_string() const;

    int calc_length() const{
        int length = src->length;

        for (auto it = match_list->begin(); it != match_list->end(); it++) {
                length += (*it)->length;
        }

        return length;
    }
};

class RelyAnno: public SpecNode {
public:
    unique_ptr<SpecNode> prop;
    unique_ptr<SpecNode> body;

    RelyAnno() { throw std::invalid_argument("RelyAnno must have a prop and body"); }
    RelyAnno(unique_ptr<SpecNode>prop, unique_ptr<SpecNode>body) :
        SpecNode(body->get_type()), prop(std::move(prop)), body(std::move(body)) {}

    virtual ~RelyAnno() = default;
};

class Rely : public RelyAnno {
public:

    Rely() { throw std::invalid_argument("Rely must have a prop and body"); }
    Rely(unique_ptr<SpecNode>prop, unique_ptr<SpecNode>body) : RelyAnno(std::move(prop), std::move(body)) {
        this->length = calc_length();
    }

    bool operator==(const SpecNode& other) const {
        if (typeid(other) != typeid(Rely)) {
            return false;
        }

        return *this->prop == *((Rely&)other).prop &&
               *this->body == *((Rely&)other).body;
    }

    bool operator!=(const SpecNode& other) const {
        return !(*this == other);
    }

    void clear_z3_eval() {
        this->cached_eval = nullptr;
        this->prop->clear_z3_eval();
        this->body->clear_z3_eval();
    }

    unique_ptr<SpecNode> deep_copy() const {
        // deep copy prop and body
        unique_ptr<SpecNode> new_prop = this->prop->deep_copy();
        unique_ptr<SpecNode> new_body = this->body->deep_copy();

        auto ret = make_unique<Rely>(std::move(new_prop), std::move(new_body));

        ret->length = this->length;

        return ret;
    }

    void deep_copy(unique_ptr<SpecNode> &p) const {
        // deep copy prop and body
        unique_ptr<SpecNode> new_prop = this->prop->deep_copy();
        unique_ptr<SpecNode> new_body = this->body->deep_copy();

        p = make_unique<Rely>(std::move(new_prop), std::move(new_body));

        p->length = this->length;
    }

    void infer_type(Project &proj, unordered_map<string, shared_ptr<SpecType>> &known_types,
                optional<shared_ptr<SpecType>> &result_type);

private:
    const string to_string() const;

    int calc_length() const{
        return body->length + prop->length;
    }
};

class Anno : public RelyAnno {
public:
    Anno() { throw std::invalid_argument("Anno must have a prop and body"); }
    Anno(unique_ptr<SpecNode>prop, unique_ptr<SpecNode>body) : RelyAnno(std::move(prop), std::move(body)) {
        this->length = calc_length();
    }

    bool operator==(const SpecNode& other) const {
        if (typeid(other) != typeid(Anno)) {
            return false;
        }

        return *this->prop == *((Anno&)other).prop &&
               *this->body == *((Anno&)other).body;
    }

    bool operator!=(const SpecNode& other) const {
        return !(*this == other);
    }

    void clear_z3_eval() {
        this->cached_eval = nullptr;
        this->prop->clear_z3_eval();
        this->body->clear_z3_eval();
    }

    unique_ptr<SpecNode> deep_copy() const {
        // deep copy prop and body
        unique_ptr<SpecNode> new_prop = this->prop->deep_copy();
        unique_ptr<SpecNode> new_body = this->body->deep_copy();

        return make_unique<Anno>(std::move(new_prop), std::move(new_body));
    }

    void deep_copy(unique_ptr<SpecNode> &p) const {
        // deep copy prop and body
        unique_ptr<SpecNode> new_prop = this->prop->deep_copy();
        unique_ptr<SpecNode> new_body = this->body->deep_copy();

        p = make_unique<Anno>(std::move(new_prop), std::move(new_body));
    }

    void infer_type(Project &proj, unordered_map<string, shared_ptr<SpecType>> &known_types,
                    optional<shared_ptr<SpecType>> &result_type);
private:
    const string to_string() const;

    int calc_length() const{
        return body->length + prop->length;
    }
};

class If : public SpecNode {
public:
    unique_ptr<SpecNode> cond;
    unique_ptr<SpecNode> then_body;
    unique_ptr<SpecNode> else_body;

    If() { throw std::invalid_argument("If must have a cond, then_body, and else_body"); }
    If(unique_ptr<SpecNode>cond, unique_ptr<SpecNode>then_body, unique_ptr<SpecNode>else_body) :
        SpecNode(then_body->get_type()), cond(std::move(cond)), then_body(std::move(then_body)), else_body(std::move(else_body)) {
        this->length = calc_length();
        if (this->cond == nullptr)
            throw std::invalid_argument("If condition cannot be null");
    }

    bool operator==(const SpecNode& other) const {
        if (typeid(other) != typeid(If)) {
            return false;
        }

        return *this->cond == *((If&)other).cond &&
               *this->then_body == *((If&)other).then_body &&
               *this->else_body == *((If&)other).else_body;
    }

    bool operator!=(const SpecNode& other) const {
        return !(*this == other);
    }

    void clear_z3_eval() {
        this->cached_eval = nullptr;
        this->cond->clear_z3_eval();
        this->then_body->clear_z3_eval();
        this->else_body->clear_z3_eval();
    }

    unique_ptr<SpecNode> deep_copy() const {
        unique_ptr<SpecNode> ret;
        deep_copy_impl(ret);
        return ret;
    }

    void deep_copy(unique_ptr<SpecNode> &p) const {
        deep_copy_impl(p);
    }

    void infer_type(Project &proj, unordered_map<string, shared_ptr<SpecType>> &known_types,
                optional<shared_ptr<SpecType>> &result_type);

private:
    const string to_string() const;

    int calc_length() const{
        return then_body->length + else_body->length + cond->length;
    }

    void deep_copy_impl(unique_ptr<SpecNode> &p) const {
        unique_ptr<SpecNode> new_cond;
        unique_ptr<SpecNode> new_then_body;
        unique_ptr<SpecNode> new_else_body;

        this->cond->deep_copy(new_cond);
        this->then_body->deep_copy(new_then_body);
        this->else_body->deep_copy(new_else_body);

        p = make_unique<If>(std::move(new_cond), std::move(new_then_body), std::move(new_else_body));
    }
};

class ForallExists : public SpecNode {
public:
    unique_ptr<vector<shared_ptr<Arg>>> vars;
    unique_ptr<SpecNode> body;

    ForallExists() { throw std::invalid_argument("ForallExists must have vars and body"); }
    ForallExists(unique_ptr<vector<shared_ptr<Arg>>> vars, unique_ptr<SpecNode>body) :
        SpecNode(Prop::PROP), vars(std::move(vars)), body(std::move(body)) {
    }

    virtual ~ForallExists() = default;
};

class Forall : public ForallExists {
public:
    Forall() { throw std::invalid_argument("Forall must have vars and body"); }
    Forall(unique_ptr<vector<shared_ptr<Arg>>> vars, unique_ptr<SpecNode>body) :
        ForallExists(std::move(vars), std::move(body)) {
        this->length = calc_length();
    }

    bool operator==(const SpecNode& other) const {
        if (typeid(other) != typeid(Forall)) {
            return false;
        }

        if (this->vars->size() != ((Forall&)other).vars->size()) {
            return false;
        }

        for (int i = 0; i < this->vars->size(); i++) {
            if (*(*this->vars)[i] != *(*((Forall&)other).vars)[i]) {
                return false;
            }
        }

        return *this->body == *((Forall&)other).body;
    }

    bool operator!=(const SpecNode& other) const {
        return !(*this == other);
    }

    void clear_z3_eval() {
        this->cached_eval = nullptr;
        this->body->clear_z3_eval();
    }

    unique_ptr<SpecNode> deep_copy() const {
        // throw std::invalid_argument("Forall cannot be deep copied");
        unique_ptr<SpecNode> new_body = this->body->deep_copy();
        unique_ptr<vector<shared_ptr<Arg>>> new_vars = make_unique<vector<shared_ptr<Arg>>>();

        for (auto it = vars->begin(); it != vars->end(); it++) {
            auto new_arg = make_shared<Arg>((*it)->name, (*it)->type);
            if ((*it)->expr) {
                new_arg->expr = (*it)->expr->deep_copy_down();
            }
            new_vars->push_back(std::move(new_arg));
        }

        return make_unique<Forall>(std::move(new_vars), std::move(new_body));
    }
    void deep_copy(unique_ptr<SpecNode> &p) const {
        // throw std::invalid_argument("Forall cannot be deep copied");
        unique_ptr<SpecNode> new_body = this->body->deep_copy();
        unique_ptr<vector<shared_ptr<Arg>>> new_vars = make_unique<vector<shared_ptr<Arg>>>();

        for (auto it = vars->begin(); it != vars->end(); it++) {
            auto new_arg = make_shared<Arg>((*it)->name, (*it)->type);
            if ((*it)->expr) {
                new_arg->expr = (*it)->expr->deep_copy_down();
            }
            new_vars->push_back(std::move(new_arg));
        }

        p = make_unique<Forall>(std::move(new_vars), std::move(new_body));
    }

    void infer_type(Project &proj, unordered_map<string, shared_ptr<SpecType>> &known_types,
                optional<shared_ptr<SpecType>> &result_type);

private:
    const string to_string() const;

    int calc_length() const{
        return body->length;
    }
};

class Exists : public ForallExists {
public:
    Exists() { throw std::invalid_argument("Exists must have vars and body"); }
    Exists(unique_ptr<vector<shared_ptr<Arg>>> vars, unique_ptr<SpecNode>body) :
        ForallExists(std::move(vars), std::move(body)) {
        this->length = calc_length();
    }

    bool operator==(const SpecNode& other) const {
        if (typeid(other) != typeid(Exists)) {
            return false;
        }

        if (this->vars->size() != ((Exists&)other).vars->size()) {
            return false;
        }

        for (int i = 0; i < this->vars->size(); i++) {
            if (*(*this->vars)[i] != *(*((Exists&)other).vars)[i]) {
                return false;
            }
        }

        return *this->body == *((Exists&)other).body;
    }

    bool operator!=(const SpecNode& other) const {
        return !(*this == other);
    }

    void clear_z3_eval() {
        this->cached_eval = nullptr;
        this->body->clear_z3_eval();
    }

    unique_ptr<SpecNode> deep_copy() const {
        unique_ptr<SpecNode> new_body = this->body->deep_copy();
        unique_ptr<vector<shared_ptr<Arg>>> new_vars = make_unique<vector<shared_ptr<Arg>>>();

        for (auto it = vars->begin(); it != vars->end(); it++) {
            auto new_arg = make_shared<Arg>((*it)->name, (*it)->type);
            if ((*it)->expr) {
                new_arg->expr = (*it)->expr->deep_copy_down();
            }
            new_vars->push_back(std::move(new_arg));
        }

        return make_unique<Exists>(std::move(new_vars), std::move(new_body));
    }

    void deep_copy(unique_ptr<SpecNode> &p) const {
        unique_ptr<SpecNode> new_body = this->body->deep_copy();
        unique_ptr<vector<shared_ptr<Arg>>> new_vars = make_unique<vector<shared_ptr<Arg>>>();

        for (auto it = vars->begin(); it != vars->end(); it++) {
            auto new_arg = make_shared<Arg>((*it)->name, (*it)->type);
            if ((*it)->expr) {
                new_arg->expr = (*it)->expr->deep_copy_down();
            }
            new_vars->push_back(std::move(new_arg));
        }

        p = make_unique<Forall>(std::move(new_vars), std::move(new_body));
    }

    void infer_type(Project &proj, unordered_map<string, shared_ptr<SpecType>> &known_types,
                optional<shared_ptr<SpecType>> &result_type);

private:
    const string to_string() const;

    int calc_length() const{
        return body->length;
    }

};

class Declaration {
public:
    string name;
    shared_ptr<SpecType> type;
    int length;
    mutable string _str;

    Declaration() { throw std::invalid_argument("Declaration must have a name and type"); }
    Declaration(string name, shared_ptr<SpecType> type) :
        name(name), type(type), length(1) {}

    bool operator==(const Declaration& other) const {
        return this->name == other.name && *this->type == *other.type;
    }

    bool operator!=(const Declaration& other) const {
        return !(*this == other);
    }

    operator string() const {
        if (this->_str == "") {
            this->_str = this->to_string();
        }
        return this->_str;
    }

    shared_ptr<SpecType> get_type() const {
        return this->type;
    }

    shared_ptr<SpecValue> absf() const {
        if (this->_absf == nullptr) {
            this->_absf = this->type->declare(this->name, 0);
        }
        return this->_absf;
    }

    virtual ~Declaration() = default;

private:
    mutable shared_ptr<SpecValue> _absf;
    const string to_string() const {
        return  "Parameter " + this->name + " : " + string(*this->type) + ".";
    }
};

class Definition {
public:
    string name;
    shared_ptr<SpecType> rettype;
    unique_ptr<vector<shared_ptr<Arg>>> args;
    unique_ptr<SpecNode> body;
    int length;
    mutable string _str;
    bool deleyed_type_inference = false;


    Definition() { throw std::invalid_argument("Definition must have a name, rettype, args, and body"); }
    Definition(string name, shared_ptr<SpecType> rettype, unique_ptr<vector<shared_ptr<Arg>>> args, unique_ptr<SpecNode> body) :
        name(name), rettype(rettype), args(std::move(args)), body(std::move(body)) {
        this->length = this->body->length; // This cannot be done in the initializer list because body is moved.
    }

    Definition(Definition &other) :
        name(other.name), rettype(other.rettype), args(make_unique<vector<shared_ptr<Arg>>>(*other.args)),
        body(other.body->deep_copy()), length(other.length) {}


    bool operator==(const Definition& other) const {
        if (this->args->size() != other.args->size()) {
            return false;
        }

        if (this->name != other.name || *this->rettype != *other.rettype || *this->body != *other.body) {
            return false;
        }

        for (int i = 0; i < this->args->size(); i++) {
            if (*(*this->args)[i] != *(*other.args)[i]) {
                return false;
            }
        }

        return true;
    }

    bool operator!=(const Definition& other) const {
        return !(*this == other);
    }

    operator string() const {
        if (this->_str == "") {
            this->_str = this->to_string();
        }
        return this->_str;
    }

    shared_ptr<SpecType> get_type() const {
        if (args->size()) {
            auto args = make_shared<vector<shared_ptr<SpecType>>>();

            for (auto it = this->args->begin(); it != this->args->end(); it++) {
                args->push_back((*it)->type);
            }

            return make_shared<Function>(this->rettype, args);
        }
        return this->rettype;
    }

    void infer_type(Project &proj);

    shared_ptr<FuncValue> absf() const {
        if (this->_absf == nullptr) {
            auto arg_list = make_shared<vector<shared_ptr<SpecType>>>();

            for (auto it = this->args->begin(); it != this->args->end(); it++) {
                arg_list->push_back((*it)->type);
            }

            // func has to be wrapped in a shared_ptr because SpecType inherit from enable_shared_from_this
            auto func = make_shared<Function>(this->rettype, arg_list);

            this->_absf = static_pointer_cast<FuncValue>(func->declare(name, 0));
        }

        return this->_absf;
    }

    virtual ~Definition() = default;

private:
    mutable shared_ptr<FuncValue> _absf;
    virtual const string to_string() const;

protected:
    // Reserved for Fixpoint
    Definition(string name, shared_ptr<SpecType> rettype, unique_ptr<vector<shared_ptr<Arg>>> args) :
        name(name), rettype(rettype), args(std::move(args)), body(nullptr) {}
};

class Fixpoint : public Definition {
public:
    Fixpoint() { throw std::invalid_argument("Fixpoint must have a name, rettype, args, and body"); }
    Fixpoint(string name, shared_ptr<SpecType> rettype, unique_ptr<vector<shared_ptr<Arg>>> args, unique_ptr<SpecNode> body) :
        Definition(name, rettype, std::move(args), std::move(body)) {}
    Fixpoint(string name, shared_ptr<SpecType> rettype, unique_ptr<vector<shared_ptr<Arg>>> args) :
        Definition(name, rettype, std::move(args)) {}
    Fixpoint(Fixpoint &other) : Definition(other) {}

    z3::func_decl absf() const {

         z3::sort_vector sorts(z3ctx);
         //z3::expr_vector args(z3ctx);
         auto arg_list = make_shared<vector<shared_ptr<SpecType>>>();
         for(auto arg: *this->args) { 
            sorts.push_back(arg->type->get_z3_type());
            arg_list->push_back(arg->type);
         }
        
        auto rec_fun = z3ctx.recfun(this->name.c_str(), sorts, this->rettype->get_z3_type());
        //auto func = make_shared<Function>(this->rettype, arg_list);
        // func has to be wrapped in a shared_ptr because SpecType inherit from enable_shared_from_this
        return rec_fun;
    }

private:
    const string to_string() const;
};

namespace IRLoader{
    class IRModule;
}

class Layer {
public:
    string name;
    shared_ptr<SpecType> abs_data;
    unordered_map<string, string> ops;
    vector<string> prims;
    string code; // Temp until we ported the IRModule class
    vector<string> passthrough;
    unordered_map<string, std::set<string>> prim_deps;
    bool dummy = false;

    Layer() { throw std::invalid_argument("Layer must have a name, abs_data, ops, prims, and code"); }
    Layer(string name) : name(name) {}
    Layer(string name, unique_ptr<SpecType> abs_data, unordered_map<string, string> ops,
          vector<string> prims, string code, vector<string> passthrough) :
        name(name), abs_data(std::move(abs_data)), ops(std::move(ops)), prims(prims), code(code), passthrough(passthrough) {}
    Layer(string name, bool dummy) : name(name), dummy(dummy) {}

    shared_ptr<IRLoader::IRModule> load_module();
};

}// namespace autov
