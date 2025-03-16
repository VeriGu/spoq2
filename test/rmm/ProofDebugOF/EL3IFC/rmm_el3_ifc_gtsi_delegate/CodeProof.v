Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import EL3IFC.rmm_el3_ifc_gtsi_delegate.LowSpec.
Require Import GlobalDefs.
Require Import InitRec.Layer.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section EL3IFC_rmm_el3_ifc_gtsi_delegate_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque monitor_call_spec.
    Lemma f_rmm_el3_ifc_gtsi_delegate_correct:
      forall v_addr st st' res
             (Hspec: rmm_el3_ifc_gtsi_delegate_spec_low v_addr st = Some (res, st')),
        exec_func InitRec_layer code "rmm_el3_ifc_gtsi_delegate"
                  [VInt v_addr]
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

End EL3IFC_rmm_el3_ifc_gtsi_delegate_CodeProof.

