; The patch declares the vuln's parameter names in the other order.  Callers
; pass arguments by position, so patch(x, y) = y - x while vuln(x, y) = x - y.
; Identifying the two sides' arguments by name would equate them.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i32 @vuln(i32 noundef %a, i32 noundef %b) {
entry:
  %r = sub i32 %a, %b
  ret i32 %r
}

define dso_local i32 @patch(i32 noundef %b, i32 noundef %a) {
entry:
  %r = sub i32 %a, %b
  ret i32 %r
}
