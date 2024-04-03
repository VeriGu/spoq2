Require Import Bottom.Layer.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import MakeReturnCode.pack_struct_return_code.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section MakeReturnCode_pack_struct_return_code_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f_pack_struct_return_code_correct:
      forall v_return_code_coerce st st' res
             (Hspec: pack_struct_return_code_spec_low v_return_code_coerce st = Some (res, st')),
        exec_func Bottom_layer code "pack_struct_return_code"
                  [VInt v_return_code_coerce]
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

End MakeReturnCode_pack_struct_return_code_CodeProof.

