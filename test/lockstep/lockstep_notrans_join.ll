target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i32 @vuln(ptr noundef %p, i32 noundef %n) {
entry:
  %c = icmp sgt i32 %n, 0
  br i1 %c, label %a, label %j
a:
  %x = load i32, ptr %p, align 4
  br label %j
j:
  %v = phi i32 [ %x, %a ], [ 0, %entry ]
  %d = icmp sgt i32 %v, 5
  br i1 %d, label %big, label %small
big:
  ret i32 1
small:
  ret i32 %v
}

define dso_local i32 @patch(ptr noundef %p, i32 noundef %n) {
entry:
  %c = icmp sgt i32 %n, 0
  br i1 %c, label %a, label %j
a:
  %x = load i32, ptr %p, align 4
  br label %j
j:
  %v = phi i32 [ %x, %a ], [ 0, %entry ]
  %d = icmp sgt i32 %v, 5
  br i1 %d, label %big, label %small
big:
  ret i32 1
small:
  ret i32 %v
}
