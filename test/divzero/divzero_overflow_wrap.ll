; TIF003's shape.  **Not implemented**: this asserts the right answer and
; reports a skip until spoq gives it.
;
;   vuln  n = (len + rps - 1) / rps        patch  n = len/rps + (len%rps != 0)
;   both  return strip % n
;
; Over Z the two are the same function -- both are ceil(len/rps) -- so the
; refinement holds and verified: true is what the expected file asks for.  spoq
; cannot relate the two forms, so it reads the patch's None branch as undefined
; behaviour the spec does not have.
;
; The CVE needs the 32-bit add to wrap: len = rps = 0xFFFFFFFF gives n == 0 in
; the vuln and n == 1 in the patch, so the vuln divides by zero.  That much the
; model now has -- an i32 sum is reduced to its width -- so what is left is only
; the first gap, relating the two forms of the ceiling.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
declare dso_local i32 @len()
declare dso_local i32 @rps()
define dso_local i32 @vuln(i32 %strip) {
entry:
  %l = call i32 @len()
  %r = call i32 @rps()
  %rz = icmp eq i32 %r, 0
  br i1 %rz, label %bail, label %go
bail:
  ret i32 0
go:
  %s1 = add i32 %l, %r
  %s2 = sub i32 %s1, 1
  %n = udiv i32 %s2, %r
  %q = urem i32 %strip, %n
  ret i32 %q
}
define dso_local i32 @patch(i32 %strip) {
entry:
  %l = call i32 @len()
  %r = call i32 @rps()
  %rz = icmp eq i32 %r, 0
  br i1 %rz, label %bail, label %go
bail:
  ret i32 0
go:
  %d = udiv i32 %l, %r
  %m = urem i32 %l, %r
  %nz = icmp ne i32 %m, 0
  %inc = zext i1 %nz to i32
  %n = add i32 %d, %inc
  %q = urem i32 %strip, %n
  ret i32 %q
}
