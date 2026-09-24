; An aligned lockstep refinement must not reuse an expression value cached
; under another branch of the patch.
;
;   vuln(pp, n)  = n < 64 ? **pp : 2 * **pp
;   patch(pp, n) = *pp == null ? 0 : (n < 64 ? **pp + 1 : 2 * **pp)
;
; The `n < 64` branches carry the same !pv.align index; the patch's null check
; carries none, so the traversal steps the patch first and walks the vuln under
; each of its branches.  Under the null branch the vuln's second load is
; undefined on both of its paths, and z3_eval decides it to None under that
; path condition.  If that value is reused under the non-null branch, the vuln
; looks undefined there too, and the patch's wrong result goes unchecked.  It
; returns **pp + 1 where the vuln returns **pp, so verification must fail.
;
; SPOQ_HOIST_BUDGET=1 keeps the inlined load_RData body inside the scrutinee
; of its Match, where z3_eval decides it, rather than hoisting it into the
; spec tree; that is the shape lua002 reaches at the default budget.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i32 @vuln(ptr noundef %pp, i32 noundef %n) {
entry:
  %c = icmp slt i32 %n, 64
  br i1 %c, label %deref, label %other, !pv.align !1

deref:
  %v = load ptr, ptr %pp, align 8
  %x = load i32, ptr %v, align 4
  ret i32 %x

other:
  %v2 = load ptr, ptr %pp, align 8
  %x2 = load i32, ptr %v2, align 4
  %d = shl nsw i32 %x2, 1
  ret i32 %d
}

define dso_local i32 @patch(ptr noundef %pp, i32 noundef %n) {
entry:
  %v0 = load ptr, ptr %pp, align 8
  %isnull = icmp eq ptr %v0, null
  br i1 %isnull, label %early, label %body

early:
  ret i32 0

body:
  %c = icmp slt i32 %n, 64
  br i1 %c, label %deref, label %other, !pv.align !1

deref:
  %v = load ptr, ptr %pp, align 8
  %x = load i32, ptr %v, align 4
  %y = add nsw i32 %x, 1
  ret i32 %y

other:
  %v2 = load ptr, ptr %pp, align 8
  %x2 = load i32, ptr %v2, align 4
  %d = shl nsw i32 %x2, 1
  ret i32 %d
}

!1 = !{i64 1}
