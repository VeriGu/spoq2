; Reading a three-dimensional global.
;
; libpng's png_combine_row masks are [2 x [3 x [3 x i32]]].  load_global gets an
; arm per global whose type it can index -- a scalar, a pointer, a struct, an
; array of those -- and a global whose element is itself an array gets none, so
; every read of one is undefined and the spec collapses to None.  Reported as a
; skip until it does: the case asserts that the spec reads the global, which is
; what the one-dimensional global_bounds_refinement already does.
;
; nd_array_global_type is the same module, and pins the parts that do work.

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@mask = internal unnamed_addr constant [2 x [3 x [3 x i32]]] zeroinitializer, align 16

declare dso_local i32 @pick()

define dso_local i32 @vuln() {
entry:
  %i = call i32 @pick()
  %x = sext i32 %i to i64
  %p = getelementptr inbounds [2 x [3 x [3 x i32]]], ptr @mask, i64 0, i64 1, i64 2, i64 %x
  %v = load i32, ptr %p, align 4
  ret i32 %v
}
