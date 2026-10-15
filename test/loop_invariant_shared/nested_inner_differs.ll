; Shared loop invariant, nested loops.
;
;   vuln:  for (j = 0; j < m; j++) { acc = sum of n calls to pick(); total += acc; }
;          a / total
;   patch: the inner loop as in extra_param, which carries a;
;          total == 0 ? 0 : a / total
;
; Neither loop pair is identified.  The relation of the inner loops is
; instantiated inside the product of the outer loops, which then run in
; lockstep.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare dso_local i32 @pick()

define dso_local i32 @f_vuln(i32 %a, i32 %n, i32 %m) {
entry:
  br label %outer
outer:
  %j = phi i32 [ 0, %entry ], [ %j.next, %olatch ]
  %total = phi i32 [ 0, %entry ], [ %total.next, %olatch ]
  br label %inner
inner:
  %i = phi i32 [ 0, %outer ], [ %i.next, %inner ]
  %acc = phi i32 [ 0, %outer ], [ %acc.next, %inner ]
  %p = call i32 @pick()
  %acc.next = add i32 %acc, %p
  %i.next = add i32 %i, 1
  %c = icmp slt i32 %i.next, %n
  br i1 %c, label %inner, label %olatch
olatch:
  %total.next = add i32 %total, %acc.next
  %j.next = add i32 %j, 1
  %oc = icmp slt i32 %j.next, %m
  br i1 %oc, label %outer, label %exit
exit:
  %q = sdiv i32 %a, %total.next
  ret i32 %q
}

define dso_local i32 @f_patch(i32 %a, i32 %n, i32 %m) {
entry:
  br label %outer
outer:
  %j = phi i32 [ 0, %entry ], [ %j.next, %olatch ]
  %total = phi i32 [ 0, %entry ], [ %total.next, %olatch ]
  br label %inner
inner:
  %k = phi i32 [ 0, %outer ], [ %k1, %ilatch ]
  %sum = phi i32 [ 0, %outer ], [ %sum1, %ilatch ]
  %r = call i32 @pick()
  %e = icmp eq i32 %r, %a
  br i1 %e, label %one, label %two
one:
  %s1 = add i32 %sum, %r
  br label %ilatch
two:
  %s2 = add i32 %r, %sum
  br label %ilatch
ilatch:
  %sum1 = phi i32 [ %s1, %one ], [ %s2, %two ]
  %k1 = add i32 %k, 1
  %more = icmp slt i32 %k1, %n
  br i1 %more, label %inner, label %olatch
olatch:
  %total.next = add i32 %total, %sum1
  %j.next = add i32 %j, 1
  %oc = icmp slt i32 %j.next, %m
  br i1 %oc, label %outer, label %exit
exit:
  %z = icmp eq i32 %total.next, 0
  br i1 %z, label %bail, label %go
bail:
  ret i32 0
go:
  %q = sdiv i32 %a, %total.next
  ret i32 %q
}
