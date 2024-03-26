Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Helpers_calc_esr_idabort_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition calc_esr_idabort_spec_low (v_esr_el2: Z) (v_spsr_el2: Z) (v_fsc: Z) (st: RData) : (option (Z * RData)) :=
    let v_and1 := (v_esr_el2 & (4227858432)) in
    let v_and2 := (v_spsr_el2 & (15)) in
    let v_cmp_not := (v_and2 =? (0)) in
    when v_ec_0, st == (
        let v_ec_0 := 0 in
        if v_cmp_not
        then (
          let v_ec_0 := v_and1 in
          (Some (v_ec_0, st)))
        else (
          let v_add := (v_and1 + (67108864)) in
          let v_ec_0 := v_add in
          (Some (v_ec_0, st))));
    let v_and := (v_esr_el2 & (18446744069481691456)) in
    let v_or := (v_and |' (512)) in
    let v_or3 := (v_or |' (v_fsc)) in
    let v_or4 := (v_or3 |' (v_ec_0)) in
    let __return__ := true in
    let __retval__ := v_or4 in
    (Some (__retval__, st)).

End Helpers_calc_esr_idabort_LowSpec.

#[global] Hint Unfold calc_esr_idabort_spec_low: spec.
