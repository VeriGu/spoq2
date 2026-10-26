; f_vuln, f_patch and g form a call cycle that no function outside it calls.
; %x and %y are distinct allocas of one type, so the reload of %x yields 1.
; With per-type slot names, an alloca on such a cycle gets index 0, so %x and
; %y share a slot and the reload yields 2.

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare void @init(ptr captures(none), ptr captures(none))

define dso_local void @g(i32 %n) {
entry:
  %c = icmp eq i32 %n, 0
  br i1 %c, label %done, label %rec
rec:
  %a = call i32 @f_vuln(i32 0)
  %b = call i32 @f_patch(i32 0)
  br label %done
done:
  ret void
}

define dso_local i32 @f_vuln(i32 %n) {
entry:
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  call void @init(ptr %x, ptr %y)
  store i32 1, ptr %x, align 4
  store i32 2, ptr %y, align 4
  %v = load i32, ptr %x, align 4
  call void @g(i32 %n)
  ret i32 %v
}

define dso_local i32 @f_patch(i32 %n) {
entry:
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  call void @init(ptr %x, ptr %y)
  store i32 1, ptr %x, align 4
  store i32 2, ptr %y, align 4
  %v = load i32, ptr %x, align 4
  call void @g(i32 %n)
  ret i32 1
}
