; Two functions that call through the same pointer with the same arguments get
; the same result: an indirect call is one uninterpreted function per call
; signature, applied to the pointer, not one per calling function.
;
;   vuln(fp, x)  = fp(x) + 10 / x                      UB when x == 0
;   patch(fp, x) = x == 0 ? 0 : fp(x) + 10 / x
;
; Refinement needs the two calls of fp to agree, as the vuln's and the
; patch's calls of one method do in mruby CVE-2022-0570's mrb_f_send.

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i32 @vuln(ptr %fp, i32 %x) {
entry:
  %r = call i32 %fp(i32 %x)
  %q = sdiv i32 10, %x
  %s = add i32 %r, %q
  ret i32 %s
}

define dso_local i32 @patch(ptr %fp, i32 %x) {
entry:
  %z = icmp eq i32 %x, 0
  br i1 %z, label %zero, label %call
zero:
  ret i32 0
call:
  %r = call i32 %fp(i32 %x)
  %q = sdiv i32 10, %x
  %s = add i32 %r, %q
  ret i32 %s
}
