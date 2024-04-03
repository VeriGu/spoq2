Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section S2TTInit_s2tt_init_assigned_empty_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Fixpoint s2tt_init_assigned_empty_loop700_low (_N_: nat) (__return__: bool) (v_call: Z) (v_indvars_iv: Z) (v_level: Z) (v_pa_addr_05: Z) (v_s2tt: Ptr) (st: RData) : (option (bool * Z * Z * Z * Z * Ptr * RData)) :=
    match (_N_) with
    | O => (Some (__return__, v_call, v_indvars_iv, v_level, v_pa_addr_05, v_s2tt, st))
    | (S _N_) =>
      match ((s2tt_init_assigned_empty_loop700_low _N_ __return__ v_call v_indvars_iv v_level v_pa_addr_05 v_s2tt st)) with
      | (Some (__return__, v_call, v_indvars_iv, v_level, v_pa_addr_05, v_s2tt, st)) =>
        if __return__
        then (Some (__return__, v_call, v_indvars_iv, v_level, v_pa_addr_05, v_s2tt, st))
        else (
          rely (((v_s2tt.(pbase)) = ("slot_delegated")));
          when v_call2, st == ((s2tte_create_assigned_empty_spec v_pa_addr_05 v_level st));
          let v_arrayidx := (ptr_offset v_s2tt ((8 * (v_indvars_iv)) + (0))) in
          when st == ((store_RData 8 v_arrayidx v_call2 st));
          let v_add := (v_pa_addr_05 + (v_call)) in
          let v_indvars_iv_next := (v_indvars_iv + (1)) in
          let v_exitcond := (v_indvars_iv_next <>? (512)) in
          match (
            if v_exitcond
            then (
              let v_indvars_iv := v_indvars_iv_next in
              let v_pa_addr_05 := v_add in
              (Some (__return__, v_indvars_iv, v_pa_addr_05, st)))
            else (
              when st == ((iasm_4_spec st));
              let __return__ := true in
              (Some (__return__, v_indvars_iv, v_pa_addr_05, st)))
          ) with
          | (Some (__return__, v_indvars_iv, v_pa_addr_05, st)) =>
            if __return__
            then (Some (__return__, v_call, v_indvars_iv, v_level, v_pa_addr_05, v_s2tt, st))
            else (
              let __continue__ := true in
              (Some (__return__, v_call, v_indvars_iv, v_level, v_pa_addr_05, v_s2tt, st)))
          | None => None
          end)
      | None => None
      end
    end.

  Definition s2tt_init_assigned_empty_spec_low (v_s2tt: Ptr) (v_pa: Z) (v_level: Z) (st: RData) : (option RData) :=
    rely (((v_s2tt.(pbase)) = ("slot_delegated")));
    let v_conv := v_level in
    when v_call, st == ((s2tte_map_size_spec v_conv st));
    let v_indvars_iv := 0 in
    let v_pa_addr_05 := v_pa in
    rely (((s2tt_init_assigned_empty_loop700_rank v_call v_indvars_iv v_level v_pa_addr_05 v_s2tt) >= (0)));
    match (
      (s2tt_init_assigned_empty_loop700_low
        (z_to_nat (s2tt_init_assigned_empty_loop700_rank v_call v_indvars_iv v_level v_pa_addr_05 v_s2tt))
        false
        v_call
        v_indvars_iv
        v_level
        v_pa_addr_05
        v_s2tt
        st)
    ) with
    | (Some (__return__, v_call, v_indvars_iv, v_level, v_pa_addr_05, v_s2tt, st)) =>
      if __return__
      then (Some st)
      else (Some st)
    | None => None
    end.

End S2TTInit_s2tt_init_assigned_empty_LowSpec.

#[global] Hint Unfold s2tt_init_assigned_empty_loop700_low: spec.
#[global] Hint Unfold s2tt_init_assigned_empty_spec_low: spec.
