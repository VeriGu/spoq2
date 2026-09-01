Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import S2TTEDesc.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section S2TTEState_s2tte_is_valid_ns_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2tte_is_valid_ns_spec_low (v_s2tte: Z) (v_level: Z) (st: RData) : (option (bool * RData)) :=
    when v_call, st_0 == ((s2tte_check_spec v_s2tte v_level 36028797018963968 st));
    (Some (v_call, st_0)).

End S2TTEState_s2tte_is_valid_ns_LowSpec.

#[global] Hint Unfold s2tte_is_valid_ns_spec_low: spec.
