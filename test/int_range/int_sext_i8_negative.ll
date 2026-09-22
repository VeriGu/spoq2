; Sign extension reads the top bit; zero extension does not.
;
; An i8 holding 0xFF is -1 signed and 255 unsigned, so the two extensions of it
; differ by 256.  Neither reading is the identity on the other, which is what
; makes this the case that fixes the representation's signedness: on a signed
; residue `sext` is the identity and `zext` adds 2^8 to a negative value.
;
; The multiply by zero keeps 0xFF an instruction rather than a literal, and the
; function branch-free.  With both casts the identity the difference is 0.

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare dso_local i8 @pick8()

define dso_local i32 @vuln() {
entry:
  %a = call i8 @pick8()
  %zero = mul i8 %a, 0
  %v = add i8 %zero, -1
  %s = sext i8 %v to i32
  %u = zext i8 %v to i32
  %d = sub i32 %u, %s
  ret i32 %d
}
