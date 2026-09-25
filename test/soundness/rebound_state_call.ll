; A pattern that re-binds a name in scope binds a new value.
;
;   vuln  = pick(); return 0
;   patch = return 0
;
; pick may change the state, and the postcondition asks for equal final
; states, so the patch is wrong.  The vuln spec binds pick's result state as
; `st`, re-binding the entry state's name.  Equating each value a pattern
; binds with one constant per name equates pick's result state with the entry
; state, and the patch verifies.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare dso_local i32 @pick()

define dso_local i32 @vuln(i32 %a) {
entry:
  %r = call i32 @pick()
  ret i32 0
}

define dso_local i32 @patch(i32 %a) {
entry:
  ret i32 0
}
