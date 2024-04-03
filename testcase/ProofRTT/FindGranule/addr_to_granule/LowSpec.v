Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section FindGranule_addr_to_granule_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition addr_to_granule_spec_low (v_addr: Z) (st: RData) : (option (Ptr * RData)) :=
    when v_call, st == ((plat_granule_addr_to_idx_spec v_addr st));
    when v_call1, st == ((granule_from_idx_spec v_call st));
    let __return__ := true in
    let __retval__ := v_call1 in
    (Some (__retval__, st)).

End FindGranule_addr_to_granule_LowSpec.

#[global] Hint Unfold addr_to_granule_spec_low: spec.
