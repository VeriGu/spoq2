(* SPOQ START HERE *)

Definition pvn := Z. (* Provenance *)
Parameter spvn: string -> (Z).
Parameter pvns : Z -> (string).
Definition next_pvn (p: pvn): pvn := p + 1.
(* The value a load yields and a store takes: a 64-bit word.  The model is
   whole-value -- `sz` carries the width -- so this is the widest machine
   integer and a narrower value sign-extends into it.  int64 is Z in Coq, and a
   64-bit bitvector to the solver under SPOQ_BV_SORTS, so a loaded value is a
   bitvector rather than an unbounded integer. *)
Definition Byte := int64.
Definition Block := ((ZMap.t Byte) * intSizeT).
Parameter empty_bks: PMap.t (option Block).
Parameter empty_bk: ZMap.t Byte.
Definition bk := Block.
Record MEM := mkMEM {
  blocks: (PMap.t (option Block));
  nextBlock: pvn
}.
Definition empty_MEM: MEM := mkMEM empty_bks 1.
(* An object is smaller than 2^62 bytes, so a size can be added to or
   subtracted from an offset without leaving the 64-bit range.  The bound is
   assumed of every block size; a pointer offset is not bounded, since an
   argument may carry any value. *)
Definition MAX_OBJECT : intSizeT := 4611686018427387904.
Definition size_in_range (sz: intSizeT) : bool := (0 <=? sz) && (sz <? MAX_OBJECT).
(* The block is keyed by spvn of the new pointer's base, the key every access
   through that pointer looks up, as in realloc.  Allocation always succeeds:
   the pointer is not null. *)
Definition malloc (m: MEM) (sz: intSizeT): option (Ptr * MEM) :=
  let new_mem := mkMEM (m.(blocks) # (spvn (pvns m.(nextBlock))) == (Some (empty_bk,sz))) (next_pvn m.(nextBlock)) in
  let new_ptr := (mkPtr (pvns m.(nextBlock)) 0) in
  rely (size_in_range sz);
  (* The allocation key is unused. *)
  rely ((m.(blocks) @ (spvn (pvns m.(nextBlock)))) = None);
  rely (~((pvns m.(nextBlock)) =s "null"));
  rely (~(is_global_ptr new_ptr));
  rely (~(is_stack_ptr new_ptr));
  Some (new_ptr, new_mem).

(* void *realloc(void *ptr, size_t size); *)
Definition realloc (m: MEM) (p: Ptr) (sz: intSizeT) : option (Ptr * MEM) :=
  if (p.(pbase) =s "null") then (malloc m sz) else
  match (m.(blocks) @ (spvn p.(pbase))) with
  | None => None
  | Some b => match b with
    | (bytemap, old_sz) =>
      if (p.(poffset) =? 0) then
        let new_ptr := (mkPtr (pvns m.(nextBlock)) 0) in
        rely (size_in_range sz);
        rely ((m.(blocks) @ (spvn (pvns m.(nextBlock)))) = None);
        rely (~(is_global_ptr new_ptr));
        rely (~(is_stack_ptr new_ptr));
        Some (new_ptr, mkMEM ((m.(blocks) # (spvn p.(pbase)) == None) # (spvn (pvns m.(nextBlock))) == (Some (bytemap, sz))) (next_pvn m.(nextBlock)))
      else None
    end
  end.

Definition free (m: MEM) (p: Ptr) : option MEM :=
  let deref := m.(blocks) @ (spvn p.(pbase)) in
  match deref with
  | Some deref_bk => Some (mkMEM (m.(blocks) # (spvn p.(pbase)) == None) m.(nextBlock))
  | None => None
  end.

Definition blk_store (b: Block) (p: Ptr) (sz: intSizeT) (v: Byte) : option Block :=
  if (p.(pbase) =s "null") then None else
  match b with
    | (bytemap, bk_sz) => rely (size_in_range bk_sz);
      match (p.(poffset) <=? bk_sz - sz) with
      | false => None
      | true => if (p.(poffset) >=? 0) then
      (* The block keeps the object's size; sz is the width of this store. *)
      Some (bytemap # p.(poffset) == v, bk_sz)
      else None
      end
    end.

Definition blk_load (b: Block) (p: Ptr) (sz: intSizeT) : option Byte :=
  if (p.(pbase) =s "null") then None else
  match b with
    | (bytemap, bk_sz) => rely (size_in_range bk_sz);
      (if (p.(poffset) <=? bk_sz - sz) then
      (if (p.(poffset) >=? 0) then
        (if (sz >? 0) then
          (Some (bytemap @ (p.(poffset))))
        else None)
      else None)
    else None)
    end.

Definition heap_store (m: MEM) (sz: intSizeT) (p: Ptr) (v: int64) : option MEM :=
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

Definition heap_load (m: MEM) (sz: intSizeT) (p: Ptr) : option (Byte) :=
  let pb := (spvn p.(pbase)) in
  let blk := (m.(blocks) @ pb) in
    (match blk with
      | None => None
      | Some b => (blk_load b p sz)
      end).

Definition ptr_add (p: Ptr) (idx: intSizeT) : Ptr :=
  (mkPtr p.(pbase) (p.(poffset) + idx)).

(* Given a heap and a pointer, max_heap_ptr_offset gives the
   number of valid bytes that can be read after that pointer *)
Definition max_heap_ptr_offset (m: MEM) (p: Ptr) : intSizeT :=
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
Definition PROJ_NAME: string := "i1_join_call".
Definition PROJ_BASE: string := "i1_join_call".
Definition PROJ_BC_PATH: string := "i1_join_call.bc".





Definition is_stack_ptr (p: Ptr): bool := (false = true).


Inductive StackVal := 
	| ZMapVal (ZMapValConstr: (ZMap.t (ZMap.t int64)))
	| ZVal (ZValConstr: int64)
.
Definition STACK := (SMap (option StackVal)).

Inductive StackKey := 
| sk_Null.

Record GLOBALS :=
  mkGLOBALS {
    __spoq_dummy_field: Z    }.
Record RData := mkRData {	stack: STACK;	heap: MEM;	globals: GLOBALS}.
Definition is_global_ptr (p: Ptr): bool := (false = true).


Definition global_in_bounds (sz: intSizeT) (p: Ptr) (limit: intSizeT) : bool :=
  (0 <=? p.(poffset)) && (p.(poffset) <=? limit - sz).

Definition load_global (sz: intSizeT) (p: Ptr) (st: RData) : (option int64) :=
  None. (* load_global *)

Definition store_global (sz: intSizeT) (p: Ptr) (v: int64) (st: RData) : option RData :=
  None. (* store_global *)

Definition MIN_GLOBAL : intSizeT := 67108864.
Definition MAX_GLOBAL : intSizeT := 67108864.

Definition global_to_ptr (v: intSizeT) : Ptr := 
 if (v >=? MAX_GLOBAL ) then (mkPtr "null" 0) else
 if (v <? 0 ) then (mkPtr "null" 0) else
   (mkPtr "null" 0).
Parameter int_to_ptr_other : (intSizeT -> (Ptr)).
Definition int_to_ptr (v: intSizeT) : Ptr := 
 if (v =? (0 - 1)) then (mkPtr "null" (0 - 1)) else
 if ((0 <=? v) && (v <? MIN_GLOBAL)) then (mkPtr "null" v) else
 if ((MIN_GLOBAL <=? v) && (v <? MAX_GLOBAL)) then (global_to_ptr v) else
    (int_to_ptr_other v).
Parameter ptr_to_int_other : (Ptr -> (intSizeT)).
Definition ptr_to_int (p: Ptr) : intSizeT := 
 if (p.(poffset) <? 0) then (-1) else
 if (p.(pbase) =s "null") then (if (p.(poffset) <? MIN_GLOBAL) then p.(poffset) else (ptr_to_int_other p)) else
    (ptr_to_int_other p).
Definition ptr_to_int_other_outside_globals : Prop := forall (p: Ptr), (((ptr_to_int_other p) <? MIN_GLOBAL) \/ (MAX_GLOBAL <=? (ptr_to_int_other p))).
Definition ptr_to_int_other_not_null : Prop := forall (p: Ptr), (((ptr_to_int_other p) <? (0 - 1)) \/ (MIN_GLOBAL <=? (ptr_to_int_other p))).
Definition int_to_ptr_other_inverse : Prop := forall (p: Ptr), ((int_to_ptr_other (ptr_to_int_other p)) = p).
Definition ptr_to_int_other_inverse : Prop := forall (v: intSizeT), ((((v <? (0 - 1)) \/ (MAX_GLOBAL <=? v))) -> ((ptr_to_int_other (int_to_ptr_other v)) = v)).

Definition load_stack (sz: intSizeT) (p: Ptr) (stack_map: STACK): (option int64) := 
	match (stack_map @ p.(pbase)) with
		| Some sv => match sv with
			| ZVal ZVal_val => rely (false);
				Some ZVal_val
		end
	| None => None
end. (* load_stack *)
Definition store_stack (sz: intSizeT) (p: Ptr) (v: int64) (stack_map: STACK): (option STACK) := 
	match (stack_map @ p.(pbase)) with
		| Some sv => match sv with
			| ZVal ZVal_val => rely (false);
				Some (stack_map # p.(pbase) == Some(ZVal v))
		end
	| None => None
end. (* store_stack *)
Definition load_stack_ptr (sz: intSizeT) (p: Ptr) (stack_map: STACK): (option Ptr) := 
	match (stack_map @ p.(pbase)) with
		| Some sv => match sv with
			| ZVal ZVal_val => rely (false);
				Some (int_to_ptr ZVal_val)
		end
	| None => None
end. (* load_stack_ptr *)
Definition store_stack_ptr (sz: intSizeT) (p: Ptr) (v: Ptr) (stack_map: STACK): (option STACK) := 
	match (stack_map @ p.(pbase)) with
		| Some sv => match sv with
			| ZVal ZVal_val => rely (false);
				Some (stack_map # p.(pbase) == Some(ZVal (ptr_to_int v)))
		end
	| None => None
end. (* store_stack_ptr *)

Parameter pred_spec : (int32-> (RData-> (option ((Z) * RData)))).

Section Axioms.
  Definition LAYER_DATA := RData.
  (* Definition load_RData_no_effect : Prop := forall (sz: intSizeT) (p: Ptr) (st: RData) (st2: RData) (ret: Z),
     ((load_RData sz p st = Some (ret, st2)) -> (st2 = st)). *)
  Definition int_to_ptr_zero : Prop := (int_to_ptr 0) = (mkPtr "null" 0).
  Definition int_to_ptr_neg_one : Prop := (int_to_ptr (0 - 1)) = (mkPtr "null" (0 - 1)).
  (* Definition pvns_spvn : Prop := forall (p: Provenance), (spvn (pvns p) = p). *) (* This axiom causes false preconditions *)
  (* Definition pvns_not_static_unfold : Prop := forall (p: Provenance), (let pb := pvns p in (~(is_static_pbase pb))). *)
  (* Hint Unfold pvns_not_static_unfold. *)
  (* Definition max_heap_ptr_offset_no_deref_zero (m: MEM) (p: Ptr): Prop :=   *)
    (* ((max_heap_ptr_offset m p) <= 0) -> (forall (sz: intSizeT), ((heap_load m sz p) = None)). *)

(* Definition malloc_not_static: Prop := forall (h: MEM), (let pb := pvns (h.(nextBlock)) in (~(is_static_pbase pb))). *)
End Axioms.

Section Layer1.
    Definition LAYER_STORE: string := "store_RData".
    Definition LAYER_LOAD: string := "load_RData".
    Definition LAYER_PTR2INT: string := "ptr_to_int".
    Definition LAYER_INT2PTR: string := "int_to_ptr".
    Definition LAYER_PTR_EQB: string := "ptr_eqb".
    Definition LAYER_PTR_GTB: string := "ptr_gtb".
    Definition LAYER_PTR_LTB: string := "ptr_ltb".
    Definition LAYER_PRIMS: list string :=
        "pred" ::
        "vuln" ::
        nil.
End Layer1.

Hint CheckInv vuln_spec.
Hint Postcondition vuln_spec (_ret_0 >=? (0)).
Hint Postcondition vuln_spec (_ret_0 <=? (1)).
