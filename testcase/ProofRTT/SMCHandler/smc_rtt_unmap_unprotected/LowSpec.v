Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section SMCHandler_smc_rtt_unmap_unprotected_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition smc_rtt_unmap_unprotected_spec_low (v_rd_addr: Z) (v_map_addr: Z) (v_ulevel: Z) (st: RData) : (option (Z * RData)) :=
    when v_call, st == ((map_unmap_ns_spec v_rd_addr v_map_addr v_ulevel 0 1 st));
    let __return__ := true in
    let __retval__ := v_call in
    (Some (__retval__, st)).

End SMCHandler_smc_rtt_unmap_unprotected_LowSpec.

#[global] Hint Unfold smc_rtt_unmap_unprotected_spec_low: spec.
