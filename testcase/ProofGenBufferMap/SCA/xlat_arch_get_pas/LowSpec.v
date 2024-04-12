Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section SCA_xlat_arch_get_pas_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition xlat_arch_get_pas_spec_low (v_attr: Z) (st: RData) : (option (Z * RData)) :=
    let v_and := (v_attr & (1024)) in
    when v_retval_0, st == (
        let v_retval_0 := 0 in
        if (v_and =? (1024))
        then (
          let v_retval_0 := 32 in
          (Some (v_retval_0, st)))
        else (
          when v_retval_0, st == (
              let v_retval_0 := 0 in
              if (v_and =? (0))
              then (
                let v_retval_0 := 0 in
                (Some (v_retval_0, st)))
              else None);
          (Some (v_retval_0, st))));
    let __return__ := true in
    let __retval__ := v_retval_0 in
    (Some (__retval__, st)).

End SCA_xlat_arch_get_pas_LowSpec.

#[global] Hint Unfold xlat_arch_get_pas_spec_low: spec.
