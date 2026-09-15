; The control: the same branch and loop, with a block between the join and the
; loop header so the join is not itself the preheader.

define i32 @vuln(i32 noundef %n, i32 noundef %m) local_unnamed_addr {
entry:
  %c1 = icmp sgt i32 %n, 0
  br i1 %c1, label %a, label %b

a:
  br label %join

b:
  br label %join

join:
  %seed = add nsw i32 %m, 1
  br label %pre

pre:
  %start = add nsw i32 %seed, 1
  br label %loop

loop:
  %i = phi i32 [ %start, %pre ], [ %i.next, %loop ]
  %i.next = add nsw i32 %i, 1
  %cc = icmp slt i32 %i.next, %n
  br i1 %cc, label %loop, label %exit

exit:
  ret i32 %i
}
