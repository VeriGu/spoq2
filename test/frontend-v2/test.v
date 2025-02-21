(* This configuration file reflects what are currently supported by the llvm-version of frontend *)
Definition PROJ_NAME: string := "frontend-v2".
Definition PROJ_BASE: string := "coq/frontend-v2".
Definition PROJ_BC_PATH: string := "./test.c.bc"

Record RData :=
  mkRData {
    x: Z;
    y: Z
  }.

Section Bottom.
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

  Definition add_spec_low (v_0: Z) (v_1: Z) (st: RData) : option (Z * RData) :=
    Some (v_0 + v_1, st).
    
End Layer1.

Section Layer2.
  Definition LAYER_DATA := RData.
  Definition LAYER_PRIMS: list string :=
    "add_one" ::
    nil.

  Definition add_one_spec_low (v_0: Z) (st: RData) : option (Z * RData) :=
    when v_1, st_1 == (add_spec_low v_0 1 st);
    Some (v_1, st_1).
End Layer2.