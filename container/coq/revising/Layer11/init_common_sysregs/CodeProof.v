Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer1.Spec.
Require Import Layer10.Layer.
Require Import Layer10.Spec.
Require Import Layer11.init_common_sysregs.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer11_init_common_sysregs_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque granule_addr_spec.
  Local Opaque int_to_ptr.
  Local Opaque load_RData.
  Local Opaque ptr_offset.
  Local Opaque realm_vtcr_spec.
  Local Opaque store_RData.
    Lemma f_init_common_sysregs_correct:
      forall v_0 v_1 st st'
             (Hspec: init_common_sysregs_spec_low v_0 v_1 st = Some st'),
        exec_func Layer10_layer code "init_common_sysregs"
                  [VPtr v_0; VPtr v_1]
                  st st' None.
Admitted.

End Layer11_init_common_sysregs_CodeProof.

