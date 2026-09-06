; A single `select`, straight-line, nothing else going on.
;
; select is NOT handled by the translator: SpoqIRTranslator.cpp mentions
; SelectInst nowhere.  It is removed earlier, by control_flow_eliminate_select
; (SpoqIRCFG.cpp:133), which is Phase 1 of control_flow_conversion_v2.  So with
; the CFG pass skipped a select arrives at translation unhandled -- this fixture
; pins what that does.
;
; Shape taken from the `||` short-circuit chain in ffm001, e.g.
;   %cmp301    = icmp eq i32 %13, 50
;   %or.cond40 = select i1 %or.cond39, i1 true, i1 %cmp301
; See translate_select_chain.ll for why that chain is expensive.

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i32 @vuln(i32 %x) {
entry:
  %cmp = icmp eq i32 %x, 50
  %sel = select i1 %cmp, i32 100, i32 200
  ret i32 %sel
}
