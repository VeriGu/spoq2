Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer5.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer6_is_addr_in_par_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition is_addr_in_par_spec_low (v_0: Ptr) (v_1: Z) (st: RData) : (option (bool * RData)) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
    rely ((((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))) /\ ((((v_0.(poffset)) mod (4096)) = (0)))) /\ (((v_1 mod (4096)) = (0)))));
    when v_4, st_0 == ((load_RData 8 (mkPtr (v_0.(pbase)) ((v_0.(poffset)) + (48))) st));
    when v_6, st_1 == ((load_RData 8 (mkPtr (v_0.(pbase)) ((v_0.(poffset)) + (64))) st_0));
    (Some ((((v_1 - (v_4)) >=? (0)) && ((((v_6 + ((- 1))) - (v_1)) >=? (0)))), st_1)).

End Layer6_is_addr_in_par_LowSpec.

#[global] Hint Unfold is_addr_in_par_spec_low: spec.
