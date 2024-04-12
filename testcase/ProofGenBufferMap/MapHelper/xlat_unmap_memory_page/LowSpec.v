Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section MapHelper_xlat_unmap_memory_page_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition xlat_unmap_memory_page_spec_low (v_table: Ptr) (v_va: Z) (st: RData) : (option (Z * RData)) :=
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
          let v_and := (v_call1 & (36028797018963969)) in
          let v_cmp2_not := (v_and =? (36028797018963969)) in
          when v_retval_0, st == (
              let v_retval_0 := 0 in
              if v_cmp2_not
              then (
                when st == ((xlat_write_tte_spec v_call 36028797018963968 st));
                when st == ((xlat_arch_tlbi_va_spec v_va st));
                when st == ((xlat_arch_tlbi_va_sync_spec st));
                let v_retval_0 := 0 in
                (Some (v_retval_0, st)))
              else (
                let v_retval_0 := (- 14) in
                (Some (v_retval_0, st))));
          (Some (v_retval_0, st))));
    let __return__ := true in
    let __retval__ := v_retval_0 in
    (Some (__retval__, st)).

End MapHelper_xlat_unmap_memory_page_LowSpec.

#[global] Hint Unfold xlat_unmap_memory_page_spec_low: spec.
