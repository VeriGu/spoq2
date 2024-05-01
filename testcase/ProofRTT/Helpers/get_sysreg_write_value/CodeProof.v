Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Helpers.get_sysreg_write_value.LowSpec.
Require Import MakeReturnCode.Layer.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Helpers_get_sysreg_write_value_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opacque load_RData.
  Local Opacque ptr_offset.
    Lemma f_get_sysreg_write_value_correct:
      forall v_rec v_esr st st' res
             (Hspec: get_sysreg_write_value_spec_low v_rec v_esr st = Some (res, st')),
        exec_func MakeReturnCode_layer code "get_sysreg_write_value"
                  [VPtr v_rec; VInt v_esr]
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

End Helpers_get_sysreg_write_value_CodeProof.

