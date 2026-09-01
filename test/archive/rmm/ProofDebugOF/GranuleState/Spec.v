Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section GranuleState_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition atomic_granule_put_spec (v_g: Ptr) (st: RData) : (option RData) :=
    rely ((((v_g.(pbase)) = ("granules")) /\ ((((v_g.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))));
    when cid == (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
    if ((((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))) <? (0))
    then None
    else (
      if (
        (((((v_g.(poffset)) + (8)) mod (ST_GRANULE_SIZE)) =? (8)) &&
          (((((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_REC)) =? (0)))))
      then (
        (Some ((st.[log] :<
          ((EVT
            CPU_ID
            (REC_REF (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))))) ::
            ((st.(log))))).[share].[granules] :<
          (((st.(share)).(granules)) #
            (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) ==
            ((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
              (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))))))))
      else (
        (Some (st.[share].[granules] :<
          (((st.(share)).(granules)) #
            (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE)) ==
            ((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).[e_refcount] :<
              (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))))))))).

  Definition granule_get_state_spec (v_g: Ptr) (st: RData) : (option (Z * RData)) :=
    rely ((((v_g.(pbase)) = ("granules")) /\ ((((v_g.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))));
    (Some (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_state)), st)).

  Definition granule_refcount_read_acquire_spec (v_g: Ptr) (st: RData) : (option (Z * RData)) :=
    rely ((((v_g.(pbase)) = ("granules")) /\ ((((v_g.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))));
    (Some (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)), st)).

  Definition granule_set_state_spec (v_g: Ptr) (v_state: Z) (st: RData) : (option RData) :=
    rely ((((v_g.(pbase)) = ("granules")) /\ ((((v_g.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))));
    when cid == (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock)));
    (Some (st.[share].[granules] :<
      (((st.(share)).(granules)) #
        (((v_g.(poffset)) + (4)) / (ST_GRANULE_SIZE)) ==
        ((((st.(share)).(granules)) @ (((v_g.(poffset)) + (4)) / (ST_GRANULE_SIZE))).[e_state] :< v_state)))).

  Definition granule_from_idx_spec (v_idx: Z) (st: RData) : (option (Ptr * RData)) :=
    rely ((((0 - (v_idx)) <= (0)) /\ ((v_idx < (1048576)))));
    (Some ((mkPtr "granules" (16 * (v_idx))), st)).

End GranuleState_Spec.

#[global] Hint Unfold atomic_granule_put_spec: spec.
#[global] Hint Unfold granule_get_state_spec: spec.
#[global] Hint Unfold granule_refcount_read_acquire_spec: spec.
#[global] Hint Unfold granule_set_state_spec: spec.
#[global] Hint Unfold granule_from_idx_spec: spec.
