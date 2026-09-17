#include "llvm_coq_type.h"
#include "SpoqIR.h"
#include "SpoqIRModule.h"
#include "log.h"
#include "nodes.h"
#include "project.h"
#include "shortcuts.h"
#include "anon_structs.h"

#include <cassert>
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/CFG.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/DebugInfoMetadata.h"
#include "llvm/IR/InstrTypes.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Value.h"
#include "llvm/Support/Casting.h"
#include "llvm/Transforms/Utils/ValueMapper.h"
#include "llvm/IR/InlineAsm.h"
#include "llvm/Support/ModRef.h"
#include <memory>
#include <stdexcept>
#include <unordered_map>
#include <cstring>
#include <cctype>
#include <sstream>
#include <values.h>

#include "llvm/Analysis/LoopInfo.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/PassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Support/MemoryBuffer.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Transforms/Scalar.h"
#include "llvm/Transforms/Utils/Cloning.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/Transforms/Scalar/ConstantHoisting.h"
#include "llvm/Support/raw_ostream.h"

namespace autov {

/// Whether [proj] already declares [name].  Out of line because SpoqIRModule.h
/// only forward declares Project, and its one caller there is inline.
bool project_declares(Project* proj, const std::string& name) {
    return proj && proj->is_known_symbol(name);
}

/**
 * @brief This look up table is incomplete and only contains the most common binary ops in llvm.
 *
 */
const std::unordered_map<llvm::Instruction::BinaryOps, Expr::binops> SpoqIRModule::binops_lut = {
    {llvm::Instruction::BinaryOps::Add, Expr::binops::ADD},
    {llvm::Instruction::BinaryOps::Sub, Expr::binops::MINUS},
    {llvm::Instruction::BinaryOps::Mul, Expr::binops::MULT},
    {llvm::Instruction::BinaryOps::SDiv, Expr::binops::DIV},
    {llvm::Instruction::BinaryOps::UDiv, Expr::binops::DIV},
    {llvm::Instruction::BinaryOps::SRem, Expr::binops::MOD},
    {llvm::Instruction::BinaryOps::URem, Expr::binops::MOD},
    {llvm::Instruction::BinaryOps::Shl, Expr::binops::LSHIFT},
    {llvm::Instruction::BinaryOps::LShr, Expr::binops::RSHIFT}, // FIXME: we use RSHIFT(arithmetic) for both LShr
    {llvm::Instruction::BinaryOps::AShr, Expr::binops::RSHIFT},
    {llvm::Instruction::BinaryOps::And, Expr::binops::BITAND},
    {llvm::Instruction::BinaryOps::Or, Expr::binops::BITOR},
    // FIXME: {llvm::Instruction::BinaryOps::Xor, Expr::binops::BITOR},
};

const std::unordered_map<llvm::Instruction::BinaryOps, Expr::binops> SpoqIRModule::bool_binops_lut = {
    {llvm::Instruction::BinaryOps::And, Expr::binops::BAND},
    {llvm::Instruction::BinaryOps::Or, Expr::binops::BOR},
};

const std::unordered_map<llvm::CmpInst::Predicate, Expr::binops> SpoqIRModule::cmpops_lut = {
    {llvm::CmpInst::Predicate::ICMP_EQ, Expr::binops::BEQ},
    {llvm::CmpInst::Predicate::ICMP_NE, Expr::binops::BNE},
    // Signed Numbers
    {llvm::CmpInst::Predicate::ICMP_SGT, Expr::binops::BGT},
    {llvm::CmpInst::Predicate::ICMP_SGE, Expr::binops::BGE},
    {llvm::CmpInst::Predicate::ICMP_SLT, Expr::binops::BLT},
    {llvm::CmpInst::Predicate::ICMP_SLE, Expr::binops::BLE},
    // Unsigned Numbers
    {llvm::CmpInst::Predicate::ICMP_UGT, Expr::binops::BGT},
    {llvm::CmpInst::Predicate::ICMP_UGE, Expr::binops::BGE},
    {llvm::CmpInst::Predicate::ICMP_ULT, Expr::binops::BLT},
    {llvm::CmpInst::Predicate::ICMP_ULE, Expr::binops::BLE},
};


/* -- floating point: present, uninterpreted ---------------------------------
 *
 * Floats are not modelled.  Every floating point computation becomes an
 * application of a declared, uninterpreted function, so a function containing
 * one still translates, prints as valid Coq, and reaches the solver -- which is
 * all that is wanted: verifying behaviour *next to* float instructions, not
 * behaviour that depends on them.  An uninterpreted function is consistent with
 * every real semantics, so nothing that goes through is wrong because of
 * floats; anything needing float reasoning simply does not go through.
 *
 * `Float := Z` in every prelude, and is the field type of records the
 * abstraction layer reads, so the type stays Z.  What changes is that nothing
 * is claimed about the values.
 */

/// Whether [inst] is a floating point computation -- something to make opaque
/// rather than translate.
///
/// Restricted to the four instruction classes that compute: a load of a float,
/// a store, a GEP into a float array, a phi or a select over floats are all
/// ordinary operations on an opaque value and must keep their normal treatment.
/// Within those classes the test is on the types, so it catches every float
/// opcode -- the six arithmetic, the six casts, and fcmp -- without listing
/// them, and leaves integer and pointer work alone.
static bool is_float_computation(llvm::Instruction *inst) {
    if (!llvm::isa<llvm::BinaryOperator>(inst) && !llvm::isa<llvm::UnaryOperator>(inst) &&
        !llvm::isa<llvm::CastInst>(inst) && !llvm::isa<llvm::CmpInst>(inst))
        return false;
    if (inst->getType()->isFPOrFPVectorTy()) return true;
    for (auto const &op : inst->operands())
        if (op->getType()->isFPOrFPVectorTy()) return true;
    return false;
}

/// The name a float computation is given.
///
/// Derived from the opcode alone -- never from the containing function, unlike
/// the function pointer convention.  vuln and patch must call the *same*
/// uninterpreted function or no refinement proof could relate them.  Width is
/// left out for the same reason it is left out of the type: `Float` is one type
/// here, so `fmul` on a float and on a double are one symbol.
static std::string float_op_name(llvm::Instruction *inst) {
    if (auto cmp = llvm::dyn_cast<llvm::CmpInst>(inst))
        return "fcmp_" + llvm::CmpInst::getPredicateName(cmp->getPredicate()).str();
    return inst->getOpcodeName();
}

/// `llvm.fabs.f64` -> `llvm_fabs`, dropping the overload suffix so one symbol
/// serves every width.
static std::string float_intrinsic_name(llvm::StringRef llvm_name) {
    std::string name = llvm_name.str();
    for (auto const suffix : {".f32", ".f64", ".f80", ".f128"}) {
        auto const at = name.rfind(suffix);
        if (at != std::string::npos && at + std::strlen(suffix) == name.size()) {
            name.resize(at);
            break;
        }
    }
    for (auto &c : name)
        if (!std::isalnum(static_cast<unsigned char>(c))) c = '_';
    return name;
}

/// Declare [name] as an uninterpreted function over [arg_types] -> [rettype],
/// unless the project already has it.
///
/// GlobalDefs because these are shared: the same `fmul` is used by every
/// function in every layer, and GlobalDefs is the one location every generated
/// spec imports.  A declaration whose loc matches no section is registered and
/// never emitted, which leaves the Coq referencing a name it never declares.
static void declare_uninterpreted(Project *proj, const std::string &name,
                                  shared_ptr<vector<shared_ptr<SpecType>>> arg_types,
                                  shared_ptr<SpecType> rettype) {
    if (proj->defs.find(name) != proj->defs.end()) return;
    if (proj->decls.find(name) != proj->decls.end()) return;
    // A constant is declared at its own type, not as a nullary function: z3_eval
    // reaches a bare symbol through a path that asserts the declaration is not
    // a Function, and a float literal arrives there as a Symbol.
    shared_ptr<SpecType> type =
        arg_types->empty() ? std::move(rettype)
                           : make_shared<Function>(std::move(rettype), std::move(arg_types));
    proj->add_declaration(make_unique<Declaration>(name, std::move(type)),
                          make_shared<loc_t>(Project::LOC_GLOBALDEFS, "", ""));
}

/// [cond] in a boolean position, coerced if it is not already a Bool.
///
/// C tests an int against zero, and a spec whose result is an i1 rendered as Z
/// hands one back -- `llvm.is.fpclass` in snd014, whose generated spec returns
/// `option (Z * RData)` and whose result the caller branches on.  Without this
/// the If carries an Int where z3 wants a Bool and z3::operator! asserts.
static unique_ptr<SpecNode> as_condition(unique_ptr<SpecNode> cond) {
    if (cond->get_type() && cond->get_type()->name == Bool::BOOL->name) return cond;
    auto elems = std::make_unique<vector<unique_ptr<SpecNode>>>();
    elems->push_back(std::move(cond));
    elems->push_back(std::make_unique<IntConst>(0));
    return std::make_unique<Expr>(Expr::binops::BNE, std::move(elems), Bool::BOOL);
}

/// The symbol standing for a `poison` or `undef` vector, declared.
///
/// Clang builds a vector out of poison -- `insertelement <2 x double> poison,
/// ...` is what `_mm_load_sd` compiles to -- and an undeclared symbol is not
/// treated as unconstrained downstream: check_well_typed aborts on
/// "Unknown symbol", which is where snd014 stopped.  Declaring it says the only
/// honest thing, that it is some value of its type.
///
/// Named after the element count, which is the pre-existing convention: two of
/// different widths are not even the same type.  Two of the *same* width
/// therefore share a constant, which says they are equal -- more than poison
/// promises, though in practice these are placeholders overwritten lane by lane
/// before anything reads them.
static unique_ptr<SpecNode> undefined_vector_symbol(Project *proj, const char *kind,
                                                    llvm::Type *ty) {
    std::string name = std::string(kind) + "_vector";
    if (auto fvty = llvm::dyn_cast<llvm::FixedVectorType>(ty))
        name += "_" + std::to_string(fvty->getNumElements());

    auto const type = SpoqIRModule::llvm_ir_type_to_spec_pure(ty);
    assert(proj && "an undefined vector needs a project to declare it in");
    declare_uninterpreted(proj, name, make_shared<vector<shared_ptr<SpecType>>>(), type);
    return std::make_unique<Symbol>(name, type);
}

/// A stable name for a float literal, from its exact bits.
///
/// hexfloat because it round-trips: 0.1 and the double nearest it must not
/// collide, and two occurrences of one literal must be one constant.  The same
/// scheme z3_eval already used for these, so the spec and the solver now agree
/// on a single symbol rather than each inventing its own.
static std::string float_literal_name(double v) {
    std::ostringstream os;
    os << std::hexfloat << v;
    std::string name = "float_lit_" + os.str();
    for (auto &c : name)
        if (!std::isalnum(static_cast<unsigned char>(c))) c = '_';
    return name;
}

/// The block both arms of a conditional branch reconverge at, or null.
///
/// Structural rather than a post-dominator query: it recognises the diamond
///
///        B                 t and f each have B as their only predecessor,
///       / \                both branch straight to J, and J has exactly
///      t   f               those two predecessors.
///       \ /
///        J
///
/// and the triangle below, and declines anything else -- for which the caller
/// walks each arm to its own return, duplicating what follows.  The predecessor
/// count is the load-bearing condition: a third edge into J would mean control
/// can reach it without passing through this If, so the values bound after the
/// If would not all be defined.
static llvm::BasicBlock *reconvergence_point(llvm::BasicBlock *b, llvm::BasicBlock *t,
                                             llvm::BasicBlock *f, SpoqLoopContext &context) {
    if (t == f) return nullptr;                     // not a branch in any real sense

    // A postheader still looks like an ordinary two-predecessor join from
    // outside the loop, and stopping an arm there would read its phis directly
    // instead of through the loop's pass-out list.  A preheader is not like
    // that: its phis are ordinary ones, merging the arms that reach the loop,
    // and the loop's own phis are in the header.  Refusing preheaders too left
    // each arm to walk into the loop and emit it again.
    const auto usable_join = [&context](llvm::BasicBlock *j) {
        if (!j) return false;
        if (j == context.get_postheader() || j == context.get_loopheader()) return false;
        return !context.is_postheader(j);
    };

    // Triangle -- `if (c) { arm }` with no else, where one successor IS the
    // join.  That successor needs no walking: it yields the phi values for the
    // b->j edge directly.
    for (auto *arm : {t, f}) {
        auto *other = (arm == t) ? f : t;
        if (arm->getUniquePredecessor() != b) continue;
        if (arm->getUniqueSuccessor() != other) continue;
        if (!other->hasNPredecessors(2)) continue;
        if (context.require_jump_no_step(arm)) continue;
        if (usable_join(other)) return other;
    }

    // Diamond.
    const auto diamond = [&]() -> llvm::BasicBlock * {
        if (!t->getUniquePredecessor() || !f->getUniquePredecessor()) return nullptr;
        if (t->getUniquePredecessor() != b || f->getUniquePredecessor() != b) return nullptr;

        auto *j = t->getUniqueSuccessor();
        if (!j || j != f->getUniqueSuccessor()) return nullptr;
        if (!j->hasNPredecessors(2)) return nullptr;
        if (j == t || j == f) return nullptr;

        if (context.require_jump_no_step(t) || context.require_jump_no_step(f)) return nullptr;
        return usable_join(j) ? j : nullptr;
    };
    if (auto *j = diamond()) return j;

    // Neither shape matched, so compute the reconvergence point rather than
    // recognising it.  The immediate post-dominator is where the arms rejoin by
    // definition: every path out of b reaches it.  That gives the region one
    // exit; requiring every edge into it to come from inside gives it one
    // entry, which is what the predecessor counts above were approximating --
    // control must not reach the continuation except through this If, or the
    // values bound after it would not all be defined.
    //
    // A ladder of early exits has this property and matches no fixed shape,
    // however many rungs it has.
    auto *j = context.ipdom(b);
    if (!j || j == b) return nullptr;

    // A loop is emitted as a recursive call, so it is a boundary a single If
    // cannot span: leaving one is a break, not a branch to a continuation.  And
    // a header's phis are that call's parameters, not a merge.
    if (context.loop_of(j) != context.loop_of(b)) return nullptr;
    if (context.is_any_loop_header(j)) return nullptr;

    for (auto *p : llvm::predecessors(j))
        if (!context.dominates(b, p)) return nullptr;

    return usable_join(j) ? j : nullptr;
}

void SpoqIRModule::dfs_llvm_ir_to_spoq_inst_vec (llvm::BasicBlock* block, llvm::BasicBlock* parent, spoq_inst_vec_t& vec, SpoqLoopContext& context,
        llvm::BasicBlock* stop, bool join_phis_bound) {

    if (context.is_backward(parent, block)) {
        vec.push_back(std::make_unique<SpoqContinueInst>(parent));
        return;
    }

    if (context.is_exiting(parent, block)) {
        vec.push_back(std::make_unique<SpoqBreakInst>(parent));
        return;
    }

    assert (block != context.get_postheader() && "Postheader should not be visited. All exits blcoked before.");

    // This arm was told to stop at the join.  Yield what the join needs -- each
    // of its phis on this edge, plus the state as this arm leaves it -- and let
    // the caller emit everything after the join once.
    if (block == stop) {
        auto join_inst = std::make_unique<SpoqJoinInst>(block, parent);
        assert(parent && "reached a join with no predecessor to select phi values from");
        for (auto &phi : block->phis())
            join_inst->incoming.push_back(phi.getIncomingValueForBlock(parent));
        vec.push_back(std::move(join_inst));
        return;
    }

    // This block is a loop preheader.
    // The preheader's all instructions excpet for the last unconditional branch are put in the current vec.
    // The postheader's all instructions except for PHIs should be put in the current vec
    if (auto target = context.require_jump(block)) {
        // Reached once per path, like any other block the walk does not stop
        // at.  A preheader with two predecessors and no If reconverging at it
        // is entered twice, and each entry emits its own SpoqLoopInst -- the
        // call belongs on both paths, since the loop runs on both.  What there
        // is only one of is the body, which llvm_ir_to_spoq_ir fills later
        // through the map below rather than into this instruction.
        for (auto &inst: *block) {
            if (inst.isTerminator()) continue;
            // Reached as the continuation of a reconverging If, which bound
            // this block's phis already -- the same exemption the non-preheader
            // path below makes.
            if (join_phis_bound && llvm::dyn_cast<llvm::PHINode>(&inst)) continue;
            vec.push_back(std::make_unique<SpoqLLVMInst>(&inst));
        }


        // Only the first of these registrations takes, so for a loop entered on
        // several paths exactly one of the instructions ends up holding the
        // body and the rest keep an empty vector.  find_inline_asm walks all of
        // them and depends on that: two populated copies would report the same
        // asm twice.
        auto v = std::make_unique<SpoqLoopInst>(block);
        context.set_loop_inst_for_jump(block, v->body);
        vec.push_back(std::move(v));

        dfs_llvm_ir_to_spoq_inst_vec(target, nullptr, vec, context, stop);
        return;
    }


    // Non preheader
    for(auto &inst: *block) {
        if(auto phi = llvm::dyn_cast<llvm::PHINode>(&inst)) {
            if (block == context.get_loopheader()) {
                // Becomes an argument of the loop's Fixpoint.
                context.add_header_phi(phi);
                continue;
            }
            if (context.postheader_with_phi(block)) {
                // Belongs to the loop we jump over; processed with that loop.
                continue;
            }
            if (join_phis_bound) {
                // Continuation of a reconverging If, which already bound them.
                continue;
            }

            // A phi at an ordinary join.  We arrived along one edge, from
            // `parent`, so on this path the phi is that edge's incoming value.
            //
            // getIncomingValueForBlock takes the first entry for `parent`, which
            // is unambiguous even when an edge is duplicated
            // (`br i1 c, label %J, label %J`): LLVM's verifier rejects a phi
            // that gives one predecessor two different values.
            assert(parent && "join phi reached without a predecessor to select from");
            auto *incoming = phi->getIncomingValueForBlock(parent);
            assert(incoming && "phi has no incoming value for the edge we arrived on");
            vec.push_back(std::make_unique<SpoqPhiInst>(phi, incoming, parent));
            continue;
        }

        if(auto br = llvm::dyn_cast<llvm::BranchInst>(&inst)) {
            if(br->isConditional()) {
                auto cond = br->getCondition();
                auto true_block = br->getSuccessor(0);
                auto false_block = br->getSuccessor(1);
                auto *join = reconvergence_point(block, true_block, false_block, context);

                SpoqIfInst spoq_inst(cond);
                spoq_inst.join = join;
                // With a join, each arm stops there; without one, each arm runs
                // to its own return and inherits our own stop.
                auto *arm_stop = join ? join : stop;
                dfs_llvm_ir_to_spoq_inst_vec(true_block, block, spoq_inst.true_body, context, arm_stop);
                dfs_llvm_ir_to_spoq_inst_vec(false_block, block, spoq_inst.false_body, context, arm_stop);
                vec.push_back(std::make_unique<SpoqIfInst>(std::move(spoq_inst)));

                if (join) {
                    // Emitted once, after the If, rather than once per arm.  The
                    // join's own phis are bound by the If, hence join_phis_bound.
                    dfs_llvm_ir_to_spoq_inst_vec(join, block, vec, context, stop,
                                                 /*join_phis_bound=*/true);
                }
            } else {
                dfs_llvm_ir_to_spoq_inst_vec(br->getSuccessor(0), block, vec, context, stop);
            }
            return; // A br is the last instruction in a block (for a valid llvm module)
        }
        else {
            // These functions are added before
            if (block == context.get_preheader()) continue;
            vec.push_back(std::make_unique<SpoqLLVMInst>(&inst));
        }
    }
}

bool SpoqIRModule::llvm_ir_to_spoq_ir(SpoqFunction &spoq_func) {
    if(!spoq_func.cfg_converted) return false;

    spoq_func.loop_context.init(spoq_func.llvm_func);
    while(spoq_func.loop_context.step()) {
        if ( !spoq_func.loop_context.context_in_loop() )
            dfs_llvm_ir_to_spoq_inst_vec(spoq_func.loop_context.get_start(), nullptr, spoq_func.spoq_insts, spoq_func.loop_context);
        else {
            dfs_llvm_ir_to_spoq_inst_vec(spoq_func.loop_context.get_start(), nullptr, spoq_func.loop_context.get_loop_inst_for_jump(), spoq_func.loop_context);
            // Update the postheader_phi
            for (auto &inst: spoq_func.loop_context.get_postheader()->phis()) {
                spoq_func.loop_context.add_postheader_phi(&inst);
            }
        }
    }

    spoq_func.spoq_insts_converted = true;
    return true;
}

// Spoq IR <----> Spoq Coq Low Spec

unique_ptr<SpecNode> SpoqIRContext::get_llvm_value_spec(llvm::Value* value, llvm::Type* force_sym_type, bool abstraction) {
    if (value == nullptr) assert(false && "llvm value is nullptr");
    if (force_sym_type != nullptr) {
        type_map[value] = SpoqIRModule::llvm_ir_type_to_spec_pure(force_sym_type);
        return std::make_unique<Symbol>(get_llvm_value_name(value), type_map[value]);
    }

    if (llvm::dyn_cast<llvm::Constant>(value)) {
        if(auto global = llvm::dyn_cast<llvm::GlobalVariable>(value)) {
            auto const name = global->getName().str();
            assert(name != "" && "global variable name is empty");
            auto vec = std::make_unique<vector<unique_ptr<SpecNode>>>();
            vec->push_back(std::make_unique<StringConst>(name));
            vec->push_back(std::make_unique<IntConst>(0));
            auto expr = std::make_unique<Expr>("mkPtr", std::move(vec));
            // A global's address is a Ptr wherever it appears, so say so rather
            // than leave it to inference: in a variadic argument past the
            // declared parameters there is no signature to recover it from, and
            // an untyped node trips check_well_typed with "Unknown type".
            expr->type = Struct::Ptr;
            return expr;
        } else if(auto data = llvm::dyn_cast<llvm::ConstantData>(value)) {
            if (auto int_val = llvm::dyn_cast<llvm::ConstantInt>(data)) {
                if(int_val->getBitWidth() == 1) {
                    return std::make_unique<BoolConst>(!int_val->isZero());
                } else {
                    auto spec = std::make_unique<IntConst>(int_val->getSExtValue(), int_val->isNegative());
                    if (abstraction && !int_val->isNegative()) {
                        auto v = int_val->getZExtValue();
                        if (!abs_const_checked[v]) {
                            abs_const_checked[v] = true;
                            for (auto &abs : abs_config) {
                                if (!abs.constant_assumption) continue;
                                if (!(v >= abs.mem_start && v < abs.mem_start + abs.mem_size)) continue;
                                auto vec = std::make_unique<vector<unique_ptr<SpecNode>>>();
                                vec->push_back(std::make_unique<IntConst>(int_val->getSExtValue(), int_val->isNegative()));
                                abs_rely.push_back(std::make_unique<Expr>(abs.abs_wrapper_name, std::move(vec)));
                                break;
                            }
                        }
                    }
                    return spec;
                }
            } else if(auto  const*float_val = llvm::dyn_cast<llvm::ConstantFP>(data)){
                // A declared constant, not the decimal FloatConst prints: a
                // decimal is not a term the spec language has under
                // `Float := Z`, and it is the one thing here the solver used to
                // read differently from the emitted Coq.
                auto const apfloat = float_val->getValue();
                auto const name = float_literal_name(apfloat.convertToDouble());
                assert(proj && "a float literal needs a project to declare it in");
                declare_uninterpreted(proj, name,
                                      make_shared<vector<shared_ptr<SpecType>>>(), Int::INT);
                return std::make_unique<Symbol>(name, Int::INT);
            } else if(auto ptr_null = llvm::dyn_cast<llvm::ConstantPointerNull>(data)) {
                auto vec = std::make_unique<vector<unique_ptr<SpecNode>>>();
                vec->push_back(std::make_unique<StringConst>("null"));
                vec->push_back(std::make_unique<IntConst>(0));
                auto expr = std::make_unique<Expr>("mkPtr", std::move(vec));
                expr->type = Struct::Ptr;
                return expr;
            } else if (auto arr = llvm::dyn_cast<llvm::ConstantAggregateZero>(data)) {
                // The CAZ type corresponds to the special zeroinitializer constant
                // This constant can be used to initialize a value of any type to zero.
                auto ty = arr->getType();
                if(ty->isVectorTy()){
                    auto node = std::make_unique<Symbol>("zeroinitializer_vector");
                    node->type = SpoqIRModule::llvm_ir_type_to_spec_pure(ty);
                    return node;
                } else {
                    assert(false && "unsupported CAZ type");
                }
            } else if (auto undef = llvm::dyn_cast<llvm::UndefValue>(data)) {
                if (data->getType()->isIntegerTy(1)) {
                    return std::make_unique<BoolConst>(true);
                } else if (data->getType()->isIntegerTy()) {
                    // TODO: should we emit a warning here?
                    return std::make_unique<IntConst>(0);
                } else if (data->getType()->isArrayTy()) {
                    // TODO: check array element is integer
                    return std::make_unique<Symbol>("undef_zmap", this->get_llvm_value_type(undef));
                } else if (data->getType()->isPointerTy()) {
                    auto vec = std::make_unique<vector<unique_ptr<SpecNode>>>();
                    vec->push_back(std::make_unique<StringConst>("null"));
                    vec->push_back(std::make_unique<IntConst>(0));
                    auto expr = std::make_unique<Expr>("mkPtr", std::move(vec));
                    expr->type = Struct::Ptr;
                    return expr;
                }
            }
        } else if (auto expr = llvm::dyn_cast<llvm::ConstantExpr>(value)) {
            if (expr->getOpcode() == llvm::AddrSpaceCastInst::CastOps::PtrToInt) {
              auto vec = std::make_unique<vector<unique_ptr<SpecNode>>>();
              vec->push_back(this->get_llvm_value_spec(expr->getOperand(0)));
              return std::make_unique<Expr>(this->ptr2int_op_name, std::move(vec));
            } else if (expr->getOpcode() == llvm::AddrSpaceCastInst::CastOps::IntToPtr) {
              auto vec = std::make_unique<vector<unique_ptr<SpecNode>>>();
              vec->push_back(this->get_llvm_value_spec(expr->getOperand(0)));
              return std::make_unique<Expr>(this->int2ptr_op_name, std::move(vec));
            }
            else if (expr->getOpcode() == llvm::Instruction::GetElementPtr) {
                auto res = SpoqIRModule::gep_inst_to_spec(expr, *this);
                return std::move(res.second);
            } else if (expr->getOpcode() == llvm::AddrSpaceCastInst::CastOps::BitCast) {
                if (expr->getOperand(0)->getType()->isPointerTy() && value->getType()->isPointerTy()) {
                    return this->get_llvm_value_spec(expr->getOperand(0));
                }
            }
        } else if (auto func = llvm::dyn_cast<llvm::Function>(value)) {
            auto vec = std::make_unique<vector<unique_ptr<SpecNode>>>();
            vec->push_back(std::make_unique<StringConst>(func->getName().str() + "_fptr"));
            vec->push_back(std::make_unique<IntConst>(0));
            auto expr = std::make_unique<Expr>("mkPtr", std::move(vec));
            expr->type = Struct::Ptr;
            return expr;
        }

        // Parameteric constant, need to be defined in the spec file
        if (value->getType()->isIntegerTy()) {
            auto const name = get_llvm_value_name(value, &counter);
            auto const new_name = "const_" + spoq_func.llvm_func->getName().str() + name;
            llvm::errs() << "abstract constant requires definition: " << *value << " " << new_name << "\n";
            if (value->getType()->isIntegerTy(1)) return std::make_unique<Symbol>(new_name, Bool::BOOL);
            else return std::make_unique<Symbol>(new_name, Int::INT);
        }

        if (auto poison = llvm::dyn_cast<llvm::PoisonValue>(value)) {
            auto ty = poison->getType();
            if (ty->isVectorTy()) return undefined_vector_symbol(proj, "poison", ty);
            llvm::errs() << "poison value encountered: " << *poison << "\n";
            assert(false && "poison value encountered");
        }
        if (auto undef = llvm::dyn_cast<llvm::UndefValue>(value)) {
            auto ty = undef->getType();
            if (ty->isVectorTy()) return undefined_vector_symbol(proj, "undef", ty);
            llvm::errs() << "unsupported undef value encountered: " << *undef << "\n";
            assert(false && "unsupported undef value encountered");
        }

        llvm::errs() << "unsupport llvm constant: " << *value << " ty: " << *value->getType() << "\n";
        assert(false && "unsupport llvm constant");
    } else if (auto arg = llvm::dyn_cast<llvm::Argument>(value)) {
        if (type_map.find(value) == type_map.end()) {
            type_map[value] = this->get_llvm_value_type(value);
        }
        auto symbol = std::make_unique<Symbol>(get_llvm_value_name(value),
                                            type_map[value]);
        auto const abs = arg_require_abstraction(arg->getParent(), arg->getArgNo());
        if (abstraction && abs != "") {
            assert(type_map[value]->name == "Z" && "only support Z type for abstraction");
            // std::cout << "abstraction: " << abs << std::endl;
            auto vec = std::make_unique<vector<unique_ptr<SpecNode>>>();
            vec->push_back(std::move(symbol));
            auto expr = std::make_unique<Expr>("Z_to_" + abs, std::move(vec));
            expr->type = make_shared<SpecType>(abs);
            // std::cout << "abstraction: " << string(*expr) << std::endl;

            auto vec2 = std::make_unique<vector<unique_ptr<SpecNode>>>();
            vec2->push_back(std::move(expr));
            auto expr2 = std::make_unique<Expr>(abs + "_to_Z", std::move(vec2));
            expr2->type = Int::INT;
            return expr2;
        } else {
            return symbol;
        }
    } else if (auto inst = llvm::dyn_cast<llvm::Instruction>(value)) {
        if (type_map.find(value) == type_map.end()) {
            type_map[value] = this->get_llvm_value_type(value);
        }
        auto symbol = std::make_unique<Symbol>(get_llvm_value_name(value),
                                        type_map[value]);
        auto call = llvm::dyn_cast<llvm::CallInst>(value);
        if (call && abstraction) {
            auto const abs = ret_require_abstraction(call->getCalledFunction(), 0);
            if (abs != "") {
                // std::cout << string(*symbol) << " " << string(*type_map[value]) << std::endl;
                assert(type_map[value]->name == "Z" &&
                       "only support Z type for abstraction");
                // std::cout << "abstraction: " << abs << std::endl;
                auto vec = std::make_unique<vector<unique_ptr<SpecNode>>>();
                vec->push_back(std::move(symbol));
                auto expr =
                    std::make_unique<Expr>("Z_to_" + abs, std::move(vec));
                expr->type = make_shared<SpecType>(abs);
                // std::cout << "abstraction: " << string(*expr) << std::endl;

                auto vec2 = std::make_unique<vector<unique_ptr<SpecNode>>>();
                vec2->push_back(std::move(expr));
                auto expr2 =
                    std::make_unique<Expr>(abs + "_to_Z", std::move(vec2));
                expr2->type = Int::INT;
                return expr2;
            }
        }
        auto load = llvm::dyn_cast<llvm::LoadInst>(value);
        if (load && abstraction) {
            auto const abs = symbol_require_abstraction(load->getParent()->getParent(), symbol->text);
            if (abs != "") {
                assert(type_map[value]->name == "Z" &&
                       "only support Z type for abstraction");
                auto vec = std::make_unique<vector<unique_ptr<SpecNode>>>();
                vec->push_back(std::move(symbol));
                auto expr =
                    std::make_unique<Expr>("Z_to_" + abs, std::move(vec));
                expr->type = make_shared<SpecType>(abs);
                std::cout << "abstraction: " << string(*expr) << std::endl;

                auto vec2 = std::make_unique<vector<unique_ptr<SpecNode>>>();
                vec2->push_back(std::move(expr));
                auto expr2 =
                    std::make_unique<Expr>(abs + "_to_Z", std::move(vec2));
                expr2->type = Int::INT;
                return expr2;
            }
        }
        return symbol;
    } else {
        llvm::errs() << "unsupport llvm value: " << *value << " " << *(value->getType()) << "\n";
        assert(false && "unsupport llvm value");
    }
}

/// The value element of `<callee>_spec`'s result -- the `T` in
/// `option (T * RData)` -- or null when the project has no such spec.
static shared_ptr<SpecType> spec_result_type(Project *proj, llvm::CallInst *call) {
    auto const *callee = call->getCalledFunction();
    if (!proj || !callee) return nullptr;
    auto const name = callee->getName().str() + "_spec";

    shared_ptr<SpecType> fn_type;
    if (auto it = proj->decls.find(name); it != proj->decls.end()) fn_type = it->second->type;
    else if (auto it2 = proj->defs.find(name); it2 != proj->defs.end()) fn_type = it2->second->get_type();
    auto const fn = dynamic_pointer_cast<Function>(fn_type);
    if (!fn) return nullptr;

    auto const opt = dynamic_pointer_cast<Option>(fn->rettype);
    if (!opt) return nullptr;
    auto const tup = dynamic_pointer_cast<Tuple>(opt->elem_type);
    if (!tup || tup->types->empty()) return nullptr;
    return tup->types->front();
}

shared_ptr<SpecType> SpoqIRContext::get_llvm_value_type(llvm::Value* value) {
    // TODO: pointer abstraction here
    if(value->getType() == nullptr) {
        llvm::errs() << "value type: " << *value << "\n";
        assert(false && "llvm value type is nullptr");
    }

    // i1 is the one type spoq and the preprocessing passes render differently:
    // Bool here, Z there.  So a call to a spec ExtractBasics generated for an
    // i1-returning function hands back a Z, and saying Bool would make the
    // binding and its uses disagree -- z3 then aborts negating an Int for the
    // else branch of `if <that value>`.  Ask the spec rather than the LLVM
    // type.  Only for i1: everywhere else the two mappings agree.
    if (value->getType()->isIntegerTy(1))
        if (auto call = llvm::dyn_cast<llvm::CallInst>(value))
            if (auto const t = spec_result_type(proj, call)) return t;

    return SpoqIRModule::llvm_ir_type_to_spec_pure(value->getType());
}


namespace {
/// Builds the spec-side type.  The preprocessing passes build a Coq string from
/// the same traversal (include/llvm_coq_type.h); this one builds the SpecType
/// those strings have to agree with, since a spec signature emitted there is
/// checked against a body translated here.
struct SpecTypeOf {
    using result_t = shared_ptr<SpecType>;

    shared_ptr<SpecType> boolean() { return Bool::BOOL; }
    shared_ptr<SpecType> integer(unsigned) { return Int::INT; }
    shared_ptr<SpecType> pointer() { return Struct::Ptr; }

    /// A Z of unknown magnitude: `Float := Z` in every prelude, and nothing is
    /// claimed about the value.  Float::FLOAT would map it to a 64-bit IEEE
    /// sort in z3, which the emitted Coq does not agree with.
    shared_ptr<SpecType> floating(llvm::Type *) { return Int::INT; }

    shared_ptr<SpecType> voidty() { return make_shared<SpecType>("Void"); }

    /// Metadata is not a value type: it reaches an operand only through a debug
    /// intrinsic, which is stripped before translation.  Rejected rather than
    /// named, as it was before the traversal was shared.
    shared_ptr<SpecType> metadata() {
        throw std::invalid_argument("metadata is not a spec type");
    }

    shared_ptr<SpecType> structure(llvm::StructType *sty) {
        if (sty->getName().empty()) return make_shared<SpecType>(std::string());
        return make_shared<SpecType>(anonStructName(sty));
    }

    /// Both aggregates are a map from index to element, with the length left
    /// out -- prints as `(ZMap.t Z)`, which is what the passes emit too.
    shared_ptr<SpecType> array(llvm::Type *elem, uint64_t) { return mapped(elem); }
    shared_ptr<SpecType> vector(llvm::Type *elem, uint64_t) { return mapped(elem); }

    shared_ptr<SpecType> unsupported(llvm::Type *ty) {
        throw std::invalid_argument("invalid types: " + ty->getStructName().str());
    }

  private:
    shared_ptr<SpecType> mapped(llvm::Type *elem) {
        auto const elem_type = SpoqIRModule::llvm_ir_type_to_spec_pure(elem);
        assert(elem_type != SpecType::UNKNOWN_TYPE && "aggregate element type is unknown");
        return make_shared<ZMap>(elem_type);
    }
};
}  // namespace

shared_ptr<SpecType> SpoqIRModule::llvm_ir_type_to_spec_pure(llvm::Type* type) {
    SpecTypeOf builder;
    return autov::coqty::of_type(type, builder);
}

unique_ptr<SpecNode> construct_return_spec(Project  const*proj,
                                           SpoqIRContext &context) {
    if (context.continue_return) {
        auto v = std::move(context.continue_return);
        context.continue_return = nullptr;
        return v;
    }
    if (context.return_none) {
        context.return_none = false;
        return make_unique<Symbol>("None");
    }

    unique_ptr<std::vector<unique_ptr<SpecNode>>> tuple =
        std::make_unique<std::vector<unique_ptr<SpecNode>>>();
    if (context.pass_stack.size() == 0)
        assert(context.return_list.size() <= 1 &&
               "multiple return value only supported for loop component");

    if (context.return_list.size() >= 1) {
        for (int i = 0; i < context.return_list.size(); i++) {
            tuple->push_back(
                context.get_llvm_value_spec(context.return_list[i]));
        }
        if (context.return_list.size() == 1)
            context.rettype = tuple->at(0)->type;
        else {
            std::shared_ptr<std::vector<shared_ptr<SpecType>>> const children_type =
                std::make_shared<std::vector<shared_ptr<SpecType>>>();
            for (int i = 0; i < context.return_list.size(); i++) {
                children_type->push_back(
                    context.get_llvm_value_type(context.return_list[i]));
            }
            context.rettype = std::make_shared<Tuple>(children_type);
        }

        context.return_list.clear();
        tuple->push_back(std::make_unique<Symbol>(context.abs_data_name,
                                                  context.abs_data_type));
        return Shortcut::_Some_u(Shortcut::_Tuple_u(std::move(tuple)));
    } else {
        return Shortcut::_Some_u(context.get_abs_data());
    }
}
std::pair<unique_ptr<SpecNode>, unique_ptr<SpecNode>>
SpoqIRModule::gep_inst_to_spec (llvm::Value* gep_inst_or_expr, SpoqIRContext& context) {
    auto gep_inst = llvm::dyn_cast<llvm::GetElementPtrInst>(gep_inst_or_expr);
    auto gep_expr = llvm::dyn_cast<llvm::ConstantExpr>(gep_inst_or_expr);
    if ((!gep_expr || gep_expr->getOpcode() != llvm::Instruction::GetElementPtr) && !gep_inst ) {
        llvm::errs() << *gep_inst_or_expr << "\n";
        assert(false && "gep_inst_to_spec: not a gep instruction");
    }
    auto gep = llvm::dyn_cast<llvm::User>(gep_inst_or_expr);

    auto const ptr = context.get_llvm_value_spec(gep->getOperand(0));
    unique_ptr<SpecNode> expr = std::make_unique<IntConst>(0);
    assert(gep->getOperand(0)->getType()->isPointerTy() &&
           "source pointer type is not a pointer type for GEP");
    // Under opaque pointers the operand type no longer names the pointee, so read the
    // element type the GEP itself records.  GEPOperator covers both the instruction
    // and the constant-expression form handled above.
    auto source_type = llvm::cast<llvm::GEPOperator>(gep_inst_or_expr)->getSourceElementType();
    auto const c_source_type = source_type;
    std::vector<llvm::Value*> indices;
    for(int i = 1; i < gep->getNumOperands(); i++) {
        llvm::Value* index = gep->getOperand(i);
        indices.push_back(index);
        auto elem_type = llvm::GetElementPtrInst::getIndexedType(c_source_type, indices);
        if(auto sty = llvm::dyn_cast<llvm::StructType>(source_type)) {
            assert(index->getType()->isIntegerTy() && "Struct index is not integer");
            auto index_val = llvm::dyn_cast<llvm::ConstantInt>(index);
            auto const offset = context.llvm_dl->getStructLayout(sty)->getElementOffset(index_val->getZExtValue());
            auto operands = std::make_unique<std::vector<unique_ptr<SpecNode>>>();
            operands->push_back(std::move(expr));
            operands->push_back(std::make_unique<IntConst>(offset));
            expr = make_unique<Expr>(Expr::binops::ADD, std::move(operands));
        } else {
            int type_size;
            if(elem_type->isVectorTy()) type_size = context.llvm_dl->getTypeStoreSize(elem_type);
            else type_size = context.llvm_dl->getTypeAllocSize(elem_type);
            auto index_value = context.get_llvm_value_spec(index);
            auto operands = std::make_unique<std::vector<unique_ptr<SpecNode>>>();
            operands->push_back(std::move(index_value));
            operands->push_back(std::make_unique<IntConst>(type_size));
            auto mul_expr = std::make_unique<Expr>(Expr::binops::MULT,std::move(operands));
            operands = std::make_unique<std::vector<unique_ptr<SpecNode>>>();
            operands->push_back(std::move(mul_expr));
            operands->push_back(std::move(expr));
            expr = make_unique<Expr>(Expr::binops::ADD, std::move(operands));
        }
        source_type = elem_type;
    }
    auto operands = std::make_unique<vector<unique_ptr<SpecNode>>>();
    operands->push_back(context.get_llvm_value_spec(gep->getOperand(0)));
    operands->push_back(std::move(expr));
    expr = std::make_unique<Expr>(context.ptr_off_op_name, std::move(operands));
    expr->type = Struct::Ptr;
    if (gep_inst) {
        auto sym = context.get_llvm_value_spec(gep);
        return std::make_pair(std::move(sym), std::move(expr));
    } else {
        return std::make_pair(nullptr, std::move(expr));
    }
    // return Shortcut::_Let_u(std::move(sym), std::move(expr), spoq_inst_to_spec(proj, vec, num + 1, context));
}

std::pair<unique_ptr<SpecNode>, unique_ptr<SpecNode>>
SpoqIRModule::store_load_to_spec(llvm::Instruction* inst, SpoqIRContext& context) {
    if (auto load = llvm::dyn_cast<llvm::LoadInst>(inst)) {
        // TODO: pointer abstraction here
        unique_ptr<vector<unique_ptr<SpecNode>>> operands = std::make_unique<vector<unique_ptr<SpecNode>>>();
        assert(load->getPointerOperand()->getType()->isPointerTy() &&
               "load operand is not a pointer");
        auto value_type = load->getType();
        auto const value_size = context.llvm_dl->getTypeStoreSize(value_type);

        operands->push_back(make_unique<IntConst>(value_size));
        operands->push_back(context.get_llvm_value_spec(load->getPointerOperand()));
        operands->push_back(context.get_abs_data());

        // auto children = std::make_unique<vector<unique_ptr<SpecNode>>>();
        unique_ptr<SpecNode> ret = nullptr;
        if (value_type->isIntegerTy()) {
            ret = context.get_llvm_value_spec(load, nullptr, false);
            std::unique_ptr<SpecNode> expr = std::make_unique<Expr>(context.load_op_name, std::move(operands));
            // llvm::errs() << *inst << "\n";
            // llvm::errs() << *value_type << "\n";
            // auto int_ty = llvm::dyn_cast<llvm::IntegerType>(value_type);
            // inst->getModule()->getNamedMetadata(int_ty->deb)
            // int_ty->
            return std::make_pair(std::move(ret), std::move(expr));
        }
        else if (value_type->isPointerTy()) {
            ret = context.get_llvm_value_spec_ptr_in_Z(load);
        }
        else if (value_type->isFloatingPointTy()){
            ret = context.get_llvm_value_spec(load, nullptr, false);
        }
        else {
            assert(false && "load value type not supported");
        }
        // children->push_back(context.get_abs_data());
        // auto ret = Shortcut::_Tuple_u(std::move(children));
        auto expr = std::make_unique<Expr>(context.load_op_name, std::move(operands));
        return std::make_pair(std::move(ret), std::move(expr));
    } else if (auto store = llvm::dyn_cast<llvm::StoreInst>(inst)) {
        unique_ptr<vector<unique_ptr<SpecNode>>> operands = std::make_unique<vector<unique_ptr<SpecNode>>>();
        auto value_type = store->getValueOperand()->getType();
        auto const value_size = context.llvm_dl->getTypeStoreSize(value_type);
        operands->push_back(make_unique<IntConst>(value_size));
        operands->push_back(context.get_llvm_value_spec(store->getPointerOperand()));
        auto value_op = context.get_llvm_value_spec(store->getValueOperand());
        if (value_type->isIntegerTy()) {
            operands->push_back(std::move(value_op));
        } else if (value_type->isPointerTy()) {
            auto vec = std::make_unique<vector<unique_ptr<SpecNode>>>();
            vec->push_back(std::move(value_op));
            // TODO: pointer abstraction here
            operands->push_back(std::make_unique<Expr>(context.ptr2int_op_name, std::move(vec)));
        } else if (value_type->isFloatingPointTy() ){
            operands->push_back(std::move(value_op));
        } else {
            llvm::errs() << "store inst:" << *store << "\n";
            llvm::errs() << "store value type: " << *value_type << "\n";
            assert(false && "store value type not supported");
        }
        operands->push_back(context.get_abs_data());

        auto ret = context.get_abs_data();
        return std::make_pair(std::move(ret), std::make_unique<Expr>(context.store_op_name, std::move(operands)));
    }
    assert(false && "store_load_to_spec: Not implemented yet[store inst]");
}

unique_ptr<SpecNode> SpoqIRModule::spoq_inst_to_spec(Project* proj, spoq_inst_vec_t& vec, int num, SpoqIRContext& context) {
    if(num >= vec.size()) {
        return construct_return_spec(proj, context);
    }

    if (auto spoq_inst = Shortcut::dyn_cast_u<SpoqLLVMInst>(vec[num])) {
        // LOG_DEBUG << (spoq_inst->get_llvm_inst()->getOpcodeName());

        // Terminator
        if (auto ret = llvm::dyn_cast<llvm::ReturnInst>(spoq_inst->inst)) {
            assert(num == vec.size() - 1);
            if(auto rv = ret->getReturnValue()) context.return_list.push_back(rv);
            return spoq_inst_to_spec(proj, vec, num + 1, context);
        }
        if (auto ret = llvm::dyn_cast<llvm::UnreachableInst>(spoq_inst->inst)) {
            assert(num == vec.size() - 1 && "unreachable is not the last inst");
            context.return_none = true;
            return spoq_inst_to_spec(proj, vec, num + 1, context);
        }

        // Floating point, before the arms below get a chance at it: every
        // float computation is one uninterpreted application, whatever its
        // opcode.  Ahead of them because fmul is a BinaryOperator and sitofp a
        // CastInst, and those arms would otherwise claim them.
        if (is_float_computation(spoq_inst->inst)) {
            auto *inst = spoq_inst->inst;
            auto const name = float_op_name(inst);
            auto arg_types = make_shared<vector<shared_ptr<SpecType>>>();
            auto operands = std::make_unique<vector<unique_ptr<SpecNode>>>();
            for (auto const &op : inst->operands()) {
                arg_types->push_back(context.get_llvm_value_type(op));
                operands->push_back(context.get_llvm_value_spec(op));
            }
            declare_uninterpreted(proj, name, arg_types,
                                  SpoqIRModule::llvm_ir_type_to_spec_pure(inst->getType()));
            auto expr = std::make_unique<Expr>(name, std::move(operands));
            expr->type = SpoqIRModule::llvm_ir_type_to_spec_pure(inst->getType());
            return Shortcut::_Let_u(context.get_llvm_value_spec(inst), std::move(expr),
                                    spoq_inst_to_spec(proj, vec, num + 1, context));
        }

        // Binary Operation
        if (auto bi = llvm::dyn_cast<llvm::BinaryOperator>(spoq_inst->inst)) {
            unique_ptr<vector<unique_ptr<SpecNode>>> operands = std::make_unique<vector<unique_ptr<SpecNode>>>();
            auto op0 = context.get_llvm_value_spec(bi->getOperand(0));
            auto op1 = context.get_llvm_value_spec(bi->getOperand(1));

            auto ptr0 = context.is_ptr_to_int(bi->getOperand(0));
            auto ptr1 = context.is_ptr_to_int(bi->getOperand(1));

            bool const movein = bi->getOpcode() == llvm::Instruction::BinaryOps::Add && ((!ptr0) != (!ptr1));
            std::unique_ptr<SpecNode> movein_base = nullptr;
            bool const reduce = bi->getOpcode() == llvm::Instruction::BinaryOps::Sub && ptr0;

            std::unique_ptr<Expr> rely_expr = nullptr;
            auto rely_operands = std::make_unique<vector<unique_ptr<SpecNode>>>();

            if ( reduce || movein ) {
                if (ptr0) {
                    rely_operands->push_back(context.ptr2int_to_field(ptr0, "pbase"));
                    if (movein) movein_base = context.ptr2int_to_field(ptr0, "pbase");
                    operands->push_back(context.ptr2int_to_field(ptr0, "poffset"));
                } else {
                    rely_operands->push_back(context.get_llvm_value_spec(bi->getOperand(0)));
                    operands->push_back(std::move(op0));
                }
                if (ptr1) {
                    rely_operands->push_back(context.ptr2int_to_field(ptr1, "pbase"));
                    if (movein) movein_base = context.ptr2int_to_field(ptr1, "pbase");
                    operands->push_back(context.ptr2int_to_field(ptr1, "poffset"));
                } else {
                    rely_operands->push_back(context.get_llvm_value_spec(bi->getOperand(1)));
                    operands->push_back(std::move(op1));
                }
                if (ptr0 && ptr1) {
                    rely_expr = std::make_unique<Expr>(Expr::EQUAL, std::move(rely_operands));
                }
            } else {
                operands->push_back(std::move(op0));
                operands->push_back(std::move(op1));
            }

            unique_ptr<SpecNode> expr = nullptr;

            if (bi->getOpcode() == llvm::Instruction::BinaryOps::Xor) {
                if(bi->getOperand(0)->getType()->isIntegerTy(1)) {
                    expr = std::make_unique<Expr>("xorb_spec", std::move(operands));
                } else {
                    expr = std::make_unique<Expr>("Z.lxor", std::move(operands));
                }
            } else if (bi->getOperand(0)->getType()->isIntegerTy(1)) {
                assert(bi->getOperand(1)->getType()->isIntegerTy(1) && "Binary operation on bool and ?");
                assert(bool_binops_lut.find(bi->getOpcode()) != bool_binops_lut.end() && "Binary operation not supported");
                expr = std::make_unique<Expr>(bool_binops_lut.at(bi->getOpcode()), std::move(operands));
            } else if(binops_lut.find(bi->getOpcode()) != binops_lut.end()) {
                bool const shift_to_div = (bi->getOpcode() == llvm::Instruction::BinaryOps::LShr || bi->getOpcode() == llvm::Instruction::BinaryOps::AShr)
                    && bi->getOperand(0)->getType()->isIntegerTy(64) && bi->getOperand(1)->getType()->isIntegerTy(64);
                bool const shift_to_mul = bi->getOpcode() == llvm::Instruction::BinaryOps::Shl && bi->getOperand(0)->getType()->isIntegerTy(64) && bi->getOperand(1)->getType()->isIntegerTy(64);
                auto num = llvm::dyn_cast<llvm::ConstantInt>(bi->getOperand(1));
                if (num && (shift_to_div || shift_to_mul)) {
                    auto const val = num->getZExtValue();
                    operands->pop_back();
                    operands->push_back(std::make_unique<IntConst>(1LL << val));
                    if (shift_to_div)
                       expr = std::make_unique<Expr>(Expr::binops::DIV, std::move(operands));
                    else  if (shift_to_mul)
                       expr = std::make_unique<Expr>(Expr::binops::MULT, std::move(operands));
                    else assert(false && "unexpected shift operation");
                } else {
                    // RJS most div exprs are made here.
                   expr = std::make_unique<Expr>(binops_lut.at(bi->getOpcode()), std::move(operands));
                    if(bi->getOpcode() == llvm::Instruction::BinaryOps::UDiv){
                        auto bexpr_elems = make_unique<std::vector<std::unique_ptr<SpecNode>>>();
                        bexpr_elems->push_back(expr->deep_copy());
                        bexpr_elems->push_back(make_unique<IntConst>(0));
                        auto bexpr = make_unique<Expr>(Expr::binops::GTE, std::move(bexpr_elems));
                        // expr = make_unique<Rely>(std::move(bexpr), std::move(expr));
                        rely_expr = std::move(bexpr);
                    }
                }
            }
            if (expr == nullptr) {
                llvm::errs() << "Binary operation not supported: " << *bi << "\n";
                assert(false && "Binary operation not supported");
            }

            if (movein) {
                assert(movein_base != nullptr && "move offset into the base");
                auto children = make_unique<vector<unique_ptr<SpecNode>>>();
                children->push_back(movein_base->deep_copy());
                children->push_back(std::move(expr));
                auto mkptr = std::make_unique<Expr>("mkPtr", std::move(children));
                auto operands = std::make_unique<vector<unique_ptr<SpecNode>>>();
                operands->push_back(std::move(mkptr));
                expr = std::make_unique<Expr>(context.ptr2int_op_name, std::move(operands));
            }

            unique_ptr<SpecNode> sym = context.get_llvm_value_spec(bi);
            context.add_cache(context.get_llvm_value_name(bi), expr);

            auto remain = spoq_inst_to_spec(proj, vec, num + 1, context);

            auto new_expr = context.apply_abstraction(std::move(expr));
            context.add_cache(context.get_llvm_value_name(bi), new_expr);
            auto _let =  Shortcut::_Let_u(std::move(sym), std::move(new_expr), std::move(remain));
            if (rely_expr) {
                return std::make_unique<Rely>(std::move(rely_expr), std::move(_let));
            } else {
                return _let;
            }
        } else if(auto cmp = llvm::dyn_cast<llvm::CmpInst>(spoq_inst->inst)) {
            unique_ptr<vector<unique_ptr<SpecNode>>> operands = std::make_unique<vector<unique_ptr<SpecNode>>>();
            operands->push_back(context.get_llvm_value_spec(cmp->getOperand(0)));
            operands->push_back(context.get_llvm_value_spec(cmp->getOperand(1)));
            unique_ptr<Expr> expr = nullptr;
            if (cmp->getOperand(0)->getType()->isPointerTy()) {
                if (cmp->getPredicate() == llvm::CmpInst::Predicate::ICMP_EQ) {
                    expr = std::make_unique<Expr>(context.ptr_eqb_op_name, std::move(operands));
                }
                else if (cmp->getPredicate() == llvm::CmpInst::Predicate::ICMP_ULT) {
                    expr = std::make_unique<Expr>(context.ptr_ltb_op_name, std::move(operands));
                }
                else if (cmp->getPredicate() == llvm::CmpInst::Predicate::ICMP_NE) {
                    expr = std::make_unique<Expr>(context.ptr_eqb_op_name, std::move(operands));
                    operands = std::make_unique<vector<unique_ptr<SpecNode>>>();
                    operands->push_back(std::move(expr));
                    expr = std::make_unique<Expr>(Expr::ops::BNOT, std::move(operands));
                } else if (cmp->getPredicate() == llvm::CmpInst::Predicate::ICMP_ULE) {
                    expr = std::make_unique<Expr>(context.ptr_leb_op_name, std::move(operands));

                } else if (cmp->getPredicate() == llvm::CmpInst::Predicate::ICMP_UGT) {
                    expr = std::make_unique<Expr>(context.ptr_ugt_op_name, std::move(operands));
                } else {
                    llvm::errs() << "Unsupported binary cmp operation with pointer operand" << "\n";
                }
            } else if(cmpops_lut.find(cmp->getPredicate()) != cmpops_lut.end()) {
                expr = std::make_unique<Expr>(cmpops_lut.at(cmp->getPredicate()), std::move(operands));
            }// z3 only has signed integers, so signed and unsigned gt should be the same
            if (expr == nullptr) {
                llvm::errs() << "Binary Cmp operation not supported: " << *cmp << "\n";
                assert(false && "Binary Cmp operation not supported");
            }
            unique_ptr<SpecNode> const sym = context.get_llvm_value_spec(cmp);
            context.add_cache(context.get_llvm_value_name(cmp), expr);
            auto new_expr = context.apply_abstraction(std::move(expr));
            return Shortcut::_Let_u(context.get_llvm_value_spec(cmp), std::move(new_expr), spoq_inst_to_spec(proj, vec, num + 1, context));
        }

        // function call
        if (auto call = llvm::dyn_cast<llvm::CallInst>(spoq_inst->inst)) {

            if (call->isDebugOrPseudoInst()) {
                return spoq_inst_to_spec(proj, vec, num + 1, context);
            }
            if (call->isInlineAsm()) {
                    auto iasm = llvm::dyn_cast<llvm::InlineAsm>(call->getCalledOperand());
                    assert(iasm && "Not an inline asm when isInlineAsm() is true");

                    auto args = std::make_unique<vector<unique_ptr<SpecNode>>>();
                    for(int i = 0; i < call->arg_size(); i++) {
                        args->push_back(context.get_llvm_value_spec(call->getArgOperand(i)));
                    }
                    args->push_back(context.get_abs_data());

                    unique_ptr<SpecNode> ret = nullptr;
                    if(call->getType()->isVoidTy()) {
                        ret = context.get_abs_data();
                    } else {
                        auto children = std::make_unique<vector<unique_ptr<SpecNode>>>();
                        children->push_back(context.get_llvm_value_spec(call));
                        children->push_back(context.get_abs_data());
                        ret = Shortcut::_Tuple_u(std::move(children));
                    }


                    auto callee_name = proj->spoq_code.iasm2func[call] + "_spec";
                    auto expr = std::make_unique<Expr>(callee_name, std::move(args));

                    auto remain = spoq_inst_to_spec(proj, vec, num + 1, context);
                    return Shortcut::_When_u(std::move(ret), std::move(expr), std::move(remain));
            }
            else if (auto callee = call->getCalledOperand()) {

                auto callee_func = call->getCalledFunction();
                if (callee_func && callee_func->isIntrinsic()) {
                    // A floating point intrinsic is uninterpreted, like every
                    // other float computation.  This is the one genuinely
                    // open-ended part -- llvm.fabs, fmuladd, round, floor,
                    // is.fpclass, pow, lrint, sqrt and more appear in the
                    // corpus -- so it is a rule about the types rather than a
                    // list of names.  Anything else keeps the assert.
                    bool touches_float = call->getType()->isFPOrFPVectorTy();
                    for (auto const &a : call->args())
                        if (a->getType()->isFPOrFPVectorTy()) touches_float = true;
                    if (touches_float) {
                        auto const name = float_intrinsic_name(callee_func->getName());
                        auto arg_types = make_shared<vector<shared_ptr<SpecType>>>();
                        auto operands = std::make_unique<vector<unique_ptr<SpecNode>>>();
                        for (auto const &a : call->args()) {
                            arg_types->push_back(context.get_llvm_value_type(a));
                            operands->push_back(context.get_llvm_value_spec(a));
                        }
                        auto const rettype = llvm_ir_type_to_spec_pure(call->getType());
                        declare_uninterpreted(proj, name, arg_types, rettype);
                        auto expr = std::make_unique<Expr>(name, std::move(operands));
                        expr->type = rettype;
                        return Shortcut::_Let_u(context.get_llvm_value_spec(call), std::move(expr),
                                                spoq_inst_to_spec(proj, vec, num + 1, context));
                    }
                    llvm::errs() << "Intrinsic function call: " << *call << "\n";
                    assert(false && "Not impl: intrinsic function call");
                } else if (callee_func && callee->getName().starts_with("llvm_dbg_")) {
                    return spoq_inst_to_spec(proj, vec, num + 1, context);
                } else if (callee_func && proj->disable_funcs[callee->getName().str()]) {
                    return spoq_inst_to_spec(proj, vec, num + 1, context);
                }

                auto args = std::make_unique<vector<unique_ptr<SpecNode>>>();
                if (!callee_func) args->push_back(context.get_llvm_value_spec(callee));
                for(int i = 0; i < call->arg_size(); i++) {
                    args->push_back(context.get_llvm_value_spec(call->getArgOperand(i)));
                }
                args->push_back(context.get_abs_data());

                // Note: what the callee's memory attributes imply about the state is
                // no longer decided here.  For an external declaration it is baked
                // into the synthesised body of <callee>_spec (see
                // SpoqIRModule::synthesize_attribute_specs), so it arrives once, at
                // unfold time, instead of being re-derived at every callsite.

                unique_ptr<SpecNode> ret = nullptr;
                if(call->getType()->isVoidTy()) {
                    ret = context.get_abs_data();
                } else {
                    auto children = std::make_unique<vector<unique_ptr<SpecNode>>>();
                    children->push_back(context.get_llvm_value_spec(call, nullptr, false));
                    children->push_back(context.get_abs_data());
                    ret = Shortcut::_Tuple_u(std::move(children));
                }

                auto callee_name = callee->getName().str() + "_spec";
                if (!callee_func) {
                    callee_name = context.get_llvm_value_name(callee) + "_" + std::to_string(call->arg_size()) + "_fptr_";
                    callee_name = callee_name + context.spoq_func.llvm_func->getName().str() + "_spec";

                    // Nothing says what the pointer refers to.  Declare the spec
                    // rather than leaving the name dangling: an uninterpreted
                    // function of the pointer, the arguments and the state, which
                    // is how an external declaration's spec is treated.  A project
                    // that knows better can still define or declare it itself --
                    // this only fills the gap.
                    if (proj->defs.find(callee_name) == proj->defs.end() &&
                        proj->decls.find(callee_name) == proj->decls.end()) {
                        auto fn_args = make_shared<vector<shared_ptr<SpecType>>>();
                        fn_args->push_back(context.get_llvm_value_type(callee));
                        for (unsigned i = 0; i < call->arg_size(); i++)
                            fn_args->push_back(context.get_llvm_value_type(call->getArgOperand(i)));
                        fn_args->push_back(context.abs_data_type);

                        shared_ptr<SpecType> rettype;
                        if (call->getType()->isVoidTy()) {
                            rettype = make_shared<Option>(context.abs_data_type);
                        } else {
                            auto elems = make_shared<vector<shared_ptr<SpecType>>>();
                            elems->push_back(context.get_llvm_value_type(call));
                            elems->push_back(context.abs_data_type);
                            rettype = make_shared<Option>(make_shared<Tuple>(elems));
                        }

                        LOG_INFO << "[FPTR] declaring " << callee_name
                                 << " for an indirect call with no spec" << std::endl;
                        // The LowSpec of the function that calls through the
                        // pointer, which is where the reference to this name
                        // will be.  loc_t("", "", "") would register the
                        // declaration and never emit it: gen_low_spec writes
                        // the Decls whose loc is the section it is generating,
                        // and treats the empty loc as "nowhere".
                        proj->add_declaration(
                            make_unique<Declaration>(callee_name,
                                                     make_shared<Function>(rettype, fn_args)),
                            make_shared<loc_t>(proj->layers[context.layer_id]->name,
                                               context.fname(), Project::LOC_LOWSPEC));
                    }
                }

                auto expr = std::make_unique<Expr>(callee_name, std::move(args));
                auto new_expr = context.apply_abstraction(std::move(expr));

                auto remain = spoq_inst_to_spec(proj, vec, num + 1, context);

                if (proj->cmds.PostEnsure.find(callee->getName().str()) != proj->cmds.PostEnsure.end()) {
                    for (auto & prop : proj->cmds.PostEnsure[callee->getName().str()]) {
                        auto p = prop->deep_copy();
                        if (call->getType()->isVoidTy()) {
                            Shortcut::subst_expression(p.get(), "ret_0", context.abs_data_name);
                        } else{
                            Shortcut::subst_expression(p.get(), "ret_0", context.get_llvm_value_name(call));
                            Shortcut::subst_expression(p.get(), "ret_1", context.abs_data_name);
                        }
                        remain = std::make_unique<Rely>(std::move(p), std::move(remain));
                    }
                }

                return Shortcut::_When_u(std::move(ret), std::move(new_expr), std::move(remain));
            } else {
                llvm::errs() << "No inline asm && No called function found: " << *call << "\n";
                assert(false && "No inline asm && No called function found");
            }
        }


        if (auto load = llvm::dyn_cast<llvm::LoadInst>(spoq_inst->inst)) {
            auto rhs = store_load_to_spec(spoq_inst->inst, context);
            if (load->getType()->isPointerTy()) {
                // TODO: pointer abstraction here

                auto children = std::make_unique<vector<unique_ptr<SpecNode>>>();
                children->push_back(context.get_llvm_value_spec_ptr_in_Z(load));
                auto i2p_v = std::make_unique<Expr>(context.int2ptr_op_name, std::move(children));

                auto remain_expr = Shortcut::_Let_u(context.get_llvm_value_spec(load, nullptr, false), std::move(i2p_v), spoq_inst_to_spec(proj, vec, num + 1, context));
                return Shortcut::_When_u(std::move(rhs.first), std::move(rhs.second), std::move(remain_expr));
            } else {
                return Shortcut::_When_u(std::move(rhs.first), std::move(rhs.second), spoq_inst_to_spec(proj, vec, num + 1, context));
            }
        } else if (auto store = llvm::dyn_cast<llvm::StoreInst>(spoq_inst->inst)) {
            auto rhs = store_load_to_spec(spoq_inst->inst, context);
            return Shortcut::_When_u(std::move(rhs.first), std::move(rhs.second), spoq_inst_to_spec(proj, vec, num + 1, context));
        }

        if (auto alloc = llvm::dyn_cast<llvm::AllocaInst>(spoq_inst->inst)) {
            std::string name;
            if (!alloc->getName().empty()) name = alloc->getName().str();
            else {
                llvm::raw_string_ostream os(name);
                alloc->printAsOperand(os, false, proj->spoq_code.llvm_module.get());
                name.erase(0, 1);
            }
            name = "v_" + Shortcut::replace_dot(name);
            auto local_names = proj->cmds.StackMap[context.spoq_func.llvm_func->getName().str()];
            auto const stack_var = local_names[name];
             // TODO: should we use some more stable way to get the stack_var name?
            if(stack_var.empty()) llvm::errs() << "*alloca: " << *alloc << "\n";
            assert(!stack_var.empty() && "stack_var is empty");
            auto children = make_unique<vector<unique_ptr<SpecNode>>>();
            children->push_back(make_unique<StringConst>(stack_var));
            children->push_back(make_unique<IntConst>(0));
            auto mkptr = std::make_unique<Expr>("mkPtr", std::move(children));
            context.add_cache(context.get_llvm_value_name(alloc), mkptr);
            return Shortcut::_Let_u(context.get_llvm_value_spec(alloc), std::move(mkptr), spoq_inst_to_spec(proj, vec, num + 1, context));
        }

        if (auto gep = llvm::dyn_cast<llvm::GetElementPtrInst>(spoq_inst->inst)) {
            auto const ptr = context.get_llvm_value_spec(gep->getPointerOperand());
            unique_ptr<SpecNode> expr = std::make_unique<IntConst>(0);
            auto source_element_type = gep->getPointerOperandType();
            std::vector<llvm::Value*> indices;
            // llvm::errs() << "\n" << *gep << "\n";

            // A getElementPtr command may have many indexes into a nested aggregate structure.
            // This constructs a (ptr_offset base_ptr (... result of indexing ...))
            // In the end, however, we should know that the resulting pointer's offset % size = result of indexing.
            // Otherwise we would have UB.
            for(auto idx = gep->idx_begin(); idx != gep->idx_end(); ++idx) {

                llvm::Value* index = *idx;
                indices.push_back(index);
                auto elem_type = llvm::GetElementPtrInst::getIndexedType(gep->getSourceElementType(), indices);
                if(auto sty = llvm::dyn_cast<llvm::StructType>(source_element_type)) {
                    assert(index->getType()->isIntegerTy() && "Struct index is not integer");
                    auto index_val = llvm::dyn_cast<llvm::ConstantInt>(index);
                    // llvm::errs() << *gep << "\n";
                    // llvm::errs() << "*index_val: " << *index << "\n";
                    assert(index_val && "index is not a constant integer");
                    auto const offset = context.llvm_dl->getStructLayout(sty)->getElementOffset(index_val->getZExtValue());
                    auto operands = std::make_unique<std::vector<unique_ptr<SpecNode>>>();
                    operands->push_back(std::move(expr));
                    operands->push_back(std::make_unique<IntConst>(offset));
                    expr = make_unique<Expr>(Expr::binops::ADD, std::move(operands));
                } else {
                    int type_size;
                    if(elem_type->isVectorTy()) type_size = context.llvm_dl->getTypeStoreSize(elem_type);
                    else type_size = context.llvm_dl->getTypeAllocSize(elem_type);
                    auto index_value = context.get_llvm_value_spec(index);
                    auto operands = std::make_unique<std::vector<unique_ptr<SpecNode>>>();
                    operands->push_back(std::move(index_value));
                    operands->push_back(std::make_unique<IntConst>(type_size));
                    auto mul_expr = std::make_unique<Expr>(Expr::binops::MULT,std::move(operands));
                    operands = std::make_unique<std::vector<unique_ptr<SpecNode>>>();
                    operands->push_back(std::move(mul_expr));
                    operands->push_back(std::move(expr));
                    expr = make_unique<Expr>(Expr::binops::ADD, std::move(operands));
                }
                source_element_type = elem_type;
            }
            auto operands = std::make_unique<vector<unique_ptr<SpecNode>>>();
            operands->push_back(context.get_llvm_value_spec(gep->getPointerOperand()));
            auto offset_calc = expr->deep_copy();
            operands->push_back(std::move(expr));
            expr = std::make_unique<Expr>(context.ptr_off_op_name, std::move(operands));
            expr->type = Struct::Ptr;
            // We just constructed a pointer.  How can we express that the pointer is going to be aligned?`
            auto sym = context.get_llvm_value_spec(gep);
            context.add_cache(context.get_llvm_value_name(gep), expr);
            auto pointed_type = gep->getSourceElementType();
            std::unique_ptr<SpecNode> result;
            if(pointed_type->isStructTy()){
                // This rely clause should express that the resulting pointer is aligned with the proper field
                // We want sym.(poffset) % size_of_aggregate = (calculated_offset).
                std::unique_ptr<SpecNode> mod_expr = sym->deep_copy();

                auto record_get_elems = make_unique<std::vector<unique_ptr<SpecNode>>>();
                record_get_elems->push_back(std::move(mod_expr));
                record_get_elems->push_back(make_unique<Symbol>("poffset"));
                mod_expr = make_unique<Expr>(Expr::RecordGet, std::move(record_get_elems));
                auto mod_elems = make_unique<std::vector<unique_ptr<SpecNode>>>();
                mod_elems->push_back(std::move(mod_expr));
                // calculate total aggregate size
                auto const aggregate_size = context.llvm_dl->getTypeAllocSize(pointed_type);
                mod_elems->push_back(make_unique<IntConst>(aggregate_size));
                mod_expr = make_unique<Expr>(Expr::binops::MOD, std::move(mod_elems));
                auto rely_prop_elems = make_unique<std::vector<unique_ptr<SpecNode>>>();
                rely_prop_elems->push_back(std::move(mod_expr));
                rely_prop_elems->push_back(std::move(offset_calc));
                auto rely_prop = make_unique<Expr>(Expr::binops::EQUAL, std::move(rely_prop_elems));
                auto rely_clause = make_unique<Rely>(std::move(rely_prop), spoq_inst_to_spec(proj, vec, num + 1, context));
                result = Shortcut::_Let_u(std::move(sym), std::move(expr), std::move(rely_clause));
            } else {
                result = Shortcut::_Let_u(std::move(sym), std::move(expr), spoq_inst_to_spec(proj, vec, num + 1, context));
            }
            // llvm::errs() << "\n" << *gep << "\n";
            // LOG_DEBUG << string(*result);
            return result;
        }
        if (auto ins = llvm::dyn_cast<llvm::InsertElementInst>(spoq_inst->inst)) {

            // operands are vector, value, index
            auto array = ins->getOperand(0);
            auto val = ins->getOperand(1);
            auto idx = llvm::dyn_cast<llvm::ConstantInt>(ins->getOperand(2));
            if (!idx){
                assert(false && "InsertElement only supported with constant index.");
            }

            auto operands = std::make_unique<vector<unique_ptr<SpecNode>>>();
            operands->push_back(context.get_llvm_value_spec(array));
            operands->push_back(std::make_unique<IntConst>(idx->getZExtValue()));
            operands->push_back(context.get_llvm_value_spec(val));
            auto expr = std::make_unique<Expr>(Expr::ops::SET, std::move(operands));
            auto sym = context.get_llvm_value_spec(ins);
            context.add_cache(context.get_llvm_value_name(ins), expr);
            return Shortcut::_Let_u(std::move(sym), std::move(expr), spoq_inst_to_spec(proj, vec, num + 1, context));
        }
        if (auto ex = llvm::dyn_cast<llvm::ExtractValueInst>(spoq_inst->inst)) {
            assert(ex->getNumIndices() == 1 && "ExtractValueInst with 0 or multiple indices not supported");
            auto array = ex->getAggregateOperand();
            auto operands = std::make_unique<vector<unique_ptr<SpecNode>>>();
            operands->push_back(context.get_llvm_value_spec(array));
            for(auto const index: ex->getIndices()) {
                operands->push_back(std::make_unique<IntConst>(index));
            }
            auto expr = std::make_unique<Expr>(Expr::ops::GET, std::move(operands));
            auto sym = context.get_llvm_value_spec(ex);
            context.add_cache(context.get_llvm_value_name(spoq_inst->inst), expr);
            return Shortcut::_Let_u(std::move(sym), std::move(expr), spoq_inst_to_spec(proj, vec, num + 1, context));
        } else if (auto in = llvm::dyn_cast<llvm::InsertValueInst>(spoq_inst->inst)) {
            assert(in->getNumIndices() == 1 && "InsertValueInst with 0 or multiple indices not supported");
            auto array = in->getAggregateOperand();
            auto operands = std::make_unique<vector<unique_ptr<SpecNode>>>();
            operands->push_back(context.get_llvm_value_spec(array));
            for(auto const index: in->getIndices()) {
                operands->push_back(std::make_unique<IntConst>(index));
            }
            operands->push_back(context.get_llvm_value_spec(in->getInsertedValueOperand()));
            auto expr = std::make_unique<Expr>(Expr::ops::SET, std::move(operands));
            auto sym = context.get_llvm_value_spec(in);
            context.add_cache(context.get_llvm_value_name(in), expr);
            return Shortcut::_Let_u(std::move(sym), std::move(expr), spoq_inst_to_spec(proj, vec, num + 1, context));
        }


        // pointer-integer conversion
        if (auto p2i = llvm::dyn_cast<llvm::PtrToIntInst>(spoq_inst->inst)) {
            auto operands = std::make_unique<vector<unique_ptr<SpecNode>>>();
            operands->push_back(context.get_llvm_value_spec(p2i->getPointerOperand()));
            auto expr = std::make_unique<Expr>(context.ptr2int_op_name, std::move(operands));
            auto sym = context.get_llvm_value_spec(p2i);
            context.add_cache(context.get_llvm_value_name(p2i), expr);
            return Shortcut::_Let_u(std::move(sym), std::move(expr), spoq_inst_to_spec(proj, vec, num + 1, context));
        } else if (auto i2p = llvm::dyn_cast<llvm::IntToPtrInst>(spoq_inst->inst)) {
            auto operands = std::make_unique<vector<unique_ptr<SpecNode>>>();
            operands->push_back(context.get_llvm_value_spec(i2p->getOperand(0)));
            auto expr = std::make_unique<Expr>(context.int2ptr_op_name, std::move(operands));
            auto sym = context.get_llvm_value_spec(i2p);
            context.add_cache(context.get_llvm_value_name(i2p), expr);
            return Shortcut::_Let_u(std::move(sym), std::move(expr), spoq_inst_to_spec(proj, vec, num + 1, context));
        }

        // TODO: other conversion operations
        if (auto sel = llvm::dyn_cast<llvm::SelectInst>(spoq_inst->inst)) {
            //   %r = select i1 %c, T %a, T %b
            // becomes
            //   let r := (if c then a else b) in <rest>
            auto sym = context.get_llvm_value_spec(sel);
            auto expr = std::make_unique<If>(
                as_condition(context.get_llvm_value_spec(sel->getCondition())),
                context.get_llvm_value_spec(sel->getTrueValue()),
                context.get_llvm_value_spec(sel->getFalseValue()));
            return Shortcut::_Let_u(std::move(sym), std::move(expr),
                                    spoq_inst_to_spec(proj, vec, num + 1, context));
        }

        if (auto bc = llvm::dyn_cast<llvm::CastInst>(spoq_inst->inst)) {
            auto src = bc->getSrcTy();
            auto dst = bc->getDestTy();
            if (src->isPointerTy() && dst->isPointerTy()) {
                auto sym = context.get_llvm_value_spec(bc);
                auto expr = context.get_llvm_value_spec(bc->getOperand(0));
                context.add_cache(context.get_llvm_value_name(bc), expr);
                return Shortcut::_Let_u(std::move(sym), std::move(expr), spoq_inst_to_spec(proj, vec, num + 1, context));
            } else if (src->isIntegerTy() && dst->isIntegerTy()) {
                if (llvm::dyn_cast<llvm::ZExtInst>(bc) && src->isIntegerTy(1)) {
                    auto sym = context.get_llvm_value_spec(bc);
                    auto args = std::make_unique<vector<unique_ptr<SpecNode>>>();
                    args->push_back(context.get_llvm_value_spec(bc->getOperand(0)));
                    // auto expr = std::make_unique<Expr>("spoq_zext_spec", std::move(args));
                    auto expr = std::make_unique<If>(
                        as_condition(context.get_llvm_value_spec(bc->getOperand(0))),
                        std::make_unique<IntConst>(1), std::make_unique<IntConst>(0));
                    // context.add_cache(context.get_llvm_value_name(bc), expr);
                    return Shortcut::_Let_u(std::move(sym), std::move(expr), spoq_inst_to_spec(proj, vec, num + 1, context));
                }
                // TODO: overflow / underflow check
                // is this sext?
                auto sym = context.get_llvm_value_spec(bc);
                auto expr = context.get_llvm_value_spec(bc->getOperand(0));
                context.add_cache(context.get_llvm_value_name(bc), expr);
                return Shortcut::_Let_u(std::move(sym), std::move(expr), spoq_inst_to_spec(proj, vec, num + 1, context));
            } else if (src->isVectorTy() && dst->isVectorTy()) {
                auto src_vec_ty = llvm::dyn_cast<llvm::VectorType>(src);
                auto dst_vec_ty = llvm::dyn_cast<llvm::VectorType>(dst);
                if (src_vec_ty->getElementCount() == dst_vec_ty->getElementCount() &&
                    src_vec_ty->getElementType()->isIntegerTy() &&
                    dst_vec_ty->getElementType()->isIntegerTy() &&
                    llvm::dyn_cast<llvm::SExtInst>(bc)) {
                        // Uncertain about the semantic correctness of this.  Need a test.
                        auto sym = context.get_llvm_value_spec(bc);
                        auto expr = context.get_llvm_value_spec(bc->getOperand(0));
                        context.add_cache(context.get_llvm_value_name(bc), expr);
                        return Shortcut::_Let_u(std::move(sym), std::move(expr), spoq_inst_to_spec(proj, vec, num + 1, context));
                } else {
                    llvm::errs() << "Unsupported SpoqIR Cast instruction [LLVM]: " << *spoq_inst->inst << "\n";
                    assert(false && "Unsupported SpoqIR Cast instruction [LLVM]");
                }
            } else {
                llvm::errs() << "Unsupported SpoqIR Cast instruction [LLVM]: " << *spoq_inst->inst << "\n";
                assert(false && "Unsupported SpoqIR Cast instruction [LLVM]");
            }
        }

        if (auto phi = llvm::dyn_cast<llvm::PHINode>(spoq_inst->inst)) {
            // PHI nodes in loopheader are translated as loop spec arguments.
            // PHI nodes in postheaders are translated as a _When for the loop spec call
            // PHI nodes are not in any other blocks.
            // TODO: sanity check
            return spoq_inst_to_spec(proj, vec, num + 1, context);
        }

        llvm::errs() << "Unsupported SpoqIR instruction [LLVM]: " << *spoq_inst->inst << "\n";
        assert(false && "Unsupported SpoqIR instruction [LLVM]");
    } else if (auto inst = Shortcut::dyn_cast_u<SpoqPhiInst>(vec[num])) {
        // let <phi> := <incoming value for the edge we arrived on> in <rest>
        //
        // Bound under the phi's own SSA name, so downstream uses resolve without
        // a rename map.  That name is unique in the function and nothing is in
        // scope under it yet, since SSA dominance puts every use after this
        // point.
        //
        // One `let` per phi is sound even when a join carries several, for the
        // same dominance reason: an incoming value must dominate its own edge,
        // which nothing defined inside the join block does, so sibling phis
        // cannot name each other and their order does not matter.
        auto sym = context.get_llvm_value_spec(inst->phi);
        auto value = context.get_llvm_value_spec(inst->incoming);
        return Shortcut::_Let_u(std::move(sym), std::move(value),
                                spoq_inst_to_spec(proj, vec, num + 1, context));
    } else if (auto inst = Shortcut::dyn_cast_u<SpoqJoinInst>(vec[num])) {
        // The tail of one arm of a reconverging If:
        //
        //   Some (v_1, ..., v_k, st)
        //
        // where v_i is what the join's i-th phi takes on this arm's edge and
        // `st` is the state as this arm leaves it, so a store in the arm is
        // carried out through the same tuple.  Wrapped in Some because the arm
        // is option-typed: a `rely` anywhere inside it can yield None.
        assert(num == vec.size() - 1 && "a join is not the last instruction in its arm");
        auto values = std::make_unique<vector<unique_ptr<SpecNode>>>();
        for (auto *incoming : inst->incoming)
            values->push_back(context.get_llvm_value_spec(incoming));
        values->push_back(context.get_abs_data());
        auto yielded = values->size() == 1 ? std::move(values->at(0))
                                           : Shortcut::_Tuple_u(std::move(values));
        return Shortcut::_Some_u(std::move(yielded));
    } else if (auto inst = Shortcut::dyn_cast_u<SpoqIfInst>(vec[num])) {
        auto cond = as_condition(context.get_llvm_value_spec(inst->cond));
        auto then_body = spoq_inst_to_spec(proj, inst->true_body, 0, context);
        auto else_body = spoq_inst_to_spec(proj, inst->false_body, 0, context);
        unique_ptr<If> if_inst = std::make_unique<If>(
            std::move(cond), std::move(then_body), std::move(else_body));

        if (!inst->join) {
            // Each arm ran to its own return, so there is nothing after the If.
            assert(num == vec.size() - 1 && "a non-reconverging if-else must be the final return");
            return std::move(if_inst);
        }

        // The arms reconverge.  Bind what they yield and carry on once:
        //
        //   when (r_1, ..., r_k, st) == (if c then <arm> else <arm>); <rest>
        //
        // The names bound are the join's own phi names, plus `st`, which shadows
        // the incoming state exactly as a store's `when st == ...` does -- that
        // is what carries an arm's memory effects past the join.  A `when`
        // rather than a plain `let` because the arms are option-typed and their
        // None has to propagate.
        auto pattern_parts = std::make_unique<vector<unique_ptr<SpecNode>>>();
        for (auto &phi : inst->join->phis())
            pattern_parts->push_back(context.get_llvm_value_spec(&phi));
        pattern_parts->push_back(context.get_abs_data());
        auto pattern = pattern_parts->size() == 1
                               ? std::move(pattern_parts->at(0))
                               : Shortcut::_Tuple_u(std::move(pattern_parts));

        return Shortcut::_When_u(std::move(pattern), std::move(if_inst),
                                 spoq_inst_to_spec(proj, vec, num + 1, context));
    } else if (auto inst = Shortcut::dyn_cast_u<SpoqLoopInst>(vec[num])) {

        // Generate the loop body spec
       auto name = context.get_loop_spec_name(inst->preheader_block);

       // context.spoq_func.loop_context.debug_jump();
        if (proj->defs.find(name) != proj->defs.end()) {
            LOG_DEBUG << "skip loop spec: " << name << " already exists\n";
        } else {
            // Through the loop context, not `inst->body`: a loop entered on
            // several paths has a SpoqLoopInst per path, and the body was
            // filled into whichever of them registered it.  Taking it from the
            // map is what makes the definition the same whichever one the walk
            // reaches first -- reading `inst->body` builds it from an empty
            // vector whenever that is not the one holding the body.
            context.pass_stack.push(inst->preheader_block);
            auto &body = context.spoq_func.loop_context.get_loop_inst_for_jump(inst->preheader_block);
            auto spec = spoq_inst_to_spec(proj, body, 0, context);
            context.pass_stack.pop();

            if(proj->cmds.InitRely.find(name) != proj->cmds.InitRely.end()) {
                for(auto & f : proj->cmds.InitRely[name])
                    spec = std::make_unique<Rely>(f->deep_copy(), std::move(spec));
            }

            auto argtype = context.compute_loop_spec_arg(inst->preheader_block);
            auto const rettype = context.compute_loop_return_type(inst->preheader_block);
            auto def = new Fixpoint(name, rettype, std::move(argtype), std::move(spec));
            auto const loc = make_shared<loc_t>(proj->layers[context.layer_id]->name, context.fname(), Project::LOC_LOWSPEC);
            proj->add_definition(std::unique_ptr<Fixpoint>(def), loc);
        }

        auto const arg_list = context.compute_loop_continue_arg_list(inst->preheader_block, inst->preheader_block);
        auto v = std::make_unique<vector<unique_ptr<SpecNode>>>();
        for(auto arg: arg_list) {
            v->push_back(context.get_llvm_value_spec(arg));
        }
        v->push_back(context.get_abs_data());
        auto src_loop = std::make_unique<Expr>(name, std::move(v));

        auto pass_out_list = Shortcut::_Tuple_u(context.compute_loop_break_return_list(inst->preheader_block));
        auto rest = context.bind_loop_results(inst->preheader_block,
                                              spoq_inst_to_spec(proj, vec, num + 1, context));
        return Shortcut::_When_u(std::move(pass_out_list), std::move(src_loop), std::move(rest));
    } else if (auto inst = Shortcut::dyn_cast_u<SpoqContinueInst>(vec[num])) {
        assert(num == vec.size() - 1 && "continue is not the last instruction");
        int guard = 0, i = 0;
        auto const arg_list = context.compute_loop_continue_arg_list(inst->latch_block, nullptr, &guard);
        auto v = std::make_unique<vector<unique_ptr<SpecNode>>>();
        for(auto arg: arg_list) {
            if (i >= guard) {
                v->push_back(std::make_unique<Symbol>("arg_dummy" + std::to_string(i - guard), context.get_llvm_value_type(arg)));
            } else {
                v->push_back(context.get_llvm_value_spec(arg));
            }
            ++i;
        }
        v->push_back(context.get_abs_data());
        context.continue_return = std::make_unique<Expr>(context.get_loop_spec_name(), std::move(v));
        auto const typevec = context.compute_loop_return_type(context.pass_stack.top());
        context.continue_return->type = typevec;
        return spoq_inst_to_spec(proj, vec, num + 1, context);
    } else if (auto inst = Shortcut::dyn_cast_u<SpoqBreakInst>(vec[num])) {
        assert(num == vec.size() - 1 && "continue is not the last instruction");
        context.update_loop_break_return_list(inst->exiting_block);
        return spoq_inst_to_spec(proj, vec, num + 1, context);
    } else {
        assert(false && "Unsupported SpoqIR instruction [LOOP]");
        return nullptr;
    }
}

}; // namespace autov
