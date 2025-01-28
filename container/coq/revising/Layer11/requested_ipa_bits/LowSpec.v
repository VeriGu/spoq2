Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer11_requested_ipa_bits_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition requested_ipa_bits_spec_low (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    when v_3, st_0 == ((load_RData 8 (ptr_offset v_0 32) st));
    (Some ((v_3 & (255)), st_0)).

End Layer11_requested_ipa_bits_LowSpec.

#[global] Hint Unfold requested_ipa_bits_spec_low: spec.
