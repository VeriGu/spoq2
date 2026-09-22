; Addition at a width wraps at that width.
;
; Two i32 values sum to an i32, so the sum is back in an i32's range whatever
; the operands were.  Over unbounded Z the sum of two unconstrained values is
; unconstrained and neither bound holds.
;
; The bound is the signed window because that is the representation: a value of
; LLVM type iN lies in [-2^(N-1), 2^(N-1)).  Stated on the sum itself rather
; than on a zero extension of it, so the function stays branch-free -- `zext`
; of a possibly-negative value is an `if`, and `Hint Postcondition` states its
; query at a leaf without the path condition that reaches it.

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare dso_local i32 @pick32()

define dso_local i32 @vuln() {
entry:
  %a = call i32 @pick32()
  %b = call i32 @pick32()
  %s = add i32 %a, %b
  ret i32 %s
}
