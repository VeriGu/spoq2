Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer9_rsi_rtt_create_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition rsi_rtt_create_spec_low (v_0_Zptr: Z) (v_1_Zptr: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    let v_0 := (test_PA v_0_Zptr) in
    let v_1 := (test_PA v_1_Zptr) in
    when v__0, st_0 == (
        if ((v_1 & (1)) =? (0))
        then (
          when v_18, st_0 == ((find_lock_granule_spec_abs v_1 5 st));
          rely (((((v_18.(poffset)) mod (16)) = (0)) /\ (((v_18.(poffset)) >= (0)))));
          rely ((((v_18.(pbase)) = ("granules")) \/ (((v_18.(pbase)) = ("null")))));
          when v__1, st_1 == (
              if (ptr_eqb v_18 (mkPtr "null" 0))
              then (
                when v_20, st_1 == ((pack_return_code_spec 1 1 st_0));
                (Some (v_20, st_1)))
              else (
                when v_23, st_1 == ((rtt_create_internal_spec_abs v_18 v_0 v_2 v_3 0 st_0));
                (Some (((v_23 << (32)) >> (32)), st_1))));
          (Some (v__1, st_1)))
        else (
          when v_8, st_0 == ((find_lock_granule_spec_abs (v_1 & ((- 2))) 3 st));
          rely (((((v_8.(poffset)) mod (16)) = (0)) /\ (((v_8.(poffset)) >= (0)))));
          rely ((((v_8.(pbase)) = ("granules")) \/ (((v_8.(pbase)) = ("null")))));
          when v__1, st_1 == (
              if (ptr_eqb v_8 (mkPtr "null" 0))
              then (
                when v_10, st_1 == ((pack_return_code_spec 1 2 st_0));
                (Some (v_10, st_1)))
              else (
                when v_13, st_1 == ((granule_map_spec v_8 3 st_0));
                when v_15, st_2 == ((rtt_create_s1_el1_spec_abs v_13 v_0 v_2 v_3 st_1));
                when st_3 == ((granule_unlock_spec v_8 st_2));
                (Some (((v_15 << (32)) >> (32)), st_3))));
          (Some (v__1, st_1))));
    (Some (v__0, st_0)).

End Layer9_rsi_rtt_create_LowSpec.

#[global] Hint Unfold rsi_rtt_create_spec_low: spec.
