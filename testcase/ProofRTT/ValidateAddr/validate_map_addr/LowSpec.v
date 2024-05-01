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
    when v_call, st == ((realm_ipa_size_spec v_rd st));
    let v_cmp_not := (v_call >? (v_map_addr)) in
    when v_retval_0, st == (
        let v_retval_0 := false in
        if v_cmp_not
        then (
          when v_call1, st == ((addr_is_level_aligned_spec v_map_addr v_level st));
          when v_retval_0, st == (
              let v_retval_0 := false in
              if v_call1
              then (
                let v_retval_0 := true in
                (Some (v_retval_0, st)))
              else (
                let v_retval_0 := false in
                (Some (v_retval_0, st))));
          (Some (v_retval_0, st)))
        else (
          let v_retval_0 := false in
          (Some (v_retval_0, st))));
    let __return__ := true in
    let __retval__ := v_retval_0 in
    (Some (__retval__, st)).

End ValidateAddr_validate_map_addr_LowSpec.

#[global] Hint Unfold validate_map_addr_spec_low: spec.
