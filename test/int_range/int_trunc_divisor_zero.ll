; png001's shape: a truncation that can make a divisor zero.
;
;   vuln   rf = (uint32_t)(width * channels + 1);  4294967295 / rf
;   patch  rf =            width * channels + 1;   4294967295 / rf
;
; width*channels+1 is at least 1, so the patch never divides by zero.  Truncated
; to 32 bits it is zero whenever width*channels is 2^32-1, which 1431655765 * 3
; reaches, so the vuln does.  The patch removes that undefined behaviour.
;
; The quotient is returned rather than discarded, because a dead one is
; eliminated before enforce_no_div_by_zero can guard it.  That also makes the
; two disagree where both are defined -- the truncated divisor is a different
; number -- so the refinement itself does not hold, which is equally true of
; png001: its patch changes the computed limit as well as removing the
; division by zero.
;
; Needs both halves of the representation: the truncation, so the divisor can be
; zero at all, and the range of an i32 and an i8, so width*channels+1 cannot be
; zero in the patch.  With integers unbounded and the casts the identity the two
; functions are the same term, and width*channels = -1 makes both undefined.

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare dso_local i32 @width()
declare dso_local i8 @channels()

define dso_local i64 @vuln() {
entry:
  %w = call i32 @width()
  %c = call i8 @channels()
  %w64 = zext i32 %w to i64
  %c64 = zext i8 %c to i64
  %p = mul i64 %w64, %c64
  %r = add i64 %p, 1
  %t = trunc i64 %r to i32
  %rf = zext i32 %t to i64
  %d = udiv i64 4294967295, %rf
  ret i64 %d
}

define dso_local i64 @patch() {
entry:
  %w = call i32 @width()
  %c = call i8 @channels()
  %w64 = zext i32 %w to i64
  %c64 = zext i8 %c to i64
  %p = mul i64 %w64, %c64
  %r = add i64 %p, 1
  %d = udiv i64 4294967295, %r
  ret i64 %d
}
