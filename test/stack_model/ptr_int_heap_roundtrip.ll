; ModuleID = 'two_file_ir/ptr_int_roundtrip_heap_defined_vuln.ll'
source_filename = "two_file_code/ptr_int_roundtrip_heap_defined_vuln.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define dso_local i32 @entry_vuln(ptr noundef %p) #0 {
entry:
  %retval = alloca i32, align 4
  %p.addr = alloca ptr, align 8
  %a = alloca i64, align 8
  %q = alloca ptr, align 8
  %cleanup.dest.slot = alloca i32, align 4
  store ptr %p, ptr %p.addr, align 8, !tbaa !20
  %0 = load ptr, ptr %p.addr, align 8, !tbaa !20
  %tobool = icmp ne ptr %0, null
  br i1 %tobool, label %if.end, label %if.then

if.then:                                          ; preds = %entry
  store i32 1, ptr %retval, align 4
  br label %return

if.end:                                           ; preds = %entry
  call void @llvm.lifetime.start.p0(ptr %a) #2
  %1 = load ptr, ptr %p.addr, align 8, !tbaa !20
  %2 = ptrtoint ptr %1 to i64
  %add = add i64 %2, 4
  store i64 %add, ptr %a, align 8, !tbaa !26
  call void @llvm.lifetime.start.p0(ptr %q) #2
  %3 = load i64, ptr %a, align 8, !tbaa !26
  %sub = sub i64 %3, 4
  %4 = inttoptr i64 %sub to ptr
  store ptr %4, ptr %q, align 8, !tbaa !20
  %5 = load ptr, ptr %q, align 8, !tbaa !20
  %6 = load ptr, ptr %p.addr, align 8, !tbaa !20
  %cmp = icmp ne ptr %5, %6
  br i1 %cmp, label %if.then1, label %if.end2

if.then1:                                         ; preds = %if.end
  store i32 0, ptr %retval, align 4
  store i32 1, ptr %cleanup.dest.slot, align 4
  br label %cleanup

if.end2:                                          ; preds = %if.end
  store i32 1, ptr %retval, align 4
  store i32 1, ptr %cleanup.dest.slot, align 4
  br label %cleanup

cleanup:                                          ; preds = %if.end2, %if.then1
  call void @llvm.lifetime.end.p0(ptr %q) #2
  call void @llvm.lifetime.end.p0(ptr %a) #2
  br label %return

return:                                           ; preds = %cleanup, %if.then
  %7 = load i32, ptr %retval, align 4
  ret i32 %7
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
!20 = !{!22, !22, i64 0}
!22 = !{!"p1 int", !24, i64 0}
!24 = !{!"any pointer", !16, i64 0}
!26 = !{!28, !28, i64 0}
!28 = !{!"long", !16, i64 0}

; patch IR below --------------

define dso_local i32 @entry_patch(ptr noundef %p) #0 {
entry:
  %p.addr = alloca ptr, align 8
  store ptr %p, ptr %p.addr, align 8, !tbaa !19
  %0 = load ptr, ptr %p.addr, align 8, !tbaa !19
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
!19 = !{!21, !21, i64 0}
!21 = !{!"p1 int", !23, i64 0}
!23 = !{!"any pointer", !15, i64 0}
