Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Helpers___tte_write_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition __tte_write_spec_low (v_ttep: Ptr) (v_tte: Z) (st: RData) : (option RData) :=
    rely ((((v_ttep.(pbase)) = ("slot_rtt")) \/ (((v_ttep.(pbase)) = ("slot_rtt2")))));
    when st_0 == ((__sca_write64_spec v_ttep v_tte st));
    when st_1 == ((iasm_4_spec st_0));
    (Some st_1).

End Helpers___tte_write_LowSpec.

#[global] Hint Unfold __tte_write_spec_low: spec.
