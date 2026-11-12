target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i32 @vuln(ptr noundef %p) {
entry:
  %x = load i32, ptr %p, align 4
  %c = icmp sgt i32 %x, 0
  br i1 %c, label %pos, label %neg
pos:
  ret i32 %x
neg:
  ret i32 0
}

define dso_local i32 @patch(ptr noundef %p) {
entry:
  %x = load i32, ptr %p, align 4
  %c = icmp sgt i32 %x, 0
  br i1 %c, label %pos, label %neg
pos:
  ret i32 %x
neg:
  ret i32 0
}
