Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section S2TTEDesc_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition addr_level_mask_spec (v_addr: Z) (v_level: Z) (st: RData) : (option (Z * RData)) :=
    (Some (((v_addr & (281474976710655)) & (((- 1) << (((((((v_level * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))), st)).

  Definition s2tte_check_spec (v_s2tte: Z) (v_level: Z) (v_ns: Z) (st: RData) : (option (bool * RData)) :=
    match (
      if (((v_s2tte & (36028797018963968)) - (v_ns)) =? (0))
      then (
        match (
          if ((v_level =? (3)) && (((v_s2tte & (3)) =? (3))))
          then (Some (false, false, st))
          else (
            match (
              if ((v_level =? (2)) && (((v_s2tte & (3)) =? (1))))
              then (Some (false, false, st))
              else (Some (true, false, st))
            ) with
            | (Some (return___1, retval___1, st_0)) =>
              if return___1
              then (Some (true, retval___1, st_0))
              else (Some (false, retval___1, st_0))
            | None => None
            end)
        ) with
        | (Some (__return___0, __retval___0, st_0)) =>
          if __return___0
          then (Some (true, __retval___0, st_0))
          else (Some (true, true, st_0))
        | None => None
        end)
      else (Some (true, false, st))
    ) with
    | (Some (__return__, __retval__, st_0)) =>
      if __return__
      then (Some (__retval__, st_0))
      else (Some (__retval__, st_0))
    | None => None
    end.

  Definition s2tte_has_hipas_spec (v_s2tte: Z) (v_hipas: Z) (st: RData) : (option (bool * RData)) :=
    match (
      if ((v_s2tte & (3)) =? (0))
      then (
        match (
          if (((v_s2tte & (60)) - (v_hipas)) =? (0))
          then (Some (true, true, st))
          else (Some (false, false, st))
        ) with
        | (Some (__return___0, __retval___0, st_0)) =>
          if __return___0
          then (Some (true, __retval___0, st_0))
          else (Some (false, __retval___0, st_0))
        | None => None
        end)
      else (Some (false, false, st))
    ) with
    | (Some (__return__, __retval__, st_0)) =>
      if __return__
      then (Some (__retval__, st_0))
      else (Some (false, st_0))
    | None => None
    end.

  Definition __table_get_entry_spec (v_g_tbl: Ptr) (v_idx: Z) (st: RData) : (option (Z * RData)) :=
    rely ((((v_g_tbl.(poffset)) mod (ST_GRANULE_SIZE)) = (0)));
    rely (((v_g_tbl.(pbase)) = ("granules")));
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    when cid == (((((st.(share)).(granules)) @ ((((st.(share)).(slots)) # SLOT_RTT == (((((GRANULES_BASE + ((v_g_tbl.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT)).(e_lock)));
    (Some (
      (((((st.(share)).(granule_data)) @ ((((st.(share)).(slots)) # SLOT_RTT == (((((GRANULES_BASE + ((v_g_tbl.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT)).(g_norm)) @ (((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE)) + ((8 * (v_idx)))))  ,
      (st.[share].[slots] :<
        (((st.(share)).(slots)) # SLOT_RTT == (((((GRANULES_BASE + ((v_g_tbl.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))))
    )).

End S2TTEDesc_Spec.

#[global] Hint Unfold addr_level_mask_spec: spec.
#[global] Hint Unfold s2tte_check_spec: spec.
#[global] Hint Unfold s2tte_has_hipas_spec: spec.
#[global] Hint Unfold __table_get_entry_spec: spec.
