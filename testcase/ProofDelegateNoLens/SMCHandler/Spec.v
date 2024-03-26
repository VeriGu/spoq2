Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section SMCHandler_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition smc_granule_delegate_spec (v_addr: Z) (st: RData) : (option (Z * RData)) :=
    if ((v_addr & (4095)) =? (0))
    then (
      if ((v_addr / (GRANULE_SIZE)) >? (1048575))
      then (Some (1, st))
      else (
        rely ((((0 - ((v_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_addr / (GRANULE_SIZE)) < (1048576)))));
        when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
        match ((((sh.(granules)) @ (v_addr / (GRANULE_SIZE))).(e_lock))) with
        | None =>
          if ((((sh.(granules)) @ (v_addr / (GRANULE_SIZE))).(e_state)) =? (0))
          then (
            if (
              match ((((sh.(granules)) @ ((v_addr / (GRANULE_SIZE)) + (20))).(e_lock))) with
              | (Some cid) => true
              | None => false
              end)
            then (
              when cid == ((((sh.(granules)) @ ((v_addr / (GRANULE_SIZE)) + (20))).(e_lock)));
              rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
              (Some (
                0  ,
                ((st.[log] :<
                  ((EVT CPU_ID (REL (v_addr / (GRANULE_SIZE)) (((sh.(granules)) @ (v_addr / (GRANULE_SIZE))).[e_lock] :< (Some CPU_ID)))) ::
                    (((EVT CPU_ID (ACQ (v_addr / (GRANULE_SIZE)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))).[share] :<
                  ((((sh.[gpt] :< ((sh.(gpt)) # (v_addr / (GRANULE_SIZE)) == true)).[granule_data] :<
                    ((sh.(granule_data)) # (v_addr / (GRANULE_SIZE)) == (((sh.(granule_data)) @ (v_addr / (GRANULE_SIZE))).[g_norm] :< zero_granule_data_normal))).[granules] :<
                    ((((sh.(granules)) # (v_addr / (GRANULE_SIZE)) == (((sh.(granules)) @ (v_addr / (GRANULE_SIZE))).[e_lock] :< (Some CPU_ID))) #
                      ((v_addr / (GRANULE_SIZE)) + (20)) ==
                      (((sh.(granules)) @ ((v_addr / (GRANULE_SIZE)) + (20))).[e_state] :< 1)) #
                      (v_addr / (GRANULE_SIZE)) ==
                      (((sh.(granules)) @ (v_addr / (GRANULE_SIZE))).[e_lock] :< None))).[slots] :<
                    (((sh.(slots)) # SLOT_DELEGATED == (v_addr / (GRANULE_SIZE))) # SLOT_DELEGATED == (- 1))))
              )))
            else None)
          else (
            (Some (
              1  ,
              ((st.[log] :<
                ((EVT CPU_ID (REL (v_addr / (GRANULE_SIZE)) (((sh.(granules)) @ (v_addr / (GRANULE_SIZE))).[e_lock] :< (Some CPU_ID)))) ::
                  (((EVT CPU_ID (ACQ (v_addr / (GRANULE_SIZE)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))).[share] :<
                (sh.[granules] :< ((sh.(granules)) # (v_addr / (GRANULE_SIZE)) == (((sh.(granules)) @ (v_addr / (GRANULE_SIZE))).[e_lock] :< None))))
            )))
        | (Some cid) => None
        end))
    else (Some (1, st)).

  Definition smc_granule_undelegate_spec (v_addr: Z) (st: RData) : (option (Z * RData)) :=
    if ((v_addr & (4095)) =? (0))
    then (
      if ((v_addr / (GRANULE_SIZE)) >? (1048575))
      then (Some (1, st))
      else (
        rely ((((0 - ((v_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_addr / (GRANULE_SIZE)) < (1048576)))));
        when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
        match ((((sh.(granules)) @ (v_addr / (GRANULE_SIZE))).(e_lock))) with
        | None =>
          if (((((sh.(granules)) @ (v_addr / (GRANULE_SIZE))).(e_state)) - (1)) =? (0))
          then (
            if (
              match ((((sh.(granules)) @ ((v_addr / (GRANULE_SIZE)) + (20))).(e_lock))) with
              | (Some cid) => true
              | None => false
              end)
            then (
              when cid == ((((sh.(granules)) @ ((v_addr / (GRANULE_SIZE)) + (20))).(e_lock)));
              (Some (
                0  ,
                ((st.[log] :<
                  ((EVT CPU_ID (REL (v_addr / (GRANULE_SIZE)) (((sh.(granules)) @ (v_addr / (GRANULE_SIZE))).[e_lock] :< (Some CPU_ID)))) ::
                    (((EVT CPU_ID (ACQ (v_addr / (GRANULE_SIZE)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))).[share] :<
                  ((sh.[gpt] :< ((sh.(gpt)) # (v_addr / (GRANULE_SIZE)) == false)).[granules] :<
                    ((((sh.(granules)) # (v_addr / (GRANULE_SIZE)) == (((sh.(granules)) @ (v_addr / (GRANULE_SIZE))).[e_lock] :< (Some CPU_ID))) #
                      ((v_addr / (GRANULE_SIZE)) + (20)) ==
                      (((sh.(granules)) @ ((v_addr / (GRANULE_SIZE)) + (20))).[e_state] :< 0)) #
                      (v_addr / (GRANULE_SIZE)) ==
                      (((sh.(granules)) @ (v_addr / (GRANULE_SIZE))).[e_lock] :< None))))
              )))
            else None)
          else (
            (Some (
              1  ,
              ((st.[log] :<
                ((EVT CPU_ID (REL (v_addr / (GRANULE_SIZE)) (((sh.(granules)) @ (v_addr / (GRANULE_SIZE))).[e_lock] :< (Some CPU_ID)))) ::
                  (((EVT CPU_ID (ACQ (v_addr / (GRANULE_SIZE)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))).[share] :<
                (sh.[granules] :< ((sh.(granules)) # (v_addr / (GRANULE_SIZE)) == (((sh.(granules)) @ (v_addr / (GRANULE_SIZE))).[e_lock] :< None))))
            )))
        | (Some cid) => None
        end))
    else (Some (1, st)).

End SMCHandler_Spec.

#[global] Hint Unfold smc_granule_delegate_spec: spec.
#[global] Hint Unfold smc_granule_undelegate_spec: spec.
