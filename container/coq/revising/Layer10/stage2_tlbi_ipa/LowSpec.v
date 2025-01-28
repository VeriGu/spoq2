Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer10_stage2_tlbi_ipa_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Fixpoint stage2_tlbi_ipa_loop210_low (_N_: nat) (__break__: bool) (v__012: Z) (v__0911: Z) (st: RData) : (option (bool * Z * Z * RData)) :=
    match (_N_) with
    | O => (Some (__break__, v__012, v__0911, st))
    | (S _N__0) =>
      match ((stage2_tlbi_ipa_loop210_low _N__0 __break__ v__012 v__0911 st)) with
      | (Some (__break___0, v__13, v__912, st_0)) =>
        if __break___0
        then (Some (true, v__13, v__912, st_0))
        else (
          when st_1 == ((iasm_270_spec (v__13 >> (12)) st_0));
          if ((v__912 + (18446744073709547520)) =? (0))
          then (Some (true, v__13, v__912, st_1))
          else (Some (false, (v__13 + (4096)), (v__912 + (18446744073709547520)), st_1)))
      | None => None
      end
    end.

  Definition stage2_tlbi_ipa_loop210_rank (v__012: Z) (v__0911: Z) : Z :=
    0.

  Definition stage2_tlbi_ipa_spec_low (v_0: Ptr) (v_1: Z) (v_2: Z) (st: RData) : (option RData) :=
    when v_4, st_0 == ((iasm_get_vttbr_el2_spec st));
    when v_6, st_1 == ((load_RData 4 (ptr_offset v_0 24) st_0));
    when st_2 == ((iasm_set_vttbr_el2_spec (v_6 << (48)) st_1));
    when st_3 == ((iasm_12_isb_spec st_2));
    if (v_2 =? (0))
    then (
      when st_5 == ((iasm_10_spec st_3));
      when st_6 == ((iasm_258_spec st_5));
      when st_7 == ((iasm_10_spec st_6));
      when st_8 == ((iasm_12_isb_spec st_7));
      when st_9 == ((iasm_set_vttbr_el2_spec v_4 st_8));
      when st_10 == ((iasm_12_isb_spec st_9));
      (Some st_10))
    else (
      rely (((stage2_tlbi_ipa_loop210_rank v_1 v_2) >= (0)));
      match ((stage2_tlbi_ipa_loop210_low (z_to_nat (stage2_tlbi_ipa_loop210_rank v_1 v_2)) false v_1 v_2 st_3)) with
      | (Some (__break__, v__13, v__912, st_4)) =>
        when st_6 == ((iasm_10_spec st_4));
        when st_7 == ((iasm_258_spec st_6));
        when st_8 == ((iasm_10_spec st_7));
        when st_9 == ((iasm_12_isb_spec st_8));
        when st_10 == ((iasm_set_vttbr_el2_spec v_4 st_9));
        when st_11 == ((iasm_12_isb_spec st_10));
        (Some st_11)
      | None => None
      end).

End Layer10_stage2_tlbi_ipa_LowSpec.

#[global] Hint Unfold stage2_tlbi_ipa_loop210_low: spec.
#[global] Hint Unfold stage2_tlbi_ipa_loop210_rank: spec.
#[global] Hint Unfold stage2_tlbi_ipa_spec_low: spec.
