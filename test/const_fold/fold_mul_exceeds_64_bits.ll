; Constant folding of a product that does not fit 64 bits.
;
; rule_simplify_expr folds two integer constants by computing in `unsigned
; long`, so a product wider than 64 bits wraps there: 5000000000 * 5000000000
; is 2.5e19, and the fold gives 6553255926290448384, which is that minus 2^64.
;
; i128 because at i64 the defect is invisible -- the folder's wrap at 2^64 is
; exactly what an i64 multiply does, so the wrong arithmetic gives the right
; answer.  At i128 the width is not one spoq reduces, so the product is meant
; to be exact and the two diverge.

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i128 @vuln() {
entry:
  %m = mul i128 5000000000, 5000000000
  ret i128 %m
}
