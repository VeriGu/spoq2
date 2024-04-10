Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import S2TTInit.Layer.
Require Import SMCHandler.smc_rtt_destroy.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section SMCHandler_smc_rtt_destroy_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f_smc_rtt_destroy_correct:
      forall v_rtt_addr v_rd_addr v_map_addr v_ulevel st st' res
             (Hspec: smc_rtt_destroy_spec_low v_rtt_addr v_rd_addr v_map_addr v_ulevel st = Some (res, st')),
        exec_func S2TTInit_layer code "smc_rtt_destroy"
                  [VInt v_rtt_addr; VInt v_rd_addr; VInt v_map_addr; VInt v_ulevel]
                  st st' (Some (VInt res)).
Admitted.

End SMCHandler_smc_rtt_destroy_CodeProof.

