; A right shift whose amount is not a constant, the counterpart of
; shift_by_variable.  The integer encoding divides by a power of two, with the
; same real-valued power.
;
; `lshr` reads its operand as unsigned and `ashr` as signed, so the two are
; separate operations: the first becomes `uns32 a >> n` and the second `a >> n`.
; Their sum is reduced to i32 and lies in an i32's range for every value and
; every amount.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare dso_local i32 @pick()

define dso_local i32 @vuln() {
entry:
  %a = call i32 @pick()
  %n = call i32 @pick()
  %l = lshr i32 %a, %n
  %r = ashr i32 %a, %n
  %s = add i32 %l, %r
  ret i32 %s
}
