Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import SMCHandler.Spec.
Require Import SecurityProof.SecurityDefs.
Require Import SecurityProof.SecurityLemma.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Lemma smc_granule_undelegate_inv:
  forall norm_d v_addr ret_n norm_d'
    (Hspec: smc_granule_undelegate_spec v_addr norm_d = Some (ret_n, norm_d'))
    (Hinv: SharedInv norm_d.(share)),
    SharedInv norm_d'.(share).
Admitted.
