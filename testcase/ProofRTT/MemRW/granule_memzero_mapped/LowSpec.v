Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section MemRW_granule_memzero_mapped_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition granule_memzero_mapped_spec_low (v_buf: Ptr) (st: RData) : (option RData) :=
    rely (((v_buf.(pbase)) = ("slot_rtt2")));
    when v_call, st == ((memset_spec v_buf 0 4096 st));
    let __return__ := true in
    (Some st).

End MemRW_granule_memzero_mapped_LowSpec.

#[global] Hint Unfold granule_memzero_mapped_spec_low: spec.
