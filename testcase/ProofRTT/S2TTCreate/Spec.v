Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section S2TTCreate_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2tte_get_ripas_spec (v_s2tte: Z) (st: RData) : (option (Z * RData)) :=
    if ((v_s2tte & (64)) =? (0))
    then (Some (0, st))
    else (Some (1, st)).

  Definition s2tte_create_table_spec (v_pa: Z) (v_level: Z) (st: RData) : (option (Z * RData)) :=
    (Some ((v_pa |' (3)), st)).

  Definition s2tte_create_valid_spec (v_pa: Z) (v_level: Z) (st: RData) : (option (Z * RData)) :=
    if (v_level =? (3))
    then (Some ((v_pa |' (2011)), st))
    else (Some ((v_pa |' (2009)), st)).

End S2TTCreate_Spec.

#[global] Hint Unfold s2tte_get_ripas_spec: spec.
#[global] Hint Unfold s2tte_create_table_spec: spec.
#[global] Hint Unfold s2tte_create_valid_spec: spec.
