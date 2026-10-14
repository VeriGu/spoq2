; Both arms of an If leave the pointer slot %x holding &g, and the join keeps
; the If as one bound state (the phi %k, with the hoist budget at 1).  The reload
; of %x after the join is resolved to &g: every Some result of the If writes the
; slot with that value (rule_forward_join_slots).
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@g = dso_local global i32 0, align 4
@h = dso_local global i32 0, align 4

declare void @init(ptr captures(none), ptr captures(none))
declare void @ext(ptr readonly captures(none))
declare void @ext2(ptr captures(none))
declare void @use(i32)

define dso_local ptr @f_vuln(i32 %c) {
entry:
  %x = alloca ptr, align 8
  %y = alloca i32, align 4
  call void @init(ptr %x, ptr %y)
  store ptr @g, ptr %x, align 8
  %t = icmp eq i32 %c, 0
  br i1 %t, label %a, label %b
a:
  call void @ext(ptr %x)
  store i32 1, ptr %y, align 4
  br label %m
b:
  call void @ext2(ptr %y)
  br label %m
m:
  %k = phi i32 [ 1, %a ], [ 2, %b ]
  call void @use(i32 %k)
  %v = load ptr, ptr %x, align 8
  ret ptr %v
}

define dso_local ptr @f_patch(i32 %c) {
entry:
  %x = alloca ptr, align 8
  %y = alloca i32, align 4
  call void @init(ptr %x, ptr %y)
  store ptr @g, ptr %x, align 8
  %t = icmp eq i32 %c, 0
  br i1 %t, label %a, label %b
a:
  call void @ext(ptr %x)
  store i32 1, ptr %y, align 4
  br label %m
b:
  call void @ext2(ptr %y)
  br label %m
m:
  %k = phi i32 [ 1, %a ], [ 2, %b ]
  call void @use(i32 %k)
  %v = load ptr, ptr %x, align 8
  ret ptr @g
}
