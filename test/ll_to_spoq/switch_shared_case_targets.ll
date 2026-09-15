; Two cases sharing one target, so `entry` reaches sw.shared along two edges and
; a phi there holds two entries naming `entry`.  Lowering replaces `entry` with
; a different test block per edge, so each of those entries needs the block its
; own edge now comes from -- renaming them together would leave one test block
; with two entries and the other with none.

define i32 @vuln(i32 noundef %n) local_unnamed_addr {
entry:
  switch i32 %n, label %sw.default [
    i32 0, label %sw.bb0
    i32 1, label %sw.shared
    i32 2, label %sw.shared
  ]

sw.bb0:
  %a0 = add nsw i32 %n, 10
  br label %sw.epilog

sw.shared:
  %p = phi i32 [ 20, %entry ], [ 20, %entry ]
  %a1 = add nsw i32 %n, %p
  br label %sw.epilog

sw.default:
  br label %sw.epilog

sw.epilog:
  %r = phi i32 [ %a0, %sw.bb0 ], [ %a1, %sw.shared ], [ 0, %sw.default ]
  %s = add nsw i32 %r, 1
  ret i32 %s
}
