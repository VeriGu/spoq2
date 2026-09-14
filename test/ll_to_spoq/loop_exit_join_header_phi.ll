; Signature stability: a header phi whose initial value comes from outside the
; loop, and which is itself what escapes.  The header_phi machinery supplies the
; initial value positionally at the call site, so it must NOT also become a
; pass_in -- that would widen every loop that has one.

define i32 @vuln(i32 noundef %n, i32 noundef %seed) local_unnamed_addr {
entry:
  %cmp = icmp sgt i32 %n, 0
  br i1 %cmp, label %loop.ph, label %skip

loop.ph:
  %init = mul nsw i32 %seed, 2
  br label %loop

loop:
  %i = phi i32 [ 0, %loop.ph ], [ %i.next, %loop ]
  %acc = phi i32 [ %init, %loop.ph ], [ %acc.next, %loop ]
  %acc.next = add nsw i32 %acc, %i
  %i.next = add nsw i32 %i, 1
  %c = icmp slt i32 %i.next, %n
  br i1 %c, label %loop, label %loop.exit

loop.exit:
  br label %join

skip:
  br label %join

join:
  %r = phi i32 [ %acc, %loop.exit ], [ 0, %skip ]
  ret i32 %r
}
