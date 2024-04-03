Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import TableAux.Layer.
Require Import TableWalk.rtt_walk_lock_unlock.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section TableWalk_rtt_walk_lock_unlock_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f_rtt_walk_lock_unlock_correct:
      forall v_g_root v_start_level v_ipa_bits v_map_addr v_level v_wi st st'
             (Hspec: rtt_walk_lock_unlock_spec_low v_g_root v_start_level v_ipa_bits v_map_addr v_level v_wi st = Some st'),
        exec_func TableAux_layer code "rtt_walk_lock_unlock"
                  [VPtr v_g_root; VInt v_start_level; VInt v_ipa_bits; VInt v_map_addr; VInt v_level; VPtr v_wi]
                  st st' None.
Admitted.

End TableWalk_rtt_walk_lock_unlock_CodeProof.

