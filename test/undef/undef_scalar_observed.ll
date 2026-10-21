; Control for undef_scalar_double: the patch returns a double `undef` where
; the vuln returns 0.0.  An undef may be any value, so the patch does not
; refine the vuln.

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define double @scale(double %x, i32 %n) {
entry:
  br label %loop
loop:
  %i = phi i32 [ 0, %entry ], [ %inc, %loop ]
  %acc = phi double [ %x, %entry ], [ %y, %loop ]
  %y = fadd double %acc, %x
  %inc = add nsw i32 %i, 1
  %c = icmp slt i32 %inc, %n
  br i1 %c, label %loop, label %exit
exit:
  ret double %y
}

define double @entry_sec0_vuln(double %x, i32 %n, i1 %b) {
pv.root:
  br i1 %b, label %a, label %c
a:
  %r = call double @scale(double %x, i32 %n)
  ret double %r
c:
  ret double 0.0
}

define double @entry_sec0_patch(double %x, i32 %n, i1 %b) {
pv.root:
  br i1 %b, label %a, label %c
a:
  %r = call double @scale(double %x, i32 %n)
  br label %j
c:
  br label %j
j:
  %d = phi double [ %r, %a ], [ undef, %c ]
  ret double %d
}
