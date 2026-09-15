; The boundaries of the case list, where the lowered chain of equality tests has
; no room for an intermediate block.
;
;   one_case        one case and a default: a single test, no new block at all
;   no_cases        an empty case list: the switch is an unconditional branch
;   case_is_default a case whose target is already the default's, so the test
;                   cannot change where control goes and the case can be dropped

define i32 @one_case(i32 noundef %n) local_unnamed_addr {
entry:
  switch i32 %n, label %sw.default [
    i32 0, label %sw.bb0
  ]

sw.bb0:
  %a0 = add nsw i32 %n, 10
  br label %sw.epilog

sw.default:
  br label %sw.epilog

sw.epilog:
  %r = phi i32 [ %a0, %sw.bb0 ], [ 0, %sw.default ]
  ret i32 %r
}

define i32 @no_cases(i32 noundef %n) local_unnamed_addr {
entry:
  switch i32 %n, label %sw.default [
  ]

sw.default:
  %a = add nsw i32 %n, 1
  ret i32 %a
}

define i32 @case_is_default(i32 noundef %n) local_unnamed_addr {
entry:
  switch i32 %n, label %sw.default [
    i32 0, label %sw.bb0
    i32 1, label %sw.default
  ]

sw.bb0:
  %a0 = add nsw i32 %n, 10
  br label %sw.epilog

sw.default:
  %p = phi i32 [ 5, %entry ], [ 5, %entry ]
  br label %sw.epilog

sw.epilog:
  %r = phi i32 [ %a0, %sw.bb0 ], [ %p, %sw.default ]
  ret i32 %r
}
