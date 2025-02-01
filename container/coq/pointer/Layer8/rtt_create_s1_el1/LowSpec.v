Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer8_rtt_create_s1_el1_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition rtt_create_s1_el1_spec_low (v_0: Ptr) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    let ttbr := (rec_to_ttbr1_para v_0 st) in
    when st_1 == ((granule_lock_spec ttbr 5 st));
    when v_7, st_2 == ((rtt_create_internal_spec_abs ttbr (test_PA v_1) v_2 v_3 1 st_1));
    ((Some v_7), st_2).

End Layer8_rtt_create_s1_el1_LowSpec.

#[global] Hint Unfold rtt_create_s1_el1_spec_low: spec.
