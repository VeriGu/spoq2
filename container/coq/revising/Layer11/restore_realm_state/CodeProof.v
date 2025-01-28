Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer10.Layer.
Require Import Layer10.Spec.
Require Import Layer11.restore_realm_state.LowSpec.
Require Import Layer9.Spec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer11_restore_realm_state_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque gic_restore_state_spec.
  Local Opaque iasm_12_isb_spec.
  Local Opaque iasm_set_cnthctl_el2_spec.
  Local Opaque iasm_set_elr_el2_spec.
  Local Opaque iasm_set_hcr_el2_spec.
  Local Opaque iasm_set_spsr_el2_spec.
  Local Opaque load_RData.
  Local Opaque ptr_offset.
  Local Opaque restore_sysreg_state_spec.
    Lemma f_restore_realm_state_correct:
      forall v_0 st st'
             (Hspec: restore_realm_state_spec_low v_0 st = Some st'),
        exec_func Layer10_layer code "restore_realm_state"
                  [VPtr v_0]
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

End Layer11_restore_realm_state_CodeProof.

