Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer6_realm_rtt_starting_level_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition realm_rtt_starting_level_spec_low (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
    rely ((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))));
    when v_3, st_0 == ((load_RData 4 (mkPtr (v_0.(pbase)) ((v_0.(poffset)) + (20))) st));
    (Some (v_3, st_0)).

End Layer6_realm_rtt_starting_level_LowSpec.

#[global] Hint Unfold realm_rtt_starting_level_spec_low: spec.
