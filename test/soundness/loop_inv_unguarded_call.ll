; The control for loop_inv_guarded_call: the same functions with a GEP
; without inbounds, so the call to count_loop_0 is the bare match scrutinee and
; the loop invariant (st = st_old) is assumed of its result.  The vuln loads *q
; before count, the patch after it; they agree because the loop leaves the
; state unchanged.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.S = type { i32, i32, i32 }

define dso_local i32 @count(ptr %q) {
entry:
  %k = load i32, ptr %q, align 4
  %r = getelementptr %struct.S, ptr %q, i32 0, i32 2
  br label %loop
loop:
  %i = phi i32 [ 0, %entry ], [ %i.next, %loop ]
  %s = phi i32 [ 0, %entry ], [ %s.next, %loop ]
  %n = load i32, ptr %r, align 4
  %s.next = add i32 %s, 1
  %i.next = add i32 %i, 1
  %m = add i32 %n, %k
  %c = icmp slt i32 %i.next, %m
  br i1 %c, label %loop, label %exit
exit:
  ret i32 %s.next
}

define dso_local i32 @vuln(ptr %q) {
entry:
  %x = load i32, ptr %q, align 4
  %b = call i32 @count(ptr %q)
  %r = add i32 %x, %b
  ret i32 %r
}

define dso_local i32 @patch(ptr %q) {
entry:
  %b = call i32 @count(ptr %q)
  %x = load i32, ptr %q, align 4
  %r = add i32 %x, %b
  ret i32 %r
}
