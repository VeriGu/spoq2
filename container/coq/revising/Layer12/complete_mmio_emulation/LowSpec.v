Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer11.Spec.
Require Import Layer7.Spec.
Require Import Layer8.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer12_complete_mmio_emulation_LowSpec.

  Context `{int_ptr: IntPtrCast}.
  Definition complete_mmio_emulation_0_low (st_8: RData) (v_0: Ptr) (v_19: Z) (v_20: Z) (v_24: Z) (v_31: bool) (v_5: Z) : (option (bool * RData)) :=
    rely ((v_31 = (true)));
    rely ((((0 - (v_5)) <= (0)) /\ ((v_5 < (31)))));
    when st_11 == ((store_RData 8 (ptr_offset v_0 (24 + ((8 * (v_5))))) ((Z.lxor (1 << (((v_24 * (8)) + ((- 1))))) (v_20 & (v_19))) - ((1 << (((v_24 * (8)) + ((- 1))))))) st_8));
    when v_39, st_13 == ((load_RData 8 (ptr_offset v_0 272) st_11));
    when st_14 == ((store_RData 8 (ptr_offset v_0 272) (v_39 + (4)) st_13));
    (Some (true, st_14)).

  Definition complete_mmio_emulation_spec_low (v_0: Ptr) (v_1: Ptr) (st: RData) : (option (bool * RData)) :=
    when v_4, st_0 == ((load_RData 8 (ptr_offset v_0 952) st));
    when v_5, st_1 == ((esr_srt_spec v_4 st_0));
    when v_7, st_2 == ((load_RData 8 (ptr_offset v_1 56) st_1));
    if (v_7 =? (0))
    then (Some (true, st_2))
    else (
      if ((v_4 & (4227858432)) =? (2415919104))
      then (
        if ((v_4 & (16777216)) =? (0))
        then (Some (false, st_2))
        else (
          when v_15, st_3 == ((esr_is_write_spec v_4 st_2));
          if (
            if (xorb v_15 true)
            then (v_5 <>? (31))
            else false)
          then (
            when v_19, st_4 == ((load_RData 8 (ptr_offset v_1 64) st_3));
            when v_20, st_5 == ((access_mask_spec v_4 st_4));
            when v_22, st_6 == ((esr_sign_extend_spec v_4 st_5));
            if v_22
            then (
              when v_24, st_7 == ((access_len_spec v_4 st_6));
              when v_31, st_8 == ((esr_sixty_four_spec v_4 st_7));
              if v_31
              then (complete_mmio_emulation_0_low st_8 v_0 v_19 v_20 v_24 v_31 v_5)
              else (
                rely ((((0 - (v_5)) <= (0)) /\ ((v_5 < (31)))));
                when st_11 == (
                    (store_RData
                      8
                      (ptr_offset v_0 (24 + ((8 * (v_5)))))
                      (((Z.lxor (1 << (((v_24 * (8)) + ((- 1))))) (v_20 & (v_19))) - ((1 << (((v_24 * (8)) + ((- 1))))))) & (4294967295))
                      st_8));
                when v_39, st_13 == ((load_RData 8 (ptr_offset v_0 272) st_11));
                when st_14 == ((store_RData 8 (ptr_offset v_0 272) (v_39 + (4)) st_13));
                (Some (true, st_14))))
            else (
              rely ((((0 - (v_5)) <= (0)) /\ ((v_5 < (31)))));
              when st_8 == ((store_RData 8 (ptr_offset v_0 (24 + ((8 * (v_5))))) (v_20 & (v_19)) st_6));
              when v_39, st_10 == ((load_RData 8 (ptr_offset v_0 272) st_8));
              when st_11 == ((store_RData 8 (ptr_offset v_0 272) (v_39 + (4)) st_10));
              (Some (true, st_11))))
          else (
            when v_39, st_5 == ((load_RData 8 (ptr_offset v_0 272) st_3));
            when st_6 == ((store_RData 8 (ptr_offset v_0 272) (v_39 + (4)) st_5));
            (Some (true, st_6)))))
      else (Some (false, st_2))).



End Layer12_complete_mmio_emulation_LowSpec.

#[global] Hint Unfold complete_mmio_emulation_spec_low: spec.
#[global] Hint Unfold complete_mmio_emulation_0_low: spec.
