Record STACK :=
 mkSTACK {
    stack_type_1: Z;
    stack_type_1__1: Z;
    stack_type_1__2: Z
    }.

(*
  if (p.(pbase) =s "stack_type_1") then (
      Some(st.(stack).(stack_type_1), st)) else
  if (p.(pbase) =s "stack_type_1__1") then (
      Some(st.(stack).(stack_type_1__1), st)) else
  if (p.(pbase) =s "stack_type_1__2") then (
      Some(st.(stack).(stack_type_1__2), st)) else

*)

(*
  if (p.(pbase) =s "stack_type_1") then (
      Some(st.[stack].[stack_type_1] :< v)) else
  if (p.(pbase) =s "stack_type_1__1") then (
      Some(st.[stack].[stack_type_1__1] :< v)) else
  if (p.(pbase) =s "stack_type_1__2") then (
      Some(st.[stack].[stack_type_1__2] :< v)) else

*)

Hint StackVar add_vuln v_2 stack_type_1.
Hint StackVar add_patch v_2 stack_type_1.
Hint StackVar add_patch v_3 stack_type_1__1.
Hint StackVar set_global_patch v_2 stack_type_1__2.
Hint StackVar set_global_vuln v_2 stack_type_1__1.

Record GLOBALS :=
  mkGLOBALS {
      g_dumb: Z
    }.

(*
  if (p.(pbase) =s "dumb") then (
      Some(st.(share).(globals).(g_dumb), st)) else

*)

(*
  if (p.(pbase) =s "dumb") then (
      Some(st.[share].[globals].[g_dumb] :< v)) else

*)
Definition DUMB_BASE : Z := 67108864.
Definition MAX_GLOBAL : Z := 67112960.

Definition global_to_ptr (v: Z) : Ptr := 
 if (v >=? MAX_GLOBAL ) then (mkPtr "null" 0) else
 if (v <? 0 ) then (mkPtr "null" 0) else
 if (v >=? DUMB_BASE) then (mkPtr "dumb" (v - DUMB_BASE)) else
   (mkPtr "null" 0).
Definition ptr_to_int (p: Ptr) : Z := 
 if (p.(poffset) <? 0) then (-1) else
 if (p.(pbase) =s "status") then (MAX_ERR + p.(poffset)) else
 if (p.(pbase) =s "null") then 0 else
 if (p.(pbase) =s "dumb") then (DUMB_BASE + p.(poffset)) else
    (-1).
