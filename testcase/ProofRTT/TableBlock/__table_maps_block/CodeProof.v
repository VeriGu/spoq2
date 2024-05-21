Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import S2TTCreate.Layer.
Require Import TableBlock.__table_maps_block.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section TableBlock___table_maps_block_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f___table_maps_block_correct:
      forall v_table v_level v_s2tte_is_x st st' res
             (Hspec: __table_maps_block_spec_low v_table v_level v_s2tte_is_x st = Some (res, st')),
        exec_func S2TTCreate_layer code "__table_maps_block"
                  [VPtr v_table; VInt v_level; VPtr v_s2tte_is_x]
                  st st' (Some (VBool res)).
Admitted.

End TableBlock___table_maps_block_CodeProof.

