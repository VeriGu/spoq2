(* As join_scope_arm_local, but the arm-local binder gq has the name of a
   global Parameter, which is what the read would be replaced by. *)
Parameter gq : Ptr.
Definition body_spec (c: int32) (d: int32) (st: RData) : (option (Ptr * RData)) :=
  when st_b == (
    if (c =? 0)
    then (
      when gq, st1 == ((mk_spec st));
      (Some (st1.[stack] :< ((st1.(stack)) # "stack_f__x" == (Some (PtrVal gq))))))
    else (
      when gq, st1 == ((mk_spec st));
      (Some (st1.[stack] :< (((st1.(stack)) # "stack_f__x" == (Some (PtrVal gq))) # "stack_f__y" == (Some (ZVal 4)))))));
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
  when st_b == (
    if (c =? 0)
    then (
      when gq, st1 == ((mk_spec st));
      (Some (st1.[stack] :< ((st1.(stack)) # "stack_f__x" == (Some (PtrVal gq))))))
    else (
      when gq, st1 == ((mk_spec st));
      (Some (st1.[stack] :< (((st1.(stack)) # "stack_f__x" == (Some (PtrVal gq))) # "stack_f__y" == (Some (ZVal 4)))))));
  (Some (gq, st_b)).
Hint Unfold body2_spec.
