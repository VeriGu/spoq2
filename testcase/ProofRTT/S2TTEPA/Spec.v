Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section S2TTEPA_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2tte_pa_table_spec (v_s2tte: Z) (v_level: Z) (st: RData) : (option (Z * RData)) :=
    (Some (((v_s2tte & (281474976710655)) & (((- 1) << ((66 & (4294967295)))))), st)).

  Definition s2tte_pa_spec (v_s2tte: Z) (v_level: Z) (st: RData) : (option (Z * RData)) :=
    (Some (((v_s2tte & (281474976710655)) & (((- 1) << (((39 + ((38654705655 * (v_level)))) & (4294967295)))))), st)).

  Definition s2tte_map_size_spec (v_level: Z) (st: RData) : (option (Z * RData)) :=
    (Some ((1 << ((39 + (((- 9) * (v_level)))))), st)).

  Definition s2tte_create_ripas_spec' (v_ripas: Z) : (option Z) :=
    if (v_ripas =? (0))
    then (Some 0)
    else (Some 64).

  Definition s2tte_create_ripas_spec (v_ripas: Z) (st: RData) : (option (Z * RData)) :=
    when ret == ((s2tte_create_ripas_spec' v_ripas));
    (Some (ret, st)).

  Definition s2tte_create_assigned_empty_spec (v_pa: Z) (v_level: Z) (st: RData) : (option (Z * RData)) :=
    (Some ((v_pa |' (4)), st)).

End S2TTEPA_Spec.

Opaque s2tte_create_ripas_spec'.
#[global] Hint Unfold s2tte_pa_table_spec: spec.
#[global] Hint Unfold s2tte_pa_spec: spec.
#[global] Hint Unfold s2tte_map_size_spec: spec.
#[global] Hint Unfold s2tte_create_assigned_empty_spec: spec.
#[global] Hint Unfold s2tte_create_ripas_spec: spec.
