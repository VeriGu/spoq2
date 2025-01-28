Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer10.restore_sysreg_state.LowSpec.
Require Import Layer9.Layer.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer10_restore_sysreg_state_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque iasm_153_spec.
  Local Opaque iasm_154_spec.
  Local Opaque iasm_162_spec.
  Local Opaque iasm_166_spec.
  Local Opaque iasm_167_spec.
  Local Opaque iasm_168_spec.
  Local Opaque iasm_169_spec.
  Local Opaque iasm_170_spec.
  Local Opaque iasm_172_spec.
  Local Opaque iasm_174_spec.
  Local Opaque iasm_175_spec.
  Local Opaque iasm_182_spec.
  Local Opaque iasm_183_spec.
  Local Opaque iasm_184_spec.
  Local Opaque iasm_185_spec.
  Local Opaque iasm_75_spec.
  Local Opaque iasm_76_spec.
  Local Opaque iasm_77_spec.
  Local Opaque iasm_82_spec.
  Local Opaque iasm_88_spec.
  Local Opaque iasm_set_actlr_el1_spec.
  Local Opaque iasm_set_cntvoff_el2_spec.
  Local Opaque iasm_set_csselr_el1_spec.
  Local Opaque iasm_set_disr_el1_spec.
  Local Opaque iasm_set_mdccint_el1_spec.
  Local Opaque iasm_set_mdscr_el1_spec.
  Local Opaque iasm_set_par_el1_spec.
  Local Opaque iasm_set_pmcr_el0_spec.
  Local Opaque iasm_set_pmuserenr_el0_spec.
  Local Opaque iasm_set_sp_el0_spec.
  Local Opaque iasm_set_sp_el1_spec.
  Local Opaque iasm_set_tpidr_el0_spec.
  Local Opaque iasm_set_tpidr_el1_spec.
  Local Opaque iasm_set_tpidrro_el0_spec.
  Local Opaque iasm_set_vmpidr_el2_spec.
  Local Opaque load_RData.
  Local Opaque ptr_offset.
    Lemma f_restore_sysreg_state_correct:
      forall v_0 st st'
             (Hspec: restore_sysreg_state_spec_low v_0 st = Some st'),
        exec_func Layer9_layer code "restore_sysreg_state"
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

End Layer10_restore_sysreg_state_CodeProof.

