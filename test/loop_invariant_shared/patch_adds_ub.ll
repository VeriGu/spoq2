; Shared loop invariant, a patch that adds UB inside the loop.
;
;   vuln:  for (i = 0; i < n; i++) acc += pick();  return acc;
;   patch: the same, dividing by zero when pick() == 5
;
; Where the patch is None the vuln continues without UB, so there is no
; relation and the patch does not refine the vuln.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare dso_local i32 @pick()

define dso_local i32 @f_vuln(i32 %n) {
entry:
  br label %loop
loop:
  %i = phi i32 [ 0, %entry ], [ %i.next, %loop ]
  %acc = phi i32 [ 0, %entry ], [ %acc.next, %loop ]
  %p = call i32 @pick()
  %acc.next = add i32 %acc, %p
  %i.next = add i32 %i, 1
  %c = icmp slt i32 %i.next, %n
  br i1 %c, label %loop, label %exit
exit:
  ret i32 %acc.next
}

define dso_local i32 @f_patch(i32 %n) {
entry:
  br label %loop
loop:
  %i = phi i32 [ 0, %entry ], [ %i.next, %latch ]
  %acc = phi i32 [ 0, %entry ], [ %acc.next, %latch ]
  %p = call i32 @pick()
  %five = icmp eq i32 %p, 5
  br i1 %five, label %ub, label %latch
ub:
  %q = sdiv i32 %p, 0
  ret i32 %q
latch:
  %acc.next = add i32 %acc, %p
  %i.next = add i32 %i, 1
  %c = icmp slt i32 %i.next, %n
  br i1 %c, label %loop, label %exit
exit:
  ret i32 %acc.next
}
