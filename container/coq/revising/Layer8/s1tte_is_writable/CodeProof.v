Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer7.Layer.
Require Import Layer8.s1tte_is_writable.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer8_s1tte_is_writable_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f_s1tte_is_writable_correct:
      forall v_0 st st' res
             (Hspec: s1tte_is_writable_spec_low v_0 st = Some (res, st')),
        exec_func Layer7_layer code "s1tte_is_writable"
                  [VInt v_0]
                  st st' (Some (VBool res)).
Admitted.

End Layer8_s1tte_is_writable_CodeProof.

