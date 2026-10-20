; Shared loop invariant, a patch exit before any branch of the vuln.
;
;   vuln:  for (i = 0; i < n; i++) { x = pick(); if (i == 7) return 100 / 0;
;                                     acc += x; }  return acc;
;   patch: for (i = 0; i < n; i++) { if (i == 7) return -1; x = pick();
;                                     acc += x; }  return acc;
;
; The patch tests i == 7 at the top of its body, and the vuln only after it
; calls pick(), so in the product of the two bodies the patch reaches its exit
; first.  The vuln exits on the same test, to a division by zero after the
; loop, and the exits must still be paired (code 0 to code 0).
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare dso_local i32 @pick()

define dso_local i32 @f_vuln(i32 %n) {
entry:
  br label %loop
loop:
  %i = phi i32 [ 0, %entry ], [ %i.next, %latch ]
  %acc = phi i32 [ 0, %entry ], [ %acc.next, %latch ]
  %x = call i32 @pick()
  %seven = icmp eq i32 %i, 7
  br i1 %seven, label %ub, label %latch
ub:
  %q = sdiv i32 100, 0
  ret i32 %q
latch:
  %acc.next = add i32 %acc, %x
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
  %seven = icmp eq i32 %i, 7
  br i1 %seven, label %early, label %body
early:
  ret i32 -1
body:
  %x = call i32 @pick()
  br label %latch
latch:
  %acc.next = add i32 %acc, %x
  %i.next = add i32 %i, 1
  %c = icmp slt i32 %i.next, %n
  br i1 %c, label %loop, label %exit
exit:
  ret i32 %acc.next
}
