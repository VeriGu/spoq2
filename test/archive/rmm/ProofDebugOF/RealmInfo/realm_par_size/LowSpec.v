Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import S2TTEOps.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section RealmInfo_realm_par_size_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition realm_par_size_spec_low (v_rd: Ptr) (st: RData) : (option (Z * RData)) :=
    when v_call, st_0 == ((realm_ipa_size_spec v_rd st));
    (Some ((v_call >> (1)), st_0)).

End RealmInfo_realm_par_size_LowSpec.

#[global] Hint Unfold realm_par_size_spec_low: spec.
