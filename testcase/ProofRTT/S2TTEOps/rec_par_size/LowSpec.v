Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section S2TTEOps_rec_par_size_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition rec_par_size_spec_low (v_rec: Ptr) (st: RData) : (option (Z * RData)) :=
    when v_call, st == ((rec_ipa_size_spec v_rec st));
    let v_div := (v_call >> (1)) in
    let __return__ := true in
    let __retval__ := v_div in
    (Some (__retval__, st)).

End S2TTEOps_rec_par_size_LowSpec.

#[global] Hint Unfold rec_par_size_spec_low: spec.
