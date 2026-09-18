; Globals whose extent the memory model has to bound.  One of each shape
; load_global emits an arm for, plus the two shapes whose extent is not the
; static size: several string constants merged under one identifier, and a
; zero-length array.  @mask is three-dimensional, the shape of libpng's
; png_combine_row masks.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"

%struct.Pair = type { i32, i32 }

@table = internal global [2049 x i8] zeroinitializer, align 16
@counter = internal global i32 0, align 4
@handle = internal global ptr null, align 8
@pair = internal global %struct.Pair zeroinitializer, align 4
@pairs = internal global [8 x %struct.Pair] zeroinitializer, align 4
@flex = internal global [0 x i8] zeroinitializer, align 1
@mask = internal unnamed_addr constant [2 x [3 x [3 x i32]]] zeroinitializer, align 16
@.str.1 = private unnamed_addr constant [4 x i8] c"ab\0A\00", align 1
@.str.2 = private unnamed_addr constant [16 x i8] c"a longer one\0A\00\00\00", align 1

define i32 @use(i64 %i) {
entry:
  %p = getelementptr inbounds i8, ptr @table, i64 %i
  %v = load i8, ptr %p, align 1
  %z = zext i8 %v to i32
  ret i32 %z
}
