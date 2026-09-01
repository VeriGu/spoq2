Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section GranuleInfo_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition find_lock_granules_loop197_rank (v_granules: Ptr) (v_i_241: Z) : Z :=
    (2 - (v_i_241)).

  Definition find_lock_granules_loop0_rank (v_granules: Ptr) (v_i_143: Z) : Z :=
    (2 - (v_i_143)).

  Fixpoint find_lock_granules_loop197 (_N_: nat) (__break__: bool) (v_granules: Ptr) (v_i_241: Z) (st: RData) : (option (bool * Ptr * Z * RData)) :=
    match (_N_) with
    | O => (Some (__break__, v_granules, v_i_241, st))
    | (S _N__0) =>
      match ((find_lock_granules_loop197 _N__0 __break__ v_granules v_i_241 st)) with
      | (Some (__break___0, v_granules_0, v_i_242, st_0)) =>
        if __break___0
        then (Some (true, v_granules_0, v_i_242, st_0))
        else (
          rely (((v_granules_0.(poffset)) = (0)));
          rely (((v_granules_0.(pbase)) = ("stack_gs")));
          if ((((v_granules_0.(poffset)) + (((40 * (v_i_242)) + (24)))) / (40)) =? (0))
          then (
            rely (
              ((((((st_0.(stack)).(stack_gs0)).(e_gset_g)) > (0)) /\ ((((((st_0.(stack)).(stack_gs0)).(e_gset_g)) - (GRANULES_BASE)) >= (0)))) /\
                ((((((st_0.(stack)).(stack_gs0)).(e_gset_g)) - (18446744073705226240)) < (0)))));
            rely ((((((st_0.(stack)).(stack_gs0)).(e_gset_g_ret)) > (0)) /\ ((((- 48) + ((((((st_0.(stack)).(stack_gs0)).(e_gset_g_ret)) - (STACK_VIRT)) / (GRANULE_SIZE)))) = (0)))));
            (Some (false, v_granules_0, (v_i_242 + (1)), (st_0.[stack].[stack_g0] :< (((st_0.(stack)).(stack_gs0)).(e_gset_g))))))
          else (
            rely (
              ((((((st_0.(stack)).(stack_gs1)).(e_gset_g)) > (0)) /\ ((((((st_0.(stack)).(stack_gs1)).(e_gset_g)) - (GRANULES_BASE)) >= (0)))) /\
                ((((((st_0.(stack)).(stack_gs1)).(e_gset_g)) - (18446744073705226240)) < (0)))));
            rely ((((((st_0.(stack)).(stack_gs1)).(e_gset_g_ret)) > (0)) /\ ((((- 49) + ((((((st_0.(stack)).(stack_gs1)).(e_gset_g_ret)) - (STACK_VIRT)) / (GRANULE_SIZE)))) = (0)))));
            if ((v_i_242 + (1)) <>? (2))
            then (Some (false, v_granules_0, (v_i_242 + (1)), (st_0.[stack].[stack_g1] :< (((st_0.(stack)).(stack_gs1)).(e_gset_g)))))
            else (Some (true, v_granules_0, v_i_242, (st_0.[stack].[stack_g1] :< (((st_0.(stack)).(stack_gs1)).(e_gset_g)))))))
      | None => None
      end
    end.

  Definition get_cached_llt_info_spec (st: RData) : (option (Ptr * RData)) :=
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    (Some ((mkPtr "llt_info_cache" (24 * (CPU_ID))), st)).

  Definition slot_to_va_spec (v_slot: Z) (st: RData) : (option (Z * RData)) :=
    (Some (((v_slot << (12)) + (18446744073709420544)), st)).

  Definition granule_unlock_transition_spec (v_g: Ptr) (v_new_state: Z) (st: RData) : (option RData) :=
    rely ((((v_g.(pbase)) = ("granules")) /\ ((((v_g.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))));
    when cid == (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock)));
    (Some ((st.[log] :<
      ((EVT CPU_ID (REL ((v_g.(poffset)) / (ST_GRANULE_SIZE)) ((((st.(share)).(granules)) @ (((v_g.(poffset)) + (4)) / (ST_GRANULE_SIZE))).[e_state] :< v_new_state))) ::
        ((st.(log))))).[share].[granules] :<
      (((st.(share)).(granules)) #
        (((v_g.(poffset)) + (4)) / (ST_GRANULE_SIZE)) ==
        (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (4)) / (ST_GRANULE_SIZE))).[e_lock] :< None).[e_state] :< v_new_state)))).

End GranuleInfo_Spec.

#[global] Hint Unfold find_lock_granules_loop197_rank: spec.
#[global] Hint Unfold find_lock_granules_loop0_rank: spec.
#[global] Hint Unfold find_lock_granules_loop197: spec.
#[global] Hint Unfold get_cached_llt_info_spec: spec.
#[global] Hint Unfold slot_to_va_spec: spec.
#[global] Hint Unfold granule_unlock_transition_spec: spec.
