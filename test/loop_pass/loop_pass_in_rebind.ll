; ModuleID = 'loop_pass_in_rebind.ll'
source_filename = "loop_pass_in_rebind.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define dso_local i32 @entry_vuln(ptr nofree noundef readonly captures(none) %p, i32 noundef %n) local_unnamed_addr #0 {
entry:
  %s = alloca i32, align 4, !pv.align !11
  call void @llvm.lifetime.start.p0(ptr %s)
  store i32 0, ptr %s, align 4, !tbaa !12, !pv.align !13
  call void @touch(ptr noundef %s), !pv.align !14
  %pv.retval.pv.ret = call i32 @entry_sec0_vuln(ptr %p, i32 %n, ptr %s)
  ret i32 %pv.retval.pv.ret, !pv.align !15
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(ptr captures(none)) #1

declare void @touch(ptr noundef) local_unnamed_addr #2

; Function Attrs: nounwind uwtable
define dso_local i32 @entry_patch(ptr nofree noundef readonly captures(none) %p, i32 noundef %n) local_unnamed_addr #0 {
entry:
  %s = alloca i32, align 4, !pv.align !11
  call void @llvm.lifetime.start.p0(ptr %s)
  store i32 0, ptr %s, align 4, !tbaa !12, !pv.align !13
  call void @touch(ptr noundef %s), !pv.align !14
  %pv.retval.pv.ret = call i32 @entry_sec0_patch(ptr %p, i32 %n, ptr %s)
  ret i32 %pv.retval.pv.ret, !pv.align !15
}

; Function Attrs: nofree noinline norecurse nosync nounwind memory(argmem: readwrite)
define i32 @entry_sec0_vuln(ptr nofree readonly captures(none) %p, i32 %n, ptr nofree writeonly captures(none) %s) local_unnamed_addr #3 {
pv.root:
  %cmp = icmp sle i32 %n, 0, !pv.align !16
  br i1 %cmp, label %pv.exit.0, label %do.body.preheader, !pv.align !17

do.body.preheader:                                ; preds = %pv.root
  %wide.trip.count = zext nneg i32 %n to i64
  br label %do.body

do.body:                                          ; preds = %do.body, %do.body.preheader
  %indvars.iv = phi i64 [ 0, %do.body.preheader ], [ %indvars.iv.next, %do.body ]
  %acc.0 = phi i32 [ %add, %do.body ], [ 0, %do.body.preheader ]
  %arrayidx = getelementptr inbounds i32, ptr %p, i64 %indvars.iv
  %0 = load i32, ptr %arrayidx, align 4, !tbaa !12
  %add = add nsw i32 %0, %acc.0
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp ne i64 %indvars.iv.next, %wide.trip.count
  br i1 %exitcond, label %do.body, label %do.end, !llvm.loop !18

do.end:                                           ; preds = %do.body
  store i32 %add, ptr %s, align 4, !tbaa !12
  %1 = load i32, ptr %p, align 4, !tbaa !12, !pv.align !21
  %add3 = add nsw i32 %1, %add, !pv.align !22
  br label %pv.exit.0, !pv.align !23

pv.exit.0:                                        ; preds = %do.end, %pv.root
  %pv.retval = phi i32 [ %add3, %do.end ], [ 0, %pv.root ], !pv.align !24
  ret i32 %pv.retval
}

; Function Attrs: nofree noinline norecurse nosync nounwind memory(argmem: readwrite)
define i32 @entry_sec0_patch(ptr nofree readonly captures(none) %p, i32 %n, ptr nofree writeonly captures(none) %s) local_unnamed_addr #4 {
pv.root:
  %cmp = icmp sle i32 %n, 0, !pv.align !16
  br i1 %cmp, label %pv.exit.0, label %if.end, !pv.align !17

if.end:                                           ; preds = %pv.root
  %0 = zext nneg i32 %n to i64
  %1 = add nsw i64 %0, -1
  br label %do.body, !pv.align !25

do.body:                                          ; preds = %do.body, %if.end
  %indvars.iv = phi i64 [ %indvars.iv.next, %do.body ], [ %1, %if.end ]
  %acc.0 = phi i32 [ 0, %if.end ], [ %add, %do.body ]
  %arrayidx = getelementptr inbounds i32, ptr %p, i64 %indvars.iv
  %2 = load i32, ptr %arrayidx, align 4, !tbaa !12
  %add = add nsw i32 %2, %acc.0
  %indvars.iv.next = add nsw i64 %indvars.iv, -1
  %cmp1 = icmp sge i64 %indvars.iv.next, 0
  br i1 %cmp1, label %do.body, label %do.end, !llvm.loop !26

do.end:                                           ; preds = %do.body
  store i32 %add, ptr %s, align 4, !tbaa !12
  %3 = load i32, ptr %p, align 4, !tbaa !12, !pv.align !21
  %add3 = add nsw i32 %3, %add, !pv.align !22
  br label %pv.exit.0, !pv.align !23

pv.exit.0:                                        ; preds = %do.end, %pv.root
  %pv.retval = phi i32 [ %add3, %do.end ], [ 0, %pv.root ], !pv.align !24
  ret i32 %pv.retval
}

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nofree noinline norecurse nosync nounwind memory(argmem: readwrite) "pv-arg-map"="0:p;1:n" "pv-caller-args"="0" "pv-change-region"="0" "pv-change-region-side"="vuln" "pv-outer-args"="p,n" "pv-stack-args"="2:s:0" }
attributes #4 = { nofree noinline norecurse nosync nounwind memory(argmem: readwrite) "pv-arg-map"="0:p;1:n" "pv-caller-args"="0" "pv-change-region"="0" "pv-change-region-side"="patch" "pv-outer-args"="p,n" "pv-stack-args"="2:s:0" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5, !5}
!llvm.errno.tbaa = !{!6, !6}

!0 = !{i32 7, !"Dwarf Version", i32 5}
!1 = !{i32 2, !"Debug Info Version", i32 3}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"PIE Level", i32 2}
!4 = !{i32 7, !"uwtable", i32 2}
!5 = !{!"clang version 23.1.0 (https://github.com/llvm/llvm-project.git ea7d852a70e8bdfaf601d6626a760f9771b2c4b4)"}
!6 = !{!7, !8, i64 0}
!7 = !{!"__libc_errno", !8, i64 0}
!8 = !{!"int", !9, i64 0}
!9 = !{!"omnipotent char", !10, i64 0}
!10 = !{!"Simple C/C++ TBAA"}
!11 = !{i64 1}
!12 = !{!8, !8, i64 0}
!13 = !{i64 2}
!14 = !{i64 3}
!15 = !{i64 18}
!16 = !{i64 4}
!17 = !{i64 5}
!18 = distinct !{!18, !19, !20}
!19 = !{!"llvm.loop.mustprogress"}
!20 = !{!"llvm.loop.unroll.disable"}
!21 = !{i64 9}
!22 = !{i64 11}
!23 = !{i64 12}
!24 = !{i64 16}
!25 = !{i64 6}
!26 = distinct !{!26, !19, !20}
