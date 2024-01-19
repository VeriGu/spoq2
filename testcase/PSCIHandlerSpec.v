Definition psci_features_spec (v_agg_result: Ptr) (v_rec: Ptr) (v_psci_func_id: Z) (st: RData) : (option RData) :=
  rely ((((v_agg_result.(pbase)) = ("handle_realm_rsi_stack")) /\ ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))))));
  when st_0 == ((llvm_memset_p0i8_i64_spec_state_oracle (mkPtr "handle_realm_rsi_stack" (v_agg_result.(poffset))) 0 72 false st));
  if (
    (((((((((((v_psci_func_id =? (2214592513)) || ((v_psci_func_id =? (3288334337)))) || ((v_psci_func_id =? (2214592514)))) || ((v_psci_func_id =? (2214592515)))) ||
      ((v_psci_func_id =? (3288334339)))) ||
      ((v_psci_func_id =? (2214592516)))) ||
      ((v_psci_func_id =? (3288334340)))) ||
      ((v_psci_func_id =? (2214592520)))) ||
      ((v_psci_func_id =? (2214592521)))) ||
      ((v_psci_func_id =? (2214592522)))) ||
      ((v_psci_func_id =? (2147483648)))))
  then (Some (st_0.[stack].[handle_realm_rsi_stack] :< (((st_0.(stack)).(handle_realm_rsi_stack)) # ((v_agg_result.(poffset)) + (32)) == 0)))
  else (Some (st_0.[stack].[handle_realm_rsi_stack] :< (((st_0.(stack)).(handle_realm_rsi_stack)) # ((v_agg_result.(poffset)) + (32)) == (- 1)))).

Definition psci_system_reset_spec (v_agg_result: Ptr) (v_rec: Ptr) (st: RData) : (option RData) :=
  rely ((((v_agg_result.(pbase)) = ("handle_realm_rsi_stack")) /\ ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))))));
  when st_0 == ((llvm_memset_p0i8_i64_spec_state_oracle (mkPtr "handle_realm_rsi_stack" (v_agg_result.(poffset))) 0 72 false st));
  rely (
    match (((((st_0.(share)).(granules)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
    | (Some cid) =>
      ((((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\
        (((((((st_0.(share)).(granules)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true)))) /\
        (((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) > (0)) /\
          ((((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >= (0)) /\
            (((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - ((GRANULES_BASE + (16777216)))) < (0)))))))) /\
        ((("granules" = ("granules")) /\
          ((((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0))))))
    | None =>
      ((((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\
        (((((((st_0.(share)).(granules)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true)))) /\
        (((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) > (0)) /\
          ((((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >= (0)) /\
            (((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - ((GRANULES_BASE + (16777216)))) < (0)))))))) /\
        ((("granules" = ("granules")) /\
          ((((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0))))))
    end);
  when sh == (((st_0.(repl)) ((st_0.(oracle)) (st_0.(log))) (st_0.(share))));
  match ((((sh.(granules)) @ ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock))) with
  | None =>
    if (
      (((((sh.(granules)) @ ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_state)) -
        (2)) =?
        (0)))
    then (
      rely (
        match (
          ((((sh.(granules)) #
            ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
            (((sh.(granules)) @ ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
              (Some CPU_ID))) @ ((sh.(slots)) @ SLOT_REC)).(e_lock))
        ) with
        | (Some cid) =>
          match (
            ((((sh.(granules)) #
              ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
              (((sh.(granules)) @ ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                (Some CPU_ID))) @ (((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >> (4))).(e_lock))
          ) with
          | (Some cid_0) =>
            (((((((((sh.(granules)) #
              ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
              (((sh.(granules)) @ ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                (Some CPU_ID))) @ ((sh.(slots)) @ SLOT_REC)).(e_refcount)) =?
              (0)) =
              (true)) /\
              ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) > (0)) /\
                (((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >= (0)) /\
                  ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - ((GRANULES_BASE + (16777216)))) < (0)))))))) /\
              (((((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)) /\
                (("granules" = ("granules")))) /\
                ((((2 <= (24)) /\ ((2 >= (0)))) /\ ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))))))))) /\
              (((("slot_rd" = ("slot_rd")) /\ ((0 = (0)))) /\ ((true = (true))))))
          | _ =>
            (((((((((sh.(granules)) #
              ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
              (((sh.(granules)) @ ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                (Some CPU_ID))) @ ((sh.(slots)) @ SLOT_REC)).(e_refcount)) =?
              (0)) =
              (true)) /\
              ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) > (0)) /\
                (((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >= (0)) /\
                  ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - ((GRANULES_BASE + (16777216)))) < (0)))))))) /\
              (((((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)) /\
                (("granules" = ("granules")))) /\
                ((((2 <= (24)) /\ ((2 >= (0)))) /\ ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))))))))) /\
              (((("slot_rd" = ("slot_rd")) /\ ((0 = (0)))) /\ ((false = (true))))))
          end
        | None =>
          match (
            ((((sh.(granules)) #
              ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
              (((sh.(granules)) @ ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                (Some CPU_ID))) @ (((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >> (4))).(e_lock))
          ) with
          | (Some cid) =>
            ((((((((sh.(granules)) @ ((sh.(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true)) /\
              ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) > (0)) /\
                (((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >= (0)) /\
                  ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - ((GRANULES_BASE + (16777216)))) < (0)))))))) /\
              (((((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)) /\
                (("granules" = ("granules")))) /\
                ((((2 <= (24)) /\ ((2 >= (0)))) /\ ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))))))))) /\
              (((("slot_rd" = ("slot_rd")) /\ ((0 = (0)))) /\ ((true = (true))))))
          | _ =>
            ((((((((sh.(granules)) @ ((sh.(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true)) /\
              ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) > (0)) /\
                (((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >= (0)) /\
                  ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - ((GRANULES_BASE + (16777216)))) < (0)))))))) /\
              (((((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)) /\
                (("granules" = ("granules")))) /\
                ((((2 <= (24)) /\ ((2 >= (0)))) /\ ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))))))))) /\
              (((("slot_rd" = ("slot_rd")) /\ ((0 = (0)))) /\ ((false = (true))))))
          end
        end);
      match (
        ((((sh.(granules)) #
          ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
          (((sh.(granules)) @ ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
            (Some CPU_ID))) @ (((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >> (4))).(e_lock))
      ) with
      | (Some cid) =>
        (Some (((st_0.[log] :<
          ((EVT
            CPU_ID 
            (REL
              ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) 
              (((sh.(granules)) @ ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                (Some CPU_ID)))) ::
            (((EVT
              CPU_ID 
              (ACQ ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)))) ::
              ((((st_0.(oracle)) (st_0.(log))) ++ ((st_0.(log))))))))).[share] :<
          (((sh.[granule_data] :<
            ((sh.(granule_data)) #
              (((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >> (4)) ==
              (((sh.(granule_data)) @ (((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >> (4))).[g_rd].[e_rd_rd_state] :<
                2))).[granules] :<
            ((sh.(granules)) #
              ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
              (((sh.(granules)) @ ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                None))).[slots] :<
            ((sh.(slots)) # SLOT_RD == (- 1)))).[stack].[handle_realm_rsi_stack] :<
          (((st_0.(stack)).(handle_realm_rsi_stack)) # (v_agg_result.(poffset)) == 1)))
      | _ => None
      end)
    else None
  | (Some cid) => None
  end.

Definition psci_system_off_spec (v_agg_result: Ptr) (v_rec: Ptr) (st: RData) : (option RData) :=
  rely ((((v_agg_result.(pbase)) = ("handle_realm_rsi_stack")) /\ ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))))));
  when st_0 == ((llvm_memset_p0i8_i64_spec_state_oracle (mkPtr "handle_realm_rsi_stack" (v_agg_result.(poffset))) 0 72 false st));
  rely (
    match (((((st_0.(share)).(granules)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
    | (Some cid) =>
      ((((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\
        (((((((st_0.(share)).(granules)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true)))) /\
        (((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) > (0)) /\
          ((((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >= (0)) /\
            (((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - ((GRANULES_BASE + (16777216)))) < (0)))))))) /\
        ((("granules" = ("granules")) /\
          ((((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0))))))
    | None =>
      ((((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\
        (((((((st_0.(share)).(granules)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true)))) /\
        (((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) > (0)) /\
          ((((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >= (0)) /\
            (((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - ((GRANULES_BASE + (16777216)))) < (0)))))))) /\
        ((("granules" = ("granules")) /\
          ((((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0))))))
    end);
  when sh == (((st_0.(repl)) ((st_0.(oracle)) (st_0.(log))) (st_0.(share))));
  match ((((sh.(granules)) @ ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock))) with
  | None =>
    if (
      (((((sh.(granules)) @ ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_state)) -
        (2)) =?
        (0)))
    then (
      rely (
        match (
          ((((sh.(granules)) #
            ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
            (((sh.(granules)) @ ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
              (Some CPU_ID))) @ ((sh.(slots)) @ SLOT_REC)).(e_lock))
        ) with
        | (Some cid) =>
          match (
            ((((sh.(granules)) #
              ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
              (((sh.(granules)) @ ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                (Some CPU_ID))) @ (((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >> (4))).(e_lock))
          ) with
          | (Some cid_0) =>
            (((((((((sh.(granules)) #
              ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
              (((sh.(granules)) @ ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                (Some CPU_ID))) @ ((sh.(slots)) @ SLOT_REC)).(e_refcount)) =?
              (0)) =
              (true)) /\
              ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) > (0)) /\
                (((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >= (0)) /\
                  ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - ((GRANULES_BASE + (16777216)))) < (0)))))))) /\
              (((((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)) /\
                (("granules" = ("granules")))) /\
                ((((2 <= (24)) /\ ((2 >= (0)))) /\ ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))))))))) /\
              (((("slot_rd" = ("slot_rd")) /\ ((0 = (0)))) /\ ((true = (true))))))
          | _ =>
            (((((((((sh.(granules)) #
              ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
              (((sh.(granules)) @ ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                (Some CPU_ID))) @ ((sh.(slots)) @ SLOT_REC)).(e_refcount)) =?
              (0)) =
              (true)) /\
              ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) > (0)) /\
                (((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >= (0)) /\
                  ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - ((GRANULES_BASE + (16777216)))) < (0)))))))) /\
              (((((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)) /\
                (("granules" = ("granules")))) /\
                ((((2 <= (24)) /\ ((2 >= (0)))) /\ ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))))))))) /\
              (((("slot_rd" = ("slot_rd")) /\ ((0 = (0)))) /\ ((false = (true))))))
          end
        | None =>
          match (
            ((((sh.(granules)) #
              ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
              (((sh.(granules)) @ ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                (Some CPU_ID))) @ (((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >> (4))).(e_lock))
          ) with
          | (Some cid) =>
            ((((((((sh.(granules)) @ ((sh.(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true)) /\
              ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) > (0)) /\
                (((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >= (0)) /\
                  ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - ((GRANULES_BASE + (16777216)))) < (0)))))))) /\
              (((((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)) /\
                (("granules" = ("granules")))) /\
                ((((2 <= (24)) /\ ((2 >= (0)))) /\ ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))))))))) /\
              (((("slot_rd" = ("slot_rd")) /\ ((0 = (0)))) /\ ((true = (true))))))
          | _ =>
            ((((((((sh.(granules)) @ ((sh.(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true)) /\
              ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) > (0)) /\
                (((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >= (0)) /\
                  ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - ((GRANULES_BASE + (16777216)))) < (0)))))))) /\
              (((((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)) /\
                (("granules" = ("granules")))) /\
                ((((2 <= (24)) /\ ((2 >= (0)))) /\ ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))))))))) /\
              (((("slot_rd" = ("slot_rd")) /\ ((0 = (0)))) /\ ((false = (true))))))
          end
        end);
      match (
        ((((sh.(granules)) #
          ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
          (((sh.(granules)) @ ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
            (Some CPU_ID))) @ (((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >> (4))).(e_lock))
      ) with
      | (Some cid) =>
        (Some (((st_0.[log] :<
          ((EVT
            CPU_ID 
            (REL
              ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) 
              (((sh.(granules)) @ ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                (Some CPU_ID)))) ::
            (((EVT
              CPU_ID 
              (ACQ ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)))) ::
              ((((st_0.(oracle)) (st_0.(log))) ++ ((st_0.(log))))))))).[share] :<
          (((sh.[granule_data] :<
            ((sh.(granule_data)) #
              (((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >> (4)) ==
              (((sh.(granule_data)) @ (((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >> (4))).[g_rd].[e_rd_rd_state] :<
                2))).[granules] :<
            ((sh.(granules)) #
              ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
              (((sh.(granules)) @ ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                None))).[slots] :<
            ((sh.(slots)) # SLOT_RD == (- 1)))).[stack].[handle_realm_rsi_stack] :<
          (((st_0.(stack)).(handle_realm_rsi_stack)) # (v_agg_result.(poffset)) == 1)))
      | _ => None
      end)
    else None
  | (Some cid) => None
  end.

Definition psci_affinity_info_spec (v_agg_result: Ptr) (v_rec: Ptr) (v_target_affinity: Z) (v_lowest_affinity_level: Z) (st: RData) : (option RData) :=
  rely ((((v_agg_result.(pbase)) = ("handle_realm_rsi_stack")) /\ ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))))));
  when st_0 == ((llvm_memset_p0i8_i64_spec_state_oracle (mkPtr "handle_realm_rsi_stack" (v_agg_result.(poffset))) 0 72 false st));
  if (v_lowest_affinity_level =? (0))
  then (
    rely (
      (((match (((((st_0.(share)).(granules)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
      | (Some cid) => ((((((st_0.(share)).(granules)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))
      | None => ((((((st_0.(share)).(granules)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))
      end) /\
        (((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) > (0)) /\
          ((((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >= (0)) /\
            (((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - ((GRANULES_BASE + (16777216)))) < (0)))))))) /\
        ((((((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)) /\
          (("granules" = ("granules")))) /\
          ((((2 <= (24)) /\ ((2 >= (0)))) /\ ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))))))))));
    match (((((st_0.(share)).(granules)) @ ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >> (4))).(e_lock))) with
    | (Some cid) =>
      if (
        (((((((v_target_affinity >> (4)) & (4080)) |' ((v_target_affinity & (15)))) |' (((v_target_affinity >> (4)) & (1044480)))) |'
          (((v_target_affinity >> (12)) & (267386880)))) -
          ((((((st_0.(share)).(granule_data)) @ ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_rec_count)))) <?
          (0)))
      then (
        if (
          (((((((v_target_affinity >> (4)) & (4080)) |' ((v_target_affinity & (15)))) |' (((v_target_affinity >> (4)) & (1044480)))) |'
            (((v_target_affinity >> (12)) & (267386880)))) -
            ((((((st_0.(share)).(granule_data)) @ ((((st_0.(share)).(slots)) # SLOT_RD == (- 1)) @ SLOT_REC)).(g_rec)).(e_rec_idx)))) =?
            (0)))
        then (
          (Some ((st_0.[share].[slots] :< (((st_0.(share)).(slots)) # SLOT_RD == (- 1))).[stack].[handle_realm_rsi_stack] :<
            (((st_0.(stack)).(handle_realm_rsi_stack)) # ((v_agg_result.(poffset)) + (32)) == 0))))
        else (
          (Some (((st_0.[share].[granule_data] :<
            (((st_0.(share)).(granule_data)) #
              ((((st_0.(share)).(slots)) # SLOT_RD == (- 1)) @ SLOT_REC) ==
              ((((st_0.(share)).(granule_data)) @ ((((st_0.(share)).(slots)) # SLOT_RD == (- 1)) @ SLOT_REC)).[g_rec].[e_psci_info].[e_pending] :< 1))).[share].[slots] :<
            (((st_0.(share)).(slots)) # SLOT_RD == (- 1))).[stack].[handle_realm_rsi_stack] :<
            ((((st_0.(stack)).(handle_realm_rsi_stack)) # (v_agg_result.(poffset)) == 1) # ((v_agg_result.(poffset)) + (8)) == v_target_affinity)))))
      else (
        (Some ((st_0.[share].[slots] :< (((st_0.(share)).(slots)) # SLOT_RD == (- 1))).[stack].[handle_realm_rsi_stack] :<
          (((st_0.(stack)).(handle_realm_rsi_stack)) # ((v_agg_result.(poffset)) + (32)) == (- 2)))))
    | _ => None
    end)
  else (Some (st_0.[stack].[handle_realm_rsi_stack] :< (((st_0.(stack)).(handle_realm_rsi_stack)) # ((v_agg_result.(poffset)) + (32)) == (- 2)))).

Definition psci_cpu_on_spec (v_agg_result: Ptr) (v_rec: Ptr) (v_target_cpu: Z) (v_entry_point_address: Z) (v_context_id: Z) (st: RData) : (option RData) :=
  rely ((((v_agg_result.(pbase)) = ("handle_realm_rsi_stack")) /\ ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))))));
  when st_0 == ((llvm_memset_p0i8_i64_spec_state_oracle (mkPtr "handle_realm_rsi_stack" (v_agg_result.(poffset))) 0 72 false st));
  rely (
    match (((((st_0.(share)).(granules)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
    | (Some cid) =>
      ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\
        (((((((st_0.(share)).(granules)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))))
    | None =>
      ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\
        (((((((st_0.(share)).(granules)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))))
    end);
  if (
    ((((1 << (((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_ipa_bits)))) >> (1)) - (v_entry_point_address)) >?
      (0)))
  then (
    rely (
      (((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) > (0)) /\
        ((((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >= (0)) /\
          (((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - ((GRANULES_BASE + (16777216)))) < (0)))))) /\
        ((((((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)) /\
          (("granules" = ("granules")))) /\
          ((((2 <= (24)) /\ ((2 >= (0)))) /\ ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))))))))));
    match (((((st_0.(share)).(granules)) @ ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >> (4))).(e_lock))) with
    | (Some cid) =>
      if (
        (((((((v_target_cpu >> (4)) & (4080)) |' ((v_target_cpu & (15)))) |' (((v_target_cpu >> (4)) & (1044480)))) |' (((v_target_cpu >> (12)) & (267386880)))) -
          ((((((st_0.(share)).(granule_data)) @ ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_rec_count)))) <?
          (0)))
      then (
        if (
          (((((((v_target_cpu >> (4)) & (4080)) |' ((v_target_cpu & (15)))) |' (((v_target_cpu >> (4)) & (1044480)))) |' (((v_target_cpu >> (12)) & (267386880)))) -
            ((((((st_0.(share)).(granule_data)) @ ((((st_0.(share)).(slots)) # SLOT_RD == (- 1)) @ SLOT_REC)).(g_rec)).(e_rec_idx)))) =?
            (0)))
        then (
          (Some ((st_0.[share].[slots] :< (((st_0.(share)).(slots)) # SLOT_RD == (- 1))).[stack].[handle_realm_rsi_stack] :<
            (((st_0.(stack)).(handle_realm_rsi_stack)) # ((v_agg_result.(poffset)) + (32)) == (- 4)))))
        else (
          (Some (((st_0.[share].[granule_data] :<
            (((st_0.(share)).(granule_data)) #
              ((((st_0.(share)).(slots)) # SLOT_RD == (- 1)) @ SLOT_REC) ==
              ((((st_0.(share)).(granule_data)) @ ((((st_0.(share)).(slots)) # SLOT_RD == (- 1)) @ SLOT_REC)).[g_rec].[e_psci_info].[e_pending] :< 1))).[share].[slots] :<
            (((st_0.(share)).(slots)) # SLOT_RD == (- 1))).[stack].[handle_realm_rsi_stack] :<
            ((((st_0.(stack)).(handle_realm_rsi_stack)) # (v_agg_result.(poffset)) == 1) # ((v_agg_result.(poffset)) + (8)) == v_target_cpu)))))
      else (
        (Some ((st_0.[share].[slots] :< (((st_0.(share)).(slots)) # SLOT_RD == (- 1))).[stack].[handle_realm_rsi_stack] :<
          (((st_0.(stack)).(handle_realm_rsi_stack)) # ((v_agg_result.(poffset)) + (32)) == (- 2)))))
    | _ => None
    end)
  else (Some (st_0.[stack].[handle_realm_rsi_stack] :< (((st_0.(stack)).(handle_realm_rsi_stack)) # ((v_agg_result.(poffset)) + (32)) == (- 9)))).

Definition psci_cpu_off_spec (v_agg_result: Ptr) (v_rec: Ptr) (st: RData) : (option RData) :=
  rely ((((v_agg_result.(pbase)) = ("handle_realm_rsi_stack")) /\ ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))))));
  when st_0 == ((llvm_memset_p0i8_i64_spec_state_oracle (mkPtr "handle_realm_rsi_stack" (v_agg_result.(poffset))) 0 72 false st));
  rely (
    match (((((st_0.(share)).(granules)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
    | (Some cid) => ((((((st_0.(share)).(granules)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))
    | None => ((((((st_0.(share)).(granules)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))
    end);
  (Some ((st_0.[share].[granule_data] :<
    (((st_0.(share)).(granule_data)) #
      (((st_0.(share)).(slots)) @ SLOT_REC) ==
      ((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).[g_rec].[e_runnable] :< 0))).[stack].[handle_realm_rsi_stack] :<
    ((((st_0.(stack)).(handle_realm_rsi_stack)) # (v_agg_result.(poffset)) == 1) # ((v_agg_result.(poffset)) + (32)) == 0))).

Definition psci_cpu_suspend_spec (v_agg_result: Ptr) (v_rec: Ptr) (v_entry_point_address: Z) (v_context_id: Z) (st: RData) : (option RData) :=
  rely ((((v_agg_result.(pbase)) = ("handle_realm_rsi_stack")) /\ ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))))));
  when st_0 == ((llvm_memset_p0i8_i64_spec_state_oracle (mkPtr "handle_realm_rsi_stack" (v_agg_result.(poffset))) 0 72 false st));
  (Some (st_0.[stack].[handle_realm_rsi_stack] :<
    ((((st_0.(stack)).(handle_realm_rsi_stack)) # (v_agg_result.(poffset)) == 1) # ((v_agg_result.(poffset)) + (32)) == 0))).

Definition psci_version_spec (v_agg_result: Ptr) (v_rec: Ptr) (st: RData) : (option RData) :=
  rely ((((v_agg_result.(pbase)) = ("handle_realm_rsi_stack")) /\ ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))))));
  when st_0 == ((llvm_memset_p0i8_i64_spec_state_oracle (mkPtr "handle_realm_rsi_stack" (v_agg_result.(poffset))) 0 72 false st));
  (Some (st_0.[stack].[handle_realm_rsi_stack] :< (((st_0.(stack)).(handle_realm_rsi_stack)) # ((v_agg_result.(poffset)) + (32)) == 65537))).

