Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import S2TTEOps.s2_walk_result_match_ripas.LowSpec.
Require Import S2TTEPA.Layer.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section S2TTEOps_s2_walk_result_match_ripas_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opacque load_RData.
  Local Opacque ptr_offset.
    Lemma f_s2_walk_result_match_ripas_correct:
      forall v_res v_ripas st st' res
             (Hspec: s2_walk_result_match_ripas_spec_low v_res v_ripas st = Some (res, st')),
        exec_func S2TTEPA_layer code "s2_walk_result_match_ripas"
                  [VPtr v_res; VInt v_ripas]
                  st st' (Some (VBool res)).
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

End S2TTEOps_s2_walk_result_match_ripas_CodeProof.

