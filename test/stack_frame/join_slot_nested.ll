; An outer If whose then arm holds an inner If, with no call between the two
; joins, so the outer join's then result is the state the inner join binds.
; With the hoist budget at 1 both joins stay bound states.  The reload of %x
; after the outer join is resolved to &g by following the inner join's results
; (rule_forward_join_slots).
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@g = dso_local global i32 0, align 4

declare void @init(ptr captures(none), ptr captures(none))
declare void @ext(ptr readonly captures(none))
declare void @ext2(ptr captures(none))
declare void @use(i32)

define dso_local ptr @f_vuln(i32 %c, i32 %d) {
entry:
  %x = alloca ptr, align 8
  %y = alloca i32, align 4
  call void @init(ptr %x, ptr %y)
  store ptr @g, ptr %x, align 8
  %t = icmp eq i32 %c, 0
  br i1 %t, label %a, label %b
a:
  %u = icmp eq i32 %d, 0
  br i1 %u, label %a1, label %a2
a1:
  call void @ext(ptr %x)
  store i32 1, ptr %y, align 4
  br label %a3
a2:
  call void @ext2(ptr %y)
  br label %a3
a3:
  %j = phi i32 [ 1, %a1 ], [ 2, %a2 ]
  br label %m
b:
  call void @ext2(ptr %y)
  br label %m
m:
  %k = phi i32 [ %j, %a3 ], [ 2, %b ]
  call void @use(i32 %k)
  %v = load ptr, ptr %x, align 8
  ret ptr %v
}

define dso_local ptr @f_patch(i32 %c, i32 %d) {
entry:
  %x = alloca ptr, align 8
  %y = alloca i32, align 4
  call void @init(ptr %x, ptr %y)
  store ptr @g, ptr %x, align 8
  %t = icmp eq i32 %c, 0
  br i1 %t, label %a, label %b
a:
  %u = icmp eq i32 %d, 0
  br i1 %u, label %a1, label %a2
a1:
  call void @ext(ptr %x)
  store i32 1, ptr %y, align 4
  br label %a3
a2:
  call void @ext2(ptr %y)
  br label %a3
a3:
  %j = phi i32 [ 1, %a1 ], [ 2, %a2 ]
  br label %m
b:
  call void @ext2(ptr %y)
  br label %m
m:
  %k = phi i32 [ %j, %a3 ], [ 2, %b ]
  call void @use(i32 %k)
  %v = load ptr, ptr %x, align 8
  ret ptr @g
}
