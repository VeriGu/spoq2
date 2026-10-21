; ModuleID = 'build/loop_ptrdiff.ll'
source_filename = "src/loop_ptrdiff_vuln.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: write) uwtable
define dso_local range(i32 0, 2) i32 @fill(ptr noundef %dst, i32 noundef %n, i32 noundef %off) local_unnamed_addr #0 !dbg !17 {
entry:
    #dbg_value(ptr %dst, !24, !DIExpression(), !30)
    #dbg_value(i32 %n, !25, !DIExpression(), !30)
    #dbg_value(i32 %off, !26, !DIExpression(), !30)
    #dbg_value(ptr %dst, !27, !DIExpression(), !30)
    #dbg_value(i32 0, !28, !DIExpression(), !31)
  %sub.ptr.rhs.cast = ptrtoint ptr %dst to i64
    #dbg_value(i32 0, !28, !DIExpression(), !31)
    #dbg_value(ptr %dst, !27, !DIExpression(), !30)
  %cmp5 = icmp slt i32 0, %n, !dbg !32
  br i1 %cmp5, label %for.body.lr.ph, label %for.cond.cleanup, !dbg !34

for.body.lr.ph:                                   ; preds = %entry
  br label %for.body, !dbg !34

for.cond.for.cond.cleanup_crit_edge:              ; preds = %if.end
  br label %for.cond.cleanup, !dbg !35

for.cond.cleanup:                                 ; preds = %for.cond.for.cond.cleanup_crit_edge, %entry
  br label %cleanup, !dbg !36

for.body:                                         ; preds = %if.end, %for.body.lr.ph
  %i.07 = phi i32 [ 0, %for.body.lr.ph ], [ %inc, %if.end ]
  %p.06 = phi ptr [ %dst, %for.body.lr.ph ], [ %incdec.ptr, %if.end ]
    #dbg_value(i32 %i.07, !28, !DIExpression(), !31)
    #dbg_value(ptr %p.06, !27, !DIExpression(), !30)
  %sub.ptr.lhs.cast = ptrtoint ptr %p.06 to i64, !dbg !37
  %sub.ptr.sub = sub i64 %sub.ptr.lhs.cast, %sub.ptr.rhs.cast, !dbg !37
  %conv = trunc i64 %sub.ptr.sub to i32, !dbg !40
  %cmp1 = icmp ugt i32 %off, %conv, !dbg !41
  br i1 %cmp1, label %if.then, label %if.end, !dbg !42

if.then:                                          ; preds = %for.body
  br label %cleanup, !dbg !43

if.end:                                           ; preds = %for.body
  store i8 0, ptr %p.06, align 1, !dbg !44, !tbaa !45
  %incdec.ptr = getelementptr inbounds nuw i8, ptr %p.06, i32 1, !dbg !46
    #dbg_value(ptr %incdec.ptr, !27, !DIExpression(), !30)
  %inc = add nuw nsw i32 %i.07, 1, !dbg !47
    #dbg_value(i32 %inc, !28, !DIExpression(), !31)
  %exitcond = icmp ne i32 %inc, %n, !dbg !48
  br i1 %exitcond, label %for.body, label %for.cond.for.cond.cleanup_crit_edge, !dbg !35, !llvm.loop !49

cleanup:                                          ; preds = %if.then, %for.cond.cleanup
  %cleanup.dest.slot.0 = phi i32 [ 1, %if.then ], [ 2, %for.cond.cleanup ]
  %cond = icmp eq i32 %cleanup.dest.slot.0, 2
  br i1 %cond, label %for.end, label %cleanup3

for.end:                                          ; preds = %cleanup
  br label %cleanup3, !dbg !53

cleanup3:                                         ; preds = %for.end, %cleanup
  %retval.1 = phi i32 [ 0, %for.end ], [ 1, %cleanup ], !dbg !30
  ret i32 %retval.1, !dbg !54
}

; Function Attrs: nofree noinline norecurse nosync nounwind memory(argmem: write)
define range(i32 0, 2) i32 @entry_sec0_vuln(ptr %dst.addr.val, i32 %n.addr.val, i32 %off.addr.val) local_unnamed_addr #1 {
pv.root:
  %call = call i32 @fill(ptr noundef %dst.addr.val, i32 noundef %n.addr.val, i32 noundef %off.addr.val), !pv.align !55
  ret i32 %call
}

; Function Attrs: nofree noinline norecurse nosync nounwind memory(argmem: write)
define range(i32 0, 2) i32 @entry_sec0_patch(ptr %dst.addr.val, i32 %n.addr.val, i32 %off.addr.val) local_unnamed_addr #2 {
pv.root:
  %cmp = icmp sgt i32 %n.addr.val, 3
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %pv.root
  br label %return

if.end:                                           ; preds = %pv.root
  %call = call i32 @fill(ptr noundef %dst.addr.val, i32 noundef %n.addr.val, i32 noundef %off.addr.val), !pv.align !55
  br label %return

return:                                           ; preds = %if.end, %if.then
  %retval.0 = phi i32 [ 0, %if.then ], [ %call, %if.end ]
  ret i32 %retval.0
}

attributes #0 = { nofree norecurse nosync nounwind memory(argmem: write) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree noinline norecurse nosync nounwind memory(argmem: write) "pv-arg-map"="0:dst;1:n;2:off" "pv-caller-args"="0" "pv-change-region"="0" "pv-change-region-side"="vuln" "pv-entry-heap-unchanged" "pv-outer-args"="dst,n,off" }
attributes #2 = { nofree noinline norecurse nosync nounwind memory(argmem: write) "pv-arg-map"="0:dst;1:n;2:off" "pv-caller-args"="0" "pv-change-region"="0" "pv-change-region-side"="patch" "pv-entry-heap-unchanged" "pv-outer-args"="dst,n,off" }

!llvm.dbg.cu = !{!0, !4}
!llvm.module.flags = !{!6, !7, !8, !9, !10}
!llvm.ident = !{!11, !11}
!llvm.errno.tbaa = !{!12, !12}

!0 = distinct !DICompileUnit(language: DW_LANG_C11, file: !1, producer: "clang version 23.1.0 (https://github.com/llvm/llvm-project.git ea7d852a70e8bdfaf601d6626a760f9771b2c4b4)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "src/loop_ptrdiff_vuln.c", directory: "/tmp/review/libredwg_cve-2021-42586/ex/examples/synthetic_two_file/loop_ptrdiff", checksumkind: CSK_MD5, checksum: "2e06aa411d4b4bc21b93dcc30a4c7694")
!2 = !{!3}
!3 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!4 = distinct !DICompileUnit(language: DW_LANG_C11, file: !5, producer: "clang version 23.1.0 (https://github.com/llvm/llvm-project.git ea7d852a70e8bdfaf601d6626a760f9771b2c4b4)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !2, splitDebugInlining: false, nameTableKind: None)
!5 = !DIFile(filename: "src/loop_ptrdiff_patch.c", directory: "/tmp/review/libredwg_cve-2021-42586/ex/examples/synthetic_two_file/loop_ptrdiff", checksumkind: CSK_MD5, checksum: "7c23b6c8c79628c4f3f7972994a87971")
!6 = !{i32 7, !"Dwarf Version", i32 5}
!7 = !{i32 2, !"Debug Info Version", i32 3}
!8 = !{i32 8, !"PIC Level", i32 2}
!9 = !{i32 7, !"PIE Level", i32 2}
!10 = !{i32 7, !"uwtable", i32 2}
!11 = !{!"clang version 23.1.0 (https://github.com/llvm/llvm-project.git ea7d852a70e8bdfaf601d6626a760f9771b2c4b4)"}
!12 = !{!13, !14, i64 0}
!13 = !{!"__libc_errno", !14, i64 0}
!14 = !{!"int", !15, i64 0}
!15 = !{!"omnipotent char", !16, i64 0}
!16 = !{!"Simple C/C++ TBAA"}
!17 = distinct !DISubprogram(name: "fill", scope: !1, file: !1, line: 1, type: !18, scopeLine: 1, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !23, keyInstructions: true)
!18 = !DISubroutineType(types: !19)
!19 = !{!20, !21, !20, !3}
!20 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!21 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !22, size: 64)
!22 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!23 = !{!24, !25, !26, !27, !28}
!24 = !DILocalVariable(name: "dst", arg: 1, scope: !17, file: !1, line: 1, type: !21)
!25 = !DILocalVariable(name: "n", arg: 2, scope: !17, file: !1, line: 1, type: !20)
!26 = !DILocalVariable(name: "off", arg: 3, scope: !17, file: !1, line: 1, type: !3)
!27 = !DILocalVariable(name: "p", scope: !17, file: !1, line: 2, type: !21)
!28 = !DILocalVariable(name: "i", scope: !29, file: !1, line: 3, type: !20)
!29 = distinct !DILexicalBlock(scope: !17, file: !1, line: 3, column: 5)
!30 = !DILocation(line: 0, scope: !17)
!31 = !DILocation(line: 0, scope: !29)
!32 = !DILocation(line: 3, column: 23, scope: !33, atomGroup: 13, atomRank: 1)
!33 = distinct !DILexicalBlock(scope: !29, file: !1, line: 3, column: 5)
!34 = !DILocation(line: 3, column: 5, scope: !29, atomGroup: 14, atomRank: 1)
!35 = !DILocation(line: 3, column: 5, scope: !29, atomGroup: 4, atomRank: 1)
!36 = !DILocation(line: 3, column: 5, scope: !29)
!37 = !DILocation(line: 4, column: 32, scope: !38)
!38 = distinct !DILexicalBlock(scope: !39, file: !1, line: 4, column: 13)
!39 = distinct !DILexicalBlock(scope: !33, file: !1, line: 3, column: 33)
!40 = !DILocation(line: 4, column: 19, scope: !38)
!41 = !DILocation(line: 4, column: 17, scope: !38, atomGroup: 5, atomRank: 2)
!42 = !DILocation(line: 4, column: 17, scope: !38, atomGroup: 5, atomRank: 1)
!43 = !DILocation(line: 4, column: 40, scope: !38, atomGroup: 6, atomRank: 1)
!44 = !DILocation(line: 5, column: 12, scope: !39, atomGroup: 7, atomRank: 1)
!45 = !{!15, !15, i64 0}
!46 = !DILocation(line: 6, column: 10, scope: !39, atomGroup: 8, atomRank: 2)
!47 = !DILocation(line: 3, column: 29, scope: !33, atomGroup: 9, atomRank: 2)
!48 = !DILocation(line: 3, column: 23, scope: !33, atomGroup: 3, atomRank: 1)
!49 = distinct !{!49, !36, !50, !51, !52}
!50 = !DILocation(line: 7, column: 5, scope: !29)
!51 = !{!"llvm.loop.mustprogress"}
!52 = !{!"llvm.loop.unroll.disable"}
!53 = !DILocation(line: 8, column: 5, scope: !17, atomGroup: 11, atomRank: 1)
!54 = !DILocation(line: 9, column: 1, scope: !17, atomGroup: 12, atomRank: 1)
!55 = !{i64 10}
