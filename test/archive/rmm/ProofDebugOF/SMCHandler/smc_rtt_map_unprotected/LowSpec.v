Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import S2TTCreate.Spec.
Require Import S2TTEState.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section SMCHandler_smc_rtt_map_unprotected_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition smc_rtt_map_unprotected_spec_low (v_rd_addr: Z) (v_map_addr: Z) (v_ulevel: Z) (v_s2tte: Z) (st: RData) : (option (Z * RData)) :=
    when v_call, st_0 == ((host_ns_s2tte_is_valid_spec v_s2tte v_ulevel st));
    if v_call
    then (
      when v_call1, st_1 == ((map_unmap_ns_spec v_rd_addr v_map_addr v_ulevel v_s2tte 0 st_0));
      (Some (v_call1, st_1)))
    else (Some (1, st_0)).

End SMCHandler_smc_rtt_map_unprotected_LowSpec.

#[global] Hint Unfold smc_rtt_map_unprotected_spec_low: spec.
