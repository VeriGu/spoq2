; Neither arm of the If writes %x, whose value before it is unknown: the writable
; call @ext2 sets it.  One arm stores to %y, the other does nothing.  The join
; keeps the If as one bound state (the phi %k, with the hoist budget at 1), and the
; reload of %x after it is read from the state before the If, where every arm
; leaves the slot unchanged.

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare void @init(ptr captures(none), ptr captures(none))
declare void @ext2(ptr captures(none))
declare void @use(i32)

define dso_local ptr @f_vuln(i32 %c) {
entry:
  %x = alloca ptr, align 8
  %y = alloca i32, align 4
  call void @init(ptr %x, ptr %y)
  call void @ext2(ptr %x)
  %t = icmp eq i32 %c, 0
  br i1 %t, label %a, label %b
a:
  store i32 1, ptr %y, align 4
  br label %m
b:
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
  call void @ext2(ptr %x)
  %t = icmp eq i32 %c, 0
  br i1 %t, label %a, label %b
a:
  store i32 1, ptr %y, align 4
  br label %m
b:
  br label %m
m:
  %k = phi i32 [ 1, %a ], [ 2, %b ]
  call void @use(i32 %k)
  %v = load ptr, ptr %x, align 8
  ret ptr %v
}
