; Diamond WITH a join phi.
;
; Needs no CFG pass.  The arms reconverge at `join`, so each stops there and
; yields the value its edge carries for the phi, and the code after the join is
; emitted once:
;
;   let cmp := (a >? (b)) in
;   when r, st == (
;       if cmp
;       then (let t := (a + (1)) in (Some (t, st)))
;       else (let e := (b - (1)) in (Some (e, st))));
;   (Some (r, st))
;
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i32 @vuln(i32 %a, i32 %b) {
entry:
  %cmp = icmp sgt i32 %a, %b
  br i1 %cmp, label %then, label %else

then:
  %t = add nsw i32 %a, 1
  br label %join

else:
  %e = sub nsw i32 %b, 1
  br label %join

join:
  %r = phi i32 [ %t, %then ], [ %e, %else ]
  ret i32 %r
}
