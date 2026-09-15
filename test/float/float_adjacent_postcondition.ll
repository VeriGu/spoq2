; End-to-end: a function whose control flow turns on a floating point
; comparison, with a postcondition that holds whatever the floats do.
;
;   vuln(x, d) = ((x > 0) ? 1 : 0) + ((sitofp x) * d > 1.0 ? 1 : 0)
;
; This is the requirement itself: verify behaviour *next to* float
; instructions, not behaviour that depends on them.  Nothing is modelled about
; fmul, sitofp or fcmp, so the branch is unresolvable and both arms have to be
; explored -- and the bounds on the return value hold on both.
;
; Also pins that floats do not need configuring: the .main.v says nothing about
; fmul, sitofp, fcmp_ogt or the literal, all of which the translator declares
; on first use.

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i32 @vuln(i32 %x, double %d) {
entry:
  %c = sitofp i32 %x to double
  %m = fmul double %c, %d
  %big = fcmp ogt double %m, 1.000000e+00
  br i1 %big, label %hi, label %lo

hi:
  br label %join

lo:
  br label %join

join:
  %k = phi i32 [ 1, %hi ], [ 0, %lo ]
  %cmp = icmp sgt i32 %x, 0
  %sel = select i1 %cmp, i32 1, i32 0
  %r = add nsw i32 %sel, %k
  ret i32 %r
}
