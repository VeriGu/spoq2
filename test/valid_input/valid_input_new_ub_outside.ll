; The patch adds undefined behaviour outside the valid inputs:
;
;   vuln(x)  = x > 100 ? (g = 1, -1) : x + 1
;   patch(x) = x > 100 ? 10 / (x - 101) : x + 1      UB when x == 101
;
; The predicate x <= 100 relaxes the relations, not the check that the patch
; has no UB where the vuln is defined, so this fails.  This is what separates
; ValidInput from an InitRely assumption: precondition_param_assumes is the same
; program with the restriction assumed, and it verifies.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@g = dso_local global i32 0, align 4
@h = dso_local global i32 0, align 4

define dso_local i32 @entry_vuln(i32 %x) {
entry:
  %big = icmp sgt i32 %x, 100
  br i1 %big, label %out, label %in
out:
  store i32 1, ptr @g, align 4
  ret i32 -1
in:
  %r = add i32 %x, 1
  ret i32 %r
}

define dso_local i32 @entry_patch(i32 %x) {
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
