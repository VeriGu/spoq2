; The patch differs from the vuln on the then branch only, so the then leaf
; fails.  With fail_fast the traversal does not visit the else leaf.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i32 @vuln(i32 noundef %n) {
entry:
  %c = icmp sgt i32 %n, 0
  br i1 %c, label %pos, label %neg
pos:
  ret i32 1
neg:
  ret i32 7
}

define dso_local i32 @patch(i32 noundef %n) {
entry:
  %c = icmp sgt i32 %n, 0
  br i1 %c, label %pos, label %neg
pos:
  ret i32 0
neg:
  ret i32 7
}
