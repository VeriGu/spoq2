Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import S2TTEDesc.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section S2TTEState_addr_is_level_aligned_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition addr_is_level_aligned_spec_low (v_addr: Z) (v_level: Z) (st: RData) : (option (bool * RData)) :=
    when v_call, st_0 == ((addr_level_mask_spec v_addr v_level st));
    (Some (((v_call - (v_addr)) =? (0)), st_0)).

End S2TTEState_addr_is_level_aligned_LowSpec.

#[global] Hint Unfold addr_is_level_aligned_spec_low: spec.
