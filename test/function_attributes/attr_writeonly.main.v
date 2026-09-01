(* SPOQ START HERE *)

Definition pvn := Z. (* Provenance *)
Parameter spvn: string -> (Z).
Parameter pvns : Z -> (string).
Definition next_pvn (p: pvn): pvn := p + 1.
Definition Byte := Z.
Definition Block := ((ZMap.t Byte) * Z).
Parameter empty_bks: ZMap.t (option Block).
Parameter empty_bk: ZMap.t Byte.
Definition bk := Block.
Record MEM := mkMEM {
  blocks: (ZMap.t (option Block));
  nextBlock: pvn
}.
Definition empty_MEM: MEM := mkMEM empty_bks 1.
Definition malloc (m: MEM) (sz: Z): option (Ptr * MEM) :=
  let new_mem := mkMEM (m.(blocks) # (m.(nextBlock)) == (Some (empty_bk,sz))) (next_pvn m.(nextBlock)) in
  let new_ptr := (mkPtr (pvns m.(nextBlock)) 0) in
  rely (~(is_global_ptr new_ptr));
  rely (~(is_stack_ptr new_ptr));
  Some (new_ptr, new_mem).

Definition free (m: MEM) (p: Ptr) : option MEM := 
  let deref := m.(blocks) @ (spvn p.(pbase)) in 
  match deref with
  | Some deref_bk => Some (mkMEM (m.(blocks) # (spvn p.(pbase)) == None) m.(nextBlock))
  | None => None
  end.

Definition blk_store (b: Block) (p: Ptr) (sz: Z) (v: Byte) : option Block :=
  if (p.(pbase) =s "null") then None else
  match b with 
    | (bytemap, bk_sz) => match (p.(poffset) + sz <=? bk_sz) with
      | false => None
      | true => if (p.(poffset) >=? 0) then 
      Some (bytemap # p.(poffset) == v, sz)
      else None
      end
    end.

Definition blk_load (b: Block) (p: Ptr) (sz: Z) : option Byte :=
  if (p.(pbase) =s "null") then None else
  match b with 
    | (bytemap, bk_sz) => (if ((p.(poffset) + sz) <=? bk_sz) then 
      (if (p.(poffset) >=? 0) then 
        (if (sz >? 0) then
          (Some (bytemap @ (p.(poffset))))
        else None) 
      else None) 
    else None)
    end.

Definition heap_store (m: MEM) (sz: Z) (p: Ptr) (v: Z) : option MEM :=
  let pb := (spvn p.(pbase)) in 
  let blk := (m.(blocks) @ pb) in 
    (match blk with 
      | None => None
      | Some b => (let new_blk := (blk_store b p sz v) in 
        match new_blk with
        | None => None
        | Some snb => Some (mkMEM (m.(blocks) # pb == (Some snb)) (m.(nextBlock)))
        end)
      end).

Definition heap_load (m: MEM) (sz: Z) (p: Ptr) : option (Byte) := 
  let pb := (spvn p.(pbase)) in 
  let blk := (m.(blocks) @ pb) in 
    (match blk with
      | None => None
      | Some b => (blk_load b p sz)
      end).

Definition ptr_add (p: Ptr) (idx: Z) : Ptr :=
  (mkPtr p.(pbase) (p.(poffset) + idx)).

(* Given a heap and a pointer, max_heap_ptr_offset gives the
   number of valid bytes that can be read after that pointer *)
Definition max_heap_ptr_offset (m: MEM) (p: Ptr) : Z :=
  let blk := (m.(blocks) @ (spvn p.(pbase))) in
    (match blk with
     | None => 0
     | Some b => match b with
      | (bytemap, blk_sz) => (blk_sz - p.(poffset))
      end
      end).

Definition Float := Z.
Definition Double := Z.
Definition Metadata := Z.
  
(* SPOQ STOP *)
Definition PROJ_NAME: string := "attr_writeonly".
Definition PROJ_BASE: string := "attr_writeonly".
Definition PROJ_BC_PATH: string := "attr_writeonly.bc".




Definition is_stack_ptr (p: Ptr): bool := (false = true).


Inductive StackVal := 
	| ZMapVal (ZMapValConstr: (ZMap.t (ZMap.t Z)))
	| ZVal (ZValConstr: Z)
.
Definition STACK := (SMap (option StackVal)).

Inductive StackKey := 
| sk_Null.


Definition load_stack (sz: Z) (p: Ptr) (stack_map: STACK): (option Z) := 
	match (stack_map @ p.(pbase)) with
		| Some sv => match sv with
			| ZVal ZVal_val => rely (false);
				Some ZVal_val
		end
	| None => None
end. (* load_stack *)
Definition store_stack (sz: Z) (p: Ptr) (v: Z) (stack_map: STACK): (option STACK) := 
	match (stack_map @ p.(pbase)) with
		| Some sv => match sv with
			| ZVal ZVal_val => rely (false);
				Some (stack_map # p.(pbase) == Some(ZVal v))
		end
	| None => None
end. (* store_stack *)
Record GLOBALS :=
  mkGLOBALS {
      g_g: Z
    }.
Record RData := mkRData {	stack: STACK;	heap: MEM;	globals: GLOBALS}.
Definition is_global_ptr (p: Ptr): bool := (false = true)\/
	"g" =s p.(pbase).

Definition load_global (sz: Z) (p: Ptr) (st: RData) : (option Z) :=
  if (p.(pbase) =s "g") then (
      Some(st.(globals).(g_g))) else
  None. (* load_global *)

Definition store_global (sz: Z) (p: Ptr) (v: Z) (st: RData) : option RData :=
  if (p.(pbase) =s "g") then (
      Some(st.[globals].[g_g] :< v)) else
  None. (* store_global *)

Definition G_BASE : Z := 67108864.
Definition MAX_GLOBAL : Z := 67112960.

Definition global_to_ptr (v: Z) : Ptr := 
 if (v >=? MAX_GLOBAL ) then (mkPtr "null" 0) else
 if (v <? 0 ) then (mkPtr "null" 0) else
 if (v >=? G_BASE) then (mkPtr "g" (v - G_BASE)) else
   (mkPtr "null" 0).
Definition ptr_to_int (p: Ptr) : Z := 
 if (p.(poffset) <? 0) then (-1) else
 if (p.(pbase) =s "null") then 0 else
 if (p.(pbase) =s "g") then (G_BASE + p.(poffset)) else
    (-1).

Parameter poison_vector: (ZMap.t Z).
Parameter poison_vector_4: (ZMap.t Z).
Parameter undef_vector: (ZMap.t Z).
Parameter undef_vector_4: (ZMap.t Z).
Parameter zeroinitializer_vector: (ZMap.t Z).
(* Definition zeroinitializer_vector: (ZMap.t Z) := fun k => 0. *)

Definition zmap_z_add (a: (ZMap.t Z)) (b: (ZMap.t Z)) : (ZMap.t Z) :=
  (zmap_z_add_inner a b k).

Definition zmap_z_add_inner (a: (ZMap.t Z)) (b: (ZMap.t Z)) (k: Z) : Z :=
  ((a @ k) + (b @ k)).

(* Parameter llvm_vector_reduce_add_v4i32_spec : ((ZMap.t Z) -> ((RData) -> (option ((Z) * RData)))). *)
Definition llvm_vector_reduce_add_v4i32_spec (v: (ZMap.t Z)) (st: RData): option ((Z) * RData) :=
  Some (((v @ 0) + (v @ 1) + (v @ 2) + (v @ 3)), st).


Definition ptr_eqb (p1: Ptr) (p2: Ptr) : bool :=
  (p1.(pbase)) =s (p2.(pbase)) && (p1.(poffset) =? p2.(poffset)).
  (* ptr_to_int p1 =? ptr_to_int p2. *)


Definition ptr_ltb (p1: Ptr) (p2: Ptr) : bool :=
  ptr_to_int p1 <? ptr_to_int p2.
Definition ptr_leb (p1: Ptr) (p2: Ptr) : bool :=
  ptr_to_int p1 <=? ptr_to_int p2.

Definition ptr_gtb (p1: Ptr) (p2: Ptr) : bool :=
  ptr_to_int p1 >? ptr_to_int p2.

Definition ptr_ugt (p1: Ptr) (p2: Ptr) : bool :=
  ptr_to_int p1 >? ptr_to_int p2.
Definition spoq_zext_spec (v_0: bool) : Z := (* used to model LLVM zext *)
  if (v_0) then 1 else 0.

Definition pv_assert_spec (v_0: Z) (st: RData) : (option RData) :=
  let v_1 := (v_0 <>? (0)) in
  if v_1
  then (Some st)
  else None.

Definition exit_spec (v_0: Z) (st: RData) : (option RData) := None.
Definition malloc_spec (sz: Z) (st: RData) : option (Ptr * RData) :=
  let result := (malloc st.(heap) sz) in
  match result with
  | None => None
  | Some (p, m') => Some (p, st.[heap] :< m')
  end.

Definition free_spec (p: Ptr) (st: RData) : option RData :=
  let result := (free st.(heap) p) in
  match result with
  | None => None
  | Some m' => Some (st.[heap] :< m')
  end.

Definition load_RData (sz: Z) (p: Ptr) (st: RData) : (option Z) :=
  if (p.(pbase) =s "null") then None else
  if (is_global_ptr p) then
  match (load_global sz p st) with
  | Some new_st => Some(new_st)
  | None => None
  end else
  if (is_stack_ptr p) then
  match (load_stack sz p st.(stack)) with
    | Some byte => Some(byte)
    | None => None
  end
  else match (heap_load st.(heap) sz p) with
      | None => None
      | Some byte => Some(byte)
  end.

Definition store_RData (sz: Z) (p: Ptr) (v: Z) (st: RData) : option RData :=
  if (p.(pbase) =s "null") then None else
  if (is_global_ptr p) then
    store_global sz p v st
  else
  if (is_stack_ptr p) then
  match (store_stack sz p v st.(stack)) with
    | Some new_stack => Some(st.[stack] :< new_stack)
    | None => None
  end else
  match (heap_store st.(heap) sz p v) with
      | None => None
      | Some new_heap => Some(st.[heap] :< new_heap)
  end.
Hint DelayUnfold load_RData.
Hint DelayUnfold store_RData.
Definition store_stack_bypass (sz: Z) (p: Ptr) (v: Z) (st: RData) : option RData :=
  match (store_stack sz p v st.(stack)) with
    | Some new_stack => Some(st.[stack] :< new_stack)
    | None => None
  end.
Definition load_stack_bypass (sz: Z) (p: Ptr) (st: RData) : (option Z) :=
  load_stack sz p st.(stack).
(*
Definition load_RData (sz: Z) (p: Ptr) (st: RData) : (option Z) :=
  if (is_static_pbase p.(pbase)) then
    (load_static_RData sz p st)
  else match (heap_load st.(heap) sz p) with
  | None => None
  | Some byte => Some(byte)
  end.

Definition store_RData (sz: Z) (p: Ptr) (v: Z) (st: RData) : option RData :=
  if (is_static_pbase p.(pbase)) then
    (store_static_RData  sz p v st)
  else match (heap_store st.(heap) sz p v) with
  | None => None
  | Some new_heap => Some(st.[heap] :< new_heap)
  end. *)

Definition xorb_spec (b1 : bool) (b2 : bool) : bool :=
  if b1 then if b2 then false else true
  else if b2 then true else false.

Section Axioms.
  Definition LAYER_DATA := RData.
  (* Definition load_RData_no_effect : Prop := forall (sz: Z) (p: Ptr) (st: RData) (st2: RData) (ret: Z),
     ((load_RData sz p st = Some (ret, st2)) -> (st2 = st)). *)
  Definition int_to_ptr_zero : Prop := (int_to_ptr 0) = (mkPtr "null" 0).
  Definition int_to_ptr_neg_one : Prop := (int_to_ptr (0 - 1)) = (mkPtr "null" (0 - 1)).
  (* Definition pvns_spvn : Prop := forall (p: Provenance), (spvn (pvns p) = p). *) (* This axiom causes false preconditions *)
  (* Definition pvns_not_static_unfold : Prop := forall (p: Provenance), (let pb := pvns p in (~(is_static_pbase pb))). *)
  (* Hint Unfold pvns_not_static_unfold. *)
  (* Definition max_heap_ptr_offset_no_deref_zero (m: MEM) (p: Ptr): Prop :=   *)
    (* ((max_heap_ptr_offset m p) <= 0) -> (forall (sz: Z), ((heap_load m sz p) = None)). *)

(* Definition malloc_not_static: Prop := forall (h: MEM), (let pb := pvns (h.(nextBlock)) in (~(is_static_pbase pb))). *)
End Axioms.

Parameter global_to_ptr: (Z -> (Ptr)).
Parameter ptr_to_int: (Z -> (Ptr)).

Parameter llvm_memcpy_p0i8_p0i8_i64_spec: (Ptr -> (Ptr -> (Z -> (bool -> (RData -> (option RData)))))).
Parameter llvm_memcpy_p0_p0_i64_spec: (Ptr -> (Ptr -> (Z -> (bool -> (RData -> (option RData)))))).

(* Definition llvm_memcpy_p0i8_p0i8_i64_spec (v_dest: Ptr) (v_src: Ptr) (sz: Z) (is_volatile: bool) (st: RData) : (option RData) :=
    (Some st). *)
Definition llvm_lifetime_start_p0_spec (p: Ptr) (st: RData) : (option RData) := (Some st).
Definition llvm_lifetime_end_p0_spec (p: Ptr) (st: RData) : (option RData) := (Some st).
Definition llvm_assume_spec (b: bool) (st: RData) : (option RData) := st.
(* Parameter io_read_stub (fd: Z) (len: Z) : (Block).
Definition read_spec (fd: Z) (buf: Ptr) (len: Z) (st: RData) : (option RData) :=
  (let (bytemap, read_bytes) := (io_read_stub fd len) in
  (store_RData read_bytes buf
  ). *)

Parameter ext_wo_spec : (RData -> (option ((Z) * RData))).

Section Bottom.
    Definition LAYER_DATA := RData.
    Definition LAYER_PRIMS: list string :=
        "ext_wo" ::
        nil.
End Bottom.

Section Layer1.
    Definition LAYER_STORE: string := "store_RData".
    Definition LAYER_LOAD: string := "load_RData".
    Definition LAYER_PTR2INT: string := "ptr_to_int".
    Definition LAYER_INT2PTR: string := "int_to_ptr".
    Definition LAYER_PTR_EQB: string := "ptr_eqb".
    Definition LAYER_PTR_GTB: string := "ptr_gtb".
    Definition LAYER_PTR_LTB: string := "ptr_ltb".
    Definition LAYER_PRIMS: list string :=
        "patch" ::
        "vuln" ::
        nil.
End Layer1.

Definition patch_correct (st: RData) (st_sim: RData): Prop :=
    st = st_sim
    .

Hint Refines vuln_spec patch_spec patch_correct patch_correct (patch_ret = vuln_ret).
