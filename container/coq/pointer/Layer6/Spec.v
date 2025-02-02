Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer2.Spec.
Require Import Layer3.Spec.
Require Import Layer4.Spec.
Require Import Layer5.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter g_mapped_addr_set_para : Z -> Z -> Z).

Parameter pack_struct_return_code_para : Z -> Z.

Parameter make_return_code_para : Z -> Z.

Parameter test_PTE_Z : abs_PTE_t -> Z.

Parameter test_Z_PTE : Z -> abs_PTE_t.

Parameter uart0_phys_para : abs_PTE_t -> bool.

Section Layer6_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2tte_get_ripas_spec' (v_0: Z) : (option Z) :=
    if ((v_0 & (64)) =? (0))
    then (Some 0)
    else (Some 1).

  Definition s1tte_create_valid_spec' (v_0: Z) (v_1: Z) : (option Z) :=
    if (v_1 =? (3))
    then (Some (v_0 |' (1795)))
    else (Some (v_0 |' (1793))).

  Definition s2tte_pa_spec' (v_0: Z) (v_1: Z) : (option Z) :=
    if ((v_1 <? (3)) && (((v_0 & (3)) =? (3))))
    then (Some ((v_0 & (281474976710655)) & (((- 1) << (12)))))
    else (Some ((v_0 & (281474976710655)) & (((- 1) << (((((3 - (v_1)) * (9)) + (12)) & (4294967295))))))).

  Definition __granule_put_spec (v_0: Ptr) (st: RData) : (option RData) :=
    rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
    rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
    when st_1 == ((atomic_add_64 (ptr_offset v_0 8) (- 1) st));
    (Some st_1).

  Definition s2tte_create_assigned_spec_abs (v_0: abs_PA_t) (v_1: Z) (st: RData) : (option (abs_PTE_t * RData)) :=
    (Some ((mkabs_PTE_t v_0 0 0 1), st)).

  Definition s1tte_create_valid_spec_abs (v_0: abs_PA_t) (v_1: Z) (st: RData) : (option (abs_PTE_t * RData)) :=
    if (v_1 =? (3))
    then (Some ((mkabs_PTE_t v_0 0 0 3), st))
    else (Some ((mkabs_PTE_t v_0 0 0 1), st)).

  Definition s1tte_pa_spec_abs (v_0: abs_PTE_t) (st: RData) : (option (abs_PA_t * RData)) :=
    (Some ((v_0.(meta_PA)), st)).

  Definition s2tte_pa_spec_abs (v_0: abs_PTE_t) (v_1: Z) (st: RData) : (option (abs_PA_t * RData)) :=
    (Some ((v_0.(meta_PA)), st)).

  Definition g_mapped_addr_set_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
    rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
    when v_4, st_0 == ((load_RData_granules 8 (ptr_offset v_0 8) st));
    when st_1 == ((store_RData_granules 8 (ptr_offset v_0 8) (g_mapped_addr_set_para v_4 v_1) st_0));
    (Some st_1).

  Definition s2tte_is_unassigned_spec_abs (v_0: abs_PTE_t) (st: RData) : (option (bool * RData)) :=
    let result := ((((v_0.(meta_desc_type)) =? (0)) && (((v_0.(meta_ripas)) =? (0)))) && (((v_0.(meta_mem_attr)) =? (0)))) in
    (Some (result, st)).

  Definition s2tte_is_assigned_spec_abs (v_0: abs_PTE_t) (v_1: Z) (st: RData) : (option (bool * RData)) :=
    let result := ((((v_0.(meta_desc_type)) =? (0)) && (((v_0.(meta_ripas)) =? (0)))) && (((v_0.(meta_mem_attr)) =? (1)))) in
    (Some (result, st)).

  Definition s2tte_get_ripas_spec_abs (v_0: abs_PTE_t) (st: RData) : (option (Z * RData)) :=
    (Some ((v_0.(meta_ripas)), st)).

  Definition s2tte_is_table_spec_abs (v_0: abs_PTE_t) (v_1: Z) (st: RData) : (option (bool * RData)) :=
    (Some (((v_1 <? (3)) && (((v_0.(meta_desc_type)) =? (3)))), st)).

  Definition find_lock_two_granules_spec_abs (v_0: abs_PA_t) (v_1: Z) (v_2: Ptr) (v_3: abs_PA_t) (v_4: Z) (v_5: Ptr) (st: RData) : (option (abs_ret_2ptr * RData)) :=
    if ((v_0.(meta_granule_offset)) =? ((v_3.(meta_granule_offset))))
    then (Some ((mkabs_ret_2ptr (mkPtr "null" 0) (mkPtr "null" 0)), st))
    else (
      when ret_0, st_0 == ((find_lock_granule_spec_abs v_0 v_1 st));
      if ((ret_0.(pbase)) =s ("null"))
      then (Some ((mkabs_ret_2ptr (mkPtr "null" 0) (mkPtr "null" 0)), st_0))
      else (
        when ret_1, st_1 == ((find_lock_granule_spec_abs v_3 v_4 st_0));
        if ((ret_1.(pbase)) =s ("null"))
        then (
          when st_2 == ((granule_unlock_spec ret_0 st_1));
          (Some ((mkabs_ret_2ptr (mkPtr "null" 0) (mkPtr "null" 0)), st_2)))
        else (Some ((mkabs_ret_2ptr ret_0 ret_1), st_1)))).

  Definition __tte_write_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
    None.

  Definition store_RData_granule_data (sz: Z) (p: Ptr) (v: Z) (st: RData) : (option RData) :=
    let idx := ((p.(poffset)) / (4096)) in
    let g_data := (((st.(share)).(granule_data)) @ idx) in
    let elem_ofs := ((p.(poffset)) mod (4096)) in
    let new_g_data := (g_data.[g_norm] :< ((g_data.(g_norm)) # elem_ofs == v)) in
    let p := (((st.(share)).(granule_data)) # idx == new_g_data) in
    let new_st := (st.[share].[granule_data] :< p) in
    (Some new_st).

  Definition __tte_write_spec_abs (v_0: Ptr) (v_1: abs_PTE_t) (st: RData) : (option RData) :=
    let v_1_Z := (test_PTE_Z v_1) in
    when st_0 == ((store_RData_granule_data 64 v_0 v_1_Z st));
    (Some st_0).

  Definition s2tt_init_unassigned_loop759_rank (v: Ptr) (v_0: Z) (v_1: Z) : Z :=
    0.

  Definition s2tt_init_unassigned_loop759_0_rank (v: Ptr) (v_0: Z) (v_1: Z) : Z :=
    0.

  Definition rtt_walk_lock_unlock_spec_abs (v_0: Ptr) (v_1: Ptr) (v_2: Z) (v_3: Z) (v_4: Z) (v_5: Z) (st: RData) : (option (abs_ret_rtt * RData)) :=
    when ret_1, st_1 == ((__find_lock_next_level_spec v_0 v_4 0 st));
    if (ptr_eqb ret_1 (mkPtr "null" 0))
    then (
      when i, s == ((s2_addr_to_idx_spec v_4 0 st_1));
      (Some ((mkabs_ret_rtt 0 v_0 i), s)))
    else (
      when st_2 == ((granule_unlock_spec v_0 st_1));
      when ret_2, st_3 == ((__find_lock_next_level_spec ret_1 v_4 1 st_2));
      if (ptr_eqb ret_2 (mkPtr "null" 0))
      then (
        when i, s == ((s2_addr_to_idx_spec v_4 1 st_3));
        (Some ((mkabs_ret_rtt 1 ret_1 i), s)))
      else (
        when st_4 == ((granule_unlock_spec ret_1 st_3));
        when ret_3, st_5 == ((__find_lock_next_level_spec ret_2 v_4 2 st_4));
        if (ptr_eqb ret_3 (mkPtr "null" 0))
        then (
          when i, s == ((s2_addr_to_idx_spec v_4 2 st_5));
          (Some ((mkabs_ret_rtt 2 ret_2 i), s)))
        else (
          when st_6 == ((granule_unlock_spec ret_2 st_5));
          when i, s == ((s2_addr_to_idx_spec v_4 2 st_6));
          (Some ((mkabs_ret_rtt 3 ret_3 i), s))))).

  Definition set_pas_any_to_ns_spec (v_0: Z) (st: RData) : (option RData) :=
    (Some st).

  Definition set_pas_ns_to_any_spec (v_0: Z) (st: RData) : (option RData) :=
    (Some st).

  Definition s2tte_pa_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    when ret == ((s2tte_pa_spec' v_0 v_1));
    (Some (ret, st)).

  Definition rtt_walk_lock_unlock_spec (v_0: Ptr) (v_1: Ptr) (v_2: Z) (v_3: Z) (v_4: Z) (v_5: Z) (st: RData) : (option RData) :=
    None.

  Definition granule_set_state_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
    rely ((((v_0.(poffset)) mod (16)) = (0)));
    (Some (st.[share].[globals].[g_granules] :<
      ((((st.(share)).(globals)).(g_granules)) #
        (((v_0.(poffset)) + (4)) / (16)) ==
        (((((st.(share)).(globals)).(g_granules)) @ (((v_0.(poffset)) + (4)) / (16))).[e_state_s_granule] :< v_1)))).

  Definition pack_return_code_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    (Some ((pack_struct_return_code_para (make_return_code_para v_0)), st)).

  Definition __granule_get_spec (v_0: Ptr) (st: RData) : (option RData) :=
    rely (((v_0.(pbase)) =s ("granules")));
    rely (((((v_0.(poffset)) + (8)) mod (16)) = (8)));
    (Some (st.[share].[globals].[g_granules] :<
      ((((st.(share)).(globals)).(g_granules)) #
        (((v_0.(poffset)) + (8)) / (16)) ==
        (((((st.(share)).(globals)).(g_granules)) @ (((v_0.(poffset)) + (8)) / (16))).[e_ref] :<
          ((((((st.(share)).(globals)).(g_granules)) @ (((v_0.(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
            (((((((st.(share)).(globals)).(g_granules)) @ (((v_0.(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))))).

  Definition g_refcount_spec (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
    when v_3, st_0 == ((load_RData 8 (mkPtr (v_0.(pbase)) ((v_0.(poffset)) + (8))) st));
    (Some ((v_3 & (4095)), st_0)).

  Definition s2tte_create_assigned_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    (Some ((v_0 |' (4)), st)).

  Definition stage1_tlbi_all_spec (st: RData) : (option RData) :=
    (Some st).

  Definition s1tte_pa_spec (v_0: Z) (st: RData) : (option (Z * RData)) :=
    (Some (((v_0 & (281474976710655)) & (((- 1) << (12)))), st)).

  Definition s2tte_is_unassigned_spec (v_0: Z) (st: RData) : (option (bool * RData)) :=
    (Some (((v_0 & (63)) =? (0)), st)).

  Definition s1tte_create_valid_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    when ret == ((s1tte_create_valid_spec' v_0 v_1));
    (Some (ret, st)).

  Definition s2tte_get_ripas_spec (v_0: Z) (st: RData) : (option (Z * RData)) :=
    when ret == ((s2tte_get_ripas_spec' v_0));
    (Some (ret, st)).

  Definition ns_buffer_unmap_spec (v_0: Z) (st: RData) : (option RData) :=
    (Some st).

  Definition ns_buffer_read_spec (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Ptr) (st: RData) : (option (bool * RData)) :=
    when ret == ((granule_pa_to_va_spec' v_1));
    when v_6, st_1 == ((memcpy_ns_read_spec v_3 ret v_2 st));
    (Some (v_6, st_1)).

  Definition s2tte_create_table_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    (Some ((v_0 |' (3)), st)).

  Definition s2tt_init_unassigned_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
    (Some st).

End Layer6_Spec.

Opaque s2tte_get_ripas_spec'.
Opaque s1tte_create_valid_spec'.
Opaque s2tte_pa_spec'.
#[global] Hint Unfold __granule_put_spec: spec.
#[global] Hint Unfold s2tte_create_assigned_spec_abs: spec.
#[global] Hint Unfold s1tte_create_valid_spec_abs: spec.
#[global] Hint Unfold s1tte_pa_spec_abs: spec.
#[global] Hint Unfold s2tte_pa_spec_abs: spec.
#[global] Hint Unfold g_mapped_addr_set_spec: spec.
#[global] Hint Unfold s2tte_is_unassigned_spec_abs: spec.
#[global] Hint Unfold s2tte_is_assigned_spec_abs: spec.
#[global] Hint Unfold s2tte_get_ripas_spec_abs: spec.
#[global] Hint Unfold s2tte_is_table_spec_abs: spec.
#[global] Hint Unfold find_lock_two_granules_spec_abs: spec.
Opaque __tte_write_spec.
#[global] Hint Unfold store_RData_granule_data: spec.
#[global] Hint Unfold __tte_write_spec_abs: spec.
#[global] Hint Unfold s2tt_init_unassigned_loop759_rank: spec.
#[global] Hint Unfold s2tt_init_unassigned_loop759_0_rank: spec.
Opaque rtt_walk_lock_unlock_spec_abs.
#[global] Hint Unfold set_pas_any_to_ns_spec: spec.
#[global] Hint Unfold set_pas_ns_to_any_spec: spec.
#[global] Hint Unfold s2tte_pa_spec: spec.
Opaque rtt_walk_lock_unlock_spec.
#[global] Hint Unfold granule_set_state_spec: spec.
#[global] Hint Unfold pack_return_code_spec: spec.
#[global] Hint Unfold __granule_get_spec: spec.
#[global] Hint Unfold g_refcount_spec: spec.
#[global] Hint Unfold s2tte_create_assigned_spec: spec.
#[global] Hint Unfold stage1_tlbi_all_spec: spec.
#[global] Hint Unfold s1tte_pa_spec: spec.
#[global] Hint Unfold s2tte_is_unassigned_spec: spec.
#[global] Hint Unfold s1tte_create_valid_spec: spec.
#[global] Hint Unfold s2tte_get_ripas_spec: spec.
#[global] Hint Unfold ns_buffer_unmap_spec: spec.
#[global] Hint Unfold ns_buffer_read_spec: spec.
#[global] Hint Unfold s2tte_create_table_spec: spec.
Opaque s2tt_init_unassigned_spec.
