Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section FindGranule_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition granule_lock_on_state_match_spec (v_g: Ptr) (v_expected_state: Z) (st: RData) : (option (bool * RData)) :=
    rely ((((v_g.(pbase)) = ("granules")) /\ ((((v_g.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))));
    when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
    match (((((st.(share)).(granules)) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))).(e_lock))) with
    | None =>
      if ((((((st.(share)).(granules)) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))).(e_state)) - (v_expected_state)) =? (0))
      then (
        (Some (
          true  ,
          ((lens 407 st).[share].[granules] :<
            ((((lens 406 st).(share)).(granules)) #
              ((v_g.(poffset)) / (ST_GRANULE_SIZE)) ==
              (((((lens 406 st).(share)).(granules)) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID))))
        )))
      else (
        (Some (
          false  ,
          (((lens 407 st).[log] :<
            ((EVT
              CPU_ID
              (REL ((v_g.(poffset)) / (ST_GRANULE_SIZE)) (((((lens 406 st).(share)).(granules)) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID)))) ::
              (((lens 407 st).(log))))).[share].[granules] :<
            ((((lens 406 st).(share)).(granules)) #
              ((v_g.(poffset)) / (ST_GRANULE_SIZE)) ==
              (((((lens 406 st).(share)).(granules)) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))).[e_lock] :< None)))
        )))
    | (Some cid) => None
    end.

  Definition find_granule_spec (v_addr: Z) (st: RData) : (option (Ptr * RData)) :=
    if ((v_addr & (4095)) =? (0))
    then (
      if ((v_addr / (GRANULE_SIZE)) >? (1048575))
      then (Some ((mkPtr "null" 0), st))
      else (
        rely ((((0 - ((v_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_addr / (GRANULE_SIZE)) < (1048576)))));
        (Some ((mkPtr "granules" (16 * ((v_addr / (GRANULE_SIZE))))), st))))
    else (Some ((mkPtr "null" 0), st)).

End FindGranule_Spec.

#[global] Hint Unfold granule_lock_on_state_match_spec: spec.
#[global] Hint Unfold find_granule_spec: spec.
