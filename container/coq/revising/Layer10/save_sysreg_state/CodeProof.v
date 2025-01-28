Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer10.save_sysreg_state.LowSpec.
Require Import Layer9.Layer.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer10_save_sysreg_state_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque iasm_136_spec.
  Local Opaque iasm_139_spec.
  Local Opaque iasm_212_spec.
  Local Opaque iasm_213_spec.
  Local Opaque iasm_219_spec.
  Local Opaque iasm_221_spec.
  Local Opaque iasm_224_spec.
  Local Opaque iasm_225_spec.
  Local Opaque iasm_226_spec.
  Local Opaque iasm_227_spec.
  Local Opaque iasm_228_spec.
  Local Opaque iasm_229_spec.
  Local Opaque iasm_230_spec.
  Local Opaque iasm_231_spec.
  Local Opaque iasm_233_spec.
  Local Opaque iasm_234_spec.
  Local Opaque iasm_6_spec.
  Local Opaque iasm_7_spec.
  Local Opaque iasm_81_spec.
  Local Opaque iasm_84_spec.
  Local Opaque iasm_get_actlr_el1_spec.
  Local Opaque iasm_get_cntvoff_el2_spec.
  Local Opaque iasm_get_csselr_el1_spec.
  Local Opaque iasm_get_disr_el1_spec.
  Local Opaque iasm_get_mdccint_el1_spec.
  Local Opaque iasm_get_mdscr_el1_spec.
  Local Opaque iasm_get_par_el1_spec.
  Local Opaque iasm_get_pmcr_el0_spec.
  Local Opaque iasm_get_pmuserenr_el0_spec.
  Local Opaque iasm_get_sp_el0_spec.
  Local Opaque iasm_get_sp_el1_spec.
  Local Opaque iasm_get_tpidr_el0_spec.
  Local Opaque iasm_get_tpidr_el1_spec.
  Local Opaque iasm_get_tpidrro_el0_spec.
  Local Opaque ptr_offset.
  Local Opaque store_RData.
    Lemma f_save_sysreg_state_correct:
      forall v_0 st st'
             (Hspec: save_sysreg_state_spec_low v_0 st = Some st'),
        exec_func Layer9_layer code "save_sysreg_state"
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

End Layer10_save_sysreg_state_CodeProof.

