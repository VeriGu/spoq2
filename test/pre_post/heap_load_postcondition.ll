; The postcondition of a function that loads from the heap.
;
;   get(p) = p->b & 1            postcondition: result <= 1
;
; Proving it walks load_RData's branches with a NoneConditionAccumulator,
; which is copied at each branch and extended below it.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.Inner = type { i32, i32 }

define dso_local i32 @get(ptr %p) {
entry:
  %bp = getelementptr inbounds nuw %struct.Inner, ptr %p, i32 0, i32 1
  %b = load i32, ptr %bp, align 4
  %r = and i32 %b, 1
  ret i32 %r
}
