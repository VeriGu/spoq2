; The loop count_loop_0 takes r = &q->f2, an inbounds struct GEP.  With
; ptr_offset_inbounds in the model, the poison check becomes an if around the
; call, and the refinement matches on
;
;   match (if (<q and q+8 in bounds>) then (count_loop_0 (q+8) ..) else (count_loop_0 (null,-1) ..)) with ..
;
; The vuln loads *q before count, the patch after it; they agree because the
; loop leaves the state unchanged (Loop_inv count_loop_0 (st = st_old)).  The
; invariant must be assumed of the loop call under the if, as it is of the
; bare call in loop_inv_unguarded_call.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.S = type { i32, i32, i32 }

define dso_local i32 @count(ptr %q) {
entry:
  %k = load i32, ptr %q, align 4
  %r = getelementptr inbounds nuw %struct.S, ptr %q, i32 0, i32 2
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
