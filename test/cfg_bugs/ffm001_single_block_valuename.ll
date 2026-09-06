; Exponential block cloning in control_flow_clone_and_split -- small input.
;
; @vuln is a SINGLE basic block, yet conversion runs for ~26s and then throws
;   "block size too large in fn vuln."
; from the repeats>10000000 guard in control_flow_clone_and_split
; (src/frontend/SpoqIRCFG.cpp).  That function's own comment explains it:
;
;   EXPONENTIAL BLOWUP WARNING: for a chain of N sequential diamonds, each
;   clone duplicates everything downstream.  This produces 2^N blocks.
;
; Same root cause as ffm001_sws_init_context.ll, which throws the same error
; after ~228s.  The two differ only in where the time is spent: this one in
; LLVM value-name allocation for the cloned instructions, the larger one in
; SpoqLoopContext::travel, which update_jump re-runs over the growing CFG.
;
; NOT a hang -- both terminate via the guard.  Earlier notes in this repo called
; it non-termination; that was an artefact of using timeouts (10s/20s) shorter
; than the time to reach the guard.
;
; Provenance: llvm-reduce over ffm001_sws_init_context.ll.  The `call ... null()`
; operands are reduction artefacts (nulled call targets), so this is a
; degenerate module -- kept because it reaches the same guard ~9x faster, not
; because the input is realistic.

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.SwsFilter = type { ptr, ptr, ptr, ptr }
%struct.SwsContext = type { ptr, ptr, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, [2 x double], [3 x ptr], [4 x i32], [4 x ptr], [4 x i32], [4 x ptr], double, i32, i32, ptr, ptr, [256 x i32], [256 x i32], ptr, ptr, ptr, ptr, i32, i32, i32, i32, i32, i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i32, i32, i32, i32, ptr, ptr, i32, i32, i32, ptr, [8 x i8], [768 x i32], [768 x ptr], [768 x ptr], [768 x ptr], [176 x i32], [4 x ptr], i32, i32, i32, [4 x i32], [4 x i32], i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, [1024 x i32], [1024 x i32], i32, i64, i64, i64, i64, i64, [1024 x i32], i64, i64, [8 x i16], [8 x i32], ptr, ptr, i32, ptr, ptr, ptr, ptr, [3 x [4 x i16]], [3 x [4 x i16]], ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32 }
%struct.SwsVector = type { ptr, i32 }

@.str.2 = external hidden unnamed_addr constant [69 x i8], align 1
@ff_yuv2rgb_coeffs = external constant [8 x [4 x i32]], align 16
@.str.3 = external hidden unnamed_addr constant [43 x i8], align 1
@.str.4 = external hidden unnamed_addr constant [44 x i8], align 1
@.str.5 = external hidden unnamed_addr constant [53 x i8], align 1
@.str.6 = external hidden unnamed_addr constant [45 x i8], align 1
@.str.7 = external hidden unnamed_addr constant [55 x i8], align 1
@.str.8 = external hidden unnamed_addr constant [74 x i8], align 1
@.str.9 = external hidden unnamed_addr constant [91 x i8], align 1
@.str.10 = external hidden unnamed_addr constant [90 x i8], align 1
@.str.11 = external hidden unnamed_addr constant [75 x i8], align 1
@.str.12 = external hidden unnamed_addr constant [75 x i8], align 1
@.str.13 = external hidden unnamed_addr constant [25 x i8], align 1
@.str.14 = external hidden unnamed_addr constant [30 x i8], align 1
@.str.15 = external hidden unnamed_addr constant [15 x i8], align 1
@.str.16 = external hidden unnamed_addr constant [32 x i8], align 1
@.str.17 = external hidden unnamed_addr constant [19 x i8], align 1
@.str.18 = external hidden unnamed_addr constant [20 x i8], align 1
@.str.19 = external hidden unnamed_addr constant [28 x i8], align 1
@.str.20 = external hidden unnamed_addr constant [10 x i8], align 1
@.str.21 = external hidden unnamed_addr constant [1 x i8], align 1
@.str.22 = external hidden unnamed_addr constant [2 x i8], align 1
@.str.23 = external hidden unnamed_addr constant [10 x i8], align 1
@.str.24 = external hidden unnamed_addr constant [16 x i8], align 1
@.str.25 = external hidden unnamed_addr constant [53 x i8], align 1
@.str.26 = external hidden unnamed_addr constant [53 x i8], align 1
@.str.27 = external hidden unnamed_addr constant [43 x i8], align 1
@scale_algorithms = external hidden unnamed_addr constant [11 x { i32, [4 x i8], ptr, i32, [4 x i8] }], align 16

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(ptr captures(none)) #0

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(ptr captures(none)) #0

; Function Attrs: nounwind uwtable
define i32 @vuln(ptr noundef %c, ptr noundef %srcFilter, ptr noundef %dstFilter) local_unnamed_addr #1 {
entry:
  %.ce.loc4 = alloca i1, align 1
  %.ce.loc = alloca i1, align 1
  %srcFilter.addr = alloca ptr, align 8
  %dstFilter.addr = alloca ptr, align 8
  %dummyFilter = alloca %struct.SwsFilter, align 8
  store ptr %srcFilter, ptr %srcFilter.addr, align 8, !tbaa !10
  store ptr %dstFilter, ptr %dstFilter.addr, align 8, !tbaa !10
  call void @llvm.lifetime.start.p0(ptr %dummyFilter) #5
  call void @llvm.memset.p0.i64(ptr align 8 %dummyFilter, i8 0, i64 32, i1 false)
  %srcW1 = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 2
  %0 = load i32, ptr %srcW1, align 16, !tbaa !13
  %srcH2 = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 3
  %1 = load i32, ptr %srcH2, align 4, !tbaa !23
  %dstW3 = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 110
  %2 = load i32, ptr %dstW3, align 8, !tbaa !24
  %dstH4 = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 4
  %3 = load i32, ptr %dstH4, align 8, !tbaa !25
  %conv = sext i32 %2 to i64
  %mul = mul nsw i64 %conv, 2
  %sub = add nsw i64 %mul, 81
  %and = and i64 %sub, -16
  %conv6 = trunc i64 %and to i32
  %srcFormat7 = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 14
  %4 = load i32, ptr %srcFormat7, align 16, !tbaa !26
  %dstFormat8 = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 13
  %5 = load i32, ptr %dstFormat8, align 4, !tbaa !27
  %call = call i32 null()
  %flags9 = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 67
  %6 = load i32, ptr %flags9, align 8, !tbaa !28
  call fastcc void null()
  %cmp = icmp eq i32 %0, %2
  %cmp11 = icmp eq i32 %1, %3
  %7 = select i1 %cmp, i1 %cmp11, i1 false
  %land.ext = zext i1 %7 to i32
  %call14 = call fastcc i32 null(ptr noundef %srcFormat7)
  %srcRange = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 81
  %8 = load i32, ptr %srcRange, align 4, !tbaa !29
  %or = or i32 %8, %call14
  store i32 %or, ptr %srcRange, align 4, !tbaa !29
  %call16 = call fastcc i32 null(ptr noundef %dstFormat8)
  %dstRange = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 82
  %9 = load i32, ptr %dstRange, align 16, !tbaa !30
  %or17 = or i32 %9, %call16
  store i32 %or17, ptr %dstRange, align 16, !tbaa !30
  %10 = load i32, ptr %srcFormat7, align 16, !tbaa !26
  %cmp19 = icmp ne i32 %4, %10
  call void (ptr, i32, ptr, ...) null(ptr noundef %c, i32 noundef 24, ptr noundef @.str.2)
  %contrast = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 76
  %11 = load i32, ptr %contrast, align 16, !tbaa !31
  %tobool26 = icmp ne i32 %11, 0
  call fastcc void null(ptr noundef %c)
  %12 = load i32, ptr %srcFormat7, align 16, !tbaa !26
  %13 = load i32, ptr %dstFormat8, align 4, !tbaa !27
  %call37 = call ptr null(i32 noundef %12)
  %call38 = call ptr null(i32 noundef %13)
  %call41 = call i32 null(i32 noundef %12)
  %tobool42 = icmp ne i32 %call41, 0
  %call44 = call i32 null(i32 noundef %12)
  %cmp45 = icmp eq i32 %call44, %13
  %and59 = and i32 %6, 2047
  %tobool60 = icmp ne i32 %and59, 0
  %sub82 = sub nuw nsw i32 %and59, 1
  %and83 = and i32 %sub82, %and59
  %tobool84 = icmp ne i32 %and83, 0
  %cmp88 = icmp slt i32 %0, 1
  %cmp91 = icmp slt i32 %1, 1
  %or.cond = select i1 %cmp88, i1 true, i1 %cmp91
  %cmp94 = icmp slt i32 %2, 1
  %or.cond1 = select i1 %or.cond, i1 true, i1 %cmp94
  %cmp97 = icmp slt i32 %3, 1
  %or.cond2 = select i1 %or.cond1, i1 true, i1 %cmp97
  call fastcc void null(ptr %dstFilter.addr, ptr %dummyFilter)
  call fastcc void null(ptr %srcFilter.addr, ptr %dummyFilter)
  %conv107 = zext nneg i32 %0 to i64
  %shl = mul nuw nsw i64 %conv107, 65536
  %shr = lshr i32 %2, 1
  %conv108 = zext nneg i32 %shr to i64
  %add109 = add nuw nsw i64 %conv108, %shl
  %div = sdiv i64 %add109, %conv
  %conv111 = trunc i64 %div to i32
  %lumXInc = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 9
  store i32 %conv111, ptr %lumXInc, align 4, !tbaa !32
  %conv112 = zext nneg i32 %1 to i64
  %shl113 = mul nuw nsw i64 %conv112, 65536
  %shr114 = lshr i32 %3, 1
  %conv115 = zext nneg i32 %shr114 to i64
  %add116 = add nuw nsw i64 %conv115, %shl113
  %conv117 = zext nneg i32 %3 to i64
  %div118 = udiv i64 %add116, %conv117
  %conv119 = trunc i64 %div118 to i32
  %lumYInc = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 11
  store i32 %conv119, ptr %lumYInc, align 4, !tbaa !33
  %call120 = call i32 null(ptr noundef %call38)
  %dstFormatBpp121 = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 15
  store i32 %call120, ptr %dstFormatBpp121, align 4, !tbaa !34
  %call122 = call i32 null(ptr noundef %call37)
  %srcFormatBpp = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 16
  store i32 %call122, ptr %srcFormatBpp, align 8, !tbaa !35
  %vRounder = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 112
  store i64 1125917086973956, ptr %vRounder, align 8, !tbaa !36
  %14 = load ptr, ptr %srcFilter.addr, align 8, !tbaa !10
  %lumV = getelementptr inbounds nuw %struct.SwsFilter, ptr %14, i32 0, i32 1
  %15 = load ptr, ptr %lumV, align 8, !tbaa !37
  %tobool123 = icmp ne ptr %15, null
  %length = getelementptr inbounds nuw %struct.SwsVector, ptr %15, i32 0, i32 1
  %16 = load i32, ptr %length, align 8, !tbaa !40
  %cmp126 = icmp sgt i32 %16, 1
  %17 = load ptr, ptr %srcFilter.addr, align 8, !tbaa !10
  %18 = load ptr, ptr %17, align 8, !tbaa !43
  %tobool152 = icmp ne ptr %18, null
  %length155 = getelementptr inbounds nuw %struct.SwsVector, ptr %18, i32 0, i32 1
  %19 = load i32, ptr %length155, align 8, !tbaa !40
  %cmp156 = icmp sgt i32 %19, 1
  %chrSrcHSubSample = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 19
  %chrSrcVSubSample = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 20
  %call185 = call i32 null(i32 noundef %12, ptr noundef %chrSrcHSubSample, ptr noundef %chrSrcVSubSample)
  %chrDstHSubSample = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 21
  %chrDstVSubSample = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 22
  %call186 = call i32 null(i32 noundef %13, ptr noundef %chrDstHSubSample, ptr noundef %chrDstVSubSample)
  %cmp187 = icmp eq i32 %13, 321
  %cmp190 = icmp eq i32 %13, 325
  %or.cond3 = select i1 %cmp187, i1 true, i1 %cmp190
  %cmp193 = icmp eq i32 %13, 326
  %or.cond4 = select i1 %or.cond3, i1 true, i1 %cmp193
  %cmp196 = icmp eq i32 %13, 322
  %or.cond5 = select i1 %or.cond4, i1 true, i1 %cmp196
  %cmp199 = icmp eq i32 %13, 327
  %or.cond6 = select i1 %or.cond5, i1 true, i1 %cmp199
  %cmp202 = icmp eq i32 %13, 328
  %or.cond7 = select i1 %or.cond6, i1 true, i1 %cmp202
  %cmp205 = icmp eq i32 %13, 323
  %or.cond8 = select i1 %or.cond7, i1 true, i1 %cmp205
  %cmp208 = icmp eq i32 %13, 329
  %or.cond9 = select i1 %or.cond8, i1 true, i1 %cmp208
  %cmp211 = icmp eq i32 %13, 330
  %or.cond10 = select i1 %or.cond9, i1 true, i1 %cmp211
  %cmp214 = icmp eq i32 %13, 324
  %or.cond11 = select i1 %or.cond10, i1 true, i1 %cmp214
  %cmp217 = icmp eq i32 %13, 331
  %or.cond12 = select i1 %or.cond11, i1 true, i1 %cmp217
  %cmp220 = icmp eq i32 %13, 332
  %or.cond13 = select i1 %or.cond12, i1 true, i1 %cmp220
  %cmp223 = icmp eq i32 %13, 41
  %or.cond14 = select i1 %or.cond13, i1 true, i1 %cmp223
  %cmp226 = icmp eq i32 %13, 42
  %or.cond15 = select i1 %or.cond14, i1 true, i1 %cmp226
  %cmp229 = icmp eq i32 %13, 30
  %or.cond16 = select i1 %or.cond15, i1 true, i1 %cmp229
  %cmp232 = icmp eq i32 %13, 29
  %or.cond17 = select i1 %or.cond16, i1 true, i1 %cmp232
  %cmp235 = icmp eq i32 %13, 2
  %or.cond18 = select i1 %or.cond17, i1 true, i1 %cmp235
  %cmp238 = icmp eq i32 %13, 43
  %or.cond19 = select i1 %or.cond18, i1 true, i1 %cmp238
  %cmp241 = icmp eq i32 %13, 44
  %or.cond20 = select i1 %or.cond19, i1 true, i1 %cmp241
  %cmp244 = icmp eq i32 %13, 45
  %or.cond21 = select i1 %or.cond20, i1 true, i1 %cmp244
  %cmp247 = icmp eq i32 %13, 46
  %or.cond22 = select i1 %or.cond21, i1 true, i1 %cmp247
  %cmp250 = icmp eq i32 %13, 63
  %or.cond23 = select i1 %or.cond22, i1 true, i1 %cmp250
  %cmp253 = icmp eq i32 %13, 62
  %or.cond24 = select i1 %or.cond23, i1 true, i1 %cmp253
  %cmp256 = icmp eq i32 %13, 22
  %or.cond25 = select i1 %or.cond24, i1 true, i1 %cmp256
  %cmp259 = icmp eq i32 %13, 23
  %or.cond26 = select i1 %or.cond25, i1 true, i1 %cmp259
  %cmp262 = icmp eq i32 %13, 24
  %or.cond27 = select i1 %or.cond26, i1 true, i1 %cmp262
  %cmp265 = icmp eq i32 %13, 291
  %or.cond28 = select i1 %or.cond27, i1 true, i1 %cmp265
  %cmp268 = icmp eq i32 %13, 292
  %or.cond29 = select i1 %or.cond28, i1 true, i1 %cmp268
  %cmp271 = icmp eq i32 %13, 10
  %or.cond30 = select i1 %or.cond29, i1 true, i1 %cmp271
  %cmp274 = icmp eq i32 %13, 9
  %or.cond31 = select i1 %or.cond30, i1 true, i1 %cmp274
  %cmp277 = icmp eq i32 %13, 67
  %or.cond32 = select i1 %or.cond31, i1 true, i1 %cmp277
  %cmp280 = icmp eq i32 %13, 68
  %or.cond33 = select i1 %or.cond32, i1 true, i1 %cmp280
  %cmp283 = icmp eq i32 %13, 28
  %or.cond34 = select i1 %or.cond33, i1 true, i1 %cmp283
  %cmp286 = icmp eq i32 %13, 27
  %or.cond35 = select i1 %or.cond34, i1 true, i1 %cmp286
  %cmp289 = icmp eq i32 %13, 3
  %or.cond36 = select i1 %or.cond35, i1 true, i1 %cmp289
  %cmp292 = icmp eq i32 %13, 47
  %or.cond37 = select i1 %or.cond36, i1 true, i1 %cmp292
  %cmp295 = icmp eq i32 %13, 48
  %or.cond38 = select i1 %or.cond37, i1 true, i1 %cmp295
  %cmp298 = icmp eq i32 %13, 49
  %or.cond39 = select i1 %or.cond38, i1 true, i1 %cmp298
  %cmp301 = icmp eq i32 %13, 50
  %or.cond40 = select i1 %or.cond39, i1 true, i1 %cmp301
  %cmp304 = icmp eq i32 %13, 65
  %or.cond41 = select i1 %or.cond40, i1 true, i1 %cmp304
  %cmp307 = icmp eq i32 %13, 64
  %or.cond42 = select i1 %or.cond41, i1 true, i1 %cmp307
  %cmp310 = icmp eq i32 %13, 19
  %or.cond43 = select i1 %or.cond42, i1 true, i1 %cmp310
  %cmp313 = icmp eq i32 %13, 20
  %or.cond44 = select i1 %or.cond43, i1 true, i1 %cmp313
  %cmp316 = icmp eq i32 %13, 21
  %or.cond45 = select i1 %or.cond44, i1 true, i1 %cmp316
  %cmp319 = icmp eq i32 %13, 293
  %or.cond46 = select i1 %or.cond45, i1 true, i1 %cmp319
  %cmp322 = icmp eq i32 %13, 294
  %or.cond47 = select i1 %or.cond46, i1 true, i1 %cmp322
  %or.cond48 = select i1 %or.cond47, i1 true, i1 %cmp271
  %or.cond49 = select i1 %or.cond48, i1 true, i1 %cmp274
  ret i32 0
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr writeonly captures(none), i8, i64, i1 immarg) #2

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.sqrt.f64(double) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write)
declare void @llvm.assume(i1 noundef) #4

attributes #0 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #1 = { nounwind uwtable "min-legal-vector-width"="0" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }
attributes #3 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write) }
attributes #5 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4, !4}
!llvm.errno.tbaa = !{!5, !5}

!0 = !{i32 7, !"Dwarf Version", i32 5}
!1 = !{i32 2, !"Debug Info Version", i32 3}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{!"Ubuntu clang version 23.1.1 (++20260901122056+5340f7cc8814-1~exp1~20260901122107.62)"}
!5 = !{!6, !7, i64 0}
!6 = !{!"__libc_errno", !7, i64 0}
!7 = !{!"int", !8, i64 0}
!8 = !{!"omnipotent char", !9, i64 0}
!9 = !{!"Simple C/C++ TBAA"}
!10 = !{!11, !11, i64 0}
!11 = !{!"p1 _ZTS9SwsFilter", !12, i64 0}
!12 = !{!"any pointer", !8, i64 0}
!13 = !{!14, !7, i64 16}
!14 = !{!"SwsContext", !15, i64 0, !12, i64 8, !7, i64 16, !7, i64 20, !7, i64 24, !7, i64 28, !7, i64 32, !7, i64 36, !7, i64 40, !7, i64 44, !7, i64 48, !7, i64 52, !7, i64 56, !7, i64 60, !7, i64 64, !7, i64 68, !7, i64 72, !7, i64 76, !7, i64 80, !7, i64 84, !7, i64 88, !7, i64 92, !7, i64 96, !7, i64 100, !7, i64 104, !8, i64 112, !8, i64 128, !8, i64 152, !8, i64 168, !8, i64 200, !8, i64 216, !16, i64 248, !7, i64 256, !7, i64 260, !17, i64 264, !17, i64 272, !8, i64 280, !8, i64 1304, !18, i64 2328, !18, i64 2336, !18, i64 2344, !18, i64 2352, !7, i64 2360, !7, i64 2364, !7, i64 2368, !7, i64 2372, !7, i64 2376, !7, i64 2380, !20, i64 2384, !17, i64 2392, !17, i64 2400, !17, i64 2408, !17, i64 2416, !21, i64 2424, !21, i64 2432, !21, i64 2440, !21, i64 2448, !7, i64 2456, !7, i64 2460, !7, i64 2464, !7, i64 2468, !7, i64 2472, !7, i64 2476, !20, i64 2480, !20, i64 2488, !7, i64 2496, !7, i64 2500, !7, i64 2504, !12, i64 2512, !8, i64 2528, !8, i64 5600, !8, i64 11744, !8, i64 17888, !8, i64 24032, !8, i64 24736, !7, i64 24768, !7, i64 24772, !7, i64 24776, !8, i64 24780, !8, i64 24796, !7, i64 24812, !7, i64 24816, !7, i64 24820, !7, i64 24824, !7, i64 24828, !7, i64 24832, !7, i64 24836, !7, i64 24840, !7, i64 24844, !7, i64 24848, !7, i64 24852, !7, i64 24856, !7, i64 24860, !7, i64 24864, !7, i64 24868, !7, i64 24872, !22, i64 24880, !22, i64 24888, !22, i64 24896, !22, i64 24904, !22, i64 24912, !22, i64 24920, !22, i64 24928, !22, i64 24936, !22, i64 24944, !22, i64 24952, !22, i64 24960, !8, i64 24968, !8, i64 29064, !7, i64 33160, !22, i64 33168, !22, i64 33176, !22, i64 33184, !22, i64 33192, !22, i64 33200, !8, i64 33208, !22, i64 37304, !22, i64 37312, !8, i64 37320, !8, i64 37336, !20, i64 37368, !20, i64 37376, !7, i64 37384, !17, i64 37392, !17, i64 37400, !17, i64 37408, !17, i64 37416, !8, i64 37424, !8, i64 37448, !12, i64 37472, !12, i64 37480, !12, i64 37488, !12, i64 37496, !12, i64 37504, !12, i64 37512, !12, i64 37520, !12, i64 37528, !12, i64 37536, !12, i64 37544, !12, i64 37552, !12, i64 37560, !12, i64 37568, !12, i64 37576, !12, i64 37584, !12, i64 37592, !12, i64 37600, !12, i64 37608, !12, i64 37616, !7, i64 37624, !7, i64 37628}
!15 = !{!"p1 _ZTS7AVClass", !12, i64 0}
!16 = !{!"double", !8, i64 0}
!17 = !{!"p1 short", !12, i64 0}
!18 = !{!"p2 short", !19, i64 0}
!19 = !{!"any p2 pointer", !12, i64 0}
!20 = !{!"p1 omnipotent char", !12, i64 0}
!21 = !{!"p1 int", !12, i64 0}
!22 = !{!"long", !8, i64 0}
!23 = !{!14, !7, i64 20}
!24 = !{!14, !7, i64 33160}
!25 = !{!14, !7, i64 24}
!26 = !{!14, !7, i64 64}
!27 = !{!14, !7, i64 60}
!28 = !{!14, !7, i64 2504}
!29 = !{!14, !7, i64 24812}
!30 = !{!14, !7, i64 24816}
!31 = !{!14, !7, i64 24768}
!32 = !{!14, !7, i64 44}
!33 = !{!14, !7, i64 52}
!34 = !{!14, !7, i64 68}
!35 = !{!14, !7, i64 72}
!36 = !{!14, !22, i64 33176}
!37 = !{!38, !39, i64 8}
!38 = !{!"SwsFilter", !39, i64 0, !39, i64 8, !39, i64 16, !39, i64 24}
!39 = !{!"p1 _ZTS9SwsVector", !12, i64 0}
!40 = !{!41, !7, i64 8}
!41 = !{!"SwsVector", !42, i64 0, !7, i64 8}
!42 = !{!"p1 double", !12, i64 0}
!43 = !{!38, !39, i64 0}
