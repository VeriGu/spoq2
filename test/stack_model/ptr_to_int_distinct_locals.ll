; ModuleID = 'two_file_ir/stack_ptr_to_int_strict_vuln.ll'
source_filename = "two_file_code/stack_ptr_to_int_strict_vuln.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define dso_local i32 @entry_vuln() #0 {
entry:
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %px = alloca ptr, align 8
  %py = alloca ptr, align 8
  call void @llvm.lifetime.start.p0(ptr %x) #2
  store i32 1, ptr %x, align 4, !tbaa !20
  call void @llvm.lifetime.start.p0(ptr %y) #2
  store i32 2, ptr %y, align 4, !tbaa !20
  call void @llvm.lifetime.start.p0(ptr %px) #2
  store ptr %x, ptr %px, align 8, !tbaa !22
  call void @llvm.lifetime.start.p0(ptr %py) #2
  store ptr %y, ptr %py, align 8, !tbaa !22
  %0 = load ptr, ptr %px, align 8, !tbaa !22
  %1 = ptrtoint ptr %0 to i64
  %2 = load ptr, ptr %py, align 8, !tbaa !22
  %3 = ptrtoint ptr %2 to i64
  %cmp = icmp eq i64 %1, %3
  %conv = zext i1 %cmp to i32
  %div = sdiv i32 1, %conv
  call void @llvm.lifetime.end.p0(ptr %py) #2
  call void @llvm.lifetime.end.p0(ptr %px) #2
  call void @llvm.lifetime.end.p0(ptr %y) #2
  call void @llvm.lifetime.end.p0(ptr %x) #2
  ret i32 %div
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(ptr captures(none)) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(ptr captures(none)) #1

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { nounwind }

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
!22 = !{!24, !24, i64 0}
!24 = !{!"p1 int", !26, i64 0}
!26 = !{!"any pointer", !16, i64 0}

; patch IR below --------------

define dso_local i32 @entry_patch() #0 {
entry:
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %px = alloca ptr, align 8
  %py = alloca ptr, align 8
  call void @llvm.lifetime.start.p0(ptr %x) #2
  store i32 1, ptr %x, align 4, !tbaa !19
  call void @llvm.lifetime.start.p0(ptr %y) #2
  store i32 2, ptr %y, align 4, !tbaa !19
  call void @llvm.lifetime.start.p0(ptr %px) #2
  store ptr %x, ptr %px, align 8, !tbaa !21
  call void @llvm.lifetime.start.p0(ptr %py) #2
  store ptr %y, ptr %py, align 8, !tbaa !21
  %0 = load ptr, ptr %px, align 8, !tbaa !21
  %1 = ptrtoint ptr %0 to i64
  %2 = load ptr, ptr %py, align 8, !tbaa !21
  %3 = ptrtoint ptr %2 to i64
  %cmp = icmp eq i64 %1, %3
  %conv = zext i1 %cmp to i32
  call void @llvm.lifetime.end.p0(ptr %py) #2
  call void @llvm.lifetime.end.p0(ptr %px) #2
  call void @llvm.lifetime.end.p0(ptr %y) #2
  call void @llvm.lifetime.end.p0(ptr %x) #2
  ret i32 %conv
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
!21 = !{!23, !23, i64 0}
!23 = !{!"p1 int", !25, i64 0}
!25 = !{!"any pointer", !15, i64 0}
