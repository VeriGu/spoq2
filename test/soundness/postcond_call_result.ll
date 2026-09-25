; The result of a loop with an invariant is the loop's result, with the
; invariant assumed of it.
;
;   count(n) = s = 0; for (i = 0; i < n; i++) s++; return s
;   vuln(n)  = count(n) == 7 ? 1 : 0
;   patch(n) = count(n) == 7 ? 1 : 0          (a branch instead of a zext)
;
; Hint Unfold inlines count into both, so both apply the one fixpoint
; count_loop_0 to the same arguments and the patch verifies.  Binding the
; loop's result names to fresh constants, constrained only by the invariant,
; leaves the two results unrelated and the refinement unprovable.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i32 @count(i32 %n) {
entry:
  br label %loop
loop:
  %i = phi i32 [ 0, %entry ], [ %i.next, %loop ]
  %s = phi i32 [ 0, %entry ], [ %s.next, %loop ]
  %s.next = add i32 %s, 1
  %i.next = add i32 %i, 1
  %c = icmp slt i32 %i.next, %n
  br i1 %c, label %loop, label %exit
exit:
  ret i32 %s.next
}

define dso_local i32 @vuln(i32 %n) {
entry:
  %b = call i32 @count(i32 %n)
  %c = icmp eq i32 %b, 7
  %r = zext i1 %c to i32
  ret i32 %r
}

define dso_local i32 @patch(i32 %n) {
entry:
  %b = call i32 @count(i32 %n)
  %c = icmp eq i32 %b, 7
  br i1 %c, label %yes, label %no
yes:
  ret i32 1
no:
  ret i32 0
}
