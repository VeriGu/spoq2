Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section GranuleInfo_get_cached_llt_info_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition get_cached_llt_info_spec_low (st: RData) : (option (Ptr * RData)) :=
    when v_call, st == ((my_cpuid_spec st));
    let v_idxprom := v_call in
    rely (((0 <= (v_idxprom)) /\ ((v_idxprom < (16)))));
    let v_arrayidx := (ptr_offset (mkPtr "llt_info_cache" 0) (((24 * (16)) * (0)) + (((24 * (v_idxprom)) + (0))))) in
    let __return__ := true in
    let __retval__ := v_arrayidx in
    (Some (__retval__, st)).

End GranuleInfo_get_cached_llt_info_LowSpec.

#[global] Hint Unfold get_cached_llt_info_spec_low: spec.
