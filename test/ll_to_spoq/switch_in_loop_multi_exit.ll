; A switch inside a loop: two cases leave by different exits, the default
; continues.  This is what loop normalisation cannot take unlowered -- it
; redirects every exit edge to the postheader and asserts twice on the way,
; once that an exiting block ends in a branch and once that it has a single
; outgoing edge, and a switch with two escaping cases fails both.
;
; Lowered, each test block carries at most one exit edge, so the loop has three
; ordinary exits: the header, the second test, and the latch.

define i32 @vuln(i32 noundef %n, i32 noundef %m) local_unnamed_addr {
entry:
  br label %loop

loop:
  %i = phi i32 [ 0, %entry ], [ %i.next, %loop.latch ]
  %acc = phi i32 [ 0, %entry ], [ %acc.next, %loop.latch ]
  %k = add nsw i32 %i, %n
  switch i32 %k, label %loop.latch [
    i32 7, label %exit.a
    i32 9, label %exit.b
  ]

loop.latch:
  %acc.next = add nsw i32 %acc, %i
  %i.next = add nsw i32 %i, 1
  %cc = icmp slt i32 %i.next, %m
  br i1 %cc, label %loop, label %exit.c

exit.a:
  ret i32 1

exit.b:
  ret i32 2

exit.c:
  ret i32 %acc.next
}
