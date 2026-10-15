; Shared loop invariant, added continue.
;
;   vuln:  for (i = 0; i < n; i++) { d = pick(); acc += 100 / d; }  return acc;
;   patch: the same with `if (d == 0) continue;` before the division
;
; On the skipped iterations the vuln divides by zero in the same iteration, so
; the vuln path is None and the pair needs no relation.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare dso_local i32 @pick()

define dso_local i32 @f_vuln(i32 %n) {
entry:
  br label %loop
loop:
  %i = phi i32 [ 0, %entry ], [ %i.next, %loop ]
  %acc = phi i32 [ 0, %entry ], [ %acc.next, %loop ]
  %d = call i32 @pick()
  %q = sdiv i32 100, %d
  %acc.next = add i32 %acc, %q
  %i.next = add i32 %i, 1
  %c = icmp slt i32 %i.next, %n
  br i1 %c, label %loop, label %exit
exit:
  ret i32 %acc.next
}

define dso_local i32 @f_patch(i32 %n) {
entry:
  br label %header
header:
  %i = phi i32 [ 0, %entry ], [ %i.next, %latch ]
  %acc = phi i32 [ 0, %entry ], [ %acc.sel, %latch ]
  %d = call i32 @pick()
  %z = icmp eq i32 %d, 0
  br i1 %z, label %latch, label %body
body:
  %q = sdiv i32 100, %d
  %acc.b = add i32 %acc, %q
  br label %latch
latch:
  %acc.sel = phi i32 [ %acc, %header ], [ %acc.b, %body ]
  %i.next = add i32 %i, 1
  %c = icmp slt i32 %i.next, %n
  br i1 %c, label %header, label %exit
exit:
  ret i32 %acc.sel
}
