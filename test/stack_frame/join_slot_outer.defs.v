(* st_b's join has a then result that writes &g to stack_type_2 and an else
   result that updates another slot of st_a, a state bound by an earlier join
   outside st_b's.  Both of st_a's results write &g there, so the read of st_b
   after the join is &g, found by resolving st_a through its binding
   (rule_forward_join_slots). *)
Definition body_spec (c: int32) (d: int32) (st: RData) : (option (Ptr * RData)) :=
  when st_a == (
    if (c =? 0)
    then (Some (st.[stack] :< ((st.(stack)) # "stack_type_2" == (Some (PtrVal (mkPtr "g" 0))))))
    else (
      when st2 == ((use_spec 1 st));
      (Some (st2.[stack] :< ((st2.(stack)) # "stack_type_2" == (Some (PtrVal (mkPtr "g" 0))))))));
  when st_b == (
    if (d =? 0)
    then (
      when st3 == ((use_spec 2 st_a));
      (Some (st3.[stack] :< ((st3.(stack)) # "stack_type_2" == (Some (PtrVal (mkPtr "g" 0)))))))
    else (Some (st_a.[stack] :< ((st_a.(stack)) # "stack_type_1" == (Some (ZVal 4))))));
  when st_c == ((use_spec 3 st_b));
  match ((st_b.(stack)) @ "stack_type_2") with
  | (Some sv) =>
    match sv with
    | (ZMapVal z) => None
    | (ZVal z) => None
    | (PtrVal p) => (Some (p, st_c))
    end
  | None => None
  end.
Hint Unfold body_spec.

(* body_spec with the read replaced by its value. *)
Definition body2_spec (c: int32) (d: int32) (st: RData) : (option (Ptr * RData)) :=
  when st_a == (
    if (c =? 0)
    then (Some (st.[stack] :< ((st.(stack)) # "stack_type_2" == (Some (PtrVal (mkPtr "g" 0))))))
    else (
      when st2 == ((use_spec 1 st));
      (Some (st2.[stack] :< ((st2.(stack)) # "stack_type_2" == (Some (PtrVal (mkPtr "g" 0))))))));
  when st_b == (
    if (d =? 0)
    then (
      when st3 == ((use_spec 2 st_a));
      (Some (st3.[stack] :< ((st3.(stack)) # "stack_type_2" == (Some (PtrVal (mkPtr "g" 0)))))))
    else (Some (st_a.[stack] :< ((st_a.(stack)) # "stack_type_1" == (Some (ZVal 4))))));
  when st_c == ((use_spec 3 st_b));
  (Some ((mkPtr "g" 0), st_c)).
Hint Unfold body2_spec.
