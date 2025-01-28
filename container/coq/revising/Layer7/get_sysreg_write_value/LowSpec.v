Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer6.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer7_get_sysreg_write_value_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition get_sysreg_write_value_spec_low (v_0: Ptr) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    rely (((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))) /\ ((((v_0.(poffset)) mod (4096)) = (0)))));
    when v_3, st_0 == ((esr_sysreg_rt_spec v_1 st));
    if (v_3 =? (31))
    then (Some (0, st_0))
    else (
      rely ((((0 - (v_3)) <= (0)) /\ ((v_3 < (31)))));
      when v_9, st_1 == ((load_RData 8 (ptr_offset v_0 (24 + ((8 * (v_3))))) st_0));
      (Some (v_9, st_1))).

End Layer7_get_sysreg_write_value_LowSpec.

#[global] Hint Unfold get_sysreg_write_value_spec_low: spec.
