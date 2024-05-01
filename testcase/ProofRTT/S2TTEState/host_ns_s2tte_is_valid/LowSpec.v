Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import S2TTEDesc.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section S2TTEState_host_ns_s2tte_is_valid_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition host_ns_s2tte_is_valid_spec_low (v_s2tte: Z) (v_level: Z) (st: RData) : (option (bool * RData)) :=
    when v_call, st == ((addr_level_mask_spec (- 1) v_level st));
    let v_or2 := (v_call |' (988)) in
    let v_neg := (Z.lxor v_or2 (- 1)) in
    let v_and := (v_neg & (v_s2tte)) in
    let v_cmp_not := (v_and =? (0)) in
    when v_retval_0, st == (
        let v_retval_0 := false in
        if v_cmp_not
        then (
          let v_and3 := (v_s2tte & (28)) in
          let v_cmp4 := (v_and3 =? (16)) in
          when v_retval_0, st == (
              let v_retval_0 := false in
              if v_cmp4
              then (
                let v_retval_0 := false in
                (Some (v_retval_0, st)))
              else (
                let v_and7 := (v_s2tte & (768)) in
                let v_cmp8 := (v_and7 =? (256)) in
                when v_retval_0, st == (
                    let v_retval_0 := false in
                    if v_cmp8
                    then (
                      let v_retval_0 := false in
                      (Some (v_retval_0, st)))
                    else (
                      let v_retval_0 := true in
                      (Some (v_retval_0, st))));
                (Some (v_retval_0, st))));
          (Some (v_retval_0, st)))
        else (
          let v_retval_0 := false in
          (Some (v_retval_0, st))));
    let __return__ := true in
    let __retval__ := v_retval_0 in
    (Some (__retval__, st)).

End S2TTEState_host_ns_s2tte_is_valid_LowSpec.

#[global] Hint Unfold host_ns_s2tte_is_valid_spec_low: spec.
