Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import ExceptionOps.data_create.LowSpec.
Require Import GlobalDefs.
Require Import S2TTInit.Layer.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section ExceptionOps_data_create_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f_data_create_correct:
      forall v_data_addr v_rd_addr v_map_addr v_g_src v_flags st st' res
             (Hspec: data_create_spec_low v_data_addr v_rd_addr v_map_addr v_g_src v_flags st = Some (res, st')),
        exec_func S2TTInit_layer code "data_create"
                  [VInt v_data_addr; VInt v_rd_addr; VInt v_map_addr; VPtr v_g_src; VInt v_flags]
                  st st' (Some (VInt res)).
Admitted.

End ExceptionOps_data_create_CodeProof.

