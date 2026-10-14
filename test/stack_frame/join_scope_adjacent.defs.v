(* st_b's join leaves &g in the slot, then an adjacent when rebinds st_b to
   the result of an opaque call.  The read is of the second st_b, so it is not
   replaced by &g; body2_spec is what that replacement would give. *)
Definition body_spec (c: int32) (d: int32) (st: RData) : (option (Ptr * RData)) :=
  when st_b == (
    if (c =? 0)
    then (Some (st.[stack] :< ((st.(stack)) # "stack_type_2" == (Some (PtrVal (mkPtr "g" 0))))))
    else (Some (st.[stack] :< (((st.(stack)) # "stack_type_2" == (Some (PtrVal (mkPtr "g" 0)))) # "stack_type_1" == (Some (ZVal 4))))));
  when st_b == ((use_spec 1 st_b));
  match (((st_b.(stack)) @ "stack_type_2")) with
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
  when st_b == (
    if (c =? 0)
    then (Some (st.[stack] :< ((st.(stack)) # "stack_type_2" == (Some (PtrVal (mkPtr "g" 0))))))
    else (Some (st.[stack] :< (((st.(stack)) # "stack_type_2" == (Some (PtrVal (mkPtr "g" 0)))) # "stack_type_1" == (Some (ZVal 4))))));
  when st_b == ((use_spec 1 st_b));
  (Some ((mkPtr "g" 0), st_b)).
Hint Unfold body2_spec.
