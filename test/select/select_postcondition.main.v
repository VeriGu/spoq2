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

(* SPOQ STOP *)
Definition PROJ_NAME: string := "select_postcondition".
Definition PROJ_BASE: string := "select_postcondition".
Definition PROJ_BC_PATH: string := "select_postcondition.bc".

Inductive StackVal := 
	| ZMapVal (ZMapValConstr: (ZMap.t (ZMap.t Z)))
	| ZVal (ZValConstr: Z)
.
Definition STACK := (SMap (option StackVal)).

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

Definition G_BASE : Z := 67108864.
Definition MAX_GLOBAL : Z := 67112960.

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



(* The result comes from a `select`, which control_flow_eliminate_select
   rewrites into a diamond before translation, so proving anything about the
   return value exercises that rewrite end to end.

   CheckInv is what schedules the proof: check_pre_post only runs for
   definitions in cmds.invs.  Without it the Postcondition hints parse and are
   then silently never proved -- the test would pass vacuously.

   Names available: _ret_0 .. _ret_n for the returned tuple elements, and `st`
   for the post-state (see prove_by_traverse).

   There is no Refines hint and only one function in the .ll, so no refinement
   runs and spoq emits no result JSON.  The verdict lives only in the log,
   which is why the .expected.json asserts on stderr rather than on JSON keys.

   These are deliberately true on BOTH paths.  check_pre_post currently proves
   only the `then` branch: for this function it accepts `_ret_0 = 1` (false
   when x <= 0), and swapping the select arms swaps which of `_ret_0 = 0` /
   `_ret_0 = 1` it accepts.  A one-sided postcondition would pass today and
   start failing once that is fixed, so only all-paths-true properties are
   asserted here.

   The rest of this file is the minimum the pipeline needs: it was reduced from
   the 359-line project template by deleting whatever could go without changing
   the result.  The memory model survives only because RData is built from
   STACK / MEM / GLOBALS. *)
Hint CheckInv vuln_spec.
Hint Postcondition vuln_spec ((_ret_0 = (0)) \/ (_ret_0 = (1))).
Hint Postcondition vuln_spec (_ret_0 >=? (0)).
Hint Postcondition vuln_spec (_ret_0 <=? (1)).
