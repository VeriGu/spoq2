; A short `||` short-circuit chain -- the shape that makes ffm001 explode.
;
; Each `select i1 %prev, i1 true, i1 %cmpN` is what clang emits for one `||`
; term.  control_flow_eliminate_select (SpoqIRCFG.cpp:133) rewrites every one
; of them into a diamond with a join phi:
;
;     select.true.bb / select.true.bridge
;     select.false.bb / select.false.bridge
;     phi at the merge point
;
; control_flow_clone_and_split then clones each diamond to get rid of that phi,
; and its own comment says what that costs:
;
;     EXPONENTIAL BLOWUP WARNING: for a chain of N sequential diamonds, each
;     clone duplicates everything downstream.  This produces 2^N blocks.
;
; So N selects in a row cost 2^N.  ffm001_sws_init_context.ll has 197 selects;
; ffm001_single_block_valuename.ll has 51 in a single basic block, which is why
; a one-block function still takes ~26s to hit the repeats>10000000 guard.
;
; Four terms here: small enough to convert quickly, while being the same shape.
; Raise the count to watch the cost grow.

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; return (x == 49 || x == 50 || x == 65 || x == 64) ? 1 : 0;
define dso_local i32 @vuln(i32 %x) {
entry:
  %cmp0 = icmp eq i32 %x, 49
  %cmp1 = icmp eq i32 %x, 50
  %or1 = select i1 %cmp0, i1 true, i1 %cmp1
  %cmp2 = icmp eq i32 %x, 65
  %or2 = select i1 %or1, i1 true, i1 %cmp2
  %cmp3 = icmp eq i32 %x, 64
  %or3 = select i1 %or2, i1 true, i1 %cmp3
  %res = zext i1 %or3 to i32
  ret i32 %res
}
