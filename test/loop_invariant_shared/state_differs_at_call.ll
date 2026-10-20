; Shared loop invariant, states unrelated at the call.
;
;   vuln:  for (i = 0; i < n; i++) acc += pick();  return acc;
;   patch: pick();  for (i = 0; i < n; i++) acc += pick();  return acc;
;          (the loop adds pick() on both arms of a test, so that it is not
;          identified with the vuln loop)
;
; pick() is a function of the state, so the bodies write the state, and the
; patch enters its loop after one more call, as a rotated loop does.  No
; relation of the states holds at the call, so the loops cannot run in
; lockstep, and inference is skipped.
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
  %first = call i32 @pick()
  br label %loop
loop:
  %i = phi i32 [ 0, %entry ], [ %i.next, %latch ]
  %acc = phi i32 [ 0, %entry ], [ %acc.next, %latch ]
  %p = call i32 @pick()
  %e = icmp eq i32 %p, %n
  br i1 %e, label %one, label %two
one:
  %s1 = add i32 %acc, %p
  br label %latch
two:
  %s2 = add i32 %p, %acc
  br label %latch
latch:
  %acc.next = phi i32 [ %s1, %one ], [ %s2, %two ]
  %i.next = add i32 %i, 1
  %c = icmp slt i32 %i.next, %n
  br i1 %c, label %loop, label %exit
exit:
  ret i32 %acc.next
}
