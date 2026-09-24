; The vuln returns a value and the patch returns nothing, so vuln_ret =
; patch_ret has no patch_ret to relate: the refinement cannot be stated.  The
; mismatch used to be logged and the check carried on, comparing only states.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i32 @vuln() {
entry:
  ret i32 7
}

define dso_local void @patch() {
entry:
  ret void
}
