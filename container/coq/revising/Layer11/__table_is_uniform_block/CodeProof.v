Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer10.Layer.
Require Import Layer11.__table_is_uniform_block.LowSpec.
Require Import Layer2.Spec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer11___table_is_uniform_block_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Hint Unfold __table_is_uniform_block_funptr_wrap907:spec.
  Hint Unfold __table_is_uniform_block_loop904_low:spec.
  Hint Unfold __table_is_uniform_block_loop904_rank:spec.
  Local Opaque __tte_read_spec.
  Local Opaque ptr_offset.
    Lemma f___table_is_uniform_block_correct:
      forall v_0 v_1 st st' res
             (Hspec: __table_is_uniform_block_spec_low v_0 v_1 st = Some (res, st')),
        exec_func Layer10_layer code "__table_is_uniform_block"
                  [VPtr v_0; VPtr v_1]
                  st st' (Some (VBool res)).
Admitted.

End Layer11___table_is_uniform_block_CodeProof.

