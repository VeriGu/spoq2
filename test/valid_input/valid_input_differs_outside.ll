; A valid-input predicate, x <= 100.  On valid inputs the patch must refine the
; vuln under the usual relations; on others it may behave differently, as long
; as it adds no undefined behaviour.
;
;   vuln(x)  = x > 100 ? (g = 1, -1) : x + 1
;   patch(x) = x > 100 ? -2 : x + 1
;
; The two differ only on x > 100, where the returns differ and only the vuln
; writes g.
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
  ret i32 -2
in:
  %r = add i32 %x, 1
  ret i32 %r
}
