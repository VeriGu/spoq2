Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section RDState_set_rd_rec_count_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition set_rd_rec_count_spec_low (v_rd: Ptr) (v_val: Z) (st: RData) : (option RData) :=
    rely ((((v_rd.(pbase)) = ("slot_rd")) /\ (((v_rd.(poffset)) = (0)))));
    let v_rec_count := (ptr_offset v_rd ((456 * (0)) + ((8 + (0))))) in
    when st == ((__sca_write64_release_spec v_rec_count v_val st));
    let __return__ := true in
    (Some st).

End RDState_set_rd_rec_count_LowSpec.

#[global] Hint Unfold set_rd_rec_count_spec_low: spec.
