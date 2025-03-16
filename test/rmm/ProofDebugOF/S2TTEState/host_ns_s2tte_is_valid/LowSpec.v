Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import S2TTEDesc.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section S2TTEState_host_ns_s2tte_is_valid_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition host_ns_s2tte_is_valid_spec_low (v_s2tte: Z) (v_level: Z) (st: RData) : (option (bool * RData)) :=
    when v_call, st_0 == ((addr_level_mask_spec (- 1) v_level st));
    if (((Z.lxor (v_call |' (988)) (- 1)) & (v_s2tte)) =? (0))
    then (
      if ((v_s2tte & (28)) =? (16))
      then (Some (false, st_0))
      else (
        if ((v_s2tte & (768)) =? (256))
        then (Some (false, st_0))
        else (Some (true, st_0))))
    else (Some (false, st_0)).

End S2TTEState_host_ns_s2tte_is_valid_LowSpec.

#[global] Hint Unfold host_ns_s2tte_is_valid_spec_low: spec.
