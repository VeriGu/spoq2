; A value defined in the inner loop that escapes *only* through the outer loop's
; backedge: %prod is the outer loop's carried value, and nothing below the outer
; loop refers to it.  The escape is a use outside the inner loop but inside the
; outer one, so it needs a pass_out at the inner level and nothing beyond it.

define i32 @vuln(i32 noundef %n, i32 noundef %m) local_unnamed_addr {
entry:
  br label %outer

outer:
  %oi = phi i32 [ 0, %entry ], [ %oi.next, %outer.latch ]
  %oacc = phi i32 [ 0, %entry ], [ %prod, %outer.latch ]
  br label %inner

inner:
  %ii = phi i32 [ 0, %outer ], [ %ii.next, %inner ]
  %iacc = phi i32 [ %oacc, %outer ], [ %prod, %inner ]
  %prod = add nsw i32 %iacc, %ii
  %ii.next = add nsw i32 %ii, 1
  %ic = icmp slt i32 %ii.next, %m
  br i1 %ic, label %inner, label %outer.latch

outer.latch:
  %oi.next = add nsw i32 %oi, 1
  %oc = icmp slt i32 %oi.next, %n
  br i1 %oc, label %outer, label %done

done:
  ret i32 %oacc
}
