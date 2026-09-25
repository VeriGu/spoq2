; A postcondition proved from a callee's postcondition.
;
;   get(x)   = x & 1             postcondition: result <= 1
;   vuln(x)  = get(x)            postcondition: result <= 1
;   patch(x) = get(x)
;
; get is left folded, so vuln's postcondition follows only from get's,
; stated of the value the call's result pattern binds.  Stating it of a
; separate per-name constant leaves vuln's result unconstrained.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i32 @get(i32 %x) {
entry:
  %r = and i32 %x, 1
  ret i32 %r
}

define dso_local i32 @vuln(i32 %x) {
entry:
  %r = call i32 @get(i32 %x)
  ret i32 %r
}

define dso_local i32 @patch(i32 %x) {
entry:
  %r = call i32 @get(i32 %x)
  ret i32 %r
}
