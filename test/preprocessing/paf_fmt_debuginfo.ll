; PAF_FMT from libsndfile src/paf.c (snd001): an anonymous struct named only by
; a typedef, so the LLVM type has no field names.  Compiled with -g from:
;
;   typedef struct { int version, endianness, samplerate, format, channels,
;                    source ; } PAF_FMT ;
;   int paf_samplerate (int x)
;   { PAF_FMT paf_fmt ; paf_fmt.samplerate = x ; paf_fmt.channels = 1 ;
;     return paf_fmt.samplerate ; }
;
; extractbasics names the record's fields after the DW_TAG_member entries of
; the struct the typedef refers to.  See paf_fmt_retained.ll and
; paf_fmt_nodebug.ll for the same struct without the function's debug info.
; ModuleID = 'paf_fmt.c'
source_filename = "paf_fmt.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.PAF_FMT = type { i32, i32, i32, i32, i32, i32 }

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @paf_samplerate(i32 noundef %x) #0 !dbg !9 {
entry:
  %x.addr = alloca i32, align 4
  %paf_fmt = alloca %struct.PAF_FMT, align 4
  store i32 %x, ptr %x.addr, align 4
    #dbg_declare(ptr %x.addr, !14, !DIExpression(), !15)
    #dbg_declare(ptr %paf_fmt, !16, !DIExpression(), !26)
  %0 = load i32, ptr %x.addr, align 4, !dbg !27
  %samplerate = getelementptr inbounds nuw %struct.PAF_FMT, ptr %paf_fmt, i32 0, i32 2, !dbg !28
  store i32 %0, ptr %samplerate, align 4, !dbg !29
  %channels = getelementptr inbounds nuw %struct.PAF_FMT, ptr %paf_fmt, i32 0, i32 4, !dbg !30
  store i32 1, ptr %channels, align 4, !dbg !31
  %samplerate1 = getelementptr inbounds nuw %struct.PAF_FMT, ptr %paf_fmt, i32 0, i32 2, !dbg !32
  %1 = load i32, ptr %samplerate1, align 4, !dbg !32
  ret i32 %1, !dbg !33
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5, !6, !7}

!0 = distinct !DICompileUnit(language: DW_LANG_C11, file: !1, producer: "clang version 23.1.0 (https://github.com/llvm/llvm-project.git ea7d852a70e8bdfaf601d6626a760f9771b2c4b4)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "paf_fmt.c", directory: ".", checksumkind: CSK_MD5, checksum: "3dacc5dc56d280322b6336b3349e9f9b")
!2 = !{i32 7, !"Dwarf Version", i32 5}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = !{i32 8, !"PIC Level", i32 2}
!5 = !{i32 7, !"PIE Level", i32 2}
!6 = !{i32 7, !"uwtable", i32 2}
!7 = !{i32 7, !"frame-pointer", i32 2}
!9 = distinct !DISubprogram(name: "paf_samplerate", scope: !1, file: !1, line: 11, type: !10, scopeLine: 12, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !13)
!10 = !DISubroutineType(types: !11)
!11 = !{!12, !12}
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !{}
!14 = !DILocalVariable(name: "x", arg: 1, scope: !9, file: !1, line: 11, type: !12)
!15 = !DILocation(line: 11, column: 25, scope: !9)
!16 = !DILocalVariable(name: "paf_fmt", scope: !9, file: !1, line: 12, type: !17)
!17 = !DIDerivedType(tag: DW_TAG_typedef, name: "PAF_FMT", file: !1, line: 9, baseType: !18)
!18 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !1, line: 2, size: 192, elements: !19)
!19 = !{!20, !21, !22, !23, !24, !25}
!20 = !DIDerivedType(tag: DW_TAG_member, name: "version", scope: !18, file: !1, line: 3, baseType: !12, size: 32)
!21 = !DIDerivedType(tag: DW_TAG_member, name: "endianness", scope: !18, file: !1, line: 4, baseType: !12, size: 32, offset: 32)
!22 = !DIDerivedType(tag: DW_TAG_member, name: "samplerate", scope: !18, file: !1, line: 5, baseType: !12, size: 32, offset: 64)
!23 = !DIDerivedType(tag: DW_TAG_member, name: "format", scope: !18, file: !1, line: 6, baseType: !12, size: 32, offset: 96)
!24 = !DIDerivedType(tag: DW_TAG_member, name: "channels", scope: !18, file: !1, line: 7, baseType: !12, size: 32, offset: 128)
!25 = !DIDerivedType(tag: DW_TAG_member, name: "source", scope: !18, file: !1, line: 8, baseType: !12, size: 32, offset: 160)
!26 = !DILocation(line: 12, column: 11, scope: !9)
!27 = !DILocation(line: 13, column: 23, scope: !9)
!28 = !DILocation(line: 13, column: 10, scope: !9)
!29 = !DILocation(line: 13, column: 21, scope: !9)
!30 = !DILocation(line: 14, column: 10, scope: !9)
!31 = !DILocation(line: 14, column: 19, scope: !9)
!32 = !DILocation(line: 15, column: 17, scope: !9)
!33 = !DILocation(line: 15, column: 2, scope: !9)
