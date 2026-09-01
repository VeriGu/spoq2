Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Helpers.Spec.
Require Import Mmap.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section S2TTEDesc___table_get_entry_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition __table_get_entry_spec_low (v_g_tbl: Ptr) (v_idx: Z) (st: RData) : (option (Z * RData)) :=
    rely ((((v_g_tbl.(poffset)) mod (ST_GRANULE_SIZE)) = (0)));
    rely (((v_g_tbl.(pbase)) = ("granules")));
    when v_call, st_0 == ((granule_map_spec v_g_tbl 22 st));
    when v_call2, st_1 == ((__tte_read_spec (ptr_offset v_call (8 * (v_idx))) st_0));
    when st_2 == ((buffer_unmap_spec v_call st_1));
    (Some (v_call2, st_2)).

End S2TTEDesc___table_get_entry_LowSpec.

#[global] Hint Unfold __table_get_entry_spec_low: spec.
