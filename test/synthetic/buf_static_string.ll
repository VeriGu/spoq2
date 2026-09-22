; ModuleID = 'code/buf_static_string.c'
source_filename = "code/buf_static_string.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@string = dso_local global [14 x i8] c"hello, world!\00", align 1

; Function Attrs: nounwind uwtable
define dso_local signext i8 @vuln(i32 noundef %idx) #0 {
entry:
  %idx.addr = alloca i32, align 4
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !9
  %0 = load i32, ptr %idx.addr, align 4, !tbaa !9
  %idxprom = zext i32 %0 to i64
  %arrayidx = getelementptr inbounds nuw [14 x i8], ptr @string, i64 0, i64 %idxprom
  %1 = load i8, ptr %arrayidx, align 1, !tbaa !10
  ret i8 %1
}

; Function Attrs: nounwind uwtable
define dso_local signext i8 @patch(i32 noundef %idx) #0 {
entry:
  %retval = alloca i8, align 1
  %idx.addr = alloca i32, align 4
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !9
  %0 = load i32, ptr %idx.addr, align 4, !tbaa !9
  %cmp = icmp uge i32 %0, 14
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  store i8 -1, ptr %retval, align 1
  br label %return

if.end:                                           ; preds = %entry
  %1 = load i32, ptr %idx.addr, align 4, !tbaa !9
  %idxprom = zext i32 %1 to i64
  %arrayidx = getelementptr inbounds nuw [14 x i8], ptr @string, i64 0, i64 %idxprom
  %2 = load i8, ptr %arrayidx, align 1, !tbaa !10
  store i8 %2, ptr %retval, align 1
  br label %return

return:                                           ; preds = %if.end, %if.then
  %3 = load i8, ptr %retval, align 1
  ret i8 %3
}

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

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
