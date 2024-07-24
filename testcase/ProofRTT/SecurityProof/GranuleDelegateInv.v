Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import SMCHandler.Spec.
Require Import SecurityProof.SecurityDefs.
Require Import SecurityProof.SecurityLemma.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Lemma smc_granule_delegate_inv:
  forall norm_d v_addr ret_n norm_d'
    (Hspec: smc_granule_delegate_spec v_addr norm_d = Some (ret_n, norm_d'))
    (Hinv: SharedInv norm_d.(share)),
    SharedInv norm_d'.(share).
(*

      - inv Hinv.
        constructor; simpl; repeat rewrite lens_same; simpl.
        + unfold gpt_false_ns in *. simpl.
          intros. destruct_zmap; subst; simpl; apply gpt_false_ns_inv0; assumption.
        + unfold delegated_zero in *. simpl; intros.
          destruct_zmap' Hdel; subst; simpl; apply delegated_zero_inv0; assumption.
        + unfold rtt_prop in *. simpl; intros.
          erewrite walk_rtt_same in Hwalk.
          eapply rtt_prop_inv0 in Hwalk.
          destruct_zmap; simpl; subst; assumption.
          destruct_zmap' Hrd; simpl in *; subst; assumption.
          intros. simpl in *. reflexivity.

 *)
Admitted.
