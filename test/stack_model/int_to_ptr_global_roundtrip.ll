; ModuleID = 'two_file_ir/ptr_int_roundtrip_global_defined_vuln.ll'
source_filename = "two_file_code/ptr_int_roundtrip_global_defined_vuln.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@g = dso_local global i32 0, align 4
@h = dso_local global i32 0, align 4

; Function Attrs: nounwind uwtable
define dso_local i32 @entry_vuln(i32 noundef %i) #0 {
entry:
  %i.addr = alloca i32, align 4
  %p = alloca ptr, align 8
  %a = alloca i64, align 8
  %q = alloca ptr, align 8
  store i32 %i, ptr %i.addr, align 4, !tbaa !20
  call void @llvm.lifetime.start.p0(ptr %p) #2
  %0 = load i32, ptr %i.addr, align 4, !tbaa !20
  %tobool = icmp ne i32 %0, 0
  %1 = zext i1 %tobool to i64
  %cond = select i1 %tobool, ptr @g, ptr @h
  store ptr %cond, ptr %p, align 8, !tbaa !22
  call void @llvm.lifetime.start.p0(ptr %a) #2
  %2 = load ptr, ptr %p, align 8, !tbaa !22
  %3 = ptrtoint ptr %2 to i64
  %add = add i64 %3, 4
  store i64 %add, ptr %a, align 8, !tbaa !28
  call void @llvm.lifetime.start.p0(ptr %q) #2
  %4 = load i64, ptr %a, align 8, !tbaa !28
  %sub = sub i64 %4, 4
  %5 = inttoptr i64 %sub to ptr
  store ptr %5, ptr %q, align 8, !tbaa !22
  %6 = load ptr, ptr %q, align 8, !tbaa !22
  %7 = load ptr, ptr %p, align 8, !tbaa !22
  %cmp = icmp eq ptr %6, %7
  %conv = zext i1 %cmp to i32
  call void @llvm.lifetime.end.p0(ptr %q) #2
  call void @llvm.lifetime.end.p0(ptr %a) #2
  call void @llvm.lifetime.end.p0(ptr %p) #2
  ret i32 %conv
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
!28 = !{!30, !30, i64 0}
!30 = !{!"long", !16, i64 0}

; patch IR below --------------

define dso_local i32 @entry_patch(i32 noundef %i) #0 {
entry:
  %i.addr = alloca i32, align 4
  store i32 %i, ptr %i.addr, align 4, !tbaa !19
  %0 = load i32, ptr %i.addr, align 4, !tbaa !19
  ret i32 1
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
