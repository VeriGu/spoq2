Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Helpers_psci_reset_rec_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition psci_reset_rec_spec_low (v_rec: Ptr) (v_caller_sctlr_el1: Z) (st: RData) : (option RData) :=
    rely ((((v_rec.(pbase)) = ("slot_rec2")) /\ (((v_rec.(poffset)) = (0)))));
    let v_pstate := (ptr_offset v_rec ((3272 * (0)) + ((280 + (0))))) in
    when st == ((store_RData 8 v_pstate 965 st));
    let v_sctlr_el1 := (ptr_offset v_rec ((3272 * (0)) + ((288 + ((64 + (0))))))) in
    let v_and := (v_caller_sctlr_el1 & (33554432)) in
    let v_or := (v_and |' (12912760)) in
    when st == ((store_RData 8 v_sctlr_el1 v_or st));
    let __return__ := true in
    (Some st).

End Helpers_psci_reset_rec_LowSpec.

#[global] Hint Unfold psci_reset_rec_spec_low: spec.
