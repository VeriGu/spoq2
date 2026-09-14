; A value defined in the *inner* loop escaping past both loops, through a join
; below the outer loop that also has a path skipping both.  %prod has to be
; passed out of the inner loop and then out of the outer one, which is the
; recursive walk in recursive_update_pass rather than a single level.

define i32 @vuln(i32 noundef %n, i32 noundef %m) local_unnamed_addr {
entry:
  %cmp = icmp sgt i32 %n, 0
  br i1 %cmp, label %outer.ph, label %skip

outer.ph:
  br label %outer

outer:
  %oi = phi i32 [ 0, %outer.ph ], [ %oi.next, %outer.latch ]
  %oacc = phi i32 [ 0, %outer.ph ], [ %prod, %outer.latch ]
  br label %inner.ph

inner.ph:
  br label %inner

inner:
  %ii = phi i32 [ 0, %inner.ph ], [ %ii.next, %inner ]
  %iacc = phi i32 [ %oacc, %inner.ph ], [ %prod, %inner ]
  %prod = add nsw i32 %iacc, %ii
  %ii.next = add nsw i32 %ii, 1
  %ic = icmp slt i32 %ii.next, %m
  br i1 %ic, label %inner, label %inner.exit

inner.exit:
  br label %outer.latch

outer.latch:
  %oi.next = add nsw i32 %oi, 1
  %oc = icmp slt i32 %oi.next, %n
  br i1 %oc, label %outer, label %outer.exit

outer.exit:
  br label %join

skip:
  br label %join

join:
  %r = phi i32 [ %prod, %outer.exit ], [ -1, %skip ]
  ret i32 %r
}
