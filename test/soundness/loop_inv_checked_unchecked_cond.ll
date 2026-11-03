; count(q, r, p) writes *q = 7 when freeze(r) != p.  vuln and patch call it
; once bounds-checked, count(q, q+8 inbounds, q+8), and once unchecked,
; count(q, q+8, q+8).  When q+8 is out of bounds the checked call gets the
; poison pointer and writes *q; the vuln reads *q before the calls and the
; patch after them, so the patch is wrong.
; The invariant holds only where ptr_eqb rf p, which the bounds check decides
; at the checked call.  Unfolding ptr_eqb in the invariant needs the loop's
; argument types.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"
%struct.S = type { i32, i32, i32 }

define dso_local i32 @count(ptr %q, ptr %r, ptr %p) {
entry:
  %k = load i32, ptr %q, align 4
  %rf = freeze ptr %r
  br label %loop
loop:
  %i = phi i32 [ 0, %entry ], [ %i.next, %latch ]
  %ne = icmp ne ptr %rf, %p
  br i1 %ne, label %wr, label %latch
wr:
  store i32 7, ptr %q, align 4
  br label %latch
latch:
  %i.next = add i32 %i, 1
  %c = icmp slt i32 %i.next, %k
  br i1 %c, label %loop, label %exit
exit:
  ret i32 %i.next
}

define dso_local i32 @vuln(ptr %q) {
entry:
  %x = load i32, ptr %q, align 4
  %r1 = getelementptr inbounds nuw %struct.S, ptr %q, i32 0, i32 2
  %p = getelementptr %struct.S, ptr %q, i32 0, i32 2
  %a = call i32 @count(ptr %q, ptr %r1, ptr %p)
  %b = call i32 @count(ptr %q, ptr %p, ptr %p)
  %s = add i32 %x, %a
  %t = add i32 %s, %b
  ret i32 %t
}

define dso_local i32 @patch(ptr %q) {
entry:
  %r1 = getelementptr inbounds nuw %struct.S, ptr %q, i32 0, i32 2
  %p = getelementptr %struct.S, ptr %q, i32 0, i32 2
  %a = call i32 @count(ptr %q, ptr %r1, ptr %p)
  %b = call i32 @count(ptr %q, ptr %p, ptr %p)
  %x = load i32, ptr %q, align 4
  %s = add i32 %x, %a
  %t = add i32 %s, %b
  ret i32 %t
}
