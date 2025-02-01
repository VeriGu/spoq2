Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer1_granule_addr_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition granule_addr_spec_low (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    when v__0, st_0 == (
        if (((ptr_to_int v_0) - ((ptr_to_int (mkPtr "granules" 0)))) >? (8388592))
        then (Some (((((ptr_to_int v_0) - ((ptr_to_int (mkPtr "granules" 0)))) * (256)) + (549755813888)), st))
        else (Some (((((ptr_to_int v_0) - ((ptr_to_int (mkPtr "granules" 0)))) * (256)) + (2147483648)), st)));
    (Some (v__0, st_0)).

End Layer1_granule_addr_LowSpec.

#[global] Hint Unfold granule_addr_spec_low: spec.
