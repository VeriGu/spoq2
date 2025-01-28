Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer11_init_rec_sysregs_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition init_rec_sysregs_spec_low (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
    when st_0 == ((store_RData 8 (ptr_offset v_0 320) 64 st));
    when st_1 == ((store_RData 8 (ptr_offset v_0 360) 12912760 st_0));
    when st_2 == ((store_RData 8 (ptr_offset v_0 504) 4096 st_1));
    when st_3 == ((store_RData 8 (ptr_offset v_0 800) (v_1 |' (2147483648)) st_2));
    when st_4 == ((store_RData 8 (ptr_offset v_0 536) 3072 st_3));
    (Some st_4).

End Layer11_init_rec_sysregs_LowSpec.

#[global] Hint Unfold init_rec_sysregs_spec_low: spec.
