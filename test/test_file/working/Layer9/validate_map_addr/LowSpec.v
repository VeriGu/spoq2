Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer9_validate_map_addr_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition validate_map_addr_spec_low (v_0: Z) (v_1: Z) (v_2: Ptr) (st: RData) : (option (Z * RData)) :=
    rely (((((v_2.(pbase)) = ("granule_data")) /\ (((v_2.(poffset)) >= (0)))) /\ ((0 = (((v_2.(poffset)) mod (4096)))))));
    rely ((((((st.(share)).(granule_data)) @ ((v_2.(poffset)) / (4096))).(g_granule_state)) = (GRANULE_STATE_RD)));
    when v_4, st == ((realm_ipa_size_spec v_2 st));
    let v__not := (v_4 >? (v_0)) in
    when v__sroa_0_0, st == (
        let v__sroa_0_0 := 0 in
        if v__not
        then (
          let v_8 := (ptr_offset v_2 ((416 * (0)) + ((408 + (0))))) in
          rely ((408 = (((v_8.(poffset)) mod (4096)))));
          when v_9, st == ((load_RData 8 v_8 st));
          let v__not8 := (v_9 =? (0)) in
          when v__0_in, st == (
              let v__0_in := false in
              if v__not8
              then (
                when v_13, st == ((addr_is_level_aligned_spec v_0 v_1 st));
                let v__0_in := v_13 in
                (Some (v__0_in, st)))
              else (
                when v_11, st == ((s1addr_is_level_aligned_spec v_0 v_1 st));
                let v__0_in := v_11 in
                (Some (v__0_in, st))));
          when v__sroa_0_0, st == (
              let v__sroa_0_0 := 0 in
              if v__0_in
              then (
                when v_18, st == ((make_return_code_spec 0 0 st));
                let v__sroa_0_0 := v_18 in
                (Some (v__sroa_0_0, st)))
              else (
                when v_16, st == ((make_return_code_spec 1 0 st));
                let v__sroa_0_0 := v_16 in
                (Some (v__sroa_0_0, st))));
          (Some (v__sroa_0_0, st)))
        else (
          when v_6, st == ((make_return_code_spec 1 0 st));
          let v__sroa_0_0 := v_6 in
          (Some (v__sroa_0_0, st))));
    let __return__ := true in
    let __retval__ := v__sroa_0_0 in
    (Some (__retval__, st)).

End Layer9_validate_map_addr_LowSpec.

#[global] Hint Unfold validate_map_addr_spec_low: spec.
