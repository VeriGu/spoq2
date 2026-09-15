; A switch reconverging at a join with a loop below it -- the shape decode_str
; has in ffm015, where sw.epilog115 merges five edges and loops follow.

define i32 @vuln(i32 noundef %n, i32 noundef %m) local_unnamed_addr {
entry:
  switch i32 %n, label %sw.default [
    i32 0, label %sw.bb0
    i32 1, label %sw.bb1
  ]

sw.bb0:
  %a0 = add nsw i32 %n, 10
  br label %sw.epilog

sw.bb1:
  %a1 = add nsw i32 %n, 20
  br label %sw.epilog

sw.default:
  br label %sw.epilog

sw.epilog:
  %r = phi i32 [ %a0, %sw.bb0 ], [ %a1, %sw.bb1 ], [ 0, %sw.default ]
  br label %loop

loop:
  %i = phi i32 [ 0, %sw.epilog ], [ %i.next, %loop ]
  %sum = phi i32 [ %r, %sw.epilog ], [ %sum.next, %loop ]
  %sum.next = add nsw i32 %sum, %i
  %i.next = add nsw i32 %i, 1
  %cc = icmp slt i32 %i.next, %m
  br i1 %cc, label %loop, label %exit

exit:
  ret i32 %sum.next
}
