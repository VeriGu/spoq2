Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Helpers.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section GranuleInfo_get_cached_llt_info_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition get_cached_llt_info_spec_low (st: RData) : (option (Ptr * RData)) :=
    when v_call, st_0 == ((my_cpuid_spec st));
    rely ((((0 - (v_call)) <= (0)) /\ ((v_call < (16)))));
    (Some ((ptr_offset (mkPtr "llt_info_cache" 0) (24 * (v_call))), st_0)).

End GranuleInfo_get_cached_llt_info_LowSpec.

#[global] Hint Unfold get_cached_llt_info_spec_low: spec.
