; The range of a value of LLVM type i8.
;
; `pick8` returns an i8, so its result is one of 256 bit patterns and `zext` to
; i32 reads it as 0..255.  Without a width on the oracle's result it would be an
; unconstrained Z and neither bound would hold.
;
; An oracle rather than a parameter so the value is opaque: the fact under test
; comes from the type, not from anything the caller passed.

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare dso_local i8 @pick8()

define dso_local i32 @vuln() {
entry:
  %a = call i8 @pick8()
  %z = zext i8 %a to i32
  ret i32 %z
}
