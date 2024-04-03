Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section S2TTEPA_s2tte_pa_table_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2tte_pa_table_spec_low (v_s2tte: Z) (v_level: Z) (st: RData) : (option (Z * RData)) :=
    when v_call, st == ((addr_level_mask_spec v_s2tte 3 st));
    let __return__ := true in
    let __retval__ := v_call in
    (Some (__retval__, st)).

End S2TTEPA_s2tte_pa_table_LowSpec.

#[global] Hint Unfold s2tte_pa_table_spec_low: spec.
