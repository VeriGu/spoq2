if (! (((d.(pbase)) =s "null") && ((d.(poffset)) =? 0)))
then match ((((st.(heap)).(blocks)) @
(spvn (d.(pbase))))) with
	| None => match ((((st.(heap)).(blocks)) @
(spvn (d.(pbase))))) with
	| None => match ((((st.(heap)).(blocks)) @
(spvn (d.(pbase))))) with
	| None => if ((~ false) /\ ((~ ((d.(pbase)) =s "null")) /\ ((~ ("result" =s (d.(pbase)))) /\ (~ ((((((d.(pbase)) =s "stack_type_1") \/ ((d.(pbase)) =s "stack_type_1__1")) \/ ((d.(pbase)) =s "stack_type_1__2")) \/ ((d.(pbase)) =s "stack_type_2")) \/ ((d.(pbase)) =s "stack_type_2__1"))))))
then None
else match (((st.(stack)) @
(d.(pbase)))) with
	| (Some sv) => if ((~ false) /\ ((d.(pbase)) =s "null"))
then None
else match ((((st.(heap)).(blocks)) @
(spvn (d.(pbase))))) with
	| None => match ((((st.(heap)).(blocks)) @
(spvn (d.(pbase))))) with
	| None => match ((((st.(heap)).(blocks)) @
(spvn (d.(pbase))))) with
	| None => match ((((st.(heap)).(blocks)) @
(spvn (d.(pbase))))) with
	| None => match ((((st.(heap)).(blocks)) @
(spvn (d.(pbase))))) with
	| None => match ((((st.(heap)).(blocks)) @
(spvn (d.(pbase))))) with
	| None => rely ((((d.(poffset)) mod 16) = 0));
if ("result" =s (d.(pbase)))
then (Some (((st.(globals)).(g_result)), st))
else when sv_38 == (((st.(stack)) @
(d.(pbase))));
match sv_38 with
	| (ZVal ZVal_val) => (Some (ZVal_val, st))
end
	| _ => None
end
	| _ => None
end
	| _ => None
end
	| _ => None
end
	| _ => None
end
	| _ => None
end
	| None => if ((~ false) /\ ((~ ((d.(pbase)) =s "null")) /\ ((~ ("result" =s (d.(pbase)))) /\ ((((((d.(pbase)) =s "stack_type_1") \/ ((d.(pbase)) =s "stack_type_1__1")) \/ ((d.(pbase)) =s "stack_type_1__2")) \/ ((d.(pbase)) =s "stack_type_2")) \/ ((d.(pbase)) =s "stack_type_2__1")))))
then None
else if ((~ false) /\ ((d.(pbase)) =s "null"))
then None
else match ((((st.(heap)).(blocks)) @
(spvn (d.(pbase))))) with
	| None => match ((((st.(heap)).(blocks)) @
(spvn (d.(pbase))))) with
	| None => match ((((st.(heap)).(blocks)) @
(spvn (d.(pbase))))) with
	| None => match ((((st.(heap)).(blocks)) @
(spvn (d.(pbase))))) with
	| None => match ((((st.(heap)).(blocks)) @
(spvn (d.(pbase))))) with
	| None => match ((((st.(heap)).(blocks)) @
(spvn (d.(pbase))))) with
	| None => rely ((((d.(poffset)) mod 16) = 0));
(Some (((st.(globals)).(g_result)), st))
	| _ => None
end
	| _ => None
end
	| _ => None
end
	| _ => None
end
	| _ => None
end
	| _ => None
end
end
	| _ => None
end
	| _ => None
end
	| (Some b) => let (bytemap, bk_sz) := b in
	if ((~ false) /\ ((~ ((d.(pbase)) =s "null")) /\ ((~ ("result" =s (d.(pbase)))) /\ ((~ ((((((d.(pbase)) =s "stack_type_1") \/ ((d.(pbase)) =s "stack_type_1__1")) \/ ((d.(pbase)) =s "stack_type_1__2")) \/ ((d.(pbase)) =s "stack_type_2")) \/ ((d.(pbase)) =s "stack_type_2__1"))) /\ ((((d.(poffset)) + 4) - bk_sz) >? 0)))))
then None
else when b_41 == ((((st.(heap)).(blocks)) @
(spvn (d.(pbase)))));
let (bytemap_31, bk_sz_30) := b_41 in
	if ((~ false) /\ ((~ ((d.(pbase)) =s "null")) /\ ((~ ("result" =s (d.(pbase)))) /\ ((~ ((((((d.(pbase)) =s "stack_type_1") \/ ((d.(pbase)) =s "stack_type_1__1")) \/ ((d.(pbase)) =s "stack_type_1__2")) \/ ((d.(pbase)) =s "stack_type_2")) \/ ((d.(pbase)) =s "stack_type_2__1"))) /\ (((((d.(poffset)) + 4) - bk_sz_30) <=? 0) /\ ((d.(poffset)) <? 0))))))
then None
else when b_40 == ((((st.(heap)).(blocks)) @
(spvn (d.(pbase)))));
match (((st.(stack)) @
(d.(pbase)))) with
	| (Some sv) => if ((~ false) /\ ((d.(pbase)) =s "null"))
then None
else when b_39 == ((((st.(heap)).(blocks)) @
(spvn (d.(pbase)))));
when b_37 == ((((st.(heap)).(blocks)) @
(spvn (d.(pbase)))));
when b_36 == ((((st.(heap)).(blocks)) @
(spvn (d.(pbase)))));
when b_35 == ((((st.(heap)).(blocks)) @
(spvn (d.(pbase)))));
when b_32 == ((((st.(heap)).(blocks)) @
(spvn (d.(pbase)))));
when b_30 == ((((st.(heap)).(blocks)) @
(spvn (d.(pbase)))));
rely ((((d.(poffset)) mod 16) = 0));
if ("result" =s (d.(pbase)))
then (Some (((st.(globals)).(g_result)), st))
else if ((((((d.(pbase)) =s "stack_type_1") \/ ((d.(pbase)) =s "stack_type_1__1")) \/ ((d.(pbase)) =s "stack_type_1__2")) \/ ((d.(pbase)) =s "stack_type_2")) \/ ((d.(pbase)) =s "stack_type_2__1"))
then when sv_38 == (((st.(stack)) @
(d.(pbase))));
match sv_38 with
	| (ZVal ZVal_val) => (Some (ZVal_val, st))
end
else match ((((st.(heap)).(blocks)) @
(spvn (d.(pbase))))) with
	| None => None
	| (Some b_15) => let (bytemap_29, bk_sz_28) := b_15 in
	(Some ((bytemap_29 @ (d.(poffset))), st))
end
	| None => if ((~ false) /\ ((~ ((d.(pbase)) =s "null")) /\ ((~ ("result" =s (d.(pbase)))) /\ ((((((d.(pbase)) =s "stack_type_1") \/ ((d.(pbase)) =s "stack_type_1__1")) \/ ((d.(pbase)) =s "stack_type_1__2")) \/ ((d.(pbase)) =s "stack_type_2")) \/ ((d.(pbase)) =s "stack_type_2__1")))))
then None
else if ((~ false) /\ ((d.(pbase)) =s "null"))
then None
else when b_39 == ((((st.(heap)).(blocks)) @
(spvn (d.(pbase)))));
when b_37 == ((((st.(heap)).(blocks)) @
(spvn (d.(pbase)))));
when b_36 == ((((st.(heap)).(blocks)) @
(spvn (d.(pbase)))));
when b_35 == ((((st.(heap)).(blocks)) @
(spvn (d.(pbase)))));
when b_32 == ((((st.(heap)).(blocks)) @
(spvn (d.(pbase)))));
when b_30 == ((((st.(heap)).(blocks)) @
(spvn (d.(pbase)))));
rely ((((d.(poffset)) mod 16) = 0));
if ("result" =s (d.(pbase)))
then (Some (((st.(globals)).(g_result)), st))
else match ((((st.(heap)).(blocks)) @
(spvn (d.(pbase))))) with
	| None => None
	| (Some b_15) => let (bytemap_29, bk_sz_28) := b_15 in
	(Some ((bytemap_29 @ (d.(poffset))), st))
end
end
end
else (Some ((-1), st))