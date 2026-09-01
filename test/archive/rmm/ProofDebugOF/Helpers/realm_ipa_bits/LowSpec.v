Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Helpers_realm_ipa_bits_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition realm_ipa_bits_spec_low (v_rd: Ptr) (st: RData) : (option (Z * RData)) :=
    rely ((((v_rd.(pbase)) = ("slot_rd")) /\ (((v_rd.(poffset)) = (0)))));
    when v_0, st_0 == ((load_RData 4 (ptr_offset v_rd 16) st));
    (Some (v_0, st_0)).

End Helpers_realm_ipa_bits_LowSpec.

#[global] Hint Unfold realm_ipa_bits_spec_low: spec.
