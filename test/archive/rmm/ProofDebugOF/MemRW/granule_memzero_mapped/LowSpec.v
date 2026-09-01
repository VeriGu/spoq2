Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section MemRW_granule_memzero_mapped_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition granule_memzero_mapped_spec_low (v_buf: Ptr) (st: RData) : (option RData) :=
    rely ((((v_buf.(pbase)) = ("slot_rtt2")) \/ (((v_buf.(pbase)) = ("slot_rec")))));
    when v_call, st_0 == ((memset_spec v_buf 0 4096 st));
    (Some st_0).

End MemRW_granule_memzero_mapped_LowSpec.

#[global] Hint Unfold granule_memzero_mapped_spec_low: spec.
