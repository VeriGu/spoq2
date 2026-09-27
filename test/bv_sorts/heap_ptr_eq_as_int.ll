; A pointer comparison returned as an int, under SPOQ_BV_SORTS=1.
;
;   vuln(k)  = box := malloc(8); *box = "hello"; return *box == "hello";
;   patch(k) = box := malloc(8); return 1;
;
; Generated from examples/synthetic/two_file_code (clang -O0 through the
; synthetic pipeline).  The refinement holds, and does with integer sorts.
; With bitvector sorts spoq aborts: "Z value reaches a (_ BitVec 32) slot at
; record construct".  The zext of the comparison is translated as
; `if (ptr_eqb ...) then 1 else 0` with widthless literals; ptr_eqb of a
; pointer reloaded from the heap stays an uninterpreted call, so the whole
; ite -- an unbounded integer term -- reaches the int32 return slot.  When the
; condition folds away, only the literals reach it, and those convert.
; ModuleID = 'two_file_ir/heap_ptr_eq_as_int_vuln.ll'
source_filename = "two_file_code/heap_ptr_eq_as_int_vuln.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [6 x i8] c"hello\00", align 1
@vuln_result = dso_local global i32 0, align 4
@patch_result = dso_local global i32 0, align 4

; Function Attrs: nounwind uwtable
define dso_local i32 @entry_vuln(i32 noundef %k) #0 {
entry:
  %retval = alloca i32, align 4
  %k.addr = alloca i32, align 4
  %box = alloca ptr, align 8
  %cleanup.dest.slot = alloca i32, align 4
  %same = alloca i32, align 4
  store i32 %k, ptr %k.addr, align 4, !tbaa !20
  call void @llvm.lifetime.start.p0(ptr %box) #3
  %call = call noalias ptr @malloc(i64 noundef 8) #4
  store ptr %call, ptr %box, align 8, !tbaa !22
  %0 = load ptr, ptr %box, align 8, !tbaa !22
  %tobool = icmp ne ptr %0, null
  br i1 %tobool, label %if.end, label %if.then

if.then:                                          ; preds = %entry
  store i32 0, ptr %retval, align 4
  store i32 1, ptr %cleanup.dest.slot, align 4
  br label %cleanup

if.end:                                           ; preds = %entry
  %1 = load ptr, ptr %box, align 8, !tbaa !22
  store ptr @.str, ptr %1, align 8, !tbaa !30
  call void @llvm.lifetime.start.p0(ptr %same) #3
  %2 = load ptr, ptr %box, align 8, !tbaa !22
  %3 = load ptr, ptr %2, align 8, !tbaa !30
  %cmp = icmp eq ptr %3, @.str
  %conv = zext i1 %cmp to i32
  store i32 %conv, ptr %same, align 4, !tbaa !20
  %4 = load i32, ptr %same, align 4, !tbaa !20
  store i32 %4, ptr %retval, align 4
  store i32 1, ptr %cleanup.dest.slot, align 4
  call void @llvm.lifetime.end.p0(ptr %same) #3
  br label %cleanup

cleanup:                                          ; preds = %if.end, %if.then
  call void @llvm.lifetime.end.p0(ptr %box) #3
  %5 = load i32, ptr %retval, align 4
  ret i32 %5
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(ptr captures(none)) #1

; Function Attrs: nounwind allocsize(0)
declare noalias ptr @malloc(i64 noundef) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(ptr captures(none)) #1

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { nounwind allocsize(0) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind }
attributes #4 = { nounwind allocsize(0) }

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
!24 = !{!"p2 omnipotent char", !26, i64 0}
!26 = !{!"any p2 pointer", !28, i64 0}
!28 = !{!"any pointer", !16, i64 0}
!30 = !{!32, !32, i64 0}
!32 = !{!"p1 omnipotent char", !28, i64 0}

; patch IR below --------------

define dso_local i32 @entry_patch(i32 noundef %k) #0 {
entry:
  %retval = alloca i32, align 4
  %k.addr = alloca i32, align 4
  %box = alloca ptr, align 8
  %cleanup.dest.slot = alloca i32, align 4
  store i32 %k, ptr %k.addr, align 4, !tbaa !19
  call void @llvm.lifetime.start.p0(ptr %box) #3
  %call = call noalias ptr @malloc(i64 noundef 8) #4
  store ptr %call, ptr %box, align 8, !tbaa !21
  %0 = load ptr, ptr %box, align 8, !tbaa !21
  %tobool = icmp ne ptr %0, null
  br i1 %tobool, label %if.end, label %if.then

if.then:                                          ; preds = %entry
  store i32 0, ptr %retval, align 4
  store i32 1, ptr %cleanup.dest.slot, align 4
  br label %cleanup

if.end:                                           ; preds = %entry
  store i32 1, ptr %retval, align 4
  store i32 1, ptr %cleanup.dest.slot, align 4
  br label %cleanup

cleanup:                                          ; preds = %if.end, %if.then
  call void @llvm.lifetime.end.p0(ptr %box) #3
  %1 = load i32, ptr %retval, align 4
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
!19 = !{!13, !13, i64 0}
!21 = !{!23, !23, i64 0}
!23 = !{!"p2 omnipotent char", !25, i64 0}
!25 = !{!"any p2 pointer", !27, i64 0}
!27 = !{!"any pointer", !15, i64 0}
