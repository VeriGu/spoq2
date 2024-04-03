Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import S2TTCreate.Layer.
Require Import S2TTInit.s2tt_init_destroyed.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section S2TTInit_s2tt_init_destroyed_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f_s2tt_init_destroyed_correct:
      forall v_s2tt st st'
             (Hspec: s2tt_init_destroyed_spec_low v_s2tt st = Some st'),
        exec_func S2TTCreate_layer code "s2tt_init_destroyed"
                  [VPtr v_s2tt]
                  st st' None.
Admitted.

End S2TTInit_s2tt_init_destroyed_CodeProof.

