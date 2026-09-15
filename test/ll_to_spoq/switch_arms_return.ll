; A switch whose every arm returns, so there is no join below it.  The lowered
; chain becomes nested Ifs with no reconvergence point at any level, and each
; If has to be the last instruction in its arm.

define i32 @vuln(i32 noundef %n) local_unnamed_addr {
entry:
  switch i32 %n, label %sw.default [
    i32 0, label %sw.bb0
    i32 1, label %sw.bb1
    i32 2, label %sw.bb2
  ]

sw.bb0:
  %a0 = add nsw i32 %n, 10
  ret i32 %a0

sw.bb1:
  %a1 = mul nsw i32 %n, 3
  ret i32 %a1

sw.bb2:
  ret i32 -1

sw.default:
  ret i32 0
}
