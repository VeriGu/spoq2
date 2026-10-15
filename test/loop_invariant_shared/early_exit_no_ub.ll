; Negative control for early_exit_ub_after: after a break the vuln returns x.
;
;   vuln:  for (i = 0; i < n; i++) { x = pick(); if (x <= 0) break; acc += x; }
;          after a break: x; after the last iteration: acc
;   patch: the same loop with `if (x == 0) return -1;` before the break test
;
; The loops pair path for path except at x == 0, where the vuln breaks and the
; patch returns early.  The vuln then returns 0 and the patch -1, so the patch
; does not refine the vuln, and the failure is at that exit.
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
  %le = icmp sle i32 %x, 0
  br i1 %le, label %brk, label %latch
latch:
  %acc.next = add i32 %acc, %x
  %i.next = add i32 %i, 1
  %c = icmp slt i32 %i.next, %n
  br i1 %c, label %loop, label %done
brk:
  %q = add i32 %x, 0
  ret i32 %q
done:
  ret i32 %acc.next
}

define dso_local i32 @f_patch(i32 %n) {
entry:
  br label %loop
loop:
  %i = phi i32 [ 0, %entry ], [ %i.next, %latch ]
  %acc = phi i32 [ 0, %entry ], [ %acc.next, %latch ]
  %x = call i32 @pick()
  %z = icmp eq i32 %x, 0
  br i1 %z, label %early, label %test
test:
  %le = icmp sle i32 %x, 0
  br i1 %le, label %brk, label %latch
latch:
  %acc.next = add i32 %acc, %x
  %i.next = add i32 %i, 1
  %c = icmp slt i32 %i.next, %n
  br i1 %c, label %loop, label %done
early:
  ret i32 -1
brk:
  %q = add i32 %x, 0
  ret i32 %q
done:
  ret i32 %acc.next
}
