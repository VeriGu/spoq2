Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer11.Layer.
Require Import Layer11.Spec.
Require Import Layer12.map_unmap_ns.LowSpec.
Require Import Layer2.Spec.
Require Import Layer4.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer12_map_unmap_ns_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque __granule_get_spec.
  Local Opaque __granule_put_spec.
  Local Opaque __tte_read_spec.
  Local Opaque __tte_write_spec.
  Local Opaque addr_block_intersects_par_spec.
  Local Opaque find_lock_granule_spec.
  Local Opaque free_stack.
  Local Opaque granule_lock_spec.
  Local Opaque granule_map_spec.
  Local Opaque granule_unlock_spec.
  Local Opaque int_to_ptr.
  Local Opaque invalidate_block_spec.
  Local Opaque invalidate_page_spec.
  Local Opaque llvm_memcpy_p0i8_p0i8_i64_spec.
  Local Opaque load_RData.
  Local Opaque mkPtr.
  Local Opaque new_frame.
  Local Opaque pack_return_code_spec.
  Local Opaque ptr_eqb.
  Local Opaque ptr_offset.
  Local Opaque realm_ipa_bits_spec.
  Local Opaque realm_rtt_starting_level_spec.
  Local Opaque rtt_walk_lock_unlock_spec.
  Local Opaque s2tte_create_unassigned_spec.
  Local Opaque s2tte_create_valid_ns_spec.
  Local Opaque s2tte_is_destroyed_spec.
  Local Opaque s2tte_is_unassigned_spec.
  Local Opaque s2tte_is_valid_ns_spec.
  Local Opaque validate_rtt_map_cmds_spec.
    Lemma f_map_unmap_ns_correct:
      forall v_0 v_1 v_2 v_3 v_4 st st' res
             (Hspec: map_unmap_ns_spec_low v_0 v_1 v_2 v_3 v_4 st = Some (res, st')),
        exec_func Layer11_layer code "map_unmap_ns"
                  [VInt v_0; VInt v_1; VInt v_2; VInt v_3; VInt v_4]
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

End Layer12_map_unmap_ns_CodeProof.

