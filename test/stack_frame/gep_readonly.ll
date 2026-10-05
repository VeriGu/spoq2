; a GEP of &x to a readonly parameter

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@g = dso_local global i32 0, align 4
@gp = dso_local global ptr null, align 8

declare void @init(ptr captures(none))
declare void @ext(ptr readonly captures(none))

define dso_local i32 @f_vuln() {
entry:
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  call void @init(ptr %x)
  %q = getelementptr inbounds i8, ptr %x, i64 0
  store i32 5, ptr %x, align 4
  call void @ext(ptr %q)
  %v = load i32, ptr %x, align 4
  ret i32 %v
}

define dso_local i32 @f_patch() {
entry:
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  call void @init(ptr %x)
  %q = getelementptr inbounds i8, ptr %x, i64 0
  store i32 5, ptr %x, align 4
  call void @ext(ptr %q)
  %v = load i32, ptr %x, align 4
  ret i32 5
}

