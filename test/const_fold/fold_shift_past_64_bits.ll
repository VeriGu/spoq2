; Constant folding of a shift by more than 64.
;
; rule_simplify_expr folds a constant shift with C++ `<<` on an `unsigned
; long`, which is undefined for a count of 64 or more.  On x86 the count is
; taken modulo 64, so `shl i128 1, 100` folds to 2^36 = 68719476736 rather than
; 2^100.
;
; The result is not representable as an IntConst either, so the fold cannot be
; corrected by computing it more carefully -- a shift this wide has to be left
; unfolded.

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i128 @vuln() {
entry:
  %s = shl i128 1, 100
  ret i128 %s
}
