; Companion of args_swapped_wrong_patch: the patch swaps both the parameter
; names and their uses, so patch(x, y) = x - y, as the vuln computes.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i32 @vuln(i32 noundef %a, i32 noundef %b) {
entry:
  %r = sub i32 %a, %b
  ret i32 %r
}

define dso_local i32 @patch(i32 noundef %b, i32 noundef %a) {
entry:
  %r = sub i32 %b, %a
  ret i32 %r
}
