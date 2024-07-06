Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section ValidateAddr_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition validate_map_addr_spec' (v_map_addr: Z) (v_level: Z) (v_rd: Ptr) (st: RData) : (option (bool * RData)) :=
    rely ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RD)).(e_lock)) = ((Some CPU_ID))));
    rely (((v_rd.(poffset)) = (0)));
    rely (((v_rd.(pbase)) = ("slot_rd")));
    if (((1 << (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) - (v_map_addr)) >? (0))
    then (
      if ((((v_map_addr & (281474976710655)) & (((- 1) << (((39 + ((38654705655 * (v_level)))) & (4294967295)))))) - (v_map_addr)) =? (0))
      then (Some (true, st))
      else (Some (false, st)))
    else (Some (false, st)).

  Definition validate_map_addr_spec (v_map_addr: Z) (v_level: Z) (v_rd: Ptr) (st: RData) : (option (bool * RData)) :=
    when ret, st' == ((validate_map_addr_spec' v_map_addr v_level v_rd st));
    (Some (ret, st)).

  Definition addr_in_par_spec (v_rd: Ptr) (v_addr: Z) (st: RData) : (option (bool * RData)) :=
    rely ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RD)).(e_lock)) = ((Some CPU_ID))));
    rely (((v_rd.(poffset)) = (0)));
    rely (((v_rd.(pbase)) = ("slot_rd")));
    (Some (
      ((((1 << (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) >> (1)) - (v_addr)) >? (0))  ,
      st
    )).

End ValidateAddr_Spec.

Opaque validate_map_addr_spec'.
#[global] Hint Unfold validate_map_addr_spec: spec.
#[global] Hint Unfold addr_in_par_spec: spec.
