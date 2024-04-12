Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section XLat_Helper_xlat_read_tte_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition xlat_read_tte_spec_low (v_entry1: Ptr) (st: RData) : (option (Z * RData)) :=
    when v_call, st == ((__sca_read64_spec v_entry1 st));
    let __return__ := true in
    let __retval__ := v_call in
    (Some (__retval__, st)).

End XLat_Helper_xlat_read_tte_LowSpec.

#[global] Hint Unfold xlat_read_tte_spec_low: spec.
