Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import S2TTEOps.Spec.
Require Import S2TTEState.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section ValidateAddr_validate_map_addr_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition validate_map_addr_spec_low (v_map_addr: Z) (v_level: Z) (v_rd: Ptr) (st: RData) : (option (bool * RData)) :=
    rely ((rd_is_locked st));
    rely (((v_rd.(poffset)) = (0)));
    rely (((v_rd.(pbase)) = ("slot_rd")));
    when v_call, st_0 == ((realm_ipa_size_spec v_rd st));
    if ((v_call - (v_map_addr)) >? (0))
    then (
      when v_call1, st_1 == ((addr_is_level_aligned_spec v_map_addr v_level st_0));
      if v_call1
      then (Some (true, st_1))
      else (Some (false, st_1)))
    else (Some (false, st_0)).

End ValidateAddr_validate_map_addr_LowSpec.

#[global] Hint Unfold validate_map_addr_spec_low: spec.
