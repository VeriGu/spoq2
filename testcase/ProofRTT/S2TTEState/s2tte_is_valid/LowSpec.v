Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section S2TTEState_s2tte_is_valid_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2tte_is_valid_spec_low (v_s2tte: Z) (v_level: Z) (st: RData) : (option (bool * RData)) :=
    when v_call, st == ((s2tte_check_spec v_s2tte v_level 0 st));
    let __return__ := true in
    let __retval__ := v_call in
    (Some (__retval__, st)).

End S2TTEState_s2tte_is_valid_LowSpec.

#[global] Hint Unfold s2tte_is_valid_spec_low: spec.
