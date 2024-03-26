Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section MmapInternal_buffer_unmap_internal_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition buffer_unmap_internal_spec_low (v_buf: Ptr) (st: RData) : (option RData) :=
    rely (((v_buf.(poffset)) = (0)));
    rely (
      ((((((((((((v_buf.(pbase)) = ("slot_rd")) \/ (((v_buf.(pbase)) = ("slot_ns")))) \/ (((v_buf.(pbase)) = ("slot_delegated")))) \/ (((v_buf.(pbase)) = ("slot_rec")))) \/
        (((v_buf.(pbase)) = ("slot_rec2")))) \/
        (((v_buf.(pbase)) = ("slot_rec_target")))) \/
        (((v_buf.(pbase)) = ("slot_rec_aux0")))) \/
        (((v_buf.(pbase)) = ("slot_rtt")))) \/
        (((v_buf.(pbase)) = ("slot_rtt2")))) \/
        (((v_buf.(pbase)) = ("slot_rsi_call")))) \/
        (((v_buf.(pbase)) = ("slot_ns")))));
    when st == ((iasm_10_spec st));
    when v_call, st == ((get_cached_llt_info_spec st));
    let v_0 := (ptr_to_int v_buf) in
    when v_call1, st == ((xlat_unmap_memory_page_spec v_call v_0 st));
    let __return__ := true in
    (Some st).

End MmapInternal_buffer_unmap_internal_LowSpec.

#[global] Hint Unfold buffer_unmap_internal_spec_low: spec.
