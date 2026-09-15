; A loop preheader reached along two paths that no single branch reconverges at.
;
; `entry` reconverges at `join`, not at P: the arm through X skips the loop
; entirely, so P does not post-dominate `entry`.  A does not reconverge at P
; either -- P's other predecessor is B, which A does not dominate.  So nothing
; makes the walk pass through P once, and it enters the loop from A and again
; from B.
;
; Reduced from decode_str in ffm015, where sw.bb32 is reached from two different
; switches -- one case of the outer switch, and two of the inner one -- and
; while.body39.lr.ph below it is the preheader entered three times.

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
  %i = phi i32 [ 0, %P ], [ %i.next, %loop ]
  %i.next = add nsw i32 %i, 1
  %cc = icmp slt i32 %i.next, %m
  br i1 %cc, label %loop, label %join

join:
  ret i32 0
}
