Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section SCA___sca_read64_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition __sca_read64_spec_low (v_ptr: Ptr) (st: RData) : (option (Z * RData)) :=
    when v_0, st == ((iasm_0_spec v_ptr st));
    let __return__ := true in
    let __retval__ := v_0 in
    (Some (__retval__, st)).

End SCA___sca_read64_LowSpec.

#[global] Hint Unfold __sca_read64_spec_low: spec.
