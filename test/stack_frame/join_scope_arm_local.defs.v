(* Each arm of st_b's join writes PtrVal q for an arm-local q, and an outer q
   is in scope at the join.  The values are equal as terms but name different
   bindings, so the read of st_b is not replaced by PtrVal q (the outer one);
   body2_spec is what that replacement would give, and does not verify. *)
Definition body_spec (c: int32) (d: int32) (st: RData) : (option (Ptr * RData)) :=
  when q, st0 == ((mk_spec st));
  when st_b == (
    if (c =? 0)
    then (
      when q, st1 == ((mk_spec st0));
      (Some (st1.[stack] :< ((st1.(stack)) # "stack_f__x" == (Some (PtrVal q))))))
    else (
      when q, st1 == ((mk_spec st0));
      (Some (st1.[stack] :< (((st1.(stack)) # "stack_f__x" == (Some (PtrVal q))) # "stack_f__y" == (Some (ZVal 4)))))));
  match (((st_b.(stack)) @ "stack_f__x")) with
  | (Some sv) =>
    match sv with
    | (ZMapVal z) => None
    | (ZVal z) => None
    | (PtrVal p) => (Some (p, st_b))
    end
  | None => None
  end.
Hint Unfold body_spec.

Definition body2_spec (c: int32) (d: int32) (st: RData) : (option (Ptr * RData)) :=
  when q, st0 == ((mk_spec st));
  when st_b == (
    if (c =? 0)
    then (
      when q, st1 == ((mk_spec st0));
      (Some (st1.[stack] :< ((st1.(stack)) # "stack_f__x" == (Some (PtrVal q))))))
    else (
      when q, st1 == ((mk_spec st0));
      (Some (st1.[stack] :< (((st1.(stack)) # "stack_f__x" == (Some (PtrVal q))) # "stack_f__y" == (Some (ZVal 4)))))));
  (Some (q, st_b)).
Hint Unfold body2_spec.
