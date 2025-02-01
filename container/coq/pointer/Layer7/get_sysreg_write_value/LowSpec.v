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
    if (((v_1 >> (5)) & (31)) =? (31))
    then (Some (0, st))
    else (
      rely ((((0 - (((v_1 >> (5)) & (31)))) <= (0)) /\ ((((v_1 >> (5)) & (31)) < (31)))));
      when v_9, st_2 == ((load_RData 8 (mkPtr (v_0.(pbase)) ((v_0.(poffset)) + ((24 + ((8 * (((v_1 >> (5)) & (31))))))))) st));
      (Some (v_9, st_2))).

End Layer7_get_sysreg_write_value_LowSpec.

#[global] Hint Unfold get_sysreg_write_value_spec_low: spec.
