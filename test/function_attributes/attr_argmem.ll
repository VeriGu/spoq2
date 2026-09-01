; ModuleID = '/home/rjs2247/workspace/spoq3/test/function_attributes/src/attr_argmem.c'
source_filename = "/home/rjs2247/workspace/spoq3/test/function_attributes/src/attr_argmem.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@g = dso_local global i32 0, align 4

; Function Attrs: nounwind uwtable
define dso_local i32 @vuln() #0 {
entry:
  store i32 5, ptr @g, align 4, !tbaa !9
  %call = call i32 @ext_argmem(ptr noundef @g)
  %0 = load i32, ptr @g, align 4, !tbaa !9
  ret i32 %0
}

declare i32 @ext_argmem(ptr noundef) #1

; Function Attrs: nounwind uwtable
define dso_local i32 @patch() #0 {
entry:
  store i32 5, ptr @g, align 4, !tbaa !9
  %call = call i32 @ext_argmem(ptr noundef @g)
  ret i32 5
}

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind willreturn memory(read, argmem: readwrite, inaccessiblemem: none, target_mem: none) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

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
