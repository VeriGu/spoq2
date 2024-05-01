Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Helpers.Spec.
Require Import InvalidatePages.Layer.
Require Import Mmap.Spec.
Require Import S2TTEDesc.__table_get_entry.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section S2TTEDesc___table_get_entry_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opacque ST_GRANULE_SIZE.
  Local Opacque __tte_read_spec.
  Local Opacque buffer_unmap_spec.
  Local Opacque granule_map_spec.
  Local Opacque ptr_offset.
    Lemma f___table_get_entry_correct:
      forall v_g_tbl v_idx st st' res
             (Hspec: __table_get_entry_spec_low v_g_tbl v_idx st = Some (res, st')),
        exec_func InvalidatePages_layer code "__table_get_entry"
                  [VPtr v_g_tbl; VInt v_idx]
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

End S2TTEDesc___table_get_entry_CodeProof.

