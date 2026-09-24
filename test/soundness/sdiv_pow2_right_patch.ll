; LLVM's sdiv truncates toward zero: -7 sdiv 4 = -1.  A modulus or division
; that rounds toward negative infinity gives -2 instead.  A divisor of 2^k is the case the bitvector encoding turns into an arithmetic shift.
; The patch returns the value the vuln computes, so it must verify.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i32 @vuln(i32 noundef %x) {
entry:
  %c = icmp eq i32 %x, -7
  br i1 %c, label %a, label %b
a:
  %r = sdiv i32 %x, 4
  ret i32 %r
b:
  ret i32 0
}

define dso_local i32 @patch(i32 noundef %x) {
entry:
  %c = icmp eq i32 %x, -7
  %r = select i1 %c, i32 -1, i32 0
  ret i32 %r
}
