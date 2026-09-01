Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section ValidateTable_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition validate_rtt_map_cmds_spec (v_map_addr: Z) (v_level: Z) (v_rd: Ptr) (st: RData) : (option (bool * RData)) :=
    rely (((v_rd.(poffset)) = (0)));
    rely (((v_rd.(pbase)) = ("slot_rd")));
    if (((v_level + ((- 4))) - ((- 2))) <? (0))
    then (Some (false, st))
    else (
      rely ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RD)).(e_lock)) = ((Some CPU_ID))));
      if (((1 << (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) - (v_map_addr)) >? (0))
      then (
        if (
          ((((v_map_addr & (281474976710655)) & (((- 1) << (((((((v_level * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) - (v_map_addr)) =?
            (0)))
        then (Some (true, st))
        else (Some (false, st)))
      else (Some (false, st))).

  Definition s2tte_create_valid_ns_spec (v_s2tte: Z) (v_level: Z) (st: RData) : (option (Z * RData)) :=
    if (v_level =? (3))
    then (Some ((v_s2tte |' (54043195528446979)), st))
    else (Some ((v_s2tte |' (54043195528446977)), st)).

End ValidateTable_Spec.

#[global] Hint Unfold validate_rtt_map_cmds_spec: spec.
#[global] Hint Unfold s2tte_create_valid_ns_spec: spec.
