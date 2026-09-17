; Both sides already test the divisor, so neither has division UB and the guard
; must not be added a second time.  A redundant `if (b <> 0) ... else None`
; under a branch that has already established b <> 0 is not wrong, but it is
; dead weight that the hoist then copies, so the pass is pinned not to emit it.
;
; impl_eliminates_ub is false because there is no division UB to eliminate.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
declare dso_local i32 @pick()
define dso_local i32 @vuln(i32 %a) {
entry:
  %b = call i32 @pick()
  %z = icmp eq i32 %b, 0
  br i1 %z, label %bail, label %go
bail:
  ret i32 -1
go:
  %q = sdiv i32 %a, %b
  ret i32 %q
}
define dso_local i32 @patch(i32 %a) {
entry:
  %b = call i32 @pick()
  %z = icmp eq i32 %b, 0
  br i1 %z, label %bail, label %go
bail:
  ret i32 -1
go:
  %q = sdiv i32 %a, %b
  ret i32 %q
}
