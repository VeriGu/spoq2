; trunc to i1 negated by xor with true, then branched on.
;
;   vuln:  b = trunc x to i1;  if (xor b true) then 1 else 0
;   patch: if ((x & 1) == 0) then 1 else 0
;
; An i1 xor is xorb_spec, which takes two Bools.  With the truncated value a
; Z, z3 aborts: "Sort mismatch at argument #1 for function (declare-fun
; xorb_spec.0_call (Bool Bool) Bool) supplied sort is Int".

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i32 @f_vuln(i32 %x) {
entry:
  %b = trunc i32 %x to i1
  %n = xor i1 %b, true
  br i1 %n, label %t, label %f
t:
  ret i32 1
f:
  ret i32 0
}

define dso_local i32 @f_patch(i32 %x) {
entry:
  %a = and i32 %x, 1
  %e = icmp eq i32 %a, 0
  br i1 %e, label %t, label %f
t:
  ret i32 1
f:
  ret i32 0
}
