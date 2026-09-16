; End-to-end: the patch is a refinement only because reading past a global is
; undefined.
;
;   vuln()  = table[pick()]
;   patch() = 0 <= pick() < 256 ? table[pick()] : 0
;
; `pick` is an oracle, so the index is arbitrary.  The two agree wherever the
; index is in range; where it is not, the patch returns 0 and the vuln reads
; off the end of `table`.  The refinement therefore holds exactly when
; load_global bounds the access by the global's extent -- with an unbounded
; global the vuln has a defined value out of range and the two differ.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@table = internal global [256 x i8] zeroinitializer, align 16

declare dso_local i32 @pick()

define dso_local i32 @vuln() {
entry:
  %i = call i32 @pick()
  %x = sext i32 %i to i64
  %p = getelementptr inbounds [256 x i8], ptr @table, i64 0, i64 %x
  %v = load i8, ptr %p, align 1
  %z = zext i8 %v to i32
  ret i32 %z
}

define dso_local i32 @patch() {
entry:
  %i = call i32 @pick()
  %ge = icmp sgt i32 %i, -1
  br i1 %ge, label %chk, label %out

chk:
  %lt = icmp slt i32 %i, 256
  br i1 %lt, label %in, label %out

in:
  %x = sext i32 %i to i64
  %p = getelementptr inbounds [256 x i8], ptr @table, i64 0, i64 %x
  %v = load i8, ptr %p, align 1
  %z = zext i8 %v to i32
  ret i32 %z

out:
  ret i32 0
}
