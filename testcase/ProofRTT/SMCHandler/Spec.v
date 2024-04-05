Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section SMCHandler_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition smc_realm_activate_spec (v_rd_addr: Z) (st: RData) : (option (Z * RData)) :=
    if ((v_rd_addr & (4095)) =? (0))
    then (
      if ((v_rd_addr / (GRANULE_SIZE)) >? (1048575))
      then (Some (1, st))
      else (
        rely ((((0 - ((v_rd_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_rd_addr / (GRANULE_SIZE)) < (1048576)))));
        when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
        match (((((st.(share)).(granules)) @ (v_rd_addr / (GRANULE_SIZE))).(e_lock))) with
        | None =>
          if ((((((st.(share)).(granules)) @ (v_rd_addr / (GRANULE_SIZE))).(e_state)) - (2)) =? (0))
          then (
            rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
            if ((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_rd_state)) =? (0))
            then (
              if (
                match ((((((lens 1135 st).(share)).(granules)) @ (v_rd_addr / (GRANULE_SIZE))).(e_lock))) with
                | (Some cid) => true
                | None => false
                end)
              then (
                (Some (
                  0  ,
                  (((lens 9262 st).[share].[granule_data] :<
                    (((st.(share)).(granule_data)) #
                      (v_rd_addr / (GRANULE_SIZE)) ==
                      ((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).[g_rd] :<
                        (((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).[e_rd_rd_state] :< 1)))).[share].[slots] :<
                    ((((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))) # SLOT_RD == (- 1)))
                )))
              else None)
            else (Some (2, ((lens 9264 st).[share].[slots] :< ((((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))) # SLOT_RD == (- 1))))))
          else (Some (1, (lens 1137 st)))
        | (Some cid) => None
        end))
    else (Some (1, st)).

  Definition smc_version_spec (st: RData) : (option (Z * RData)) :=
    (Some (3670016, st)).

  Definition smc_rtt_create_6 (v_wi: Ptr) (v_call14: Ptr) (v_call15: Z) (v_call16: Ptr) (v_ulevel: Z) (v_g_tbl: Ptr) (v_rtt_addr: Z) (st_0: RData) (st_26: RData) : (option (Z * RData)) :=
    rely (((v_wi.(pbase)) = ("smc_rtt_create_stack")));
    rely (((v_call16.(pbase)) = ("slot_delegated")));
    rely (((v_call14.(pbase)) = ("slot_rtt")));
    rely (((v_g_tbl.(pbase)) = ("smc_rtt_create_stack")));
    if ((v_call15 & (64)) =? (0))
    then (
      match ((s2tt_init_unassigned_loop0 (z_to_nat 256) false 0 0 v_call16 st_26)) with
      | (Some (__return__, v_call_0, v_index_0, v_s2tt_0, st_1)) =>
        rely (
          ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
            ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
        rely ((("granules" = ("granules")) /\ ((((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
        if (
          if (
            ((((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) -
              (GRANULE_STATE_RD)) =?
              (0)))
          then true
          else (
            match (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
            | (Some cid) => true
            | None => false
            end))
        then (
          when cid == (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
          if (
            ((((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)) <?
              (0)))
          then None
          else (
            rely (
              (((((((lens 170 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (STACK_VIRT)) < (0)) /\
                (((((((lens 170 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) >= (0)))));
            rely ((("granules" = ("granules")) /\ ((((((((lens 170 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)))));
            if (
              match ((((((lens 170 st_1).(share)).(granules)) @ (((((((lens 170 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (20))).(e_lock))) with
              | (Some cid_0) => true
              | None => false
              end)
            then (
              rely (((v_call16.(poffset)) = (0)));
              rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
              rely (((v_call14.(poffset)) = (0)));
              rely (
                (((((((lens 7764 st_1).(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
                  (((((((lens 7764 st_1).(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
              rely (
                (((((((lens 7770 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (STACK_VIRT)) < (0)) /\
                  (((((((lens 7770 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) >= (0)))));
              (Some (
                0  ,
                (((lens 7942 st_1).[share].[granule_data] :<
                  (((st_1.(share)).(granule_data)) #
                    (((st_1.(share)).(slots)) @ SLOT_RTT) ==
                    ((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                      (((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                        ((v_call14.(poffset)) + ((8 * (((((lens 7764 st_1).(stack)).(smc_rtt_create_stack)) @ ((v_wi.(poffset)) + (8))))))) ==
                        (v_rtt_addr |' (3)))))).[share].[slots] :<
                  ((((st_1.(share)).(slots)) # SLOT_DELEGATED == (- 1)) # SLOT_RTT == (- 1)))
              )))
            else None))
        else None
      | None => None
      end)
    else (
      match ((s2tt_init_unassigned_loop0 (z_to_nat 256) false 64 0 v_call16 st_26)) with
      | (Some (__return__, v_call_0, v_index_0, v_s2tt_0, st_1)) =>
        rely (
          ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
            ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
        rely ((("granules" = ("granules")) /\ ((((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
        if (
          if (
            ((((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) -
              (GRANULE_STATE_RD)) =?
              (0)))
          then true
          else (
            match (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
            | (Some cid) => true
            | None => false
            end))
        then (
          when cid == (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
          if (
            ((((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)) <?
              (0)))
          then None
          else (
            rely (
              (((((((lens 170 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (STACK_VIRT)) < (0)) /\
                (((((((lens 170 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) >= (0)))));
            rely ((("granules" = ("granules")) /\ ((((((((lens 170 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)))));
            if (
              match ((((((lens 170 st_1).(share)).(granules)) @ (((((((lens 170 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (20))).(e_lock))) with
              | (Some cid_0) => true
              | None => false
              end)
            then (
              rely (((v_call16.(poffset)) = (0)));
              rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
              rely (((v_call14.(poffset)) = (0)));
              rely (
                (((((((lens 7969 st_1).(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
                  (((((((lens 7969 st_1).(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
              rely (
                (((((((lens 7975 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (STACK_VIRT)) < (0)) /\
                  (((((((lens 7975 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) >= (0)))));
              (Some (
                0  ,
                (((lens 8147 st_1).[share].[granule_data] :<
                  (((st_1.(share)).(granule_data)) #
                    (((st_1.(share)).(slots)) @ SLOT_RTT) ==
                    ((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                      (((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                        ((v_call14.(poffset)) + ((8 * (((((lens 7969 st_1).(stack)).(smc_rtt_create_stack)) @ ((v_wi.(poffset)) + (8))))))) ==
                        (v_rtt_addr |' (3)))))).[share].[slots] :<
                  ((((st_1.(share)).(slots)) # SLOT_DELEGATED == (- 1)) # SLOT_RTT == (- 1)))
              )))
            else None))
        else None
      | None => None
      end).

  Definition smc_rtt_create_5 (v_wi: Ptr) (v_call14: Ptr) (v_call15: Z) (v_call16: Ptr) (v_ulevel: Z) (v_g_tbl: Ptr) (v_rtt_addr: Z) (st_0: RData) (st_27: RData) : (option (Z * RData)) :=
    rely (((v_wi.(pbase)) = ("smc_rtt_create_stack")));
    rely (((v_call16.(pbase)) = ("slot_delegated")));
    rely (((v_call14.(pbase)) = ("slot_rtt")));
    rely (((v_g_tbl.(pbase)) = ("smc_rtt_create_stack")));
    match ((s2tt_init_destroyed_loop0 (z_to_nat 256) false 0 v_call16 st_27)) with
    | (Some (__return__, v_index_0, v_s2tt_0, st_1)) =>
      rely (
        ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
          ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
      rely ((("granules" = ("granules")) /\ ((((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
      if (
        if (
          ((((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) -
            (GRANULE_STATE_RD)) =?
            (0)))
        then true
        else (
          match (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
          | (Some cid) => true
          | None => false
          end))
      then (
        when cid == (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
        if (
          ((((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)) <?
            (0)))
        then None
        else (
          rely (
            (((((((lens 170 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (STACK_VIRT)) < (0)) /\
              (((((((lens 170 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) >= (0)))));
          rely ((("granules" = ("granules")) /\ ((((((((lens 170 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)))));
          if (
            match ((((((lens 170 st_1).(share)).(granules)) @ (((((((lens 170 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (20))).(e_lock))) with
            | (Some cid_0) => true
            | None => false
            end)
          then (
            rely (((v_call16.(poffset)) = (0)));
            rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
            rely (((v_call14.(poffset)) = (0)));
            rely (
              (((((((lens 7380 st_1).(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
                (((((((lens 7380 st_1).(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
            rely (
              (((((((lens 7386 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (STACK_VIRT)) < (0)) /\
                (((((((lens 7386 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) >= (0)))));
            (Some (
              0  ,
              (((lens 7558 st_1).[share].[granule_data] :<
                (((st_1.(share)).(granule_data)) #
                  (((st_1.(share)).(slots)) @ SLOT_RTT) ==
                  ((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                    (((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                      (8 * (((((lens 7380 st_1).(stack)).(smc_rtt_create_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                      (v_rtt_addr |' (3)))))).[share].[slots] :<
                ((((st_1.(share)).(slots)) # SLOT_DELEGATED == (- 1)) # SLOT_RTT == (- 1)))
            )))
          else None))
      else None
    | None => None
    end.

  Definition smc_rtt_create_4 (v_wi: Ptr) (v_call14: Ptr) (v_call15: Z) (v_call16: Ptr) (v_ulevel: Z) (v_g_tbl: Ptr) (v_rtt_addr: Z) (st_0: RData) (st_28: RData) : (option (Z * RData)) :=
    rely (((v_wi.(pbase)) = ("smc_rtt_create_stack")));
    rely (((v_call16.(pbase)) = ("slot_delegated")));
    rely (((v_call14.(pbase)) = ("slot_rtt")));
    rely (((v_g_tbl.(pbase)) = ("smc_rtt_create_stack")));
    match (
      (s2tt_init_assigned_empty_loop700
        (z_to_nat 512)
        false
        (1 << ((((3 - (v_ulevel)) * (9)) + (12))))
        0
        v_ulevel
        ((v_call15 & (281474976710655)) & (((- 1) << ((((((((v_ulevel + ((- 1))) * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295))))))
        v_call16
        st_28)
    ) with
    | (Some (__return__, v_call_0, v_indvars_iv_0, v_level_0, v_pa_addr_6, v_s2tt_0, st_1)) =>
      rely (
        ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (STACK_VIRT)) < (0)) /\
          ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) >= (0)))));
      rely ((("granules" = ("granules")) /\ ((((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
      if (
        if (
          ((((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) -
            (GRANULE_STATE_RD)) =?
            (0)))
        then true
        else (
          match (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_lock))) with
          | (Some cid) => true
          | None => false
          end))
      then (
        when cid == (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
        if (
          ((((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) +
            (512)) <?
            (0)))
        then None
        else (
          rely (
            (((((((lens 284 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (STACK_VIRT)) < (0)) /\
              (((((((lens 284 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) >= (0)))));
          rely ((("granules" = ("granules")) /\ ((((((((lens 284 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)))));
          if (
            match ((((((lens 284 st_1).(share)).(granules)) @ (((((((lens 284 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (20))).(e_lock))) with
            | (Some cid_0) => true
            | None => false
            end)
          then (
            rely (((v_call16.(poffset)) = (0)));
            rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
            rely (((v_call14.(poffset)) = (0)));
            rely (
              (((((((lens 7585 st_1).(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
                (((((((lens 7585 st_1).(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
            rely (
              (((((((lens 7591 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (STACK_VIRT)) < (0)) /\
                (((((((lens 7591 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) >= (0)))));
            (Some (
              0  ,
              (((lens 7763 st_1).[share].[granule_data] :<
                (((st_1.(share)).(granule_data)) #
                  (((st_1.(share)).(slots)) @ SLOT_RTT) ==
                  ((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                    (((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                      (8 * (((((lens 7585 st_1).(stack)).(smc_rtt_create_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                      (v_rtt_addr |' (3)))))).[share].[slots] :<
                ((((st_1.(share)).(slots)) # SLOT_DELEGATED == (- 1)) # SLOT_RTT == (- 1)))
            )))
          else None))
      else None
    | None => None
    end.

  Definition smc_rtt_create_3 (v_wi: Ptr) (v_map_addr: Z) (v_call14: Ptr) (v_call15: Z) (v_call16: Ptr) (v_s2_ctx: Ptr) (v_g_tbl: Ptr) (v_rtt_addr: Z) (v_ulevel: Z) (st_0: RData) (st_29: RData) : (option (Z * RData)) :=
    rely (((v_wi.(pbase)) = ("smc_rtt_create_stack")));
    rely (((v_call16.(pbase)) = ("slot_delegated")));
    rely (((v_call14.(pbase)) = ("slot_rtt")));
    rely (((v_g_tbl.(pbase)) = ("smc_rtt_create_stack")));
    rely (((v_s2_ctx.(pbase)) = ("smc_rtt_create_stack")));
    when cid == (((((st_29.(share)).(granules)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).(e_lock)));
    match (
      (s2tt_init_valid_loop719
        (z_to_nat 512)
        false
        (1 << ((((3 - (v_ulevel)) * (9)) + (12))))
        0
        v_ulevel
        ((v_call15 & (281474976710655)) & (((- 1) << ((((((((v_ulevel + ((- 1))) * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295))))))
        v_call16
        (st_29.[share].[granule_data] :<
          (((st_29.(share)).(granule_data)) #
            (((st_29.(share)).(slots)) @ SLOT_RTT) ==
            ((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
              (((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                ((v_call14.(poffset)) + ((8 * ((((st_29.(stack)).(smc_rtt_create_stack)) @ ((v_wi.(poffset)) + (8))))))) ==
                0)))))
    ) with
    | (Some (__return__, v_call_0, v_indvars_iv_0, v_level_0, v_pa_addr_6, v_s2tt_0, st_1)) =>
      rely (
        ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (STACK_VIRT)) < (0)) /\
          ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) >= (0)))));
      rely ((("granules" = ("granules")) /\ ((((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
      if (
        if (
          ((((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) -
            (GRANULE_STATE_RD)) =?
            (0)))
        then true
        else (
          match (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
          | (Some cid_0) => true
          | None => false
          end))
      then (
        when cid_0 == (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
        if (
          ((((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) +
            (512)) <?
            (0)))
        then None
        else (
          rely (
            (((((((lens 284 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (STACK_VIRT)) < (0)) /\
              (((((((lens 284 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) >= (0)))));
          rely ((("granules" = ("granules")) /\ ((((((((lens 284 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)))));
          if (
            match ((((((lens 284 st_1).(share)).(granules)) @ (((((((lens 284 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (20))).(e_lock))) with
            | (Some cid_1) => true
            | None => false
            end)
          then (
            rely (((v_call16.(poffset)) = (0)));
            rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
            rely (((v_call14.(poffset)) = (0)));
            rely (
              (((((((lens 7189 st_1).(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
                (((((((lens 7189 st_1).(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
            if (((((lens 7189 st_1).(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) >? (0))
            then (
              if ((((((lens 7189 st_1).(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (MAX_ERR)) >=? (0))
              then None
              else (
                if ((((((lens 7189 st_1).(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (SLOT_VIRT)) >= (0))
                then None
                else (
                  if ((((((lens 7189 st_1).(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) >= (0))
                  then None
                  else (
                    if ((((((lens 7189 st_1).(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))
                    then (
                      rely (
                        (((((((lens 7201 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (STACK_VIRT)) < (0)) /\
                          (((((((lens 7201 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) >= (0)))));
                      if (((((lens 7201 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) >? (0))
                      then (
                        if ((((((lens 7201 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (MAX_ERR)) >=? (0))
                        then None
                        else (
                          if ((((((lens 7201 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (SLOT_VIRT)) >= (0))
                          then None
                          else (
                            if ((((((lens 7201 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (STACK_VIRT)) >= (0))
                            then None
                            else (
                              if ((((((lens 7201 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) >= (0))
                              then (
                                (Some (
                                  0  ,
                                  (((lens 7379 st_1).[share].[granule_data] :<
                                    (((st_1.(share)).(granule_data)) #
                                      (((st_1.(share)).(slots)) @ SLOT_RTT) ==
                                      ((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                        (((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                          (8 * (((((lens 7189 st_1).(stack)).(smc_rtt_create_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                                          (v_rtt_addr |' (3)))))).[share].[slots] :<
                                    ((((st_1.(share)).(slots)) # SLOT_DELEGATED == (- 1)) # SLOT_RTT == (- 1)))
                                )))
                              else None))))
                      else None)
                    else None))))
            else None)
          else None))
      else None
    | None => None
    end.

  Definition smc_rtt_create_2 (v_map_addr: Z) (v_wi: Ptr) (v_call14: Ptr) (v_call15: Z) (v_call16: Ptr) (v_ulevel: Z) (v_g_tbl: Ptr) (v_s2_ctx: Ptr) (v_rtt_addr: Z) (st_0: RData) (st_30: RData) : (option (Z * RData)) :=
    rely (((v_wi.(pbase)) = ("smc_rtt_create_stack")));
    rely (((v_call16.(pbase)) = ("slot_delegated")));
    rely (((v_call14.(pbase)) = ("slot_rtt")));
    rely (((v_g_tbl.(pbase)) = ("smc_rtt_create_stack")));
    rely (((v_s2_ctx.(pbase)) = ("smc_rtt_create_stack")));
    when cid == (((((st_30.(share)).(granules)) @ (((st_30.(share)).(slots)) @ SLOT_RTT)).(e_lock)));
    match (
      (s2tt_init_valid_ns_loop738
        (z_to_nat 512)
        false
        (1 << ((((3 - (v_ulevel)) * (9)) + (12))))
        0
        v_ulevel
        ((v_call15 & (281474976710655)) & (((- 1) << ((((((((v_ulevel + ((- 1))) * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295))))))
        v_call16
        (st_30.[share].[granule_data] :<
          (((st_30.(share)).(granule_data)) #
            (((st_30.(share)).(slots)) @ SLOT_RTT) ==
            ((((st_30.(share)).(granule_data)) @ (((st_30.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
              (((((st_30.(share)).(granule_data)) @ (((st_30.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                ((v_call14.(poffset)) + ((8 * ((((st_30.(stack)).(smc_rtt_create_stack)) @ ((v_wi.(poffset)) + (8))))))) ==
                0)))))
    ) with
    | (Some (__return__, v_call_0, v_indvars_iv_0, v_level_0, v_pa_addr_6, v_s2tt_0, st_1)) =>
      rely (
        ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (STACK_VIRT)) < (0)) /\
          ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) >= (0)))));
      rely ((("granules" = ("granules")) /\ ((((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
      if (
        if (
          ((((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) -
            (GRANULE_STATE_RD)) =?
            (0)))
        then true
        else (
          match (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
          | (Some cid_0) => true
          | None => false
          end))
      then (
        when cid_0 == (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
        if (
          ((((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) +
            (512)) <?
            (0)))
        then None
        else (
          rely (
            (((((((lens 284 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (STACK_VIRT)) < (0)) /\
              (((((((lens 284 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) >= (0)))));
          rely ((("granules" = ("granules")) /\ ((((((((lens 284 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)))));
          if (
            match ((((((lens 284 st_1).(share)).(granules)) @ (((((((lens 284 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (20))).(e_lock))) with
            | (Some cid_1) => true
            | None => false
            end)
          then (
            rely (((v_call16.(poffset)) = (0)));
            rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
            rely (((v_call14.(poffset)) = (0)));
            rely (
              (((((((lens 6998 st_1).(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
                (((((((lens 6998 st_1).(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
            if (((((lens 6998 st_1).(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) >? (0))
            then (
              if ((((((lens 6998 st_1).(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (MAX_ERR)) >=? (0))
              then None
              else (
                if ((((((lens 6998 st_1).(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (SLOT_VIRT)) >= (0))
                then None
                else (
                  rely (
                    (((((((lens 7010 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (STACK_VIRT)) < (0)) /\
                      (((((((lens 7010 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) >= (0)))));
                  if (((((lens 7010 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) >? (0))
                  then (
                    if ((((((lens 7010 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (MAX_ERR)) >=? (0))
                    then None
                    else (
                      if ((((((lens 7010 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (SLOT_VIRT)) >= (0))
                      then None
                      else (
                        (Some (
                          0  ,
                          (((lens 7188 st_1).[share].[granule_data] :<
                            (((st_1.(share)).(granule_data)) #
                              (((st_1.(share)).(slots)) @ SLOT_RTT) ==
                              ((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                (((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                  ((v_call14.(poffset)) + ((8 * (((((lens 6998 st_1).(stack)).(smc_rtt_create_stack)) @ ((v_wi.(poffset)) + (8))))))) ==
                                  (v_rtt_addr |' (3)))))).[share].[slots] :<
                            ((((st_1.(share)).(slots)) # SLOT_DELEGATED == (- 1)) # SLOT_RTT == (- 1)))
                        )))))
                  else None)))
            else None)
          else None))
      else None
    | None => None
    end.

  Definition smc_rtt_create_1 (v_ulevel: Z) (v_call14: Ptr) (v_call16: Ptr) (v_wi: Ptr) (v_g_tbl: Ptr) (st_0: RData) (st_31: RData) : (option (Z * RData)) :=
    rely (((v_g_tbl.(pbase)) = ("smc_rtt_create_stack")));
    rely (((v_wi.(pbase)) = ("smc_rtt_create_stack")));
    rely (((v_call16.(pbase)) = ("slot_delegated")));
    rely (((v_call14.(pbase)) = ("slot_rtt")));
    rely (((v_call16.(poffset)) = (0)));
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    rely (((v_call14.(poffset)) = (0)));
    rely (
      ((((((st_31.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
        ((((((st_31.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
    when cid == (((((st_31.(share)).(granules)) @ (((((st_31.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
    rely (
      (((((((lens 6945 (st_31.[share].[slots] :< ((((st_31.(share)).(slots)) # SLOT_DELEGATED == (- 1)) # SLOT_RTT == (- 1)))).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) -
        (STACK_VIRT)) <
        (0)) /\
        (((((((lens 6945 (st_31.[share].[slots] :< ((((st_31.(share)).(slots)) # SLOT_DELEGATED == (- 1)) # SLOT_RTT == (- 1)))).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) -
          (GRANULES_BASE)) >=
          (0)))));
    (Some (
      ((((((v_ulevel + ((- 1))) << (32)) + (4)) >> (24)) & (4294967040)) |' (((((v_ulevel + ((- 1))) << (32)) + (4)) & (4294967295))))  ,
      (lens 6997 (st_31.[share].[slots] :< ((((st_31.(share)).(slots)) # SLOT_DELEGATED == (- 1)) # SLOT_RTT == (- 1))))
    )).

  Definition smc_rtt_create_0 (v_g_tbl: Ptr) (v_rtt_addr: Z) (v_ulevel: Z) (v_wi: Ptr) (v_call14: Ptr) (v_call16: Ptr) (st_0: RData) (st_31: RData) : (option (Z * RData)) :=
    rely (((v_g_tbl.(pbase)) = ("smc_rtt_create_stack")));
    rely (((v_wi.(pbase)) = ("smc_rtt_create_stack")));
    rely (((v_call16.(pbase)) = ("slot_delegated")));
    rely (((v_call14.(pbase)) = ("slot_rtt")));
    rely (
      ((((((st_31.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (STACK_VIRT)) < (0)) /\
        ((((((st_31.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) >= (0)))));
    rely ((("granules" = ("granules")) /\ (((((((st_31.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)))));
    if (
      match (((((st_31.(share)).(granules)) @ ((((((st_31.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (20))).(e_lock))) with
      | (Some cid) => true
      | None => false
      end)
    then (
      when cid == (((((st_31.(share)).(granules)) @ ((((((st_31.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (20))).(e_lock)));
      rely (((v_call16.(poffset)) = (0)));
      rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
      rely (((v_call14.(poffset)) = (0)));
      rely (
        (((((((lens 633 st_31).(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
          (((((((lens 633 st_31).(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
      rely (
        (((((((lens 6771 st_31).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (STACK_VIRT)) < (0)) /\
          (((((((lens 6771 st_31).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) >= (0)))));
      (Some (
        0  ,
        (((lens 6943 st_31).[share].[granule_data] :<
          (((st_31.(share)).(granule_data)) #
            (((st_31.(share)).(slots)) @ SLOT_RTT) ==
            ((((st_31.(share)).(granule_data)) @ (((st_31.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
              (((((st_31.(share)).(granule_data)) @ (((st_31.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                ((v_call14.(poffset)) + ((8 * (((((lens 633 st_31).(stack)).(smc_rtt_create_stack)) @ ((v_wi.(poffset)) + (8))))))) ==
                (v_rtt_addr |' (3)))))).[share].[slots] :<
          ((((st_31.(share)).(slots)) # SLOT_DELEGATED == (- 1)) # SLOT_RTT == (- 1)))
      )))
    else None.

  Definition smc_rtt_create_spec (v_rtt_addr: Z) (v_rd_addr: Z) (v_map_addr: Z) (v_ulevel: Z) (st: RData) : (option (Z * RData)) :=
    match ((find_lock_granules_loop0 (z_to_nat 2) false false false (mkPtr "find_lock_two_granules_stack" 0) 0 (lens 8328 st))) with
    | (Some (__return__, __retval__, __break__, v_granules_0, v_i_144, st_3)) =>
      rely (((v_granules_0.(pbase)) = ("find_lock_two_granules_stack")));
      if __return__
      then (
        if __retval__
        then (
          rely (
            (((((((lens 2449 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8164 st).(func_sp)).(smc_rtt_create_sp))) - (STACK_VIRT)) < (0)) /\
              (((((((lens 2449 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8164 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >= (0)))));
          rely ((((((((lens 2449 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8164 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)));
          rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
          when cid == ((((((lens 2449 st_3).(share)).(granules)) @ ((((((lens 2449 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8164 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(e_lock)));
          if (
            ((v_ulevel >? (3)) ||
              ((((((((((st_3.(share)).(granule_data)) @ ((((((lens 2449 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8164 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level)) +
                (1)) -
                (v_ulevel)) >?
                (0)))))
          then (
            rely (
              (((((((lens 8333 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) - (STACK_VIRT)) < (0)) /\
                (((((((lens 8333 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >= (0)))));
            (Some (
              1  ,
              ((lens 8456 st_3).[share].[slots] :<
                ((((st_3.(share)).(slots)) #
                  SLOT_RD ==
                  ((((((lens 2449 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8164 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))) #
                  SLOT_RD ==
                  (- 1)))
            )))
          else (
            rely (((Some cid) = ((Some CPU_ID))));
            if (
              (((1 <<
                (((((((st_3.(share)).(granule_data)) @ ((((((lens 2449 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8164 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) -
                (v_map_addr)) >?
                (0)))
            then (
              if (
                ((((v_map_addr & (281474976710655)) & (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) -
                  (v_map_addr)) =?
                  (0)))
              then (
                rely (
                  (((((((((st_3.(share)).(granule_data)) @ ((((((lens 2449 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8164 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
                    (STACK_VIRT)) <
                    (0)) /\
                    (((((((((st_3.(share)).(granule_data)) @ ((((((lens 2449 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8164 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
                      (GRANULES_BASE)) >=
                      (0)))));
                rely (
                  (("granules" = ("granules")) /\
                    ((((((((((st_3.(share)).(granule_data)) @ ((((((lens 2449 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8164 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
                      (GRANULES_BASE)) mod
                      (ST_GRANULE_SIZE)) =
                      (0)))));
                when sh == (
                    (((lens 2449 st_3).(repl))
                      (((lens 2449 st_3).(oracle)) ((lens 2449 st_3).(log)))
                      (((lens 2449 st_3).(share)).[slots] :<
                        ((((st_3.(share)).(slots)) #
                          SLOT_RD ==
                          ((((((lens 2449 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8164 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))) #
                          SLOT_RD ==
                          (- 1)))));
                rely (
                  (((((((lens 8492 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8164 st).(func_sp)).(smc_rtt_create_sp))) - (STACK_VIRT)) < (0)) /\
                    (((((((lens 8492 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8164 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >= (0)))));
                when st_18 == (
                    (rtt_walk_lock_unlock_spec
                      (mkPtr
                        "granules"
                        (((((((st_3.(share)).(granule_data)) @ ((((((lens 2449 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8164 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
                          (GRANULES_BASE)))
                      ((((((st_3.(share)).(granule_data)) @ ((((((lens 2449 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8164 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level))
                      ((((((st_3.(share)).(granule_data)) @ ((((((lens 2449 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8164 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits))
                      v_map_addr
                      (v_ulevel + ((- 1)))
                      (mkPtr "smc_rtt_create_stack" (((lens 8244 st).(func_sp)).(smc_rtt_create_sp)))
                      ((lens 8503 st_3).[share].[slots] :<
                        ((((st_3.(share)).(slots)) #
                          SLOT_RD ==
                          ((((((lens 2449 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8164 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))) #
                          SLOT_RD ==
                          (- 1)))));
                if (((((st_18.(stack)).(smc_rtt_create_stack)) @ ((((lens 8244 st).(func_sp)).(smc_rtt_create_sp)) + (16))) - ((v_ulevel + ((- 1))))) =? (0))
                then (
                  rely (
                    ((((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (STACK_VIRT)) < (0)) /\
                      ((((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >= (0)))));
                  rely (((((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)));
                  when cid_0 == (((((st_18.(share)).(granules)) @ (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(e_lock)));
                  rely (
                    ((((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) - (STACK_VIRT)) < (0)) /\
                      ((((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >= (0)))));
                  rely (((((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)));
                  if (
                    (((((((st_18.(share)).(granule_data)) @ (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_18.(stack)).(smc_rtt_create_stack)) @ ((((lens 8244 st).(func_sp)).(smc_rtt_create_sp)) + (8)))))) &
                      (3)) =?
                      (0)))
                  then (
                    if (
                      (((((((st_18.(share)).(granule_data)) @ (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_18.(stack)).(smc_rtt_create_stack)) @ ((((lens 8244 st).(func_sp)).(smc_rtt_create_sp)) + (8)))))) &
                        (60)) =?
                        (0)))
                    then (
                      (smc_rtt_create_6
                        (mkPtr "smc_rtt_create_stack" (((lens 8244 st).(func_sp)).(smc_rtt_create_sp)))
                        (mkPtr "slot_rtt" 0)
                        (((((st_18.(share)).(granule_data)) @ (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_18.(stack)).(smc_rtt_create_stack)) @ ((((lens 8244 st).(func_sp)).(smc_rtt_create_sp)) + (8))))))
                        (mkPtr "slot_delegated" 0)
                        v_ulevel
                        (mkPtr "smc_rtt_create_stack" (((lens 8204 st).(func_sp)).(smc_rtt_create_sp)))
                        v_rtt_addr
                        (lens 8164 st)
                        (st_18.[share].[slots] :<
                          ((((st_18.(share)).(slots)) #
                            SLOT_RTT ==
                            (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))) #
                            SLOT_DELEGATED ==
                            (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))))))
                    else (
                      if (
                        ((((((((st_18.(share)).(granule_data)) @ (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_18.(stack)).(smc_rtt_create_stack)) @ ((((lens 8244 st).(func_sp)).(smc_rtt_create_sp)) + (8)))))) &
                          (60)) -
                          (8)) =?
                          (0)))
                      then (
                        (smc_rtt_create_5
                          (mkPtr "smc_rtt_create_stack" (((lens 8244 st).(func_sp)).(smc_rtt_create_sp)))
                          (mkPtr "slot_rtt" 0)
                          (((((st_18.(share)).(granule_data)) @ (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_18.(stack)).(smc_rtt_create_stack)) @ ((((lens 8244 st).(func_sp)).(smc_rtt_create_sp)) + (8))))))
                          (mkPtr "slot_delegated" 0)
                          v_ulevel
                          (mkPtr "smc_rtt_create_stack" (((lens 8204 st).(func_sp)).(smc_rtt_create_sp)))
                          v_rtt_addr
                          (lens 8164 st)
                          (st_18.[share].[slots] :<
                            ((((st_18.(share)).(slots)) #
                              SLOT_RTT ==
                              (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))) #
                              SLOT_DELEGATED ==
                              (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))))))
                      else (
                        if (
                          ((((((((st_18.(share)).(granule_data)) @ (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_18.(stack)).(smc_rtt_create_stack)) @ ((((lens 8244 st).(func_sp)).(smc_rtt_create_sp)) + (8)))))) &
                            (60)) -
                            (4)) =?
                            (0)))
                        then (
                          (smc_rtt_create_4
                            (mkPtr "smc_rtt_create_stack" (((lens 8244 st).(func_sp)).(smc_rtt_create_sp)))
                            (mkPtr "slot_rtt" 0)
                            (((((st_18.(share)).(granule_data)) @ (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_18.(stack)).(smc_rtt_create_stack)) @ ((((lens 8244 st).(func_sp)).(smc_rtt_create_sp)) + (8))))))
                            (mkPtr "slot_delegated" 0)
                            v_ulevel
                            (mkPtr "smc_rtt_create_stack" (((lens 8204 st).(func_sp)).(smc_rtt_create_sp)))
                            v_rtt_addr
                            (lens 8164 st)
                            (st_18.[share].[slots] :<
                              ((((st_18.(share)).(slots)) #
                                SLOT_RTT ==
                                (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))) #
                                SLOT_DELEGATED ==
                                (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))))))
                        else (
                          (smc_rtt_create_0
                            (mkPtr "smc_rtt_create_stack" (((lens 8204 st).(func_sp)).(smc_rtt_create_sp)))
                            v_rtt_addr
                            v_ulevel
                            (mkPtr "smc_rtt_create_stack" (((lens 8244 st).(func_sp)).(smc_rtt_create_sp)))
                            (mkPtr "slot_rtt" 0)
                            (mkPtr "slot_delegated" 0)
                            (lens 8164 st)
                            (st_18.[share].[slots] :<
                              ((((st_18.(share)).(slots)) #
                                SLOT_RTT ==
                                (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))) #
                                SLOT_DELEGATED ==
                                (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4)))))))))
                  else (
                    if (
                      (((((((st_18.(share)).(granule_data)) @ (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_18.(stack)).(smc_rtt_create_stack)) @ ((((lens 8244 st).(func_sp)).(smc_rtt_create_sp)) + (8)))))) &
                        (36028797018963968)) =?
                        (0)))
                    then (
                      if (
                        (((v_ulevel + ((- 1))) =? (2)) &&
                          ((((((((st_18.(share)).(granule_data)) @ (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_18.(stack)).(smc_rtt_create_stack)) @ ((((lens 8244 st).(func_sp)).(smc_rtt_create_sp)) + (8)))))) &
                            (3)) =?
                            (1)))))
                      then (
                        (smc_rtt_create_3
                          (mkPtr "smc_rtt_create_stack" (((lens 8244 st).(func_sp)).(smc_rtt_create_sp)))
                          v_map_addr
                          (mkPtr "slot_rtt" 0)
                          (((((st_18.(share)).(granule_data)) @ (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_18.(stack)).(smc_rtt_create_stack)) @ ((((lens 8244 st).(func_sp)).(smc_rtt_create_sp)) + (8))))))
                          (mkPtr "slot_delegated" 0)
                          (mkPtr "smc_rtt_create_stack" (((lens 8284 st).(func_sp)).(smc_rtt_create_sp)))
                          (mkPtr "smc_rtt_create_stack" (((lens 8204 st).(func_sp)).(smc_rtt_create_sp)))
                          v_rtt_addr
                          v_ulevel
                          (lens 8164 st)
                          (st_18.[share].[slots] :<
                            ((((st_18.(share)).(slots)) #
                              SLOT_RTT ==
                              (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))) #
                              SLOT_DELEGATED ==
                              (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))))))
                      else (
                        if (
                          (((v_ulevel + ((- 1))) <? (3)) &&
                            ((((((((st_18.(share)).(granule_data)) @ (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_18.(stack)).(smc_rtt_create_stack)) @ ((((lens 8244 st).(func_sp)).(smc_rtt_create_sp)) + (8)))))) &
                              (3)) =?
                              (3)))))
                        then (
                          (smc_rtt_create_1
                            v_ulevel
                            (mkPtr "slot_rtt" 0)
                            (mkPtr "slot_delegated" 0)
                            (mkPtr "smc_rtt_create_stack" (((lens 8244 st).(func_sp)).(smc_rtt_create_sp)))
                            (mkPtr "smc_rtt_create_stack" (((lens 8204 st).(func_sp)).(smc_rtt_create_sp)))
                            (lens 8164 st)
                            (st_18.[share].[slots] :<
                              ((((st_18.(share)).(slots)) #
                                SLOT_RTT ==
                                (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))) #
                                SLOT_DELEGATED ==
                                (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))))))
                        else (
                          (smc_rtt_create_0
                            (mkPtr "smc_rtt_create_stack" (((lens 8204 st).(func_sp)).(smc_rtt_create_sp)))
                            v_rtt_addr
                            v_ulevel
                            (mkPtr "smc_rtt_create_stack" (((lens 8244 st).(func_sp)).(smc_rtt_create_sp)))
                            (mkPtr "slot_rtt" 0)
                            (mkPtr "slot_delegated" 0)
                            (lens 8164 st)
                            (st_18.[share].[slots] :<
                              ((((st_18.(share)).(slots)) #
                                SLOT_RTT ==
                                (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))) #
                                SLOT_DELEGATED ==
                                (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))))))))
                    else (
                      if (
                        ((((((((st_18.(share)).(granule_data)) @ (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_18.(stack)).(smc_rtt_create_stack)) @ ((((lens 8244 st).(func_sp)).(smc_rtt_create_sp)) + (8)))))) &
                          (36028797018963968)) -
                          (36028797018963968)) =?
                          (0)))
                      then (
                        if (
                          (((v_ulevel + ((- 1))) =? (2)) &&
                            ((((((((st_18.(share)).(granule_data)) @ (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_18.(stack)).(smc_rtt_create_stack)) @ ((((lens 8244 st).(func_sp)).(smc_rtt_create_sp)) + (8)))))) &
                              (3)) =?
                              (1)))))
                        then (
                          (smc_rtt_create_2
                            v_map_addr
                            (mkPtr "smc_rtt_create_stack" (((lens 8244 st).(func_sp)).(smc_rtt_create_sp)))
                            (mkPtr "slot_rtt" 0)
                            (((((st_18.(share)).(granule_data)) @ (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_18.(stack)).(smc_rtt_create_stack)) @ ((((lens 8244 st).(func_sp)).(smc_rtt_create_sp)) + (8))))))
                            (mkPtr "slot_delegated" 0)
                            v_ulevel
                            (mkPtr "smc_rtt_create_stack" (((lens 8204 st).(func_sp)).(smc_rtt_create_sp)))
                            (mkPtr "smc_rtt_create_stack" (((lens 8284 st).(func_sp)).(smc_rtt_create_sp)))
                            v_rtt_addr
                            (lens 8164 st)
                            (st_18.[share].[slots] :<
                              ((((st_18.(share)).(slots)) #
                                SLOT_RTT ==
                                (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))) #
                                SLOT_DELEGATED ==
                                (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))))))
                        else (
                          if (
                            (((v_ulevel + ((- 1))) <? (3)) &&
                              ((((((((st_18.(share)).(granule_data)) @ (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_18.(stack)).(smc_rtt_create_stack)) @ ((((lens 8244 st).(func_sp)).(smc_rtt_create_sp)) + (8)))))) &
                                (3)) =?
                                (3)))))
                          then (
                            (smc_rtt_create_1
                              v_ulevel
                              (mkPtr "slot_rtt" 0)
                              (mkPtr "slot_delegated" 0)
                              (mkPtr "smc_rtt_create_stack" (((lens 8244 st).(func_sp)).(smc_rtt_create_sp)))
                              (mkPtr "smc_rtt_create_stack" (((lens 8204 st).(func_sp)).(smc_rtt_create_sp)))
                              (lens 8164 st)
                              (st_18.[share].[slots] :<
                                ((((st_18.(share)).(slots)) #
                                  SLOT_RTT ==
                                  (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))) #
                                  SLOT_DELEGATED ==
                                  (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))))))
                          else (
                            (smc_rtt_create_0
                              (mkPtr "smc_rtt_create_stack" (((lens 8204 st).(func_sp)).(smc_rtt_create_sp)))
                              v_rtt_addr
                              v_ulevel
                              (mkPtr "smc_rtt_create_stack" (((lens 8244 st).(func_sp)).(smc_rtt_create_sp)))
                              (mkPtr "slot_rtt" 0)
                              (mkPtr "slot_delegated" 0)
                              (lens 8164 st)
                              (st_18.[share].[slots] :<
                                ((((st_18.(share)).(slots)) #
                                  SLOT_RTT ==
                                  (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))) #
                                  SLOT_DELEGATED ==
                                  (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))))))))
                      else (
                        if (
                          (((v_ulevel + ((- 1))) <? (3)) &&
                            ((((((((st_18.(share)).(granule_data)) @ (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_18.(stack)).(smc_rtt_create_stack)) @ ((((lens 8244 st).(func_sp)).(smc_rtt_create_sp)) + (8)))))) &
                              (3)) =?
                              (3)))))
                        then (
                          (smc_rtt_create_1
                            v_ulevel
                            (mkPtr "slot_rtt" 0)
                            (mkPtr "slot_delegated" 0)
                            (mkPtr "smc_rtt_create_stack" (((lens 8244 st).(func_sp)).(smc_rtt_create_sp)))
                            (mkPtr "smc_rtt_create_stack" (((lens 8204 st).(func_sp)).(smc_rtt_create_sp)))
                            (lens 8164 st)
                            (st_18.[share].[slots] :<
                              ((((st_18.(share)).(slots)) #
                                SLOT_RTT ==
                                (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))) #
                                SLOT_DELEGATED ==
                                (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))))))
                        else (
                          (smc_rtt_create_0
                            (mkPtr "smc_rtt_create_stack" (((lens 8204 st).(func_sp)).(smc_rtt_create_sp)))
                            v_rtt_addr
                            v_ulevel
                            (mkPtr "smc_rtt_create_stack" (((lens 8244 st).(func_sp)).(smc_rtt_create_sp)))
                            (mkPtr "slot_rtt" 0)
                            (mkPtr "slot_delegated" 0)
                            (lens 8164 st)
                            (st_18.[share].[slots] :<
                              ((((st_18.(share)).(slots)) #
                                SLOT_RTT ==
                                (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))) #
                                SLOT_DELEGATED ==
                                (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))))))))))
                else (
                  rely (
                    ((((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (STACK_VIRT)) < (0)) /\
                      ((((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >= (0)))));
                  when cid_0 == (((((st_18.(share)).(granules)) @ (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                  rely (
                    (((((((lens 8505 st_18).(stack)).(smc_rtt_create_stack)) @ (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) - (STACK_VIRT)) < (0)) /\
                      (((((((lens 8505 st_18).(stack)).(smc_rtt_create_stack)) @ (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >= (0)))));
                  (Some (
                    ((((((((st_18.(stack)).(smc_rtt_create_stack)) @ ((((lens 8244 st).(func_sp)).(smc_rtt_create_sp)) + (16))) << (32)) + (4)) >> (24)) & (4294967040)) |'
                      (((((((st_18.(stack)).(smc_rtt_create_stack)) @ ((((lens 8244 st).(func_sp)).(smc_rtt_create_sp)) + (16))) << (32)) + (4)) & (4294967295))))  ,
                    (lens 8557 st_18)
                  ))))
              else (
                rely (
                  (((((((lens 8715 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) - (STACK_VIRT)) < (0)) /\
                    (((((((lens 8715 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >= (0)))));
                (Some (
                  1  ,
                  ((lens 8838 st_3).[share].[slots] :<
                    ((((st_3.(share)).(slots)) #
                      SLOT_RD ==
                      ((((((lens 2449 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8164 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))) #
                      SLOT_RD ==
                      (- 1)))
                ))))
            else (
              rely (
                (((((((lens 8869 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) - (STACK_VIRT)) < (0)) /\
                  (((((((lens 8869 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >= (0)))));
              (Some (
                1  ,
                ((lens 8992 st_3).[share].[slots] :<
                  ((((st_3.(share)).(slots)) #
                    SLOT_RD ==
                    ((((((lens 2449 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8164 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))) #
                    SLOT_RD ==
                    (- 1)))
              )))))
        else (Some (1, (lens 9067 st_3))))
      else (
        if (v_i_144 >? (0))
        then (
          rely ((((((st_3.(stack)).(find_lock_two_granules_stack)) @ ((v_granules_0.(poffset)) + (((40 * ((v_i_144 + ((- 1))))) + (24))))) - (STACK_VIRT)) < (0)));
          rely ((((((st_3.(stack)).(find_lock_two_granules_stack)) @ ((v_granules_0.(poffset)) + (((40 * ((v_i_144 + ((- 1))))) + (24))))) - (GRANULES_BASE)) >= (0)));
          when cid == (
              ((((st_3.(share)).(granules)) @
                (((((st_3.(stack)).(find_lock_two_granules_stack)) @ ((v_granules_0.(poffset)) + (((40 * ((v_i_144 + ((- 1))))) + (24))))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
          (Some (1, (lens 9163 st_3))))
        else (Some (1, (lens 9259 st_3))))
    | None => None
    end.

End SMCHandler_Spec.

#[global] Hint Unfold smc_realm_activate_spec: spec.
#[global] Hint Unfold smc_version_spec: spec.
Opaque smc_rtt_create_6.
Opaque smc_rtt_create_5.
Opaque smc_rtt_create_4.
Opaque smc_rtt_create_3.
Opaque smc_rtt_create_2.
Opaque smc_rtt_create_1.
Opaque smc_rtt_create_0.
#[global] Hint Unfold smc_rtt_create_spec: spec.
