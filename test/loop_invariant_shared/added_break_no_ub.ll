; Negative control for added_break_later_ub: where the patch breaks on c < 0,
; the vuln adds 1 and keeps iterating without UB.  No vuln invariant shows UB,
; so there is no relation, and the patch does not refine the vuln.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare dso_local i32 @pick()

define dso_local i32 @f_vuln(i32 %n, i32 %c0) {
entry:
  br label %loop
loop:
  %i = phi i32 [ 0, %entry ], [ %i.next, %body ]
  %c = phi i32 [ %c0, %entry ], [ %p, %body ]
  %acc = phi i32 [ 0, %entry ], [ %acc.next, %body ]
  %neg = icmp slt i32 %c, 0
  br i1 %neg, label %d, label %norm
d:
  %acc.d = add i32 %acc, 1
  br label %norm
norm:
  %acc.n = phi i32 [ %acc, %loop ], [ %acc.d, %d ]
  %done = icmp sge i32 %i, %n
  br i1 %done, label %exit, label %body
body:
  %p = call i32 @pick()
  %acc.next = add i32 %acc.n, %p
  %i.next = add i32 %i, 1
  br label %loop
exit:
  ret i32 %acc.n
}

define dso_local i32 @f_patch(i32 %n, i32 %c0) {
entry:
  br label %loop
loop:
  %i = phi i32 [ 0, %entry ], [ %i.next, %body ]
  %c = phi i32 [ %c0, %entry ], [ %p, %body ]
  %acc = phi i32 [ 0, %entry ], [ %acc.next, %body ]
  %neg = icmp slt i32 %c, 0
  br i1 %neg, label %exit, label %norm
norm:
  %done = icmp sge i32 %i, %n
  br i1 %done, label %exit, label %body
body:
  %p = call i32 @pick()
  %acc.next = add i32 %acc, %p
  %i.next = add i32 %i, 1
  br label %loop
exit:
  ret i32 %acc
}
