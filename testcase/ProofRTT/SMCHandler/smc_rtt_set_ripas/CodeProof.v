Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import ExceptionOps.Layer.
Require Import GlobalDefs.
Require Import SMCHandler.smc_rtt_set_ripas.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section SMCHandler_smc_rtt_set_ripas_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f_smc_rtt_set_ripas_correct:
      forall v_rd_addr v_rec_addr v_map_addr v_ulevel v_uripas st st' res
             (Hspec: smc_rtt_set_ripas_spec_low v_rd_addr v_rec_addr v_map_addr v_ulevel v_uripas st = Some (res, st')),
        exec_func ExceptionOps_layer code "smc_rtt_set_ripas"
                  [VInt v_rd_addr; VInt v_rec_addr; VInt v_map_addr; VInt v_ulevel; VInt v_uripas]
                  st st' (Some (VInt res)).
Admitted.

End SMCHandler_smc_rtt_set_ripas_CodeProof.

