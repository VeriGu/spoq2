; Both functions read through a null pointer on every path, so every path of
; both ends in None and the refinement holds vacuously: verified, but neither
; side reaches a Some.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i64 @vuln(ptr noundef %d) {
entry:
  %v = load i64, ptr null, align 8
  ret i64 %v
}

define dso_local i64 @patch(ptr noundef %d) {
entry:
  %v = load i64, ptr null, align 8
  ret i64 %v
}
