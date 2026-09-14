; Two loop exits, with a body value escaping through a join below them.  The
; postheader selector has to dispatch among the exits while the value is carried
; out alongside it.

define i32 @vuln(i32 noundef %n, i32 noundef %m) local_unnamed_addr {
entry:
  br label %loop

loop:
  %i = phi i32 [ 0, %entry ], [ %i.next, %latch ]
  %acc = phi i32 [ 0, %entry ], [ %sum, %latch ]
  %sum = add nsw i32 %acc, %i
  %early = icmp sgt i32 %sum, %m
  br i1 %early, label %exit.early, label %latch

latch:
  %i.next = add nsw i32 %i, 1
  %c = icmp slt i32 %i.next, %n
  br i1 %c, label %loop, label %exit.normal

exit.early:
  br label %join

exit.normal:
  br label %join

join:
  %r = phi i32 [ %sum, %exit.early ], [ -1, %exit.normal ]
  ret i32 %r
}
