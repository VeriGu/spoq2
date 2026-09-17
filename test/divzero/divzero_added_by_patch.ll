; The soundness direction: a patch may remove undefined behaviour, never add it.
;
;   vuln  = a + pick()
;   patch = a / pick()
;
; Pinned so that a change which guards divisions only in the spec, or drops the
; guard on the impl side, is caught: it would report this as verified.
;
; spec_has_ub is true here even though the vuln has no division -- pick() is an
; oracle and may itself return None.  What this case pins is impl_has_non_spec_ub.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
declare dso_local i32 @pick()
define dso_local i32 @vuln(i32 %a) {
entry:
  %b = call i32 @pick()
  %s = add i32 %a, %b
  ret i32 %s
}
define dso_local i32 @patch(i32 %a) {
entry:
  %b = call i32 @pick()
  %q = sdiv i32 %a, %b
  ret i32 %q
}
