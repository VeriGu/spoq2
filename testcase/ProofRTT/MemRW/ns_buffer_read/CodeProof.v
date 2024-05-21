Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import MemRW.ns_buffer_read.LowSpec.
Require Import Mmap.Layer.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section MemRW_ns_buffer_read_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f_ns_buffer_read_correct:
      forall v_slot v_ns_gr v_offset v_size v_dest st st' res
             (Hspec: ns_buffer_read_spec_low v_slot v_ns_gr v_offset v_size v_dest st = Some (res, st')),
        exec_func Mmap_layer code "ns_buffer_read"
                  [VInt v_slot; VPtr v_ns_gr; VInt v_offset; VInt v_size; VPtr v_dest]
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

End MemRW_ns_buffer_read_CodeProof.

