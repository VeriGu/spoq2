; Shared loop invariant, added break with UB in a later vuln iteration.
;
;   vuln:  loop { if (c < 0) { if (c < -10) return 100 / 0; c--; continue; }
;                 if (i >= n) break; p = pick(); acc += p; c = p; i++; }
;          return acc;
;   patch: the same with `break` in place of the c < 0 branch
;
; Where the patch breaks, the vuln keeps iterating with c < 0, which persists
; until c < -10 and the division by zero.  The vuln invariant c < 0 shows that
; the vuln never returns from such a state.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare dso_local i32 @pick()

define dso_local i32 @f_vuln(i32 %n, i32 %c0) {
entry:
  br label %loop
loop:
  %i = phi i32 [ 0, %entry ], [ %i, %dloop ], [ %i.next, %body ]
  %c = phi i32 [ %c0, %entry ], [ %c.m, %dloop ], [ %p, %body ]
  %acc = phi i32 [ 0, %entry ], [ %acc, %dloop ], [ %acc.next, %body ]
  %neg = icmp slt i32 %c, 0
  br i1 %neg, label %d, label %norm
d:
  %big = icmp slt i32 %c, -10
  br i1 %big, label %ub, label %dloop
ub:
  %q = sdiv i32 100, 0
  ret i32 %q
dloop:
  %c.m = add i32 %c, -1
  br label %loop
norm:
  %done = icmp sge i32 %i, %n
  br i1 %done, label %exit, label %body
body:
  %p = call i32 @pick()
  %acc.next = add i32 %acc, %p
  %i.next = add i32 %i, 1
  br label %loop
exit:
  ret i32 %acc
}

define dso_local i32 @f_patch(i32 %n, i32 %c0) {
entry:
  br label %loop
loop:
  %i = phi i32 [ 0, %entry ], [ %i.next, %body ]
  %c = phi i32 [ %c0, %entry ], [ %p, %body ]
  %acc = phi i32 [ 0, %entry ], [ %acc.next, %body ]
  %neg = icmp slt i32 %c, 0
  br i1 %neg, label %exit, label %norm
norm:
  %done = icmp sge i32 %i, %n
  br i1 %done, label %exit, label %body
body:
  %p = call i32 @pick()
  %acc.next = add i32 %acc, %p
  %i.next = add i32 %i, 1
  br label %loop
exit:
  ret i32 %acc
}
