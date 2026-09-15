; A chain of early exits converging on one join, with a loop below it.  Reduced
; from decode_unit_vuln in ffm054, where a fully unrolled 16-way search gives
; `while.end` seventeen predecessors and three seventeen-way phis, and
; `while.body10.lr.ph` below it is a loop preheader.
;
; A ladder is neither a diamond nor a triangle: each rung's taken edge goes to
; the next rung, not to the join, so no arm is a single block reaching it.

define i32 @vuln(i32 noundef %n, i32 noundef %m) local_unnamed_addr {
entry:
  br label %while.body

while.body:
  %c0 = icmp uge i32 %n, 1
  br i1 %c0, label %rung1, label %while.end

rung1:
  %a1 = add nsw i32 %n, 1
  %c1 = icmp uge i32 %n, 2
  br i1 %c1, label %rung2, label %while.end

rung2:
  %a2 = add nsw i32 %a1, 1
  %c2 = icmp uge i32 %n, 3
  br i1 %c2, label %rung3, label %while.end

rung3:
  %a3 = add nsw i32 %a2, 1
  %c3 = icmp uge i32 %n, 4
  br i1 %c3, label %rung4, label %while.end

rung4:
  %a4 = add nsw i32 %a3, 1
  br label %while.end

while.end:
  %x = phi i32 [ 0, %while.body ], [ 1, %rung1 ], [ 2, %rung2 ], [ 3, %rung3 ], [ 4, %rung4 ]
  %acc = phi i32 [ 0, %while.body ], [ %a1, %rung1 ], [ %a2, %rung2 ], [ %a3, %rung3 ], [ %a4, %rung4 ]
  %cmp9 = icmp sgt i32 %m, 0
  br i1 %cmp9, label %loop.lr.ph, label %tail

loop.lr.ph:
  br label %loop

loop:
  %i = phi i32 [ 0, %loop.lr.ph ], [ %i.next, %loop ]
  %sum = phi i32 [ %acc, %loop.lr.ph ], [ %sum.next, %loop ]
  %sum.next = add nsw i32 %sum, %i
  %i.next = add nsw i32 %i, 1
  %cc = icmp slt i32 %i.next, %m
  br i1 %cc, label %loop, label %loop.end

loop.end:
  br label %tail

tail:
  %r = phi i32 [ %x, %while.end ], [ %sum.next, %loop.end ]
  ret i32 %r
}
