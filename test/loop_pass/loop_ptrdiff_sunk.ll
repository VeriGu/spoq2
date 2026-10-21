; The converse of loop_ptrdiff_hoisted: `ptrtoint ptr %p` is inside the loop
; and the difference `p - dst` is after it, so the loop passes out %p, which
; the difference is translated from, as well as the cast.  Not in LCSSA form,
; where the use would be a phi and an integer.
;
;   fill(dst, n): p = dst; do { *p = 0; p++; } while (--n); return p - dst;
; The patch returns n, which differs from p - dst for n <= 0.

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @fill(ptr %dst, i64 %n) {
entry:
  %d = ptrtoint ptr %dst to i64
  br label %loop
loop:
  %p = phi ptr [ %dst, %entry ], [ %next, %loop ]
  %i = phi i64 [ %n, %entry ], [ %dec, %loop ]
  store i8 0, ptr %p, align 1
  %next = getelementptr inbounds i8, ptr %p, i64 1
  %c = ptrtoint ptr %next to i64
  %dec = sub i64 %i, 1
  %more = icmp ne i64 %dec, 0
  br i1 %more, label %loop, label %exit
exit:
  %r = sub i64 %c, %d
  ret i64 %r
}

define i64 @entry_sec0_vuln(ptr %dst, i64 %n) {
pv.root:
  %r = call i64 @fill(ptr %dst, i64 %n)
  ret i64 %r
}

define i64 @entry_sec0_patch(ptr %dst, i64 %n) {
pv.root:
  %r = call i64 @fill(ptr %dst, i64 %n)
  ret i64 %n
}
