; ptrtoint carries an obligation rather than narrowing.
;
; An address wider than the pointer type cannot arise from a defined program --
; forming a pointer more than one element past its object is undefined -- so the
; conversion relies on the address fitting instead of wrapping it.  That makes
; an address that does not fit a reported problem rather than one silently
; reduced to a number that aliases a real object.
;
; Without the obligation `ptr_to_int p` is an unconstrained Z and neither bound
; holds.

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i64 @vuln(ptr %p) {
entry:
  %a = ptrtoint ptr %p to i64
  ret i64 %a
}
