; The same for the remainder: srem/urem map to MOD, which is undefined at zero
; for exactly the same reason, and needs the same guard.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
declare dso_local i32 @pick()
define dso_local i32 @vuln(i32 %a) {
entry:
  %b = call i32 @pick()
  %r = urem i32 %a, %b
  ret i32 %r
}
define dso_local i32 @patch(i32 %a) {
entry:
  %b = call i32 @pick()
  %z = icmp eq i32 %b, 0
  br i1 %z, label %bail, label %go
bail:
  ret i32 0
go:
  %r = urem i32 %a, %b
  ret i32 %r
}
