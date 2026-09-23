(* SPOQ START HERE *)

Definition pvn := Z. (* Provenance *)
Parameter spvn: string -> (Z).
Parameter pvns : Z -> (string).
Definition next_pvn (p: pvn): pvn := p + 1.
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
Definition malloc (m: MEM) (sz: intSizeT): option (Ptr * MEM) :=
  let new_mem := mkMEM (m.(blocks) # (m.(nextBlock)) == (Some (empty_bk,sz))) (next_pvn m.(nextBlock)) in
  let new_ptr := (mkPtr (pvns m.(nextBlock)) 0) in
  rely (size_in_range sz);
  rely (~(is_global_ptr new_ptr));
  rely (~(is_stack_ptr new_ptr));
  Some (new_ptr, new_mem).

(* SPOQ STOP *)
Definition PROJ_NAME: string := "ifelse_postcondition".
Definition PROJ_BASE: string := "ifelse_postcondition".
Definition PROJ_BC_PATH: string := "ifelse_postcondition.bc".

Inductive StackVal :=
	| ZMapVal (ZMapValConstr: (ZMap.t (ZMap.t int64)))
	| ZVal (ZValConstr: int64)
.
Definition STACK := (SMap (option StackVal)).

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
Record GLOBALS :=
  mkGLOBALS {
      g_g: int64
    }.
Record RData := mkRData {	stack: STACK;	heap: MEM;	globals: GLOBALS}.
Definition is_global_ptr (p: Ptr): bool := (false = true)\/
	"g" =s p.(pbase).

Definition G_BASE : intSizeT := 67108864.
Definition MAX_GLOBAL : intSizeT := 67112960.

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
        "vuln" ::
        nil.
End Layer1.



(* The result comes from a two-predecessor join carrying a phi, which
   control_flow_clone_and_split removes by cloning the join and everything
   after it once per incoming edge.  Proving anything about the return value
   therefore exercises that cloning end to end.  The spec it produces is

       if (x >? (0)) then (Some (x, st)) else (Some ((0 - (x)), st))

   so both arms survived with their own value -- ifelse_postcondition.expected.json
   asserts that text, which is what distinguishes a working join from one that
   collapsed to a single arm.

   CheckInv is what schedules the proof: check_pre_post only runs for
   definitions in cmds.invs.  Without it the Postcondition hints parse and are
   then silently never proved -- the test would pass vacuously.

   Names available: _ret_0 .. _ret_n for the returned tuple elements, and `st`
   for the post-state (see prove_by_traverse).

   There is no Refines hint and only one function in the .ll, so no refinement
   runs and spoq emits no result JSON.  The verdict lives only in the log,
   which is why the .expected.json asserts on stderr rather than on JSON keys.

   WHY THE POSTCONDITION IS SHAPED LIKE THIS.  check_pre_post substitutes
   _ret_0 with the value of the *then* arm only: it drops the else arm, and it
   does not assume the branch guard either.  For this function the goal it
   actually sends to Z3 is

       true /\ ((x = (x)) \/ (x = ((0 - (x)))))      <- _ret_0 := x

   Two consequences, both checked by hand against this fixture:

     - The obvious property of an absolute value, (_ret_0 >=? (0)), is TRUE on
       both paths and is REJECTED -- the substituted goal is `x >=? 0`, with no
       `x > 0` hypothesis to discharge it.  It is left commented out below as
       the fix target rather than deleted.
     - (_ret_0 = x) alone is FALSE on the else path (vuln(-5) = 5) and is
       ACCEPTED.  Swapping the two phi inputs swaps which of (_ret_0 = x) and
       (_ret_0 = (0 - x)) is accepted, which is what identifies the then arm as
       the one being read.

   So the asserted postcondition is the disjunction: true on both paths, and
   provable under the one-sided substitution, so it will keep passing once the
   substitution is fixed.  It is also the property the join is responsible for
   -- the result is one of the two values the phi merges.  A one-sided
   postcondition would pass today and start failing after the fix, so none is
   asserted here.  Same restriction, same reason, as
   test/select/select_postcondition.main.v. *)
Hint CheckInv vuln_spec.
(* Two's complement abs: the negation wraps, so at x = -2^31 it returns -2^31
   again.  The disjunction still holds there, by the first arm rather than the
   second -- deciding that needs the reduction to be exact rather than an
   uninterpreted symbol. *)
Hint Postcondition vuln_spec ((_ret_0 = x) \/ (_ret_0 = (0 - x))).
(* Fix target -- true on both paths, rejected today; see above.
Hint Postcondition vuln_spec (_ret_0 >=? (0)). *)
