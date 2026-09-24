; Demand unfolding inlines g where the first vuln leaf fails below the call,
; simplified under that leaf's path condition (n < 64), where g is 1.  Written
; into the shared patch tree, that body answers for the second leaf too, where
; g is 3 and the vuln returns 1.  The patch is wrong for n >= 64.
;
;   vuln(n)  = 1
;   patch(n) = g(n)
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i32 @vuln(i32 noundef %n) {
entry:
  %c = icmp slt i32 %n, 64
  br i1 %c, label %a, label %b
a:
  ret i32 1
b:
  ret i32 1
}

; g(n) = n < 64 ? 1 : 3
define dso_local i32 @g(i32 noundef %n) noinline {
entry:
  %c = icmp slt i32 %n, 64
  %r = select i1 %c, i32 1, i32 3
  ret i32 %r
}

define dso_local i32 @patch(i32 noundef %n) {
entry:
  %r = call i32 @g(i32 %n)
  ret i32 %r
}
