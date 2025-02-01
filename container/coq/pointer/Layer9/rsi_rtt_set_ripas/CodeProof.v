Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer8.Layer.
Require Import Layer9.rsi_rtt_set_ripas.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer9_rsi_rtt_set_ripas_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f_rsi_rtt_set_ripas_correct:
      forall v_0 v_1 v_2 v_3 st st' res
             (Hspec: rsi_rtt_set_ripas_spec_low v_0 v_1 v_2 v_3 st = Some (res, st')),
        exec_func Layer8_layer code "rsi_rtt_set_ripas"
                  [VInt v_0; VInt v_1; VInt v_2; VInt v_3]
                  st st' (Some (VInt res)).
Admitted.

End Layer9_rsi_rtt_set_ripas_CodeProof.

