; A join carrying SEVERAL phis.
;
; LLVM requires every phi to sit at the top of its block, and they all execute
; simultaneously: each reads the value its edge carried into the block, not
; whatever an earlier phi in the same block just produced.  The translator emits
; one `let` per phi, i.e. sequentially, so this fixture exists to pin that the
; sequencing does not change the result.
;
; It does not, by dominance: a phi's incoming value has to dominate the
; terminator of the edge it arrives on, and a definition inside the join block
; dominates none of its predecessors.  So no phi at a join can name a sibling
; phi, and there is no parallel-copy problem to schedule around.  (Loop headers
; *can* have mutually referring phis -- `%a = phi [0,%entry],[%b,%latch]` with
; `%b` the other way round -- and are translated as Fixpoint arguments.)
;
; The three phis below cross their incoming values over deliberately:
;
;   %a    takes then's first value  / else's first value
;   %b    takes then's second       / else's second
;   %mix  takes then's SECOND       / else's FIRST
;
; so binding them in the wrong order, or resolving them all against one edge,
; produces a different arithmetic result rather than something that still
; happens to typecheck.

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i32 @vuln(i32 %x, i32 %y) {
entry:
  %c = icmp sgt i32 %x, %y
  br i1 %c, label %then, label %else

then:
  %t1 = add nsw i32 %x, 1
  %t2 = add nsw i32 %y, 2
  br label %join

else:
  %e1 = sub nsw i32 %x, 3
  %e2 = sub nsw i32 %y, 4
  br label %join

join:
  %a = phi i32 [ %t1, %then ], [ %e1, %else ]
  %b = phi i32 [ %t2, %then ], [ %e2, %else ]
  %mix = phi i32 [ %t2, %then ], [ %e1, %else ]
  %s = add nsw i32 %a, %b
  %r = add nsw i32 %s, %mix
  ret i32 %r
}
