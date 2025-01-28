Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer2.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer12_host_ns_s2tte_is_valid_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition host_ns_s2tte_is_valid_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (bool * RData)) :=
    when v_3, st_0 == ((addr_level_mask_spec (- 1) v_1 st));
    if ((v_0 & (281474976706560)) =? (708837376))
    then (Some (true, st_0))
    else (
      if (((Z.lxor (v_3 |' (1020)) (- 1)) & (v_0)) =? (0))
      then (
        if ((v_0 & (60)) =? (16))
        then (Some (false, st_0))
        else (
          if ((v_0 & (768)) =? (256))
          then (Some (false, st_0))
          else (Some (true, st_0))))
      else (Some (false, st_0))).

End Layer12_host_ns_s2tte_is_valid_LowSpec.

#[global] Hint Unfold host_ns_s2tte_is_valid_spec_low: spec.
