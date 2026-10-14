; main.v defines is_stack_ptr as a conjunction, so (~ (is_stack_ptr p)) excludes
; no slot: the transformed spec keeps the slot comparisons, as a rule that took
; is_stack_ptr to mean "the base is a stack slot" would not.

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare void @init(ptr captures(none), ptr captures(none), ptr captures(none))

define dso_local i32 @f_vuln(ptr %p) {
entry:
  %x = alloca i32, align 4
  %y = alloca ptr, align 8
  %z = alloca [4 x i32], align 16
  call void @init(ptr %x, ptr %y, ptr %z)
  %q = getelementptr inbounds i8, ptr %p, i64 8
  %v = load i32, ptr %q, align 4
  ret i32 %v
}

define dso_local i32 @f_patch(ptr %p) {
entry:
  %x = alloca i32, align 4
  %y = alloca ptr, align 8
  %z = alloca [4 x i32], align 16
  call void @init(ptr %x, ptr %y, ptr %z)
  %q = getelementptr inbounds i8, ptr %p, i64 8
  %v = load i32, ptr %q, align 4
  ret i32 %v
}
