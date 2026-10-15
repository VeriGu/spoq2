; A loop whose only exit is inside one arm of a branch (jq's decToString):
;
;   for (;;) { if (cut < 0) { if (up == lsu) break; up--; cut = 2; } cut--; }
;
; Every path out of the header passes through if.then, so if.then is the
; header's immediate post-dominator; but the else arm reaches the back edge,
; which the loop's spec ends with a recursive call, so if.then is not a join of
; the two arms.  Taking it as one gave the If arms different types (an
; assertion in type_inference.cpp).

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i32 @vuln(i32 %cut, i64 %up, i64 %lsu) {
entry:
  br label %for.cond

for.cond:
  %cut0 = phi i32 [ %cut, %entry ], [ %dec, %if.end3 ]
  %up0 = phi i64 [ %up, %entry ], [ %up1, %if.end3 ]
  %cmp = icmp slt i32 %cut0, 0
  br i1 %cmp, label %if.then, label %if.end3

if.then:
  %cmp1 = icmp eq i64 %up0, %lsu
  br i1 %cmp1, label %for.end, label %if.end

if.end:
  %updec = sub i64 %up0, 1
  br label %if.end3

if.end3:
  %cut1 = phi i32 [ 2, %if.end ], [ %cut0, %for.cond ]
  %up1 = phi i64 [ %updec, %if.end ], [ %up0, %for.cond ]
  %dec = sub i32 %cut1, 1
  br label %for.cond

for.end:
  ret i32 0
}
