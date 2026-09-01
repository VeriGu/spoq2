Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import LockGranules.Layer.
Require Import MmapInternal.granule_addr.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section MmapInternal_granule_addr_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque ST_GRANULE_SIZE.
  Local Opaque mkPtr.
  Local Opaque plat_granule_idx_to_addr_spec.
  Local Opaque ptr_to_int.
    Lemma f_granule_addr_correct:
      forall v_g st st' res
             (Hspec: granule_addr_spec_low v_g st = Some (res, st')),
        exec_func LockGranules_layer code "granule_addr"
                  [VPtr v_g]
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

End MmapInternal_granule_addr_CodeProof.

