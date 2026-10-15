; Negative control for stack_scratch_slot: the patch loop writes keep in place
; of tmp, so the patch reads acc back from keep and does not refine the
; vuln.  The stack frame must not relate keep.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@dumb = dso_local global i32 0, align 4

define dso_local i32 @f_vuln(i32 %n, i32 %k) {
entry:
  %tmp = alloca i32, align 4
  %keep = alloca i32, align 4
  store i32 %k, ptr %keep, align 4
  br label %loop
loop:
  %i = phi i32 [ 0, %entry ], [ %i.next, %loop ]
  %acc = phi i32 [ 0, %entry ], [ %acc.next, %loop ]
  %kv = load volatile i32, ptr %keep, align 4
  %acc.next = add i32 %acc, %kv
  %i.next = add i32 %i, 1
  %c = icmp slt i32 %i.next, %n
  br i1 %c, label %loop, label %exit
exit:
  ret i32 %acc.next
}

define dso_local i32 @f_patch(i32 %n, i32 %k) {
entry:
  %tmp = alloca i32, align 4
  %keep = alloca i32, align 4
  store i32 %k, ptr %keep, align 4
  br label %loop
loop:
  %i = phi i32 [ 0, %entry ], [ %i.next, %loop ]
  %acc = phi i32 [ 0, %entry ], [ %acc.next, %loop ]
  store i32 %acc, ptr %keep, align 4
  %t = load volatile i32, ptr %keep, align 4
  %kv = load volatile i32, ptr %keep, align 4
  %acc.next = add i32 %t, %kv
  %i.next = add i32 %i, 1
  %c = icmp slt i32 %i.next, %n
  br i1 %c, label %loop, label %exit
exit:
  ret i32 %acc.next
}
