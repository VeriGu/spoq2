; Control of hint_match_infeasible_arm: the same module, with the invariant
; stated without a match.  Passes today.
;
; A Prop-valued match in a loop invariant, added on an infeasible arm.
;
;   count(n) = s = 0; i = 0; do { s += 10 / n; i++ } while (i < 5); return s
;   vuln(n)  = count(n)
;   patch(n) = n == 7 ? count(n) : count(n)
;
; From n == 0 the loop divides by zero before any exit.  The invariant says
; so through a match on a heap block.  On the vuln's None arm (n == 0) the
; impl's match on the same loop call reaches its Some arm with a state that
; already contradicts it, and spoq adds the invariant there before checking
; the arm.  Both versions are equal: verified.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i32 @count(i32 %n) {
entry:
  br label %loop
loop:
  %i = phi i32 [ 0, %entry ], [ %i.next, %loop ]
  %s = phi i32 [ 0, %entry ], [ %s.next, %loop ]
  %t = sdiv i32 10, %n
  %s.next = add i32 %s, %t
  %i.next = add i32 %i, 1
  %c = icmp slt i32 %i.next, 5
  br i1 %c, label %loop, label %exit
exit:
  ret i32 %s.next
}

define dso_local i32 @vuln(i32 %n) {
entry:
  %r = call i32 @count(i32 %n)
  ret i32 %r
}

define dso_local i32 @patch(i32 %n) {
entry:
  %c = icmp eq i32 %n, 7
  br i1 %c, label %yes, label %no
yes:
  %a = call i32 @count(i32 %n)
  ret i32 %a
no:
  %b = call i32 @count(i32 %n)
  ret i32 %b
}
