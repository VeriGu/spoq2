; ir2json on C++ debug info.  A C++ struct's DICompositeType lists, among its
; elements, its fields (DIDerivedType DW_TAG_member, !20), its static data
; members (DIDerivedType with DIFlagStaticMember, !21) and its methods
; (DISubprogram, !22).  Only the first occupy storage in the object.
; gen_module.cpp cast every element to DIDerivedType, so ir2json aborted on
; any C++ module with a method (openexr CVE-2020-16588).
;
; From `struct Point { int x; static int count; int get() const { return x; } };
;        int read(Point *p) { return p->x; }`, clang++ -g -O1
; -Xclang -disable-llvm-passes.

; ModuleID = 'cxx_struct_method.cpp'
source_filename = "cxx_struct_method.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.Point = type { i32 }

; Function Attrs: mustprogress nounwind uwtable
define dso_local noundef i32 @_Z4readP5Point(ptr noundef %p) #0 !dbg !13 {
entry:
  %p.addr = alloca ptr, align 8
  store ptr %p, ptr %p.addr, align 8, !tbaa !29
    #dbg_declare(ptr %p.addr, !28, !DIExpression(), !32)
  %0 = load ptr, ptr %p.addr, align 8, !dbg !33, !tbaa !29
  %x = getelementptr inbounds nuw %struct.Point, ptr %0, i32 0, i32 0, !dbg !34
  %1 = load i32, ptr %x, align 4, !dbg !35, !tbaa !36
  ret i32 %1, !dbg !38
}

attributes #0 = { mustprogress nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5, !6}
!llvm.ident = !{!7}
!llvm.errno.tbaa = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "clang version 23.1.0 (https://github.com/llvm/llvm-project.git ea7d852a70e8bdfaf601d6626a760f9771b2c4b4)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "cxx_struct_method.cpp", directory: "/src")
!2 = !{i32 7, !"Dwarf Version", i32 5}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = !{i32 8, !"PIC Level", i32 2}
!5 = !{i32 7, !"PIE Level", i32 2}
!6 = !{i32 7, !"uwtable", i32 2}
!7 = !{!"clang version 23.1.0 (https://github.com/llvm/llvm-project.git ea7d852a70e8bdfaf601d6626a760f9771b2c4b4)"}
!8 = !{!9, !10, i64 0}
!9 = !{!"__libc_errno", !10, i64 0}
!10 = !{!"int", !11, i64 0}
!11 = !{!"omnipotent char", !12, i64 0}
!12 = !{!"Simple C++ TBAA"}
!13 = distinct !DISubprogram(name: "read", linkageName: "_Z4readP5Point", scope: !1, file: !1, line: 7, type: !14, scopeLine: 7, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !27, keyInstructions: true)
!14 = !DISubroutineType(types: !15)
!15 = !{!16, !17}
!16 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!17 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !18, size: 64)
!18 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "Point", file: !1, line: 1, size: 32, flags: DIFlagTypePassByValue, elements: !19, identifier: "_ZTS5Point")
!19 = !{!20, !21, !22}
!20 = !DIDerivedType(tag: DW_TAG_member, name: "x", scope: !18, file: !1, line: 2, baseType: !16, size: 32)
!21 = !DIDerivedType(tag: DW_TAG_variable, name: "count", scope: !18, file: !1, line: 3, baseType: !16, flags: DIFlagStaticMember)
!22 = !DISubprogram(name: "get", linkageName: "_ZNK5Point3getEv", scope: !18, file: !1, line: 4, type: !23, scopeLine: 4, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!23 = !DISubroutineType(types: !24)
!24 = !{!16, !25}
!25 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !26, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!26 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !18)
!27 = !{!28}
!28 = !DILocalVariable(name: "p", arg: 1, scope: !13, file: !1, line: 7, type: !17)
!29 = !{!30, !30, i64 0}
!30 = !{!"p1 _ZTS5Point", !31, i64 0}
!31 = !{!"any pointer", !11, i64 0}
!32 = !DILocation(line: 7, column: 17, scope: !13)
!33 = !DILocation(line: 7, column: 29, scope: !13)
!34 = !DILocation(line: 7, column: 32, scope: !13)
!35 = !DILocation(line: 7, column: 32, scope: !13, atomGroup: 1, atomRank: 2)
!36 = !{!37, !10, i64 0}
!37 = !{!"_ZTS5Point", !10, i64 0}
!38 = !DILocation(line: 7, column: 22, scope: !13, atomGroup: 1, atomRank: 1)
