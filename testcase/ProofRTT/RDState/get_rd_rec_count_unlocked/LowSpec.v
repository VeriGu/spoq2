Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section RDState_get_rd_rec_count_unlocked_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition get_rd_rec_count_unlocked_spec_low (v_rd: Ptr) (st: RData) : (option (Z * RData)) :=
    rely ((((v_rd.(pbase)) = ("slot_rd")) /\ (((v_rd.(poffset)) = (0)))));
    let v_rec_count := (ptr_offset v_rd ((456 * (0)) + ((8 + (0))))) in
    when v_call, st == ((__sca_read64_acquire_spec v_rec_count st));
    let __return__ := true in
    let __retval__ := v_call in
    (Some (__retval__, st)).

End RDState_get_rd_rec_count_unlocked_LowSpec.

#[global] Hint Unfold get_rd_rec_count_unlocked_spec_low: spec.
