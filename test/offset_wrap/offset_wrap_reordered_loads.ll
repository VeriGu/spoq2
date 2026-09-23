; Minimal case for 64-bit wraparound of pointer offsets under SPOQ_BV_SORTS=1.
;
;   vuln(d)  = a := *(int*)d; b := *(long*)d; b == 0 ? 0 : a + b
;   patch(d) = b := *(long*)d; b == 0 ? 0 : (a := *(int*)d; a + b)
;
; Both read the same address, 4 bytes and 8 bytes.  The two agree wherever
; the reads are in bounds, and where the 4-byte read fails the 8-byte read
; must fail too: `d.poffset + 8 <= size` implies `d.poffset + 4 <= size` in
; Z.  With offsets as 64-bit bitvectors it does not -- at d.poffset = 2^63 - 8
; the first sum wraps negative -- so the patch, which reads 8 bytes first and
; returns 0 when they are zero, looks as if it eliminates the vuln's UB on
; that path, and impl_eliminates_ub flips to true.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i64 @vuln(ptr noundef %d) {
entry:
  %a = load i32, ptr %d, align 4
  %b = load i64, ptr %d, align 8
  %z = icmp eq i64 %b, 0
  br i1 %z, label %zero, label %sum

zero:
  ret i64 0

sum:
  %ae = sext i32 %a to i64
  %r = add i64 %ae, %b
  ret i64 %r
}

define dso_local i64 @patch(ptr noundef %d) {
entry:
  %b = load i64, ptr %d, align 8
  %z = icmp eq i64 %b, 0
  br i1 %z, label %zero, label %sum

zero:
  ret i64 0

sum:
  %a = load i32, ptr %d, align 4
  %ae = sext i32 %a to i64
  %r = add i64 %ae, %b
  ret i64 %r
}
