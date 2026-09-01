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
    when v_call, st_0 == ((plat_granule_idx_to_addr_spec (((ptr_to_int v_g) - ((ptr_to_int (mkPtr "granules" 0)))) >> (4)) st));
    (Some (v_call, st_0)).

End MmapInternal_granule_addr_LowSpec.

#[global] Hint Unfold granule_addr_spec_low: spec.
