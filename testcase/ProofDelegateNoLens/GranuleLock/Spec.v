Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section GranuleLock_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition granule_unlock_spec (v_g: Ptr) (st: RData) : (option RData) :=
    if ((v_g.(pbase)) =s ("granules"))
    then (
      when cid == (((((st.(share)).(granules)) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))).(e_lock)));
      (Some ((st.[log] :< ((EVT CPU_ID (REL ((v_g.(poffset)) / (ST_GRANULE_SIZE)) (((st.(share)).(granules)) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))))) :: ((st.(log))))).[share].[granules] :<
        (((st.(share)).(granules)) # ((v_g.(poffset)) / (ST_GRANULE_SIZE)) == ((((st.(share)).(granules)) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))).[e_lock] :< None)))))
    else None.

  Definition find_lock_granule_spec (v_addr: Z) (v_expected_state: Z) (st: RData) : (option (Ptr * RData)) :=
    if ((v_addr & (4095)) =? (0))
    then (
      if ((v_addr / (GRANULE_SIZE)) >? (1048575))
      then (Some ((mkPtr "null" 0), st))
      else (
        rely ((((0 - ((v_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_addr / (GRANULE_SIZE)) < (1048576)))));
        when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
        match ((((sh.(granules)) @ (v_addr / (GRANULE_SIZE))).(e_lock))) with
        | None =>
          if (((((sh.(granules)) @ (v_addr / (GRANULE_SIZE))).(e_state)) - (v_expected_state)) =? (0))
          then (
            (Some (
              (mkPtr "granules" (16 * ((v_addr / (GRANULE_SIZE)))))  ,
              ((st.[log] :< ((EVT CPU_ID (ACQ (v_addr / (GRANULE_SIZE)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))).[share] :<
                (sh.[granules] :< ((sh.(granules)) # (v_addr / (GRANULE_SIZE)) == (((sh.(granules)) @ (v_addr / (GRANULE_SIZE))).[e_lock] :< (Some CPU_ID)))))
            )))
          else (
            (Some (
              (mkPtr "null" 0)  ,
              ((st.[log] :<
                ((EVT CPU_ID (REL (v_addr / (GRANULE_SIZE)) (((sh.(granules)) @ (v_addr / (GRANULE_SIZE))).[e_lock] :< (Some CPU_ID)))) ::
                  (((EVT CPU_ID (ACQ (v_addr / (GRANULE_SIZE)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))).[share] :<
                (sh.[granules] :< ((sh.(granules)) # (v_addr / (GRANULE_SIZE)) == (((sh.(granules)) @ (v_addr / (GRANULE_SIZE))).[e_lock] :< None))))
            )))
        | (Some cid) => None
        end))
    else (Some ((mkPtr "null" 0), st)).

End GranuleLock_Spec.

#[global] Hint Unfold granule_unlock_spec: spec.
#[global] Hint Unfold find_lock_granule_spec: spec.
