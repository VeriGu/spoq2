Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import GranuleLock.Spec.
Require Import Helpers.Spec.
Require Import InvalidatePages.Spec.
Require Import Mmap.Spec.
Require Import S2TTEState.Spec.
Require Import TableWalk.Spec.
Require Import ValidateAddr.Spec.
Require Import ValidateTable.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section S2TTCreate_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2tte_create_valid_spec' (v_pa: Z) (v_level: Z) : (option Z) :=
    if (v_level =? (3))
    then (Some (v_pa |' (2011)))
    else (Some (v_pa |' (2009))).

  Definition s2tte_create_valid_spec (v_pa: Z) (v_level: Z) (st: RData) : (option (Z * RData)) :=
    when ret == ((s2tte_create_valid_spec' v_pa v_level));
    (Some (ret, st)).

  Definition s2tte_get_ripas_spec' (v_s2tte: Z) : (option Z) :=
    if ((v_s2tte & (64)) =? (0))
    then (Some 0)
    else (Some 1).

  Definition s2tte_get_ripas_spec (v_s2tte: Z) (st: RData) : (option (Z * RData)) :=
    when ret == ((s2tte_get_ripas_spec' v_s2tte));
    (Some (ret, st)).
End S2TTCreate_Spec.

#[global] Hint Unfold s2tte_get_ripas_spec: spec.
#[global] Hint Unfold s2tte_create_valid_spec: spec.
