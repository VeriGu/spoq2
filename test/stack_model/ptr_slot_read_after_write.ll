; A store and read-back through a pointer argument that may address a stack slot.
;
; Scalar stack slots have one StackVal constructor per representation -- ZVal for
; an integer, PtrVal for a pointer word -- and store_stack rebuilds whichever it
; finds, so the stack it yields is a match over the constructors and the load
; that follows reads from it.  The read-after-write folds only once the `when`
; binding that stack is pushed into the match's arms (rule_move_match_out_when);
; without it the simulation cannot relate the spec's read-back to the impl's and
; the refinement is reported as not holding.
;
; From the synthetic corpus's buf_dyn_no_change.

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@dumb = dso_local global i32 0, align 4

; Function Attrs: nounwind uwtable
define dso_local signext i8 @vuln(ptr noundef %buf, i32 noundef %buf_len, i32 noundef %idx) #0 {
entry:
  %buf.addr = alloca ptr, align 8
  %buf_len.addr = alloca i32, align 4
  %idx.addr = alloca i32, align 4
  store ptr %buf, ptr %buf.addr, align 8, !tbaa !9
  store i32 %buf_len, ptr %buf_len.addr, align 4, !tbaa !12
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !12
  %0 = load ptr, ptr %buf.addr, align 8, !tbaa !9
  %arrayidx = getelementptr inbounds i8, ptr %0, i64 0
  store i8 104, ptr %arrayidx, align 1, !tbaa !13
  %1 = load ptr, ptr %buf.addr, align 8, !tbaa !9
  %2 = load i32, ptr %idx.addr, align 4, !tbaa !12
  %idxprom = zext i32 %2 to i64
  %arrayidx1 = getelementptr inbounds nuw i8, ptr %1, i64 %idxprom
  %3 = load i8, ptr %arrayidx1, align 1, !tbaa !13
  ret i8 %3
}

; Function Attrs: nounwind uwtable
define dso_local signext i8 @patch(ptr noundef %buf, i32 noundef %buf_len, i32 noundef %idx) #0 {
entry:
  %buf.addr = alloca ptr, align 8
  %buf_len.addr = alloca i32, align 4
  %idx.addr = alloca i32, align 4
  store ptr %buf, ptr %buf.addr, align 8, !tbaa !9
  store i32 %buf_len, ptr %buf_len.addr, align 4, !tbaa !12
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !12
  %0 = load ptr, ptr %buf.addr, align 8, !tbaa !9
  %arrayidx = getelementptr inbounds i8, ptr %0, i64 0
  store i8 104, ptr %arrayidx, align 1, !tbaa !13
  %1 = load ptr, ptr %buf.addr, align 8, !tbaa !9
  %2 = load i32, ptr %idx.addr, align 4, !tbaa !12
  %idxprom = zext i32 %2 to i64
  %arrayidx1 = getelementptr inbounds nuw i8, ptr %1, i64 %idxprom
  %3 = load i8, ptr %arrayidx1, align 1, !tbaa !13
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
!9 = !{!10, !10, i64 0}
!10 = !{!"p1 omnipotent char", !11, i64 0}
!11 = !{!"any pointer", !7, i64 0}
!12 = !{!6, !6, i64 0}
!13 = !{!7, !7, i64 0}
