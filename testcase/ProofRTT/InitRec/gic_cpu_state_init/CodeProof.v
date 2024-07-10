Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import InitRec.gic_cpu_state_init.LowSpec.
Require Import InitRegs.Layer.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section InitRec_gic_cpu_state_init_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opacque memset_spec.
  Local Opacque ptr_offset.
  Local Opacque store_RData.
    Lemma f_gic_cpu_state_init_correct:
      forall v_gicstate st st'
             (Hspec: gic_cpu_state_init_spec_low v_gicstate st = Some st'),
        exec_func InitRegs_layer code "gic_cpu_state_init"
                  [VPtr v_gicstate]
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

End InitRec_gic_cpu_state_init_CodeProof.

