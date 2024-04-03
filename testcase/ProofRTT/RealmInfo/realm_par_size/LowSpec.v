Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section RealmInfo_realm_par_size_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition realm_par_size_spec_low (v_rd: Ptr) (st: RData) : (option (Z * RData)) :=
    when v_call, st == ((realm_ipa_size_spec v_rd st));
    let v_div := (v_call >> (1)) in
    let __return__ := true in
    let __retval__ := v_div in
    (Some (__retval__, st)).

End RealmInfo_realm_par_size_LowSpec.

#[global] Hint Unfold realm_par_size_spec_low: spec.
