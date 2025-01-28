Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer5.Spec.
Require Import Layer6.Layer.
Require Import Layer6.Spec.
Require Import Layer7.smc_granule_ns_to_any.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer7_smc_granule_ns_to_any_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque MEM0_PHYS.
  Local Opaque MEM0_SIZE.
  Local Opaque MEM1_PHYS.
  Local Opaque MEM1_SIZE.
  Local Opaque __granule_get_spec.
  Local Opaque find_lock_granule_spec.
  Local Opaque g_mapped_addr_set_spec.
  Local Opaque granule_set_state_spec.
  Local Opaque granule_unlock_spec.
  Local Opaque mkPtr.
  Local Opaque pack_return_code_spec.
  Local Opaque ptr_eqb.
  Local Opaque set_pas_ns_to_any_spec.
    Lemma f_smc_granule_ns_to_any_correct:
      forall v_0 v_1 st st' res
             (Hspec: smc_granule_ns_to_any_spec_low v_0 v_1 st = Some (res, st')),
        exec_func Layer6_layer code "smc_granule_ns_to_any"
                  [VInt v_0; VInt v_1]
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

End Layer7_smc_granule_ns_to_any_CodeProof.

