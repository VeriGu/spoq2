Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Helpers_s2_sl_addr_to_idx_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2_sl_addr_to_idx_spec_low (v_addr: Z) (v_start_level: Z) (v_ipa_bits: Z) (st: RData) : (option (Z * RData)) :=
    (Some ((((Z.lxor ((- 1) << (v_ipa_bits)) (- 1)) & (v_addr)) >> ((((3 - (v_start_level)) * (9)) + (12)))), st)).

End Helpers_s2_sl_addr_to_idx_LowSpec.

#[global] Hint Unfold s2_sl_addr_to_idx_spec_low: spec.
