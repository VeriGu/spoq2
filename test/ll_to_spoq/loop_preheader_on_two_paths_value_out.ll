; The same two-path preheader as loop_preheader_on_two_paths.ll, with a value
; carried out of the loop and read below it.
;
; `%sum.next` is defined in the loop and used by the phi at `join`, so it has to
; be passed out and bound at every call site the loop gets. That is what makes
; this case able to tell a correct fix from a plausible one: the bare fixture's
; loop returns nothing anyone reads, so a second call site that carries the
; wrong values -- or a definition built from an empty body -- still produces a
; closed, well-formed spec.

define i32 @vuln(i32 %n, i32 %m) {
entry:
  %c0 = icmp sgt i32 %n, 0
  br i1 %c0, label %A, label %B

A:
  %c1 = icmp sgt i32 %n, 5
  br i1 %c1, label %P, label %X

B:
  br label %P

X:
  br label %join

P:
  br label %loop

loop:
  %i = phi i32 [ 0, %P ], [ %i.next, %loop ]
  %sum = phi i32 [ %n, %P ], [ %sum.next, %loop ]
  %sum.next = add nsw i32 %sum, %i
  %i.next = add nsw i32 %i, 1
  %cc = icmp slt i32 %i.next, %m
  br i1 %cc, label %loop, label %join

join:
  %r = phi i32 [ 0, %X ], [ %sum.next, %loop ]
  %out = add nsw i32 %r, 7
  ret i32 %out
}
