Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Helpers_addr_is_contained_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition addr_is_contained_spec_low (v_container_base: Z) (v_container_end: Z) (v_address: Z) (st: RData) : (option (bool * RData)) :=
    let v_cmp := (v_address >=? (v_container_base)) in
    let v_sub := (v_container_end + ((- 1))) in
    let v_cmp1 := (v_sub >=? (v_address)) in
    let v_0 := (v_cmp && (v_cmp1)) in
    let __return__ := true in
    let __retval__ := v_0 in
    (Some (__retval__, st)).

End Helpers_addr_is_contained_LowSpec.

#[global] Hint Unfold addr_is_contained_spec_low: spec.
