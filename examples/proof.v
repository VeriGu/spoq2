Definition PROJ_NAME: string := "Example.Proof".
Definition PROJ_BASE: string := "./Proof".

Hint NoHighSpec true.

(* Machine state *)
Record s_result :=
 mks_result {
    e_add : Z;
    e_sub : Z
  }.

Definition load_s_result (sz: Z) (ofs: Z) (st: s_result) : option Z :=
  if (ofs =? 0) then Some (st.(e_add)) else
  if (ofs =? 4) then Some (st.(e_sub)) else
  None.

Definition store_s_result (sz: Z) (ofs: Z) (v: Z) (st: s_result) : option s_result :=
  if (ofs =? 0) then Some (st.[e_add] :< v) else
  if (ofs =? 4) then Some (st.[e_sub] :< v) else
  None.

Record RData :=
  mkRData {
      result: s_result
    }.

(* Layer interface *)
Definition load_RData (sz: Z) (p: Ptr) (st: RData) : (option (Z * RData)) :=
  if (p.(pbase) =s "res") then
    when res == load_s_result sz p.(poffset) st.(result);
    Some (res, st)
  else None.


Definition store_RData (sz: Z) (p: Ptr) (v: Z) (st: RData) : option RData :=
  if (p.(pbase) =s "res") then
    when new_res == _s_result sz p.(poffset) v st.(result);
    Some (st.[result] :< new_res)
  else None.

Definition int_to_ptr (v: Z) : Ptr := (mkPtr "null" 0).
Definition ptr_to_int (p: Ptr) : Z := 0.
Definition ptr_eqb (p1: Ptr) (p2: Ptr) : bool := true.
Definition ptr_ltb (p1: Ptr) (p2: Ptr) : bool := true.
Definition ptr_gtb (p1: Ptr) (p2: Ptr) : bool := true.
Definition alloc_stack (sz: Z) (ofs: Z) (st: RData) : option (Ptr * RData) :=
  Some ((mkPtr "bad_stack" 0), st).
Definition free_stack (p: Ptr) (st: RData) : option RData := Some st.

Section Bottom.
  Definition LAYER_DATA := RData.
  Definition LAYER_CODE : string := "./example.json".
  Definition LAYER_LOAD : string := "load_RData".
  Definition LAYER_STORE : string := "store_RData".
  Definition LAYER_PRIMS: list string :=
    "alloc" ::
      nil.

  Definition alloc_spec (st: RData) : option (Ptr * RData) := Some ((mkPtr "null" 0), st).
End Bottom.

Section AddSub.
  Definition LAYER_DATA := RData.
  Definition LAYER_CODE : string := "./example.json".
  Definition LAYER_LOAD : string := "load_RData".
  Definition LAYER_STORE : string := "store_RData".
  Definition LAYER_ALLOC : string := "alloc_stack".
  Definition LAYER_FREE : string := "free_stack".
  Definition LAYER_PTR2INT : string := "ptr_to_int".
  Definition LAYER_INT2PTR : string := "int_to_ptr".
  Definition LAYER_PTR_EQB : string := "ptr_eqb".
  Definition LAYER_PTR_GTB : string := "ptr_gtb".
  Definition LAYER_PTR_LTB : string := "ptr_ltb".
  Definition LAYER_PRIMS: list string :=
    "add" ::
      "sub" ::
      nil.
End AddSub.

Section Main.
  Definition LAYER_DATA := RData.
  Definition LAYER_CODE : string := "./example.json".
  Definition LAYER_LOAD : string := "load_RData".
  Definition LAYER_STORE : string := "store_RData".
  Definition LAYER_ALLOC : string := "alloc_stack".
  Definition LAYER_FREE : string := "free_stack".
  Definition LAYER_PTR2INT : string := "ptr_to_int".
  Definition LAYER_INT2PTR : string := "int_to_ptr".
  Definition LAYER_PTR_EQB : string := "ptr_eqb".
  Definition LAYER_PTR_GTB : string := "ptr_gtb".
  Definition LAYER_PTR_LTB : string := "ptr_ltb".
  Definition LAYER_PRIMS: list string :=
    "add_sub" ::
      nil.
End Main.
