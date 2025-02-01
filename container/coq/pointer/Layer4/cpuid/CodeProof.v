Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer3.Layer.
Require Import Layer4.cpuid.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer4_cpuid_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f_cpuid_correct:
      forall st st' res
             (Hspec: cpuid_spec_low st = Some (res, st')),
        exec_func Layer3_layer code "cpuid"
                  []
                  st st' (Some (VInt res)).
Admitted.

End Layer4_cpuid_CodeProof.

