; ModuleID = 'two_file_ir/hidden_ub_unfold_not_triggered_fail_vuln.ll'
source_filename = "two_file_code/hidden_ub_unfold_not_triggered_fail_vuln.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.Data = type { i32, ptr }

@result = dso_local global i32 0, align 4

; Function Attrs: nounwind uwtable
define dso_local i32 @peek_next_val(ptr noundef %d, i32 noundef %skip) #0 {
entry:
  %retval = alloca i32, align 4
  %d.addr = alloca ptr, align 8
  %skip.addr = alloca i32, align 4
  store ptr %d, ptr %d.addr, align 8, !tbaa !20
  store i32 %skip, ptr %skip.addr, align 4, !tbaa !26
  %0 = load i32, ptr %skip.addr, align 4, !tbaa !26
  %tobool = icmp ne i32 %0, 0
  br i1 %tobool, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %1 = load ptr, ptr %d.addr, align 8, !tbaa !20
  %next = getelementptr inbounds nuw %struct.Data, ptr %1, i32 0, i32 1
  %2 = load ptr, ptr %next, align 8, !tbaa !28
  %val = getelementptr inbounds nuw %struct.Data, ptr %2, i32 0, i32 0
  %3 = load i32, ptr %val, align 8, !tbaa !32
  store i32 %3, ptr %retval, align 4
  br label %return

if.else:                                          ; preds = %entry
  %4 = load ptr, ptr %d.addr, align 8, !tbaa !20
  %val1 = getelementptr inbounds nuw %struct.Data, ptr %4, i32 0, i32 0
  %5 = load i32, ptr %val1, align 8, !tbaa !32
  store i32 %5, ptr %retval, align 4
  br label %return

return:                                           ; preds = %if.else, %if.then
  %6 = load i32, ptr %retval, align 4
  ret i32 %6
}

; Function Attrs: nounwind uwtable
define dso_local i32 @entry_vuln(ptr noundef %d) #0 {
entry:
  %retval = alloca i32, align 4
  %d.addr = alloca ptr, align 8
  store ptr %d, ptr %d.addr, align 8, !tbaa !20
  %0 = load ptr, ptr %d.addr, align 8, !tbaa !20
  %tobool = icmp ne ptr %0, null
  br i1 %tobool, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %1 = load ptr, ptr %d.addr, align 8, !tbaa !20
  %call = call i32 @peek_next_val(ptr noundef %1, i32 noundef 0)
  store i32 %call, ptr %retval, align 4
  br label %return

if.end:                                           ; preds = %entry
  store i32 -1, ptr %retval, align 4
  br label %return

return:                                           ; preds = %if.end, %if.then
  %2 = load i32, ptr %retval, align 4
  ret i32 %2
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
!22 = !{!"p1 _ZTS4Data", !24, i64 0}
!24 = !{!"any pointer", !16, i64 0}
!26 = !{!14, !14, i64 0}
!28 = !{!30, !22, i64 8}
!30 = !{!"Data", !14, i64 0, !22, i64 8}
!32 = !{!30, !14, i64 0}

; patch IR below --------------

define dso_local i32 @entry_patch(ptr noundef %d) #0 {
entry:
  %retval = alloca i32, align 4
  %d.addr = alloca ptr, align 8
  store ptr %d, ptr %d.addr, align 8, !tbaa !19
  %0 = load ptr, ptr %d.addr, align 8, !tbaa !19
  %tobool = icmp ne ptr %0, null
  br i1 %tobool, label %land.lhs.true, label %if.end

land.lhs.true:                                    ; preds = %entry
  %1 = load ptr, ptr %d.addr, align 8, !tbaa !19
  %next = getelementptr inbounds nuw %struct.Data, ptr %1, i32 0, i32 1
  %2 = load ptr, ptr %next, align 8, !tbaa !27
  %tobool1 = icmp ne ptr %2, null
  br i1 %tobool1, label %if.then, label %if.end

if.then:                                          ; preds = %land.lhs.true
  %3 = load ptr, ptr %d.addr, align 8, !tbaa !19
  %call = call i32 @peek_next_val(ptr noundef %3, i32 noundef 0)
  store i32 %call, ptr %retval, align 4
  br label %return

if.end:                                           ; preds = %land.lhs.true, %entry
  store i32 -1, ptr %retval, align 4
  br label %return

return:                                           ; preds = %if.end, %if.then
  %4 = load i32, ptr %retval, align 4
  ret i32 %4
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
!21 = !{!"p1 _ZTS4Data", !23, i64 0}
!23 = !{!"any pointer", !15, i64 0}
!25 = !{!13, !13, i64 0}
!27 = !{!29, !21, i64 8}
!29 = !{!"Data", !13, i64 0, !21, i64 8}
!31 = !{!29, !13, i64 0}
