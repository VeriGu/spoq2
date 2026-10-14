(* Both results of st_b's join are based on a state named s: the else result
   on the outer s, the then result on an s the arm rebinds to an opaque call's
   result.  Both reads are (s.(stack)) @ slot as terms, but the then one is of
   the inner s, so the read of st_b is not replaced by the outer s's read;
   body2_spec is what that replacement would give. *)
Definition body_spec (c: int32) (d: int32) (st: RData) : (option (Ptr * RData)) :=
  when s == ((use_spec 0 st));
  when st_b == (
    if (c =? 0)
    then (
      when s == ((use_spec 1 s));
      (Some (s.[stack] :< ((s.(stack)) # "stack_type_1" == (Some (ZVal 3))))))
    else (Some (s.[stack] :< ((s.(stack)) # "stack_type_1" == (Some (ZVal 4))))));
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
  when s == ((use_spec 0 st));
  when st_b == (
    if (c =? 0)
    then (
      when s == ((use_spec 1 s));
      (Some (s.[stack] :< ((s.(stack)) # "stack_type_1" == (Some (ZVal 3))))))
    else (Some (s.[stack] :< ((s.(stack)) # "stack_type_1" == (Some (ZVal 4))))));
  match (((s.(stack)) @ "stack_type_2")) with
  | (Some sv) =>
    match sv with
    | (ZMapVal z) => None
    | (ZVal z) => None
    | (PtrVal p) => (Some (p, st_b))
    end
  | None => None
  end.
Hint Unfold body2_spec.
