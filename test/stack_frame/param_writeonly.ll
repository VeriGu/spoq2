; negative control: writeonly parameter given &x

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@g = dso_local global i32 0, align 4
@gp = dso_local global ptr null, align 8

declare void @init(ptr captures(none))
declare void @ext(ptr writeonly captures(none))

define dso_local i32 @f_vuln() {
entry:
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  call void @init(ptr %x)
  store i32 5, ptr %x, align 4
  call void @ext(ptr %x)
  %v = load i32, ptr %x, align 4
  ret i32 %v
}

define dso_local i32 @f_patch() {
entry:
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  call void @init(ptr %x)
  store i32 5, ptr %x, align 4
  call void @ext(ptr %x)
  %v = load i32, ptr %x, align 4
  ret i32 5
}

