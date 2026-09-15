; The same shape with a two-predecessor join, which reconvergence_point does
; recognise.  The control on join_three_preds_before_loop.ll: what fails there is
; the arity of the join, not the presence of a loop below it.

define i32 @vuln(i32 noundef %n, i32 noundef %m) local_unnamed_addr {
entry:
  %c1 = icmp sgt i32 %n, 0
  br i1 %c1, label %a, label %b

a:
  br label %join

b:
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
