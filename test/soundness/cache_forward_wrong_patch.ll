; forward_simulation walks the patch once per vuln leaf.  The patch's
; `n < 64 ? *p : 5` is decided under the first leaf's path condition; a value
; cached then and reused under the second leaf reads `*p` where the patch
; returns 5.  The patch is wrong for n >= 64, so verification must fail.
;
; SPOQ_HOIST_BUDGET=1 keeps the If inside its Match's scrutinee, where z3_eval
; decides it.
;
;   vuln(p, n)  = *p
;   patch(p, n) = n < 64 ? *p : 5
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i32 @vuln(ptr noundef %p, i32 noundef %n) {
entry:
  %c = icmp slt i32 %n, 64
  br i1 %c, label %a, label %b
a:
  %x = load i32, ptr %p, align 4
  ret i32 %x
b:
  %y = load i32, ptr %p, align 4
  ret i32 %y
}

define dso_local i32 @patch(ptr noundef %p, i32 noundef %n) {
entry:
  %c = icmp slt i32 %n, 64
  br i1 %c, label %a, label %j
a:
  %x = load i32, ptr %p, align 4
  br label %j
j:
  %r = phi i32 [ %x, %a ], [ 5, %entry ]
  ret i32 %r
}
