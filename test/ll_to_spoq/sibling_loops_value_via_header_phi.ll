; The same two sibling loops, but the second loop takes the first loop's body
; value as the initial value of its header phi.  The only use of %asum outside
; loop A is that phi operand.

define i32 @vuln(i32 noundef %n, i32 noundef %m) local_unnamed_addr {
entry:
  br label %a

a:
  %ai = phi i32 [ 0, %entry ], [ %ai.next, %a ]
  %aacc = phi i32 [ 0, %entry ], [ %asum, %a ]
  %asum = add nsw i32 %aacc, %ai
  %ai.next = add nsw i32 %ai, 1
  %ac = icmp slt i32 %ai.next, %n
  br i1 %ac, label %a, label %a.exit

a.exit:
  br label %b

b:
  %bi = phi i32 [ 0, %a.exit ], [ %bi.next, %b ]
  %bacc = phi i32 [ %asum, %a.exit ], [ %bsum, %b ]
  %bsum = mul nsw i32 %bacc, %bi
  %bi.next = add nsw i32 %bi, 1
  %bc = icmp slt i32 %bi.next, %m
  br i1 %bc, label %b, label %b.exit

b.exit:
  ret i32 %bsum
}
