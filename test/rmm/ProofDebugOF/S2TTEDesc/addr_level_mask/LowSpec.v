Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section S2TTEDesc_addr_level_mask_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition addr_level_mask_spec_low (v_addr: Z) (v_level: Z) (st: RData) : (option (Z * RData)) :=
    (Some (((v_addr & (281474976710655)) & (((- 1) << (((((((v_level * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))), st)).

End S2TTEDesc_addr_level_mask_LowSpec.

#[global] Hint Unfold addr_level_mask_spec_low: spec.
