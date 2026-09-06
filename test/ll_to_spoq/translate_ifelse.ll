; Branching WITHOUT a join phi: each arm returns.
;
; The translator asserts that any PHI node sits in a loop header or postheader
; (dfs_llvm_ir_to_spoq_inst_vec, SpoqIRTranslator.cpp:132).  Removing join phis
; is precisely control_flow_clone_and_split's job -- it clones the diamond so
; the phi disappears -- so a diamond WITH a phi is out of scope when the CFG
; pass is skipped.  See IrTranslation.IfElseWithJoinPhiNeedsCfgPass.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i32 @vuln(i32 %a, i32 %b) {
entry:
  %cmp = icmp sgt i32 %a, %b
  br i1 %cmp, label %then, label %else

then:
  %t = add nsw i32 %a, 1
  ret i32 %t

else:
  %e = sub nsw i32 %b, 1
  ret i32 %e
}
