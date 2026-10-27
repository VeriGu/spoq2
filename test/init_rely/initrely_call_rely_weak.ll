; Negative control for initrely_call_rely: checked_pos returns Some (x >? -5),
; which allows x <= 0, where the vuln returns 2 and the patch 1.
;
;   vuln:  0 < x < 1000 ? 1 : 2
;   patch: 1

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i32 @f_vuln(i32 %x) {
entry:
  %pos = icmp sgt i32 %x, 0
  %small = icmp slt i32 %x, 1000
  %in = and i1 %pos, %small
  br i1 %in, label %one, label %two
one:
  ret i32 1
two:
  ret i32 2
}

define dso_local i32 @f_patch(i32 %x) {
entry:
  ret i32 1
}
