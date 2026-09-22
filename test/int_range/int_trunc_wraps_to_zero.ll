; Truncation is modular, not the identity.
;
; 2^32 has 32 low zero bits, so `trunc i64 2^32 to i32` is 0 -- this is the
; value png001's MAGMA canary tests for, `row_factor_l == ((size_t)1 << 32)`.
;
; The multiply by zero is what makes 2^32 reach the truncation as an
; instruction rather than as a literal the IR parser could fold, and it keeps
; the function branch-free: `Hint Postcondition` states its query at a leaf
; without the path condition that reaches it, so a guarded value cannot be
; pinned this way.
;
; With the cast as the identity the result is 2^32.

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare dso_local i64 @pick64()

define dso_local i64 @vuln() {
entry:
  %a = call i64 @pick64()
  %zero = mul i64 %a, 0
  %v = add i64 %zero, 4294967296
  %t = trunc i64 %v to i32
  %z = zext i32 %t to i64
  ret i64 %z
}
