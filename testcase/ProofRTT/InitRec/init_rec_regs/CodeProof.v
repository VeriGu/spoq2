Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import InitRec.init_rec_regs.LowSpec.
Require Import InitRegs.Layer.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section InitRec_init_rec_regs_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f_init_rec_regs_correct:
      forall v_rec v_rec_params v_rd st st'
             (Hspec: init_rec_regs_spec_low v_rec v_rec_params v_rd st = Some st'),
        exec_func InitRegs_layer code "init_rec_regs"
                  [VPtr v_rec; VPtr v_rec_params; VPtr v_rd]
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

End InitRec_init_rec_regs_CodeProof.

