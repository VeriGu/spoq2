; A join with three predecessors, with a loop below it.  reconvergence_point
; recognises the diamond and the triangle only, so a three-way join is declined
; and each arm walks on to whatever follows -- here the loop's preheader, which
; is then emitted once per arm.

define i32 @vuln(i32 noundef %n, i32 noundef %m) local_unnamed_addr {
entry:
  %c1 = icmp sgt i32 %n, 0
  br i1 %c1, label %a, label %b

a:
  br label %join

b:
  %c2 = icmp sgt i32 %m, 0
  br i1 %c2, label %c, label %join

c:
  br label %join

join:
  br label %loop

loop:
  %i = phi i32 [ 0, %join ], [ %i.next, %loop ]
  %i.next = add nsw i32 %i, 1
  %cc = icmp slt i32 %i.next, %n
  br i1 %cc, label %loop, label %exit

exit:
  ret i32 %i
}
