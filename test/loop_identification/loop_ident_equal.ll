; Vuln/patch loop identification (infer_spec_task_v2, identify_patch_loops).
;
;   vuln  = acc = sum of n calls to pick(); a / acc
;   patch = the same loop; acc == 0 ? 0 : a / acc
;
; Each loop becomes a Fixpoint with postcondition true, so without
; identification the two accumulators are unrelated and the refinement fails.
; The loops are equal up to value names, so the patch loop is defined as the
; vuln loop and both helpers compute the same acc.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare dso_local i32 @pick()

define dso_local i32 @f_vuln(i32 %a, i32 %n) {
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
  %q = sdiv i32 %a, %acc.next
  ret i32 %q
}

define dso_local i32 @f_patch(i32 %a, i32 %n) {
entry:
  br label %header
header:
  %k = phi i32 [ 0, %entry ], [ %k1, %header ]
  %sum = phi i32 [ 0, %entry ], [ %sum1, %header ]
  %r = call i32 @pick()
  %sum1 = add i32 %sum, %r
  %k1 = add i32 %k, 1
  %more = icmp slt i32 %k1, %n
  br i1 %more, label %header, label %done
done:
  %z = icmp eq i32 %sum1, 0
  br i1 %z, label %bail, label %go
bail:
  ret i32 0
go:
  %q = sdiv i32 %a, %sum1
  ret i32 %q
}
