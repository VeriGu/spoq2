; A call of llvm.assume, whose spec main.v defines.  The patch adds a guard
; before the call, so the vuln has undefined behaviour where the two differ.

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare void @llvm.assume(i1)

define i32 @scale(i32 %x) {
entry:
  %c = icmp sgt i32 %x, 0
  call void @llvm.assume(i1 %c)
  %r = add nsw i32 %x, 1
  ret i32 %r
}

define i32 @entry_sec0_vuln(i32 %x) {
pv.root:
  %r = call i32 @scale(i32 %x)
  ret i32 %r
}

define i32 @entry_sec0_patch(i32 %x) {
pv.root:
  %c = icmp sgt i32 %x, 0
  br i1 %c, label %a, label %b
a:
  %r = call i32 @scale(i32 %x)
  ret i32 %r
b:
  ret i32 0
}
