Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer7.Layer.
Require Import Layer7.Spec.
Require Import Layer8.psci_rsi.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer8_psci_rsi_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque GRANULE_STATE_REC.
  Local Opaque psci_affinity_info_spec.
  Local Opaque psci_cpu_off_spec.
  Local Opaque psci_cpu_on_spec.
  Local Opaque psci_cpu_suspend_spec.
  Local Opaque psci_features_spec.
  Local Opaque psci_system_off_spec.
  Local Opaque psci_system_reset_spec.
  Local Opaque psci_version_spec.
  Local Opaque ptr_offset.
  Local Opaque store_RData.
    Lemma f_psci_rsi_correct:
      forall v_0 v_1 v_2 v_3 v_4 v_5 st st'
             (Hspec: psci_rsi_spec_low v_0 v_1 v_2 v_3 v_4 v_5 st = Some st'),
        exec_func Layer7_layer code "psci_rsi"
                  [VPtr v_0; VPtr v_1; VInt v_2; VInt v_3; VInt v_4; VInt v_5]
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

End Layer8_psci_rsi_CodeProof.

