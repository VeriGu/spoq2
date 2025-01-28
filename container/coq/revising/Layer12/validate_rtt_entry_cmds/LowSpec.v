Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer9.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer12_validate_rtt_entry_cmds_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition validate_rtt_entry_cmds_spec_low (v_0: Z) (v_1: Z) (v_2: Ptr) (st: RData) : (option (Z * RData)) :=
    when v_4, st_0 == ((realm_rtt_starting_level_spec v_2 st));
    if ((v_1 >? (3)) || (((v_4 - (v_1)) >? (0))))
    then (
      when v_9, st_1 == ((make_return_code_spec 1 1 st_0));
      (Some (v_9, st_1)))
    else (
      when v_11, st_1 == ((validate_map_addr_spec v_0 v_1 v_2 st_0));
      (Some (v_11, st_1))).

End Layer12_validate_rtt_entry_cmds_LowSpec.

#[global] Hint Unfold validate_rtt_entry_cmds_spec_low: spec.
