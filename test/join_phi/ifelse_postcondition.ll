; End-to-end: a function whose result comes from an if-else, with a
; postcondition that must be proved.
;
;   vuln(x) = (x > 0) ? x : -x        /* absolute value */
;
; The point is the join.  `if.end` has two predecessors and a phi merging two
; different SSA values, which is the shape control_flow_clone_and_split exists
; to remove: it clones the join and everything after it, once per incoming
; edge, until no block has two predecessors.  One join costs 4 clone steps
; (2^(N+2)-4 for N=1); see test/ll_to_spoq/README.md for why that matters at
; scale.
;
; Contrast with test/select/select_postcondition.ll, which reaches a two-armed
; spec without any join at all -- a select is translated straight to an If.
; Here the two arms come from the CFG, so this covers the other route.
;
; The phi merges %x and %sub rather than two constants on purpose: constants
; would let the arms collapse during simplification, and then the test would no
; longer show that each cloned path kept its own value.

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i32 @vuln(i32 %x) {
entry:
  %cmp = icmp sgt i32 %x, 0
  br i1 %cmp, label %if.then, label %if.else

if.then:
  br label %if.end

if.else:
  %sub = sub nsw i32 0, %x
  br label %if.end

if.end:
  %r = phi i32 [ %x, %if.then ], [ %sub, %if.else ]
  ret i32 %r
}
