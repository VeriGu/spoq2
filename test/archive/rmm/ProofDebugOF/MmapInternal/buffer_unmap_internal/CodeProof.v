Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import GranuleInfo.Spec.
Require Import LockGranules.Layer.
Require Import MmapInternal.buffer_unmap_internal.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section MmapInternal_buffer_unmap_internal_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque get_cached_llt_info_spec.
  Local Opaque iasm_10_spec.
  Local Opaque ptr_to_int.
  Local Opaque xlat_unmap_memory_page_spec.
    Lemma f_buffer_unmap_internal_correct:
      forall v_buf st st'
             (Hspec: buffer_unmap_internal_spec_low v_buf st = Some st'),
        exec_func LockGranules_layer code "buffer_unmap_internal"
                  [VPtr v_buf]
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

End MmapInternal_buffer_unmap_internal_CodeProof.

