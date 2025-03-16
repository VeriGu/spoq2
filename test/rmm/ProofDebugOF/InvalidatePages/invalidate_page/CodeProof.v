Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import InvalidatePages.invalidate_page.LowSpec.
Require Import Mmap.Layer.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section InvalidatePages_invalidate_page_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque stage2_tlbi_ipa_spec.
    Lemma f_invalidate_page_correct:
      forall v_s2_ctx v_addr st st'
             (Hspec: invalidate_page_spec_low v_s2_ctx v_addr st = Some st'),
        exec_func Mmap_layer code "invalidate_page"
                  [VPtr v_s2_ctx; VInt v_addr]
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

End InvalidatePages_invalidate_page_CodeProof.

