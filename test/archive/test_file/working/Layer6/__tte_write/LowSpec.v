Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer6___tte_write_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition __tte_write_spec_low (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
    rely ((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))));
    when st == ((__sca_write64_spec v_0 v_1 st));
    let __return__ := true in
    (Some st).

End Layer6___tte_write_LowSpec.

#[global] Hint Unfold __tte_write_spec_low: spec.
