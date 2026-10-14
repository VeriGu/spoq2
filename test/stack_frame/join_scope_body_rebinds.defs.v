(* Both arms of st_b's join write PtrVal q for the outer q, but the body
   rebinds q before reading st_b.  Replacing the read with PtrVal q there would
   name the new q; body2_spec returns the outer q, which is correct, so this
   verifies only if the replacement is not made under the rebinding. *)
Definition body_spec (c: int32) (d: int32) (st: RData) : (option (Ptr * RData)) :=
  when q, st0 == ((mk_spec st));
  when st_b == (
    if (c =? 0)
    then (Some (st0.[stack] :< ((st0.(stack)) # "stack_type_2" == (Some (PtrVal q)))))
    else (Some (st0.[stack] :< (((st0.(stack)) # "stack_type_2" == (Some (PtrVal q))) # "stack_type_1" == (Some (ZVal 4))))));
  when q, st9 == ((mk_spec st_b));
  match (((st_b.(stack)) @ "stack_type_2")) with
  | (Some sv) =>
    match sv with
    | (ZMapVal z) => None
    | (ZVal z) => None
    | (PtrVal p) => (Some (p, st9))
    end
  | None => None
  end.
Hint Unfold body_spec.

Definition body2_spec (c: int32) (d: int32) (st: RData) : (option (Ptr * RData)) :=
  when q, st0 == ((mk_spec st));
  when st_b == (
    if (c =? 0)
    then (Some (st0.[stack] :< ((st0.(stack)) # "stack_type_2" == (Some (PtrVal q)))))
    else (Some (st0.[stack] :< (((st0.(stack)) # "stack_type_2" == (Some (PtrVal q))) # "stack_type_1" == (Some (ZVal 4))))));
  when q1, st9 == ((mk_spec st_b));
  (Some (q, st9)).
Hint Unfold body2_spec.
