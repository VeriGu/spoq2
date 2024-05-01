Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import RealmInfo.Layer.
Require Import RealmInfo.Spec.
Require Import ValidateAddr.addr_in_par.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section ValidateAddr_addr_in_par_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opacque rd_is_locked.
  Local Opacque realm_par_size_spec.
    Lemma f_addr_in_par_correct:
      forall v_rd v_addr st st' res
             (Hspec: addr_in_par_spec_low v_rd v_addr st = Some (res, st')),
        exec_func RealmInfo_layer code "addr_in_par"
                  [VPtr v_rd; VInt v_addr]
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

End ValidateAddr_addr_in_par_CodeProof.

