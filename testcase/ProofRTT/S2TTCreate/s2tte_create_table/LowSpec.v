Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section S2TTCreate_s2tte_create_table_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2tte_create_table_spec_low (v_pa: Z) (v_level: Z) (st: RData) : (option (Z * RData)) :=
    let v_or := (v_pa |' (3)) in
    let __return__ := true in
    let __retval__ := v_or in
    (Some (__retval__, st)).

End S2TTCreate_s2tte_create_table_LowSpec.

#[global] Hint Unfold s2tte_create_table_spec_low: spec.
