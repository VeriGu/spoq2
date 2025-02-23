; ModuleID = '/home/rongyi/spoq3/test/frontend-v2/test.c.ll'
source_filename = "/home/rongyi/spoq3/test/frontend-v2/test.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind readnone uwtable willreturn
define dso_local i32 @add(i32 noundef %0, i32 noundef %1) local_unnamed_addr #0 {
  %3 = icmp eq i32 %0, 0
  br i1 %3, label %4, label %5

4:                                                ; preds = %2
  br label %20

5:                                                ; preds = %2
  %6 = icmp eq i32 %1, 1
  br i1 %6, label %7, label %8

7:                                                ; preds = %5
  br label %20

8:                                                ; preds = %5
  %9 = add nsw i32 %1, 123
  %10 = icmp sgt i32 %1, -23
  br i1 %10, label %11, label %12

11:                                               ; preds = %8
  br label %20

12:                                               ; preds = %8
  %13 = icmp sgt i32 %1, -73
  br i1 %13, label %14, label %15

14:                                               ; preds = %12
  br label %20

15:                                               ; preds = %12
  %16 = icmp sgt i32 %1, -122
  br i1 %16, label %17, label %19

17:                                               ; preds = %15
  %18 = add nsw i32 %1, 125
  br label %20

19:                                               ; preds = %15
  br label %20

20:                                               ; preds = %19, %17, %14, %11, %7, %4
  %.0 = phi i32 [ 0, %4 ], [ 2, %7 ], [ 100, %11 ], [ 50, %14 ], [ %18, %17 ], [ %9, %19 ]
  ret i32 %.0
}

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind readnone uwtable willreturn
define dso_local i32 @add_one(i32 noundef %0) local_unnamed_addr #0 {
  %2 = call i32 @add(i32 noundef %0, i32 noundef 1) #1
  ret i32 %2
}

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind readnone uwtable willreturn
define dso_local i32 @main() local_unnamed_addr #0 {
  ret i32 0
}

attributes #0 = { mustprogress nofree noinline norecurse nosync nounwind readnone uwtable willreturn "frame-pointer"="none" "min-legal-vector-width"="0" "no-builtins" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nobuiltin "no-builtins" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
