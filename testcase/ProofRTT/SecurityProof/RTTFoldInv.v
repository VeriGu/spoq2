Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import SMCHandler.Spec.
Require Import SecurityProof.SecurityDefs.
Require Import SecurityProof.SecurityLemma.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Lemma smc_rtt_fold_3_inv:
  forall s2_ctx map_addr wi call15 call34 call44 call33 sec_d_init sec_d ret_n sec_d'
    (Hspec: smc_rtt_fold_3 s2_ctx map_addr wi call15 call34 call44 call33 sec_d_init sec_d = Some (ret_n, sec_d'))
    (Hinv: SharedInv sec_d.(share)),
    SharedInv sec_d'.(share).
Admitted.
