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

  Definition get_cached_llt_info_spec (st: RData) : (option (Ptr * RData)) :=
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    (Some ((mkPtr "llt_info_cache" (24 * (CPU_ID))), st)).

  Definition slot_to_va_spec (v_slot: Z) (st: RData) : (option (Z * RData)) :=
    (Some (((v_slot << (12)) + (18446744073709420544)), st)).

End GranuleInfo_Spec.

#[global] Hint Unfold find_lock_granules_loop197_rank: spec.
#[global] Hint Unfold find_lock_granules_loop0_rank: spec.
#[global] Hint Unfold get_cached_llt_info_spec: spec.
#[global] Hint Unfold slot_to_va_spec: spec.
