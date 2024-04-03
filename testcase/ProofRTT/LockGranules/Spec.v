Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section LockGranules_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition find_lock_unused_granule_spec (v_addr: Z) (v_expected_state: Z) (st: RData) : (option (Ptr * RData)) :=
    if ((v_addr & (4095)) =? (0))
    then (
      if ((v_addr / (GRANULE_SIZE)) >? (1048575))
      then (Some ((mkPtr "status" 1), st))
      else (
        rely ((((0 - ((v_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_addr / (GRANULE_SIZE)) < (1048576)))));
        when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
        match (((((st.(share)).(granules)) @ (v_addr / (GRANULE_SIZE))).(e_lock))) with
        | None =>
          if ((((((st.(share)).(granules)) @ (v_addr / (GRANULE_SIZE))).(e_state)) - (v_expected_state)) =? (0))
          then (
            if (
              if ((((((st.(share)).(granules)) @ ((v_addr / (GRANULE_SIZE)) + (24))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
              then true
              else (
                match ((((((lens 1335 st).(share)).(granules)) @ ((v_addr / (GRANULE_SIZE)) + (24))).(e_lock))) with
                | (Some cid) => true
                | None => false
                end))
            then (
              if ((((((lens 1335 st).(share)).(granules)) @ ((v_addr / (GRANULE_SIZE)) + (24))).(e_refcount)) =? (0))
              then (Some ((mkPtr "granules" (16 * ((v_addr / (GRANULE_SIZE))))), (lens 1335 st)))
              else (Some ((mkPtr "status" 5), (lens 1340 st))))
            else None)
          else (Some ((mkPtr "status" 1), (lens 1337 st)))
        | (Some cid) => None
        end))
    else (Some ((mkPtr "status" 1), st)).

  Definition find_lock_two_granules_spec (v_addr1: Z) (v_expected_state1: Z) (v_g1: Ptr) (v_addr2: Z) (v_expected_state2: Z) (v_g2: Ptr) (st: RData) : (option (bool * RData)) :=
    rely (((v_g2.(pbase)) = ("smc_rtt_create_stack")));
    rely (((v_g1.(pbase)) = ("smc_rtt_create_stack")));
    match ((find_lock_granules_loop0 (z_to_nat 2) false false false (mkPtr "find_lock_two_granules_stack" 0) 0 (lens 2446 st))) with
    | (Some (__return__, __retval__, __break__, v_granules_0, v_i_144, st_3)) =>
      rely (((v_granules_0.(pbase)) = ("find_lock_two_granules_stack")));
      if __return__
      then (Some (__retval__, (lens 2449 st_3)))
      else (
        if (v_i_144 >? (0))
        then (
          rely ((((((st_3.(stack)).(find_lock_two_granules_stack)) @ ((v_granules_0.(poffset)) + (((40 * ((v_i_144 + ((- 1))))) + (24))))) - (STACK_VIRT)) < (0)));
          rely ((((((st_3.(stack)).(find_lock_two_granules_stack)) @ ((v_granules_0.(poffset)) + (((40 * ((v_i_144 + ((- 1))))) + (24))))) - (GRANULES_BASE)) >= (0)));
          when cid == (
              ((((st_3.(share)).(granules)) @
                (((((st_3.(stack)).(find_lock_two_granules_stack)) @ ((v_granules_0.(poffset)) + (((40 * ((v_i_144 + ((- 1))))) + (24))))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
          (Some (false, (lens 2543 st_3))))
        else (Some (false, (lens 2593 st_3))))
    | None => None
    end.

End LockGranules_Spec.

#[global] Hint Unfold find_lock_unused_granule_spec: spec.
#[global] Hint Unfold find_lock_two_granules_spec: spec.
