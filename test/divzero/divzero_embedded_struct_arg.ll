; Division by a value read through a pointer to a struct embedded in another
; struct, passed as an argument.
;
;   struct Inner { int a; int b; };                   size 8
;   struct Outer { int x; struct Inner in; int y; };  size 16, in at 4
;
;   get_b(struct Inner *p) = p->b
;   vuln  = 100 / get_b(&o->in)
;   patch = get_b(&o->in) == 0 ? 0 : 100 / get_b(&o->in)
;
; get_b's argument points at the start of an Inner, but that Inner is at
; offset 4 of a 16-byte object, so p's offset is not a multiple of
; sizeof(Inner).  Assuming `p.poffset mod sizeof(Inner) = 0` for a struct
; pointer argument makes every path through get_b UB once it is unfolded.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.Inner = type { i32, i32 }
%struct.Outer = type { i32, %struct.Inner, i32 }

define dso_local i32 @get_b(ptr %p) {
entry:
  %bp = getelementptr inbounds nuw %struct.Inner, ptr %p, i32 0, i32 1
  %b = load i32, ptr %bp, align 4
  ret i32 %b
}

define dso_local i32 @vuln(ptr %o) {
entry:
  %in = getelementptr inbounds nuw %struct.Outer, ptr %o, i32 0, i32 1
  %b = call i32 @get_b(ptr %in)
  %q = sdiv i32 100, %b
  ret i32 %q
}

define dso_local i32 @patch(ptr %o) {
entry:
  %in = getelementptr inbounds nuw %struct.Outer, ptr %o, i32 0, i32 1
  %b = call i32 @get_b(ptr %in)
  %z = icmp eq i32 %b, 0
  br i1 %z, label %bail, label %go
bail:
  ret i32 0
go:
  %q = sdiv i32 100, %b
  ret i32 %q
}
