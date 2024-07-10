Require Import Bottom.Spec.
Require Import CheckFeature.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import MemRW.Layer.
Require Import RealmCreate.vmid_free.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section RealmCreate_vmid_free_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opacque atomic_bit_clear_release_64_spec.
  Local Opacque is_feat_vmid16_present_spec.
  Local Opacque mkPtr.
  Local Opacque ptr_offset.
    Lemma f_vmid_free_correct:
      forall v_vmid st st'
             (Hspec: vmid_free_spec_low v_vmid st = Some st'),
        exec_func MemRW_layer code "vmid_free"
                  [VInt v_vmid]
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

End RealmCreate_vmid_free_CodeProof.

