; The range of a truncation.
;
; `trunc i64 to i32` keeps the low 32 bits, so the result is in an i32's range
; whatever the input was.  With the cast as the identity it would be the
; oracle's unconstrained Z and neither bound would hold.

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare dso_local i64 @pick64()

define dso_local i32 @vuln() {
entry:
  %a = call i64 @pick64()
  %t = trunc i64 %a to i32
  ret i32 %t
}
