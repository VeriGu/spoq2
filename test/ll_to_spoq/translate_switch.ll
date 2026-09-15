; A switch reconverging at one join.  Three cases plus the default, so four
; edges into sw.epilog.

define i32 @vuln(i32 noundef %n) local_unnamed_addr {
entry:
  switch i32 %n, label %sw.default [
    i32 0, label %sw.bb0
    i32 1, label %sw.bb1
    i32 2, label %sw.bb2
  ]

sw.bb0:
  %a0 = add nsw i32 %n, 10
  br label %sw.epilog

sw.bb1:
  %a1 = add nsw i32 %n, 20
  br label %sw.epilog

sw.bb2:
  %a2 = add nsw i32 %n, 30
  br label %sw.epilog

sw.default:
  br label %sw.epilog

sw.epilog:
  %r = phi i32 [ %a0, %sw.bb0 ], [ %a1, %sw.bb1 ], [ %a2, %sw.bb2 ], [ 0, %sw.default ]
  %s = add nsw i32 %r, 1
  ret i32 %s
}
