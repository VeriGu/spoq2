; Control of hint_match_true_arm: the same module; the invariant compares
; the block itself, with no match.  Passes today.
;
; A match arm whose value is true is replaced by another arm's value.
;
;   vuln(n)  = for (i = 0; i < n; i++) ; return 0      (the loop keeps st)
;   patch(n) = 0
;
; The invariant  blk_cell (st @ 0) = blk_cell (st_old @ 0)  holds: the loop
; does not change the state.  blk_cell is a match on the block, unfolded
; into nested matches on st and st_old.  Where an iteration leaves st as
; st_old, the arm comparing the two cells simplifies to true, and z3_eval
; of the match then takes the other arm's value (the instantiate-Exists
; optimization), so the check reports the invariant not inductive.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i32 @vuln(i32 noundef %n) {
entry:
  br label %loop
loop:
  %i = phi i32 [ 0, %entry ], [ %i.next, %loop ]
  %i.next = add i32 %i, 1
  %c = icmp slt i32 %i.next, %n
  br i1 %c, label %loop, label %exit
exit:
  ret i32 0
}

define dso_local i32 @patch(i32 noundef %n) {
entry:
  ret i32 0
}
