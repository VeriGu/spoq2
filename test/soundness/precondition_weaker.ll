; The precondition relates states that agree on the globals only, but spoq
; starts both sides from one state, which assumes they agree everywhere.  Two
; states related this way can differ on the stack, and neither function
; touches it, so the postcondition st = st_sim does not follow: the refinement
; does not hold as stated and must not be reported as verified.
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
