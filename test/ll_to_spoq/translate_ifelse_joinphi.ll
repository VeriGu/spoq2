; Diamond WITH a join phi -- out of scope for the CFG-pass bypass.
;
; Translation asserts "PHI node is not in the loop header or postheader"
; (SpoqIRTranslator.cpp:132).  control_flow_clone_and_split would normally have
; cloned the diamond so this phi no longer exists.  Kept to pin that boundary.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i32 @vuln(i32 %a, i32 %b) {
entry:
  %cmp = icmp sgt i32 %a, %b
  br i1 %cmp, label %then, label %else

then:
  %t = add nsw i32 %a, 1
  br label %join

else:
  %e = sub nsw i32 %b, 1
  br label %join

join:
  %r = phi i32 [ %t, %then ], [ %e, %else ]
  ret i32 %r
}
