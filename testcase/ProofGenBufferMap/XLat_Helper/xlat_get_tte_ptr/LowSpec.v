Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section XLat_Helper_xlat_get_tte_ptr_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition xlat_get_tte_ptr_spec_low (v_llt: Ptr) (v_va: Z) (st: RData) : (option (Ptr * RData)) :=
    let v_llt_base_va := (ptr_offset v_llt ((24 * (0)) + ((8 + (0))))) in
    when v_0, st == ((load_RData 8 v_llt_base_va st));
    let v_cmp := (v_0 >? (v_va)) in
    when v_retval_0, st == (
        let v_retval_0 := (mkPtr "#" 0) in
        if v_cmp
        then (
          let v_retval_0 := (mkPtr "null" 0) in
          (Some (v_retval_0, st)))
        else (
          let v_sub := (v_va - (v_0)) in
          let v_level := (ptr_offset v_llt ((24 * (0)) + ((16 + (0))))) in
          when v_1, st == ((load_RData 4 v_level st));
          let v_conv := v_1 in
          let v_sub2 := (3 - (v_conv)) in
          let v_mul := (v_sub2 * (9)) in
          let v_add := (v_mul + (12)) in
          let v_shr := (v_sub >> (v_add)) in
          let v_conv4 := (v_shr & (4294967295)) in
          let v_cmp5 := (v_conv4 <? (512)) in
          when v_cond, st == (
              let v_cond := (mkPtr "#" 0) in
              if v_cmp5
              then (
                let v_table := (ptr_offset v_llt ((24 * (0)) + ((0 + (0))))) in
                when v_2_tmp, st == ((load_RData 8 v_table st));
                let v_2 := (int_to_ptr v_2_tmp) in
                let v_arrayidx := (ptr_offset v_2 ((8 * (v_conv4)) + (0))) in
                let v_cond := v_arrayidx in
                (Some (v_cond, st)))
              else (
                let v_cond := (mkPtr "null" 0) in
                (Some (v_cond, st))));
          let v_retval_0 := v_cond in
          (Some (v_retval_0, st))));
    let __return__ := true in
    let __retval__ := v_retval_0 in
    (Some (__retval__, st)).

End XLat_Helper_xlat_get_tte_ptr_LowSpec.

#[global] Hint Unfold xlat_get_tte_ptr_spec_low: spec.
