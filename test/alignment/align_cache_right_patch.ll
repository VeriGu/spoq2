; Companion of align_cache_wrong_patch: the same vuln, and a patch that is
; correct -- it returns what the vuln does, and 0 only where every vuln path
; dereferences null.  Clearing cached values per patch branch must not cost
; the proof.
;
;   vuln(pp, n)  = n < 64 ? **pp : 2 * **pp
;   patch(pp, n) = *pp == null ? 0 : (n < 64 ? **pp : 2 * **pp)
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
  ret i32 %x

other:
  %v2 = load ptr, ptr %pp, align 8
  %x2 = load i32, ptr %v2, align 4
  %d = shl nsw i32 %x2, 1
  ret i32 %d
}

!1 = !{i64 1}
