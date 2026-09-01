Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import GranuleInfo.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section MmapInternal_buffer_map_internal_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition buffer_map_internal_spec_low (v_slot: Z) (v_addr: Z) (st: RData) : (option (Ptr * RData)) :=
    rely ((v_slot <= (24)));
    rely ((v_slot >= (0)));
    when v_call, st_0 == ((slot_to_va_spec v_slot st));
    when v_call2, st_1 == ((get_cached_llt_info_spec st_0));
    when v_call3, st_2 == (
        if (v_slot =? (0))
        then (xlat_map_memory_page_with_attrs_spec v_call2 v_call v_addr 1458 st_1)
        else (xlat_map_memory_page_with_attrs_spec v_call2 v_call v_addr 434 st_1));
    if (v_call3 =? (0))
    then (Some ((int_to_ptr v_call), st_2))
    else (Some ((mkPtr "null" 0), st_2)).

End MmapInternal_buffer_map_internal_LowSpec.

#[global] Hint Unfold buffer_map_internal_spec_low: spec.
