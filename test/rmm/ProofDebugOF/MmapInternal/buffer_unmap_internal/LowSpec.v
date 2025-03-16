Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import GranuleInfo.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section MmapInternal_buffer_unmap_internal_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition buffer_unmap_internal_spec_low (v_buf: Ptr) (st: RData) : (option RData) :=
    when st_0 == ((iasm_10_spec st));
    when v_call, st_1 == ((get_cached_llt_info_spec st_0));
    when v_call1, st_2 == ((xlat_unmap_memory_page_spec v_call (ptr_to_int v_buf) st_1));
    (Some st_2).

End MmapInternal_buffer_unmap_internal_LowSpec.

#[global] Hint Unfold buffer_unmap_internal_spec_low: spec.
