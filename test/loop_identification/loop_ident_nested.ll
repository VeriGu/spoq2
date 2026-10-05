; Loop identification with a nested loop.  The outer loop specs call the inner
; loop specs, so the outer pair is equal only if the inner pair is, and the
; two pairs are checked together.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare dso_local i32 @pick()

define dso_local i32 @g_vuln(i32 %a, i32 %n) {
entry:
  br label %outer
outer:
  %i = phi i32 [ 0, %entry ], [ %i.next, %outer.latch ]
  %acc = phi i32 [ 0, %entry ], [ %acc.inner, %outer.latch ]
  br label %inner
inner:
  %j = phi i32 [ 0, %outer ], [ %j.next, %inner ]
  %s = phi i32 [ %acc, %outer ], [ %s.next, %inner ]
  %p = call i32 @pick()
  %s.next = add i32 %s, %p
  %j.next = add i32 %j, 1
  %cj = icmp slt i32 %j.next, %i
  br i1 %cj, label %inner, label %outer.latch
outer.latch:
  %acc.inner = phi i32 [ %s.next, %inner ]
  %i.next = add i32 %i, 1
  %ci = icmp slt i32 %i.next, %n
  br i1 %ci, label %outer, label %exit
exit:
  %q = sdiv i32 %a, %acc.inner
  ret i32 %q
}

define dso_local i32 @g_patch(i32 %a, i32 %n) {
entry:
  br label %o
o:
  %x = phi i32 [ 0, %entry ], [ %x1, %o.latch ]
  %t = phi i32 [ 0, %entry ], [ %t.in, %o.latch ]
  br label %in
in:
  %y = phi i32 [ 0, %o ], [ %y1, %in ]
  %u = phi i32 [ %t, %o ], [ %u1, %in ]
  %r = call i32 @pick()
  %u1 = add i32 %u, %r
  %y1 = add i32 %y, 1
  %cy = icmp slt i32 %y1, %x
  br i1 %cy, label %in, label %o.latch
o.latch:
  %t.in = phi i32 [ %u1, %in ]
  %x1 = add i32 %x, 1
  %cx = icmp slt i32 %x1, %n
  br i1 %cx, label %o, label %done
done:
  %z = icmp eq i32 %t.in, 0
  br i1 %z, label %bail, label %go
bail:
  ret i32 0
go:
  %q = sdiv i32 %a, %t.in
  ret i32 %q
}
