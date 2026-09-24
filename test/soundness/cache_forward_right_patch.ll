; Companion of cache_forward_wrong_patch: the patch reads `*p` on both arms of
; the same join, so it agrees with the vuln and must verify.
;
;   vuln(p, n)  = *p
;   patch(p, n) = n < 64 ? *p : *p
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i32 @vuln(ptr noundef %p, i32 noundef %n) {
entry:
  %c = icmp slt i32 %n, 64
  br i1 %c, label %a, label %b
a:
  %x = load i32, ptr %p, align 4
  ret i32 %x
b:
  %y = load i32, ptr %p, align 4
  ret i32 %y
}

define dso_local i32 @patch(ptr noundef %p, i32 noundef %n) {
entry:
  %c = icmp slt i32 %n, 64
  br i1 %c, label %a, label %b
a:
  %x = load i32, ptr %p, align 4
  br label %j
b:
  %y = load i32, ptr %p, align 4
  br label %j
j:
  %r = phi i32 [ %x, %a ], [ %y, %b ]
  ret i32 %r
}
