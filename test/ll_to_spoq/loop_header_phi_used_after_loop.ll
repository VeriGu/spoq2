; A header phi used after the loop by an ordinary instruction, not a phi.
; Translates today, and shows the value carried out twice: once as `acc_after`
; from header_phi and once as `acc` from pass_out.  The second is shadowed by
; bind_loop_results, so it is redundant rather than wrong.

define i32 @vuln(i32 noundef %n) local_unnamed_addr {
entry:
  br label %loop
loop:
  %i = phi i32 [ 0, %entry ], [ %i.next, %loop ]
  %acc = phi i32 [ 0, %entry ], [ %acc.next, %loop ]
  %acc.next = add nsw i32 %acc, %i
  %i.next = add nsw i32 %i, 1
  %c = icmp slt i32 %i.next, %n
  br i1 %c, label %loop, label %exit
exit:
  %z = add nsw i32 %acc, 1
  ret i32 %z
}
