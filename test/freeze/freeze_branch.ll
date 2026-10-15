; A `freeze` is translated as its operand.  spoq values are never poison or
; undef, and freeze of a value that is neither is that value (LangRef).
; SimplifyCFG's branch-on-icmp-chain step inserts `freeze i1` on a branch
; condition (ffmpeg ffm001, `switch.early.test`), which spoq rejected.
;
;   vuln(x) = (freeze x > 0) ? 1 : 0, branching on a frozen condition

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i32 @vuln(i32 %x) {
entry:
  %y = freeze i32 %x
  %cmp = icmp sgt i32 %y, 0
  %c = freeze i1 %cmp
  br i1 %c, label %pos, label %other
pos:
  ret i32 1
other:
  ret i32 0
}
