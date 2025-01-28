Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer5.Spec.
Require Import Layer9.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer11_validate_rtt_map_cmds_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition validate_rtt_map_cmds_spec_low (v_0: Z) (v_1: Z) (v_2: Ptr) (st: RData) : (option (Z * RData)) :=
    if (((- 2) + (v_1)) <? (0))
    then (
      when v_7, st_0 == ((make_return_code_spec 1 1 st));
      (Some (v_7, st_0)))
    else (
      when v_9, st_0 == ((validate_map_addr_spec v_0 v_1 v_2 st));
      (Some (v_9, st_0))).

End Layer11_validate_rtt_map_cmds_LowSpec.

#[global] Hint Unfold validate_rtt_map_cmds_spec_low: spec.
