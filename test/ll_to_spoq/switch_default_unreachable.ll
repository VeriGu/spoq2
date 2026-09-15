; An exhaustive switch, which clang gives an `unreachable` default -- the shape
; of a switch over an enum with every value handled.
;
; The default is on no path to the return, so no block post-dominates entry and
; the arms have no reconvergence point to stop at.  Each one walks the code
; after the join for itself.

define i32 @vuln(i32 noundef %n) local_unnamed_addr {
entry:
  switch i32 %n, label %sw.default [
    i32 0, label %sw.bb0
    i32 1, label %sw.bb1
  ]

sw.bb0:
  %a0 = add nsw i32 %n, 10
  br label %sw.epilog

sw.bb1:
  %a1 = add nsw i32 %n, 20
  br label %sw.epilog

sw.default:
  unreachable

sw.epilog:
  %r = phi i32 [ %a0, %sw.bb0 ], [ %a1, %sw.bb1 ]
  %s = add nsw i32 %r, 1
  ret i32 %s
}
