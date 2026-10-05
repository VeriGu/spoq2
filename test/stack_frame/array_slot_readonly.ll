; an array slot given to a readonly parameter

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@g = dso_local global i32 0, align 4
@gp = dso_local global ptr null, align 8

declare void @init(ptr captures(none))
declare void @ext(ptr readonly captures(none))

define dso_local i32 @f_vuln() {
entry:
  %x = alloca [4 x i32], align 16
  call void @init(ptr %x)
  %e = getelementptr inbounds [4 x i32], ptr %x, i64 0, i64 1
  store i32 7, ptr %e, align 4
  call void @ext(ptr %x)
  %v = load i32, ptr %e, align 4
  ret i32 %v
}

define dso_local i32 @f_patch() {
entry:
  %x = alloca [4 x i32], align 16
  call void @init(ptr %x)
  %e = getelementptr inbounds [4 x i32], ptr %x, i64 0, i64 1
  store i32 7, ptr %e, align 4
  call void @ext(ptr %x)
  %v = load i32, ptr %e, align 4
  ret i32 7
}
