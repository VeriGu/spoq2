#pragma once

#include <project.h>
#include <z3_rules.h>

namespace autov {

/// Relational postconditions for differing vuln/patch loops.
///
/// For a patch loop `<base>_patch_loop_k` and a vuln loop `<base>_vuln_loop_j`
/// that identification did not merge, a coupling invariant R over their
/// arguments is inferred by Houdini on the product of one iteration of each
/// body.  The candidates are equalities between same-sorted arguments,
/// congruences `y = c * x (mod 2^32)`, arguments equal to their ground value at
/// the call, equality of the states, and of their parts: each record field, and
/// the stack outside a set of keys and at each key.  Those that do not hold at
/// the call site are dropped first.  The parts of the states are related with
/// the memory accessors inlined, which is the second attempt.  The theorem
///
///   R(x, y) /\ V(x) = Some r  ->
///     \/_c (code(r) = c /\ (Q_c(r, y) \/ (P(y) = Some r' /\ E_c(r, r'))))
///
/// is proved by induction on the vuln's iterations, where E_c relates the exits
/// under an inferred exit-code mapping, and Q_c characterizes the vuln exits
/// on which the patch diverged (the vuln must then reach UB after the loop).  A
/// pair on which the vuln continues and the patch exits is discharged by a
/// unary vuln invariant U, inferred the same way, from which the vuln never
/// returns Some.
///
/// [call] is the value of a loop call at a Match scrutinee in the refinement
/// check.  For each counterpart loop call found in [state], the theorem is
/// instantiated at the two calls and added to [state].  Disabled by
/// SPOQ_SHARED_LOOP_INV=0.
void relate_loop_calls(Project *proj, const shared_ptr<ProveState> &state, const z3::expr &call);

}  // namespace autov
