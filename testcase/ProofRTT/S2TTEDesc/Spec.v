Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section S2TTEDesc_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2tte_check_spec' (v_s2tte: Z) (v_level: Z) (v_ns: Z) : (option bool) :=
    if (((v_s2tte & (36028797018963968)) - (v_ns)) =? (0))
    then (
      if ((v_level =? (3)) && (((v_s2tte & (3)) =? (3))))
      then (Some true)
      else (
        if ((v_level =? (2)) && (((v_s2tte & (3)) =? (1))))
        then (Some true)
        else (Some false)))
    else (Some false).

  Definition s2tte_has_hipas_spec' (v_s2tte: Z) (v_hipas: Z) : (option bool) :=
    if ((v_s2tte & (3)) =? (0))
    then (
      if (((v_s2tte & (60)) - (v_hipas)) =? (0))
      then (Some true)
      else (Some false))
    else (Some false).

  Definition addr_level_mask_spec (v_addr: Z) (v_level: Z) (st: RData) : (option (Z * RData)) :=
    (Some (((v_addr & (281474976710655)) & (((- 1) << (((39 + ((38654705655 * (v_level)))) & (4294967295)))))), st)).

  Definition s2tte_check_spec (v_s2tte: Z) (v_level: Z) (v_ns: Z) (st: RData) : (option (bool * RData)) :=
    when ret == ((s2tte_check_spec' v_s2tte v_level v_ns));
    (Some (ret, st)).

  Definition s2tte_has_hipas_spec (v_s2tte: Z) (v_hipas: Z) (st: RData) : (option (bool * RData)) :=
    when ret == ((s2tte_has_hipas_spec' v_s2tte v_hipas));
    (Some (ret, st)).

  Definition __table_get_entry_spec (v_g_tbl: Ptr) (v_idx: Z) (st: RData) : (option (Z * RData)) :=
    rely ((((v_g_tbl.(poffset)) mod (ST_GRANULE_SIZE)) = (0)));
    rely (((v_g_tbl.(pbase)) = ("granules")));
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    when cid == (((((st.(share)).(granules)) @ ((v_g_tbl.(poffset)) >> (4))).(e_lock)));
    (Some (
      (((((st.(share)).(granule_data)) @ ((v_g_tbl.(poffset)) >> (4))).(g_norm)) @ (8 * (v_idx)))  ,
      (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RTT == ((v_g_tbl.(poffset)) >> (4))))
    )).

End S2TTEDesc_Spec.

Opaque s2tte_check_spec'.
Opaque s2tte_has_hipas_spec'.
#[global] Hint Unfold addr_level_mask_spec: spec.
#[global] Hint Unfold s2tte_check_spec: spec.
#[global] Hint Unfold s2tte_has_hipas_spec: spec.
#[global] Hint Unfold __table_get_entry_spec: spec.
