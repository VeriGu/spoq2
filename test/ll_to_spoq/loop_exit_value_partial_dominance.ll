; A loop value defined on only one path inside the body, escaping through a join.
; It dominates one exiting block and not the other, which is the case
; update_loop_break_return_list substitutes UndefValue for.

define i32 @vuln(i32 noundef %n, i32 noundef %m) local_unnamed_addr {
entry:
  br label %loop

loop:
  %i = phi i32 [ 0, %entry ], [ %i.next, %latch ]
  %c1 = icmp sgt i32 %i, %m
  br i1 %c1, label %side, label %latch

side:
  %v = mul nsw i32 %i, 7
  br label %exit.side

latch:
  %i.next = add nsw i32 %i, 1
  %c = icmp slt i32 %i.next, %n
  br i1 %c, label %loop, label %exit.normal

exit.side:
  br label %join

exit.normal:
  br label %join

join:
  %r = phi i32 [ %v, %exit.side ], [ -2, %exit.normal ]
  ret i32 %r
}
