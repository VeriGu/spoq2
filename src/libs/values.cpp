#include <cstdio>
#include <cstdlib>
#include <map>
#include <string>
#include <utility>
#include <vector>
#include <map>
#include <unordered_map>
#include <utils.h>
#include <values.h>
#include <limits>
#include <sstream>
#include <z3++.h>

namespace autov {
using std::string;
using std::vector;
using std::unique_ptr;
using std::make_unique;
using std::shared_ptr;
using std::make_shared;
using std::unordered_map;


z3::context z3ctx;

unordered_map<string, z3::sort> Inductive::created_z3_types;
unordered_map<string, z3::sort> Struct::created_z3_types;
unordered_map<string, z3::sort> List::created_z3_types;

/// SPOQ_Z3_BITVEC, read once.
static const std::string &bitvec_setting() {
    static std::string const s = [] {
        const char *e = std::getenv("SPOQ_Z3_BITVEC");
        return std::string(e ? e : "");
    }();
    return s;
}

bool z3_bitvec_bitwise_enabled() { return bitvec_setting() != "0"; }

/// A value with an LLVM width is declared as a bitvector of that width rather
/// than converted at each use.  Off by default; SPOQ_BV_SORTS=1 turns it on.
///
/// The two encodings give the same verdicts, so this is not a choice about what
/// is proved.  It is off because it is incomplete: a value declared in a
/// .main.v is a Z and carries no width, so it meets a width-carrying one
/// constantly and reconcile_sorts drops both back to the integers.  Every such
/// meeting is a bv2int or an int2bv the solver cannot see through, and until
/// the declarations carry widths there are more of them than the bitvectors
/// save.  Giving the declarations widths is what the Coq int/SizeT split is
/// for; test/int_range records what it is worth.
bool z3_bv_sorts_enabled() {
    static bool const on = [] {
        const char *e = std::getenv("SPOQ_BV_SORTS");
        return e && std::string(e) == "1";
    }();
    return on;
}

/// Counts of each kind of sort crossing, dumped at exit when SPOQ_TRACE_SORTS
/// is set.  Plain data, so nothing it touches can have been destroyed by the
/// time the handler runs.
enum CrossKind {
    X_RECONCILE_LIT, X_RECONCILE_WIDEN, X_RECONCILE_BV2INT,
    X_BV2INT, X_BV2INT_LIT, X_INT2BV_LIT, X_WIDEN, X_NARROW, X_OTHER, X_N
};
static const char *const kCrossName[X_N] = {
    "reconcile literal", "reconcile widen", "reconcile bv->int",
    "coerce bv->int", "coerce bv->int literal",
    "coerce int->bv literal", "coerce bv->bv widen", "coerce bv->bv narrow", "coerce other"};
static unsigned long g_crossings[X_N];
static bool g_trace_sorts_on = false;

/// Sites, by literal pointer: nothing here has a destructor, so there is
/// nothing for the exit handler to read after destruction.
static const char *g_site_names[8];
static unsigned long g_site_counts[8];
static void note_site(const char *site) {
    if (!g_trace_sorts_on) return;
    for (int i = 0; i < 8; i++) {
        if (g_site_names[i] == site) { g_site_counts[i]++; return; }
        if (!g_site_names[i]) { g_site_names[i] = site; g_site_counts[i] = 1; return; }
    }
}

static void dump_crossings() {
    for (int i = 0; i < X_N; i++)
        if (g_crossings[i]) fprintf(stderr, "[sorts] %-24s %lu\n", kCrossName[i], g_crossings[i]);
    for (int i = 0; i < 8 && g_site_names[i]; i++)
        fprintf(stderr, "[sorts]   at %-20s %lu\n", g_site_names[i], g_site_counts[i]);
}
static void note_crossing(CrossKind k) {
    static bool const init = [] {
        g_trace_sorts_on = std::getenv("SPOQ_TRACE_SORTS") != nullptr;
        if (g_trace_sorts_on) std::atexit(dump_crossings);
        return true;
    }();
    (void)init;
    if (g_trace_sorts_on) g_crossings[k]++;
}

/// Whether the literal [lit] is a value of a [w]-bit two's complement integer.
/// Every int64 literal fits 64 bits or more; below that, shifting in int64 is
/// safe.
static bool literal_fits(int64_t lit, unsigned w) {
    if (w >= 64) return true;
    return lit >= -(int64_t(1) << (w - 1)) && lit < (int64_t(1) << (w - 1));
}

std::pair<z3::expr, z3::expr> reconcile_sorts(const z3::expr &a, const z3::expr &b) {
    auto const abv = a.is_bv(), bbv = b.is_bv();
    if (abv == bbv) {
        if (!abv || a.get_sort().bv_size() == b.get_sort().bv_size()) return {a, b};
        // Equal widths are what an LLVM operation gives; widen rather than
        // truncate if one ever arrives narrower.
        auto const wa = a.get_sort().bv_size(), wb = b.get_sort().bv_size();
        return wa < wb ? std::make_pair(z3::sext(a, wb - wa), b)
                       : std::make_pair(a, z3::sext(b, wa - wb));
    }
    auto const &v = abv ? a : b;
    auto const &o = abv ? b : a;
    auto const w = v.get_sort().bv_size();
    int64_t lit = 0;
    note_crossing(o.is_numeral() ? X_RECONCILE_LIT : X_RECONCILE_BV2INT);
    // Only when the literal fits the width.  bv_val truncates, so 2^31 at 32
    // bits would become -2^31 and a range bound like `x < 2147483648` would
    // read as `x <s -2147483648`, which is false -- every branch under it then
    // prunes as unreachable.  A bound that does not fit is exactly the kind a
    // range rely states, so this is the common case, not a corner.
    if (o.is_numeral() && o.is_numeral_i64(lit) && literal_fits(lit, w)) {
        auto const as_bv = z3ctx.bv_val(lit, w);
        return abv ? std::make_pair(a, as_bv) : std::make_pair(as_bv, b);
    }
    // A literal outside the width is a range bound, `x < 2^31` on an int32.
    // Widened to the address width, where every int64 literal fits, the
    // comparison stays in the vectors; the alternative is a bv2int the solver
    // cannot see through.
    if (o.is_numeral() && o.is_numeral_i64(lit) && w < kSizeTWidth) {
        note_crossing(X_RECONCILE_WIDEN);
        auto const wide = z3::sext(v, kSizeTWidth - w);
        auto const as_bv = z3ctx.bv_val(lit, kSizeTWidth);
        return abv ? std::make_pair(wide, as_bv) : std::make_pair(as_bv, wide);
    }
    auto const as_int = z3::bv2int(v, true);
    return abv ? std::make_pair(as_int, b) : std::make_pair(a, as_int);
}

z3::expr coerce_to_sort(const z3::expr &e, const z3::sort &want, const char *site,
                        const std::string &name) {
    if (z3::eq(e.get_sort(), want)) return e;
    auto const have_bv = e.is_bv(), want_bv = want.is_bv();
    if (have_bv && want_bv) {
        auto const hw = e.get_sort().bv_size(), ww = want.bv_size();
        note_crossing(hw < ww ? X_WIDEN : X_NARROW);
        return hw < ww ? z3::sext(e, ww - hw) : e.extract(ww - 1, 0);
    }
    if (have_bv && want.is_int()) {
        note_crossing(e.is_numeral() ? X_BV2INT_LIT : X_BV2INT);
        note_site(site);
        return z3::bv2int(e, true);
    }
    if (e.is_int() && want_bv) {
        auto const w = want.bv_size();
        int64_t lit = 0;
        if (e.is_numeral() && e.is_numeral_i64(lit) && literal_fits(lit, w)) {
            note_crossing(X_INT2BV_LIT);
            return z3ctx.bv_val(lit, w);
        }
        // A Z term reaching a bitvector slot.  int2bv would be exact, but the
        // solver cannot reason through it around integer arithmetic, and on
        // lua002 that made nearly every refinement query time out.  The fix
        // belongs at the source: give the value a width, or declare the slot
        // without one.
        auto text = e.to_string();
        if (text.size() > 200) text = text.substr(0, 200) + " ...";
        throw std::invalid_argument("Z value reaches a (_ BitVec " + std::to_string(w) + ") slot at " +
                                    site + (name.empty() ? "" : " " + name) + ": " + text);
    }
    // Z3's power is real-valued over the integers.  pow2_int converts at the
    // source; this covers any other real, taking its floor, so that a stray one
    // is a loss of precision rather than an uncaught z3::exception.
    if (e.is_real() && (want.is_int() || want_bv))
        return coerce_to_sort(z3::expr(z3ctx, Z3_mk_real2int(z3ctx, e)), want, site, name);
    note_crossing(X_OTHER);
    return e;
}

std::optional<unsigned> pow2_exponent(const z3::expr &e) {
    if (!e.is_bv() || !e.is_numeral()) return std::nullopt;
    uint64_t v = 0;
    if (!e.is_numeral_u64(v) || v == 0 || (v & (v - 1)) != 0) return std::nullopt;
    unsigned k = 0;
    while ((uint64_t(1) << k) != v) k++;
    if (k >= e.get_sort().bv_size()) return std::nullopt;
    return k;
}

/// Exact for a non-negative exponent, which is what a shift amount is.
z3::expr pow2_int(const z3::expr &e) {
    auto const p = z3::pw(2, e);
    if (!p.is_real()) return p;
    return z3::expr(z3ctx, Z3_mk_real2int(z3ctx, p));
}

std::optional<WidthOp> parse_width_op(const std::string &name) {
    bool is_signed = false, extends = false;
    size_t at = 0;
    if (name.rfind("wrap", 0) == 0) { is_signed = true; at = 4; }
    else if (name.rfind("uns", 0) == 0) { at = 3; }
    else if (name.rfind("sext", 0) == 0) { is_signed = true; extends = true; at = 4; }
    else if (name.rfind("zext", 0) == 0) { extends = true; at = 4; }
    else return std::nullopt;
    // Decimal widths, bounded by kMaxIntWidth.
    auto const number = [&](unsigned &out, char stop) -> bool {
        auto const start = at;
        for (out = 0; at < name.size() && name[at] != stop; at++) {
            if (!std::isdigit(static_cast<unsigned char>(name[at]))) return false;
            out = out * 10 + unsigned(name[at] - '0');
            if (out > kMaxIntWidth) return false;
        }
        return at > start && out >= 1;
    };
    WidthOp w{is_signed, 0, 0};
    if (!extends) {
        if (!number(w.bits, '\0') || w.bits > 63) return std::nullopt;
        w.to = w.bits;
        return w;
    }
    if (!number(w.bits, '_') || at >= name.size()) return std::nullopt;
    at++;
    if (!number(w.to, '\0') || w.to <= w.bits) return std::nullopt;
    return w;
}

std::optional<z3::expr> width_op_value(const std::string &op, const z3::expr &x) {
    if (!x.is_int() && !x.is_bv()) return std::nullopt;
    auto const w_op = parse_width_op(op);
    if (!w_op) return std::nullopt;
    auto const is_signed = w_op->is_signed;
    auto const bits = w_op->bits, to = w_op->to;

    // A literal takes the same path as everything else of its width.  Reducing
    // it in the integers instead would leave `uns32 14` an integer while
    // `uns32 idx` is a vector, so two guards that are each other's complement
    // would be stated in different representations and relating them would need
    // a bv2int pushed through arithmetic.
    z3::expr arg = x;
    int64_t lit = 0;
    if (z3_bv_sorts_enabled() && arg.is_int() && arg.is_numeral() && arg.is_numeral_i64(lit) &&
        literal_fits(lit, bits))
        arg = z3ctx.bv_val(lit, bits);

    // On a bitvector the operation is not arithmetic.  Reducing a w-bit value
    // to w bits signed is the identity -- bvadd already wrapped -- so wrapN
    // disappears, which is the point of the sorts.  sextN_M and zextN_M extend
    // to M bits.  unsN is a zero extension to twice the width, not by the one
    // bit [0, 2^N) needs: a bounds check adds one to the index, and at 2^N-1
    // that overflows a signed N+1-bit vector to negative, so the check passes
    // where it should fail.  Doubling leaves room for the sums and products a
    // check is made of.
    if (arg.is_bv()) {
        auto const w = arg.get_sort().bv_size();
        auto at_width = w == bits            ? arg
                        : w > bits           ? arg.extract(bits - 1, 0)
                                             : z3::sext(arg, bits - w);
        if (is_signed) return to == bits ? at_width : z3::sext(at_width, to - bits);
        return z3::zext(at_width, to == bits ? bits : to - bits);
    }

    // On an integer, sextN_M is the identity: the value is already the signed
    // residue.
    if (is_signed && to > bits) return arg;
    auto const modulus = z3ctx.int_val((uint64_t)1 << bits);
    if (!is_signed) return z3::mod(arg, modulus);
    auto const half = z3ctx.int_val((uint64_t)1 << (bits - 1));
    return z3::mod(arg + half, modulus) - half;
}

z3::expr bv_bitwise(BitOp op, const z3::expr &a0, const z3::expr &b0,
                    const z3::func_decl &fallback) {
    auto const apply = [&](const z3::expr &x, const z3::expr &y) {
        return op == BitOp::And ? (x & y) : op == BitOp::Or ? (x | y) : (x ^ y);
    };
    // One sort first: the fallback's domain is (Int Int), and two operands
    // already carrying a width should not be taken apart again.
    auto const [a, b] = reconcile_sorts(a0, b0);
    // Exact at that width, so no guard, and no fallback to switch off.
    if (a.is_bv()) return apply(a, b).simplify();
    if (!z3_bitvec_bitwise_enabled() || !a.is_int() || !b.is_int()) return fallback(a, b);
    auto const bits = apply(z3::int2bv(kBitwiseWidth, a), z3::int2bv(kBitwiseWidth, b));
    // Two's complement at this width agrees with Z.land and its siblings only
    // for an operand the width holds, so outside that the uninterpreted
    // function stands and the solver learns nothing rather than something
    // false.
    auto const half = z3ctx.int_val(std::numeric_limits<int64_t>::min()) * z3ctx.int_val(-1);
    auto const fits = [&](const z3::expr &e) { return e >= -half && e < half; };
    return z3::ite(fits(a) && fits(b), z3::bv2int(bits, true), fallback(a, b));
}

z3::func_decl land_func = z3ctx.function("land", z3ctx.int_sort(), z3ctx.int_sort(), z3ctx.int_sort());
z3::func_decl lor_func = z3ctx.function("lor", z3ctx.int_sort(), z3ctx.int_sort(), z3ctx.int_sort());
z3::func_decl lxor_func = z3ctx.function("lxor", z3ctx.int_sort(), z3ctx.int_sort(), z3ctx.int_sort());
z3::func_decl lnot_func = z3ctx.function("lnot", z3ctx.int_sort(), z3ctx.int_sort());
z3::func_decl testbit_func = z3ctx.function("testbit", z3ctx.int_sort(), z3ctx.int_sort(), z3ctx.bool_sort());
z3::func_decl setbit_func = z3ctx.function("setbit", z3ctx.int_sort(), z3ctx.int_sort(), z3ctx.int_sort());
z3::func_decl clearbit_func = z3ctx.function("clearbit", z3ctx.int_sort(), z3ctx.int_sort(), z3ctx.int_sort());

shared_ptr<Inductive> Inductive::Nat = make_shared<Inductive>(
    "nat",
    make_shared<vector<shared_ptr<IndConstr>>>(
        std::initializer_list<shared_ptr<IndConstr>>{
            make_shared<IndConstr>("O", make_shared<vector<shared_ptr<Arg>>>()),
            make_shared<IndConstr>("S", make_shared<vector<shared_ptr<Arg>>>(1,
                make_shared<Arg>("pred", make_shared<SpecType>(SpecType("nat")))
            ))
        }
    )
);

shared_ptr<SpecType> SpecType::UNKNOWN_TYPE = make_shared<SpecType>("UNKNOWN_TYPE");
shared_ptr<Int> Int::INT = make_shared<Int>();

static std::set<unsigned> g_int_widths_used;

const std::set<unsigned> &int_widths_used() { return g_int_widths_used; }

shared_ptr<Int> Int::size_t_int() {
    static shared_ptr<Int> const t = make_shared<Int>(kSizeTWidth, "intSizeT");
    // Its definition names the width's own type, which then has to exist.
    g_int_widths_used.insert(kSizeTWidth);
    return t;
}

shared_ptr<Int> Int::of_width(unsigned bits) {
    if (bits == 0) return Int::INT;
    static std::map<unsigned, shared_ptr<Int>> interned;
    g_int_widths_used.insert(bits);
    auto const it = interned.find(bits);
    if (it != interned.end()) return it->second;
    return interned.emplace(bits, make_shared<Int>(bits)).first->second;
}

std::string coq_type_name(const shared_ptr<SpecType> &t) {
    auto const i = dynamic_pointer_cast<Int>(t);
    if (i && !i->alias.empty()) return i->alias;
    if (i && i->bits) return "int" + std::to_string(i->bits);
    return string(*t);
}

shared_ptr<SpecType> int_type_of(const z3::expr &value) {
    if (value.is_bv()) return Int::of_width(value.get_sort().bv_size());
    return Int::INT;
}

// Below the width bookkeeping it records: poffset is intSizeT.
shared_ptr<Struct> Struct::Ptr = make_shared<Struct>(
    "Ptr",
    make_shared<vector<shared_ptr<Arg>>>(
        std::initializer_list<shared_ptr<Arg>>{
            make_shared<Arg>("pbase", make_shared<String>()),
            make_shared<Arg>("poffset", Int::size_t_int())
        }
    )
);

bool is_int_type(const shared_ptr<SpecType> &t) {
    return t && dynamic_pointer_cast<Int>(t) != nullptr;
}

bool is_int_zmap_type(const shared_ptr<SpecType> &t) {
    auto const z = dynamic_pointer_cast<ZMap>(t);
    return z && is_int_type(z->elem_type);
}
shared_ptr<Float> Float::FLOAT = make_shared<Float>();
shared_ptr<String> String::STRING = make_shared<String>();
shared_ptr<Bool> Bool::BOOL = make_shared<Bool>();
shared_ptr<Prop> Prop::PROP = make_shared<Prop>();
shared_ptr<Type> Type::TYPE = make_shared<Type>();

// ----------------------------------------------------------------------------
// SpecType
// ----------------------------------------------------------------------------
z3::sort SpecType::get_z3_type() {
    auto const key = sort_key();
    if (Inductive::created_z3_types.find(key) != Inductive::created_z3_types.end()) {
        return Inductive::created_z3_types.at(key);
    } else if (Struct::created_z3_types.find(key) != Struct::created_z3_types.end()) {
        return Struct::created_z3_types.at(key);
    } else if (List::created_z3_types.find(key) != List::created_z3_types.end()) {
        return List::created_z3_types.at(key);
    }

    return z3ctx.uninterpreted_sort(name.c_str());
}

shared_ptr<SpecValue> SpecType::from_z3_value(z3::expr value) {
    return make_shared<SpecValue>(shared_from_this(), value);
}

shared_ptr<SpecValue> SpecType::declare(string name, int nid) {
    auto const sname = name + "." + std::to_string(nid);

    return make_shared<SpecValue>(shared_from_this(), z3ctx.constant(sname.c_str(), get_z3_type()));
}

// ----------------------------------------------------------------------------
// Int
// ----------------------------------------------------------------------------
std::string Int::sort_key() const {
    return bits && z3_bv_sorts_enabled() ? "int" + std::to_string(bits) : "Z";
}

z3::sort Int::get_z3_type() {
    if (bits && z3_bv_sorts_enabled()) return z3ctx.bv_sort(bits);
    return z3ctx.int_sort();
}

shared_ptr<SpecValue> Int::from_z3_value(z3::expr value) {
    return make_shared<IntValue>(value);
}

shared_ptr<SpecValue> Int::declare(string name, int nid) {
    auto const sname = name + "." + std::to_string(nid);

    return make_shared<IntValue>(z3ctx.constant(sname.c_str(), get_z3_type()));
}
// ----------------------------------------------------------------------------
// Float
// ----------------------------------------------------------------------------
z3::sort Float::get_z3_type() {
    // TODO: Make this depend on the type float vs double
    return z3ctx.fpa_sort<64UL>();
}

shared_ptr<SpecValue> Float::from_z3_value(z3::expr value) {
    return make_shared<FloatValue>(value);
}

shared_ptr<SpecValue> Float::declare(string name, int nid) {
    auto const sname = name + "." + std::to_string(nid);

    return make_shared<FloatValue>(z3ctx.constant(sname.c_str(), get_z3_type()));
}

// ----------------------------------------------------------------------------
// String
// ----------------------------------------------------------------------------
z3::sort String::get_z3_type() {
    return z3ctx.string_sort();
}

shared_ptr<SpecValue> String::from_z3_value(z3::expr value) {
    return make_shared<StringValue>(value);
}

shared_ptr<SpecValue> String::declare(string name, int nid) {
    auto const sname = name + "." + std::to_string(nid);

    return make_shared<StringValue>(z3ctx.constant(sname.c_str(), get_z3_type()));
}

// ----------------------------------------------------------------------------
// Bool
// ----------------------------------------------------------------------------
z3::sort Bool::get_z3_type() {
    return z3ctx.bool_sort();
}

shared_ptr<SpecValue> Bool::from_z3_value(z3::expr value) {
    return make_shared<BoolValue>(value);
}

shared_ptr<SpecValue> Bool::declare(string name, int nid) {
    auto const sname = name + "." + std::to_string(nid);

    return make_shared<BoolValue>(z3ctx.constant(sname.c_str(), get_z3_type()));
}

// ----------------------------------------------------------------------------
// Prop
// ----------------------------------------------------------------------------
z3::sort Prop::get_z3_type() {
    return z3ctx.bool_sort();
}

shared_ptr<SpecValue> Prop::from_z3_value(z3::expr value) {
    return make_shared<BoolValue>(value);
}

shared_ptr<SpecValue> Prop::declare(string name, int nid) {
    auto const sname = name + "." + std::to_string(nid);

    return make_shared<BoolValue>(z3ctx.constant(sname.c_str(), get_z3_type()));
}
// ----------------------------------------------------------------------------
// Vector
// ----------------------------------------------------------------------------
z3::sort Vector::get_z3_type() {
    auto z3t = this->elem_type->get_z3_type();
    return z3ctx.seq_sort(z3t);
}

shared_ptr<SpecValue> Vector::from_z3_value(z3::expr value) {
    return make_shared<VectorValue>(shared_from_this(), value);
}

shared_ptr<SpecValue> Vector::declare(string name, int nid) {
    auto const sname = name + "." + std::to_string(nid);
    auto z3t = this->elem_type->get_z3_type();

    return make_shared<VectorValue>(shared_from_this(), z3ctx.constant(name.c_str(), z3ctx.seq_sort(z3t)));
}
// ----------------------------------------------------------------------------
// ZMap
// ----------------------------------------------------------------------------
z3::sort ZMap::get_z3_type() {
    return z3ctx.array_sort(key_sort(), this->elem_type->get_z3_type());
}

shared_ptr<SpecValue> ZMap::from_z3_value(z3::expr value) {
    return make_shared<ZMapValue>(shared_from_this(), value);
}

shared_ptr<SpecValue> ZMap::declare(string name, int nid) {
    auto const sname = name + "." + std::to_string(nid);

    return make_shared<ZMapValue>(shared_from_this(), z3ctx.constant(name.c_str(), get_z3_type()));
}
// ----------------------------------------------------------------------------
// SMap
// ----------------------------------------------------------------------------
z3::sort SMap::get_z3_type() {
    return z3ctx.array_sort(z3ctx.string_sort(), this->elem_type->get_z3_type());
}

shared_ptr<SpecValue> SMap::from_z3_value(z3::expr value) {
    return make_shared<SMapValue>(shared_from_this(), value);
}

shared_ptr<SpecValue> SMap::declare(string name, int nid) {
    auto const sname = name + "." + std::to_string(nid);

    return make_shared<SMapValue>(shared_from_this(), z3ctx.constant(name.c_str(), z3ctx.array_sort(z3ctx.string_sort(), this->elem_type->get_z3_type())));
}

// ----------------------------------------------------------------------------
// Arg
// ----------------------------------------------------------------------------
std::string Arg::to_string() const {
    if (expr != nullptr) {
        return "(" + name + ": " + string(*expr) + ")";
    } else {
        return "(" + name + ": " + string(*type) + ")";
    }
}

// ----------------------------------------------------------------------------
// Struct
// ----------------------------------------------------------------------------
std::string Struct::define() const {
    std::string res = "Record " + name + " :=\n";
    std::string args;
    for(auto  const&arg: *elems) {
        args += arg->name;
        args += ": ";
        args += coq_type_name(arg->type);

        if(arg != elems->back()) {
            args += ";\n";
        }
    }

    res += "  mk" + name + " {\n";
    res += add_indent(args, 4) + "\n";
    res += "}.\n";
    return res;
}

z3::sort Struct::get_z3_type() {
    auto const key = sort_key();
    if (Struct::created_z3_types.find(key) != Struct::created_z3_types.end()) {
        return Struct::created_z3_types.at(key);
    }

    z3::constructors cs(z3ctx);
    vector<z3::sort> sorts;
    vector<z3::symbol> accs;

    for (auto const arg : *elems) {
        // The declared type, width and all: sorts are interned by sort_key, so
        // two records differing only in a field's width get distinct sorts.
        sorts.push_back(this->elems_map[arg->name]->get_z3_type());
        accs.push_back(z3ctx.str_symbol(arg->name.c_str()));
    }

    auto const mk_name = "mk" + key;
    cs.add(z3ctx.str_symbol(mk_name.c_str()), z3ctx.str_symbol(key.c_str()),
                            accs.size(), accs.data(), sorts.data());

    auto z3type = z3ctx.datatype(z3ctx.str_symbol(key.c_str()), cs);
    Struct::created_z3_types.emplace(key, z3type);
    return z3type;
}

shared_ptr<SpecValue> Struct::from_z3_value(z3::expr value) {
    return make_shared<StructValue>(shared_from_this(), value);
}

shared_ptr<SpecValue> Struct::declare(string name, int nid) {
    auto const sname = name + "." + std::to_string(nid);

    return make_shared<StructValue>(shared_from_this(), z3ctx.constant(sname.c_str(), get_z3_type()));
}

shared_ptr<SpecValue> Struct::construct(vector<shared_ptr<SpecValue>> &elems) {
    auto z3type = this->get_z3_type();
    auto const mkRData = z3type.constructors()[0];
    z3::expr_vector args(z3ctx);

    for (int i = 0; i < elems.size(); i++) {
        args.push_back(coerce_to_sort(elems[i]->get_z3_value(), mkRData.domain(i), "record construct", name));
    }

    return from_z3_value(mkRData(args));
}


// z3::func_decl Struct::get_recognizer(string constr) {
//         auto css = this->get_z3_type().recognizers()[0];

// };

// ----------------------------------------------------------------------------
// StructValue
// ----------------------------------------------------------------------------
std::shared_ptr<SpecValue> StructValue::get(string key) {
    string field = std::move(key);

    if (auto s = dynamic_cast<Struct*>(typ.get())) {
        int i = 0;
        bool found = false;
        for(auto const arg : *s->elems) {
            if(arg->name == field) {
                found = true;
                break;
            }
            i++;
        }

        if(!found)
            throw std::runtime_error("Field not found:" + field);

        auto const elem_typ = s->elems_map[field];
        z3::sort z3type = s->get_z3_type();
        assert(z3type.is_datatype());
        z3::func_decl_vector const css = z3type.constructors();
        z3::func_decl cs = css[0];  //one constructor: mk{fname}
        z3::func_decl const accessor = cs.accessors()[i]; //get the ith accessor

        return elem_typ->from_z3_value(accessor(get_z3_value()));
    }

    throw std::runtime_error("Not a struct type");
}

shared_ptr<SpecValue> StructValue::get(int key) {
    if(is_instance(typ.get(), Tuple)){
        string field = "elem_" + std::to_string(key);
        return StructValue::get(field);
    } /* else if(auto struct_typ = dynamic_cast<Struct*>(typ.get())) {
        auto elem_name = struct_typ->elems->at(key)->name;
        return StructValue::get(elem_name);
    } */
    throw std::runtime_error("StructValue::get(int) should only be called on a tuple type");

}

shared_ptr<StructValue> StructValue::set(string key, const shared_ptr<SpecValue>& value) {
    string field = std::move(key);
    if(auto s = dynamic_cast<Struct*>(typ.get())) {
        auto const elem_typ = s->elems_map[field];
        z3::sort z3type = s->get_z3_type();
        assert(z3type.is_datatype());
        z3::func_decl_vector const css = z3type.constructors();
        z3::func_decl const cs = css[0];  //one constructor: mk{fname}

        z3::expr_vector elems(z3ctx);
        int i = 0;
        for(auto const arg : *s->elems) {
            if(arg->name == field) {
                elems.push_back(coerce_to_sort(value->get_z3_value(), cs.domain(i), "record set", s->name));
            } else {
                elems.push_back(z3type.constructors()[0].accessors()[i](get_z3_value()));
            }
            i++;
        }

        return dynamic_pointer_cast<StructValue>(s->from_z3_value(cs(elems)));
    }

    throw std::runtime_error("Not a struct type");
}

shared_ptr<StructValue> StructValue::set(int key, const shared_ptr<SpecValue>& value) {
    assert(is_instance(typ.get(), Tuple));
    string field = "elem_" + std::to_string(key);
    return StructValue::set(field, std::move(value));
}

// ----------------------------------------------------------------------------
// IndValue
// ----------------------------------------------------------------------------

shared_ptr<SpecValue> IndValue::get(const string& key) {
    auto accessor = key;
    if(auto type = instance_of(typ.get(), Option)) {
        accessor = key + "_" + type->elem_type->sort_key();
    }
    if(auto type = instance_of(typ.get(), List)) {
        accessor = key + "_" + type->elem_type->sort_key();
    }
    assert(is_instance(typ.get(), Inductive));

    if(auto type = instance_of(typ.get(), Inductive)) {
        auto const val = get_z3_value();
        int const i = 0;
        auto ind_type = dynamic_cast<Inductive*>(typ.get());
        // for(auto [arg, type]: type->arg_type) {
        //     if(arg == accessor)
        //         break;
        //     i++;
        // }
        // Here we need to pick the accessor that matches type->arg_type[accessor]
        // rather than the one that matches the actual value.
        // The order of z3 accessors is not necessarily the same as the order of constrs
        for(auto const acc: accessors){
            if(acc.name().str() == accessor){
                return type->arg_type[accessor]->from_z3_value(acc(val).simplify());
            }
        }
        throw std::runtime_error("Could not find correct accessor.");
    }

    throw std::runtime_error("Not an inductive type");
}

// shared_ptr<IndValue> IndValue::set(string key, shared_ptr<SpecValue> value) {
//     //this sames not used by before
//     return nullptr;
// }

// shared_ptr<IndValue> IndValue::concat(shared_ptr<IndValue> other) {
//     assert(is_instance(typ.get(), List));
//     assert(is_instance(other->typ.get(), List));

//     if(auto type = instance_of(typ.get(), List)) {
//         z3::func_decl f = type->concat_func();
//         return dynamic_pointer_cast<IndValue>(type->from_z3_value(f(get_z3_value(), other->get_z3_value())));
//     }

//     throw std::runtime_error("Not a list type");
// }

// ----------------------------------------------------------------------------
// IndConstr
// ----------------------------------------------------------------------------
IndConstr::operator std::string() const {
    std::string res = name + " ";
    res += join_elems_space(*args);
    return res;
}

// ----------------------------------------------------------------------------
// Inductive
// ----------------------------------------------------------------------------
std::string Inductive::define() const {
    std::string res = "Inductive " + name + ": Type :=\n | ";

    res += join_constrs_pipe(*constrs) + ".\n";
    return res;
}

z3::sort Inductive::get_z3_type() {
    auto const key = sort_key();
    if (Inductive::created_z3_types.find(key) != Inductive::created_z3_types.end()) {
        return Inductive::created_z3_types.at(key);
    }

    z3::constructors cs(z3ctx);
    vector<z3::sort> sorts;
    vector<z3::symbol> accs;
    auto const tname = z3ctx.str_symbol(key.c_str());
    auto const tsort = z3ctx.datatype_sort(tname);

    for (auto const constr : *constrs) {
        sorts.clear();
        accs.clear();
        for (auto const arg : *constr->args) {
            auto arg_name = arg->name;

            if (arg->type->name == this->name)
                sorts.push_back(tsort);
            else
                sorts.push_back(arg->type->get_z3_type());
            accs.push_back(z3ctx.str_symbol(arg_name.c_str()));
        }

        auto const recog_name = "is-" + constr->name;

        cs.add(z3ctx.str_symbol(constr->name.c_str()), z3ctx.str_symbol(recog_name.c_str()),
                                accs.size(), accs.data(), sorts.data());
    }

    auto z3type = z3ctx.datatype(tname, cs);
    Inductive::created_z3_types.emplace(key, z3type);

    return z3type;
}

shared_ptr<SpecValue> Inductive::from_z3_value(z3::expr value) {
    return make_shared<IndValue>(shared_from_this(), value);
}

shared_ptr<SpecValue> Inductive::declare(string name, int nid) {
    auto const sname = name + "." + std::to_string(nid);

    return make_shared<IndValue>(shared_from_this(), z3ctx.constant(sname.c_str(), get_z3_type()));
}

shared_ptr<SpecValue> Inductive::construct(string constr, vector<shared_ptr<SpecValue>> args) {
    if (auto opt = dynamic_cast<Option*>(this)) {
        constr = constr + "_" + opt->elem_type->sort_key();
    } else if (auto lst = dynamic_cast<List*>(this)) {
        constr = constr + "_" + lst->elem_type->sort_key();
    }

    auto const css = this->get_z3_type().constructors();

    for (int i = 0; i < css.size(); i++) {
        auto const cs = css[i];
        if (cs.name().str() == constr) {
            if (args.empty()) return from_z3_value(cs());
            // Coerced against this constructor's domain, so the arity is known.
            z3::expr_vector z3_args(z3ctx);
            for (int j = 0; j < args.size(); j++)
                z3_args.push_back(coerce_to_sort(args[j]->get_z3_value(), cs.domain(j), "inductive construct", constr));
            return from_z3_value(cs(z3_args));
        }
    }

    throw std::runtime_error("Constructor not found");
}


int Inductive::get_constr_index(const string& constr) {
        auto const css = this->get_z3_type().constructors();

        for (int i = 0; i < css.size(); i++) {
            auto const cs = css[i];
            if (cs.name().str() == constr) {
                return i;
            }
        }
        throw std::runtime_error("Constructor not found");
    };

    z3::func_decl Inductive::get_constr(const string& constr) {
        auto const css = this->get_z3_type().constructors();

        for (int i = 0; i < css.size(); i++) {
            auto cs = css[i];
            if (cs.name().str() == constr) {
                return cs;
            }
        }
        throw std::runtime_error("Constructor not found");
    }

    z3::func_decl Inductive::get_recognizer(const string& constr) {
        auto const css = this->get_z3_type().constructors();
        for (int i = 0; i < css.size(); i++) {
            auto const cs = css[i];
            if (cs.name().str() == constr) {
                return this->get_z3_type().recognizers()[i];
            }
        }
        throw std::runtime_error("Constructor not found");
    }

    z3::func_decl_vector Inductive::get_accessors(const string& constr) {
        auto const css = this->get_z3_type().constructors();

        for (int i = 0; i < css.size(); i++) {
            auto cs = css[i];
            if (cs.name().str() == constr) {
                return cs.accessors();
            }
        }
        throw std::runtime_error("Constructor not found");
    }

// ----------------------------------------------------------------------------
// Function
// ----------------------------------------------------------------------------
Function::Function(const shared_ptr<SpecType>& rettype, const shared_ptr<vector<shared_ptr<SpecType>>>& args) {
    this->name = "Func_" + join_underline(*args) + "_" + rettype->name;
    this->rettype = rettype;
    this->args = args;
}

Function::operator string() const {
    if (args->empty()) return std::string(*rettype);

    // Right-associated: a -> (b -> (c -> r)).  Indexed rather than comparing
    // each arg against args->back(), which compares shared_ptr values: two
    // arguments of the same type are the *same* pointer -- every `Z -> Z -> Z`
    // is -- so the comparison said "this is the last one" for both and opened
    // no parenthesis while still closing one.
    std::string res;
    for (size_t i = 0; i + 1 < args->size(); i++)
        res += std::string(*args->at(i)) + " -> (";
    res += std::string(*args->back()) + " -> ";

    return res + std::string(*rettype) + string(args->size() - 1, ')');
}

shared_ptr<SpecValue> Function::from_z3_value(z3::expr value) {
    return make_shared<FuncValue>(shared_from_this(), value);
}

shared_ptr<SpecValue> Function::declare(string name, int nid) {
    auto const sname = name + "." + std::to_string(nid);

    return make_shared<FuncValue>(shared_from_this(), z3ctx.constant(sname.c_str(), get_z3_type()));
}

// ----------------------------------------------------------------------------
// Tuple
// ----------------------------------------------------------------------------
Tuple::Tuple(const shared_ptr<vector<shared_ptr<SpecType>>>& types) :
    Struct("Tuple_" + join_underline(*types),
           make_shared<std::vector<shared_ptr<Arg>>>()),
    types(types) {
    if (types->size() == 1) {
        throw std::runtime_error("Tuple must have at least two element");
    }

    for (int i = 0; i < types->size(); i++) {
        elems->push_back(make_shared<Arg>("elem_" + std::to_string(i), (*types)[i]));
        elems_map.emplace("elem_" + std::to_string(i), (*types)[i]);
    }
}

std::string Tuple::sort_key() const {
    std::string key = "Tuple";
    for (auto const &t : *types) key += "_" + t->sort_key();
    return key;
}

Tuple::operator string() const {
    std::string res = "(";

    for (int i = 0; i < types->size(); i++) {
        if (i != 0) {
            res += " * ";
        }
        res += std::string(*(*types)[i]);
    }
    return res + ")";
}

// XXX: Python doesn't have this. Do we need it here?
// shared_ptr<SpecValue> Tuple::construct(vector<shared_ptr<SpecValue>> args) {
//     auto elems = vector<z3::expr>();
//     for (int i = 0; i < args.size(); i++) {
//         elems.push_back(args[i]->get_z3_value());
//     }
//     // TODO
// }

// ----------------------------------------------------------------------------
// List
// ----------------------------------------------------------------------------
/** Append an element to the head of a list, returns the new list, i.e. `other :: this`.
 *  Z3 sequence cannot be concatenated with a single element, so we need to
 *  create a new sequence with the element and then concatenate it.
 */
shared_ptr<SpecValue> ListValue::append(const shared_ptr<SpecValue>& other) {
    auto const list_type = static_pointer_cast<List>(typ);
    auto const elem_type = list_type->elem_type;
    auto const other_type = other->get_type();
    auto const elem_sort = elem_type->get_z3_type();

    if (elem_type != other_type) {
        throw std::runtime_error("Type mismatch: cannot append " + string(*other_type) + " to " + string(*elem_type));
    }


    // Make `other` a Z3 sequence with a single element
    auto const unit_val = z3::expr(z3ctx, Z3_mk_seq_unit(z3ctx, other->get_z3_value()));
    // unit_val :: value
    Z3_ast const args[] = { unit_val, value };

    auto concat_decl = Z3_mk_seq_concat(z3ctx, 2, args);

    auto const concat_val = z3::expr(z3ctx, concat_decl);

    return make_shared<ListValue>(list_type, concat_val);
}

/** Concatenate two lists, returns the new list, i.e. `this ++ other`.
 */
shared_ptr<SpecValue> ListValue::concat(const shared_ptr<SpecValue>& other) {
    auto const list_type = static_pointer_cast<List>(typ);
    auto const other_type = other->get_type();
    auto other_list_type = dynamic_cast<List*>(other_type.get());

    if (*list_type != *other_list_type) {
        throw std::runtime_error("Type mismatch: cannot concatenate " + string(*other_type) + " to " + string(*list_type));
    }

    // value ++ other->value
    Z3_ast const args[] = { value, other->get_z3_value() };
    auto concat_decl = Z3_mk_seq_concat(z3ctx, 2, args);

    auto const concat_val = z3::expr(z3ctx, concat_decl);

    return make_shared<ListValue>(list_type, concat_val);
}

shared_ptr<SpecValue> int_to_ptr() {
    auto const args = make_shared<vector<shared_ptr<SpecType>>>();
    // intSizeT, the word a pointer is stored as, so that a loaded pointer
    // converts back with no change of sort.
    args->push_back(Int::size_t_int());
    return make_shared<Function>(Struct::Ptr, args)->declare("int_to_ptr", 0);
}

shared_ptr<SpecValue> ptr_to_int() {
    auto const args = make_shared<vector<shared_ptr<SpecType>>>();
    args->push_back(Struct::Ptr);
    // intSizeT, the type a pointer word has in memory, so that storing the
    // result is not a conversion.
    return make_shared<Function>(Int::size_t_int(), args)->declare("ptr_to_int", 0);
}

shared_ptr<SpecValue> z_to_nat() {
    auto const args = make_shared<vector<shared_ptr<SpecType>>>();
    args->push_back(Int::INT);
    return make_shared<Function>(Inductive::Nat, args)->declare("z_to_nat", 0);
}
} // namespace autov
