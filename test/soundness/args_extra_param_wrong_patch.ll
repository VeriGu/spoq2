; The patch takes a parameter the vuln does not, and it shares a name with the
; vuln's parameter at another position.  The shared first parameter corresponds
; by position; the extra one is free.  patch(x, y) = y is not vuln(x) = x, so
; the extra parameter must not be identified with the vuln's same-named one.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i32 @vuln(i32 noundef %a) {
entry:
  ret i32 %a
}

define dso_local i32 @patch(i32 noundef %b, i32 noundef %a) {
entry:
  ret i32 %a
}
