Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer1.Spec.
Require Import Layer10.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer11_init_common_sysregs_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition init_common_sysregs_0_low (st_0: RData) (v_0: Ptr) (v_1: Ptr) (v_4: Z) : (option RData) :=
    rely (((v_4 =? (0)) = (true)));
    when st_1 == ((store_RData 8 (ptr_offset v_0 856) 19328140351 st_0));
    when v_17, st_2 == ((realm_vtcr_spec v_1 st_1));
    when st_3 == ((store_RData 8 (ptr_offset v_0 848) v_17 st_2));
    when v_20_tmp, st_4 == ((load_RData 8 (ptr_offset v_1 32) st_3));
    when v_21, st_5 == ((granule_addr_spec (int_to_ptr v_20_tmp) st_4));
    when st_6 == ((store_RData 8 (ptr_offset v_0 840) (v_21 & (281474976710654)) st_5));
    when v_25, st_7 == ((load_RData 4 (ptr_offset v_1 40) st_6));
    when st_8 == ((store_RData 8 (ptr_offset v_0 840) ((v_25 << (48)) + ((v_21 & (281474976710654)))) st_7));
    (Some st_8).

  Definition init_common_sysregs_spec_low (v_0: Ptr) (v_1: Ptr) (st: RData) : (option RData) :=
    when v_4, st_0 == ((load_RData 8 (ptr_offset v_0 1520) st));
    if (v_4 =? (0))
    then (init_common_sysregs_0_low st_0 v_0 v_1 v_4)
    else (
      when v_6, st_1 == ((realm_vtcr_spec v_1 st_0));
      when st_2 == ((store_RData 8 (ptr_offset v_0 848) v_6 st_1));
      when v_9, st_3 == ((load_RData 4 (ptr_offset v_1 40) st_2));
      when v_13, st_4 == ((load_RData 8 (ptr_offset v_0 840) st_3));
      when st_5 == ((store_RData 8 (ptr_offset v_0 840) ((v_9 << (48)) |' (v_13)) st_4));
      (Some st_5)).



End Layer11_init_common_sysregs_LowSpec.

#[global] Hint Unfold init_common_sysregs_spec_low: spec.
#[global] Hint Unfold init_common_sysregs_0_low: spec.
