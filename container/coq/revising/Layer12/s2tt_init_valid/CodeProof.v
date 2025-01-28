Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer11.Layer.
Require Import Layer11.Spec.
Require Import Layer12.s2tt_init_valid.LowSpec.
Require Import Layer6.Spec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer12_s2tt_init_valid_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque iasm_10_spec.
  Local Opaque ptr_offset.
  Hint Unfold s2tt_init_valid_loop820_low:spec.
  Hint Unfold s2tt_init_valid_loop820_rank:spec.
  Local Opaque s2tte_create_valid_spec.
  Local Opaque s2tte_map_size_spec.
  Local Opaque store_RData.
    Lemma f_s2tt_init_valid_correct:
      forall v_0 v_1 v_2 st st'
             (Hspec: s2tt_init_valid_spec_low v_0 v_1 v_2 st = Some st'),
        exec_func Layer11_layer code "s2tt_init_valid"
                  [VPtr v_0; VInt v_1; VInt v_2]
                  st st' None.
Admitted.

End Layer12_s2tt_init_valid_CodeProof.

