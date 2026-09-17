; Division by zero as undefined behaviour: the canonical refinement.
;
;   vuln  = a / pick()
;   patch = pick() == 0 ? 0 : a / pick()
;
; The patch differs only where the vuln divides by zero, so it refines it.
; That holds only if the spec is None there -- with a total division the two
; disagree at b == 0 and nothing is provable.  enforce_no_div_by_zero is what
; puts the `if (b <> 0) ... else None` into the vuln spec.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare dso_local i32 @pick()

define dso_local i32 @vuln(i32 %a) {
entry:
  %b = call i32 @pick()
  %q = sdiv i32 %a, %b
  ret i32 %q
}

define dso_local i32 @patch(i32 %a) {
entry:
  %b = call i32 @pick()
  %z = icmp eq i32 %b, 0
  br i1 %z, label %bail, label %go
bail:
  ret i32 0
go:
  %q = sdiv i32 %a, %b
  ret i32 %q
}
