Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import S2TTEDesc.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section S2TTEState_host_ns_s2tte_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition host_ns_s2tte_spec_low (v_s2tte: Z) (v_level: Z) (st: RData) : (option (Z * RData)) :=
    when v_call, st == ((addr_level_mask_spec (- 1) v_level st));
    let v_or2 := (v_call |' (988)) in
    let v_and := (v_or2 & (v_s2tte)) in
    let __return__ := true in
    let __retval__ := v_and in
    (Some (__retval__, st)).

End S2TTEState_host_ns_s2tte_LowSpec.

#[global] Hint Unfold host_ns_s2tte_spec_low: spec.
