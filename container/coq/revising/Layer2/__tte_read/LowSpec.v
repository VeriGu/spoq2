Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer2___tte_read_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition __tte_read_spec_low (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    rely ((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))));
    when v_2, st_0 == ((__sca_read64_spec v_0 st));
    (Some (v_2, st_0)).

End Layer2___tte_read_LowSpec.

#[global] Hint Unfold __tte_read_spec_low: spec.
