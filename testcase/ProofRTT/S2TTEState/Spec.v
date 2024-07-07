Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import S2TTEDesc.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section S2TTEState_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2tte_is_assigned_spec (v_s2tte: Z) (v_level: Z) (st: RData) : (option (bool * RData)) :=
    if ((v_s2tte & (3)) =? (0))
    then (
      if (((v_s2tte & (60)) - (4)) =? (0))
      then (Some (true, st))
      else (Some (false, st)))
    else (Some (false, st)).

  Definition s2tte_is_unassigned_spec (v_s2tte: Z) (st: RData) : (option (bool * RData)) :=
    when ret == ((s2tte_has_hipas_spec' v_s2tte 0));
    (Some (ret, st)).

  Definition s2tte_is_valid_spec (v_s2tte: Z) (v_level: Z) (st: RData) : (option (bool * RData)) :=
    if ((v_s2tte & (36028797018963968)) =? (0))
    then (
      if ((v_level =? (3)) && (((v_s2tte & (3)) =? (3))))
      then (Some (true, st))
      else (
        if ((v_level =? (2)) && (((v_s2tte & (3)) =? (1))))
        then (Some (true, st))
        else (Some (false, st))))
    else (Some (false, st)).

  Definition s2tte_is_valid_ns_spec (v_s2tte: Z) (v_level: Z) (st: RData) : (option (bool * RData)) :=
    when ret == ((s2tte_check_spec' v_s2tte v_level 36028797018963968));
    (Some (ret, st)).

  Definition s2tte_is_table_spec (v_s2tte: Z) (v_level: Z) (st: RData) : (option (bool * RData)) :=
    (Some (((v_level <? (3)) && (((v_s2tte & (3)) =? (3)))), st)).

  Definition s2tte_is_destroyed_spec (v_s2tte: Z) (st: RData) : (option (bool * RData)) :=
    if ((v_s2tte & (3)) =? (0))
    then (
      if (((v_s2tte & (60)) - (8)) =? (0))
      then (Some (true, st))
      else (Some (false, st)))
    else (Some (false, st)).

  Definition host_ns_s2tte_spec (v_s2tte: Z) (v_level: Z) (st: RData) : (option (Z * RData)) :=
    (Some (
      (((((- 1) & (281474976710655)) & (((- 1) << (((((((v_level * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |' (988)) &
        (v_s2tte))  ,
      st
    )).

  Definition host_ns_s2tte_is_valid_spec' (v_s2tte: Z) (v_level: Z) : (option bool) :=
    if (((Z.lxor ((((- 1) & (281474976710655)) & (((- 1) << (((39 + ((38654705655 * (v_level)))) & (4294967295)))))) |' (988)) (- 1)) & (v_s2tte)) =? (0))
    then (
      if ((v_s2tte & (28)) =? (16))
      then (Some false)
      else (
        if ((v_s2tte & (768)) =? (256))
        then (Some false)
        else (Some true)))
    else (Some false).

  Definition host_ns_s2tte_is_valid_spec (v_s2tte: Z) (v_level: Z) (st: RData) : (option (bool * RData)) :=
    when ret == ((host_ns_s2tte_is_valid_spec' v_s2tte v_level));
    (Some (ret, st)).

  Definition table_entry_to_phys_spec (v_entry1: Z) (st: RData) : (option (Z * RData)) :=
    (Some (((v_entry1 & (281474976710655)) & (((- 1) << ((66 & (4294967295)))))), st)).

  Definition addr_is_level_aligned_spec (v_addr: Z) (v_level: Z) (st: RData) : (option (bool * RData)) :=
    (Some (((((v_addr & (281474976710655)) & (((- 1) << (((39 + ((38654705655 * (v_level)))) & (4294967295)))))) - (v_addr)) =? (0)), st)).

End S2TTEState_Spec.

Opaque host_ns_s2tte_is_valid_spec'.
#[global] Hint Unfold s2tte_is_assigned_spec: spec.
#[global] Hint Unfold s2tte_is_unassigned_spec: spec.
#[global] Hint Unfold s2tte_is_valid_spec: spec.
#[global] Hint Unfold s2tte_is_valid_ns_spec: spec.
#[global] Hint Unfold s2tte_is_table_spec: spec.
#[global] Hint Unfold s2tte_is_destroyed_spec: spec.
#[global] Hint Unfold host_ns_s2tte_spec: spec.
#[global] Hint Unfold host_ns_s2tte_is_valid_spec: spec.
#[global] Hint Unfold table_entry_to_phys_spec: spec.
#[global] Hint Unfold addr_is_level_aligned_spec: spec.
