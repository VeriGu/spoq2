; Both relations refer to two entry parameters, x and y: the states and the
; returns may differ when x < y.
;
;   vuln(x, y)  = x < y ? (g = 1, -1) : 10 / (x - y)     UB when x == y
;   patch(x, y) = x <= y ? -2 : 10 / (x - y)
;
; On x < y the returns differ and only the vuln writes g.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@g = dso_local global i32 0, align 4
@h = dso_local global i32 0, align 4

define dso_local i32 @entry_vuln(i32 %x, i32 %y) {
entry:
  %lt = icmp slt i32 %x, %y
  br i1 %lt, label %err, label %ok
err:
  store i32 1, ptr @g, align 4
  ret i32 -1
ok:
  %d = sub i32 %x, %y
  %q = sdiv i32 10, %d
  ret i32 %q
}

define dso_local i32 @entry_patch(i32 %x, i32 %y) {
entry:
  %le = icmp sle i32 %x, %y
  br i1 %le, label %err, label %ok
err:
  ret i32 -2
ok:
  %d = sub i32 %x, %y
  %q = sdiv i32 10, %d
  ret i32 %q
}
