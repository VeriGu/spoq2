Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import GranuleInfo.Spec.
Require Import LockGranules.Layer.
Require Import MmapInternal.buffer_map_internal.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section MmapInternal_buffer_map_internal_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque get_cached_llt_info_spec.
  Local Opaque int_to_ptr.
  Local Opaque mkPtr.
  Local Opaque slot_to_va_spec.
  Local Opaque xlat_map_memory_page_with_attrs_spec.
    Lemma f_buffer_map_internal_correct:
      forall v_slot v_addr st st' res
             (Hspec: buffer_map_internal_spec_low v_slot v_addr st = Some (res, st')),
        exec_func LockGranules_layer code "buffer_map_internal"
                  [VInt v_slot; VInt v_addr]
                  st st' (Some (VPtr res)).
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

End MmapInternal_buffer_map_internal_CodeProof.

