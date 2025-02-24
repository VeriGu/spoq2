(* This configuration file reflects what are currently supported by the llvm-version of frontend *)
Definition PROJ_NAME: string := "frontend-v2".
Definition PROJ_BASE: string := "coq/frontend-v2".
Definition PROJ_BC_PATH: string := "./test.c.bc".

Record RData :=
  mkRData {
    x: Z;
    y: Z
  }.

Section Bottom.
  Definition LAYER_DATA := RData.
  Definition LAYER_CODE : string := "./test.json".
  Definition LAYER_PRIMS: list string :=
    "main" ::
    nil.


End Bottom.

Section Layer1.
  Definition LAYER_DATA := RData.
  Definition LAYER_PRIMS: list string :=
    "add" ::
    nil.

  Definition fold_add_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    let v_2 := (v_0 =? (0)) in
    if v_2
    then (Some (0, st))
    else (
      let v_3 := (v_1 =? (1)) in
      if v_3
      then (Some (2, st))
      else (
        let v_4 := (v_1 + (123)) in
        let v_5 := (v_1 >? ((-23))) in
        if v_5
        then (Some (100, st))
        else (
          let v_6 := (v_1 >? ((-73))) in
          if v_6
          then (Some (50, st))
          else (
            let v_7 := (v_1 >? (18446744073709551494)) in
            if v_7
            then (
              let v_8 := (v_1 + (125)) in
              (Some (v_8, st)))
            else (Some (v_4, st)))))).

  (* Definition add_spec_low (v_0: Z) (v_1: Z) (st: RData) : option (Z * RData) :=
    Some (v_0 + v_1, st). *)
    
End Layer1.

Section Layer2.
  Definition LAYER_DATA := RData.
  Definition LAYER_PRIMS: list string :=
    "add_one" ::
    nil.

  (* Definition add_one_spec_low (v_0: Z) (st: RData) : option (Z * RData) :=
    when v_1, st_1 == (add_spec_low v_0 1 st);
    Some (v_1, st_1). *)
End Layer2.