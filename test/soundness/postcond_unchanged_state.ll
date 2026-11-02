; Control for postcond_rebound_state: get only reads *q, so the postcondition
; st = st_old holds and is assumed at the call.  The vuln reads *q before get,
; the patch after it; they agree because get leaves the state unchanged.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i32 @get(ptr %q) {
entry:
  %v = load i32, ptr %q, align 4
  ret i32 %v
}

define dso_local i32 @vuln(ptr %q) {
entry:
  %x = load i32, ptr %q, align 4
  %g = call i32 @get(ptr %q)
  %r = add i32 %x, %g
  ret i32 %r
}

define dso_local i32 @patch(ptr %q) {
entry:
  %g = call i32 @get(ptr %q)
  %x = load i32, ptr %q, align 4
  %r = add i32 %x, %g
  ret i32 %r
}
