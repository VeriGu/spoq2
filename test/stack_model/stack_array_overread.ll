; A read of a local array at an unchecked index, and the same read behind a
; bounds check.
;
; The array is a stack slot of a non-struct array type: a ZMapVal, a flat map
; from byte offset to value whose load_stack and store_stack arms require the
; access to lie inside the 16-byte allocation.  The vuln's a[idx] is None for
; idx outside [0, 3], and the patch returns -1 there, so the patch eliminates
; the UB.  Without the arms every access to the slot is None in both versions,
; and the refinement holds only vacuously.
;
; C source:
;   int vuln(int idx)  { int a[4]; a[0] = 0; a[1] = 7; a[2] = 0; a[3] = 0; return a[idx]; }
;   int patch(int idx) { int a[4]; a[0] = 0; a[1] = 7; a[2] = 0; a[3] = 0;
;                        if (idx < 0 || idx > 3) return -1; return a[idx]; }

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define dso_local i32 @vuln(i32 noundef %idx) #0 {
entry:
  %idx.addr = alloca i32, align 4
  %a = alloca [4 x i32], align 16
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !9
  call void @llvm.lifetime.start.p0(ptr %a) #2
  %arrayidx = getelementptr inbounds [4 x i32], ptr %a, i64 0, i64 0
  store i32 0, ptr %arrayidx, align 16, !tbaa !9
  %arrayidx1 = getelementptr inbounds [4 x i32], ptr %a, i64 0, i64 1
  store i32 7, ptr %arrayidx1, align 4, !tbaa !9
  %arrayidx2 = getelementptr inbounds [4 x i32], ptr %a, i64 0, i64 2
  store i32 0, ptr %arrayidx2, align 8, !tbaa !9
  %arrayidx3 = getelementptr inbounds [4 x i32], ptr %a, i64 0, i64 3
  store i32 0, ptr %arrayidx3, align 4, !tbaa !9
  %0 = load i32, ptr %idx.addr, align 4, !tbaa !9
  %idxprom = sext i32 %0 to i64
  %arrayidx4 = getelementptr inbounds [4 x i32], ptr %a, i64 0, i64 %idxprom
  %1 = load i32, ptr %arrayidx4, align 4, !tbaa !9
  call void @llvm.lifetime.end.p0(ptr %a) #2
  ret i32 %1
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(ptr captures(none)) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(ptr captures(none)) #1

; Function Attrs: nounwind uwtable
define dso_local i32 @patch(i32 noundef %idx) #0 {
entry:
  %retval = alloca i32, align 4
  %idx.addr = alloca i32, align 4
  %a = alloca [4 x i32], align 16
  %cleanup.dest.slot = alloca i32, align 4
  store i32 %idx, ptr %idx.addr, align 4, !tbaa !9
  call void @llvm.lifetime.start.p0(ptr %a) #2
  %arrayidx = getelementptr inbounds [4 x i32], ptr %a, i64 0, i64 0
  store i32 0, ptr %arrayidx, align 16, !tbaa !9
  %arrayidx1 = getelementptr inbounds [4 x i32], ptr %a, i64 0, i64 1
  store i32 7, ptr %arrayidx1, align 4, !tbaa !9
  %arrayidx2 = getelementptr inbounds [4 x i32], ptr %a, i64 0, i64 2
  store i32 0, ptr %arrayidx2, align 8, !tbaa !9
  %arrayidx3 = getelementptr inbounds [4 x i32], ptr %a, i64 0, i64 3
  store i32 0, ptr %arrayidx3, align 4, !tbaa !9
  %0 = load i32, ptr %idx.addr, align 4, !tbaa !9
  %cmp = icmp slt i32 %0, 0
  br i1 %cmp, label %if.then, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %entry
  %1 = load i32, ptr %idx.addr, align 4, !tbaa !9
  %cmp4 = icmp sgt i32 %1, 3
  br i1 %cmp4, label %if.then, label %if.end

if.then:                                          ; preds = %lor.lhs.false, %entry
  store i32 -1, ptr %retval, align 4
  store i32 1, ptr %cleanup.dest.slot, align 4
  br label %cleanup

if.end:                                           ; preds = %lor.lhs.false
  %2 = load i32, ptr %idx.addr, align 4, !tbaa !9
  %idxprom = sext i32 %2 to i64
  %arrayidx5 = getelementptr inbounds [4 x i32], ptr %a, i64 0, i64 %idxprom
  %3 = load i32, ptr %arrayidx5, align 4, !tbaa !9
  store i32 %3, ptr %retval, align 4
  store i32 1, ptr %cleanup.dest.slot, align 4
  br label %cleanup

cleanup:                                          ; preds = %if.end, %if.then
  call void @llvm.lifetime.end.p0(ptr %a) #2
  %4 = load i32, ptr %retval, align 4
  ret i32 %4
}

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { nounwind }

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
