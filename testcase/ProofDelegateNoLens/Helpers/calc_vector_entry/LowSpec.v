Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Helpers_calc_vector_entry_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition calc_vector_entry_spec_low (v_vbar: Z) (v_spsr: Z) (st: RData) : (option (Z * RData)) :=
    let v_and := (v_spsr & (15)) in
    let v_cmp := (v_and =? (5)) in
    when v_offset_0, st == (
        let v_offset_0 := 0 in
        if v_cmp
        then (
          let v_offset_0 := 512 in
          (Some (v_offset_0, st)))
        else (
          let v_cmp2 := (v_and =? (4)) in
          when v_offset_0, st == (
              let v_offset_0 := 0 in
              if v_cmp2
              then (
                let v_offset_0 := 0 in
                (Some (v_offset_0, st)))
              else (
                let v_cmp6 := (v_and =? (0)) in
                when v_offset_0, st == (
                    let v_offset_0 := 0 in
                    if v_cmp6
                    then (
                      let v_and8 := (v_spsr & (16)) in
                      let v_cmp9 := (v_and8 =? (0)) in
                      when v_offset_0, st == (
                          let v_offset_0 := 0 in
                          if v_cmp9
                          then (
                            let v_offset_0 := 1024 in
                            (Some (v_offset_0, st)))
                          else (
                            let v_offset_0 := 1536 in
                            (Some (v_offset_0, st))));
                      (Some (v_offset_0, st)))
                    else (
                      let v_offset_0 := 0 in
                      (Some (v_offset_0, st))));
                (Some (v_offset_0, st))));
          (Some (v_offset_0, st))));
    let v_add := (v_offset_0 + (v_vbar)) in
    let __return__ := true in
    let __retval__ := v_add in
    (Some (__retval__, st)).

End Helpers_calc_vector_entry_LowSpec.

#[global] Hint Unfold calc_vector_entry_spec_low: spec.
