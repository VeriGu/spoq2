Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer5.Spec.
Require Import Layer6.Layer.
Require Import Layer6.Spec.
Require Import Layer7.psci_cpu_on.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer7_psci_cpu_on_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque GRANULE_STATE_REC.
  Local Opaque int_to_ptr.
  Local Opaque llvm_memset_p0i8_i64_spec.
  Local Opaque load_RData.
  Local Opaque ptr_offset.
  Local Opaque rd_map_read_rec_count_spec.
  Local Opaque store_RData.
  Local Opaque vmpidr_to_rec_idx_spec.
    Lemma f_psci_cpu_on_correct:
      forall v_0 v_1 v_2 v_3 v_4 st st'
             (Hspec: psci_cpu_on_spec_low v_0 v_1 v_2 v_3 v_4 st = Some st'),
        exec_func Layer6_layer code "psci_cpu_on"
                  [VPtr v_0; VPtr v_1; VInt v_2; VInt v_3; VInt v_4]
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

End Layer7_psci_cpu_on_CodeProof.

