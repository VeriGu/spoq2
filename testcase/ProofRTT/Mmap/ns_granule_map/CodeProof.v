Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Mmap.ns_granule_map.LowSpec.
Require Import MmapInternal.Layer.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Mmap_ns_granule_map_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f_ns_granule_map_correct:
      forall v_slot v_granule st st' res
             (Hspec: ns_granule_map_spec_low v_slot v_granule st = Some (res, st')),
        exec_func MmapInternal_layer code "ns_granule_map"
                  [VInt v_slot; VPtr v_granule]
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

End Mmap_ns_granule_map_CodeProof.

