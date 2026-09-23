#pragma once

#include <iostream>
#include <string>
#include <utility>
#include <vector>
#include <map>
#include <unordered_map>
#include <sstream>
#include <memory>
#include <cctype>
#include <optional>
#include <set>
#include <z3++.h>

namespace autov {
using std::string;
using std::vector;
using std::unique_ptr;
using std::make_unique;
using std::shared_ptr;
using std::make_shared;
using std::unordered_map;
using std::enable_shared_from_this;
using std::static_pointer_cast;

extern z3::context z3ctx;

class SpecValue;

class SpecType : public enable_shared_from_this<SpecType> {
public:
    static shared_ptr<SpecType> UNKNOWN_TYPE;

    string name;
    bool record;

    SpecType() = default;
    SpecType(string name) : name(std::move(name)), record(false) {

    }
    SpecType(string name, bool record) : name(std::move(name)), record(record) {}

    virtual z3::sort get_z3_type();
    virtual shared_ptr<SpecValue> from_z3_value(z3::expr value);
    virtual shared_ptr<SpecValue> declare(string name, int nid);

    shared_ptr<SpecType> getptr() {
        return shared_from_this();
    }

    bool operator==(const SpecType& other) const {
        return name == other.name;
    }

    bool operator!=(const SpecType& other) const {
        return name != other.name;
    }

    virtual ~SpecType() = default;

    virtual operator string() const {
        return name;
    }

    /// The name a z3 sort for this type is interned and declared under.  The
    /// same as `name` except where a type contains a machine integer: `name`
    /// is width-blind -- every integer is "Z", which is what type equality and
    /// the emitted Coq want -- while two sorts differing only in a field's
    /// width must not share an interned sort.
    virtual std::string sort_key() const {
        return name;
    }
};

class Int : public SpecType {
public:
    /// The widthless Int, used where no LLVM type supplies a width: a
    /// hand-written spec, and the terms the rules build.
    static shared_ptr<Int> INT;

    /// Bits in the LLVM type this came from, 0 when it did not come from one.
    ///
    /// The Coq name is "intN" at a width and "Z" without one.  `intN := Z`, so
    /// a value of one is convertible with a Z and every lemma over Z applies
    /// unchanged; the width is carried so that a declaration keeps it.  The z3
    /// sort is an unbounded integer, or a bitvector of this many bits under
    /// SPOQ_BV_SORTS=1; a width of 0 is an unbounded integer either way.
    unsigned bits = 0;

    /// The Coq name, when it is not the one [bits] implies: `intSizeT`.  Kept
    /// so the declaration round-trips under that name, and redefining the name
    /// changes every field declared with it.
    std::string alias;

    Int() : SpecType("Z") {}
    explicit Int(unsigned bits, std::string alias = "")
        : SpecType("Z"), bits(bits), alias(std::move(alias)) {}

    /// "intN" only when the width changes the sort, i.e. under bitvector sorts;
    /// otherwise every integer is the same sort and the key is "Z".
    std::string sort_key() const override;

    /// The interned Int of [bits].  Interned so that a type carrying a width is
    /// as cheap to pass around as the singleton, and so the shared_ptrs of one
    /// width compare equal.
    static shared_ptr<Int> of_width(unsigned bits);

    /// `intSizeT`: the integer a pointer is stored as in a record, and the
    /// type of a pointer offset, a size and a ZMap key, of kSizeTWidth bits.
    /// Its own object rather than of_width(kSizeTWidth), so that it keeps its
    /// name through a round trip.
    static shared_ptr<Int> size_t_int();

    shared_ptr<Int> getptr() {
        return static_pointer_cast<Int>(shared_from_this());
    }

    virtual z3::sort get_z3_type() override;
    virtual shared_ptr<SpecValue> from_z3_value(z3::expr value) override;
    virtual shared_ptr<SpecValue> declare(string name, int nid) override;
};
/// Unused.  LLVM floating point types map to Int::INT, matching the prelude's
/// `Float := Z`, and float operations are uninterpreted functions over it.  This
/// maps to a 64-bit IEEE sort in z3, which that prelude does not agree with, so
/// reaching for it would silently put the solver and the emitted Coq on
/// different models -- type inference used to, for every float operation.
class Float : public SpecType {
public:
    static shared_ptr<Float> FLOAT;

    Float() : SpecType("Float") {}

    shared_ptr<Float> getptr() {
        return static_pointer_cast<Float>(shared_from_this());
    }

    virtual z3::sort get_z3_type() override;
    virtual shared_ptr<SpecValue> from_z3_value(z3::expr value) override;
    virtual shared_ptr<SpecValue> declare(string name, int nid) override;
};
class String : public SpecType {
public:
    static shared_ptr<String> STRING;
    String() : SpecType("string") {}

    shared_ptr<String> getptr() {
        return static_pointer_cast<String>(shared_from_this());
    }

    virtual z3::sort get_z3_type() override;
    virtual shared_ptr<SpecValue> from_z3_value(z3::expr value) override;
    virtual shared_ptr<SpecValue> declare(string name, int nid) override;
};

class Bool : public SpecType {
public:
    static shared_ptr<Bool> BOOL;

    Bool() : SpecType("bool") {}

    shared_ptr<Bool> getptr() {
        return static_pointer_cast<Bool>(shared_from_this());
    }

    virtual z3::sort get_z3_type() override;
    virtual shared_ptr<SpecValue> from_z3_value(z3::expr value) override;
    virtual shared_ptr<SpecValue> declare(string name, int nid) override;
};

class Array : public SpecType {
public:
    shared_ptr<SpecType> elem_type;
    Array() = default;
    Array(const shared_ptr<SpecType>& elem_type) : SpecType("list_" + elem_type->name), elem_type(elem_type) {}
    std::string sort_key() const override { return "list_" + elem_type->sort_key(); }
    //Array(const Array& other) : SpecType(other.name), elem_type(std::make_unique<SpecType>(*other.elem_type)) {}

    shared_ptr<Array> getptr() {
        return static_pointer_cast<Array>(shared_from_this());
    }

    // XXX: unused?
    // virtual z3::sort get_z3_type();
    // virtual shared_ptr<SpecValue> from_z3_value(z3::expr value);
    // virtual shared_ptr<SpecValue> declare(string name, int nid);

    operator string() const {
        return "list_" + string(*elem_type);
    }
};

class Prop : public SpecType {
public:
    static shared_ptr<Prop> PROP;

    Prop() : SpecType("Prop") {}

    shared_ptr<Prop> getptr() {
        return static_pointer_cast<Prop>(shared_from_this());
    }

    virtual z3::sort get_z3_type() override;
    virtual shared_ptr<SpecValue> from_z3_value(z3::expr value) override;
    virtual shared_ptr<SpecValue> declare(string name, int nid) override;
};

class Type : public SpecType {
public:
    static shared_ptr<Type> TYPE;

    Type() : SpecType("Type") {}

    shared_ptr<Type> getptr() {
        return static_pointer_cast<Type>(shared_from_this());
    }

    virtual z3::sort get_z3_type() override {
        throw std::runtime_error("Type.get_z3_type not implemented");
    }
    virtual shared_ptr<SpecValue> from_z3_value(z3::expr value) override {
        throw std::runtime_error("Type.from_z3_value not implemented");
    }
    virtual shared_ptr<SpecValue> declare(string name, int nid) override {
        throw std::runtime_error("Type.declare not implemented");
    }
};
// finite map Z -> V
class Vector : public SpecType {
public:
    shared_ptr<SpecType> elem_type;
    Vector() = default;
    Vector(const shared_ptr<SpecType>& elem_type) : SpecType("Vec_" + elem_type->name), elem_type(elem_type) { }
    std::string sort_key() const override { return "Vec_" + elem_type->sort_key(); }

    shared_ptr<Vector> getptr() {
        return static_pointer_cast<Vector>(shared_from_this());
    }

    operator string() const {
        return "(Vec " + string(*elem_type) + ")";
    }

    virtual z3::sort get_z3_type();
    virtual shared_ptr<SpecValue> from_z3_value(z3::expr value);
    virtual shared_ptr<SpecValue> declare(string name, int nid);
};
/// A map from integers.  `ZMap.t` is indexed by a machine integer -- an
/// offset, an array index -- and its key is intSizeT; `PMap.t` is indexed by
/// a provenance, which is a Z and not a machine integer.  Both are ZMap in
/// Coq, where every integer is Z; they differ in the key sort the solver sees.
class ZMap : public SpecType {
public:
    shared_ptr<SpecType> elem_type;
    shared_ptr<SpecType> key_type;
    ZMap() = default;
    ZMap(const shared_ptr<SpecType>& elem_type, const shared_ptr<SpecType>& key_type = nullptr)
        : SpecType((key_type && key_type != Int::size_t_int() ? "PMap_" : "ZMap_") + elem_type->name),
          elem_type(elem_type), key_type(key_type ? key_type : Int::size_t_int()) {
        if (by_provenance()) pmap_used_flag() = true;
    }
    /// Whether the key is a provenance rather than a machine integer.
    bool by_provenance() const { return key_type != Int::size_t_int(); }
    std::string coq_name() const { return by_provenance() ? "PMap.t" : "ZMap.t"; }
    std::string sort_key() const override { return (by_provenance() ? "PMap_" : "ZMap_") + elem_type->sort_key(); }
    z3::sort key_sort() const { return key_type->get_z3_type(); }
    /// Whether a PMap type was built, so the Coq output defines the module.
    static bool &pmap_used_flag() { static bool used = false; return used; }

    shared_ptr<ZMap> getptr() {
        return static_pointer_cast<ZMap>(shared_from_this());
    }

    operator string() const {
        return "(" + coq_name() + " " + string(*elem_type) + ")";
    }

    virtual z3::sort get_z3_type();
    virtual shared_ptr<SpecValue> from_z3_value(z3::expr value);
    virtual shared_ptr<SpecValue> declare(string name, int nid);
};
class SMap : public SpecType {
public:
    shared_ptr<SpecType> elem_type;
    SMap() = default;
    SMap(const shared_ptr<SpecType>& elem_type) : SpecType("SMap_" + elem_type->name), elem_type(elem_type) {}
    std::string sort_key() const override { return "SMap_" + elem_type->sort_key(); }

    shared_ptr<SMap> getptr() {
        return static_pointer_cast<SMap>(shared_from_this());
    }

    operator string() const {
        return "(SMap " + string(*elem_type) + ")";
    }

    virtual z3::sort get_z3_type();
    virtual shared_ptr<SpecValue> from_z3_value(z3::expr value);
    virtual shared_ptr<SpecValue> declare(string name, int nid);
};
class Expr;
class Arg {
public:
    string name;
    shared_ptr<SpecType> type = nullptr;
    unique_ptr<Expr> expr = nullptr;
    Arg() = default;
    Arg(string name, shared_ptr<SpecType> type) : name(std::move(name)), type(std::move(type)) {}
    Arg(string name, unique_ptr<Expr> expr) : name(std::move(name)) {
        this->expr = std::move(expr);
    }

    shared_ptr<Arg> getptr() {
        return shared_ptr<Arg>(this);
    }

    bool operator==(const Arg& other) const {
        return name == other.name && type == other.type;
    }

    bool operator!=(const Arg& other) const {
        return name != other.name || type != other.type;
    }

    operator string() const {
        return to_string();
    }

    std::string to_string() const;
};

class Struct : public SpecType {
public:
    static shared_ptr<Struct> Ptr;
    static unordered_map<string, z3::sort> created_z3_types;

    shared_ptr<vector<shared_ptr<Arg>>> elems;
    std::map<string, shared_ptr<SpecType>> elems_map;
    Struct() = default;
    Struct(string name, const shared_ptr<vector<shared_ptr<Arg>>>& elems) : SpecType(std::move(name)), elems(elems) {
        for (const auto &elem : *elems) { // Fix: Use emplace instead of assignment to insert elements into elems_map
            elems_map.emplace(elem->name, elem->type);
        }
    }

    shared_ptr<Struct> getptr() {
        return static_pointer_cast<Struct>(shared_from_this());
    }

    string define() const;
    z3::func_decl get_recognizer(string constr);
    virtual z3::sort get_z3_type() override;
    virtual shared_ptr<SpecValue> from_z3_value(z3::expr value) override;
    virtual shared_ptr<SpecValue> declare(string name, int nid) override;
    shared_ptr<SpecValue> construct(vector<shared_ptr<SpecValue>> &elems);
};

class IndConstr {
public:
    string name;
    shared_ptr<vector<shared_ptr<Arg>>> args;
    IndConstr() = default;
    IndConstr(string name, shared_ptr<vector<shared_ptr<Arg>>> args) : name(std::move(name)), args(std::move(args)) {}

    shared_ptr<IndConstr> getptr() {
        return shared_ptr<IndConstr>(this);
    }

    operator string() const;
};

class Option;
class List;

class Inductive : public SpecType {
public:
    static shared_ptr<Inductive> Nat;
    static unordered_map<string, z3::sort> created_z3_types;

    shared_ptr<vector<shared_ptr<IndConstr>>> constrs;
    std::map<string, shared_ptr<vector<shared_ptr<Arg>>>> constr;
    std::map<string, shared_ptr<SpecType>> arg_type;
    shared_ptr<std::map<string, z3::func_decl>> z3_constructors;
    //shared_ptr<std::map<string, z3::func_decl>> z3_accessors;

    Inductive() = default;
    Inductive(string name, const shared_ptr<vector<shared_ptr<IndConstr>>>& constrs) : SpecType(std::move(name)), constrs(constrs) {
        for (const auto &c : *constrs) {
            constr[c->name] = c->args;
            for (const auto &arg : *c->args) {
                arg_type[arg->name]= arg->type;
            }
        }
    }

    shared_ptr<Inductive> getptr() {
        return static_pointer_cast<Inductive>(shared_from_this());
    }

    string define() const;

    shared_ptr<SpecValue> construct(string constr, vector<shared_ptr<SpecValue>> args);

    int get_constr_index(const string& constr);

    z3::func_decl get_constr(const string& constr);

    z3::func_decl get_recognizer(const string& constr);

    z3::func_decl_vector get_accessors(const string& constr);

    virtual z3::sort get_z3_type();
    virtual shared_ptr<SpecValue> from_z3_value(z3::expr value);
    virtual shared_ptr<SpecValue> declare(string name, int nid);
};

extern Inductive Nat;

class Function : public SpecType {
public:
    shared_ptr<SpecType> rettype;
    shared_ptr<vector<shared_ptr<SpecType>>> args;
    Function(const shared_ptr<SpecType>& rettype, const shared_ptr<vector<shared_ptr<SpecType>>>& args);

    operator string() const;

    shared_ptr<Function> getptr() {
        return static_pointer_cast<Function>(shared_from_this());
    }

    //virtual z3::sort get_z3_type();
    virtual shared_ptr<SpecValue> from_z3_value(z3::expr value);
    virtual shared_ptr<SpecValue> declare(string name, int nid);
};

class Tuple : public Struct {
public:
    shared_ptr<vector<shared_ptr<SpecType>>> types;
    Tuple(const shared_ptr<vector<shared_ptr<SpecType>>>& types);

    std::string sort_key() const override;

    operator string() const;

    shared_ptr<Tuple> getptr() {
        return static_pointer_cast<Tuple>(shared_from_this());
    }
};

class List : public SpecType {
public:
    shared_ptr<SpecType> elem_type;
    static unordered_map<string, z3::sort> created_z3_types;

    List(const shared_ptr<SpecType>& elem_type) :
        SpecType("list_" + elem_type->name),
        elem_type(elem_type) {
            auto elem_sort = elem_type->get_z3_type();
            created_z3_types.emplace(sort_key(), z3ctx.seq_sort(elem_sort));
        }

    std::string sort_key() const override { return "list_" + elem_type->sort_key(); }

    shared_ptr<List> getptr() {
        return static_pointer_cast<List>(shared_from_this());
    }

    operator string() const {
        return "list " + string(*elem_type);
    }

    // z3::func_decl concat_func() {
    //     return z3::function((name + "_concat").c_str(), get_z3_type(), get_z3_type(), get_z3_type());
    // }
};

class Option : public Inductive {
public:
    shared_ptr<SpecType> elem_type;
    Option(const shared_ptr<SpecType>& elem_type) :
        Inductive(
            "Option_" + elem_type->name,
            make_shared<vector<shared_ptr<IndConstr>>>(
                std::initializer_list<shared_ptr<IndConstr>>{
                    make_shared<IndConstr>(
                        some_name(elem_type),
                        make_shared<vector<shared_ptr<Arg>>>(
                            std::initializer_list<shared_ptr<Arg>>{
                                make_shared<Arg>("value_" + elem_type->sort_key(), elem_type)
                            }
                        )
                    ),
                    make_shared<IndConstr>(none_name(elem_type), make_shared<vector<shared_ptr<Arg>>>(vector<shared_ptr<Arg>>()))
                }
            )
        ),
        elem_type(elem_type) {}

    std::string sort_key() const override { return "Option_" + elem_type->sort_key(); }

    /// The z3 constructor names.  Keyed like the sort, so that an option of an
    /// int32 and an option of a Z are distinct datatypes under bitvector sorts.
    static std::string some_name(const shared_ptr<SpecType> &elem) { return "Some_" + elem->sort_key(); }
    static std::string none_name(const shared_ptr<SpecType> &elem) { return "None_" + elem->sort_key(); }
    std::string some_name() const { return some_name(elem_type); }
    std::string none_name() const { return none_name(elem_type); }

    shared_ptr<Option> getptr() {
        return static_pointer_cast<Option>(shared_from_this());
    }

    operator string() const {
        return "(option " + string(*elem_type) + ")";
    }

};

/////////////////////
// Spec Value
////////////////////

class SpecValue {
public:
    shared_ptr<SpecType> typ;
    z3::expr value;

    SpecValue(shared_ptr<SpecType> typ, unsigned long value, bool sign = false) : typ(std::move(typ)), value(z3ctx.bool_val(false)) {
        if(sign) {
            this->value = z3ctx.int_val((long)value);
        } else {
            this->value = z3ctx.int_val(value);
        }
    }
    SpecValue(shared_ptr<SpecType> typ, long value, bool sign = false) : typ(std::move(typ)), value(z3ctx.int_val(value)) {}
    SpecValue(shared_ptr<SpecType> typ, bool value) : typ(std::move(typ)), value(z3ctx.bool_val(value)) {}
    SpecValue(shared_ptr<SpecType> typ, const string& value) : typ(std::move(typ)), value(z3ctx.string_val(value.c_str())) {}
    SpecValue(shared_ptr<SpecType> typ, double value) : typ(std::move(typ)), value(z3ctx.fpa_val(value)) {}
    SpecValue(shared_ptr<SpecType> typ, z3::expr value) : typ(std::move(typ)), value(std::move(value)) {
        if (typ == Bool::BOOL && value.is_int()){
            value = (value != 0);
        }
    }

    shared_ptr<SpecType> get_type() const { return typ; }
    z3::expr get_z3_value() const { return value; }

    operator string() const {
        return "Value(" + string(*typ) + ", " + value.to_string() + ")";
    }

    virtual ~SpecValue() = default;
};

/* -- bitvector encoding ------------------------------------------------------
 *
 * A value that came from an LLVM type carries its width in Int::bits, and under
 * SPOQ_BV_SORTS=1 is declared at a bitvector sort of that width rather than as
 * an unbounded integer.  The memory model is typed to match: a loaded word is
 * int64, a pointer offset, a size and a ZMap key are intSizeT.  A Z declared
 * in a .main.v carries no width either way, so where one meets a width the
 * operations below reconcile their operands first.
 *
 * The bitwise operations -- `a & b` and the rest -- are uninterpreted functions
 * over Z, so the solver knows nothing about them at all.  Where neither operand
 * carries a width, one is assumed, the encoding is guarded by both operands
 * fitting in it, and the uninterpreted function stands outside, which keeps it
 * sound on a value no width bounds.  SPOQ_Z3_BITVEC=0 turns that off.
 *
 * A width operation -- `wrapN`, `unsN`, `sextN_M`, `zextN_M` -- is
 * extract/sext/zext on a bitvector and the arithmetic it denotes on an
 * integer, never a round trip through
 * int2bv/bv2int, because a round trip does not compose over integer arithmetic:
 * `wrap32 (wrap32 (n+5) + 5) = wrap32 (10+n)` is instant as native bitvectors
 * and does not finish in a minute as a round trip, with or without a range on
 * n.  A bitwise round trip does compose, which is why that one stays.
 */

/// Width assumed for a bitwise operation, whose operands carry none.  One wider
/// than any width the translation reduces, so a value at a reduced width fits.
constexpr unsigned kBitwiseWidth = 64;

/// Whether the bitvector encoding of the bitwise operations is on.
bool z3_bitvec_bitwise_enabled();

/// Whether a width-carrying integer is declared as a bitvector sort.  Off
/// unless SPOQ_BV_SORTS=1.
bool z3_bv_sorts_enabled();

/// A width operation, by name.  `wrapN` reads the low N bits signed and `unsN`
/// unsigned, both at width N; `sextN_M` and `zextN_M` read an N-bit value
/// signed or unsigned into M bits.  N is [bits], M is [to].
struct WidthOp {
    bool is_signed;
    unsigned bits;
    unsigned to;
};

/// [name] decoded as a width operation; nothing when it is not one.
std::optional<WidthOp> parse_width_op(const std::string &name);

/// The z3 term [op] denotes when it names a width operation; nothing otherwise.
std::optional<z3::expr> width_op_value(const std::string &op, const z3::expr &x);

/// [a] and [b] brought to one sort, for an operation that needs them to agree.
///
/// A value with an LLVM width is a bitvector; one from a .main.v declaration --
/// an oracle result, a record field, an offset -- is an integer, and the two
/// meet constantly.  A literal takes whichever sort the other operand has,
/// exactly, which covers most of the mixing.  Anything else falls back to the
/// integers rather than converting into the bitvectors: a bv2int at a boundary
/// composes, an int2bv wrapped around arithmetic does not.
std::pair<z3::expr, z3::expr> reconcile_sorts(const z3::expr &a, const z3::expr &b);

/// [e] in sort [want], when the two differ over being a bitvector or a width.
///
/// An application's domain comes from its declaration -- a .main.v Parameter is
/// a Z, a datatype field is whatever type first built it -- while the argument
/// comes from the term and may carry an LLVM width.  A bitvector going into a Z
/// slot is converted with bv2int.
///
/// A Z term never becomes a bitvector: that is an error naming the slot, because
/// the argument is usually arithmetic and the solver cannot reason through
/// int2bv around it.  Only an integer literal that fits the width is re-typed,
/// which is exact and costs the solver nothing.  [name] identifies the function,
/// record or constructor for the error.
z3::expr coerce_to_sort(const z3::expr &e, const z3::sort &want, const char *site = "?",
                        const std::string &name = "");

/// 2^[e] at Int sort.  Z3's power is real-valued over the integers.
z3::expr pow2_int(const z3::expr &e);

/// The widest machine integer the encoding supports.  A bitvector sort, an
/// IntConst holding 2^bits, and the bitwise encoding are all bounded by it.
constexpr unsigned kMaxIntWidth = 64;

/// Width of `intSizeT`, the integer a pointer is stored as in a record.  The one
/// place to change that representation.  64 today, so it is the same sort as
/// int64 and a pointer word meets the memory's int64 slots with no conversion.
constexpr unsigned kSizeTWidth = 64;

/// The width `intN` names, when [name] is one of those.
inline std::optional<unsigned> int_type_width(const std::string &name) {
    if (name.rfind("int", 0) != 0 || name.size() <= 3) return std::nullopt;
    unsigned bits = 0;
    for (size_t i = 3; i < name.size(); i++) {
        if (!std::isdigit(static_cast<unsigned char>(name[i]))) return std::nullopt;
        bits = bits * 10 + unsigned(name[i] - '0');
        if (bits > kMaxIntWidth) return std::nullopt;
    }
    return bits >= 1 ? std::optional<unsigned>(bits) : std::nullopt;
}

/// The Coq type [t] is written as: `intN` for a machine integer that carries a
/// width, and the type's own name otherwise.  Used where a declaration is
/// emitted, so that the width survives a round trip through spoq; `name` stays
/// "Z" at every width because it is an interning key and an identifier
/// fragment, and every machine integer is the same Coq type.
std::string coq_type_name(const shared_ptr<SpecType> &t);

/// Whether [t] is a machine integer, at any width or none.
bool is_int_type(const shared_ptr<SpecType> &t);

/// Whether [t] is a ZMap whose elements are machine integers.
bool is_int_zmap_type(const shared_ptr<SpecType> &t);

/// Widths Int::of_width has been asked for, so the generated Coq can define
/// `intN := Z` for each one a module happens to use.
const std::set<unsigned> &int_widths_used();

/// `a = b` and `a <> b` with the operands brought to one sort first.  A raw ==
/// on two z3 values throws when one carries a width and the other does not.
inline z3::expr z3_eq(const z3::expr &a, const z3::expr &b) {
    auto const p = reconcile_sorts(a, b);
    return p.first == p.second;
}
inline z3::expr z3_ne(const z3::expr &a, const z3::expr &b) {
    auto const p = reconcile_sorts(a, b);
    return p.first != p.second;
}

enum class BitOp { And, Or, Xor };

/// [op] on [a] and [b].  Two bitvectors are the operation at their width; two
/// integers are [kBitwiseWidth]-bit vectors where both fit, and [fallback]
/// applied where they do not.
z3::expr bv_bitwise(BitOp op, const z3::expr &a, const z3::expr &b,
                    const z3::func_decl &fallback);

extern z3::func_decl land_func;
extern z3::func_decl lor_func;
extern z3::func_decl lxor_func;
extern z3::func_decl lnot_func;
extern z3::func_decl testbit_func;
extern z3::func_decl setbit_func;
extern z3::func_decl clearbit_func;

class BoolValue : public SpecValue {
public:
    BoolValue(bool value) : SpecValue(Bool::BOOL, value) {}
    BoolValue(z3::expr value) : SpecValue(Bool::BOOL, std::move(value)) {}

    shared_ptr<BoolValue> eq(const shared_ptr<BoolValue>& other) {
        return make_shared<BoolValue>((value == other->value).simplify());
    }
    shared_ptr<BoolValue> ne(const shared_ptr<BoolValue>& other) {
        return make_shared<BoolValue>((value != other->value).simplify());
    }
    shared_ptr<BoolValue> andb(const shared_ptr<BoolValue>& other) {
        return make_shared<BoolValue>((value && other->value).simplify());
    }
    shared_ptr<BoolValue> orb(const shared_ptr<BoolValue>& other) {
        return make_shared<BoolValue>((value || other->value).simplify());
    }
    shared_ptr<BoolValue> negb() {
        return make_shared<BoolValue>(!value);
    }
    shared_ptr<BoolValue> implies(const shared_ptr<BoolValue>& other) {
        return make_shared<BoolValue>(z3::implies(value, other->value).simplify());
    }
    shared_ptr<BoolValue> xorb(const shared_ptr<BoolValue>& other) {
        return make_shared<BoolValue>((value ^ other->value).simplify());
    }
};


/// The Int whose sort [value] has: the width of a bitvector, none otherwise.
shared_ptr<SpecType> int_type_of(const z3::expr &value);

/// k when [e] is the bitvector literal 2^k with 0 <= k < width; nothing
/// otherwise.
std::optional<unsigned> pow2_exponent(const z3::expr &e);

class IntValue : public SpecValue {
public:
    IntValue(unsigned long value, bool sign = false) : SpecValue(Int::INT, value, sign) {
    }
    IntValue(long value, bool sign = false) : SpecValue(Int::INT, value, sign) {
    }
    /// Typed by the expression's sort, so that a bitvector value reports its
    /// width.  A variable bound to it -- a pattern, a `when` -- is declared from
    /// this type, and a widthless one would declare an unbounded integer that
    /// the bitvector then has to be converted into.
    IntValue(const z3::expr &value) : SpecValue(int_type_of(value), value) {
    }


    shared_ptr<IntValue> neg() { return make_shared<IntValue>((-value).simplify()); }
    shared_ptr<IntValue> add(const shared_ptr<IntValue>& other) {
        auto const [a, b] = reconcile_sorts(value, other->value);
        return make_shared<IntValue>((a + b).simplify());
    }
    shared_ptr<IntValue> sub(const shared_ptr<IntValue>& other) {
        auto const [a, b] = reconcile_sorts(value, other->value);
        return make_shared<IntValue>((a - b).simplify());
    }
    shared_ptr<IntValue> mul(const shared_ptr<IntValue>& other) {
        auto const [a, b] = reconcile_sorts(value, other->value);
        return make_shared<IntValue>((a * b).simplify());
    }
    /// Z.div and Z.modulo round towards negative infinity.  On a bitvector, a
    /// divisor 2^k makes both exact and cheap: the quotient is an arithmetic
    /// shift and the remainder is the low k bits, where bvsdiv and bvsmod
    /// would be bit-blasted.
    shared_ptr<IntValue> div(const shared_ptr<IntValue>& other) {
        auto const [a, b] = reconcile_sorts(value, other->value);
        if (auto const k = pow2_exponent(b)) return make_shared<IntValue>(z3::ashr(a, *k).simplify());
        return make_shared<IntValue>((a / b).simplify());
    }
    shared_ptr<IntValue> mod(const shared_ptr<IntValue>& other) {
        auto const [a, b] = reconcile_sorts(value, other->value);
        if (auto const k = pow2_exponent(b)) {
            auto const w = a.get_sort().bv_size();
            if (*k == 0) return make_shared<IntValue>(z3ctx.bv_val(0, w));
            return make_shared<IntValue>(z3::zext(a.extract(*k - 1, 0), w - *k).simplify());
        }
        return make_shared<IntValue>((z3::mod(a, b)).simplify());
    }
    /// Left shift: bvshl on bitvectors, multiply by a power of two on integers.
    shared_ptr<IntValue> shiftl(const shared_ptr<IntValue>& other) {
        auto const [a, b] = reconcile_sorts(value, other->value);
        return make_shared<IntValue>((a.is_bv() ? z3::shl(a, b) : a * pow2_int(b)).simplify());
    }
    /// Right shift: bvashr on bitvectors, divide by a power of two on integers.
    /// Both round towards negative infinity.  A logical shift reaches here with
    /// its operand already converted to the unsigned residue.
    shared_ptr<IntValue> shiftr(const shared_ptr<IntValue>& other) {
        auto const [a, b] = reconcile_sorts(value, other->value);
        return make_shared<IntValue>((a.is_bv() ? z3::ashr(a, b) : a / pow2_int(b)).simplify());
    }
    shared_ptr<IntValue> xorb(const shared_ptr<IntValue>& other) {
        auto const [a, b] = reconcile_sorts(value, other->value);
        return make_shared<IntValue>((a ^ b).simplify());
    }
    shared_ptr<IntValue> land(const shared_ptr<IntValue>& other) { return make_shared<IntValue>(bv_bitwise(BitOp::And, value, other->value, land_func)); }
    shared_ptr<IntValue> lor(const shared_ptr<IntValue>& other) { return make_shared<IntValue>(bv_bitwise(BitOp::Or, value, other->value, lor_func)); }
    shared_ptr<IntValue> lxor(const shared_ptr<IntValue>& other) { return make_shared<IntValue>(bv_bitwise(BitOp::Xor, value, other->value, lxor_func)); }
    shared_ptr<IntValue> lnot() { return make_shared<IntValue>(lnot_func(value)); }
    shared_ptr<IntValue> setbit(const shared_ptr<IntValue>& other) { return make_shared<IntValue>(setbit_func(value, other->value)); }
    shared_ptr<IntValue> clearbit(const shared_ptr<IntValue>& other) { return make_shared<IntValue>(clearbit_func(value, other->value)); }
    shared_ptr<BoolValue> testbit(const shared_ptr<IntValue>& other) { return make_shared<BoolValue>(testbit_func(value, other->value)); }
    shared_ptr<BoolValue> eq(const shared_ptr<IntValue>& other) {
        auto const [a, b] = reconcile_sorts(value, other->value);
        return make_shared<BoolValue>((a == b).simplify());
    }
    shared_ptr<BoolValue> ne(const shared_ptr<IntValue>& other) {
        auto const [a, b] = reconcile_sorts(value, other->value);
        return make_shared<BoolValue>((a != b).simplify());
    }
    shared_ptr<BoolValue> lt(const shared_ptr<IntValue>& other) {
        auto const [a, b] = reconcile_sorts(value, other->value);
        return make_shared<BoolValue>((a < b).simplify());
    }
    shared_ptr<BoolValue> le(const shared_ptr<IntValue>& other) {
        auto const [a, b] = reconcile_sorts(value, other->value);
        return make_shared<BoolValue>((a <= b).simplify());
    }
    shared_ptr<BoolValue> gt(const shared_ptr<IntValue>& other) {
        auto const [a, b] = reconcile_sorts(value, other->value);
        return make_shared<BoolValue>((a > b).simplify());
    }
    shared_ptr<BoolValue> ge(const shared_ptr<IntValue>& other) {
        auto const [a, b] = reconcile_sorts(value, other->value);
        return make_shared<BoolValue>((a >= b).simplify());
    }
    shared_ptr<BoolValue> to_bool() { return make_shared<BoolValue>(value != 0); }
};
class FloatValue : public SpecValue {
public:
    FloatValue(double value) : SpecValue(Float::FLOAT, value) {}
    FloatValue(z3::expr value) : SpecValue(Float::FLOAT, std::move(value)) {}


    // shared_ptr<FloatValue> neg() { return make_shared<FloatValue>((-value).simplify()); }
    // shared_ptr<FloatValue> add(shared_ptr<FloatValue> other) { return make_shared<FloatValue>((value + other->value).simplify()); }
    // shared_ptr<FloatValue> sub(shared_ptr<FloatValue> other) { return make_shared<FloatValue>((value - other->value).simplify()); }
    // shared_ptr<FloatValue> mul(shared_ptr<FloatValue> other) { return make_shared<FloatValue>((value * other->value).simplify()); }
    // shared_ptr<FloatValue> div(shared_ptr<FloatValue> other) { return make_shared<FloatValue>((value / other->value).simplify()); }
    // shared_ptr<FloatValue> mod(shared_ptr<FloatValue> other) {return make_shared<FloatValue>((value % other->value).simplify()); }
    // shared_ptr<FloatValue> shiftl(shared_ptr<FloatValue> other) { return make_shared<FloatValue>(( value * z3::pw(2, other->value)).simplify()); }
    // shared_ptr<FloatValue> shiftr(shared_ptr<FloatValue> other) { return make_shared<FloatValue>(( value / z3::pw(2, other->value)).simplify()); }
    // shared_ptr<FloatValue> xorb(shared_ptr<FloatValue> other) { return make_shared<FloatValue>((value ^ other->value).simplify()); }
    // shared_ptr<FloatValue> land(shared_ptr<FloatValue> other) { return make_shared<FloatValue>(land_func(value, other->value)); }
    // shared_ptr<FloatValue> lor(shared_ptr<FloatValue> other) { return make_shared<FloatValue>(lor_func(value, other->value)); }
    // shared_ptr<FloatValue> lxor(shared_ptr<FloatValue> other) { return make_shared<FloatValue>(lxor_func(value, other->value)); }
    // shared_ptr<FloatValue> lnot() { return make_shared<FloatValue>(lnot_func(value)); }
    // shared_ptr<FloatValue> setbit(shared_ptr<FloatValue> other) { return make_shared<FloatValue>(setbit_func(value, other->value)); }
    // shared_ptr<FloatValue> clearbit(shared_ptr<FloatValue> other) { return make_shared<FloatValue>(clearbit_func(value, other->value)); }
    // shared_ptr<BoolValue> testbit(shared_ptr<FloatValue> other) { return make_shared<BoolValue>(testbit_func(value, other->value)); }
    // shared_ptr<BoolValue> eq(shared_ptr<FloatValue> other) { return make_shared<BoolValue>((value == other->value).simplify()); }
    // shared_ptr<BoolValue> ne(shared_ptr<FloatValue> other) { return make_shared<BoolValue>((value != other->value).simplify()); }
    // shared_ptr<BoolValue> lt(shared_ptr<FloatValue> other) { return make_shared<BoolValue>((value < other->value).simplify()); }
    // shared_ptr<BoolValue> le(shared_ptr<FloatValue> other) { return make_shared<BoolValue>((value <= other->value).simplify()); }
    // shared_ptr<BoolValue> gt(shared_ptr<FloatValue> other) { return make_shared<BoolValue>((value > other->value).simplify()); }
    // shared_ptr<BoolValue> ge(shared_ptr<FloatValue> other) { return make_shared<BoolValue>((value >= other->value).simplify()); }
};
class StringValue : public SpecValue {
public:
    StringValue(const string& value) : SpecValue(String::STRING, std::move(value)) {}
    StringValue(z3::expr value) : SpecValue(String::STRING, std::move(value)) {}

    shared_ptr<BoolValue> eq(const shared_ptr<StringValue>& other) { return make_shared<BoolValue>((value == other->value).simplify()); }
    shared_ptr<BoolValue> ne(const shared_ptr<StringValue>& other) { return make_shared<BoolValue>((value != other->value).simplify()); }
};

class VectorValue : public SpecValue {
public:
    VectorValue(const shared_ptr<SpecType>& typ, const z3::expr& value) : SpecValue(typ, value) {
        assert(value.get_sort().to_string() == typ->get_z3_type().to_string());
    }

    shared_ptr<SpecValue> get(const shared_ptr<IntValue>& key) {
        return dynamic_cast<Vector *>(typ.get())->elem_type->from_z3_value(value[key->value].simplify());
    }

    shared_ptr<VectorValue> set(const shared_ptr<IntValue>& key, const shared_ptr<SpecValue>& value) {
        return make_shared<VectorValue>(typ, z3::store(this->value, key->value, value->value).simplify());
    }

    shared_ptr<BoolValue> eq(const shared_ptr<VectorValue>& other) {
        return make_shared<BoolValue>((value == other->value).simplify());
    }
};
class ZMapValue : public SpecValue {
public:
    ZMapValue(const shared_ptr<SpecType>& typ, const z3::expr& value) : SpecValue(typ, value) {
        assert(value.get_sort().to_string() == typ->get_z3_type().to_string());
    }

    shared_ptr<SpecValue> get(const shared_ptr<IntValue>& key) {
        auto const k = coerce_to_sort(key->value, value.get_sort().array_domain(), "zmap index");
        return dynamic_cast<ZMap *>(typ.get())->elem_type->from_z3_value(value[k].simplify());
    }

    shared_ptr<ZMapValue> set(const shared_ptr<IntValue>& key, const shared_ptr<SpecValue>& value) {
        auto const k = coerce_to_sort(key->value, this->value.get_sort().array_domain(), "zmap index");
        auto const v = coerce_to_sort(value->value, this->value.get_sort().array_range(), "zmap value");
        return make_shared<ZMapValue>(typ, z3::store(this->value, k, v).simplify());
    }

    shared_ptr<BoolValue> eq(const shared_ptr<ZMapValue>& other) {
        return make_shared<BoolValue>((value == other->value).simplify());
    }
};
class SMapValue : public SpecValue {
public:
    SMapValue(shared_ptr<SpecType> typ, z3::expr value) : SpecValue(std::move(typ), std::move(value)) {}

    shared_ptr<SpecValue> get(const shared_ptr<StringValue>& key) {
        return dynamic_cast<SMap *>(typ.get())->elem_type->from_z3_value(value[key->value].simplify());
    }

    shared_ptr<SMapValue> set(const shared_ptr<StringValue>& key, const shared_ptr<SpecValue>& value) {
        return make_shared<SMapValue>(typ, z3::store(this->value, key->value, value->value).simplify());
    }

    shared_ptr<BoolValue> eq(const shared_ptr<SMapValue>& other) {
        return make_shared<BoolValue>((value == other->value).simplify());
    }
};
class FuncValue : public SpecValue {
public:
    z3::func_decl z3_func;

    FuncValue(const shared_ptr<SpecType>& typ, z3::expr value) : SpecValue(typ, std::move(value)), z3_func(z3ctx.function("unknown", 0, nullptr, z3ctx.bool_sort())) {
        vector<z3::sort> arg_types;
        auto const ftyp = static_pointer_cast<Function>(typ);
        for (const auto &arg : *ftyp->args) {
            arg_types.push_back(arg->get_z3_type());
        }
        auto const __func_call_str =  this->value.to_string() + "_call";
        auto func_call_str = __func_call_str.c_str();
        z3_func = z3ctx.function(z3ctx.str_symbol(func_call_str), arg_types.size(), arg_types.data(), ftyp->rettype->get_z3_type());
    }


    shared_ptr<SpecValue> call(vector<shared_ptr<SpecValue>> args) {
        vector<z3::expr> z3_args;

        for (const auto &arg : args) {
            auto const at = z3_args.size() < z3_func.arity() ? z3_args.size() : z3_func.arity() - 1;
            z3_args.push_back(coerce_to_sort(arg->get_z3_value(), z3_func.domain(at), "function call", z3_func.name().str()));
            // A hack to not crash on unsupported varargs stubs
            if(z3_args.size() == z3_func.arity()){
                if(args.size() > z3_args.size()){
                    z3_args.pop_back();
                    z3_args.push_back(args.at(args.size()-1)->get_z3_value());
                }
                break;
            }
        }
        return static_pointer_cast<Function>(typ)->rettype->from_z3_value(z3_func(z3_args.size(), z3_args.data()));
    }
};

class StructValue : public SpecValue {
public:
    StructValue(shared_ptr<SpecType> typ, z3::expr value) : SpecValue(std::move(typ), std::move(value)) {}

    shared_ptr<SpecValue> get(string key);
    shared_ptr<SpecValue> get(int key);
    shared_ptr<StructValue> set(string key, const shared_ptr<SpecValue>& value);
    shared_ptr<StructValue> set(int key, const shared_ptr<SpecValue>& value);

    shared_ptr<BoolValue> eq(const shared_ptr<StructValue>& other) {
        return make_shared<BoolValue>((value == other->value).simplify());
    }
};

class IndValue : public SpecValue {
public:
    z3::func_decl constructor;
    z3::func_decl_vector accessors;
    IndValue(shared_ptr<SpecType> typ, const z3::expr& value) :
        SpecValue(std::move(typ), value), constructor(value.get_sort().constructors()[0]), accessors(z3ctx) {
            auto const css = value.get_sort().constructors();
            for (auto cs :css) {
                for (const auto &acc : cs.accessors()) {
                    accessors.push_back(acc);
                }
            }
    };

    shared_ptr<SpecValue> get(const string& key);
    // shared_ptr<IndValue> set(string key, shared_ptr<SpecValue> value);
    //shared_ptr<IndValue> concat(shared_ptr<IndValue> other);

    shared_ptr<BoolValue> eq(const shared_ptr<IndValue>& other) {
        return make_shared<BoolValue>((value == other->value).simplify());
    }
};

class ListValue : public SpecValue {
public:
    ListValue(const shared_ptr<SpecType>& typ, const z3::expr& value) : SpecValue(typ, value) {
        // `typ` should be a List type
        assert(dynamic_cast<List *>(typ.get()) != nullptr);
        // `value` should be a Z3 sequence
        std::cout << "value: " << value << std::endl;
        assert(value.is_seq());
    }


    shared_ptr<SpecValue> append(const shared_ptr<SpecValue>& other);


    shared_ptr<SpecValue> concat(const shared_ptr<SpecValue>& other);

    /** Return the length of the list.
     */
    shared_ptr<SpecValue> list_len() {
        auto const len_val = z3::expr(z3ctx, Z3_mk_seq_length(z3ctx, value));

        return make_shared<IntValue>(len_val);
    }

    /** Return whether the list is empty.
     *
     * Z3 does not have a built-in function to check if a sequence is empty,
     * so we need to check if the length is 0.
     */
    shared_ptr<BoolValue> is_empty() {
        auto const len_val = z3::expr(z3ctx, Z3_mk_seq_length(z3ctx, value));
        auto const is_empty_val = z3::expr(z3ctx, Z3_mk_eq(z3ctx, len_val, z3ctx.int_val(0)));

        return make_shared<BoolValue>(is_empty_val);
    }

    /** Create an empty list.
    */
    static shared_ptr<SpecValue> empty(const shared_ptr<SpecType>& typ) {
        auto const elem_sort = typ->get_z3_type();
        auto const empty_val = z3::expr(z3ctx, Z3_mk_seq_empty(z3ctx, elem_sort));

        return make_shared<ListValue>(typ, empty_val);
    }

    /** Check whether two lists are equal, returns a boolean value.
     */
    shared_ptr<BoolValue> eq(const shared_ptr<ListValue>& other) {
        return make_shared<BoolValue>((value == other->value).simplify());
    }

    /** Check whether `other` is in the list, returns a boolean value.
     */
    // shared_ptr<SpecValue> in(shared_ptr<SpecValue> other) {
    //     // If the type is an inductive type, we use pattern matching
    // }
};

shared_ptr<SpecValue> int_to_ptr();
shared_ptr<SpecValue> ptr_to_int();
shared_ptr<SpecValue> z_to_nat();

} // namespace autov
