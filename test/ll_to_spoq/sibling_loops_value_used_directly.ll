; Two sequential loops at the same nesting level.  A value defined in the body of
; the first is used by an ordinary instruction inside the second, so it has to be
; passed out of one loop and into its sibling -- the pass_out-then-pass_in legs of
; recursive_update_pass, rather than a single direction.

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
  %bacc = phi i32 [ 0, %a.exit ], [ %bsum, %b ]
  %bsum = add nsw i32 %bacc, %asum
  %bi.next = add nsw i32 %bi, 1
  %bc = icmp slt i32 %bi.next, %m
  br i1 %bc, label %b, label %b.exit

b.exit:
  ret i32 %bsum
}
