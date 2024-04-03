Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section FindGranule_sort_granules_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition sort_granules_spec_low (v_granules: Ptr) (v_n: Z) (st: RData) : (option RData) :=
    when st == ((new_frame "sort_granules" st));
    let init_st := st in
    rely (((v_granules.(pbase)) = ("find_lock_two_granules_stack")));
    when v_temp_sroa_3, st == ((alloc_stack "sort_granules" 24 8 st));
    let v_temp_sroa_3_0_sroa_cast := v_temp_sroa_3 in
    let v_arrayidx := (ptr_offset v_granules ((40 * (1)) + (0))) in
    let v_temp_sroa_0_0__sroa_cast := v_arrayidx in
    when v_temp_sroa_0_0_copyload, st == ((load_RData 8 v_temp_sroa_0_0__sroa_cast st));
    let v_temp_sroa_2_0__sroa_idx9 := (ptr_offset v_granules ((40 * (1)) + ((8 + (0))))) in
    when v_temp_sroa_2_0_copyload, st == ((load_RData 8 v_temp_sroa_2_0__sroa_idx9 st));
    let v_temp_sroa_3_0__sroa_idx := (ptr_offset v_granules ((40 * (1)) + ((16 + (0))))) in
    let v_temp_sroa_3_0__sroa_cast := v_temp_sroa_3_0__sroa_idx in
    when st == ((llvm_memcpy_p0i8_p0i8_i64_spec v_temp_sroa_3_0_sroa_cast v_temp_sroa_3_0__sroa_cast 24 false st));
    let v_addr := (ptr_offset v_granules ((40 * (0)) + ((8 + (0))))) in
    when v_0, st == ((load_RData 8 v_addr st));
    let v_cmp4 := (v_0 >? (v_temp_sroa_2_0_copyload)) in
    when v_j_0_lcssa, st == (
        let v_j_0_lcssa := 0 in
        if v_cmp4
        then (
          let v_arrayidx2 := (ptr_offset v_granules ((40 * (0)) + (0))) in
          let v_arrayidx5 := (ptr_offset v_granules ((40 * (1)) + (0))) in
          let v_1 := v_arrayidx5 in
          let v_2 := v_arrayidx2 in
          when st == ((llvm_memcpy_p0i8_p0i8_i64_spec v_1 v_2 40 false st));
          let v_j_0_lcssa := 0 in
          (Some (v_j_0_lcssa, st)))
        else (
          let v_j_0_lcssa := 1 in
          (Some (v_j_0_lcssa, st))));
    let v_cmp8_not := (1 =? (v_j_0_lcssa)) in
    when st == (
        if v_cmp8_not
        then (Some st)
        else (
          let v_arrayidx9 := (ptr_offset v_granules ((40 * (0)) + (0))) in
          let v_temp_sroa_0_0__sroa_cast7 := v_arrayidx9 in
          when st == ((store_RData 8 v_temp_sroa_0_0__sroa_cast7 v_temp_sroa_0_0_copyload st));
          let v_temp_sroa_2_0__sroa_idx10 := (ptr_offset v_granules ((40 * (0)) + ((8 + (0))))) in
          when st == ((store_RData 8 v_temp_sroa_2_0__sroa_idx10 v_temp_sroa_2_0_copyload st));
          let v_temp_sroa_3_0__sroa_idx12 := (ptr_offset v_granules ((40 * (0)) + ((16 + (0))))) in
          let v_temp_sroa_3_0__sroa_cast13 := v_temp_sroa_3_0__sroa_idx12 in
          when st == ((llvm_memcpy_p0i8_p0i8_i64_spec v_temp_sroa_3_0__sroa_cast13 v_temp_sroa_3_0_sroa_cast 24 false st));
          (Some st)));
    let __return__ := true in
    when st == ((free_stack "sort_granules" init_st st));
    (Some st).

End FindGranule_sort_granules_LowSpec.

#[global] Hint Unfold sort_granules_spec_low: spec.
