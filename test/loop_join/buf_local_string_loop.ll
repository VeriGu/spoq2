; ModuleID = 'code/buf_local_string_loop.c'
source_filename = "code/buf_local_string_loop.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@__const.patch.string = private unnamed_addr constant [14 x i8] c"hello, world!\00", align 1
@__const.vuln.string = private unnamed_addr constant [14 x i8] c"hello, world!\00", align 1
@dumb = dso_local global i32 0, align 4

; Function Attrs: nounwind uwtable
define dso_local signext i8 @patch(i32 noundef %idx) #0 {
entry:
  %retval = alloca i8, align 1
  %idx.addr = alloca i32, align 4
  %string = alloca [14 x i8], align 1
  %i = alloca i32, align 4
  %tmp = alloca i8, align 1
  %cleanup.dest.slot = alloca i32, align 4
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !9
  call void @llvm.lifetime.start.p0(ptr %string) #2
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %string, ptr align 1 @__const.patch.string, i64 14, i1 false)
  call void @llvm.lifetime.start.p0(ptr %i) #2
  call void @llvm.lifetime.start.p0(ptr %tmp) #2
  store i8 -1, ptr %tmp, align 1, !tbaa !10
  %0 = load i32, ptr %idx.addr, align 4, !tbaa !9
  %cmp = icmp ugt i32 %0, 13
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %1 = load i8, ptr %tmp, align 1, !tbaa !10
  store i8 %1, ptr %retval, align 1
  store i32 1, ptr %cleanup.dest.slot, align 4
  br label %cleanup

if.end:                                           ; preds = %entry
  store i32 0, ptr %i, align 4, !tbaa !9
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %if.end
  %2 = load i32, ptr %i, align 4, !tbaa !9
  %3 = load i32, ptr %idx.addr, align 4, !tbaa !9
  %cmp1 = icmp ult i32 %2, %3
  br i1 %cmp1, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %4 = load i32, ptr %idx.addr, align 4, !tbaa !9
  %idxprom = zext i32 %4 to i64
  %arrayidx = getelementptr inbounds nuw [14 x i8], ptr %string, i64 0, i64 %idxprom
  %5 = load i8, ptr %arrayidx, align 1, !tbaa !10
  store i8 %5, ptr %tmp, align 1, !tbaa !10
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %6 = load i32, ptr %i, align 4, !tbaa !9
  %inc = add nsw i32 %6, 1
  store i32 %inc, ptr %i, align 4, !tbaa !9
  br label %for.cond, !llvm.loop !11

for.end:                                          ; preds = %for.cond
  %7 = load i8, ptr %tmp, align 1, !tbaa !10
  store i8 %7, ptr %retval, align 1
  store i32 1, ptr %cleanup.dest.slot, align 4
  br label %cleanup

cleanup:                                          ; preds = %for.end, %if.then
  call void @llvm.lifetime.end.p0(ptr %tmp) #2
  call void @llvm.lifetime.end.p0(ptr %i) #2
  call void @llvm.lifetime.end.p0(ptr %string) #2
  %8 = load i8, ptr %retval, align 1
  ret i8 %8
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(ptr captures(none)) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias writeonly captures(none), ptr noalias readonly captures(none), i64, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(ptr captures(none)) #1

; Function Attrs: nounwind uwtable
define dso_local signext i8 @vuln(i32 noundef %idx) #0 {
entry:
  %idx.addr = alloca i32, align 4
  %string = alloca [14 x i8], align 1
  %i = alloca i32, align 4
  %tmp = alloca i8, align 1
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !9
  call void @llvm.lifetime.start.p0(ptr %string) #2
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %string, ptr align 1 @__const.vuln.string, i64 14, i1 false)
  call void @llvm.lifetime.start.p0(ptr %i) #2
  call void @llvm.lifetime.start.p0(ptr %tmp) #2
  store i8 -1, ptr %tmp, align 1, !tbaa !10
  store i32 0, ptr %i, align 4, !tbaa !9
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, ptr %i, align 4, !tbaa !9
  %1 = load i32, ptr %idx.addr, align 4, !tbaa !9
  %cmp = icmp ult i32 %0, %1
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %2 = load i32, ptr %idx.addr, align 4, !tbaa !9
  %idxprom = zext i32 %2 to i64
  %arrayidx = getelementptr inbounds nuw [14 x i8], ptr %string, i64 0, i64 %idxprom
  %3 = load i8, ptr %arrayidx, align 1, !tbaa !10
  store i8 %3, ptr %tmp, align 1, !tbaa !10
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %4 = load i32, ptr %i, align 4, !tbaa !9
  %inc = add nsw i32 %4, 1
  store i32 %inc, ptr %i, align 4, !tbaa !9
  br label %for.cond, !llvm.loop !14

for.end:                                          ; preds = %for.cond
  %5 = load i8, ptr %tmp, align 1, !tbaa !10
  call void @llvm.lifetime.end.p0(ptr %tmp) #2
  call void @llvm.lifetime.end.p0(ptr %i) #2
  call void @llvm.lifetime.end.p0(ptr %string) #2
  ret i8 %5
}

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { nounwind }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}
!llvm.errno.tbaa = !{!4}

!0 = !{i32 8, !"PIC Level", i32 2}
!1 = !{i32 7, !"PIE Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 2}
!3 = !{!"clang version 23.1.0 (https://github.com/llvm/llvm-project.git ea7d852a70e8bdfaf601d6626a760f9771b2c4b4)"}
!4 = !{!5, !6, i64 0}
!5 = !{!"__libc_errno", !6, i64 0}
!6 = !{!"int", !7, i64 0}
!7 = !{!"omnipotent char", !8, i64 0}
!8 = !{!"Simple C/C++ TBAA"}
!9 = !{!6, !6, i64 0}
!10 = !{!7, !7, i64 0}
!11 = distinct !{!11, !12, !13}
!12 = !{!"llvm.loop.mustprogress"}
!13 = !{!"llvm.loop.unroll.disable"}
!14 = distinct !{!14, !12, !13}
