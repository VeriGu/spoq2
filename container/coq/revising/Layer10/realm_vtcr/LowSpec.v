Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer6.Spec.
Require Import Layer9.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer10_realm_vtcr_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition realm_vtcr_spec_low (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    when v_2, st_0 == ((feat_vmid16_spec st));
    if v_2
    then (
      when v_5, st_2 == ((realm_ipa_bits_spec v_0 st_0));
      when v_6, st_3 == ((realm_rtt_starting_level_spec v_0 st_2));
      if (((v_6 =? (1)) || ((v_6 =? (2)))) || ((v_6 =? (3))))
      then (
        if ((v_6 =? (1)) || ((v_6 =? (2))))
        then (
          if (v_6 =? (1))
          then (Some (((((0 - (v_5)) & (63)) |' (3221894400)) |' (0)), st_3))
          else (Some (((((0 - (v_5)) & (63)) |' (3221894400)) |' (64)), st_3)))
        else (Some (((((0 - (v_5)) & (63)) |' (3221894400)) |' (0)), st_3)))
      else (Some (((((0 - (v_5)) & (63)) |' (3221894400)) |' (128)), st_3)))
    else (
      when v_5, st_2 == ((realm_ipa_bits_spec v_0 st_0));
      when v_6, st_3 == ((realm_rtt_starting_level_spec v_0 st_2));
      if (((v_6 =? (1)) || ((v_6 =? (2)))) || ((v_6 =? (3))))
      then (
        if ((v_6 =? (1)) || ((v_6 =? (2))))
        then (
          if (v_6 =? (1))
          then (Some (((((0 - (v_5)) & (63)) |' (3221370112)) |' (0)), st_3))
          else (Some (((((0 - (v_5)) & (63)) |' (3221370112)) |' (64)), st_3)))
        else (Some (((((0 - (v_5)) & (63)) |' (3221370112)) |' (0)), st_3)))
      else (Some (((((0 - (v_5)) & (63)) |' (3221370112)) |' (128)), st_3))).

End Layer10_realm_vtcr_LowSpec.

#[global] Hint Unfold realm_vtcr_spec_low: spec.
