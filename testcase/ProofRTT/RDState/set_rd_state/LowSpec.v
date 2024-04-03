Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section RDState_set_rd_state_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition set_rd_state_spec_low (v_rd: Ptr) (v_state: Z) (st: RData) : (option RData) :=
    rely ((((v_rd.(pbase)) = ("slot_rd")) /\ (((v_rd.(poffset)) = (0)))));
    let v_state1 := (ptr_offset v_rd ((456 * (0)) + ((0 + (0))))) in
    when st == ((__sca_write64_release_spec v_state1 v_state st));
    let __return__ := true in
    (Some st).

End RDState_set_rd_state_LowSpec.

#[global] Hint Unfold set_rd_state_spec_low: spec.
