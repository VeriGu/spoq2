Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer1.Spec.
Require Import Layer2.Spec.
Require Import Layer3.Spec.
Require Import Layer4.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer7.data_create_internal.LowSpec.
Require Import Layer7.realm_ipa_to_pa.LowSpec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer7_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition get_tte_spec' (v_0: Z) (st: RData) : (option (Ptr * RData)) :=
    if ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (3)) =? (3))
    then (
      rely (
        ((((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) -
          (MEM0_VIRT)) >=
          (0)) \/
          ((((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) -
            (MEM1_VIRT)) >=
            (0)))));
      if (
        (((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) - (MAX_ERR)) >=?
          (0)))
      then None
      else (
        if (
          (((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) -
            (MEM1_VIRT)) >=?
            (0)))
        then (
          if (
            (((((((st.(share)).(granule_data)) @
              (((18446744007137558528 +
                ((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))))) +
                ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) /
                (4096))).(g_norm)) @
              (((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) +
                ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) mod
                (4096))) &
              (3)) =?
              (3)))
          then (
            rely (
              ((((PA_TO_VA
                (((((((st.(share)).(granule_data)) @
                  (((18446744007137558528 +
                    ((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))))) +
                    ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) /
                    (4096))).(g_norm)) @
                  (((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) +
                    ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) mod
                    (4096))) &
                  (281474976710655)) &
                  (((- 1) << (12))))) -
                (MEM0_VIRT)) >=
                (0)) \/
                ((((PA_TO_VA
                  (((((((st.(share)).(granule_data)) @
                    (((18446744007137558528 +
                      ((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))))) +
                      ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) /
                      (4096))).(g_norm)) @
                    (((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) +
                      ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) mod
                      (4096))) &
                    (281474976710655)) &
                    (((- 1) << (12))))) -
                  (MEM1_VIRT)) >=
                  (0)))));
            if (
              (((PA_TO_VA
                (((((((st.(share)).(granule_data)) @
                  (((18446744007137558528 +
                    ((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))))) +
                    ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) /
                    (4096))).(g_norm)) @
                  (((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) +
                    ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) mod
                    (4096))) &
                  (281474976710655)) &
                  (((- 1) << (12))))) -
                (MAX_ERR)) >=?
                (0)))
            then (
              (Some (
                (mkPtr
                  "status"
                  (((PA_TO_VA
                    (((((((st.(share)).(granule_data)) @
                      (((18446744007137558528 +
                        ((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))))) +
                        ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) /
                        (4096))).(g_norm)) @
                      (((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) +
                        ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) mod
                        (4096))) &
                      (281474976710655)) &
                      (((- 1) << (12))))) -
                    (MAX_ERR)) +
                    ((8 * ((((v_0 & (68719476735)) >> (12)) & (511)))))))  ,
                st
              )))
            else (
              if (
                (((PA_TO_VA
                  (((((((st.(share)).(granule_data)) @
                    (((18446744007137558528 +
                      ((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))))) +
                      ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) /
                      (4096))).(g_norm)) @
                    (((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) +
                      ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) mod
                      (4096))) &
                    (281474976710655)) &
                    (((- 1) << (12))))) -
                  (MEM1_VIRT)) >=?
                  (0)))
              then (
                (Some (
                  (mkPtr
                    "granule_data"
                    ((((PA_TO_VA
                      (((((((st.(share)).(granule_data)) @
                        (((18446744007137558528 +
                          ((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))))) +
                          ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) /
                          (4096))).(g_norm)) @
                        (((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) +
                          ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) mod
                          (4096))) &
                        (281474976710655)) &
                        (((- 1) << (12))))) -
                      (MEM1_VIRT)) +
                      (MEM0_SIZE)) +
                      ((8 * ((((v_0 & (68719476735)) >> (12)) & (511)))))))  ,
                  st
                )))
              else (
                (Some (
                  (mkPtr
                    "granule_data"
                    (((PA_TO_VA
                      (((((((st.(share)).(granule_data)) @
                        (((18446744007137558528 +
                          ((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))))) +
                          ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) /
                          (4096))).(g_norm)) @
                        (((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) +
                          ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) mod
                          (4096))) &
                        (281474976710655)) &
                        (((- 1) << (12))))) -
                      (MEM0_VIRT)) +
                      ((8 * ((((v_0 & (68719476735)) >> (12)) & (511)))))))  ,
                  st
                )))))
          else (Some ((mkPtr "null" 0), st)))
        else (
          if (
            (((((((st.(share)).(granule_data)) @
              ((((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) -
                (MEM0_VIRT)) +
                ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) /
                (4096))).(g_norm)) @
              (((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) +
                ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) mod
                (4096))) &
              (3)) =?
              (3)))
          then (
            rely (
              ((((PA_TO_VA
                (((((((st.(share)).(granule_data)) @
                  ((((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) -
                    (MEM0_VIRT)) +
                    ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) /
                    (4096))).(g_norm)) @
                  (((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) +
                    ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) mod
                    (4096))) &
                  (281474976710655)) &
                  (((- 1) << (12))))) -
                (MEM0_VIRT)) >=
                (0)) \/
                ((((PA_TO_VA
                  (((((((st.(share)).(granule_data)) @
                    ((((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) -
                      (MEM0_VIRT)) +
                      ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) /
                      (4096))).(g_norm)) @
                    (((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) +
                      ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) mod
                      (4096))) &
                    (281474976710655)) &
                    (((- 1) << (12))))) -
                  (MEM1_VIRT)) >=
                  (0)))));
            if (
              (((PA_TO_VA
                (((((((st.(share)).(granule_data)) @
                  ((((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) -
                    (MEM0_VIRT)) +
                    ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) /
                    (4096))).(g_norm)) @
                  (((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) +
                    ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) mod
                    (4096))) &
                  (281474976710655)) &
                  (((- 1) << (12))))) -
                (MAX_ERR)) >=?
                (0)))
            then (
              (Some (
                (mkPtr
                  "status"
                  (((PA_TO_VA
                    (((((((st.(share)).(granule_data)) @
                      ((((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) -
                        (MEM0_VIRT)) +
                        ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) /
                        (4096))).(g_norm)) @
                      (((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) +
                        ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) mod
                        (4096))) &
                      (281474976710655)) &
                      (((- 1) << (12))))) -
                    (MAX_ERR)) +
                    ((8 * ((((v_0 & (68719476735)) >> (12)) & (511)))))))  ,
                st
              )))
            else (
              if (
                (((PA_TO_VA
                  (((((((st.(share)).(granule_data)) @
                    ((((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) -
                      (MEM0_VIRT)) +
                      ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) /
                      (4096))).(g_norm)) @
                    (((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) +
                      ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) mod
                      (4096))) &
                    (281474976710655)) &
                    (((- 1) << (12))))) -
                  (MEM1_VIRT)) >=?
                  (0)))
              then (
                (Some (
                  (mkPtr
                    "granule_data"
                    ((((PA_TO_VA
                      (((((((st.(share)).(granule_data)) @
                        ((((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) -
                          (MEM0_VIRT)) +
                          ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) /
                          (4096))).(g_norm)) @
                        (((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) +
                          ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) mod
                          (4096))) &
                        (281474976710655)) &
                        (((- 1) << (12))))) -
                      (MEM1_VIRT)) +
                      (MEM0_SIZE)) +
                      ((8 * ((((v_0 & (68719476735)) >> (12)) & (511)))))))  ,
                  st
                )))
              else (
                (Some (
                  (mkPtr
                    "granule_data"
                    (((PA_TO_VA
                      (((((((st.(share)).(granule_data)) @
                        ((((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) -
                          (MEM0_VIRT)) +
                          ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) /
                          (4096))).(g_norm)) @
                        (((PA_TO_VA ((((((st.(share)).(globals)).(g_tt_l1_upper)) @ (8 * ((((v_0 & (68719476735)) >> (30)) & (511))))) & (281474976710655)) & (((- 1) << (12))))) +
                          ((8 * ((((v_0 & (68719476735)) >> (21)) & (511)))))) mod
                          (4096))) &
                        (281474976710655)) &
                        (((- 1) << (12))))) -
                      (MEM0_VIRT)) +
                      ((8 * ((((v_0 & (68719476735)) >> (12)) & (511)))))))  ,
                  st
                )))))
          else (Some ((mkPtr "null" 0), st)))))
    else (Some ((mkPtr "null" 0), st)).

  Definition get_tte_spec (v_0: Z) (st: RData) : (option (Ptr * RData)) :=
    when ret, st' == ((get_tte_spec' v_0 st));
    (Some (ret, st)).

  Definition s1addr_level_mask_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    (Some ((((- 1) << (((39 + (((- 9) * (v_1)))) & (4294967295)))) & (v_0)), st)).

  Definition ranges_intersect_spec (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (bool * RData)) :=
    (Some (((((v_1 + (v_0)) - (v_2)) >? (0)) && ((((v_3 + (v_2)) - (v_0)) >? (0)))), st)).

  Definition get_sysreg_write_value_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    rely (((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))) /\ ((((v_0.(poffset)) mod (4096)) = (0)))));
    when v_3, st_0 == ((esr_sysreg_rt_spec v_1 st));
    if (v_3 =? (31))
    then (Some (0, st_0))
    else (
      rely ((((0 - (v_3)) <= (0)) /\ ((v_3 < (31)))));
      when v_9, st_1 == ((load_RData 8 (ptr_offset v_0 (24 + ((8 * (v_3))))) st_0));
      (Some (v_9, st_1))).

  Definition esr_srt_spec (v_0: Z) (st: RData) : (option (Z * RData)) :=
    (Some (((v_0 >> (16)) & (31)), st)).

  Definition access_mask_spec (v_0: Z) (st: RData) : (option (Z * RData)) :=
    when v_2, st_0 == ((esr_sas_spec v_0 st));
    if (v_2 =? (3))
    then (Some ((- 1), st_0))
    else (
      if (v_2 =? (0))
      then (Some (255, st_0))
      else (
        if (v_2 =? (1))
        then (Some (65535, st_0))
        else (
          if (v_2 =? (2))
          then (Some (4294967295, st_0))
          else (Some (0, st_0))))).

  Definition realm_ipa_to_pa_spec (v_0: Ptr) (v_1: Z) (v_2: Ptr) (v_3: Ptr) (v_4: Ptr) (st: RData) : (option (Z * RData)) :=
    when st_0 == ((new_frame "realm_ipa_to_pa" st));
    rely ((((v_4.(pbase)) = ("stack_type_3")) /\ (((v_4.(poffset)) = (0)))));
    rely ((((v_3.(pbase)) = ("stack_type_4")) /\ (((v_3.(poffset)) = (0)))));
    rely ((((v_2.(pbase)) = ("stack_type_3__1")) /\ (((v_2.(poffset)) = (0)))));
    rely (((((((st_0.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
    rely ((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))));
    if ((v_1 & (4095)) =? (0))
    then (
      when v_11, st_1 == ((is_addr_in_par_spec v_0 v_1 st_0));
      if v_11
      then (
        when v_15_tmp, st_2 == ((load_RData 8 (ptr_offset v_0 32) st_1));
        when st_3 == ((granule_lock_spec (int_to_ptr v_15_tmp) 5 st_2));
        when v_16, st_4 == ((realm_rtt_starting_level_spec v_0 st_3));
        when v_17, st_5 == ((realm_ipa_bits_spec v_0 st_4));
        when st_6 == ((rtt_walk_lock_unlock_spec (mkPtr "stack_s_rtt_walk" 0) (int_to_ptr v_15_tmp) v_16 v_17 v_1 3 st_5));
        rely ((((st_6.(share)).(granule_data)) = (((st_5.(share)).(granule_data)))));
        when v__sroa_0_0_copyload_tmp, st_7 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 0) st_6));
        when v__sroa_4_0_copyload, st_8 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 8) st_7));
        when v__sroa_5_0_copyload, st_9 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 16) st_8));
        when v_18, st_10 == ((granule_map_spec (int_to_ptr v__sroa_0_0_copyload_tmp) 6 st_9));
        when st_11 == ((store_RData 8 v_3 v__sroa_0_0_copyload_tmp st_10));
        when v_21, st_12 == ((__tte_read_spec (ptr_offset v_18 (8 * (v__sroa_4_0_copyload))) st_11));
        when v_22, st_13 == ((s2tte_is_valid_spec v_21 v__sroa_5_0_copyload st_12));
        if v_22
        then (realm_ipa_to_pa_0_low st_0 st_13 v_1 v_2 v_21 v_22 v__sroa_5_0_copyload)
        else (
          when st_14 == ((store_RData 8 v_4 v__sroa_5_0_copyload st_13));
          when st_15 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_14));
          when st_19 == ((free_stack "realm_ipa_to_pa" st_0 st_15));
          (Some (2, st_19))))
      else (
        when st_4 == ((free_stack "realm_ipa_to_pa" st_0 st_1));
        (Some (1, st_4))))
    else (
      when st_2 == ((free_stack "realm_ipa_to_pa" st_0 st_0));
      (Some (1, st_2))).

  Definition psci_cpu_off_spec (v_0: Ptr) (v_1: Ptr) (st: RData) : (option RData) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
    rely ((((v_1.(pbase)) = ("granule_data")) /\ (((v_1.(poffset)) >= (0)))));
    rely ((((v_0.(pbase)) = ("stack_s_psci_result")) /\ (((v_0.(poffset)) = (0)))));
    when st_0 == ((llvm_memset_p0i8_i64_spec (ptr_offset v_0 0) 0 64 false st));
    when st_1 == ((store_RData 1 (ptr_offset v_0 0) 1 st_0));
    when st_2 == ((store_RData 1 (ptr_offset v_1 16) 0 st_1));
    when st_3 == ((store_RData 8 (ptr_offset v_0 32) 0 st_2));
    (Some st_3).

  Definition psci_system_reset_spec (v_0: Ptr) (v_1: Ptr) (st: RData) : (option RData) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
    rely (((((v_1.(pbase)) = ("granule_data")) /\ (((v_1.(poffset)) >= (0)))) /\ ((((v_1.(poffset)) mod (4096)) = (0)))));
    rely ((((v_0.(pbase)) = ("stack_s_psci_result")) /\ (((v_0.(poffset)) = (0)))));
    when st_0 == ((llvm_memset_p0i8_i64_spec (ptr_offset v_0 0) 0 64 false st));
    when st_1 == ((system_off_reboot_spec v_1 st_0));
    when st_2 == ((store_RData 1 (ptr_offset v_0 0) 1 st_1));
    (Some st_2).

  Definition psci_system_off_spec (v_0: Ptr) (v_1: Ptr) (st: RData) : (option RData) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
    rely (((((v_1.(pbase)) = ("granule_data")) /\ (((v_1.(poffset)) >= (0)))) /\ ((((v_1.(poffset)) mod (4096)) = (0)))));
    rely ((((v_0.(pbase)) = ("stack_s_psci_result")) /\ (((v_0.(poffset)) = (0)))));
    when st_0 == ((llvm_memset_p0i8_i64_spec (ptr_offset v_0 0) 0 64 false st));
    when st_1 == ((system_off_reboot_spec v_1 st_0));
    when st_2 == ((store_RData 1 (ptr_offset v_0 0) 1 st_1));
    (Some st_2).

  Definition psci_affinity_info_spec (v_0: Ptr) (v_1: Ptr) (v_2: Z) (v_3: Z) (st: RData) : (option RData) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
    rely (((((v_1.(pbase)) = ("granule_data")) /\ (((v_1.(poffset)) >= (0)))) /\ ((((v_1.(poffset)) mod (4096)) = (0)))));
    rely ((((v_0.(pbase)) = ("stack_s_psci_result")) /\ (((v_0.(poffset)) = (0)))));
    when st_0 == ((llvm_memset_p0i8_i64_spec (ptr_offset v_0 0) 0 64 false st));
    if (v_3 =? (0))
    then (
      when v_9, st_1 == ((vmpidr_to_rec_idx_spec v_2 st_0));
      when v_12_tmp, st_2 == ((load_RData 8 (ptr_offset v_1 944) st_1));
      when v_13, st_3 == ((rd_map_read_rec_count_spec (int_to_ptr v_12_tmp) st_2));
      if ((v_13 - (v_9)) >? (0))
      then (
        when v_18, st_4 == ((load_RData 8 (ptr_offset v_1 8) st_3));
        if ((v_18 - (v_9)) =? (0))
        then (
          when st_5 == ((store_RData 8 (ptr_offset v_0 32) 0 st_4));
          (Some st_5))
        else (
          when st_5 == ((store_RData 1 (ptr_offset v_1 1512) 1 st_4));
          when st_6 == ((store_RData 1 (ptr_offset v_0 0) 1 st_5));
          when st_7 == ((store_RData 8 (ptr_offset v_0 8) v_2 st_6));
          (Some st_7)))
      else (
        when st_4 == ((store_RData 8 (ptr_offset v_0 32) (- 2) st_3));
        (Some st_4)))
    else (
      when st_1 == ((store_RData 8 (ptr_offset v_0 32) (- 2) st_0));
      (Some st_1)).

  Definition psci_features_spec (v_0: Ptr) (v_1: Ptr) (v_2: Z) (st: RData) : (option RData) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
    rely (((((v_1.(pbase)) = ("granule_data")) /\ (((v_1.(poffset)) >= (0)))) /\ ((((v_1.(poffset)) mod (4096)) = (0)))));
    rely ((((v_0.(pbase)) = ("stack_s_psci_result")) /\ (((v_0.(poffset)) = (0)))));
    when st_0 == ((llvm_memset_p0i8_i64_spec (ptr_offset v_0 0) 0 64 false st));
    if (
      ((((((((((v_2 =? (2214592513)) || ((v_2 =? (3288334337)))) || ((v_2 =? (2214592514)))) || ((v_2 =? (2214592515)))) || ((v_2 =? (3288334339)))) || ((v_2 =? (2214592516)))) ||
        ((v_2 =? (3288334340)))) ||
        ((v_2 =? (2214592520)))) ||
        ((v_2 =? (2214592521)))) ||
        ((v_2 =? (2214592522)))))
    then (
      if (
        (((((((((v_2 =? (2214592513)) || ((v_2 =? (3288334337)))) || ((v_2 =? (2214592514)))) || ((v_2 =? (2214592515)))) || ((v_2 =? (3288334339)))) || ((v_2 =? (2214592516)))) ||
          ((v_2 =? (3288334340)))) ||
          ((v_2 =? (2214592520)))) ||
          ((v_2 =? (2214592521)))))
      then (
        if (
          ((((((((v_2 =? (2214592513)) || ((v_2 =? (3288334337)))) || ((v_2 =? (2214592514)))) || ((v_2 =? (2214592515)))) || ((v_2 =? (3288334339)))) || ((v_2 =? (2214592516)))) ||
            ((v_2 =? (3288334340)))) ||
            ((v_2 =? (2214592520)))))
        then (
          if (
            (((((((v_2 =? (2214592513)) || ((v_2 =? (3288334337)))) || ((v_2 =? (2214592514)))) || ((v_2 =? (2214592515)))) || ((v_2 =? (3288334339)))) || ((v_2 =? (2214592516)))) ||
              ((v_2 =? (3288334340)))))
          then (
            if ((((((v_2 =? (2214592513)) || ((v_2 =? (3288334337)))) || ((v_2 =? (2214592514)))) || ((v_2 =? (2214592515)))) || ((v_2 =? (3288334339)))) || ((v_2 =? (2214592516))))
            then (
              if (((((v_2 =? (2214592513)) || ((v_2 =? (3288334337)))) || ((v_2 =? (2214592514)))) || ((v_2 =? (2214592515)))) || ((v_2 =? (3288334339))))
              then (
                if ((((v_2 =? (2214592513)) || ((v_2 =? (3288334337)))) || ((v_2 =? (2214592514)))) || ((v_2 =? (2214592515))))
                then (
                  if (((v_2 =? (2214592513)) || ((v_2 =? (3288334337)))) || ((v_2 =? (2214592514))))
                  then (
                    when st_11 == ((store_RData 8 (ptr_offset v_0 32) 0 st_0));
                    (Some st_11))
                  else (
                    when st_10 == ((store_RData 8 (ptr_offset v_0 32) 0 st_0));
                    (Some st_10)))
                else (
                  when st_9 == ((store_RData 8 (ptr_offset v_0 32) 0 st_0));
                  (Some st_9)))
              else (
                when st_8 == ((store_RData 8 (ptr_offset v_0 32) 0 st_0));
                (Some st_8)))
            else (
              when st_7 == ((store_RData 8 (ptr_offset v_0 32) 0 st_0));
              (Some st_7)))
          else (
            when st_6 == ((store_RData 8 (ptr_offset v_0 32) 0 st_0));
            (Some st_6)))
        else (
          when st_5 == ((store_RData 8 (ptr_offset v_0 32) 0 st_0));
          (Some st_5)))
      else (
        when st_4 == ((store_RData 8 (ptr_offset v_0 32) 0 st_0));
        (Some st_4)))
    else (
      when st_2 == ((store_RData 8 (ptr_offset v_0 32) (- 1) st_0));
      (Some st_2)).

  Definition psci_cpu_suspend_spec (v_0: Ptr) (v_1: Ptr) (v_2: Z) (v_3: Z) (st: RData) : (option RData) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
    rely (((((v_1.(pbase)) = ("granule_data")) /\ (((v_1.(poffset)) >= (0)))) /\ ((((v_1.(poffset)) mod (4096)) = (0)))));
    rely ((((v_0.(pbase)) = ("stack_s_psci_result")) /\ (((v_0.(poffset)) = (0)))));
    when st_0 == ((llvm_memset_p0i8_i64_spec (ptr_offset v_0 0) 0 64 false st));
    when st_1 == ((store_RData 1 (ptr_offset v_0 0) 1 st_0));
    when st_2 == ((store_RData 8 (ptr_offset v_0 32) 0 st_1));
    (Some st_2).

  Definition psci_cpu_on_spec (v_0: Ptr) (v_1: Ptr) (v_2: Z) (v_3: Z) (v_4: Z) (st: RData) : (option RData) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
    rely (((((v_1.(pbase)) = ("granule_data")) /\ (((v_1.(poffset)) >= (0)))) /\ ((((v_1.(poffset)) mod (4096)) = (0)))));
    rely ((((v_0.(pbase)) = ("stack_s_psci_result")) /\ (((v_0.(poffset)) = (0)))));
    when st_0 == ((llvm_memset_p0i8_i64_spec (ptr_offset v_0 0) 0 64 false st));
    when v_8, st_1 == ((load_RData 8 (ptr_offset v_1 920) st_0));
    if ((v_8 - (v_3)) >? (0))
    then (
      when st_3 == ((store_RData 8 (ptr_offset v_0 32) (- 9) st_1));
      (Some st_3))
    else (
      when v_12, st_2 == ((load_RData 8 (ptr_offset v_1 936) st_1));
      if ((v_12 - (v_3)) >? (0))
      then (
        when v_16, st_3 == ((vmpidr_to_rec_idx_spec v_2 st_2));
        when v_19_tmp, st_4 == ((load_RData 8 (ptr_offset v_1 944) st_3));
        when v_20, st_5 == ((rd_map_read_rec_count_spec (int_to_ptr v_19_tmp) st_4));
        if ((v_20 - (v_16)) >? (0))
        then (
          when v_25, st_6 == ((load_RData 8 (ptr_offset v_1 8) st_5));
          if ((v_25 - (v_16)) =? (0))
          then (
            when st_7 == ((store_RData 8 (ptr_offset v_0 32) (- 4) st_6));
            (Some st_7))
          else (
            when st_7 == ((store_RData 1 (ptr_offset v_1 1512) 1 st_6));
            when st_8 == ((store_RData 1 (ptr_offset v_0 0) 1 st_7));
            when st_9 == ((store_RData 8 (ptr_offset v_0 8) v_2 st_8));
            (Some st_9)))
        else (
          when st_6 == ((store_RData 8 (ptr_offset v_0 32) (- 2) st_5));
          (Some st_6)))
      else (
        when st_5 == ((store_RData 8 (ptr_offset v_0 32) (- 9) st_2));
        (Some st_5))).

  Definition psci_version_spec (v_0: Ptr) (v_1: Ptr) (st: RData) : (option RData) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
    rely (((((v_1.(pbase)) = ("granule_data")) /\ (((v_1.(poffset)) >= (0)))) /\ ((((v_1.(poffset)) mod (4096)) = (0)))));
    rely ((((v_0.(pbase)) = ("stack_s_psci_result")) /\ (((v_0.(poffset)) = (0)))));
    when st_0 == ((llvm_memset_p0i8_i64_spec (ptr_offset v_0 0) 0 64 false st));
    when st_1 == ((store_RData 8 (ptr_offset v_0 32) 65537 st_0));
    (Some st_1).

  Definition region_is_contained_spec' (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) : (option bool) :=
    if (((v_2 - (v_0)) >=? (0)) && ((((v_1 + ((- 1))) - (v_2)) >=? (0))))
    then (Some ((((v_3 + ((- 1))) - (v_0)) >=? (0)) && (((v_1 + (((- 1) * (v_3)))) >=? (0)))))
    else (Some false).

  Definition region_is_contained_spec (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (bool * RData)) :=
    when ret == ((region_is_contained_spec' v_0 v_1 v_2 v_3));
    (Some (ret, st)).
  (* Definition region_is_contained_spec (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (bool * RData)) :=
    when v_5, st_0 == ((addr_is_contained_spec v_0 v_1 v_2 st));
    if v_5
    then (
      when v_8, st_1 == ((addr_is_contained_spec v_0 v_1 (v_3 + ((- 1))) st_0));
      (Some (v_8, st_1)))
    else (Some (false, st_0)). *)

  Definition s1tte_is_valid_spec (v_0: Z) (v_1: Z) (st: RData) : (option (bool * RData)) :=
    if ((v_1 =? (3)) && (((v_0 & (3)) =? (3))))
    then (Some (true, st))
    else (
      if ((v_1 <>? (3)) && (((v_0 & (3)) =? (1))))
      then (Some (true, st))
      else (Some (false, st))).

  Definition smc_granule_ns_to_any_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    rely (
      (((((v_1 - (MEM0_PHYS)) >= (0)) /\ (((v_1 - (4294967296)) < (0)))) \/ ((((v_1 - (MEM1_PHYS)) >= (0)) /\ (((v_1 - (556198264832)) < (0)))))) /\
        (((v_1 & (4095)) = (0)))));
    when v_3, st_0 == ((find_lock_granule_spec v_1 0 st));
    rely (((((v_3.(poffset)) mod (16)) = (0)) /\ (((v_3.(poffset)) >= (0)))));
    rely ((((v_3.(pbase)) = ("granules")) \/ (((v_3.(pbase)) = ("null")))));
    if (ptr_eqb v_3 (mkPtr "null" 0))
    then (
      when v_5, st_1 == ((find_lock_granule_spec v_1 6 st_0));
      rely (((((v_5.(poffset)) mod (16)) = (0)) /\ (((v_5.(poffset)) >= (0)))));
      rely ((((v_5.(pbase)) = ("granules")) \/ (((v_5.(pbase)) = ("null")))));
      if (ptr_eqb v_5 (mkPtr "null" 0))
      then (
        when v_7, st_2 == ((pack_return_code_spec 1 1 st_1));
        (Some (v_7, st_2)))
      else (
        when st_3 == ((__granule_get_spec v_5 st_1));
        when st_4 == ((granule_unlock_spec v_5 st_3));
        (Some (0, st_4))))
    else (
      when st_1 == ((set_pas_ns_to_any_spec v_1 st_0));
      when st_2 == ((granule_set_state_spec v_3 6 st_1));
      when st_3 == ((g_mapped_addr_set_spec v_3 v_0 st_2));
      when st_5 == ((__granule_get_spec v_3 st_3));
      when st_6 == ((granule_unlock_spec v_3 st_5));
      (Some (0, st_6))).

  Definition smc_granule_any_to_ns_spec (v_0: Z) (st: RData) : (option (Z * RData)) :=
    rely (
      (((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - (4294967296)) < (0)))) \/ ((((v_0 - (MEM1_PHYS)) >= (0)) /\ (((v_0 - (556198264832)) < (0)))))) /\
        (((v_0 & (4095)) = (0)))));
    when v_2, st_0 == ((find_lock_granule_spec v_0 6 st));
    rely (((((v_2.(poffset)) mod (16)) = (0)) /\ (((v_2.(poffset)) >= (0)))));
    rely ((((v_2.(pbase)) = ("granules")) \/ (((v_2.(pbase)) = ("null")))));
    if (ptr_eqb v_2 (mkPtr "null" 0))
    then (
      when v_4, st_1 == ((pack_return_code_spec 1 1 st_0));
      (Some (v_4, st_1)))
    else (
      when st_1 == ((__granule_put_spec v_2 st_0));
      when v_7, st_2 == ((g_refcount_spec v_2 st_1));
      if (v_7 =? (0))
      then (
        when st_3 == ((set_pas_any_to_ns_spec v_0 st_2));
        when st_4 == ((granule_set_state_spec v_2 0 st_3));
        when st_6 == ((g_mapped_addr_set_spec v_2 0 st_4));
        when st_7 == ((granule_unlock_spec v_2 st_6));
        (Some (0, st_7)))
      else (
        when st_4 == ((g_mapped_addr_set_spec v_2 0 st_2));
        when st_5 == ((granule_unlock_spec v_2 st_4));
        (Some (0, st_5)))).

  Definition granule_unlock_transition_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
    rely (((((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))) /\ ((v_1 >= (0)))) /\ ((v_1 <= (6)))));
    when st_0 == ((granule_set_state_spec v_0 v_1 st));
    when st_1 == ((granule_unlock_spec v_0 st_0));
    (Some st_1).

  Definition data_create_internal_spec (v_0: Z) (v_1: Ptr) (v_2: Z) (v_3: Ptr) (v_4: Ptr) (v_5: Z) (st: RData) : (option (Z * RData)) :=
    when st_0 == ((new_frame "data_create_internal" st));
    rely (((((((st_0.(share)).(granule_data)) @ ((v_4.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
    rely (((((v_4.(pbase)) = ("granule_data")) /\ ((((v_4.(poffset)) mod (4096)) = (0)))) /\ (((v_4.(poffset)) >= (0)))));
    rely (((((v_3.(pbase)) = ("granules")) /\ ((((v_3.(poffset)) mod (16)) = (0)))) /\ (((v_3.(poffset)) >= (0)))));
    when v_8, st_1 == ((s1tte_pa_spec v_0 st_0));
    when v_9, st_2 == ((find_granule_spec v_8 st_1));
    rely ((((v_9.(pbase)) = ("granules")) \/ (((v_9.(pbase)) = ("null")))));
    if (ptr_eqb v_9 (mkPtr "null" 0))
    then (
      when v_11, st_3 == ((pack_return_code_spec 1 1 st_2));
      when st_5 == ((free_stack "data_create_internal" st_0 st_3));
      (Some (v_11, st_5)))
    else (
      when st_4 == ((rtt_walk_lock_unlock_spec (mkPtr "stack_s_rtt_walk" 0) v_1 0 64 v_2 3 st_2));
      rely ((((st_4.(share)).(granule_data)) = (((st_2.(share)).(granule_data)))));
      when v__sroa_0_0_copyload_tmp, st_5 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 0) st_4));
      when v__sroa_6_0_copyload, st_6 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 16) st_5));
      if (v__sroa_6_0_copyload =? (3))
      then (
        when v__sroa_4_0_copyload, st_8 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 8) st_6));
        when v_18, st_9 == ((granule_map_spec (int_to_ptr v__sroa_0_0_copyload_tmp) 6 st_8));
        when v_21, st_10 == ((__tte_read_spec (ptr_offset v_18 (8 * (v__sroa_4_0_copyload))) st_9));
        when v_22, st_11 == ((s2tte_is_unassigned_spec v_21 st_10));
        if v_22
        then (
          if (ptr_eqb v_3 (mkPtr "null" 0))
          then (
            when v_37, st_13 == ((s2tte_get_ripas_spec v_21 st_11));
            if (v_37 =? (0))
            then (
              when v_41, st_14 == ((s2tte_create_assigned_spec v_8 3 st_13));
              if (v_5 =? (0))
              then (data_create_internal_0_low st_0 st_14 v_18 v_2 v_41 v_5 v_9 v__sroa_0_0_copyload_tmp v__sroa_4_0_copyload)
              else (
                when v_46, st_16 == ((s1tte_create_valid_spec v_8 3 st_14));
                when st_18 == ((stage1_tlbi_all_spec st_16));
                when st_19 == ((__tte_write_spec (ptr_offset v_18 (8 * (v__sroa_4_0_copyload))) (v_46 |' (1024)) st_18));
                when st_20 == ((iasm_8_spec st_19));
                when st_21 == ((iasm_12_isb_spec st_20));
                when st_22 == ((__granule_get_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_21));
                when st_23 == ((g_mapped_addr_set_spec v_9 v_2 st_22));
                when st_24 == ((__granule_get_spec v_9 st_23));
                when st_25 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_24));
                when st_15 == ((free_stack "data_create_internal" st_0 st_25));
                (Some (0, st_15))))
            else (
              if (v_5 =? (0))
              then (data_create_internal_1_low st_0 st_13 v_0 v_18 v_2 v_5 v_9 v__sroa_0_0_copyload_tmp v__sroa_4_0_copyload)
              else (
                when v_46, st_15 == ((s1tte_create_valid_spec v_8 3 st_13));
                when st_17 == ((stage1_tlbi_all_spec st_15));
                when st_18 == ((__tte_write_spec (ptr_offset v_18 (8 * (v__sroa_4_0_copyload))) (v_46 |' (1024)) st_17));
                when st_19 == ((iasm_8_spec st_18));
                when st_20 == ((iasm_12_isb_spec st_19));
                when st_21 == ((__granule_get_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_20));
                when st_22 == ((g_mapped_addr_set_spec v_9 v_2 st_21));
                when st_23 == ((__granule_get_spec v_9 st_22));
                when st_24 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_23));
                when st_14 == ((free_stack "data_create_internal" st_0 st_24));
                (Some (0, st_14)))))
          else (
            when v_28_tmp, st_12 == ((load_RData 8 (ptr_offset v_4 944) st_11));
            when st_13 == ((granule_lock_spec (int_to_ptr v_28_tmp) 2 st_12));
            when v_29, st_14 == ((granule_map_spec v_9 1 st_13));
            when v_30, st_15 == ((granule_addr_spec v_3 st_14));
            when v_31, st_16 == ((ns_buffer_read_spec 0 v_30 4096 v_29 st_15));
            when st_17 == ((ns_buffer_unmap_spec 0 st_16));
            if v_31
            then (
              when st_18 == ((granule_unlock_spec (int_to_ptr v_28_tmp) st_17));
              when v_37, st_20 == ((s2tte_get_ripas_spec v_21 st_18));
              if (v_37 =? (0))
              then (
                when v_41, st_21 == ((s2tte_create_assigned_spec v_8 3 st_20));
                if (v_5 =? (0))
                then (data_create_internal_2_low st_0 st_21 v_18 v_2 v_41 v_5 v_9 v__sroa_0_0_copyload_tmp v__sroa_4_0_copyload)
                else (
                  when v_46, st_22 == ((s1tte_create_valid_spec v_8 3 st_21));
                  when st_23 == ((stage1_tlbi_all_spec st_22));
                  when st_24 == ((__tte_write_spec (ptr_offset v_18 (8 * (v__sroa_4_0_copyload))) (v_46 |' (1024)) st_23));
                  when st_25 == ((iasm_8_spec st_24));
                  when st_26 == ((iasm_12_isb_spec st_25));
                  when st_27 == ((__granule_get_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_26));
                  when st_28 == ((g_mapped_addr_set_spec v_9 v_2 st_27));
                  when st_29 == ((__granule_get_spec v_9 st_28));
                  when st_30 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_29));
                  when st_31 == ((free_stack "data_create_internal" st_0 st_30));
                  (Some (0, st_31))))
              else (
                if (v_5 =? (0))
                then (data_create_internal_3_low st_0 st_20 v_0 v_18 v_2 v_5 v_9 v__sroa_0_0_copyload_tmp v__sroa_4_0_copyload)
                else (
                  when v_46, st_21 == ((s1tte_create_valid_spec v_8 3 st_20));
                  when st_22 == ((stage1_tlbi_all_spec st_21));
                  when st_23 == ((__tte_write_spec (ptr_offset v_18 (8 * (v__sroa_4_0_copyload))) (v_46 |' (1024)) st_22));
                  when st_24 == ((iasm_8_spec st_23));
                  when st_25 == ((iasm_12_isb_spec st_24));
                  when st_26 == ((__granule_get_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_25));
                  when st_27 == ((g_mapped_addr_set_spec v_9 v_2 st_26));
                  when st_28 == ((__granule_get_spec v_9 st_27));
                  when st_29 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_28));
                  when st_30 == ((free_stack "data_create_internal" st_0 st_29));
                  (Some (0, st_30)))))
            else (
              when v_33, st_18 == ((memset_spec v_29 0 4096 st_17));
              when st_19 == ((granule_unlock_spec (int_to_ptr v_28_tmp) st_18));
              when v_34, st_20 == ((pack_return_code_spec 1 4 st_19));
              when st_21 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_20));
              when st_23 == ((free_stack "data_create_internal" st_0 st_21));
              (Some (v_34, st_23)))))
        else (
          when v_24, st_12 == ((pack_return_code_spec 9 0 st_11));
          when st_13 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_12));
          when st_15 == ((free_stack "data_create_internal" st_0 st_13));
          (Some (v_24, st_15))))
      else (
        when v_16, st_7 == ((pack_return_code_spec 8 v__sroa_6_0_copyload st_6));
        when st_8 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_7));
        when st_10 == ((free_stack "data_create_internal" st_0 st_8));
        (Some (v_16, st_10)))).

  Definition find_lock_two_granules_spec (v_0: Z) (v_1: Z) (v_2: Ptr) (v_3: Z) (v_4: Z) (v_5: Ptr) (st: RData) : (option (Z * RData)) :=
    when st_0 == ((new_frame "find_lock_two_granules" st));
    when st_1 == ((store_RData 4 (ptr_offset (mkPtr "stack_type_6" 0) 0) 0 st_0));
    when st_2 == ((store_RData 8 (ptr_offset (mkPtr "stack_type_6" 0) 8) v_0 st_1));
    when st_3 == ((store_RData 4 (ptr_offset (mkPtr "stack_type_6" 0) 16) v_1 st_2));
    when st_4 == ((store_RData 8 (ptr_offset (mkPtr "stack_type_6" 0) 24) (ptr_to_int (mkPtr "null" 0)) st_3));
    when st_6 == ((store_RData 4 (ptr_offset (mkPtr "stack_type_6" 0) 40) 1 st_4));
    when st_7 == ((store_RData 8 (ptr_offset (mkPtr "stack_type_6" 0) 48) v_3 st_6));
    when st_8 == ((store_RData 4 (ptr_offset (mkPtr "stack_type_6" 0) 56) v_4 st_7));
    when st_9 == ((store_RData 8 (ptr_offset (mkPtr "stack_type_6" 0) 64) (ptr_to_int (mkPtr "null" 0)) st_8));
    when v_19, st_11 == ((find_lock_granules_spec (ptr_offset (mkPtr "stack_type_6" 0) 0) 2 st_9));
    when st_12 == ((free_stack "find_lock_two_granules" st_0 st_11));
    (Some (v_19, st_12)).

  Definition rtt_create_internal_spec (v_0: Ptr) (v_1: Z) (v_2: Z) (v_3: Z) (v_4: Z) (st: RData) : (option (Z * RData)) :=
    when st == ((new_frame "rtt_create_internal" st));
    let init_st := st in
    rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
    let v_6 := (mkPtr "stack_s_rtt_walk" 0) in
    when v_7, st == ((find_lock_granule_spec v_1 1 st));
    rely (((((v_7.(poffset)) mod (16)) = (0)) /\ (((v_7.(poffset)) >= (0)))));
    rely ((((v_7.(pbase)) = ("granules")) \/ (((v_7.(pbase)) = ("null")))));
    let v__not := (ptr_eqb v_7 (mkPtr "null" 0)) in
    match (
      let __retval__ := 0 in
      let __return__ := false in
      if v__not
      then (
        when v_9, st == ((pack_return_code_spec 1 1 st));
        let v_10 := v_9 in
        let v__0 := v_10 in
        let __return__ := true in
        let __retval__ := v__0 in
        (Some (__return__, __retval__, st)))
      else (Some (__return__, __retval__, st))
    ) with
    | (Some (__return__, __retval__, st)) =>
      if __return__
      then (
        when st == ((free_stack "rtt_create_internal" init_st st));
        (Some (__retval__, st)))
      else (
        when st == ((rtt_walk_lock_unlock_spec v_6 v_0 0 64 v_2 v_3 st));
        let v__sroa_0_0__sroa_idx := (ptr_offset v_6 ((24 * (0)) + ((0 + (0))))) in
        when v__sroa_0_0_copyload_tmp, st == ((load_RData 8 v__sroa_0_0__sroa_idx st));
        let v__sroa_0_0_copyload := (int_to_ptr v__sroa_0_0_copyload_tmp) in
        let v__sroa_6_0__sroa_idx16 := (ptr_offset v_6 ((24 * (0)) + ((16 + (0))))) in
        when v__sroa_6_0_copyload, st == ((load_RData 8 v__sroa_6_0__sroa_idx16 st));
        let v_12 := (v_3 + ((- 1))) in
        let v__not42 := (v__sroa_6_0_copyload =? (v_12)) in
        match (
          if v__not42
          then (Some (__return__, __retval__, st))
          else (
            let v__not43 := (v_4 =? (0)) in
            match (
              if v__not43
              then (Some (__return__, __retval__, st))
              else (
                let v_15 := (v__sroa_6_0_copyload =? (v_3)) in
                match (
                  if v_15
                  then (
                    when v_17, st == ((pack_return_code_spec 9 1234 st));
                    let v__1 := v_17 in
                    when st == ((granule_unlock_spec v__sroa_0_0_copyload st));
                    when st == ((granule_unlock_spec v_7 st));
                    let v_39 := v__1 in
                    let v__0 := v_39 in
                    let __return__ := true in
                    let __retval__ := v__0 in
                    (Some (__return__, __retval__, st)))
                  else (Some (__return__, __retval__, st))
                ) with
                | (Some (__return__, __retval__, st)) =>
                  if __return__
                  then (Some (__return__, __retval__, st))
                  else (Some (__return__, __retval__, st))
                | None => None
                end)
            ) with
            | (Some (__return__, __retval__, st)) =>
              if __return__
              then (Some (__return__, __retval__, st))
              else (
                let v_19 := v__sroa_6_0_copyload in
                when v_20, st == ((pack_return_code_spec 8 v_19 st));
                let v__1 := v_20 in
                when st == ((granule_unlock_spec v__sroa_0_0_copyload st));
                when st == ((granule_unlock_spec v_7 st));
                let v_39 := v__1 in
                let v__0 := v_39 in
                let __return__ := true in
                let __retval__ := v__0 in
                (Some (__return__, __retval__, st)))
            | None => None
            end)
        ) with
        | (Some (__return__, __retval__, st)) =>
          if __return__
          then (
            when st == ((free_stack "rtt_create_internal" init_st st));
            (Some (__retval__, st)))
          else (
            let v__sroa_4_0__sroa_idx14 := (ptr_offset v_6 ((24 * (0)) + ((8 + (0))))) in
            when v__sroa_4_0_copyload, st == ((load_RData 8 v__sroa_4_0__sroa_idx14 st));
            when v_22, st == ((granule_map_spec v__sroa_0_0_copyload 6 st));
            let v_23 := v_22 in
            let v_24 := (ptr_offset v_23 ((8 * (v__sroa_4_0_copyload)) + (0))) in
            when v_25, st == ((__tte_read_spec v_24 st));
            when v_26, st == ((granule_map_spec v_7 1 st));
            when v_27, st == ((s2tte_is_unassigned_spec v_25 st));
            match (
              if v_27
              then (
                let v_29 := v_26 in
                when v_30, st == ((s2tte_get_ripas_spec v_25 st));
                when st == ((s2tt_init_unassigned_spec v_29 v_30 st));
                when st == ((__granule_get_spec v__sroa_0_0_copyload st));
                (Some (__return__, __retval__, st)))
              else (
                when v_32, st == ((s2tte_is_table_spec v_25 v_12 st));
                match (
                  if v_32
                  then (
                    when v_34, st == ((pack_return_code_spec 9 0 st));
                    let v__037 := v_34 in
                    let v__1 := v__037 in
                    when st == ((granule_unlock_spec v__sroa_0_0_copyload st));
                    when st == ((granule_unlock_spec v_7 st));
                    let v_39 := v__1 in
                    let v__0 := v_39 in
                    let __return__ := true in
                    let __retval__ := v__0 in
                    (Some (__return__, __retval__, st)))
                  else (Some (__return__, __retval__, st))
                ) with
                | (Some (__return__, __retval__, st)) =>
                  if __return__
                  then (Some (__return__, __retval__, st))
                  else (Some (__return__, __retval__, st))
                | None => None
                end)
            ) with
            | (Some (__return__, __retval__, st)) =>
              if __return__
              then (
                when st == ((free_stack "rtt_create_internal" init_st st));
                (Some (__retval__, st)))
              else (
                when st == ((granule_set_state_spec v_7 5 st));
                when v_36, st == ((s2tte_create_table_spec v_1 v_12 st));
                when st == ((iasm_8_spec st));
                when st == ((stage1_tlbi_all_spec st));
                when st == ((__tte_write_spec v_24 v_36 st));
                when st == ((iasm_8_spec st));
                when st == ((iasm_12_isb_spec st));
                let v__037 := 0 in
                let v__1 := v__037 in
                when st == ((granule_unlock_spec v__sroa_0_0_copyload st));
                when st == ((granule_unlock_spec v_7 st));
                let v_39 := v__1 in
                let v__0 := v_39 in
                let __return__ := true in
                let __retval__ := v__0 in
                when st == ((free_stack "rtt_create_internal" init_st st));
                (Some (__retval__, st)))
            | None => None
            end)
        | None => None
        end)
    | None => None
    end.

  Definition s2tte_is_assigned_spec (v_0: Z) (v_1: Z) (st: RData) : (option (bool * RData)) :=
    (Some (((v_0 & (63)) =? (4)), st)).

End Layer7_Spec.

#[global] Hint Unfold get_tte_spec': spec.
Opaque get_tte_spec.
#[global] Hint Unfold s1addr_level_mask_spec: spec.
#[global] Hint Unfold ranges_intersect_spec: spec.
#[global] Hint Unfold get_sysreg_write_value_spec: spec.
#[global] Hint Unfold esr_srt_spec: spec.
#[global] Hint Unfold access_mask_spec: spec.
#[global] Hint Unfold realm_ipa_to_pa_spec: spec.
#[global] Hint Unfold psci_cpu_off_spec: spec.
#[global] Hint Unfold psci_system_reset_spec: spec.
#[global] Hint Unfold psci_system_off_spec: spec.
#[global] Hint Unfold psci_affinity_info_spec: spec.
#[global] Hint Unfold psci_features_spec: spec.
#[global] Hint Unfold psci_cpu_suspend_spec: spec.
#[global] Hint Unfold psci_cpu_on_spec: spec.
#[global] Hint Unfold psci_version_spec: spec.
#[global] Hint Unfold region_is_contained_spec: spec.
#[global] Hint Unfold s1tte_is_valid_spec: spec.
#[global] Hint Unfold smc_granule_ns_to_any_spec: spec.
#[global] Hint Unfold smc_granule_any_to_ns_spec: spec.
#[global] Hint Unfold granule_unlock_transition_spec: spec.
Opaque data_create_internal_spec.
#[global] Hint Unfold find_lock_two_granules_spec: spec.
#[global] Hint Unfold rtt_create_internal_spec: spec.
#[global] Hint Unfold s2tte_is_assigned_spec: spec.
