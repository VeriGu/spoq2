Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section SMCHandler_smc_data_create_unknown_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition smc_data_create_unknown_spec_low (v_data_addr: Z) (v_rd_addr: Z) (v_map_addr: Z) (st: RData) : (option (Z * RData)) :=
    when v_call, st == ((data_create_spec v_data_addr v_rd_addr v_map_addr (mkPtr "null" 0) 0 st));
    let __return__ := true in
    let __retval__ := v_call in
    (Some (__retval__, st)).

End SMCHandler_smc_data_create_unknown_LowSpec.

#[global] Hint Unfold smc_data_create_unknown_spec_low: spec.
