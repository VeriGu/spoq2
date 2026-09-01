Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Mmap.buffer_unmap.LowSpec.
Require Import MmapInternal.Layer.
Require Import MmapInternal.Spec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Mmap_buffer_unmap_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque buffer_unmap_internal_spec.
    Lemma f_buffer_unmap_correct:
      forall v_buf st st'
             (Hspec: buffer_unmap_spec_low v_buf st = Some st'),
        exec_func MmapInternal_layer code "buffer_unmap"
                  [VPtr v_buf]
                  st st' None.
    Proof.
        intros; simpl_func Hspec; simpl in *;
          unshelve (eapply exec_func_call);
         (lia ||
          match goal with
          | [ |- temp_env ] => shelve
          | [ |- function ] => shelve
          | [ |- function_body ] => shelve
          | [ |- State _ ] => shelve
          | _ => idtac
          end);
         unshelve (try reflexivity; try solve [repeat vcgen | (frewrite; repeat vcgen)]);
         (lia ||
          match goal with
          | [ |- temp_env ] => shelve
          | _ => idtac
          end).
    Qed.

End Mmap_buffer_unmap_CodeProof.

