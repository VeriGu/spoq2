; Companion of args_extra_param_wrong_patch: the patch returns its first
; parameter, which corresponds to the vuln's, so patch(x, y) = x = vuln(x)
; whatever the extra parameter y is.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i32 @vuln(i32 noundef %a) {
entry:
  ret i32 %a
}

define dso_local i32 @patch(i32 noundef %b, i32 noundef %a) {
entry:
  ret i32 %b
}
