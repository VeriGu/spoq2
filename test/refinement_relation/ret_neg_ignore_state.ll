; A refinement relation that ignores the state and accepts equal returns or
; two negative returns.
;
;   vuln(x)  = x < 0 ? (g = 1, -1) : 10 / x       UB when x == 0
;   patch(x) = x <= 0 ? -2 : 10 / x
;
; On x < 0 the returns differ and only vuln writes g; on x > 0 they agree.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@g = dso_local global i32 0, align 4
@h = dso_local global i32 0, align 4

define dso_local i32 @entry_vuln(i32 %x) {
entry:
  %neg = icmp slt i32 %x, 0
  br i1 %neg, label %err, label %ok
err:
  store i32 1, ptr @g, align 4
  ret i32 -1
ok:
  %q = sdiv i32 10, %x
  ret i32 %q
}

define dso_local i32 @entry_patch(i32 %x) {
entry:
  %le = icmp sle i32 %x, 0
  br i1 %le, label %err, label %ok
err:
  ret i32 -2
ok:
  %q = sdiv i32 10, %x
  ret i32 %q
}
