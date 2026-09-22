; ModuleID = 'two_file_ir/struct_basic_vuln.ll'
source_filename = "two_file_code/struct_basic_vuln.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.Point = type { i32, i32, i32 }

@point = dso_local global %struct.Point zeroinitializer, align 4

; Function Attrs: nounwind uwtable
define dso_local void @entry_vuln(i32 noundef %x) #0 {
entry:
  %x.addr = alloca i32, align 4
  %p = alloca %struct.Point, align 4
  store i32 %x, ptr %x.addr, align 4, !tbaa !20
  call void @llvm.lifetime.start.p0(ptr %p) #4
  %x1 = getelementptr inbounds nuw %struct.Point, ptr %p, i32 0, i32 0
  %0 = load i32, ptr %x.addr, align 4, !tbaa !20
  store i32 %0, ptr %x1, align 4, !tbaa !22
  %y = getelementptr inbounds nuw %struct.Point, ptr %p, i32 0, i32 1
  %1 = load i32, ptr %x.addr, align 4, !tbaa !20
  store i32 %1, ptr %y, align 4, !tbaa !26
  %z = getelementptr inbounds nuw %struct.Point, ptr %p, i32 0, i32 2
  %2 = load i32, ptr %x.addr, align 4, !tbaa !20
  store i32 %2, ptr %z, align 4, !tbaa !28
  %3 = load i32, ptr %x.addr, align 4, !tbaa !20
  %cmp = icmp ne i32 %3, 4
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  call void @exit(i32 noundef 1) #5
  unreachable

if.end:                                           ; preds = %entry
  call void @process_point(ptr noundef %p)
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 @point, ptr align 4 %p, i64 12, i1 false), !tbaa.struct !30
  call void @llvm.lifetime.end.p0(ptr %p) #4
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(ptr captures(none)) #1

; Function Attrs: noreturn nounwind
declare void @exit(i32 noundef) #2

declare void @process_point(ptr noundef) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias writeonly captures(none), ptr noalias readonly captures(none), i64, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(ptr captures(none)) #1

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { noreturn nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nounwind }
attributes #5 = { noreturn nounwind }

!llvm.module.flags = !{!2, !4, !6}
!llvm.ident = !{!8}
!llvm.errno.tbaa = !{!10}

!2 = !{i32 8, !"PIC Level", i32 2}
!4 = !{i32 7, !"PIE Level", i32 2}
!6 = !{i32 7, !"uwtable", i32 2}
!8 = !{!"clang version 23.1.0 (https://github.com/llvm/llvm-project.git ea7d852a70e8bdfaf601d6626a760f9771b2c4b4)"}
!10 = !{!12, !14, i64 0}
!12 = !{!"__libc_errno", !14, i64 0}
!14 = !{!"int", !16, i64 0}
!16 = !{!"omnipotent char", !18, i64 0}
!18 = !{!"Simple C/C++ TBAA"}
!20 = !{!14, !14, i64 0}
!22 = !{!24, !14, i64 0}
!24 = !{!"Point", !14, i64 0, !14, i64 4, !14, i64 8}
!26 = !{!24, !14, i64 4}
!28 = !{!24, !14, i64 8}
!30 = !{i64 0, i64 4, !20, i64 4, i64 4, !20, i64 8, i64 4, !20}

; patch IR below --------------

define dso_local void @entry_patch(i32 noundef %x) #0 {
entry:
  %x.addr = alloca i32, align 4
  %p = alloca %struct.Point, align 4
  store i32 %x, ptr %x.addr, align 4, !tbaa !19
  call void @llvm.lifetime.start.p0(ptr %p) #3
  %x1 = getelementptr inbounds nuw %struct.Point, ptr %p, i32 0, i32 0
  %0 = load i32, ptr %x.addr, align 4, !tbaa !19
  store i32 %0, ptr %x1, align 4, !tbaa !21
  %y = getelementptr inbounds nuw %struct.Point, ptr %p, i32 0, i32 1
  %1 = load i32, ptr %x.addr, align 4, !tbaa !19
  store i32 %1, ptr %y, align 4, !tbaa !25
  %z = getelementptr inbounds nuw %struct.Point, ptr %p, i32 0, i32 2
  %2 = load i32, ptr %x.addr, align 4, !tbaa !19
  store i32 %2, ptr %z, align 4, !tbaa !27
  call void @process_point(ptr noundef %p)
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 @point, ptr align 4 %p, i64 12, i1 false), !tbaa.struct !29
  call void @llvm.lifetime.end.p0(ptr %p) #3
  ret void
}
!llvm.ident = !{!7}
!llvm.errno.tbaa = !{!9}
!7 = !{!"clang version 23.1.0 (https://github.com/llvm/llvm-project.git ea7d852a70e8bdfaf601d6626a760f9771b2c4b4)"}
!9 = !{!11, !13, i64 0}
!11 = !{!"__libc_errno", !13, i64 0}
!13 = !{!"int", !15, i64 0}
!15 = !{!"omnipotent char", !17, i64 0}
!17 = !{!"Simple C/C++ TBAA"}
!19 = !{!13, !13, i64 0}
!21 = !{!23, !13, i64 0}
!23 = !{!"Point", !13, i64 0, !13, i64 4, !13, i64 8}
!25 = !{!23, !13, i64 4}
!27 = !{!23, !13, i64 8}
!29 = !{i64 0, i64 4, !19, i64 4, i64 4, !19, i64 8, i64 4, !19}
