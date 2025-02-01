Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer5___find_lock_next_level_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition __find_lock_next_level_spec_low (v_0: Ptr) (v_1: Z) (v_2: Z) (st: RData) : (option (Ptr * RData)) :=
    if (((abs_tte_read (mkPtr "granule_data" ((v_0.(poffset)) + ((8 * ((s2_addr_to_idx_para v_1 v_2)))))) st).(meta_desc_type)) =? (3))
    then (
      when st_4 == (
          (granule_lock_spec
            (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" ((v_0.(poffset)) + ((8 * ((s2_addr_to_idx_para v_1 v_2)))))) st).(meta_PA)).(meta_granule_offset)))
            5
            st));
      (Some (
        (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" ((v_0.(poffset)) + ((8 * ((s2_addr_to_idx_para v_1 v_2)))))) st).(meta_PA)).(meta_granule_offset)))  ,
        st_4
      )))
    else (Some ((mkPtr "null" 0), st)).

End Layer5___find_lock_next_level_LowSpec.

#[global] Hint Unfold __find_lock_next_level_spec_low: spec.
