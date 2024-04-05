Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section GranuleLock_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition find_lock_granule_spec (v_addr: Z) (v_expected_state: Z) (st: RData) : (option (Ptr * RData)) :=
    if ((v_addr & (4095)) =? (0))
    then (
      if ((v_addr / (GRANULE_SIZE)) >? (1048575))
      then (Some ((mkPtr "null" 0), st))
      else (
        rely ((((0 - ((v_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_addr / (GRANULE_SIZE)) < (1048576)))));
        when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
        match (((((st.(share)).(granules)) @ (v_addr / (GRANULE_SIZE))).(e_lock))) with
        | None =>
          if ((((((st.(share)).(granules)) @ (v_addr / (GRANULE_SIZE))).(e_state)) - (v_expected_state)) =? (0))
          then (Some ((mkPtr "granules" (16 * ((v_addr / (GRANULE_SIZE))))), (lens 1135 st)))
          else (Some ((mkPtr "null" 0), (lens 1137 st)))
        | (Some cid) => None
        end))
    else (Some ((mkPtr "null" 0), st)).

  Definition granule_lock_spec (v_g: Ptr) (v_expected_state: Z) (st: RData) : (option RData) :=
    rely (((((((st.(share)).(granules)) @ ((v_g.(poffset)) mod (ST_GRANULE_SIZE))).(e_state)) - (v_expected_state)) = (0)));
    rely ((((v_g.(pbase)) = ("granules")) /\ ((((v_g.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))));
    when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
    match (((((st.(share)).(granules)) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))).(e_lock))) with
    | None => (Some (lens 1126 st))
    | (Some cid) => None
    end.

  Definition granule_unlock_spec (v_g: Ptr) (st: RData) : (option RData) :=
    if ((v_g.(pbase)) =s ("granules"))
    then (
      when cid == (((((st.(share)).(granules)) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))).(e_lock)));
      (Some (lens 1131 st)))
    else None.

End GranuleLock_Spec.

#[global] Hint Unfold find_lock_granule_spec: spec.
#[global] Hint Unfold granule_lock_spec: spec.
#[global] Hint Unfold granule_unlock_spec: spec.
