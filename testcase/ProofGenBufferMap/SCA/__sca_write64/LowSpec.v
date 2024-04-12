Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section SCA___sca_write64_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition __sca_write64_spec_low (v_ptr: Ptr) (v_val: Z) (st: RData) : (option RData) :=
    when st == ((iasm_2_spec v_ptr v_val st));
    let __return__ := true in
    (Some st).

End SCA___sca_write64_LowSpec.

#[global] Hint Unfold __sca_write64_spec_low: spec.
