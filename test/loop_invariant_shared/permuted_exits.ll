; Shared loop invariant, permuted exit codes.
;
;   vuln:  for (i = 0; i < n; i++) { x = pick(); if (x == 7) return i; acc += x; }
;          return acc;
;   patch: the same loop, exiting to return acc from the header when x != 7
;          and the count is reached, and to return i from a second block
;
; The translation numbers the exits by exiting block, in loop order, so the
; patch returns the two results under swapped codes.  The exit mapping
; relates them.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare dso_local i32 @pick()

define dso_local i32 @f_vuln(i32 %n) {
entry:
  br label %loop
loop:
  %i = phi i32 [ 0, %entry ], [ %i.next, %latch ]
  %acc = phi i32 [ 0, %entry ], [ %acc.next, %latch ]
  %x = call i32 @pick()
  %hit = icmp eq i32 %x, 7
  br i1 %hit, label %found, label %latch
latch:
  %acc.next = add i32 %acc, %x
  %i.next = add i32 %i, 1
  %c = icmp slt i32 %i.next, %n
  br i1 %c, label %loop, label %done
found:
  ret i32 %i
done:
  ret i32 %acc.next
}

define dso_local i32 @f_patch(i32 %n) {
entry:
  br label %loop
loop:
  %i = phi i32 [ 0, %entry ], [ %i.next, %test ]
  %acc = phi i32 [ 0, %entry ], [ %acc.next, %test ]
  %x = call i32 @pick()
  %acc.next = add i32 %acc, %x
  %i.next = add i32 %i, 1
  %c = icmp slt i32 %i.next, %n
  %miss = icmp ne i32 %x, 7
  %last = xor i1 %c, true
  %stop = and i1 %miss, %last
  br i1 %stop, label %done, label %test
test:
  br i1 %miss, label %loop, label %found
done:
  ret i32 %acc.next
found:
  ret i32 %i
}
