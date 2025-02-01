Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer4.Layer.
Require Import Layer5.monitor_call.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer5_monitor_call_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f_monitor_call_correct:
      forall v_0 v_1 v_2 v_3 v_4 v_5 v_6 st st' res
             (Hspec: monitor_call_spec_low v_0 v_1 v_2 v_3 v_4 v_5 v_6 st = Some (res, st')),
        exec_func Layer4_layer code "monitor_call"
                  [VInt v_0; VInt v_1; VInt v_2; VInt v_3; VInt v_4; VInt v_5; VInt v_6]
                  st st' (Some (VInt res)).
Admitted.

End Layer5_monitor_call_CodeProof.

