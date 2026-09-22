; A left shift whose amount is not a constant.
;
; The integer encoding of a shift multiplies by a power of two, and Z3's power
; is real-valued over the integers.  A constant amount folds to an integer
; literal, so only a variable amount leaves a real in the term, and a real
; reaching wrap32 leaves the width reduction uninterpreted under integer sorts
; and is a sort mismatch under bitvector sorts.  Nothing else in the suite has
; a variable amount; ffm021's nsv_resync does, which is where this was found.
;
; `pick` is an oracle, so neither the value nor the amount is known.  The shift
; is at i32, so its result is reduced to that width and lies in an i32's range
; for every value and every amount.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare dso_local i32 @pick()

define dso_local i32 @vuln() {
entry:
  %a = call i32 @pick()
  %n = call i32 @pick()
  %s = shl i32 %a, %n
  ret i32 %s
}
