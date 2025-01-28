Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer3.Spec.
Require Import Layer4.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer7_get_tte_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition get_tte_spec_low (v_0: Z) (st: RData) : (option (Ptr * RData)) :=
    when v_4, st_0 == ((s2_addr_to_idx_spec (v_0 & (68719476735)) 1 st));
    when v_6, st_1 == ((load_RData 8 (ptr_offset (mkPtr "tt_l1_upper" 0) (8 * (v_4))) st_0));
    when v_7, st_2 == ((entry_is_table_spec v_6 st_1));
    if v_7
    then (
      when v_10, st_3 == ((load_RData 8 (ptr_offset (mkPtr "tt_l1_upper" 0) (8 * (v_4))) st_2));
      when v_11, st_4 == ((table_entry_to_phys_spec v_10 st_3));
      when v_14, st_5 == ((s2_addr_to_idx_spec (v_0 & (68719476735)) 2 st_4));
      when v_16, st_6 == ((load_RData 8 (ptr_offset (int_to_ptr (v_11 + (18446744000749633536))) (8 * (v_14))) st_5));
      when v_17, st_7 == ((entry_is_table_spec v_16 st_6));
      if v_17
      then (
        when v_19, st_8 == ((load_RData 8 (ptr_offset (int_to_ptr (v_11 + (18446744000749633536))) (8 * (v_14))) st_7));
        when v_20, st_9 == ((table_entry_to_phys_spec v_19 st_8));
        when v_23, st_10 == ((s2_addr_to_idx_spec (v_0 & (68719476735)) 3 st_9));
        (Some ((ptr_offset (int_to_ptr (v_20 + (18446744000749633536))) (8 * (v_23))), st_10)))
      else (Some ((mkPtr "null" 0), st_7)))
    else (Some ((mkPtr "null" 0), st_2)).

End Layer7_get_tte_LowSpec.

#[global] Hint Unfold get_tte_spec_low: spec.
