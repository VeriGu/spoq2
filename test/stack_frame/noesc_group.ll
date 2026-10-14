; %z is a pointer slot like %x, and escapes to @sink, so a pointer %q loaded
; from memory may address %z but not %x.  The store of a pointer through %q
; is an arm for both slots' type; under the rely excluding %x the store's
; symbolic key is not %x's slot, and the reload of %x resolves to &g
; (rule_forward_join_slots, with path facts).
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@g = dso_local global i32 0, align 4
@h = dso_local global i32 0, align 4

declare void @init(ptr captures(none), ptr captures(none))
declare void @sink(ptr)
declare void @use(i32)

define dso_local ptr @f_vuln(ptr %h0, i32 %c) {
entry:
  %x = alloca ptr, align 8
  %z = alloca ptr, align 8
  %y = alloca i32, align 4
  call void @init(ptr %x, ptr %y)
  call void @sink(ptr %z)
  store ptr @g, ptr %x, align 8
  %q = load ptr, ptr %h0, align 8
  %t = icmp eq i32 %c, 0
  br i1 %t, label %a, label %b
a:
  store ptr @h, ptr %q, align 8
  br label %m
b:
  store i32 2, ptr %y, align 4
  br label %m
m:
  %k = phi i32 [ 1, %a ], [ 2, %b ]
  call void @use(i32 %k)
  %v = load ptr, ptr %x, align 8
  ret ptr %v
}

define dso_local ptr @f_patch(ptr %h0, i32 %c) {
entry:
  %x = alloca ptr, align 8
  %z = alloca ptr, align 8
  %y = alloca i32, align 4
  call void @init(ptr %x, ptr %y)
  call void @sink(ptr %z)
  store ptr @g, ptr %x, align 8
  %q = load ptr, ptr %h0, align 8
  %t = icmp eq i32 %c, 0
  br i1 %t, label %a, label %b
a:
  store ptr @h, ptr %q, align 8
  br label %m
b:
  store i32 2, ptr %y, align 4
  br label %m
m:
  %k = phi i32 [ 1, %a ], [ 2, %b ]
  call void @use(i32 %k)
  %v = load ptr, ptr %x, align 8
  ret ptr @g
}
