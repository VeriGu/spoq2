Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section MapHelper_xlat_map_memory_page_with_attrs_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition xlat_map_memory_page_with_attrs_spec_low (v_table: Ptr) (v_va: Z) (v_pa: Z) (v_attrs: Z) (st: RData) : (option (Z * RData)) :=
    when v_call, st == ((xlat_get_tte_ptr_spec v_table v_va st));
    let v_cmp := (ptr_eqb v_call (mkPtr "null" 0)) in
    when v_retval_0, st == (
        let v_retval_0 := 0 in
        if v_cmp
        then (
          let v_retval_0 := (- 14) in
          (Some (v_retval_0, st)))
        else (
          when v_call1, st == ((xlat_read_tte_spec v_call st));
          let v_cmp2_not := (v_call1 =? (36028797018963968)) in
          when v_retval_0, st == (
              let v_retval_0 := 0 in
              if v_cmp2_not
              then (
                when v_call5, st == ((xlat_arch_get_max_supported_pa_spec st));
                let v_cmp6 := (v_call5 <? (v_pa)) in
                when v_retval_0, st == (
                    let v_retval_0 := 0 in
                    if v_cmp6
                    then (
                      let v_retval_0 := (- 14) in
                      (Some (v_retval_0, st)))
                    else (
                      let v_level := (ptr_offset v_table ((24 * (0)) + ((16 + (0))))) in
                      when v_0, st == ((load_RData 4 v_level st));
                      let v_conv := v_0 in
                      let v_sub := (3 - (v_conv)) in
                      let v_mul := (v_sub * (9)) in
                      let v_add := (v_mul + (12)) in
                      let v_notmask := ((- 1) << (v_add)) in
                      let v_and := (v_notmask & (v_pa)) in
                      when v_call11, st == ((xlat_desc_spec v_attrs v_and v_0 st));
                      let v_or := (v_call11 |' (36028797018963968)) in
                      when st == ((xlat_write_tte_spec v_call v_or st));
                      when st == ((iasm_335_spec st));
                      when st == ((isb_spec st));
                      let v_retval_0 := 0 in
                      (Some (v_retval_0, st))));
                (Some (v_retval_0, st)))
              else (
                let v_retval_0 := (- 14) in
                (Some (v_retval_0, st))));
          (Some (v_retval_0, st))));
    let __return__ := true in
    let __retval__ := v_retval_0 in
    (Some (__retval__, st)).

End MapHelper_xlat_map_memory_page_with_attrs_LowSpec.

#[global] Hint Unfold xlat_map_memory_page_with_attrs_spec_low: spec.
