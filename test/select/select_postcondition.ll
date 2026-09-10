; End-to-end: a function whose result comes from a `select`, with a
; postcondition that must be proved.
;
; This is the full pipeline, and the select survives all of it: spoq_inst_to_spec
; translates it straight to an If, so no diamond and no join phi is ever created.
; control_flow_eliminate_select used to expand it here and is no longer called.
; See test/join_phi/ifelse_postcondition.ll for the same two-armed spec reached
; the other way, through a real CFG join.
;
;   vuln(x) = (x > 0) ? 1 : 0
;
; Only one function, and no refinement: the .main.v asserts postconditions
; about vuln alone.

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i32 @vuln(i32 %x) {
entry:
  %cmp = icmp sgt i32 %x, 0
  %sel = select i1 %cmp, i32 1, i32 0
  ret i32 %sel
}
