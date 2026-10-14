; The loop writes only %y, so %x holds &g in the loop's result state and the
; reload of %x after the loop resolves to &g (the loop write-back).
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@g = dso_local global i32 0, align 4

declare void @init(ptr captures(none), ptr captures(none))
declare void @ext2(ptr captures(none))

define dso_local ptr @f_vuln(i32 %n) {
entry:
  %x = alloca ptr, align 8
  %y = alloca i32, align 4
  call void @init(ptr %x, ptr %y)
  store ptr @g, ptr %x, align 8
  br label %loop
loop:
  %i = phi i32 [ 0, %entry ], [ %i1, %body ]
  %t = icmp slt i32 %i, %n
  br i1 %t, label %body, label %done
body:
  call void @ext2(ptr %y)
  store i32 %i, ptr %y, align 4
  %i1 = add nsw i32 %i, 1
  br label %loop
done:
  %v = load ptr, ptr %x, align 8
  ret ptr %v
}

define dso_local ptr @f_patch(i32 %n) {
entry:
  %x = alloca ptr, align 8
  %y = alloca i32, align 4
  call void @init(ptr %x, ptr %y)
  store ptr @g, ptr %x, align 8
  br label %loop
loop:
  %i = phi i32 [ 0, %entry ], [ %i1, %body ]
  %t = icmp slt i32 %i, %n
  br i1 %t, label %body, label %done
body:
  call void @ext2(ptr %y)
  store i32 %i, ptr %y, align 4
  %i1 = add nsw i32 %i, 1
  br label %loop
done:
  %v = load ptr, ptr %x, align 8
  ret ptr @g
}
