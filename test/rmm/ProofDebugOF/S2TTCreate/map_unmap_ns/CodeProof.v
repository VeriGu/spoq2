Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import S2TTCreate.map_unmap_ns.LowSpec.
Require Import TableWalk.Layer.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section S2TTCreate_map_unmap_ns_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f_map_unmap_ns_correct:
      forall v_rd_addr v_map_addr v_level v_host_s2tte v_op st st' res
             (Hspec: map_unmap_ns_spec_low v_rd_addr v_map_addr v_level v_host_s2tte v_op st = Some (res, st')),
        exec_func TableWalk_layer code "map_unmap_ns"
                  [VInt v_rd_addr; VInt v_map_addr; VInt v_level; VInt v_host_s2tte; VInt v_op]
                  st st' (Some (VInt res)).
Admitted.

End S2TTCreate_map_unmap_ns_CodeProof.

