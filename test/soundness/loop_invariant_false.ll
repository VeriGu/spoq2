; The .main.v gives the vuln's loop the invariant arg_dummy0 = 0 /\
; arg_dummy0 = 1, which no exit state satisfies.  Assumed without being
; checked, it makes the vuln's normal exit infeasible, leaving only undefined
; behaviour, which licenses any patch -- here one that returns 12345.  The
; refinement check must validate the invariant first and find it is not
; inductive.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i32 @vuln(i32 noundef %n) {
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

define dso_local i32 @patch(i32 noundef %n) {
entry:
  ret i32 12345
}
