Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Helpers_realm_rtt_starting_level_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition realm_rtt_starting_level_spec_low (v_rd: Ptr) (st: RData) : (option (Z * RData)) :=
    rely ((((v_rd.(pbase)) = ("slot_rd")) /\ (((v_rd.(poffset)) = (0)))));
    let v_s2_starting_level := (ptr_offset v_rd ((456 * (0)) + ((16 + ((4 + (0))))))) in
    when v_0, st == ((load_RData 4 v_s2_starting_level st));
    let __return__ := true in
    let __retval__ := v_0 in
    (Some (__retval__, st)).

End Helpers_realm_rtt_starting_level_LowSpec.

#[global] Hint Unfold realm_rtt_starting_level_spec_low: spec.
