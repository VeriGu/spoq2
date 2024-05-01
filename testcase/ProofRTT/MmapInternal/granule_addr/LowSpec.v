Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section MmapInternal_granule_addr_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition granule_addr_spec_low (v_g: Ptr) (st: RData) : (option (Z * RData)) :=
    rely ((((v_g.(poffset)) mod (ST_GRANULE_SIZE)) = (0)));
    rely (((v_g.(pbase)) = ("granules")));
    let v_sub_ptr_lhs_cast := (ptr_to_int v_g) in
    let v_sub_ptr_sub := (v_sub_ptr_lhs_cast - ((ptr_to_int (mkPtr "granules" 0)))) in
    let v_sub_ptr_div := (v_sub_ptr_sub >> (4)) in
    when v_call, st == ((plat_granule_idx_to_addr_spec v_sub_ptr_div st));
    let __return__ := true in
    let __retval__ := v_call in
    (Some (__retval__, st)).

End MmapInternal_granule_addr_LowSpec.

#[global] Hint Unfold granule_addr_spec_low: spec.
