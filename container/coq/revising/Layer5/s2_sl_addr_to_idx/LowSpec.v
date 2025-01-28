Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer5_s2_sl_addr_to_idx_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2_sl_addr_to_idx_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (st: RData) : (option (Z * RData)) :=
    (Some ((((Z.lxor ((- 1) << ((v_2 & (4294967295)))) (- 1)) & (v_0)) >> ((39 + (((- 9) * (v_1)))))), st)).

End Layer5_s2_sl_addr_to_idx_LowSpec.

#[global] Hint Unfold s2_sl_addr_to_idx_spec_low: spec.
