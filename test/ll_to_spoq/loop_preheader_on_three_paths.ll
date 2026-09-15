; Three paths into one preheader -- the arity ffm015's decode_str has, where
; sw.bb32 is reached from one case of an outer switch and two of an inner one.
;
; Neither branch above the loop reconverges at it: A does not dominate B or C,
; and B does not dominate A, so no If makes the walk pass through P once.

define i32 @vuln(i32 %n, i32 %m) {
entry:
  %c0 = icmp sgt i32 %n, 0
  br i1 %c0, label %A, label %B

A:
  %c1 = icmp sgt i32 %n, 5
  br i1 %c1, label %P, label %X

B:
  %c2 = icmp sgt i32 %n, 9
  br i1 %c2, label %P, label %C

C:
  br label %P

X:
  br label %join

P:
  br label %loop

loop:
  %i = phi i32 [ 0, %P ], [ %i.next, %loop ]
  %sum = phi i32 [ %n, %P ], [ %sum.next, %loop ]
  %sum.next = add nsw i32 %sum, %i
  %i.next = add nsw i32 %i, 1
  %cc = icmp slt i32 %i.next, %m
  br i1 %cc, label %loop, label %join

join:
  %r = phi i32 [ 0, %X ], [ %sum.next, %loop ]
  %out = add nsw i32 %r, 7
  ret i32 %out
}
