Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer2.Spec.
Require Import Layer3.Spec.
Require Import Layer4.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer7.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter rec_to_ttbr1_para : Ptr -> (RData -> Ptr).

Section Layer8_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition rtt_create_s1_el1_spec_abs (v_0: Ptr) (v_1: abs_PA_t) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    let ttbr := (rec_to_ttbr1_para v_0 st) in
    when st_1 == ((granule_lock_spec ttbr 5 st));
    when v_7, st_2 == ((rtt_create_internal_spec_abs ttbr v_1 v_2 v_3 1 st_1));
    ((Some v_7), st_2).

  Definition map_unmap_ns_s1_0 (st_0: RData) (st_12: RData) (v_17: Ptr) (v_3: abs_PTE_t) (v_31: Z) (v__sroa_0_0_copyload: Ptr) (v__sroa_7_0_copyload: Z) : (option (Z * RData)) :=
    rely (((v_31 =? (0)) = (true)));
    rely (((v__sroa_0_0_copyload.(pbase)) =s ("granules")));
    rely (((((v__sroa_0_0_copyload.(poffset)) + (8)) mod (16)) = (8)));
    when st_19 == (
        (granule_unlock_spec
          v__sroa_0_0_copyload
          ((st_12.[share].[globals].[g_granules] :<
            ((((st_12.(share)).(globals)).(g_granules)) #
              (((v__sroa_0_0_copyload.(poffset)) + (8)) / (16)) ==
              (((((st_12.(share)).(globals)).(g_granules)) @ (((v__sroa_0_0_copyload.(poffset)) + (8)) / (16))).[e_ref] :<
                ((((((st_12.(share)).(globals)).(g_granules)) @ (((v__sroa_0_0_copyload.(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                  (((((((st_12.(share)).(globals)).(g_granules)) @ (((v__sroa_0_0_copyload.(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1)))))).[share].[granule_data] :<
            (((st_12.(share)).(granule_data)) #
              (((v_17.(poffset)) + ((8 * (v__sroa_7_0_copyload)))) / (4096)) ==
              ((((st_12.(share)).(granule_data)) @ (((v_17.(poffset)) + ((8 * (v__sroa_7_0_copyload)))) / (4096))).[g_norm] :<
                (((((st_12.(share)).(granule_data)) @ (((v_17.(poffset)) + ((8 * (v__sroa_7_0_copyload)))) / (4096))).(g_norm)) #
                  (((v_17.(poffset)) + ((8 * (v__sroa_7_0_copyload)))) mod (4096)) ==
                  (test_PTE_Z v_3)))))));
    (Some (0, st_19)).

  Definition map_unmap_ns_s1_1 (st_0: RData) (st_11: RData) (v_17: Ptr) (v_3: abs_PTE_t) (v__sroa_0_0_copyload: Ptr) (v__sroa_7_0_copyload: Z) : (option (Z * RData)) :=
    rely (((v__sroa_0_0_copyload.(pbase)) =s ("granules")));
    rely (((((v__sroa_0_0_copyload.(poffset)) + (8)) mod (16)) = (8)));
    when st_18 == (
        (granule_unlock_spec
          v__sroa_0_0_copyload
          ((st_11.[share].[globals].[g_granules] :<
            ((((st_11.(share)).(globals)).(g_granules)) #
              (((v__sroa_0_0_copyload.(poffset)) + (8)) / (16)) ==
              (((((st_11.(share)).(globals)).(g_granules)) @ (((v__sroa_0_0_copyload.(poffset)) + (8)) / (16))).[e_ref] :<
                ((((((st_11.(share)).(globals)).(g_granules)) @ (((v__sroa_0_0_copyload.(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                  (((((((st_11.(share)).(globals)).(g_granules)) @ (((v__sroa_0_0_copyload.(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1)))))).[share].[granule_data] :<
            (((st_11.(share)).(granule_data)) #
              (((v_17.(poffset)) + ((8 * (v__sroa_7_0_copyload)))) / (4096)) ==
              ((((st_11.(share)).(granule_data)) @ (((v_17.(poffset)) + ((8 * (v__sroa_7_0_copyload)))) / (4096))).[g_norm] :<
                (((((st_11.(share)).(granule_data)) @ (((v_17.(poffset)) + ((8 * (v__sroa_7_0_copyload)))) / (4096))).(g_norm)) #
                  (((v_17.(poffset)) + ((8 * (v__sroa_7_0_copyload)))) mod (4096)) ==
                  (test_PTE_Z v_3)))))));
    (Some (0, st_18)).

  Definition map_unmap_ns_s1_2 (st_0: RData) (st_12: RData) (v_17: Ptr) (v_47: Z) (v__sroa_0_0_copyload: Ptr) (v__sroa_7_0_copyload: Z) : (option (Z * RData)) :=
    rely (((v_47 =? (0)) = (true)));
    rely (((((v__sroa_0_0_copyload.(pbase)) = ("granules")) /\ ((((v__sroa_0_0_copyload.(poffset)) mod (16)) = (0)))) /\ (((v__sroa_0_0_copyload.(poffset)) >= (0)))));
    when st_20 == (
        (granule_unlock_spec
          v__sroa_0_0_copyload
          ((st_12.[share].[globals].[g_granules] :<
            ((((st_12.(share)).(globals)).(g_granules)) #
              ((v__sroa_0_0_copyload.(poffset)) / (16)) ==
              (((((st_12.(share)).(globals)).(g_granules)) @ ((v__sroa_0_0_copyload.(poffset)) / (16))).[e_ref] :<
                ((((((st_12.(share)).(globals)).(g_granules)) @ ((v__sroa_0_0_copyload.(poffset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                  (((((((st_12.(share)).(globals)).(g_granules)) @ ((v__sroa_0_0_copyload.(poffset)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
            (((st_12.(share)).(granule_data)) #
              (((v_17.(poffset)) + ((8 * (v__sroa_7_0_copyload)))) / (4096)) ==
              ((((st_12.(share)).(granule_data)) @ (((v_17.(poffset)) + ((8 * (v__sroa_7_0_copyload)))) / (4096))).[g_norm] :<
                (((((st_12.(share)).(granule_data)) @ (((v_17.(poffset)) + ((8 * (v__sroa_7_0_copyload)))) / (4096))).(g_norm)) #
                  (((v_17.(poffset)) + ((8 * (v__sroa_7_0_copyload)))) mod (4096)) ==
                  (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1))))))));
    (Some (0, st_20)).

  Definition map_unmap_ns_s1_3 (st_0: RData) (st_11: RData) (v_17: Ptr) (v_20: abs_PTE_t) (v__sroa_0_0_copyload: Ptr) (v__sroa_7_0_copyload: Z) : (option (Z * RData)) :=
    rely (((((v__sroa_0_0_copyload.(pbase)) = ("granules")) /\ ((((v__sroa_0_0_copyload.(poffset)) mod (16)) = (0)))) /\ (((v__sroa_0_0_copyload.(poffset)) >= (0)))));
    when st_19 == (
        (granule_unlock_spec
          v__sroa_0_0_copyload
          ((st_11.[share].[globals].[g_granules] :<
            ((((st_11.(share)).(globals)).(g_granules)) #
              ((v__sroa_0_0_copyload.(poffset)) / (16)) ==
              (((((st_11.(share)).(globals)).(g_granules)) @ ((v__sroa_0_0_copyload.(poffset)) / (16))).[e_ref] :<
                ((((((st_11.(share)).(globals)).(g_granules)) @ ((v__sroa_0_0_copyload.(poffset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                  (((((((st_11.(share)).(globals)).(g_granules)) @ ((v__sroa_0_0_copyload.(poffset)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
            (((st_11.(share)).(granule_data)) #
              (((v_17.(poffset)) + ((8 * (v__sroa_7_0_copyload)))) / (4096)) ==
              ((((st_11.(share)).(granule_data)) @ (((v_17.(poffset)) + ((8 * (v__sroa_7_0_copyload)))) / (4096))).[g_norm] :<
                (((((st_11.(share)).(granule_data)) @ (((v_17.(poffset)) + ((8 * (v__sroa_7_0_copyload)))) / (4096))).(g_norm)) #
                  (((v_17.(poffset)) + ((8 * (v__sroa_7_0_copyload)))) mod (4096)) ==
                  (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1))))))));
    (Some (0, st_19)).

  Definition map_unmap_ns_s1_spec (v_0_Zptr: Z) (v_1: Z) (v_2: Z) (v_3: Z) (v_4: Z) (st: RData) : (option (Z * RData)) :=
    when st_3 == ((granule_lock_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) 5 st));
    when ret_rtt, st_4 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "stack_s_rtt_walk" 0) (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) 0 64 v_1 v_2 st_3));
    rely ((((st_4.(share)).(granule_data)) = (((st_3.(share)).(granule_data)))));
    if (((ret_rtt.(e_1)) - (v_2)) =? (0))
    then (
      if (v_4 =? (0))
      then (
        if (
          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_desc_type)) =? (0)) &&
            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_ripas)) =? (0)))))
        then (
          if (uart0_phys_para (test_Z_PTE v_3))
          then (
            rely ((((ret_rtt.(e_2)).(pbase)) =s ("granules")));
            rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (16)) = (8)));
            when st_18 == (
                (granule_unlock_spec
                  (ret_rtt.(e_2))
                  ((st_4.[share].[globals].[g_granules] :<
                    ((((st_4.(share)).(globals)).(g_granules)) #
                      ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16)) ==
                      (((((st_4.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                        ((((((st_4.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                          (((((((st_4.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1)))))).[share].[granule_data] :<
                    (((st_4.(share)).(granule_data)) #
                      ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                      ((((st_4.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                        (((((st_4.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                          ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                          (test_PTE_Z (test_Z_PTE v_3))))))));
            (Some (0, st_18)))
          else (
            when st_1 == ((spinlock_acquire_spec (mkPtr "granules" (((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset))) st_4));
            if ((((((st_1.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (16))).(e_state_s_granule)) =? (0))
            then (
              rely (((((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)) /\ (((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) >= (0)))));
              when st_6 == (
                  (granule_unlock_spec
                    (mkPtr "granules" (((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)))
                    (st_1.[share].[globals].[g_granules] :<
                      ((((st_1.(share)).(globals)).(g_granules)) #
                        ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                        ((((((st_1.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                          ((((((st_1.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                            ((g_mapped_addr_set_para
                              ((((((st_1.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0))
                              v_1) +
                              (1)))).[e_state_s_granule] :<
                          6)))));
              rely ((((ret_rtt.(e_2)).(pbase)) =s ("granules")));
              rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (16)) = (8)));
              when st_19 == (
                  (granule_unlock_spec
                    (ret_rtt.(e_2))
                    ((st_6.[share].[globals].[g_granules] :<
                      ((((st_6.(share)).(globals)).(g_granules)) #
                        ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16)) ==
                        (((((st_6.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                          ((((((st_6.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                            (((((((st_6.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1)))))).[share].[granule_data] :<
                      (((st_6.(share)).(granule_data)) #
                        ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                        ((((st_6.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                          (((((st_6.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                            ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                            (test_PTE_Z (test_Z_PTE v_3))))))));
              (Some (0, st_19)))
            else (
              when st_2 == ((spinlock_release_spec (mkPtr "granules" (((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset))) st_1));
              when st_5 == ((spinlock_acquire_spec (mkPtr "granules" (((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset))) st_2));
              if (((((((st_5.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (16))).(e_state_s_granule)) - (6)) =? (0))
              then (
                rely (((((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)) /\ (((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) >= (0)))));
                rely (((((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) + (8)) mod (16)) = (8)));
                when st_6 == (
                    (granule_unlock_spec
                      (mkPtr "granules" (((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)))
                      (st_5.[share].[globals].[g_granules] :<
                        ((((st_5.(share)).(globals)).(g_granules)) #
                          ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (16)) ==
                          (((((st_5.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                            ((((((st_5.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st_5.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))))));
                rely ((true = (true)));
                rely ((((ret_rtt.(e_2)).(pbase)) =s ("granules")));
                rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (16)) = (8)));
                when st_19 == (
                    (granule_unlock_spec
                      (ret_rtt.(e_2))
                      ((st_6.[share].[globals].[g_granules] :<
                        ((((st_6.(share)).(globals)).(g_granules)) #
                          ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16)) ==
                          (((((st_6.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                            ((((((st_6.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st_6.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1)))))).[share].[granule_data] :<
                        (((st_6.(share)).(granule_data)) #
                          ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                          ((((st_6.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                            (((((st_6.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                              ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                              (test_PTE_Z (test_Z_PTE v_3))))))));
                (Some (0, st_19)))
              else (
                when st_6 == ((spinlock_release_spec (mkPtr "granules" (((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset))) st_5));
                if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                then (
                  rely ((((ret_rtt.(e_2)).(pbase)) =s ("granules")));
                  rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (16)) = (8)));
                  when st_19 == (
                      (granule_unlock_spec
                        (ret_rtt.(e_2))
                        ((st_6.[share].[globals].[g_granules] :<
                          ((((st_6.(share)).(globals)).(g_granules)) #
                            ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16)) ==
                            (((((st_6.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).[e_ref] :<
                              ((((((st_6.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_6.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1)))))).[share].[granule_data] :<
                          (((st_6.(share)).(granule_data)) #
                            ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                            ((((st_6.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                              (((((st_6.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                (test_PTE_Z (test_Z_PTE v_3))))))));
                  (Some (0, st_19)))
                else (
                  when st_14 == ((granule_unlock_spec (ret_rtt.(e_2)) st_6));
                  (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_14)))))))
        else (
          when st_13 == ((granule_unlock_spec (ret_rtt.(e_2)) st_4));
          (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_13))))
      else (
        if (v_4 =? (1))
        then (
          if ((v_2 =? (3)) && ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_desc_type)) =? (3))))
          then (
            if (uart0_phys_para (abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4))
            then (
              rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
              when st_19 == (
                  (granule_unlock_spec
                    (ret_rtt.(e_2))
                    ((st_4.[share].[globals].[g_granules] :<
                      ((((st_4.(share)).(globals)).(g_granules)) #
                        (((ret_rtt.(e_2)).(poffset)) / (16)) ==
                        (((((st_4.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).[e_ref] :<
                          ((((((st_4.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                            (((((((st_4.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                      (((st_4.(share)).(granule_data)) #
                        ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                        ((((st_4.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                          (((((st_4.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                            ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                            (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1))))))));
              (Some (0, st_19)))
            else (
              when st_1 == (
                  (spinlock_acquire_spec
                    (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                    st_4));
              if (
                (((((((st_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).(e_state_s_granule)) -
                  (6)) =?
                  (0)))
              then (
                rely (
                  ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)) /\
                    (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) >= (0)))));
                if (
                  ((g_refcount_para
                    (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                    (st_1.[share].[globals].[g_granules] :<
                      ((((st_1.(share)).(globals)).(g_granules)) #
                        ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16)) ==
                        (((((st_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                          ((((((st_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                            (((((((st_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                              ((- 1)))))))) =?
                    (0)))
                then (
                  when st_7 == (
                      (granule_unlock_spec
                        (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                        (st_1.[share].[globals].[g_granules] :<
                          ((((st_1.(share)).(globals)).(g_granules)) #
                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            ((((((st_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                              ((((((st_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                (g_mapped_addr_set_para
                                  (((((((st_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                    ((- 1)))
                                  0))).[e_state_s_granule] :<
                              0)))));
                  rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                  when st_20 == (
                      (granule_unlock_spec
                        (ret_rtt.(e_2))
                        ((st_7.[share].[globals].[g_granules] :<
                          ((((st_7.(share)).(globals)).(g_granules)) #
                            (((ret_rtt.(e_2)).(poffset)) / (16)) ==
                            (((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).[e_ref] :<
                              ((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                          (((st_7.(share)).(granule_data)) #
                            ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                            ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                              (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1))))))));
                  (Some (0, st_20)))
                else (
                  when st_5 == (
                      (granule_unlock_spec
                        (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                        (st_1.[share].[globals].[g_granules] :<
                          ((((st_1.(share)).(globals)).(g_granules)) #
                            ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16)) ==
                            (((((st_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                              ((((((st_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                (g_mapped_addr_set_para
                                  (((((((st_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                    ((- 1)))
                                  0)))))));
                  rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                  when st_20 == (
                      (granule_unlock_spec
                        (ret_rtt.(e_2))
                        ((st_5.[share].[globals].[g_granules] :<
                          ((((st_5.(share)).(globals)).(g_granules)) #
                            (((ret_rtt.(e_2)).(poffset)) / (16)) ==
                            (((((st_5.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).[e_ref] :<
                              ((((((st_5.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_5.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                          (((st_5.(share)).(granule_data)) #
                            ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                            ((((st_5.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                              (((((st_5.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1))))))));
                  (Some (0, st_20))))
              else (
                when st_2 == (
                    (spinlock_release_spec
                      (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                      st_1));
                if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                then (
                  rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                  when st_20 == (
                      (granule_unlock_spec
                        (ret_rtt.(e_2))
                        ((st_2.[share].[globals].[g_granules] :<
                          ((((st_2.(share)).(globals)).(g_granules)) #
                            (((ret_rtt.(e_2)).(poffset)) / (16)) ==
                            (((((st_2.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).[e_ref] :<
                              ((((((st_2.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_2.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                          (((st_2.(share)).(granule_data)) #
                            ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                            ((((st_2.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                              (((((st_2.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1))))))));
                  (Some (0, st_20)))
                else (
                  when st_14 == ((granule_unlock_spec (ret_rtt.(e_2)) st_2));
                  (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_14))))))
          else (
            if ((v_2 <>? (3)) && ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_desc_type)) =? (1))))
            then (
              if (uart0_phys_para (abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4))
              then (
                rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                when st_19 == (
                    (granule_unlock_spec
                      (ret_rtt.(e_2))
                      ((st_4.[share].[globals].[g_granules] :<
                        ((((st_4.(share)).(globals)).(g_granules)) #
                          (((ret_rtt.(e_2)).(poffset)) / (16)) ==
                          (((((st_4.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).[e_ref] :<
                            ((((((st_4.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st_4.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                        (((st_4.(share)).(granule_data)) #
                          ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                          ((((st_4.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                            (((((st_4.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                              ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                              (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1))))))));
                (Some (0, st_19)))
              else (
                when st_1 == (
                    (spinlock_acquire_spec
                      (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                      st_4));
                if (
                  (((((((st_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).(e_state_s_granule)) -
                    (6)) =?
                    (0)))
                then (
                  rely (
                    ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) mod (16)) = (0)) /\
                      (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) >= (0)))));
                  if (
                    ((g_refcount_para
                      (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                      (st_1.[share].[globals].[g_granules] :<
                        ((((st_1.(share)).(globals)).(g_granules)) #
                          ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16)) ==
                          (((((st_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                            ((((((st_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                ((- 1)))))))) =?
                      (0)))
                  then (
                    when st_7 == (
                        (granule_unlock_spec
                          (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                          (st_1.[share].[globals].[g_granules] :<
                            ((((st_1.(share)).(globals)).(g_granules)) #
                              ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16)) ==
                              ((((((st_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                                ((((((st_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                  (g_mapped_addr_set_para
                                    (((((((st_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                      ((- 1)))
                                    0))).[e_state_s_granule] :<
                                0)))));
                    rely ((true = (true)));
                    rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                    when st_20 == (
                        (granule_unlock_spec
                          (ret_rtt.(e_2))
                          ((st_7.[share].[globals].[g_granules] :<
                            ((((st_7.(share)).(globals)).(g_granules)) #
                              (((ret_rtt.(e_2)).(poffset)) / (16)) ==
                              (((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).[e_ref] :<
                                ((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_7.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                            (((st_7.(share)).(granule_data)) #
                              ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                              ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                  (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1))))))));
                    (Some (0, st_20)))
                  else (
                    when st_5 == (
                        (granule_unlock_spec
                          (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                          (st_1.[share].[globals].[g_granules] :<
                            ((((st_1.(share)).(globals)).(g_granules)) #
                              ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16)) ==
                              (((((st_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).[e_ref] :<
                                ((((((st_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                  (g_mapped_addr_set_para
                                    (((((((st_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                                      ((- 1)))
                                    0)))))));
                    rely ((true = (true)));
                    rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                    when st_20 == (
                        (granule_unlock_spec
                          (ret_rtt.(e_2))
                          ((st_5.[share].[globals].[g_granules] :<
                            ((((st_5.(share)).(globals)).(g_granules)) #
                              (((ret_rtt.(e_2)).(poffset)) / (16)) ==
                              (((((st_5.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).[e_ref] :<
                                ((((((st_5.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_5.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                            (((st_5.(share)).(granule_data)) #
                              ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                              ((((st_5.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                (((((st_5.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                  (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1))))))));
                    (Some (0, st_20))))
                else (
                  when st_2 == (
                      (spinlock_release_spec
                        (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                        st_1));
                  if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                  then (
                    rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                    when st_20 == (
                        (granule_unlock_spec
                          (ret_rtt.(e_2))
                          ((st_2.[share].[globals].[g_granules] :<
                            ((((st_2.(share)).(globals)).(g_granules)) #
                              (((ret_rtt.(e_2)).(poffset)) / (16)) ==
                              (((((st_2.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).[e_ref] :<
                                ((((((st_2.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_2.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                            (((st_2.(share)).(granule_data)) #
                              ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                              ((((st_2.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                (((((st_2.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                  (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1))))))));
                    (Some (0, st_20)))
                  else (
                    when st_14 == ((granule_unlock_spec (ret_rtt.(e_2)) st_2));
                    (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_14))))))
            else (
              when st_13 == ((granule_unlock_spec (ret_rtt.(e_2)) st_4));
              (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_13)))))
        else (
          when st_12 == ((granule_unlock_spec (ret_rtt.(e_2)) st_4));
          (Some (0, st_12)))))
    else (
      when st_8 == ((granule_unlock_spec (ret_rtt.(e_2)) st_4));
      (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_8))).

End Layer8_Spec.

#[global] Hint Unfold rtt_create_s1_el1_spec_abs: spec.
#[global] Hint Unfold map_unmap_ns_s1_0: spec.
#[global] Hint Unfold map_unmap_ns_s1_1: spec.
#[global] Hint Unfold map_unmap_ns_s1_2: spec.
#[global] Hint Unfold map_unmap_ns_s1_3: spec.
#[global] Hint Unfold map_unmap_ns_s1_spec: spec.
