; The vuln has undefined behaviour outside the valid inputs, which the patch
; removes:
;
;   vuln(x)  = x > 100 ? 10 / (x - 101) : x + 1      UB when x == 101
;   patch(x) = x > 100 ? -2 : x + 1
;
; Outside x <= 100 the defined results differ as well, which the predicate
; admits.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@g = dso_local global i32 0, align 4
@h = dso_local global i32 0, align 4

define dso_local i32 @entry_vuln(i32 %x) {
entry:
  %big = icmp sgt i32 %x, 100
  br i1 %big, label %out, label %in
out:
  %d = sub i32 %x, 101
  %q = sdiv i32 10, %d
  ret i32 %q
in:
  %r = add i32 %x, 1
  ret i32 %r
}

define dso_local i32 @entry_patch(i32 %x) {
entry:
  %big = icmp sgt i32 %x, 100
  br i1 %big, label %out, label %in
out:
  ret i32 -2
in:
  %r = add i32 %x, 1
  ret i32 %r
}
