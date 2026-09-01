Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import S2TTEDesc.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section S2TTEState_s2tte_is_unassigned_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2tte_is_unassigned_spec_low (v_s2tte: Z) (st: RData) : (option (bool * RData)) :=
    when v_call, st_0 == ((s2tte_has_hipas_spec v_s2tte 0 st));
    (Some (v_call, st_0)).

End S2TTEState_s2tte_is_unassigned_LowSpec.

#[global] Hint Unfold s2tte_is_unassigned_spec_low: spec.
