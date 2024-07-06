Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Helpers.Spec.
Require Import ValidateAddr.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section ValidateTable_validate_rtt_structure_cmds_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition validate_rtt_structure_cmds_spec_low (v_map_addr: Z) (v_level: Z) (v_rd: Ptr) (st: RData) : (option (bool * RData)) :=
    rely (((v_rd.(poffset)) = (0)));
    rely (((v_rd.(pbase)) = ("slot_rd")));
    when v_call, st_0 == ((realm_rtt_starting_level_spec v_rd st));
    if ((v_level >? (3)) || ((((v_call + (1)) - (v_level)) >? (0))))
    then (Some (false, st_0))
    else (
      when v_call4, st_1 == ((validate_map_addr_spec v_map_addr v_level v_rd st_0));
      (Some (v_call4, st_1))).

End ValidateTable_validate_rtt_structure_cmds_LowSpec.

#[global] Hint Unfold validate_rtt_structure_cmds_spec_low: spec.
