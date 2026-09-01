; ModuleID = 'add1.ll'
source_filename = "code/add1.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@dumb = dso_local local_unnamed_addr global i32 0, align 4

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local i32 @add_vuln(i32 noundef %0) local_unnamed_addr #0 {
  %2 = add nsw i32 %0, 10
  ret i32 %2
}

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local i32 @add_patch(i32 noundef %0) local_unnamed_addr #0 {
  %2 = icmp sgt i32 %0, 2147483637
  br i1 %2, label %3, label %4

3:                                                ; preds = %1
  br label %6

4:                                                ; preds = %1
  %5 = add nsw i32 %0, 10
  br label %6

6:                                                ; preds = %4, %3
  %.0 = phi i32 [ 2147483647, %3 ], [ %5, %4 ]
  ret i32 %.0
}

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(write, argmem: none, inaccessiblemem: none) uwtable
define dso_local void @set_global_patch(i32 noundef %0) local_unnamed_addr #1 {
  %2 = call i32 @add_patch(i32 noundef %0), !range !6
  store i32 %2, ptr @dumb, align 4
  ret void
}

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(write, argmem: none, inaccessiblemem: none) uwtable
define dso_local void @set_global_vuln(i32 noundef %0) local_unnamed_addr #1 {
  %2 = call i32 @add_vuln(i32 noundef %0)
  store i32 %2, ptr @dumb, align 4
  ret void
}

attributes #0 = { mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nofree noinline norecurse nosync nounwind willreturn memory(write, argmem: none, inaccessiblemem: none) uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
!6 = !{i32 -2147483638, i32 -2147483648}
