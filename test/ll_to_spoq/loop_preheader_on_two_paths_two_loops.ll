; Two independent loops, each entered on two paths.  Loop spec names are handed
; out in first-touch order and memoised per preheader, so duplicated entries
; must not consume a name each: the two loops have to stay _loop_0_ and
; _loop_1_, one definition apiece, with two call sites each.

define i32 @vuln(i32 %n, i32 %m) {
entry:
  %c0 = icmp sgt i32 %n, 0
  br i1 %c0, label %A1, label %B1

A1:
  %c1 = icmp sgt i32 %n, 5
  br i1 %c1, label %P1, label %X1

B1:
  br label %P1

X1:
  br label %mid

P1:
  br label %loop1

loop1:
  %i = phi i32 [ 0, %P1 ], [ %i.next, %loop1 ]
  %s1 = phi i32 [ %n, %P1 ], [ %s1.next, %loop1 ]
  %s1.next = add nsw i32 %s1, %i
  %i.next = add nsw i32 %i, 1
  %cc1 = icmp slt i32 %i.next, %m
  br i1 %cc1, label %loop1, label %mid

mid:
  %r1 = phi i32 [ 0, %X1 ], [ %s1.next, %loop1 ]
  %d0 = icmp sgt i32 %r1, 3
  br i1 %d0, label %A2, label %B2

A2:
  %d1 = icmp sgt i32 %r1, 7
  br i1 %d1, label %P2, label %X2

B2:
  br label %P2

X2:
  br label %join

P2:
  br label %loop2

loop2:
  %j = phi i32 [ 0, %P2 ], [ %j.next, %loop2 ]
  %s2 = phi i32 [ %r1, %P2 ], [ %s2.next, %loop2 ]
  %s2.next = mul nsw i32 %s2, 2
  %j.next = add nsw i32 %j, 1
  %cc2 = icmp slt i32 %j.next, %m
  br i1 %cc2, label %loop2, label %join

join:
  %r2 = phi i32 [ 0, %X2 ], [ %s2.next, %loop2 ]
  %out = add nsw i32 %r2, 7
  ret i32 %out
}
