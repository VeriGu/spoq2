Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer6.Spec.
Require Import Layer7.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer8_rsi_memory_dispose_LowSpec.

  Context `{int_ptr: IntPtrCast}.
  Definition rsi_memory_dispose_0_low (st_4: RData) (v_0: Ptr) (v_1: Ptr) (v_32: bool) (v_5: Z) (v_7: Z) : (option (bool * RData)) :=
    rely ((v_32 = (true)));
    when st_5 == ((store_RData 8 (ptr_offset v_0 904) v_5 st_4));
    when st_6 == ((store_RData 8 (ptr_offset v_0 912) v_7 st_5));
    when st_7 == ((store_RData 1 (ptr_offset v_0 896) 1 st_6));
    when st_8 == ((store_RData 8 (ptr_offset v_1 0) 4 st_7));
    when st_9 == ((store_RData 8 (ptr_offset v_1 104) v_5 st_8));
    when st_10 == ((store_RData 8 (ptr_offset v_1 112) v_7 st_9));
    (Some (false, st_10)).

  Definition rsi_memory_dispose_spec_low (v_0: Ptr) (v_1: Ptr) (st: RData) : (option (bool * RData)) :=
    rely ((((v_1.(pbase)) = ("stack_s_rec_exit")) /\ (((v_1.(poffset)) = (0)))));
    rely (((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
    rely (((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))) /\ ((((v_0.(poffset)) mod (4096)) = (0)))));
    when v_5, st_0 == ((load_RData 8 (ptr_offset v_0 32) st));
    when v_7, st_1 == ((load_RData 8 (ptr_offset v_0 40) st_0));
    if ((v_5 & (4095)) =? (0))
    then (
      if ((v_7 & (4095)) =? (0))
      then (
        if ((v_5 - ((v_7 + (v_5)))) <? (0))
        then (
          when v_29, st_2 == ((load_RData 8 (ptr_offset v_0 920) st_1));
          when v_31, st_3 == ((load_RData 8 (ptr_offset v_0 936) st_2));
          when v_32, st_4 == ((region_is_contained_spec v_29 v_31 v_5 (v_7 + (v_5)) st_3));
          if v_32
          then (rsi_memory_dispose_0_low st_4 v_0 v_1 v_32 v_5 v_7)
          else (
            when v_34, st_5 == ((pack_return_code_spec 1 1 st_4));
            when st_6 == ((store_RData 8 (ptr_offset (ptr_offset v_0 24) 0) v_34 st_5));
            (Some (true, st_6))))
        else (
          when v_24, st_2 == ((pack_return_code_spec 1 2 st_1));
          when st_3 == ((store_RData 8 (ptr_offset (ptr_offset v_0 24) 0) v_24 st_2));
          (Some (true, st_3))))
      else (
        when v_19, st_2 == ((pack_return_code_spec 1 2 st_1));
        when st_3 == ((store_RData 8 (ptr_offset (ptr_offset v_0 24) 0) v_19 st_2));
        (Some (true, st_3))))
    else (
      when v_12, st_2 == ((pack_return_code_spec 1 1 st_1));
      when st_3 == ((store_RData 8 (ptr_offset (ptr_offset v_0 24) 0) v_12 st_2));
      (Some (true, st_3))).



End Layer8_rsi_memory_dispose_LowSpec.

#[global] Hint Unfold rsi_memory_dispose_spec_low: spec.
#[global] Hint Unfold rsi_memory_dispose_0_low: spec.
