Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer2.Spec.
Require Import Layer6.Spec.
Require Import Layer7.Layer.
Require Import Layer7.Spec.
Require Import Layer8.set_tte_ns.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer8_set_tte_ns_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque MEM0_PHYS.
  Local Opaque MEM0_SIZE.
  Local Opaque MEM1_PHYS.
  Local Opaque MEM1_SIZE.
  Local Opaque __tte_read_spec.
  Local Opaque __tte_write_spec.
  Local Opaque get_tte_spec.
  Local Opaque iasm_10_spec.
  Local Opaque iasm_12_isb_spec.
  Local Opaque iasm_12_spec.
  Local Opaque iasm_8_spec.
  Local Opaque iasm_9_spec.
    Lemma f_set_tte_ns_correct:
      forall v_0 st st'
             (Hspec: set_tte_ns_spec_low v_0 st = Some st'),
        exec_func Layer7_layer code "set_tte_ns"
                  [VInt v_0]
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

End Layer8_set_tte_ns_CodeProof.

