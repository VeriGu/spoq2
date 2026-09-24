; Division by a field of a struct embedded in another struct.
;
;   struct Inner { int a; int b; };             size 8
;   struct Outer { int x; struct Inner in; int y; };  size 16, in at 4
;
;   vuln  = 100 / o->in.b
;   patch = o->in.b == 0 ? 0 : 100 / o->in.b
;
; o->in is at offset 4 of a 16-byte object, so its offset is not a multiple
; of sizeof(Inner).  A GEP places no alignment condition on its result; a
; translation that assumes `offset mod sizeof(T) = field offset` for each
; struct GEP makes every path UB here, and the refinement vacuous.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.Inner = type { i32, i32 }
%struct.Outer = type { i32, %struct.Inner, i32 }

define dso_local i32 @vuln(ptr %o) {
entry:
  %in = getelementptr inbounds nuw %struct.Outer, ptr %o, i32 0, i32 1
  %bp = getelementptr inbounds nuw %struct.Inner, ptr %in, i32 0, i32 1
  %b = load i32, ptr %bp, align 4
  %q = sdiv i32 100, %b
  ret i32 %q
}

define dso_local i32 @patch(ptr %o) {
entry:
  %in = getelementptr inbounds nuw %struct.Outer, ptr %o, i32 0, i32 1
  %bp = getelementptr inbounds nuw %struct.Inner, ptr %in, i32 0, i32 1
  %b = load i32, ptr %bp, align 4
  %z = icmp eq i32 %b, 0
  br i1 %z, label %bail, label %go
bail:
  ret i32 0
go:
  %q = sdiv i32 100, %b
  ret i32 %q
}
