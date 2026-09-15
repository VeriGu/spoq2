; A two-path preheader whose loop has two exits, so the postheader dispatches on
; a selector phi and each call site has to destructure it along with the values
; each exit carries.

define i32 @vuln(i32 %n, i32 %m) {
entry:
  %c0 = icmp sgt i32 %n, 0
  br i1 %c0, label %A, label %B

A:
  %c1 = icmp sgt i32 %n, 5
  br i1 %c1, label %P, label %X

B:
  br label %P

X:
  br label %join

P:
  br label %loop

loop:
  %i = phi i32 [ 0, %P ], [ %i.next, %latch ]
  %sum = phi i32 [ %n, %P ], [ %sum.next, %latch ]
  %big = icmp sgt i32 %sum, 100
  br i1 %big, label %exit.early, label %latch

latch:
  %sum.next = add nsw i32 %sum, %i
  %i.next = add nsw i32 %i, 1
  %cc = icmp slt i32 %i.next, %m
  br i1 %cc, label %loop, label %exit.done

exit.early:
  br label %join

exit.done:
  br label %join

join:
  %r = phi i32 [ 0, %X ], [ 1, %exit.early ], [ %sum.next, %exit.done ]
  %out = add nsw i32 %r, 7
  ret i32 %out
}
