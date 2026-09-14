; Two loop exits reaching a common merge, each carrying a *different* value
; defined inside the loop.  The merge phi has one in-loop incoming per exit, so
; the exit selector alone cannot stand in for the value.

define i32 @vuln(i32 noundef %n, i32 noundef %m) local_unnamed_addr {
entry:
  br label %loop

loop:
  %i = phi i32 [ 0, %entry ], [ %i.next, %latch ]
  %a = mul nsw i32 %i, 3
  %early = icmp sgt i32 %a, %m
  br i1 %early, label %merge, label %latch

latch:
  %b = add nsw i32 %i, 100
  %i.next = add nsw i32 %i, 1
  %c = icmp slt i32 %i.next, %n
  br i1 %c, label %loop, label %merge

merge:
  %x = phi i32 [ %a, %loop ], [ %b, %latch ]
  ret i32 %x
}
