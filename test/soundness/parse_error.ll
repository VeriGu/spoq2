; The .main.v writes a negation outside the parentheses the grammar requires,
; `~ (...)`.  The parser's error recovery would drop the `~` and analyse the
; relation without it; spoq must stop instead.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i32 @vuln() {
entry:
  ret i32 0
}

define dso_local i32 @patch() {
entry:
  ret i32 0
}
