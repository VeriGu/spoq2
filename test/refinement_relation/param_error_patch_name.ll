; Rejected before the refinement search: the return relation uses y, the patch's
; name for its parameter.  Relations name the vuln's parameters; the patch's
; are bound to them by position, so this has to be x.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@g = dso_local global i32 0, align 4
@h = dso_local global i32 0, align 4

define dso_local i32 @entry_vuln(i32 %x) {
entry:
  %neg = icmp slt i32 %x, 0
  br i1 %neg, label %err, label %ok
err:
  store i32 1, ptr @g, align 4
  ret i32 -1
ok:
  %q = sdiv i32 10, %x
  ret i32 %q
}

define dso_local i32 @entry_patch(i32 %y) {
entry:
  %le = icmp sle i32 %y, 0
  br i1 %le, label %err, label %ok
err:
  ret i32 -1
ok:
  %q = sdiv i32 10, %y
  ret i32 %q
}
