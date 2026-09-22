; A mask bounds the value it produces.
;
; `x & 255` keeps the low eight bits, so the result is 0..255 whatever x was.
; The bitwise operations are uninterpreted functions over Z -- `land`, `lor`,
; `lxor` -- so without the bitvector encoding the solver knows nothing about
; them and neither bound holds.  Nothing in the synthetic corpus uses one, so
; this is the case that exercises the encoding.
;
; The range on x is what lets the encoding apply: two's complement at 64 bits
; agrees with Z.land only for an operand the width holds, so the exact form is
; guarded by both operands fitting and x's range discharges the guard.

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare dso_local i32 @pick32()

define dso_local i32 @vuln() {
entry:
  %a = call i32 @pick32()
  %m = and i32 %a, 255
  ret i32 %m
}
