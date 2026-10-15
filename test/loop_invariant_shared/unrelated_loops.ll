; Shared loop invariant, unrelated loops.
;
;   vuln:  for (i = 0; i < n; i++) acc += pick();          return acc;
;   patch: for (k = n; k > 0; k--) sum += 2 * pick();     return sum;
;
; The exits do not pair: where the patch exits the vuln continues, and no vuln
; invariant shows UB, so there is no relation.
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
  %k = phi i32 [ %n, %entry ], [ %k.next, %loop ]
  %sum = phi i32 [ 0, %entry ], [ %sum.next, %loop ]
  %p = call i32 @pick()
  %p2 = shl i32 %p, 1
  %sum.next = add i32 %sum, %p2
  %k.next = add i32 %k, -1
  %c = icmp sgt i32 %k.next, 0
  br i1 %c, label %loop, label %exit
exit:
  ret i32 %sum.next
}
