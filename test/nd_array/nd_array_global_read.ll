; Reading a three-dimensional global.
;
; libpng's png_combine_row masks are [2 x [3 x [3 x i32]]].  load_global takes
; one index per dimension out of the byte offset, so the spec reads the
; global's contents and stays bounded by its extent.  `pick` is an oracle, so
; the index is arbitrary and the out-of-range case is reachable.
;
; The element is mask[1][2][i], 1*36 + 2*12 = 60 bytes in.
;
; nd_array_global_type is the same module, and pins the declaration and the
; address arithmetic in the low spec.

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
