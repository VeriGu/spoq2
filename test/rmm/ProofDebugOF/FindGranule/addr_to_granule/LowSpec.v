Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import GranuleState.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section FindGranule_addr_to_granule_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition addr_to_granule_spec_low (v_addr: Z) (st: RData) : (option (Ptr * RData)) :=
    when v_call, st_0 == ((plat_granule_addr_to_idx_spec v_addr st));
    when v_call1, st_1 == ((granule_from_idx_spec v_call st_0));
    (Some (v_call1, st_1)).

End FindGranule_addr_to_granule_LowSpec.

#[global] Hint Unfold addr_to_granule_spec_low: spec.
