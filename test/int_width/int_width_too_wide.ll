; An integer width the encoding cannot represent is rejected.
;
; kMaxIntWidth is 64: 2^bits has to be an IntConst, which holds an unsigned
; long; the bitwise encoding assumes that width; and there is no bitvector sort
; beyond it.  An i128 therefore has no faithful translation, and translating it
; anyway would produce a value that silently behaves as an unbounded integer --
; wrap and the range relies would both be skipped and the arithmetic would not
; overflow where the machine does.
;
; Rejected at the type, so it is reported whatever the instruction does with it.

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i128 @vuln(i128 %a) {
entry:
  %r = mul i128 %a, 3
  ret i128 %r
}
