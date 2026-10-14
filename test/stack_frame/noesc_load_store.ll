; %q is loaded from memory, so it cannot have the provenance of %x, whose
; address never escapes: the store through %q leaves %x holding &g, and the
; reload resolves (rely_unaddressable).
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@g = dso_local global i32 0, align 4

declare void @init(ptr captures(none), ptr captures(none))
declare void @sink(ptr)

define dso_local ptr @f_vuln(ptr %h, ptr %a) {
entry:
  %x = alloca ptr, align 8
  %y = alloca i32, align 4
  call void @init(ptr %x, ptr %y)
  store ptr @g, ptr %x, align 8
  %q = load ptr, ptr %h, align 8
  store i32 1, ptr %q, align 4
  %v = load ptr, ptr %x, align 8
  ret ptr %v
}

define dso_local ptr @f_patch(ptr %h, ptr %a) {
entry:
  %x = alloca ptr, align 8
  %y = alloca i32, align 4
  call void @init(ptr %x, ptr %y)
  store ptr @g, ptr %x, align 8
  %q = load ptr, ptr %h, align 8
  store i32 1, ptr %q, align 4
  %v = load ptr, ptr %x, align 8
  ret ptr @g
}
