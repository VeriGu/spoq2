Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer7.Layer.
Require Import Layer8.virt_to_phys.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer8_virt_to_phys_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque iasm_12_isb_spec.
  Local Opaque iasm_277_spec.
  Local Opaque iasm_278_spec.
  Local Opaque iasm_get_par_el1_spec.
  Local Opaque store_RData.
    Lemma f_virt_to_phys_correct:
      forall v_0 v_1 v_2 v_3 st st' res
             (Hspec: virt_to_phys_spec_low v_0 v_1 v_2 v_3 st = Some (res, st')),
        exec_func Layer7_layer code "virt_to_phys"
                  [VInt v_0; VInt v_1; VPtr v_2; VInt v_3]
                  st st' (Some (VInt res)).
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

End Layer8_virt_to_phys_CodeProof.

