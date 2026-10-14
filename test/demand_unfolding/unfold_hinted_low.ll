; A call to an identity external, mark, whose spec main.v defines and marks
; Hint Unfold.  The low specs are transformed with unfolding off; the hint still
; inlines mark_spec there, so its calls do not accumulate.

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare void @mark(ptr)

define dso_local i32 @f_vuln(i32 %c) {
entry:
  %x = alloca i32, align 4
  call void @mark(ptr %x)
  store i32 5, ptr %x, align 4
  %t = icmp eq i32 %c, 0
  br i1 %t, label %a, label %b
a:
  call void @mark(ptr %x)
  br label %m
b:
  br label %m
m:
  %v = load i32, ptr %x, align 4
  call void @mark(ptr %x)
  ret i32 %v
}

define dso_local i32 @f_patch(i32 %c) {
entry:
  %x = alloca i32, align 4
  call void @mark(ptr %x)
  store i32 5, ptr %x, align 4
  %t = icmp eq i32 %c, 0
  br i1 %t, label %a, label %b
a:
  call void @mark(ptr %x)
  br label %m
b:
  br label %m
m:
  %v = load i32, ptr %x, align 4
  call void @mark(ptr %x)
  ret i32 5
}
