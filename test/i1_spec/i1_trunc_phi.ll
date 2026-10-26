; A phi of i1 joining a trunc to i1 and an icmp, then branched on.
;
;   vuln:  p = (y > 0) ? trunc x to i1 : (x == 5);  if p then 1 else 0
;   patch: the same with (x & 1) != 0
;
; The If that joins at the phi yields the truncated value on one arm and the
; icmp's Bool on the other.  With the truncated value a Z, type inference
; aborts at type_inference.cpp:869 (the arms of an If differ in type).

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i32 @f_vuln(i32 %x, i32 %y) {
entry:
  %c = icmp sgt i32 %y, 0
  br i1 %c, label %a, label %b
a:
  %t1 = trunc i32 %x to i1
  br label %j
b:
  %t2 = icmp eq i32 %x, 5
  br label %j
j:
  %p = phi i1 [ %t1, %a ], [ %t2, %b ]
  br i1 %p, label %yes, label %no
yes:
  ret i32 1
no:
  ret i32 0
}

define dso_local i32 @f_patch(i32 %x, i32 %y) {
entry:
  %c = icmp sgt i32 %y, 0
  br i1 %c, label %a, label %b
a:
  %m = and i32 %x, 1
  %t1 = icmp ne i32 %m, 0
  br label %j
b:
  %t2 = icmp eq i32 %x, 5
  br label %j
j:
  %p = phi i1 [ %t1, %a ], [ %t2, %b ]
  br i1 %p, label %yes, label %no
yes:
  ret i32 1
no:
  ret i32 0
}
