; ModuleID = 'two_file_ir/gep_noinbounds_negative_base_strict_vuln.ll'
source_filename = "two_file_code/gep_noinbounds_negative_base_strict_vuln.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define dso_local i32 @entry_vuln(ptr noundef %r, ptr noundef %p) #0 {
entry:
  %r.addr = alloca ptr, align 8
  %p.addr = alloca ptr, align 8
  store ptr %r, ptr %r.addr, align 8, !tbaa !20
  store ptr %p, ptr %p.addr, align 8, !tbaa !20
  %0 = load ptr, ptr %p.addr, align 8, !tbaa !20
  %arrayidx = getelementptr i32, ptr %0, i64 5
  %1 = load i32, ptr %arrayidx, align 4, !tbaa !26
  ret i32 %1
}

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

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
!20 = !{!22, !22, i64 0}
!22 = !{!"p1 int", !24, i64 0}
!24 = !{!"any pointer", !16, i64 0}
!26 = !{!14, !14, i64 0}

; patch IR below --------------

define dso_local i32 @entry_patch(ptr noundef %r, ptr noundef %p) #0 {
entry:
  %r.addr = alloca ptr, align 8
  %p.addr = alloca ptr, align 8
  store ptr %r, ptr %r.addr, align 8, !tbaa !19
  store ptr %p, ptr %p.addr, align 8, !tbaa !19
  %0 = load ptr, ptr %p.addr, align 8, !tbaa !19
  %arrayidx = getelementptr i32, ptr %0, i64 1
  %1 = load i32, ptr %arrayidx, align 4, !tbaa !25
  ret i32 %1
}
!llvm.ident = !{!7}
!llvm.errno.tbaa = !{!9}
!7 = !{!"clang version 23.1.0 (https://github.com/llvm/llvm-project.git ea7d852a70e8bdfaf601d6626a760f9771b2c4b4)"}
!9 = !{!11, !13, i64 0}
!11 = !{!"__libc_errno", !13, i64 0}
!13 = !{!"int", !15, i64 0}
!15 = !{!"omnipotent char", !17, i64 0}
!17 = !{!"Simple C/C++ TBAA"}
!19 = !{!21, !21, i64 0}
!21 = !{!"p1 int", !23, i64 0}
!23 = !{!"any pointer", !15, i64 0}
!25 = !{!13, !13, i64 0}
