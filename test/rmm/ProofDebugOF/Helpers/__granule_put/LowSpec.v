Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Helpers___granule_put_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition __granule_put_spec_low (v_g: Ptr) (st: RData) : (option RData) :=
    rely ((((v_g.(pbase)) = ("granules")) /\ (((((v_g.(poffset)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
    when v_0, st_0 == ((load_RData 8 (ptr_offset v_g 8) st));
    when st_1 == ((store_RData 8 (ptr_offset v_g 8) (v_0 + ((- 1))) st_0));
    (Some st_1).

End Helpers___granule_put_LowSpec.

#[global] Hint Unfold __granule_put_spec_low: spec.
