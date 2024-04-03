Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section S2TTEPA_s2tte_map_size_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2tte_map_size_spec_low (v_level: Z) (st: RData) : (option (Z * RData)) :=
    let v_sub := (3 - (v_level)) in
    let v_mul := (v_sub * (9)) in
    let v_add := (v_mul + (12)) in
    let v_sh_prom := v_add in
    let v_shl := (1 << (v_sh_prom)) in
    let __return__ := true in
    let __retval__ := v_shl in
    (Some (__retval__, st)).

End S2TTEPA_s2tte_map_size_LowSpec.

#[global] Hint Unfold s2tte_map_size_spec_low: spec.
