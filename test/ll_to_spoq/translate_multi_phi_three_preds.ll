; The same several-phis-in-one-block question, on the other translation path.
;
; translate_multi_phi.ll has a two-predecessor join, which the reconvergence
; check recognises, so its phis are bound together as one tuple by the Let in
; front of the If.  A three-predecessor join is declined -- there is no single
; If whose two arms meet here -- so each phi is instead resolved against the
; edge the walk arrived on and emitted as its own `let`, once per path:
;
;   via a1:  let u := p in  let v := q in  let w := q in  ...
;   via a2:  let u := r2 in let v := s2 in let w := r2 in ...
;   via a3:  let u := r3 in let v := s3 in let w := s3 in ...
;
; That is the path where "phis execute simultaneously" could bite, because the
; bindings really are sequential.  It is still sound: a phi's incoming value
; must dominate the terminator of its edge, so no phi here can name %u, %v or
; %w, and the order they are bound in cannot matter.
;
; %w crosses over on purpose -- it takes a1's SECOND value, a2's FIRST and a3's
; SECOND -- so resolving the wrong edge changes the arithmetic instead of
; producing something that merely still typechecks.
;
; The continuation (`%t`, `%o`, the return) is therefore emitted three times,
; once per path -- which is what reconvergence avoids when it applies.

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i32 @vuln(i32 %x, i32 %y) {
entry:
  %c1 = icmp sgt i32 %x, 0
  br i1 %c1, label %a1, label %rest

rest:
  %c2 = icmp sgt i32 %y, 0
  br i1 %c2, label %a2, label %a3

a1:
  %p = add nsw i32 %x, 1
  %q = add nsw i32 %y, 1
  br label %join

a2:
  %r2 = add nsw i32 %x, 2
  %s2 = add nsw i32 %y, 2
  br label %join

a3:
  %r3 = add nsw i32 %x, 3
  %s3 = add nsw i32 %y, 3
  br label %join

join:
  %u = phi i32 [ %p, %a1 ], [ %r2, %a2 ], [ %r3, %a3 ]
  %v = phi i32 [ %q, %a1 ], [ %s2, %a2 ], [ %s3, %a3 ]
  %w = phi i32 [ %q, %a1 ], [ %r2, %a2 ], [ %s3, %a3 ]
  %t = add nsw i32 %u, %v
  %o = add nsw i32 %t, %w
  ret i32 %o
}
