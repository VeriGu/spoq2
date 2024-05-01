Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Helpers.pack_return_code.LowSpec.
Require Import MakeReturnCode.Layer.
Require Import MakeReturnCode.Spec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Helpers_pack_return_code_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opacque make_return_code_spec.
  Local Opacque pack_struct_return_code_spec.
    Lemma f_pack_return_code_correct:
      forall v_status v_index st st' res
             (Hspec: pack_return_code_spec_low v_status v_index st = Some (res, st')),
        exec_func MakeReturnCode_layer code "pack_return_code"
                  [VInt v_status; VInt v_index]
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

End Helpers_pack_return_code_CodeProof.

