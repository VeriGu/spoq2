Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section S2TTInit_s2tt_init_unassigned_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Fixpoint s2tt_init_unassigned_loop0_low (_N_: nat) (__return__: bool) (v_call: Z) (v_index: Z) (v_s2tt: Ptr) (st: RData) : (option (bool * Z * Z * Ptr * RData)) :=
    match (_N_) with
    | O => (Some (__return__, v_call, v_index, v_s2tt, st))
    | (S _N_) =>
      match ((s2tt_init_unassigned_loop0_low _N_ __return__ v_call v_index v_s2tt st)) with
      | (Some (__return__, v_call, v_index, v_s2tt, st)) =>
        if __return__
        then (Some (__return__, v_call, v_index, v_s2tt, st))
        else (
          rely (((v_s2tt.(pbase)) = ("slot_delegated")));
          let v_induction5 := (v_index + (1)) in
          let v_0 := (ptr_offset v_s2tt ((8 * (v_index)) + (0))) in
          let v_1 := (ptr_offset v_s2tt ((8 * (v_induction5)) + (0))) in
          when st == ((store_RData 8 v_0 v_call st));
          when st == ((store_RData 8 v_1 v_call st));
          let v_index_next := (v_index + (2)) in
          let v_2 := (v_index_next =? (512)) in
          match (
            if v_2
            then (
              when st == ((iasm_4_spec st));
              let __return__ := true in
              (Some (__return__, v_index, st)))
            else (
              let v_index := v_index_next in
              (Some (__return__, v_index, st)))
          ) with
          | (Some (__return__, v_index, st)) =>
            if __return__
            then (Some (__return__, v_call, v_index, v_s2tt, st))
            else (
              let __continue__ := true in
              (Some (__return__, v_call, v_index, v_s2tt, st)))
          | None => None
          end)
      | None => None
      end
    end.

  Definition s2tt_init_unassigned_spec_low (v_s2tt: Ptr) (v_ripas: Z) (st: RData) : (option RData) :=
    rely (((v_s2tt.(pbase)) = ("slot_delegated")));
    when v_call, st == ((s2tte_create_unassigned_spec v_ripas st));
    let v_index := 0 in
    rely (((s2tt_init_unassigned_loop0_rank v_call v_index v_s2tt) >= (0)));
    match ((s2tt_init_unassigned_loop0_low (z_to_nat (s2tt_init_unassigned_loop0_rank v_call v_index v_s2tt)) false v_call v_index v_s2tt st)) with
    | (Some (__return__, v_call, v_index, v_s2tt, st)) =>
      if __return__
      then (Some st)
      else (Some st)
    | None => None
    end.

End S2TTInit_s2tt_init_unassigned_LowSpec.

#[global] Hint Unfold s2tt_init_unassigned_loop0_low: spec.
#[global] Hint Unfold s2tt_init_unassigned_spec_low: spec.
