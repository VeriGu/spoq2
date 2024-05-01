Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import MemRW.granule_memzero_mapped.LowSpec.
Require Import Mmap.Layer.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section MemRW_granule_memzero_mapped_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opacque memset_spec.
    Lemma f_granule_memzero_mapped_correct:
      forall v_buf st st'
             (Hspec: granule_memzero_mapped_spec_low v_buf st = Some st'),
        exec_func Mmap_layer code "granule_memzero_mapped"
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

End MemRW_granule_memzero_mapped_CodeProof.

