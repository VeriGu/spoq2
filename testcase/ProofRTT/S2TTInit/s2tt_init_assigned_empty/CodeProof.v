Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import RTTFold.Layer.
Require Import S2TTInit.s2tt_init_assigned_empty.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section S2TTInit_s2tt_init_assigned_empty_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f_s2tt_init_assigned_empty_correct:
      forall v_s2tt v_pa v_level st st'
             (Hspec: s2tt_init_assigned_empty_spec_low v_s2tt v_pa v_level st = Some st'),
        exec_func RTTFold_layer code "s2tt_init_assigned_empty"
                  [VPtr v_s2tt; VInt v_pa; VInt v_level]
                  st st' None.
Admitted.

End S2TTInit_s2tt_init_assigned_empty_CodeProof.

