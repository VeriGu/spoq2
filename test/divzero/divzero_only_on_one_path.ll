; Guard placement.  The division is on one arm of a branch:
;
;   vuln  = flag() == 0 ? 7 : a / pick()
;
; The guard has to go inside that arm.  Hoisted above the branch it would make
; the spec None when flag() == 0 as well -- UB the function does not have, which
; hands the patch freedom it has not earned and can hide a real difference.  The
; verdict alone does not catch that, so the arm structure is pinned too.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
declare dso_local i32 @pick()
declare dso_local i32 @flag()
define dso_local i32 @vuln(i32 %a) {
entry:
  %b = call i32 @pick()
  %c = call i32 @flag()
  %t = icmp eq i32 %c, 0
  br i1 %t, label %safe, label %risky
safe:
  ret i32 7
risky:
  %q = sdiv i32 %a, %b
  ret i32 %q
}
define dso_local i32 @patch(i32 %a) {
entry:
  %b = call i32 @pick()
  %c = call i32 @flag()
  %t = icmp eq i32 %c, 0
  br i1 %t, label %safe, label %risky
safe:
  ret i32 7
risky:
  %z = icmp eq i32 %b, 0
  br i1 %z, label %bail, label %go
bail:
  ret i32 0
go:
  %q = sdiv i32 %a, %b
  ret i32 %q
}
