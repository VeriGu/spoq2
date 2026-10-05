; a pointer-valued slot given to a readonly parameter

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@g = dso_local global i32 0, align 4
@gp = dso_local global ptr null, align 8

declare void @init(ptr captures(none))
declare void @ext(ptr readonly captures(none))

define dso_local ptr @f_vuln() {
entry:
  %x = alloca ptr, align 8
  call void @init(ptr %x)
  store ptr @g, ptr %x, align 8
  call void @ext(ptr %x)
  %v = load ptr, ptr %x, align 8
  ret ptr %v
}

define dso_local ptr @f_patch() {
entry:
  %x = alloca ptr, align 8
  call void @init(ptr %x)
  store ptr @g, ptr %x, align 8
  call void @ext(ptr %x)
  %v = load ptr, ptr %x, align 8
  ret ptr @g
}
