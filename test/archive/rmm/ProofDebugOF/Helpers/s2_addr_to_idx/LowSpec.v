Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Helpers_s2_addr_to_idx_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2_addr_to_idx_spec_low (v_addr: Z) (v_level: Z) (st: RData) : (option (Z * RData)) :=
    (Some (((v_addr >> (((((((v_level * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))) & (511)), st)).

End Helpers_s2_addr_to_idx_LowSpec.

#[global] Hint Unfold s2_addr_to_idx_spec_low: spec.
