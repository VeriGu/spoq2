Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer12_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2tt_init_assigned_loop801_rank (v_0: Ptr) (v_2: Z) (v_5: Z) (v__010: Z) (v_indvars_iv: Z) : Z :=
    512.

  Definition rtt_walk_lock_unlock_loop467_rank (v_0: Ptr) (v_4: Z) (v_5: Z) (v_7: Ptr) (v_indvars_iv: Z) : Z :=
    512.

  Definition s2tt_init_valid_ns_loop839_rank (v_0: Ptr) (v_2: Z) (v_5: Z) (v__010: Z) (v_indvars_iv: Z) : Z :=
    512.

  Definition s2tt_init_valid_loop820_rank (v_0: Ptr) (v_2: Z) (v_5: Z) (v__010: Z) (v_indvars_iv: Z) : Z :=
    512.

  Definition copy_gic_state_to_ns_loop59_rank (v_0: Ptr) (v_1: Ptr) (v_indvars_iv: Z) (v_wide_trip_count: Z) : Z :=
    v_wide_trip_count.

  Definition copy_gic_state_from_ns_loop48_rank (v_0: Ptr) (v_1: Ptr) (v_indvars_iv: Z) (v_wide_trip_count: Z) : Z :=
    v_wide_trip_count.

  Definition total_root_rtt_refcount_loop295_rank (v_0: Ptr) (v__011: Z) (v_indvars_iv: Z) (v_wide_trip_count: Z) : Z :=
    v_wide_trip_count.

  Definition find_lock_unused_granule_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Ptr * RData)) :=
    None.

  Definition ptr_is_err_spec (v_0: Ptr) (st: RData) : (option (bool * RData)) :=
    if (((int_to_ptr 18446744073709547520).(pbase)) =s ("status"))
    then (
      if ((v_0.(pbase)) <>s ("status"))
      then (Some (false, st))
      else (Some (((v_0.(poffset)) >? (((int_to_ptr 18446744073709547520).(poffset)))), st)))
    else (Some ((((ptr_to_int v_0) - (18446744073709547520)) >? (0)), st)).

  Definition ptr_status_spec (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    (Some ((0 - ((ptr_to_int v_0))), st)).

End Layer12_Spec.

#[global] Hint Unfold s2tt_init_assigned_loop801_rank: spec.
#[global] Hint Unfold rtt_walk_lock_unlock_loop467_rank: spec.
#[global] Hint Unfold s2tt_init_valid_ns_loop839_rank: spec.
#[global] Hint Unfold s2tt_init_valid_loop820_rank: spec.
#[global] Hint Unfold copy_gic_state_to_ns_loop59_rank: spec.
#[global] Hint Unfold copy_gic_state_from_ns_loop48_rank: spec.
#[global] Hint Unfold total_root_rtt_refcount_loop295_rank: spec.
#[global] Hint Unfold find_lock_unused_granule_spec: spec.
#[global] Hint Unfold ptr_is_err_spec: spec.
#[global] Hint Unfold ptr_status_spec: spec.
