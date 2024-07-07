Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import ValidateAddr.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section ValidateTable_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition validate_rtt_structure_cmds_spec' (v_map_addr: Z) (v_level: Z) (v_rd: Ptr) (st: RData) : (option (bool * RData)) :=
    rely (((v_rd.(poffset)) = (0)));
    rely (((v_rd.(pbase)) = ("slot_rd")));
    if (
      ((v_level >? (3)) ||
        ((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level)) + (1)) - (v_level)) >? (0)))))
    then (Some (false, st))
    else (
      when ret, st' == ((validate_map_addr_spec' v_map_addr v_level v_rd st));
      (Some (ret, st))).

  Definition validate_rtt_structure_cmds_spec (v_map_addr: Z) (v_level: Z) (v_rd: Ptr) (st: RData) : (option (bool * RData)) :=
    when ret, st' == ((validate_rtt_structure_cmds_spec' v_map_addr v_level v_rd st));
    (Some (ret, st)).

  Definition validate_data_create_unknown_spec' (v_map_addr: Z) (v_rd: Ptr) (st: RData) : (option (Z * RData)) :=
    rely (((v_rd.(poffset)) = (0)));
    rely (((v_rd.(pbase)) = ("slot_rd")));
    rely ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RD)).(e_lock)) = ((Some CPU_ID))));
    if ((((1 << (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) >> (1)) - (v_map_addr)) >? (0))
    then (
      when ret, st' == ((validate_map_addr_spec' v_map_addr 3 v_rd st));
      if ret
      then (Some (0, st))
      else (Some (1, st)))
    else (Some (1, st)).

  Definition validate_data_create_unknown_spec (v_map_addr: Z) (v_rd: Ptr) (st: RData) : (option (Z * RData)) :=
    when ret, st' == ((validate_data_create_unknown_spec' v_map_addr v_rd st));
    (Some (ret, st)).

 Definition validate_rtt_entry_cmds_spec' (v_map_addr: Z) (v_level: Z) (v_rd: Ptr) (st: RData) : (option (bool * RData)) :=
    rely (((v_rd.(poffset)) = (0)));
    rely (((v_rd.(pbase)) = ("slot_rd")));
    if (
      ((v_level >? (3)) ||
        (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level)) - (v_level)) >? (0)))))
    then (Some (false, st))
    else (
      when ret, st' == ((validate_map_addr_spec' v_map_addr v_level v_rd st));
      (Some (ret, st))).

  Definition validate_rtt_entry_cmds_spec (v_map_addr: Z) (v_level: Z) (v_rd: Ptr) (st: RData) : (option (bool * RData)) :=
    when ret, st' == ((validate_rtt_entry_cmds_spec' v_map_addr v_level v_rd st));
    (Some (ret, st)).

End ValidateTable_Spec.

Opaque validate_rtt_structure_cmds_spec'.
Opaque validate_data_create_unknown_spec'.
Opaque validate_rtt_entry_cmds_spec'.
#[global] Hint Unfold validate_rtt_entry_cmds_spec: spec.
#[global] Hint Unfold validate_rtt_structure_cmds_spec: spec.
#[global] Hint Unfold validate_data_create_unknown_spec: spec.
