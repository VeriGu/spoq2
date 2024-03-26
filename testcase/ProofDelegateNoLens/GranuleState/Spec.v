Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section GranuleState_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition granule_get_state_spec (v_g: Ptr) (st: RData) : (option (Z * RData)) :=
    rely ((((v_g.(pbase)) = ("granules")) /\ ((((v_g.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))));
    if (
      match (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
      | (Some cid) => true
      | None => false
      end)
    then (Some (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_state)), st))
    else None.

  Definition granule_set_state_spec (v_g: Ptr) (v_state: Z) (st: RData) : (option RData) :=
    rely ((((v_g.(pbase)) = ("granules")) /\ ((((v_g.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))));
    if (
      match (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
      | (Some cid) => true
      | None => false
      end)
    then (
      when cid == (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock)));
      (Some (st.[share].[granules] :<
        (((st.(share)).(granules)) #
          (((v_g.(poffset)) + (4)) / (ST_GRANULE_SIZE)) ==
          ((((st.(share)).(granules)) @ (((v_g.(poffset)) + (4)) / (ST_GRANULE_SIZE))).[e_state] :< v_state)))))
    else None.

  Definition granule_from_idx_spec (v_idx: Z) (st: RData) : (option (Ptr * RData)) :=
    rely ((((0 - (v_idx)) <= (0)) /\ ((v_idx < (1048576)))));
    (Some ((mkPtr "granules" (16 * (v_idx))), st)).

End GranuleState_Spec.

#[global] Hint Unfold granule_get_state_spec: spec.
#[global] Hint Unfold granule_set_state_spec: spec.
#[global] Hint Unfold granule_from_idx_spec: spec.
