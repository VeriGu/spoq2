; Join-forwarding scope case: the specs are in join_scope_body_rebinds.defs.v.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@g = dso_local global i32 0, align 4

declare void @init(ptr captures(none), ptr captures(none))
declare void @use(i32)
declare ptr @mk()
declare ptr @body(i32, i32)
declare ptr @body2(i32, i32)

define dso_local ptr @f_vuln(i32 %c, i32 %d) {
entry:
  %x = alloca ptr, align 8
  %y = alloca i32, align 4
  call void @init(ptr %x, ptr %y)
  store ptr @g, ptr %x, align 8
  %m = call ptr @mk()
  call void @use(i32 0)
  %r = call ptr @body(i32 %c, i32 %d)
  ret ptr %r
}

define dso_local ptr @f_patch(i32 %c, i32 %d) {
entry:
  %x = alloca ptr, align 8
  %y = alloca i32, align 4
  call void @init(ptr %x, ptr %y)
  store ptr @g, ptr %x, align 8
  %m = call ptr @mk()
  call void @use(i32 0)
  %r = call ptr @body2(i32 %c, i32 %d)
  ret ptr %r
}
