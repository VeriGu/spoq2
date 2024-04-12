Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section XLat_Helper_xlat_write_tte_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition xlat_write_tte_spec_low (v_entry1: Ptr) (v_desc: Z) (st: RData) : (option RData) :=
    when st == ((__sca_write64_spec v_entry1 v_desc st));
    let __return__ := true in
    (Some st).

End XLat_Helper_xlat_write_tte_LowSpec.

#[global] Hint Unfold xlat_write_tte_spec_low: spec.
