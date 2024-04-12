Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section SCA_arch_feat_get_pa_width_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition arch_feat_get_pa_width_spec_low (st: RData) : (option (Z * RData)) :=
    when v_call, st == ((read_id_aa64mmfr0_el1_spec st));
    let v_and := (v_call & (15)) in
    rely (((0 <= (v_and)) /\ ((v_and < (7)))));
    let v_arrayidx := (ptr_offset (mkPtr "__const_arch_feat_get_pa_width_pa_range_bits_arr" 0) (((4 * (7)) * (0)) + (((4 * (v_and)) + (0))))) in
    when v_0, st == ((load_RData 4 v_arrayidx st));
    let __return__ := true in
    let __retval__ := v_0 in
    (Some (__retval__, st)).

End SCA_arch_feat_get_pa_width_LowSpec.

#[global] Hint Unfold arch_feat_get_pa_width_spec_low: spec.
