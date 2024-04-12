Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import MapHelper.xlat_map_memory_page_with_attrs.LowSpec.
Require Import XLat_Helper.Layer.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section MapHelper_xlat_map_memory_page_with_attrs_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f_xlat_map_memory_page_with_attrs_correct:
      forall v_table v_va v_pa v_attrs st st' res
             (Hspec: xlat_map_memory_page_with_attrs_spec_low v_table v_va v_pa v_attrs st = Some (res, st')),
        exec_func XLat_Helper_layer code "xlat_map_memory_page_with_attrs"
                  [VPtr v_table; VInt v_va; VInt v_pa; VInt v_attrs]
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

End MapHelper_xlat_map_memory_page_with_attrs_CodeProof.

