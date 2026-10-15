; Shared loop invariant, partial state equality on the globals.
;
;   vuln:  for (i = 0; i < n; i++) acc += i;  dumb = acc;  return dumb + keep;
;   patch: for (i = 0; i < n; i++) { dumb = acc; acc = dumb + i; dumb = acc; }
;          dumb = acc;  return dumb + keep;
;
; The patch writes the global dumb on every iteration, and both store acc to
; it after the loop.  R relates the globals field by field, keep included,
; and the heaps and stacks in full.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@dumb = dso_local global i32 0, align 4
@keep = dso_local global i32 0, align 4

define dso_local i32 @f_vuln(i32 %n) {
entry:
  br label %loop
loop:
  %i = phi i32 [ 0, %entry ], [ %i.next, %loop ]
  %acc = phi i32 [ 0, %entry ], [ %acc.next, %loop ]
  %acc.next = add i32 %acc, %i
  %i.next = add i32 %i, 1
  %c = icmp slt i32 %i.next, %n
  br i1 %c, label %loop, label %exit
exit:
  store i32 %acc.next, ptr @dumb, align 4
  %d = load i32, ptr @dumb, align 4
  %k = load i32, ptr @keep, align 4
  %r = add i32 %d, %k
  ret i32 %r
}

define dso_local i32 @f_patch(i32 %n) {
entry:
  br label %loop
loop:
  %i = phi i32 [ 0, %entry ], [ %i.next, %loop ]
  %acc = phi i32 [ 0, %entry ], [ %acc.next, %loop ]
  store i32 %acc, ptr @dumb, align 4
  %t = load volatile i32, ptr @dumb, align 4
  %acc.next = add i32 %t, %i
  store i32 %acc.next, ptr @dumb, align 4
  %i.next = add i32 %i, 1
  %c = icmp slt i32 %i.next, %n
  br i1 %c, label %loop, label %exit
exit:
  store i32 %acc.next, ptr @dumb, align 4
  %d = load i32, ptr @dumb, align 4
  %k = load i32, ptr @keep, align 4
  %r = add i32 %d, %k
  ret i32 %r
}
