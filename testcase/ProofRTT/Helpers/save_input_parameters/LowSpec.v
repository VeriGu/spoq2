Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Helpers_save_input_parameters_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition save_input_parameters_spec_low (v_rec: Ptr) (st: RData) : (option RData) :=
    rely (((0 <= (1)) /\ ((1 < (31)))));
    let v_arrayidx := (ptr_offset v_rec ((3272 * (0)) + ((24 + (((8 * (1)) + (0))))))) in
    when v_0, st == ((load_RData 8 v_arrayidx st));
    let v_token_ipa := (ptr_offset v_rec ((3272 * (0)) + ((2168 + ((960 + (0))))))) in
    when st == ((store_RData 8 v_token_ipa v_0 st));
    rely (((0 <= (0)) /\ ((0 < (64)))));
    let v_arraydecay := (ptr_offset v_rec ((3272 * (0)) + ((2168 + ((968 + (((1 * (0)) + (0))))))))) in
    rely (((0 <= (2)) /\ ((2 < (31)))));
    let v_arrayidx3 := (ptr_offset v_rec ((3272 * (0)) + ((24 + (((8 * (2)) + (0))))))) in
    let v_1 := v_arrayidx3 in
    when v_call, st == ((memcpy_spec v_arraydecay v_1 64 st));
    let __return__ := true in
    (Some st).

End Helpers_save_input_parameters_LowSpec.

#[global] Hint Unfold save_input_parameters_spec_low: spec.
