; Exponential block cloning in control_flow_clone_and_split -- real input.
;
; sws_init_context_vuln (254 blocks) from
; examples/ffmpeg/ffm001/build/utils.ll, extracted with llvm-extract and
; renamed to @vuln.  control_flow_conversion_v2 runs for ~228s and then throws
;   "block size too large in fn vuln."
; from the repeats>10000000 guard in control_flow_clone_and_split.
;
; Time is dominated by SpoqLoopContext::travel over BasicBlock*->BasicBlock*
; maps: update_jump calls travel_all() after each clone, so the traversal is
; re-run over an ever-growing CFG -- roughly O(2^N * blocks).
;
; In spoq proper this presents as "hangs after Attempting conversion on
; sws_init_context_vuln", because the run is normally abandoned long before the
; guard is reached.

; ModuleID = '/home/rjs2247/workspace/patchverification/examples/ffmpeg/ffm001/build/utils.ll'
source_filename = "/ffmpeg/repo/libswscale/utils.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.SwsFilter = type { ptr, ptr, ptr, ptr }
%struct.SwsContext = type { ptr, ptr, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, [2 x double], [3 x ptr], [4 x i32], [4 x ptr], [4 x i32], [4 x ptr], double, i32, i32, ptr, ptr, [256 x i32], [256 x i32], ptr, ptr, ptr, ptr, i32, i32, i32, i32, i32, i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i32, i32, i32, i32, ptr, ptr, i32, i32, i32, ptr, [8 x i8], [768 x i32], [768 x ptr], [768 x ptr], [768 x ptr], [176 x i32], [4 x ptr], i32, i32, i32, [4 x i32], [4 x i32], i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, [1024 x i32], [1024 x i32], i32, i64, i64, i64, i64, i64, [1024 x i32], i64, i64, [8 x i16], [8 x i32], ptr, ptr, i32, ptr, ptr, ptr, ptr, [3 x [4 x i16]], [3 x [4 x i16]], ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32 }
%struct.SwsVector = type { ptr, i32 }
%struct.AVPixFmtDescriptor = type { ptr, i8, i8, i8, i8, [4 x %struct.AVComponentDescriptor], ptr }
%struct.AVComponentDescriptor = type { i16 }
%struct.ScaleAlgorithm = type { i32, ptr, i32 }

@.str.2 = external hidden unnamed_addr constant [69 x i8], align 1, !dbg !0
@ff_yuv2rgb_coeffs = external constant [8 x [4 x i32]], align 16
@.str.3 = external hidden unnamed_addr constant [43 x i8], align 1, !dbg !8
@.str.4 = external hidden unnamed_addr constant [44 x i8], align 1, !dbg !13
@.str.5 = external hidden unnamed_addr constant [53 x i8], align 1, !dbg !18
@.str.6 = external hidden unnamed_addr constant [45 x i8], align 1, !dbg !23
@.str.7 = external hidden unnamed_addr constant [55 x i8], align 1, !dbg !28
@.str.8 = external hidden unnamed_addr constant [74 x i8], align 1, !dbg !33
@.str.9 = external hidden unnamed_addr constant [91 x i8], align 1, !dbg !38
@.str.10 = external hidden unnamed_addr constant [90 x i8], align 1, !dbg !43
@.str.11 = external hidden unnamed_addr constant [75 x i8], align 1, !dbg !48
@.str.12 = external hidden unnamed_addr constant [75 x i8], align 1, !dbg !53
@.str.13 = external hidden unnamed_addr constant [25 x i8], align 1, !dbg !55
@.str.14 = external hidden unnamed_addr constant [30 x i8], align 1, !dbg !60
@.str.15 = external hidden unnamed_addr constant [15 x i8], align 1, !dbg !65
@.str.16 = external hidden unnamed_addr constant [32 x i8], align 1, !dbg !70
@.str.17 = external hidden unnamed_addr constant [19 x i8], align 1, !dbg !75
@.str.18 = external hidden unnamed_addr constant [20 x i8], align 1, !dbg !80
@.str.19 = external hidden unnamed_addr constant [28 x i8], align 1, !dbg !85
@.str.20 = external hidden unnamed_addr constant [10 x i8], align 1, !dbg !90
@.str.21 = external hidden unnamed_addr constant [1 x i8], align 1, !dbg !95
@.str.22 = external hidden unnamed_addr constant [2 x i8], align 1, !dbg !100
@.str.23 = external hidden unnamed_addr constant [10 x i8], align 1, !dbg !105
@.str.24 = external hidden unnamed_addr constant [16 x i8], align 1, !dbg !107
@.str.25 = external hidden unnamed_addr constant [53 x i8], align 1, !dbg !112
@.str.26 = external hidden unnamed_addr constant [53 x i8], align 1, !dbg !114
@.str.27 = external hidden unnamed_addr constant [43 x i8], align 1, !dbg !116
@scale_algorithms = external hidden unnamed_addr constant [11 x { i32, [4 x i8], ptr, i32, [4 x i8] }], align 16, !dbg !118

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none) uwtable
declare range(i32 0, 2) i32 @sws_isSupportedInput(i32 noundef) local_unnamed_addr #0

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none) uwtable
declare range(i32 0, 2) i32 @sws_isSupportedOutput(i32 noundef) local_unnamed_addr #0

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none) uwtable
declare range(i32 0, 2) i32 @sws_isSupportedEndiannessConversion(i32 noundef) local_unnamed_addr #0

; Function Attrs: nounwind uwtable
declare range(i32 -1, 1) i32 @sws_setColorspaceDetails(ptr noundef initializes((24780, 24812)), ptr noundef, i32 noundef, ptr nofree noundef readonly captures(none), i32 noundef, i32 noundef, i32 noundef, i32 noundef) local_unnamed_addr #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(ptr captures(none)) #2

; Function Attrs: nofree norecurse nosync nounwind memory(readwrite, inaccessiblemem: none, target_mem: none) uwtable
declare hidden fastcc void @handle_formats(ptr nofree noundef captures(none)) unnamed_addr #3

declare ptr @av_pix_fmt_desc_get(i32 noundef) local_unnamed_addr #4

declare i32 @av_get_bits_per_pixel(ptr noundef) local_unnamed_addr #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(ptr captures(none)) #2

declare noalias ptr @av_mallocz(i64 noundef) local_unnamed_addr #4

; Function Attrs: nounwind uwtable
define i32 @vuln(ptr noundef %c, ptr noundef %srcFilter, ptr noundef %dstFilter) local_unnamed_addr #1 !dbg !534 {
entry:
  %.ce.loc4 = alloca i1, align 1
  %.ce.loc = alloca i1, align 1
  %srcFilter.addr = alloca ptr, align 8
  %dstFilter.addr = alloca ptr, align 8
  %dummyFilter = alloca %struct.SwsFilter, align 8
    #dbg_value(ptr %c, !894, !DIExpression(), !967)
  store ptr %srcFilter, ptr %srcFilter.addr, align 8, !tbaa !968
    #dbg_declare(ptr %srcFilter.addr, !895, !DIExpression(), !971)
  store ptr %dstFilter, ptr %dstFilter.addr, align 8, !tbaa !968
    #dbg_declare(ptr %dstFilter.addr, !896, !DIExpression(), !972)
  call void @llvm.lifetime.start.p0(ptr %dummyFilter) #14, !dbg !973
    #dbg_declare(ptr %dummyFilter, !902, !DIExpression(), !974)
  call void @llvm.memset.p0.i64(ptr align 8 %dummyFilter, i8 0, i64 32, i1 false), !dbg !975
  %srcW1 = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 2, !dbg !976
  %0 = load i32, ptr %srcW1, align 16, !dbg !977, !tbaa !978
    #dbg_value(i32 %0, !903, !DIExpression(), !967)
  %srcH2 = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 3, !dbg !988
  %1 = load i32, ptr %srcH2, align 4, !dbg !989, !tbaa !990
    #dbg_value(i32 %1, !904, !DIExpression(), !967)
  %dstW3 = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 110, !dbg !991
  %2 = load i32, ptr %dstW3, align 8, !dbg !992, !tbaa !993
    #dbg_value(i32 %2, !905, !DIExpression(), !967)
  %dstH4 = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 4, !dbg !994
  %3 = load i32, ptr %dstH4, align 8, !dbg !995, !tbaa !996
    #dbg_value(i32 %3, !906, !DIExpression(), !967)
  %conv = sext i32 %2 to i64, !dbg !997
  %mul = mul nsw i64 %conv, 2, !dbg !998
  %sub = add nsw i64 %mul, 81, !dbg !999
  %and = and i64 %sub, -16, !dbg !1000
  %conv6 = trunc i64 %and to i32, !dbg !1001
    #dbg_value(i32 %conv6, !907, !DIExpression(), !967)
  %srcFormat7 = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 14, !dbg !1002
  %4 = load i32, ptr %srcFormat7, align 16, !dbg !1003, !tbaa !1004
    #dbg_value(i32 %4, !910, !DIExpression(), !967)
  %dstFormat8 = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 13, !dbg !1005
  %5 = load i32, ptr %dstFormat8, align 4, !dbg !1006, !tbaa !1007
    #dbg_value(i32 %5, !911, !DIExpression(), !967)
    #dbg_value(i32 0, !936, !DIExpression(), !967)
  %call = call i32 @av_get_cpu_flags(), !dbg !1008
    #dbg_value(i32 %call, !909, !DIExpression(), !967)
  %flags9 = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 67, !dbg !1009
  %6 = load i32, ptr %flags9, align 8, !dbg !1010, !tbaa !1011
    #dbg_value(i32 %6, !908, !DIExpression(), !967)
  call fastcc void @pv_shared_4(), !dbg !1012
  %cmp = icmp eq i32 %0, %2, !dbg !1014
  %cmp11 = icmp eq i32 %1, %3, !dbg !1015
  %7 = select i1 %cmp, i1 %cmp11, i1 false, !dbg !1015
  %land.ext = zext i1 %7 to i32, !dbg !1016
    #dbg_value(i32 %land.ext, !901, !DIExpression(), !967)
  %call14 = call fastcc i32 @handle_jpeg(ptr noundef %srcFormat7), !dbg !1017
  %srcRange = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 81, !dbg !1018
  %8 = load i32, ptr %srcRange, align 4, !dbg !1019, !tbaa !1020
  %or = or i32 %8, %call14, !dbg !1021
  store i32 %or, ptr %srcRange, align 4, !dbg !1022, !tbaa !1020
  %call16 = call fastcc i32 @handle_jpeg(ptr noundef %dstFormat8), !dbg !1023
  %dstRange = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 82, !dbg !1024
  %9 = load i32, ptr %dstRange, align 16, !dbg !1025, !tbaa !1026
  %or17 = or i32 %9, %call16, !dbg !1027
  store i32 %or17, ptr %dstRange, align 16, !dbg !1028, !tbaa !1026
  %10 = load i32, ptr %srcFormat7, align 16, !dbg !1029, !tbaa !1004
  %cmp19 = icmp ne i32 %4, %10, !dbg !1031
  br i1 %cmp19, label %if.then24, label %lor.lhs.false, !dbg !1032

lor.lhs.false:                                    ; preds = %entry
  %11 = load i32, ptr %dstFormat8, align 4, !dbg !1033, !tbaa !1007
  %cmp22 = icmp ne i32 %5, %11, !dbg !1034
  br i1 %cmp22, label %if.then24, label %if.end25, !dbg !1035

if.then24:                                        ; preds = %lor.lhs.false, %entry
  call void (ptr, i32, ptr, ...) @av_log(ptr noundef %c, i32 noundef 24, ptr noundef @.str.2), !dbg !1036
  br label %if.end25, !dbg !1036

if.end25:                                         ; preds = %if.then24, %lor.lhs.false
  %contrast = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 76, !dbg !1037
  %12 = load i32, ptr %contrast, align 16, !dbg !1037, !tbaa !1039
  %tobool26 = icmp ne i32 %12, 0, !dbg !1040
  br i1 %tobool26, label %if.end34, label %land.lhs.true, !dbg !1041

land.lhs.true:                                    ; preds = %if.end25
  %saturation = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 78, !dbg !1042
  %13 = load i32, ptr %saturation, align 8, !dbg !1042, !tbaa !1043
  %tobool27 = icmp ne i32 %13, 0, !dbg !1044
  br i1 %tobool27, label %if.end34, label %land.lhs.true28, !dbg !1045

land.lhs.true28:                                  ; preds = %land.lhs.true
  %dstFormatBpp = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 15, !dbg !1046
  %14 = load i32, ptr %dstFormatBpp, align 4, !dbg !1046, !tbaa !1047
  %tobool29 = icmp ne i32 %14, 0, !dbg !1048
  br i1 %tobool29, label %if.end34, label %if.then30, !dbg !1049

if.then30:                                        ; preds = %land.lhs.true28
  %15 = load i32, ptr %srcRange, align 4, !dbg !1050, !tbaa !1020
  %16 = load i32, ptr %dstRange, align 16, !dbg !1051, !tbaa !1026
  %call33 = call i32 @sws_setColorspaceDetails(ptr noundef %c, ptr noundef getelementptr inbounds nuw (i8, ptr @ff_yuv2rgb_coeffs, i64 80), i32 noundef %15, ptr noundef getelementptr inbounds nuw (i8, ptr @ff_yuv2rgb_coeffs, i64 80), i32 noundef %16, i32 noundef 0, i32 noundef 65536, i32 noundef 65536), !dbg !1052
  br label %if.end34, !dbg !1052

if.end34:                                         ; preds = %if.then30, %land.lhs.true28, %land.lhs.true, %if.end25
  call fastcc void @handle_formats(ptr noundef %c), !dbg !1053
  %17 = load i32, ptr %srcFormat7, align 16, !dbg !1054, !tbaa !1004
    #dbg_value(i32 %17, !910, !DIExpression(), !967)
  %18 = load i32, ptr %dstFormat8, align 4, !dbg !1055, !tbaa !1007
    #dbg_value(i32 %18, !911, !DIExpression(), !967)
  %call37 = call ptr @av_pix_fmt_desc_get(i32 noundef %17), !dbg !1056
    #dbg_value(ptr %call37, !912, !DIExpression(), !967)
  %call38 = call ptr @av_pix_fmt_desc_get(i32 noundef %18), !dbg !1057
    #dbg_value(ptr %call38, !935, !DIExpression(), !967)
  br i1 %7, label %land.lhs.true40, label %if.then47, !dbg !1058

land.lhs.true40:                                  ; preds = %if.end34
  %call41 = call i32 @sws_isSupportedEndiannessConversion(i32 noundef %17), !dbg !1060
  %tobool42 = icmp ne i32 %call41, 0, !dbg !1061
  br i1 %tobool42, label %land.lhs.true43, label %if.then47, !dbg !1062

land.lhs.true43:                                  ; preds = %land.lhs.true40
  %call44 = call i32 @av_pix_fmt_swap_endianness(i32 noundef %17), !dbg !1063
  %cmp45 = icmp eq i32 %call44, %18, !dbg !1064
  br i1 %cmp45, label %if.end58, label %if.then47, !dbg !1065

if.then47:                                        ; preds = %land.lhs.true43, %land.lhs.true40, %if.end34
  %call48 = call i32 @sws_isSupportedInput(i32 noundef %17), !dbg !1066
  %tobool49 = icmp ne i32 %call48, 0, !dbg !1069
  br i1 %tobool49, label %if.end52, label %if.then50, !dbg !1070

if.then50:                                        ; preds = %if.then47
  %call51 = call ptr @av_get_pix_fmt_name(i32 noundef %17), !dbg !1071
  call void (ptr, i32, ptr, ...) @av_log(ptr noundef %c, i32 noundef 16, ptr noundef @.str.3, ptr noundef %call51), !dbg !1073
  br label %cleanup2202, !dbg !1074

if.end52:                                         ; preds = %if.then47
  %call53 = call i32 @sws_isSupportedOutput(i32 noundef %18), !dbg !1075
  %tobool54 = icmp ne i32 %call53, 0, !dbg !1077
  br i1 %tobool54, label %if.end58, label %if.then55, !dbg !1078

if.then55:                                        ; preds = %if.end52
  %call56 = call ptr @av_get_pix_fmt_name(i32 noundef %18), !dbg !1079
  call void (ptr, i32, ptr, ...) @av_log(ptr noundef %c, i32 noundef 16, ptr noundef @.str.4, ptr noundef %call56), !dbg !1081
  br label %cleanup2202, !dbg !1082

if.end58:                                         ; preds = %if.end52, %land.lhs.true43
  %and59 = and i32 %6, 2047, !dbg !1083
    #dbg_value(i32 %and59, !897, !DIExpression(), !967)
  %tobool60 = icmp ne i32 %and59, 0, !dbg !1084
  br i1 %tobool60, label %if.else81, label %if.then61, !dbg !1086

if.then61:                                        ; preds = %if.end58
  %cmp62 = icmp slt i32 %2, %0, !dbg !1087
  br i1 %cmp62, label %land.lhs.true64, label %if.else, !dbg !1090

land.lhs.true64:                                  ; preds = %if.then61
  %cmp65 = icmp slt i32 %3, %1, !dbg !1091
  br i1 %cmp65, label %if.then67, label %if.else, !dbg !1092

if.then67:                                        ; preds = %land.lhs.true64
  %or68 = or i32 %6, 4, !dbg !1093
    #dbg_value(i32 %or68, !908, !DIExpression(), !967)
  br label %if.end79, !dbg !1094

if.else:                                          ; preds = %land.lhs.true64, %if.then61
  %cmp69 = icmp sgt i32 %2, %0, !dbg !1095
  br i1 %cmp69, label %land.lhs.true71, label %if.else76, !dbg !1097

land.lhs.true71:                                  ; preds = %if.else
  %cmp72 = icmp sgt i32 %3, %1, !dbg !1098
  br i1 %cmp72, label %if.then74, label %if.else76, !dbg !1099

if.then74:                                        ; preds = %land.lhs.true71
  %or75 = or i32 %6, 4, !dbg !1100
    #dbg_value(i32 %or75, !908, !DIExpression(), !967)
  br label %if.end79, !dbg !1101

if.else76:                                        ; preds = %land.lhs.true71, %if.else
  %or77 = or i32 %6, 4, !dbg !1102
    #dbg_value(i32 %or77, !908, !DIExpression(), !967)
  br label %if.end79

if.end79:                                         ; preds = %if.else76, %if.then74, %if.then67
  %flags.0 = phi i32 [ %or68, %if.then67 ], [ %or75, %if.then74 ], [ %or77, %if.else76 ], !dbg !1103
    #dbg_value(i32 %flags.0, !908, !DIExpression(), !967)
  store i32 %flags.0, ptr %flags9, align 8, !dbg !1104, !tbaa !1011
  br label %if.end87, !dbg !1105

if.else81:                                        ; preds = %if.end58
  %sub82 = sub nuw nsw i32 %and59, 1, !dbg !1106
  %and83 = and i32 %sub82, %and59, !dbg !1108
  %tobool84 = icmp ne i32 %and83, 0, !dbg !1109
  br i1 %tobool84, label %if.then85, label %if.end87, !dbg !1110

if.then85:                                        ; preds = %if.else81
  call void (ptr, i32, ptr, ...) @av_log(ptr noundef %c, i32 noundef 16, ptr noundef @.str.5, i32 noundef %and59), !dbg !1111
  br label %cleanup2202, !dbg !1113

if.end87:                                         ; preds = %if.else81, %if.end79
  %flags.1 = phi i32 [ %6, %if.else81 ], [ %flags.0, %if.end79 ], !dbg !967
    #dbg_value(i32 %flags.1, !908, !DIExpression(), !967)
  %cmp88 = icmp slt i32 %0, 1, !dbg !1114
  %cmp91 = icmp slt i32 %1, 1
  %or.cond = select i1 %cmp88, i1 true, i1 %cmp91, !dbg !1116
  %cmp94 = icmp slt i32 %2, 1
  %or.cond1 = select i1 %or.cond, i1 true, i1 %cmp94, !dbg !1116
  %cmp97 = icmp slt i32 %3, 1
  %or.cond2 = select i1 %or.cond1, i1 true, i1 %cmp97, !dbg !1116
  br i1 %or.cond2, label %if.then99, label %codeRepl, !dbg !1116

if.then99:                                        ; preds = %if.end87
  call void (ptr, i32, ptr, ...) @av_log(ptr noundef %c, i32 noundef 16, ptr noundef @.str.6, i32 noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3), !dbg !1117
  br label %cleanup2202, !dbg !1119

codeRepl:                                         ; preds = %if.end87
  call fastcc void @pv_shared_0(ptr %dstFilter.addr, ptr %dummyFilter), !dbg !1120
  call fastcc void @pv_shared_1(ptr %srcFilter.addr, ptr %dummyFilter), !dbg !1122
  %conv107 = zext nneg i32 %0 to i64, !dbg !1124
  %shl = mul nuw nsw i64 %conv107, 65536, !dbg !1125
  %shr = lshr i32 %2, 1, !dbg !1126
  %conv108 = zext nneg i32 %shr to i64, !dbg !1127
  %add109 = add nuw nsw i64 %conv108, %shl, !dbg !1128
  %div = sdiv i64 %add109, %conv, !dbg !1129
  %conv111 = trunc i64 %div to i32, !dbg !1130
  %lumXInc = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 9, !dbg !1131
  store i32 %conv111, ptr %lumXInc, align 4, !dbg !1132, !tbaa !1133
  %conv112 = zext nneg i32 %1 to i64, !dbg !1134
  %shl113 = mul nuw nsw i64 %conv112, 65536, !dbg !1135
  %shr114 = lshr i32 %3, 1, !dbg !1136
  %conv115 = zext nneg i32 %shr114 to i64, !dbg !1137
  %add116 = add nuw nsw i64 %conv115, %shl113, !dbg !1138
  %conv117 = zext nneg i32 %3 to i64, !dbg !1139
  %div118 = udiv i64 %add116, %conv117, !dbg !1140
  %conv119 = trunc i64 %div118 to i32, !dbg !1141
  %lumYInc = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 11, !dbg !1142
  store i32 %conv119, ptr %lumYInc, align 4, !dbg !1143, !tbaa !1144
  %call120 = call i32 @av_get_bits_per_pixel(ptr noundef %call38), !dbg !1145
  %dstFormatBpp121 = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 15, !dbg !1146
  store i32 %call120, ptr %dstFormatBpp121, align 4, !dbg !1147, !tbaa !1047
  %call122 = call i32 @av_get_bits_per_pixel(ptr noundef %call37), !dbg !1148
  %srcFormatBpp = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 16, !dbg !1149
  store i32 %call122, ptr %srcFormatBpp, align 8, !dbg !1150, !tbaa !1151
  %vRounder = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 112, !dbg !1152
  store i64 1125917086973956, ptr %vRounder, align 8, !dbg !1153, !tbaa !1154
  %19 = load ptr, ptr %srcFilter.addr, align 8, !dbg !1155, !tbaa !968
  %lumV = getelementptr inbounds nuw %struct.SwsFilter, ptr %19, i32 0, i32 1, !dbg !1156
  %20 = load ptr, ptr %lumV, align 8, !dbg !1156, !tbaa !1157
  %tobool123 = icmp ne ptr %20, null, !dbg !1160
  br i1 %tobool123, label %land.lhs.true124, label %codeRepl2, !dbg !1161

land.lhs.true124:                                 ; preds = %codeRepl
  %length = getelementptr inbounds nuw %struct.SwsVector, ptr %20, i32 0, i32 1, !dbg !1162
  %21 = load i32, ptr %length, align 8, !dbg !1162, !tbaa !1163
  %cmp126 = icmp sgt i32 %21, 1, !dbg !1166
  br i1 %cmp126, label %lor.end, label %codeRepl2, !dbg !1167

codeRepl2:                                        ; preds = %land.lhs.true124, %codeRepl
  call void @llvm.lifetime.start.p0(ptr %.ce.loc)
  call fastcc void @pv_shared_2(ptr %srcFilter.addr, ptr %dstFilter.addr, ptr %.ce.loc), !dbg !1168
  %.ce.reload = load i1, ptr %.ce.loc, align 1
  call void @llvm.lifetime.end.p0(ptr %.ce.loc)
  br label %lor.end

lor.end:                                          ; preds = %codeRepl2, %land.lhs.true124
  %22 = phi i1 [ true, %land.lhs.true124 ], [ %.ce.reload, %codeRepl2 ]
    #dbg_value(i1 %22, !899, !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value), !967)
  %23 = load ptr, ptr %srcFilter.addr, align 8, !dbg !1169, !tbaa !968
  %24 = load ptr, ptr %23, align 8, !dbg !1170, !tbaa !1171
  %tobool152 = icmp ne ptr %24, null, !dbg !1172
  br i1 %tobool152, label %land.lhs.true153, label %codeRepl3, !dbg !1173

land.lhs.true153:                                 ; preds = %lor.end
  %length155 = getelementptr inbounds nuw %struct.SwsVector, ptr %24, i32 0, i32 1, !dbg !1174
  %25 = load i32, ptr %length155, align 8, !dbg !1174, !tbaa !1163
  %cmp156 = icmp sgt i32 %25, 1, !dbg !1175
  br i1 %cmp156, label %lor.end183, label %codeRepl3, !dbg !1176

codeRepl3:                                        ; preds = %land.lhs.true153, %lor.end
  call void @llvm.lifetime.start.p0(ptr %.ce.loc4)
  call fastcc void @pv_shared_3(ptr %srcFilter.addr, ptr %dstFilter.addr, ptr %.ce.loc4), !dbg !1177
  %.ce.reload5 = load i1, ptr %.ce.loc4, align 1
  call void @llvm.lifetime.end.p0(ptr %.ce.loc4)
  br label %lor.end183

lor.end183:                                       ; preds = %codeRepl3, %land.lhs.true153
  %26 = phi i1 [ true, %land.lhs.true153 ], [ %.ce.reload5, %codeRepl3 ]
    #dbg_value(i1 %26, !900, !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value), !967)
  %chrSrcHSubSample = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 19, !dbg !1178
  %chrSrcVSubSample = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 20, !dbg !1179
  %call185 = call i32 @av_pix_fmt_get_chroma_sub_sample(i32 noundef %17, ptr noundef %chrSrcHSubSample, ptr noundef %chrSrcVSubSample), !dbg !1180
  %chrDstHSubSample = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 21, !dbg !1181
  %chrDstVSubSample = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 22, !dbg !1182
  %call186 = call i32 @av_pix_fmt_get_chroma_sub_sample(i32 noundef %18, ptr noundef %chrDstHSubSample, ptr noundef %chrDstVSubSample), !dbg !1183
  %cmp187 = icmp eq i32 %18, 321, !dbg !1184
  %cmp190 = icmp eq i32 %18, 325, !dbg !1186
  %or.cond3 = select i1 %cmp187, i1 true, i1 %cmp190, !dbg !1187
  %cmp193 = icmp eq i32 %18, 326, !dbg !1188
  %or.cond4 = select i1 %or.cond3, i1 true, i1 %cmp193, !dbg !1187
  %cmp196 = icmp eq i32 %18, 322, !dbg !1189
  %or.cond5 = select i1 %or.cond4, i1 true, i1 %cmp196, !dbg !1187
  %cmp199 = icmp eq i32 %18, 327, !dbg !1190
  %or.cond6 = select i1 %or.cond5, i1 true, i1 %cmp199, !dbg !1187
  %cmp202 = icmp eq i32 %18, 328, !dbg !1191
  %or.cond7 = select i1 %or.cond6, i1 true, i1 %cmp202, !dbg !1187
  %cmp205 = icmp eq i32 %18, 323, !dbg !1192
  %or.cond8 = select i1 %or.cond7, i1 true, i1 %cmp205, !dbg !1187
  %cmp208 = icmp eq i32 %18, 329, !dbg !1193
  %or.cond9 = select i1 %or.cond8, i1 true, i1 %cmp208, !dbg !1187
  %cmp211 = icmp eq i32 %18, 330, !dbg !1194
  %or.cond10 = select i1 %or.cond9, i1 true, i1 %cmp211, !dbg !1187
  %cmp214 = icmp eq i32 %18, 324, !dbg !1195
  %or.cond11 = select i1 %or.cond10, i1 true, i1 %cmp214, !dbg !1187
  %cmp217 = icmp eq i32 %18, 331, !dbg !1196
  %or.cond12 = select i1 %or.cond11, i1 true, i1 %cmp217, !dbg !1187
  %cmp220 = icmp eq i32 %18, 332, !dbg !1197
  %or.cond13 = select i1 %or.cond12, i1 true, i1 %cmp220, !dbg !1187
  %cmp223 = icmp eq i32 %18, 41, !dbg !1198
  %or.cond14 = select i1 %or.cond13, i1 true, i1 %cmp223, !dbg !1187
  %cmp226 = icmp eq i32 %18, 42, !dbg !1199
  %or.cond15 = select i1 %or.cond14, i1 true, i1 %cmp226, !dbg !1187
  %cmp229 = icmp eq i32 %18, 30, !dbg !1200
  %or.cond16 = select i1 %or.cond15, i1 true, i1 %cmp229, !dbg !1187
  %cmp232 = icmp eq i32 %18, 29, !dbg !1201
  %or.cond17 = select i1 %or.cond16, i1 true, i1 %cmp232, !dbg !1187
  %cmp235 = icmp eq i32 %18, 2, !dbg !1202
  %or.cond18 = select i1 %or.cond17, i1 true, i1 %cmp235, !dbg !1187
  %cmp238 = icmp eq i32 %18, 43, !dbg !1203
  %or.cond19 = select i1 %or.cond18, i1 true, i1 %cmp238, !dbg !1187
  %cmp241 = icmp eq i32 %18, 44, !dbg !1204
  %or.cond20 = select i1 %or.cond19, i1 true, i1 %cmp241, !dbg !1187
  %cmp244 = icmp eq i32 %18, 45, !dbg !1205
  %or.cond21 = select i1 %or.cond20, i1 true, i1 %cmp244, !dbg !1187
  %cmp247 = icmp eq i32 %18, 46, !dbg !1206
  %or.cond22 = select i1 %or.cond21, i1 true, i1 %cmp247, !dbg !1187
  %cmp250 = icmp eq i32 %18, 63, !dbg !1207
  %or.cond23 = select i1 %or.cond22, i1 true, i1 %cmp250, !dbg !1187
  %cmp253 = icmp eq i32 %18, 62, !dbg !1208
  %or.cond24 = select i1 %or.cond23, i1 true, i1 %cmp253, !dbg !1187
  %cmp256 = icmp eq i32 %18, 22, !dbg !1209
  %or.cond25 = select i1 %or.cond24, i1 true, i1 %cmp256, !dbg !1187
  %cmp259 = icmp eq i32 %18, 23, !dbg !1210
  %or.cond26 = select i1 %or.cond25, i1 true, i1 %cmp259, !dbg !1187
  %cmp262 = icmp eq i32 %18, 24, !dbg !1211
  %or.cond27 = select i1 %or.cond26, i1 true, i1 %cmp262, !dbg !1187
  %cmp265 = icmp eq i32 %18, 291, !dbg !1212
  %or.cond28 = select i1 %or.cond27, i1 true, i1 %cmp265, !dbg !1187
  %cmp268 = icmp eq i32 %18, 292, !dbg !1213
  %or.cond29 = select i1 %or.cond28, i1 true, i1 %cmp268, !dbg !1187
  %cmp271 = icmp eq i32 %18, 10, !dbg !1214
  %or.cond30 = select i1 %or.cond29, i1 true, i1 %cmp271, !dbg !1187
  %cmp274 = icmp eq i32 %18, 9, !dbg !1215
  %or.cond31 = select i1 %or.cond30, i1 true, i1 %cmp274, !dbg !1187
  %cmp277 = icmp eq i32 %18, 67, !dbg !1216
  %or.cond32 = select i1 %or.cond31, i1 true, i1 %cmp277, !dbg !1187
  %cmp280 = icmp eq i32 %18, 68, !dbg !1217
  %or.cond33 = select i1 %or.cond32, i1 true, i1 %cmp280, !dbg !1187
  %cmp283 = icmp eq i32 %18, 28, !dbg !1218
  %or.cond34 = select i1 %or.cond33, i1 true, i1 %cmp283, !dbg !1187
  %cmp286 = icmp eq i32 %18, 27, !dbg !1219
  %or.cond35 = select i1 %or.cond34, i1 true, i1 %cmp286, !dbg !1187
  %cmp289 = icmp eq i32 %18, 3, !dbg !1220
  %or.cond36 = select i1 %or.cond35, i1 true, i1 %cmp289, !dbg !1187
  %cmp292 = icmp eq i32 %18, 47, !dbg !1221
  %or.cond37 = select i1 %or.cond36, i1 true, i1 %cmp292, !dbg !1187
  %cmp295 = icmp eq i32 %18, 48, !dbg !1222
  %or.cond38 = select i1 %or.cond37, i1 true, i1 %cmp295, !dbg !1187
  %cmp298 = icmp eq i32 %18, 49, !dbg !1223
  %or.cond39 = select i1 %or.cond38, i1 true, i1 %cmp298, !dbg !1187
  %cmp301 = icmp eq i32 %18, 50, !dbg !1224
  %or.cond40 = select i1 %or.cond39, i1 true, i1 %cmp301, !dbg !1187
  %cmp304 = icmp eq i32 %18, 65, !dbg !1225
  %or.cond41 = select i1 %or.cond40, i1 true, i1 %cmp304, !dbg !1187
  %cmp307 = icmp eq i32 %18, 64, !dbg !1226
  %or.cond42 = select i1 %or.cond41, i1 true, i1 %cmp307, !dbg !1187
  %cmp310 = icmp eq i32 %18, 19, !dbg !1227
  %or.cond43 = select i1 %or.cond42, i1 true, i1 %cmp310, !dbg !1187
  %cmp313 = icmp eq i32 %18, 20, !dbg !1228
  %or.cond44 = select i1 %or.cond43, i1 true, i1 %cmp313, !dbg !1187
  %cmp316 = icmp eq i32 %18, 21, !dbg !1229
  %or.cond45 = select i1 %or.cond44, i1 true, i1 %cmp316, !dbg !1187
  %cmp319 = icmp eq i32 %18, 293, !dbg !1230
  %or.cond46 = select i1 %or.cond45, i1 true, i1 %cmp319, !dbg !1187
  %cmp322 = icmp eq i32 %18, 294, !dbg !1231
  %or.cond47 = select i1 %or.cond46, i1 true, i1 %cmp322, !dbg !1187
  %or.cond48 = select i1 %or.cond47, i1 true, i1 %cmp271, !dbg !1187
  %or.cond49 = select i1 %or.cond48, i1 true, i1 %cmp274, !dbg !1187
  br i1 %or.cond49, label %land.lhs.true333, label %lor.lhs.false330, !dbg !1187

lor.lhs.false330:                                 ; preds = %lor.end183
  %call331 = call fastcc i32 @isRGB(i32 noundef %18), !dbg !1232
  %tobool332 = icmp ne i32 %call331, 0, !dbg !1233
  br i1 %tobool332, label %land.lhs.true333, label %if.end361, !dbg !1234

land.lhs.true333:                                 ; preds = %lor.lhs.false330, %lor.end183
  %and334 = and i32 %flags.1, 8192, !dbg !1235
  %tobool335 = icmp ne i32 %and334, 0, !dbg !1236
  br i1 %tobool335, label %if.end361, label %if.then336, !dbg !1237

if.then336:                                       ; preds = %land.lhs.true333
  %and337 = and i32 %2, 1, !dbg !1238
  %tobool338 = icmp ne i32 %and337, 0, !dbg !1241
  br i1 %tobool338, label %if.then339, label %if.end342, !dbg !1242

if.then339:                                       ; preds = %if.then336
  call void (ptr, i32, ptr, ...) @av_log(ptr noundef %c, i32 noundef 48, ptr noundef @.str.7), !dbg !1243
  %or340 = or i32 %flags.1, 8192, !dbg !1245
    #dbg_value(i32 %or340, !908, !DIExpression(), !967)
  store i32 %or340, ptr %flags9, align 8, !dbg !1246, !tbaa !1011
  br label %if.end342, !dbg !1247

if.end342:                                        ; preds = %if.then339, %if.then336
  %flags.2 = phi i32 [ %or340, %if.then339 ], [ %flags.1, %if.then336 ], !dbg !967
    #dbg_value(i32 %flags.2, !908, !DIExpression(), !967)
  %27 = load i32, ptr %chrSrcHSubSample, align 4, !dbg !1248, !tbaa !1250
  %cmp344 = icmp eq i32 %27, 0, !dbg !1251
  br i1 %cmp344, label %land.lhs.true346, label %if.end361, !dbg !1252

land.lhs.true346:                                 ; preds = %if.end342
  %28 = load i32, ptr %chrSrcVSubSample, align 8, !dbg !1253, !tbaa !1254
  %cmp348 = icmp eq i32 %28, 0, !dbg !1255
  br i1 %cmp348, label %land.lhs.true350, label %if.end361, !dbg !1256

land.lhs.true350:                                 ; preds = %land.lhs.true346
  %dither = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 150, !dbg !1257
  %29 = load i32, ptr %dither, align 4, !dbg !1257, !tbaa !1258
  %cmp351 = icmp ne i32 %29, 2, !dbg !1259
  br i1 %cmp351, label %land.lhs.true353, label %if.end361, !dbg !1260

land.lhs.true353:                                 ; preds = %land.lhs.true350
  %30 = load i32, ptr %flags9, align 8, !dbg !1261, !tbaa !1011
  %and355 = and i32 %30, 1, !dbg !1262
  %tobool356 = icmp ne i32 %and355, 0, !dbg !1263
  br i1 %tobool356, label %if.end361, label %if.then357, !dbg !1264

if.then357:                                       ; preds = %land.lhs.true353
  call void (ptr, i32, ptr, ...) @av_log(ptr noundef %c, i32 noundef 48, ptr noundef @.str.8), !dbg !1265
  %or358 = or i32 %flags.2, 8192, !dbg !1267
    #dbg_value(i32 %or358, !908, !DIExpression(), !967)
  store i32 %or358, ptr %flags9, align 8, !dbg !1268, !tbaa !1011
  br label %if.end361, !dbg !1269

if.end361:                                        ; preds = %if.then357, %land.lhs.true353, %land.lhs.true350, %land.lhs.true346, %if.end342, %land.lhs.true333, %lor.lhs.false330
  %flags.3 = phi i32 [ %flags.1, %land.lhs.true333 ], [ %flags.2, %land.lhs.true353 ], [ %or358, %if.then357 ], [ %flags.2, %land.lhs.true350 ], [ %flags.2, %land.lhs.true346 ], [ %flags.2, %if.end342 ], [ %flags.1, %lor.lhs.false330 ], !dbg !967
    #dbg_value(i32 %flags.3, !908, !DIExpression(), !967)
  %dither362 = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 150, !dbg !1270
  %31 = load i32, ptr %dither362, align 4, !dbg !1270, !tbaa !1258
  %cmp363 = icmp eq i32 %31, 1, !dbg !1272
  br i1 %cmp363, label %if.then365, label %if.end371, !dbg !1273

if.then365:                                       ; preds = %if.end361
  %and366 = and i32 %flags.3, 8388608, !dbg !1274
  %tobool367 = icmp ne i32 %and366, 0, !dbg !1277
  br i1 %tobool367, label %if.then368, label %if.end371, !dbg !1278

if.then368:                                       ; preds = %if.then365
  store i32 3, ptr %dither362, align 4, !dbg !1279, !tbaa !1258
  br label %if.end371, !dbg !1280

if.end371:                                        ; preds = %if.then368, %if.then365, %if.end361
  %or.cond50 = select i1 %cmp316, i1 true, i1 %cmp262, !dbg !1281
  %or.cond51 = select i1 %or.cond50, i1 true, i1 %cmp310, !dbg !1281
  %or.cond52 = select i1 %or.cond51, i1 true, i1 %cmp256, !dbg !1281
  br i1 %or.cond52, label %if.then383, label %if.end423, !dbg !1281

if.then383:                                       ; preds = %if.end371
  %32 = load i32, ptr %dither362, align 4, !dbg !1283, !tbaa !1258
  %cmp385 = icmp eq i32 %32, 1, !dbg !1286
  br i1 %cmp385, label %if.then387, label %if.end391, !dbg !1287

if.then387:                                       ; preds = %if.then383
  %and388 = and i32 %flags.3, 8192, !dbg !1288
  %tobool389 = icmp ne i32 %and388, 0, !dbg !1289
  %cond = select i1 %tobool389, i32 3, i32 2, !dbg !1290
  store i32 %cond, ptr %dither362, align 4, !dbg !1291, !tbaa !1258
  br label %if.end391, !dbg !1292

if.end391:                                        ; preds = %if.then387, %if.then383
  %and392 = and i32 %flags.3, 8192, !dbg !1293
  %tobool393 = icmp ne i32 %and392, 0, !dbg !1295
  br i1 %tobool393, label %if.end411, label %if.then394, !dbg !1296

if.then394:                                       ; preds = %if.end391
  %33 = load i32, ptr %dither362, align 4, !dbg !1297, !tbaa !1258
  %cmp396 = icmp eq i32 %33, 3, !dbg !1300
  br i1 %cmp396, label %if.then406, label %lor.lhs.false398, !dbg !1301

lor.lhs.false398:                                 ; preds = %if.then394
  %cmp400 = icmp eq i32 %33, 4, !dbg !1302
  br i1 %cmp400, label %if.then406, label %lor.lhs.false402, !dbg !1303

lor.lhs.false402:                                 ; preds = %lor.lhs.false398
  %cmp404 = icmp eq i32 %33, 5, !dbg !1304
  br i1 %cmp404, label %if.then406, label %if.end411, !dbg !1305

if.then406:                                       ; preds = %lor.lhs.false402, %lor.lhs.false398, %if.then394
  %call407 = call ptr @av_get_pix_fmt_name(i32 noundef %18), !dbg !1306
  call void (ptr, i32, ptr, ...) @av_log(ptr noundef %c, i32 noundef 48, ptr noundef @.str.9, ptr noundef %call407), !dbg !1308
  %or408 = or i32 %flags.3, 8192, !dbg !1309
    #dbg_value(i32 %or408, !908, !DIExpression(), !967)
  store i32 %or408, ptr %flags9, align 8, !dbg !1310, !tbaa !1011
  br label %if.end411, !dbg !1311

if.end411:                                        ; preds = %if.then406, %lor.lhs.false402, %if.end391
  %flags.4 = phi i32 [ %flags.3, %if.end391 ], [ %or408, %if.then406 ], [ %flags.3, %lor.lhs.false402 ], !dbg !967
    #dbg_value(i32 %flags.4, !908, !DIExpression(), !967)
  %and412 = and i32 %flags.4, 8192, !dbg !1312
  %tobool413 = icmp ne i32 %and412, 0, !dbg !1314
  br i1 %tobool413, label %if.then414, label %if.end423, !dbg !1315

if.then414:                                       ; preds = %if.end411
  %34 = load i32, ptr %dither362, align 4, !dbg !1316, !tbaa !1258
  %cmp416 = icmp eq i32 %34, 2, !dbg !1319
  br i1 %cmp416, label %if.then418, label %if.end423, !dbg !1320

if.then418:                                       ; preds = %if.then414
  %call419 = call ptr @av_get_pix_fmt_name(i32 noundef %18), !dbg !1321
  call void (ptr, i32, ptr, ...) @av_log(ptr noundef %c, i32 noundef 48, ptr noundef @.str.10, ptr noundef %call419), !dbg !1323
  store i32 3, ptr %dither362, align 4, !dbg !1324, !tbaa !1258
  br label %if.end423, !dbg !1325

if.end423:                                        ; preds = %if.then418, %if.then414, %if.end411, %if.end371
  %flags.5 = phi i32 [ %flags.4, %if.then418 ], [ %flags.4, %if.then414 ], [ %flags.4, %if.end411 ], [ %flags.3, %if.end371 ], !dbg !1326
    #dbg_value(i32 %flags.5, !908, !DIExpression(), !967)
  %call424 = call fastcc i32 @isPlanarRGB(i32 noundef %18), !dbg !1327
  %tobool425 = icmp ne i32 %call424, 0, !dbg !1329
  br i1 %tobool425, label %if.then426, label %if.end434, !dbg !1330

if.then426:                                       ; preds = %if.end423
  %and427 = and i32 %flags.5, 8192, !dbg !1331
  %tobool428 = icmp ne i32 %and427, 0, !dbg !1334
  br i1 %tobool428, label %if.end434, label %if.then429, !dbg !1335

if.then429:                                       ; preds = %if.then426
  %call430 = call ptr @av_get_pix_fmt_name(i32 noundef %18), !dbg !1336
  call void (ptr, i32, ptr, ...) @av_log(ptr noundef %c, i32 noundef 48, ptr noundef @.str.11, ptr noundef %call430), !dbg !1338
  %or431 = or i32 %flags.5, 8192, !dbg !1339
    #dbg_value(i32 %or431, !908, !DIExpression(), !967)
  store i32 %or431, ptr %flags9, align 8, !dbg !1340, !tbaa !1011
  br label %if.end434, !dbg !1341

if.end434:                                        ; preds = %if.then429, %if.then426, %if.end423
  %flags.6 = phi i32 [ %flags.5, %if.then426 ], [ %or431, %if.then429 ], [ %flags.5, %if.end423 ], !dbg !967
    #dbg_value(i32 %flags.6, !908, !DIExpression(), !967)
  %and435 = and i32 %flags.6, 8192, !dbg !1342
  %tobool436 = icmp ne i32 %and435, 0, !dbg !1344
  br i1 %tobool436, label %land.lhs.true437, label %if.end645, !dbg !1345

land.lhs.true437:                                 ; preds = %if.end434
  br i1 %or.cond49, label %land.lhs.true584, label %lor.lhs.false581, !dbg !1346

lor.lhs.false581:                                 ; preds = %land.lhs.true437
  %call582 = call fastcc i32 @isRGB(i32 noundef %18), !dbg !1347
  %tobool583 = icmp ne i32 %call582, 0, !dbg !1348
  br i1 %tobool583, label %land.lhs.true584, label %if.end645, !dbg !1349

land.lhs.true584:                                 ; preds = %lor.lhs.false581, %land.lhs.true437
  %call585 = call fastcc i32 @isPlanarRGB(i32 noundef %18), !dbg !1350
  %tobool586 = icmp eq i32 %call585, 0, !dbg !1351
  %cmp588 = icmp ne i32 %18, 292
  %or.cond100 = select i1 %tobool586, i1 %cmp588, i1 false, !dbg !1352
  %cmp591 = icmp ne i32 %18, 291
  %or.cond101 = select i1 %or.cond100, i1 %cmp591, i1 false, !dbg !1352
  %cmp594 = icmp ne i32 %18, 294
  %or.cond102 = select i1 %or.cond101, i1 %cmp594, i1 false, !dbg !1352
  %cmp597 = icmp ne i32 %18, 293
  %or.cond103 = select i1 %or.cond102, i1 %cmp597, i1 false, !dbg !1352
  %cmp600 = icmp ne i32 %18, 42
  %or.cond104 = select i1 %or.cond103, i1 %cmp600, i1 false, !dbg !1352
  %cmp603 = icmp ne i32 %18, 41
  %or.cond105 = select i1 %or.cond104, i1 %cmp603, i1 false, !dbg !1352
  %cmp606 = icmp ne i32 %18, 68
  %or.cond106 = select i1 %or.cond105, i1 %cmp606, i1 false, !dbg !1352
  %cmp609 = icmp ne i32 %18, 67
  %or.cond107 = select i1 %or.cond106, i1 %cmp609, i1 false, !dbg !1352
  %cmp612 = icmp ne i32 %18, 28
  %or.cond108 = select i1 %or.cond107, i1 %cmp612, i1 false, !dbg !1352
  %cmp615 = icmp ne i32 %18, 27
  %or.cond109 = select i1 %or.cond108, i1 %cmp615, i1 false, !dbg !1352
  %cmp618 = icmp ne i32 %18, 30
  %or.cond110 = select i1 %or.cond109, i1 %cmp618, i1 false, !dbg !1352
  %cmp621 = icmp ne i32 %18, 29
  %or.cond111 = select i1 %or.cond110, i1 %cmp621, i1 false, !dbg !1352
  %cmp624 = icmp ne i32 %18, 2
  %or.cond112 = select i1 %or.cond111, i1 %cmp624, i1 false, !dbg !1352
  %cmp627 = icmp ne i32 %18, 3
  %or.cond113 = select i1 %or.cond112, i1 %cmp627, i1 false, !dbg !1352
  %cmp630 = icmp ne i32 %18, 21
  %or.cond114 = select i1 %or.cond113, i1 %cmp630, i1 false, !dbg !1352
  %cmp633 = icmp ne i32 %18, 24
  %or.cond115 = select i1 %or.cond114, i1 %cmp633, i1 false, !dbg !1352
  %cmp636 = icmp ne i32 %18, 19
  %or.cond116 = select i1 %or.cond115, i1 %cmp636, i1 false, !dbg !1352
  %cmp639 = icmp ne i32 %18, 22
  %or.cond117 = select i1 %or.cond116, i1 %cmp639, i1 false, !dbg !1352
  br i1 %or.cond117, label %if.then641, label %if.end645, !dbg !1352

if.then641:                                       ; preds = %land.lhs.true584
  %call642 = call ptr @av_get_pix_fmt_name(i32 noundef %18), !dbg !1353
  call void (ptr, i32, ptr, ...) @av_log(ptr noundef %c, i32 noundef 24, ptr noundef @.str.12, ptr noundef %call642), !dbg !1355
  %and643 = and i32 %flags.6, -8193, !dbg !1356
    #dbg_value(i32 %and643, !908, !DIExpression(), !967)
  store i32 %and643, ptr %flags9, align 8, !dbg !1357, !tbaa !1011
  br label %if.end645, !dbg !1358

if.end645:                                        ; preds = %if.then641, %land.lhs.true584, %lor.lhs.false581, %if.end434
  %flags.7 = phi i32 [ %and643, %if.then641 ], [ %flags.6, %land.lhs.true584 ], [ %flags.6, %lor.lhs.false581 ], [ %flags.6, %if.end434 ], !dbg !967
    #dbg_value(i32 %flags.7, !908, !DIExpression(), !967)
  br i1 %or.cond49, label %land.lhs.true792, label %lor.lhs.false789, !dbg !1359

lor.lhs.false789:                                 ; preds = %if.end645
  %call790 = call fastcc i32 @isRGB(i32 noundef %18), !dbg !1361
  %tobool791 = icmp ne i32 %call790, 0, !dbg !1362
  br i1 %tobool791, label %land.lhs.true792, label %if.end797, !dbg !1363

land.lhs.true792:                                 ; preds = %lor.lhs.false789, %if.end645
  %and793 = and i32 %flags.7, 8192, !dbg !1364
  %tobool794 = icmp ne i32 %and793, 0, !dbg !1365
  br i1 %tobool794, label %if.end797, label %if.then795, !dbg !1366

if.then795:                                       ; preds = %land.lhs.true792
  store i32 1, ptr %chrDstHSubSample, align 4, !dbg !1367, !tbaa !1368
  br label %if.end797, !dbg !1369

if.end797:                                        ; preds = %if.then795, %land.lhs.true792, %lor.lhs.false789
  %and798 = and i32 %flags.7, 196608, !dbg !1370
  %shr799 = lshr i32 %and798, 16, !dbg !1371
  %vChrDrop = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 23, !dbg !1372
  store i32 %shr799, ptr %vChrDrop, align 4, !dbg !1373, !tbaa !1374
  %35 = load i32, ptr %chrSrcVSubSample, align 8, !dbg !1375, !tbaa !1254
  %add802 = add nsw i32 %35, %shr799, !dbg !1376
  store i32 %add802, ptr %chrSrcVSubSample, align 8, !dbg !1377, !tbaa !1254
  %cmp803 = icmp eq i32 %17, 321, !dbg !1378
  %cmp806 = icmp eq i32 %17, 325, !dbg !1380
  %or.cond165 = select i1 %cmp803, i1 true, i1 %cmp806, !dbg !1381
  %cmp809 = icmp eq i32 %17, 326, !dbg !1382
  %or.cond166 = select i1 %or.cond165, i1 true, i1 %cmp809, !dbg !1381
  %cmp812 = icmp eq i32 %17, 322, !dbg !1383
  %or.cond167 = select i1 %or.cond166, i1 true, i1 %cmp812, !dbg !1381
  %cmp815 = icmp eq i32 %17, 327, !dbg !1384
  %or.cond168 = select i1 %or.cond167, i1 true, i1 %cmp815, !dbg !1381
  %cmp818 = icmp eq i32 %17, 328, !dbg !1385
  %or.cond169 = select i1 %or.cond168, i1 true, i1 %cmp818, !dbg !1381
  %cmp821 = icmp eq i32 %17, 323, !dbg !1386
  %or.cond170 = select i1 %or.cond169, i1 true, i1 %cmp821, !dbg !1381
  %cmp824 = icmp eq i32 %17, 329, !dbg !1387
  %or.cond171 = select i1 %or.cond170, i1 true, i1 %cmp824, !dbg !1381
  %cmp827 = icmp eq i32 %17, 330, !dbg !1388
  %or.cond172 = select i1 %or.cond171, i1 true, i1 %cmp827, !dbg !1381
  %cmp830 = icmp eq i32 %17, 324, !dbg !1389
  %or.cond173 = select i1 %or.cond172, i1 true, i1 %cmp830, !dbg !1381
  %cmp833 = icmp eq i32 %17, 331, !dbg !1390
  %or.cond174 = select i1 %or.cond173, i1 true, i1 %cmp833, !dbg !1381
  %cmp836 = icmp eq i32 %17, 332, !dbg !1391
  %or.cond175 = select i1 %or.cond174, i1 true, i1 %cmp836, !dbg !1381
  %cmp839 = icmp eq i32 %17, 41, !dbg !1392
  %or.cond176 = select i1 %or.cond175, i1 true, i1 %cmp839, !dbg !1381
  %cmp842 = icmp eq i32 %17, 42, !dbg !1393
  %or.cond177 = select i1 %or.cond176, i1 true, i1 %cmp842, !dbg !1381
  %cmp845 = icmp eq i32 %17, 30, !dbg !1394
  %or.cond178 = select i1 %or.cond177, i1 true, i1 %cmp845, !dbg !1381
  %cmp848 = icmp eq i32 %17, 29, !dbg !1395
  %or.cond179 = select i1 %or.cond178, i1 true, i1 %cmp848, !dbg !1381
  %cmp851 = icmp eq i32 %17, 2, !dbg !1396
  %or.cond180 = select i1 %or.cond179, i1 true, i1 %cmp851, !dbg !1381
  %cmp854 = icmp eq i32 %17, 43, !dbg !1397
  %or.cond181 = select i1 %or.cond180, i1 true, i1 %cmp854, !dbg !1381
  %cmp857 = icmp eq i32 %17, 44, !dbg !1398
  %or.cond182 = select i1 %or.cond181, i1 true, i1 %cmp857, !dbg !1381
  %cmp860 = icmp eq i32 %17, 45, !dbg !1399
  %or.cond183 = select i1 %or.cond182, i1 true, i1 %cmp860, !dbg !1381
  %cmp863 = icmp eq i32 %17, 46, !dbg !1400
  %or.cond184 = select i1 %or.cond183, i1 true, i1 %cmp863, !dbg !1381
  %cmp866 = icmp eq i32 %17, 63, !dbg !1401
  %or.cond185 = select i1 %or.cond184, i1 true, i1 %cmp866, !dbg !1381
  %cmp869 = icmp eq i32 %17, 62, !dbg !1402
  %or.cond186 = select i1 %or.cond185, i1 true, i1 %cmp869, !dbg !1381
  %cmp872 = icmp eq i32 %17, 22, !dbg !1403
  %or.cond187 = select i1 %or.cond186, i1 true, i1 %cmp872, !dbg !1381
  %cmp875 = icmp eq i32 %17, 23, !dbg !1404
  %or.cond188 = select i1 %or.cond187, i1 true, i1 %cmp875, !dbg !1381
  %cmp878 = icmp eq i32 %17, 24, !dbg !1405
  %or.cond189 = select i1 %or.cond188, i1 true, i1 %cmp878, !dbg !1381
  %cmp881 = icmp eq i32 %17, 291, !dbg !1406
  %or.cond190 = select i1 %or.cond189, i1 true, i1 %cmp881, !dbg !1381
  %cmp884 = icmp eq i32 %17, 292, !dbg !1407
  %or.cond191 = select i1 %or.cond190, i1 true, i1 %cmp884, !dbg !1381
  %cmp887 = icmp eq i32 %17, 10, !dbg !1408
  %or.cond192 = select i1 %or.cond191, i1 true, i1 %cmp887, !dbg !1381
  %cmp890 = icmp eq i32 %17, 9, !dbg !1409
  %or.cond193 = select i1 %or.cond192, i1 true, i1 %cmp890, !dbg !1381
  %cmp893 = icmp eq i32 %17, 67, !dbg !1410
  %or.cond194 = select i1 %or.cond193, i1 true, i1 %cmp893, !dbg !1381
  %cmp896 = icmp eq i32 %17, 68, !dbg !1411
  %or.cond195 = select i1 %or.cond194, i1 true, i1 %cmp896, !dbg !1381
  %cmp899 = icmp eq i32 %17, 28, !dbg !1412
  %or.cond196 = select i1 %or.cond195, i1 true, i1 %cmp899, !dbg !1381
  %cmp902 = icmp eq i32 %17, 27, !dbg !1413
  %or.cond197 = select i1 %or.cond196, i1 true, i1 %cmp902, !dbg !1381
  %cmp905 = icmp eq i32 %17, 3, !dbg !1414
  %or.cond198 = select i1 %or.cond197, i1 true, i1 %cmp905, !dbg !1381
  %cmp908 = icmp eq i32 %17, 47, !dbg !1415
  %or.cond199 = select i1 %or.cond198, i1 true, i1 %cmp908, !dbg !1381
  %cmp911 = icmp eq i32 %17, 48, !dbg !1416
  %or.cond200 = select i1 %or.cond199, i1 true, i1 %cmp911, !dbg !1381
  %cmp914 = icmp eq i32 %17, 49, !dbg !1417
  %or.cond201 = select i1 %or.cond200, i1 true, i1 %cmp914, !dbg !1381
  %cmp917 = icmp eq i32 %17, 50, !dbg !1418
  %or.cond202 = select i1 %or.cond201, i1 true, i1 %cmp917, !dbg !1381
  %cmp920 = icmp eq i32 %17, 65, !dbg !1419
  %or.cond203 = select i1 %or.cond202, i1 true, i1 %cmp920, !dbg !1381
  %cmp923 = icmp eq i32 %17, 64, !dbg !1420
  %or.cond204 = select i1 %or.cond203, i1 true, i1 %cmp923, !dbg !1381
  %cmp926 = icmp eq i32 %17, 19, !dbg !1421
  %or.cond205 = select i1 %or.cond204, i1 true, i1 %cmp926, !dbg !1381
  %cmp929 = icmp eq i32 %17, 20, !dbg !1422
  %or.cond206 = select i1 %or.cond205, i1 true, i1 %cmp929, !dbg !1381
  %cmp932 = icmp eq i32 %17, 21, !dbg !1423
  %or.cond207 = select i1 %or.cond206, i1 true, i1 %cmp932, !dbg !1381
  %cmp935 = icmp eq i32 %17, 293, !dbg !1424
  %or.cond208 = select i1 %or.cond207, i1 true, i1 %cmp935, !dbg !1381
  %cmp938 = icmp eq i32 %17, 294, !dbg !1425
  %or.cond209 = select i1 %or.cond208, i1 true, i1 %cmp938, !dbg !1381
  %or.cond210 = select i1 %or.cond209, i1 true, i1 %cmp887, !dbg !1381
  %or.cond211 = select i1 %or.cond210, i1 true, i1 %cmp890, !dbg !1381
  br i1 %or.cond211, label %land.lhs.true949, label %lor.lhs.false946, !dbg !1381

lor.lhs.false946:                                 ; preds = %if.end797
  %call947 = call fastcc i32 @isRGB(i32 noundef %17), !dbg !1426
  %tobool948 = icmp ne i32 %call947, 0, !dbg !1427
  br i1 %tobool948, label %land.lhs.true949, label %if.end1011, !dbg !1428

land.lhs.true949:                                 ; preds = %lor.lhs.false946, %if.end797
  %and950 = and i32 %flags.7, 16384, !dbg !1429
  %tobool951 = icmp eq i32 %and950, 0, !dbg !1430
  %cmp953 = icmp ne i32 %17, 22
  %or.cond212 = select i1 %tobool951, i1 %cmp953, i1 false, !dbg !1431
  %cmp956 = icmp ne i32 %17, 19
  %or.cond213 = select i1 %or.cond212, i1 %cmp956, i1 false, !dbg !1431
  %cmp959 = icmp ne i32 %17, 23
  %or.cond214 = select i1 %or.cond213, i1 %cmp959, i1 false, !dbg !1431
  %cmp962 = icmp ne i32 %17, 20
  %or.cond215 = select i1 %or.cond214, i1 %cmp962, i1 false, !dbg !1431
  %cmp965 = icmp ne i32 %17, 24
  %or.cond216 = select i1 %or.cond215, i1 %cmp965, i1 false, !dbg !1431
  %cmp968 = icmp ne i32 %17, 21
  %or.cond217 = select i1 %or.cond216, i1 %cmp968, i1 false, !dbg !1431
  %cmp971 = icmp ne i32 %17, 83
  %or.cond218 = select i1 %or.cond217, i1 %cmp971, i1 false, !dbg !1431
  %cmp974 = icmp ne i32 %17, 84
  %or.cond219 = select i1 %or.cond218, i1 %cmp974, i1 false, !dbg !1431
  %cmp977 = icmp ne i32 %17, 85
  %or.cond220 = select i1 %or.cond219, i1 %cmp977, i1 false, !dbg !1431
  %cmp980 = icmp ne i32 %17, 86
  %or.cond221 = select i1 %or.cond220, i1 %cmp980, i1 false, !dbg !1431
  %cmp983 = icmp ne i32 %17, 313
  %or.cond222 = select i1 %or.cond221, i1 %cmp983, i1 false, !dbg !1431
  %cmp986 = icmp ne i32 %17, 314
  %or.cond223 = select i1 %or.cond222, i1 %cmp986, i1 false, !dbg !1431
  %cmp989 = icmp ne i32 %17, 315
  %or.cond224 = select i1 %or.cond223, i1 %cmp989, i1 false, !dbg !1431
  %cmp992 = icmp ne i32 %17, 316
  %or.cond225 = select i1 %or.cond224, i1 %cmp992, i1 false, !dbg !1431
  %cmp995 = icmp ne i32 %17, 87
  %or.cond226 = select i1 %or.cond225, i1 %cmp995, i1 false, !dbg !1431
  %cmp998 = icmp ne i32 %17, 88
  %or.cond227 = select i1 %or.cond226, i1 %cmp998, i1 false, !dbg !1431
  br i1 %or.cond227, label %land.lhs.true1000, label %if.end1011, !dbg !1431

land.lhs.true1000:                                ; preds = %land.lhs.true949
  %36 = load i32, ptr %chrDstHSubSample, align 4, !dbg !1432, !tbaa !1368
  %shr1002 = lshr i32 %2, %36, !dbg !1433
  %shr1003 = lshr i32 %0, 1, !dbg !1434
  %cmp1004 = icmp sle i32 %shr1002, %shr1003, !dbg !1435
  br i1 %cmp1004, label %if.then1009, label %lor.lhs.false1006, !dbg !1436

lor.lhs.false1006:                                ; preds = %land.lhs.true1000
  %and1007 = and i32 %flags.7, 1, !dbg !1437
  %tobool1008 = icmp ne i32 %and1007, 0, !dbg !1438
  br i1 %tobool1008, label %if.then1009, label %if.end1011, !dbg !1439

if.then1009:                                      ; preds = %lor.lhs.false1006, %land.lhs.true1000
  store i32 1, ptr %chrSrcHSubSample, align 4, !dbg !1440, !tbaa !1250
  br label %if.end1011, !dbg !1441

if.end1011:                                       ; preds = %if.then1009, %lor.lhs.false1006, %land.lhs.true949, %lor.lhs.false946
  %37 = load i32, ptr %chrSrcHSubSample, align 4, !dbg !1442, !tbaa !1250
  br label %cond.true, !dbg !1443

cond.true:                                        ; preds = %if.end1011
  %sub1013 = sub nsw i32 0, %0, !dbg !1444
  %shr1015 = ashr i32 %sub1013, %37, !dbg !1444
  %sub1016 = sub nsw i32 0, %shr1015, !dbg !1444
  br label %cond.end, !dbg !1444

cond.end:                                         ; preds = %cond.true
  %chrSrcW = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 5, !dbg !1445
  store i32 %sub1016, ptr %chrSrcW, align 4, !dbg !1446, !tbaa !1447
  %38 = load i32, ptr %chrSrcVSubSample, align 8, !dbg !1448, !tbaa !1254
  br label %cond.true1025, !dbg !1449

cond.true1025:                                    ; preds = %cond.end
  %sub1026 = sub nsw i32 0, %1, !dbg !1450
  %shr1028 = ashr i32 %sub1026, %38, !dbg !1450
  %sub1029 = sub nsw i32 0, %shr1028, !dbg !1450
  br label %cond.end1037, !dbg !1450

cond.end1037:                                     ; preds = %cond.true1025
  %chrSrcH = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 6, !dbg !1451
  store i32 %sub1029, ptr %chrSrcH, align 16, !dbg !1452, !tbaa !1453
  %39 = load i32, ptr %chrDstHSubSample, align 4, !dbg !1454, !tbaa !1368
  br label %cond.true1040, !dbg !1455

cond.true1040:                                    ; preds = %cond.end1037
  %sub1041 = sub nsw i32 0, %2, !dbg !1456
  %shr1043 = ashr i32 %sub1041, %39, !dbg !1456
  %sub1044 = sub nsw i32 0, %shr1043, !dbg !1456
  br label %cond.end1052, !dbg !1456

cond.end1052:                                     ; preds = %cond.true1040
  %chrDstW = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 7, !dbg !1457
  store i32 %sub1044, ptr %chrDstW, align 4, !dbg !1458, !tbaa !1459
  %40 = load i32, ptr %chrDstVSubSample, align 16, !dbg !1460, !tbaa !1461
  br label %cond.true1055, !dbg !1462

cond.true1055:                                    ; preds = %cond.end1052
  %sub1056 = sub nsw i32 0, %3, !dbg !1463
  %shr1058 = ashr i32 %sub1056, %40, !dbg !1463
  %sub1059 = sub nsw i32 0, %shr1058, !dbg !1463
  br label %cond.end1067, !dbg !1463

cond.end1067:                                     ; preds = %cond.true1055
  %chrDstH = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 8, !dbg !1464
  store i32 %sub1059, ptr %chrDstH, align 8, !dbg !1465, !tbaa !1466
  %mul1069 = mul nuw nsw i32 %0, 2, !dbg !1467
  %sub1072 = add nuw i32 %mul1069, 93, !dbg !1469
  %and1073 = and i32 %sub1072, -16, !dbg !1469
  %mul1074 = mul nuw nsw i32 %and1073, 2, !dbg !1470
  %conv1075 = zext nneg i32 %mul1074 to i64, !dbg !1469
  %call1076 = call noalias ptr @av_mallocz(i64 noundef %conv1075), !dbg !1471
  %formatConvBuffer = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 48, !dbg !1472
  store ptr %call1076, ptr %formatConvBuffer, align 16, !dbg !1473, !tbaa !1474
  %tobool1078 = icmp ne ptr %call1076, null, !dbg !1475
  br i1 %tobool1078, label %if.end1089, label %land.lhs.true1079, !dbg !1477

land.lhs.true1079:                                ; preds = %cond.end1067
  br label %if.then1088, !dbg !1478

if.then1088:                                      ; preds = %land.lhs.true1079
  call void (ptr, i32, ptr, ...) @av_log(ptr noundef %c, i32 noundef 16, ptr noundef @.str.13), !dbg !1479
  br label %fail, !dbg !1481

if.end1089:                                       ; preds = %cond.end1067
  %comp = getelementptr inbounds nuw %struct.AVPixFmtDescriptor, ptr %call37, i32 0, i32 5, !dbg !1482
  %bf.load = load i16, ptr %comp, align 4, !dbg !1483
  %bf.lshr = lshr i16 %bf.load, 11, !dbg !1483
  %bf.clear = and i16 %bf.lshr, 15, !dbg !1483
  %conv1090 = zext nneg i16 %bf.clear to i32, !dbg !1484
  %add1091 = add nuw nsw i32 %conv1090, 1, !dbg !1485
  %srcBpc = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 18, !dbg !1486
  store i32 %add1091, ptr %srcBpc, align 16, !dbg !1487, !tbaa !1488
  %cmp1093 = icmp slt i32 %add1091, 8, !dbg !1489
  br i1 %cmp1093, label %if.then1095, label %if.end1097, !dbg !1491

if.then1095:                                      ; preds = %if.end1089
  store i32 8, ptr %srcBpc, align 16, !dbg !1492, !tbaa !1488
  br label %if.end1097, !dbg !1493

if.end1097:                                       ; preds = %if.then1095, %if.end1089
  %comp1098 = getelementptr inbounds nuw %struct.AVPixFmtDescriptor, ptr %call38, i32 0, i32 5, !dbg !1494
  %bf.load1100 = load i16, ptr %comp1098, align 4, !dbg !1495
  %bf.lshr1101 = lshr i16 %bf.load1100, 11, !dbg !1495
  %bf.clear1102 = and i16 %bf.lshr1101, 15, !dbg !1495
  %conv1103 = zext nneg i16 %bf.clear1102 to i32, !dbg !1496
  %add1104 = add nuw nsw i32 %conv1103, 1, !dbg !1497
  %dstBpc = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 17, !dbg !1498
  store i32 %add1104, ptr %dstBpc, align 4, !dbg !1499, !tbaa !1500
  %cmp1106 = icmp slt i32 %add1104, 8, !dbg !1501
  br i1 %cmp1106, label %if.then1108, label %if.end1110, !dbg !1503

if.then1108:                                      ; preds = %if.end1097
  store i32 8, ptr %dstBpc, align 4, !dbg !1504, !tbaa !1500
  br label %if.end1110, !dbg !1505

if.end1110:                                       ; preds = %if.then1108, %if.end1097
  br i1 %or.cond211, label %if.then1260, label %lor.lhs.false1254, !dbg !1506

lor.lhs.false1254:                                ; preds = %if.end1110
  %call1255 = call fastcc i32 @isRGB(i32 noundef %17), !dbg !1508
  %tobool1256 = icmp ne i32 %call1255, 0, !dbg !1509
  %cmp1258 = icmp eq i32 %17, 11
  %or.cond275 = select i1 %tobool1256, i1 true, i1 %cmp1258, !dbg !1510
  br i1 %or.cond275, label %if.then1260, label %if.end1262, !dbg !1510

if.then1260:                                      ; preds = %lor.lhs.false1254, %if.end1110
  store i32 16, ptr %srcBpc, align 16, !dbg !1511, !tbaa !1488
  br label %if.end1262, !dbg !1512

if.end1262:                                       ; preds = %if.then1260, %lor.lhs.false1254
  %41 = load i32, ptr %dstBpc, align 4, !dbg !1513, !tbaa !1500
  %cmp1264 = icmp eq i32 %41, 16, !dbg !1515
  br i1 %cmp1264, label %if.then1266, label %if.end1268, !dbg !1516

if.then1266:                                      ; preds = %if.end1262
  %shl1267 = shl i32 %conv6, 1, !dbg !1517
    #dbg_value(i32 %shl1267, !907, !DIExpression(), !967)
  br label %if.end1268, !dbg !1518

if.end1268:                                       ; preds = %if.then1266, %if.end1262
  %dst_stride.0 = phi i32 [ %shl1267, %if.then1266 ], [ %conv6, %if.end1262 ], !dbg !967
    #dbg_value(i32 %dst_stride.0, !907, !DIExpression(), !967)
  %canMMXEXTBeUsed = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 65, !dbg !1519
  store i32 0, ptr %canMMXEXTBeUsed, align 16, !dbg !1521, !tbaa !1522
  %42 = load i32, ptr %chrSrcW, align 4, !dbg !1523, !tbaa !1447
  %conv1270 = sext i32 %42 to i64, !dbg !1524
  %shl1271 = mul nsw i64 %conv1270, 65536, !dbg !1525
  %43 = load i32, ptr %chrDstW, align 4, !dbg !1526, !tbaa !1459
  %shr1273 = ashr i32 %43, 1, !dbg !1527
  %conv1274 = sext i32 %shr1273 to i64, !dbg !1528
  %add1275 = add nsw i64 %conv1274, %shl1271, !dbg !1529
  %conv1277 = sext i32 %43 to i64, !dbg !1530
  %div1278 = sdiv i64 %add1275, %conv1277, !dbg !1531
  %conv1279 = trunc i64 %div1278 to i32, !dbg !1532
  %chrXInc = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 10, !dbg !1533
  store i32 %conv1279, ptr %chrXInc, align 16, !dbg !1534, !tbaa !1535
  %44 = load i32, ptr %chrSrcH, align 16, !dbg !1536, !tbaa !1453
  %conv1281 = sext i32 %44 to i64, !dbg !1537
  %shl1282 = mul nsw i64 %conv1281, 65536, !dbg !1538
  %45 = load i32, ptr %chrDstH, align 8, !dbg !1539, !tbaa !1466
  %shr1284 = ashr i32 %45, 1, !dbg !1540
  %conv1285 = sext i32 %shr1284 to i64, !dbg !1541
  %add1286 = add nsw i64 %conv1285, %shl1282, !dbg !1542
  %conv1288 = sext i32 %45 to i64, !dbg !1543
  %div1289 = sdiv i64 %add1286, %conv1288, !dbg !1544
  %conv1290 = trunc i64 %div1289 to i32, !dbg !1545
  %chrYInc = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 12, !dbg !1546
  store i32 %conv1290, ptr %chrYInc, align 8, !dbg !1547, !tbaa !1548
  %and1291 = and i32 %flags.7, 1, !dbg !1549
  %tobool1292 = icmp ne i32 %and1291, 0, !dbg !1551
  br i1 %tobool1292, label %if.then1293, label %if.end1303, !dbg !1552

if.then1293:                                      ; preds = %if.end1268
  %46 = load i32, ptr %canMMXEXTBeUsed, align 16, !dbg !1553, !tbaa !1522
  %tobool1295 = icmp ne i32 %46, 0, !dbg !1556
  br i1 %tobool1295, label %if.then1296, label %if.end1303, !dbg !1557

if.then1296:                                      ; preds = %if.then1293
  %47 = load i32, ptr %lumXInc, align 4, !dbg !1558, !tbaa !1133
  %add1298 = add nsw i32 %47, 20, !dbg !1560
  store i32 %add1298, ptr %lumXInc, align 4, !dbg !1561, !tbaa !1133
  %48 = load i32, ptr %chrXInc, align 16, !dbg !1562, !tbaa !1535
  %add1300 = add nsw i32 %48, 20, !dbg !1563
  store i32 %add1300, ptr %chrXInc, align 16, !dbg !1564, !tbaa !1535
  br label %if.end1303, !dbg !1565

if.end1303:                                       ; preds = %if.then1296, %if.then1293, %if.end1268
  %gamma_value = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 31, !dbg !1566
  store double 2.200000e+00, ptr %gamma_value, align 8, !dbg !1567, !tbaa !1568
    #dbg_value(i32 292, !937, !DIExpression(), !967)
  br i1 %7, label %if.end1377, label %land.lhs.true1305, !dbg !1569

land.lhs.true1305:                                ; preds = %if.end1303
  %gamma_flag = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 32, !dbg !1570
  %49 = load i32, ptr %gamma_flag, align 16, !dbg !1570, !tbaa !1571
  %tobool1306 = icmp ne i32 %49, 0, !dbg !1572
  br i1 %tobool1306, label %land.lhs.true1307, label %if.end1377, !dbg !1573

land.lhs.true1307:                                ; preds = %land.lhs.true1305
  %cmp1308 = icmp ne i32 %17, 292, !dbg !1574
  br i1 %cmp1308, label %if.then1313, label %lor.lhs.false1310, !dbg !1575

lor.lhs.false1310:                                ; preds = %land.lhs.true1307
  %cmp1311 = icmp ne i32 %18, 292, !dbg !1576
  br i1 %cmp1311, label %if.then1313, label %if.end1377, !dbg !1577

if.then1313:                                      ; preds = %lor.lhs.false1310, %land.lhs.true1307
  %cascaded_context = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 26, !dbg !1578
  store ptr null, ptr %cascaded_context, align 16, !dbg !1579, !tbaa !1580
  %cascaded_tmp = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 28, !dbg !1582
  %cascaded_tmpStride = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 27, !dbg !1583
  %call1316 = call i32 @av_image_alloc(ptr noundef %cascaded_tmp, ptr noundef %cascaded_tmpStride, i32 noundef %0, i32 noundef %1, i32 noundef 292, i32 noundef 64), !dbg !1584
    #dbg_value(i32 %call1316, !936, !DIExpression(), !967)
  %cmp1317 = icmp slt i32 %call1316, 0, !dbg !1585
  br i1 %cmp1317, label %if.then1319, label %if.end1320, !dbg !1587

if.then1319:                                      ; preds = %if.then1313
  br label %cleanup, !dbg !1588

if.end1320:                                       ; preds = %if.then1313
  %param = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 25, !dbg !1589
  %call1322 = call ptr @sws_getContext_vuln(i32 noundef %0, i32 noundef %1, i32 noundef %17, i32 noundef %0, i32 noundef %1, i32 noundef 292, i32 noundef %flags.7, ptr noundef null, ptr noundef null, ptr noundef %param), !dbg !1590
  store ptr %call1322, ptr %cascaded_context, align 16, !dbg !1591, !tbaa !1580
  %tobool1327 = icmp ne ptr %call1322, null, !dbg !1592
  br i1 %tobool1327, label %if.end1329, label %if.then1328, !dbg !1594

if.then1328:                                      ; preds = %if.end1320
  br label %cleanup, !dbg !1595

if.end1329:                                       ; preds = %if.end1320
  %50 = load ptr, ptr %srcFilter.addr, align 8, !dbg !1597, !tbaa !968
  %51 = load ptr, ptr %dstFilter.addr, align 8, !dbg !1598, !tbaa !968
  %call1332 = call ptr @sws_getContext_vuln(i32 noundef %0, i32 noundef %1, i32 noundef 292, i32 noundef %2, i32 noundef %3, i32 noundef 292, i32 noundef %flags.7, ptr noundef %50, ptr noundef %51, ptr noundef %param), !dbg !1599
  %arrayidx1334 = getelementptr inbounds nuw [3 x ptr], ptr %cascaded_context, i64 0, i64 1, !dbg !1600
  store ptr %call1332, ptr %arrayidx1334, align 8, !dbg !1601, !tbaa !1580
  %tobool1337 = icmp ne ptr %call1332, null, !dbg !1602
  br i1 %tobool1337, label %if.end1339, label %if.then1338, !dbg !1604

if.then1338:                                      ; preds = %if.end1329
  br label %cleanup, !dbg !1605

if.end1339:                                       ; preds = %if.end1329
    #dbg_value(ptr %call1332, !938, !DIExpression(), !1606)
  %is_internal_gamma = getelementptr inbounds nuw %struct.SwsContext, ptr %call1332, i32 0, i32 33, !dbg !1607
  store i32 1, ptr %is_internal_gamma, align 4, !dbg !1608, !tbaa !1609
  %52 = load double, ptr %gamma_value, align 8, !dbg !1610, !tbaa !1568
  %call1343 = call fastcc ptr @alloc_gamma_tbl(double noundef %52), !dbg !1611
  %gamma = getelementptr inbounds nuw %struct.SwsContext, ptr %call1332, i32 0, i32 34, !dbg !1612
  store ptr %call1343, ptr %gamma, align 8, !dbg !1613, !tbaa !1614
  %53 = load double, ptr %gamma_value, align 8, !dbg !1615, !tbaa !1568
  %div1345 = fdiv nsz double 1.000000e+00, %53, !dbg !1616
  %call1346 = call fastcc ptr @alloc_gamma_tbl(double noundef %div1345), !dbg !1617
  %inv_gamma = getelementptr inbounds nuw %struct.SwsContext, ptr %call1332, i32 0, i32 35, !dbg !1618
  store ptr %call1346, ptr %inv_gamma, align 16, !dbg !1619, !tbaa !1620
  %54 = load ptr, ptr %gamma, align 8, !dbg !1621, !tbaa !1614
  %tobool1348 = icmp ne ptr %54, null, !dbg !1623
  br i1 %tobool1348, label %lor.lhs.false1349, label %if.then1352, !dbg !1624

lor.lhs.false1349:                                ; preds = %if.end1339
  %tobool1351 = icmp ne ptr %call1346, null, !dbg !1625
  br i1 %tobool1351, label %if.end1353, label %if.then1352, !dbg !1626

if.then1352:                                      ; preds = %lor.lhs.false1349, %if.end1339
  br label %cleanup, !dbg !1627

if.end1353:                                       ; preds = %lor.lhs.false1349
  %arrayidx1355 = getelementptr inbounds nuw [3 x ptr], ptr %cascaded_context, i64 0, i64 2, !dbg !1628
  store ptr null, ptr %arrayidx1355, align 16, !dbg !1629, !tbaa !1580
  %cmp1356 = icmp ne i32 %18, 292, !dbg !1630
  br i1 %cmp1356, label %if.then1358, label %if.end1376, !dbg !1632

if.then1358:                                      ; preds = %if.end1353
  %cascaded1_tmp = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 30, !dbg !1633
  %cascaded1_tmpStride = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 29, !dbg !1635
  %call1361 = call i32 @av_image_alloc(ptr noundef %cascaded1_tmp, ptr noundef %cascaded1_tmpStride, i32 noundef %2, i32 noundef %3, i32 noundef 292, i32 noundef 64), !dbg !1636
    #dbg_value(i32 %call1361, !936, !DIExpression(), !967)
  %cmp1362 = icmp slt i32 %call1361, 0, !dbg !1637
  br i1 %cmp1362, label %if.then1364, label %if.end1365, !dbg !1639

if.then1364:                                      ; preds = %if.then1358
  br label %cleanup, !dbg !1640

if.end1365:                                       ; preds = %if.then1358
  %call1368 = call ptr @sws_getContext_vuln(i32 noundef %2, i32 noundef %3, i32 noundef 292, i32 noundef %2, i32 noundef %3, i32 noundef %18, i32 noundef %flags.7, ptr noundef null, ptr noundef null, ptr noundef %param), !dbg !1641
  store ptr %call1368, ptr %arrayidx1355, align 16, !dbg !1642, !tbaa !1580
  %tobool1373 = icmp ne ptr %call1368, null, !dbg !1643
  br i1 %tobool1373, label %if.end1376, label %if.then1374, !dbg !1645

if.then1374:                                      ; preds = %if.end1365
  br label %cleanup, !dbg !1646

if.end1376:                                       ; preds = %if.end1365, %if.end1353
  br label %cleanup, !dbg !1647

cleanup:                                          ; preds = %if.end1376, %if.then1374, %if.then1364, %if.then1352, %if.then1338, %if.then1328, %if.then1319
  %retval.0 = phi i32 [ %call1316, %if.then1319 ], [ %call1361, %if.then1364 ], [ 0, %if.end1376 ], [ -1, %if.then1374 ], [ -12, %if.then1352 ], [ -1, %if.then1338 ], [ -1, %if.then1328 ], !dbg !1606
  br label %cleanup2202

if.end1377:                                       ; preds = %lor.lhs.false1310, %land.lhs.true1305, %if.end1303
  br i1 %or.cond175, label %if.then1413, label %if.end1453, !dbg !1648

if.then1413:                                      ; preds = %if.end1377
  br i1 %7, label %lor.lhs.false1415, label %if.then1421, !dbg !1649

lor.lhs.false1415:                                ; preds = %if.then1413
  %cmp1416 = icmp ne i32 %18, 2, !dbg !1650
  %cmp1419 = icmp ne i32 %18, 0
  %or.cond287 = select i1 %cmp1416, i1 %cmp1419, i1 false, !dbg !1651
  br i1 %or.cond287, label %if.then1421, label %if.end1453, !dbg !1651

if.then1421:                                      ; preds = %lor.lhs.false1415, %if.then1413
    #dbg_value(i32 2, !941, !DIExpression(), !1652)
  %cascaded_tmp1422 = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 28, !dbg !1653
  %cascaded_tmpStride1424 = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 27, !dbg !1654
  %call1426 = call i32 @av_image_alloc(ptr noundef %cascaded_tmp1422, ptr noundef %cascaded_tmpStride1424, i32 noundef %0, i32 noundef %1, i32 noundef 2, i32 noundef 64), !dbg !1655
    #dbg_value(i32 %call1426, !936, !DIExpression(), !967)
  %cmp1427 = icmp slt i32 %call1426, 0, !dbg !1656
  br i1 %cmp1427, label %if.then1429, label %if.end1430, !dbg !1658

if.then1429:                                      ; preds = %if.then1421
  br label %cleanup1451, !dbg !1659

if.end1430:                                       ; preds = %if.then1421
  %55 = load ptr, ptr %srcFilter.addr, align 8, !dbg !1660, !tbaa !968
  %param1431 = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 25, !dbg !1661
  %call1433 = call ptr @sws_getContext_vuln(i32 noundef %0, i32 noundef %1, i32 noundef %17, i32 noundef %0, i32 noundef %1, i32 noundef 2, i32 noundef %flags.7, ptr noundef %55, ptr noundef null, ptr noundef %param1431), !dbg !1662
  %cascaded_context1434 = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 26, !dbg !1663
  store ptr %call1433, ptr %cascaded_context1434, align 16, !dbg !1664, !tbaa !1580
  %tobool1438 = icmp ne ptr %call1433, null, !dbg !1665
  br i1 %tobool1438, label %if.end1440, label %if.then1439, !dbg !1667

if.then1439:                                      ; preds = %if.end1430
  br label %cleanup1451, !dbg !1668

if.end1440:                                       ; preds = %if.end1430
  %56 = load ptr, ptr %dstFilter.addr, align 8, !dbg !1669, !tbaa !968
  %call1443 = call ptr @sws_getContext_vuln(i32 noundef %0, i32 noundef %1, i32 noundef 2, i32 noundef %2, i32 noundef %3, i32 noundef %18, i32 noundef %flags.7, ptr noundef null, ptr noundef %56, ptr noundef %param1431), !dbg !1670
  %arrayidx1445 = getelementptr inbounds nuw [3 x ptr], ptr %cascaded_context1434, i64 0, i64 1, !dbg !1671
  store ptr %call1443, ptr %arrayidx1445, align 8, !dbg !1672, !tbaa !1580
  %tobool1448 = icmp ne ptr %call1443, null, !dbg !1673
  br i1 %tobool1448, label %if.end1450, label %if.then1449, !dbg !1675

if.then1449:                                      ; preds = %if.end1440
  br label %cleanup1451, !dbg !1676

if.end1450:                                       ; preds = %if.end1440
  br label %cleanup1451, !dbg !1677

cleanup1451:                                      ; preds = %if.end1450, %if.then1449, %if.then1439, %if.then1429
  %retval.1 = phi i32 [ %call1426, %if.then1429 ], [ 0, %if.end1450 ], [ -1, %if.then1449 ], [ -1, %if.then1439 ], !dbg !1652
  br label %cleanup2202

if.end1453:                                       ; preds = %lor.lhs.false1415, %if.end1377
    #dbg_value(i32 1, !946, !DIExpression(), !1678)
  %hLumFilter = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 49, !dbg !1679
  %hLumFilterPos = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 53, !dbg !1681
  %hLumFilterSize = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 57, !dbg !1682
  %57 = load i32, ptr %lumXInc, align 4, !dbg !1683, !tbaa !1133
  %and1455 = and i32 %flags.7, 64, !dbg !1684
  %tobool1456 = icmp ne i32 %and1455, 0, !dbg !1685
  %or1458 = or i32 %flags.7, 4, !dbg !1686
  %cond1461 = select i1 %tobool1456, i32 %or1458, i32 %flags.7, !dbg !1686
  %58 = load ptr, ptr %srcFilter.addr, align 8, !dbg !1687, !tbaa !968
  %59 = load ptr, ptr %58, align 8, !dbg !1688, !tbaa !1171
  %60 = load ptr, ptr %dstFilter.addr, align 8, !dbg !1689, !tbaa !968
  %61 = load ptr, ptr %60, align 8, !dbg !1690, !tbaa !1171
  %param1464 = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 25, !dbg !1691
  %call1466 = call fastcc i32 @get_local_pos(ptr noundef %c, i32 noundef 0, i32 noundef 0, i32 noundef 0), !dbg !1692
  %call1467 = call fastcc i32 @get_local_pos(ptr noundef %c, i32 noundef 0, i32 noundef 0, i32 noundef 0), !dbg !1693
  %call1468 = call fastcc i32 @initFilter(ptr noundef %hLumFilter, ptr noundef %hLumFilterPos, ptr noundef %hLumFilterSize, i32 noundef %57, i32 noundef %0, i32 noundef %2, i32 noundef 1, i32 noundef 16384, i32 noundef %cond1461, i32 noundef %call, ptr noundef %59, ptr noundef %61, ptr noundef %param1464, i32 noundef %call1466, i32 noundef %call1467), !dbg !1694
    #dbg_value(i32 %call1468, !936, !DIExpression(), !967)
  %cmp1469 = icmp slt i32 %call1468, 0, !dbg !1695
  br i1 %cmp1469, label %if.then1471, label %if.end1472, !dbg !1696

if.then1471:                                      ; preds = %if.end1453
  br label %cleanup1496, !dbg !1697

if.end1472:                                       ; preds = %if.end1453
  %hChrFilter = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 50, !dbg !1698
  %hChrFilterPos = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 54, !dbg !1700
  %hChrFilterSize = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 58, !dbg !1701
  %62 = load i32, ptr %chrXInc, align 16, !dbg !1702, !tbaa !1535
  %63 = load i32, ptr %chrSrcW, align 4, !dbg !1703, !tbaa !1447
  %64 = load i32, ptr %chrDstW, align 4, !dbg !1704, !tbaa !1459
  %or1479 = or i32 %flags.7, 2, !dbg !1705
  %cond1482 = select i1 %tobool1456, i32 %or1479, i32 %flags.7, !dbg !1705
  %65 = load ptr, ptr %srcFilter.addr, align 8, !dbg !1706, !tbaa !968
  %chrH1483 = getelementptr inbounds nuw %struct.SwsFilter, ptr %65, i32 0, i32 2, !dbg !1707
  %66 = load ptr, ptr %chrH1483, align 8, !dbg !1707, !tbaa !1708
  %67 = load ptr, ptr %dstFilter.addr, align 8, !dbg !1709, !tbaa !968
  %chrH1484 = getelementptr inbounds nuw %struct.SwsFilter, ptr %67, i32 0, i32 2, !dbg !1710
  %68 = load ptr, ptr %chrH1484, align 8, !dbg !1710, !tbaa !1708
  %69 = load i32, ptr %chrSrcHSubSample, align 4, !dbg !1711, !tbaa !1250
  %src_h_chr_pos = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 87, !dbg !1712
  %70 = load i32, ptr %src_h_chr_pos, align 4, !dbg !1712, !tbaa !1713
  %call1488 = call fastcc i32 @get_local_pos(ptr noundef %c, i32 noundef %69, i32 noundef %70, i32 noundef 0), !dbg !1714
  %71 = load i32, ptr %chrDstHSubSample, align 4, !dbg !1715, !tbaa !1368
  %dst_h_chr_pos = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 88, !dbg !1716
  %72 = load i32, ptr %dst_h_chr_pos, align 8, !dbg !1716, !tbaa !1717
  %call1490 = call fastcc i32 @get_local_pos(ptr noundef %c, i32 noundef %71, i32 noundef %72, i32 noundef 0), !dbg !1718
  %call1491 = call fastcc i32 @initFilter(ptr noundef %hChrFilter, ptr noundef %hChrFilterPos, ptr noundef %hChrFilterSize, i32 noundef %62, i32 noundef %63, i32 noundef %64, i32 noundef 1, i32 noundef 16384, i32 noundef %cond1482, i32 noundef %call, ptr noundef %66, ptr noundef %68, ptr noundef %param1464, i32 noundef %call1488, i32 noundef %call1490), !dbg !1719
    #dbg_value(i32 %call1491, !936, !DIExpression(), !967)
  %cmp1492 = icmp slt i32 %call1491, 0, !dbg !1720
  br i1 %cmp1492, label %if.then1494, label %if.end1495, !dbg !1721

if.then1494:                                      ; preds = %if.end1472
  br label %cleanup1496, !dbg !1722

if.end1495:                                       ; preds = %if.end1472
  br label %cleanup1496, !dbg !1723

cleanup1496:                                      ; preds = %if.end1495, %if.then1494, %if.then1471
  %cleanup.dest.slot.0 = phi i32 [ 4, %if.then1471 ], [ 4, %if.then1494 ], [ 0, %if.end1495 ]
  %ret.0 = phi i32 [ %call1468, %if.then1471 ], [ %call1491, %if.then1494 ], [ %call1491, %if.end1495 ], !dbg !1678
    #dbg_value(i32 %ret.0, !936, !DIExpression(), !967)
  switch i32 %cleanup.dest.slot.0, label %cleanup2202 [
    i32 0, label %cleanup.cont
    i32 4, label %fail
  ]

cleanup.cont:                                     ; preds = %cleanup1496
    #dbg_value(i32 1, !950, !DIExpression(), !1724)
  %vLumFilter = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 51, !dbg !1725
  %vLumFilterPos = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 55, !dbg !1727
  %vLumFilterSize = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 59, !dbg !1728
  %73 = load i32, ptr %lumYInc, align 4, !dbg !1729, !tbaa !1144
  %74 = load ptr, ptr %srcFilter.addr, align 8, !dbg !1730, !tbaa !968
  %lumV1506 = getelementptr inbounds nuw %struct.SwsFilter, ptr %74, i32 0, i32 1, !dbg !1731
  %75 = load ptr, ptr %lumV1506, align 8, !dbg !1731, !tbaa !1157
  %76 = load ptr, ptr %dstFilter.addr, align 8, !dbg !1732, !tbaa !968
  %lumV1507 = getelementptr inbounds nuw %struct.SwsFilter, ptr %76, i32 0, i32 1, !dbg !1733
  %77 = load ptr, ptr %lumV1507, align 8, !dbg !1733, !tbaa !1157
  %call1510 = call fastcc i32 @get_local_pos(ptr noundef %c, i32 noundef 0, i32 noundef 0, i32 noundef 1), !dbg !1734
  %call1511 = call fastcc i32 @get_local_pos(ptr noundef %c, i32 noundef 0, i32 noundef 0, i32 noundef 1), !dbg !1735
  %call1512 = call fastcc i32 @initFilter(ptr noundef %vLumFilter, ptr noundef %vLumFilterPos, ptr noundef %vLumFilterSize, i32 noundef %73, i32 noundef %1, i32 noundef %3, i32 noundef 1, i32 noundef 4096, i32 noundef %cond1461, i32 noundef %call, ptr noundef %75, ptr noundef %77, ptr noundef %param1464, i32 noundef %call1510, i32 noundef %call1511), !dbg !1736
    #dbg_value(i32 %call1512, !936, !DIExpression(), !967)
  %cmp1513 = icmp slt i32 %call1512, 0, !dbg !1737
  br i1 %cmp1513, label %if.then1515, label %if.end1516, !dbg !1738

if.then1515:                                      ; preds = %cleanup.cont
  br label %cleanup1540, !dbg !1739

if.end1516:                                       ; preds = %cleanup.cont
  %vChrFilter = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 52, !dbg !1740
  %vChrFilterPos = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 56, !dbg !1742
  %vChrFilterSize = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 60, !dbg !1743
  %78 = load i32, ptr %chrYInc, align 8, !dbg !1744, !tbaa !1548
  %79 = load i32, ptr %chrSrcH, align 16, !dbg !1745, !tbaa !1453
  %80 = load i32, ptr %chrDstH, align 8, !dbg !1746, !tbaa !1466
  %or1523 = or i32 %flags.7, 2, !dbg !1747
  %cond1526 = select i1 %tobool1456, i32 %or1523, i32 %flags.7, !dbg !1747
  %81 = load ptr, ptr %srcFilter.addr, align 8, !dbg !1748, !tbaa !968
  %chrV1527 = getelementptr inbounds nuw %struct.SwsFilter, ptr %81, i32 0, i32 3, !dbg !1749
  %82 = load ptr, ptr %chrV1527, align 8, !dbg !1749, !tbaa !1750
  %83 = load ptr, ptr %dstFilter.addr, align 8, !dbg !1751, !tbaa !968
  %chrV1528 = getelementptr inbounds nuw %struct.SwsFilter, ptr %83, i32 0, i32 3, !dbg !1752
  %84 = load ptr, ptr %chrV1528, align 8, !dbg !1752, !tbaa !1750
  %85 = load i32, ptr %chrSrcVSubSample, align 8, !dbg !1753, !tbaa !1254
  %src_v_chr_pos = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 89, !dbg !1754
  %86 = load i32, ptr %src_v_chr_pos, align 4, !dbg !1754, !tbaa !1755
  %call1532 = call fastcc i32 @get_local_pos(ptr noundef %c, i32 noundef %85, i32 noundef %86, i32 noundef 1), !dbg !1756
  %87 = load i32, ptr %chrDstVSubSample, align 16, !dbg !1757, !tbaa !1461
  %dst_v_chr_pos = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 90, !dbg !1758
  %88 = load i32, ptr %dst_v_chr_pos, align 16, !dbg !1758, !tbaa !1759
  %call1534 = call fastcc i32 @get_local_pos(ptr noundef %c, i32 noundef %87, i32 noundef %88, i32 noundef 1), !dbg !1760
  %call1535 = call fastcc i32 @initFilter(ptr noundef %vChrFilter, ptr noundef %vChrFilterPos, ptr noundef %vChrFilterSize, i32 noundef %78, i32 noundef %79, i32 noundef %80, i32 noundef 1, i32 noundef 4096, i32 noundef %cond1526, i32 noundef %call, ptr noundef %82, ptr noundef %84, ptr noundef %param1464, i32 noundef %call1532, i32 noundef %call1534), !dbg !1761
    #dbg_value(i32 %call1535, !936, !DIExpression(), !967)
  %cmp1536 = icmp slt i32 %call1535, 0, !dbg !1762
  br i1 %cmp1536, label %if.then1538, label %if.end1539, !dbg !1763

if.then1538:                                      ; preds = %if.end1516
  br label %cleanup1540, !dbg !1764

if.end1539:                                       ; preds = %if.end1516
  br label %cleanup1540, !dbg !1765

cleanup1540:                                      ; preds = %if.end1539, %if.then1538, %if.then1515
  %cleanup.dest.slot.1 = phi i32 [ 4, %if.then1515 ], [ 4, %if.then1538 ], [ 0, %if.end1539 ]
  %ret.1 = phi i32 [ %call1512, %if.then1515 ], [ %call1535, %if.then1538 ], [ %call1535, %if.end1539 ], !dbg !1724
    #dbg_value(i32 %ret.1, !936, !DIExpression(), !967)
  switch i32 %cleanup.dest.slot.1, label %cleanup2202 [
    i32 0, label %cleanup.cont1542
    i32 4, label %fail
  ]

cleanup.cont1542:                                 ; preds = %cleanup1540
  %89 = load i32, ptr %vLumFilterSize, align 16, !dbg !1766, !tbaa !1767
  %vLumBufSize = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 42, !dbg !1768
  store i32 %89, ptr %vLumBufSize, align 8, !dbg !1769, !tbaa !1770
  %vChrFilterSize1544 = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 60, !dbg !1771
  %90 = load i32, ptr %vChrFilterSize1544, align 4, !dbg !1772, !tbaa !1773
  %vChrBufSize = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 43, !dbg !1774
  store i32 %90, ptr %vChrBufSize, align 4, !dbg !1775, !tbaa !1776
    #dbg_value(i32 0, !897, !DIExpression(), !967)
  %vChrFilterPos1559 = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 56
    #dbg_value(i32 0, !897, !DIExpression(), !967)
  br label %for.body.lr.ph, !dbg !1777

for.body.lr.ph:                                   ; preds = %cleanup.cont1542
  %wide.trip.count = zext nneg i32 %3 to i64, !dbg !1778
  br label %for.body, !dbg !1777

for.body:                                         ; preds = %if.end1622, %for.body.lr.ph
  %indvars.iv = phi i64 [ 0, %for.body.lr.ph ], [ %indvars.iv.next, %if.end1622 ]
    #dbg_value(i64 %indvars.iv, !897, !DIExpression(), !967)
  %91 = load i32, ptr %chrDstH, align 8, !dbg !1779, !tbaa !1466
  %conv1549 = sext i32 %91 to i64, !dbg !1780
  %mul1550 = mul nsw i64 %conv1549, %indvars.iv, !dbg !1781
  %div1552 = sdiv i64 %mul1550, %conv117, !dbg !1782
  %conv1553 = trunc i64 %div1552 to i32, !dbg !1783
    #dbg_value(i32 %conv1553, !952, !DIExpression(), !1784)
  %92 = load ptr, ptr %vLumFilterPos, align 8, !dbg !1785, !tbaa !1786
  %arrayidx1555 = getelementptr inbounds i32, ptr %92, i64 %indvars.iv, !dbg !1787
  %93 = load i32, ptr %arrayidx1555, align 4, !dbg !1787, !tbaa !1788
  %94 = load i32, ptr %vLumFilterSize, align 16, !dbg !1789, !tbaa !1767
  %add1557 = add i32 %93, -1, !dbg !1790
  %sub1558 = add i32 %add1557, %94, !dbg !1791
  %95 = load ptr, ptr %vChrFilterPos1559, align 16, !dbg !1792, !tbaa !1793
  %idxprom1560 = sext i32 %conv1553 to i64, !dbg !1794
  %arrayidx1561 = getelementptr inbounds i32, ptr %95, i64 %idxprom1560, !dbg !1794
  %96 = load i32, ptr %arrayidx1561, align 4, !dbg !1794, !tbaa !1788
  %97 = load i32, ptr %vChrFilterSize1544, align 4, !dbg !1795, !tbaa !1773
  %add1563 = add i32 %96, -1, !dbg !1796
  %sub1564 = add i32 %add1563, %97, !dbg !1797
  %98 = load i32, ptr %chrSrcVSubSample, align 8, !dbg !1798, !tbaa !1254
  %shl1566 = shl i32 %sub1564, %98, !dbg !1799
  %cmp1567 = icmp sgt i32 %sub1558, %shl1566, !dbg !1800
  br i1 %cmp1567, label %cond.true1569, label %cond.false1576, !dbg !1801

cond.true1569:                                    ; preds = %for.body
  br label %cond.end1585, !dbg !1802

cond.false1576:                                   ; preds = %for.body
  br label %cond.end1585, !dbg !1802

cond.end1585:                                     ; preds = %cond.false1576, %cond.true1569
  %cond1586 = phi i32 [ %sub1558, %cond.true1569 ], [ %shl1566, %cond.false1576 ], !dbg !1803
    #dbg_value(i32 %cond1586, !956, !DIExpression(), !1784)
  %99 = load i32, ptr %chrSrcVSubSample, align 8, !dbg !1804, !tbaa !1254
  %shr1588 = ashr i32 %cond1586, %99, !dbg !1805
    #dbg_value(i32 %shr1588, !956, !DIExpression(), !1784)
  %shl1590 = shl i32 %shr1588, %99, !dbg !1806
    #dbg_value(i32 %shl1590, !956, !DIExpression(), !1784)
  %100 = load ptr, ptr %vLumFilterPos, align 8, !dbg !1807, !tbaa !1786
  %arrayidx1593 = getelementptr inbounds i32, ptr %100, i64 %indvars.iv, !dbg !1809
  %101 = load i32, ptr %arrayidx1593, align 4, !dbg !1809, !tbaa !1788
  %102 = load i32, ptr %vLumBufSize, align 8, !dbg !1810, !tbaa !1770
  %add1595 = add nsw i32 %102, %101, !dbg !1811
  %cmp1596 = icmp slt i32 %add1595, %shl1590, !dbg !1812
  br i1 %cmp1596, label %if.then1598, label %if.end1604, !dbg !1813

if.then1598:                                      ; preds = %cond.end1585
  %sub1602 = sub nsw i32 %shl1590, %101, !dbg !1814
  store i32 %sub1602, ptr %vLumBufSize, align 8, !dbg !1815, !tbaa !1770
  br label %if.end1604, !dbg !1816

if.end1604:                                       ; preds = %if.then1598, %cond.end1585
  %103 = load ptr, ptr %vChrFilterPos1559, align 16, !dbg !1817, !tbaa !1793
  %arrayidx1607 = getelementptr inbounds i32, ptr %103, i64 %idxprom1560, !dbg !1819
  %104 = load i32, ptr %arrayidx1607, align 4, !dbg !1819, !tbaa !1788
  %105 = load i32, ptr %vChrBufSize, align 4, !dbg !1820, !tbaa !1776
  %add1609 = add nsw i32 %105, %104, !dbg !1821
  %106 = load i32, ptr %chrSrcVSubSample, align 8, !dbg !1822, !tbaa !1254
  %shr1611 = ashr i32 %shl1590, %106, !dbg !1823
  %cmp1612 = icmp slt i32 %add1609, %shr1611, !dbg !1824
  br i1 %cmp1612, label %if.then1614, label %if.end1622, !dbg !1825

if.then1614:                                      ; preds = %if.end1604
  %sub1620 = sub nsw i32 %shr1611, %104, !dbg !1826
  store i32 %sub1620, ptr %vChrBufSize, align 4, !dbg !1827, !tbaa !1776
  br label %if.end1622, !dbg !1828

if.end1622:                                       ; preds = %if.then1614, %if.end1604
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1, !dbg !1829
    #dbg_value(i64 %indvars.iv.next, !897, !DIExpression(), !967)
  %exitcond = icmp ne i64 %indvars.iv.next, %wide.trip.count, !dbg !1778
  br i1 %exitcond, label %for.body, label %for.cond.for.end_crit_edge, !dbg !1830, !llvm.loop !1831

for.cond.for.end_crit_edge:                       ; preds = %if.end1622
  br label %for.end, !dbg !1830

for.end:                                          ; preds = %for.cond.for.end_crit_edge
    #dbg_value(i32 0, !897, !DIExpression(), !967)
  %dither_error = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 75
    #dbg_value(i32 0, !897, !DIExpression(), !967)
  br label %for.body1626, !dbg !1834

for.body1626:                                     ; preds = %for.end
    #dbg_value(i64 0, !897, !DIExpression(), !967)
  %107 = load i32, ptr %dstW3, align 8, !dbg !1836, !tbaa !993
  %add1628 = add nsw i32 %107, 2, !dbg !1839
  %conv1629 = sext i32 %add1628 to i64, !dbg !1840
  %mul1630 = mul nsw i64 %conv1629, 4, !dbg !1841
  %call1631 = call noalias ptr @av_mallocz(i64 noundef %mul1630), !dbg !1842
  store ptr %call1631, ptr %dither_error, align 8, !dbg !1843, !tbaa !1844
  %tobool1637 = icmp ne ptr %call1631, null, !dbg !1845
  br i1 %tobool1637, label %for.inc1647, label %land.lhs.true1638, !dbg !1847

land.lhs.true1638:                                ; preds = %for.body1626
  %108 = load i32, ptr %dstW3, align 8, !dbg !1848, !tbaa !993
  %add1640 = add nsw i32 %108, 2, !dbg !1849
  %conv1641 = sext i32 %add1640 to i64, !dbg !1850
  %mul1642 = mul nsw i64 %conv1641, 4, !dbg !1851
  %cmp1643 = icmp ne i64 %mul1642, 0, !dbg !1852
  br i1 %cmp1643, label %if.then1645, label %for.inc1647, !dbg !1853

if.then1645:                                      ; preds = %land.lhs.true1638.3, %land.lhs.true1638.2, %land.lhs.true1638.1, %land.lhs.true1638
  call void (ptr, i32, ptr, ...) @av_log(ptr noundef %c, i32 noundef 16, ptr noundef @.str.13), !dbg !1854
  br label %fail, !dbg !1856

for.inc1647:                                      ; preds = %land.lhs.true1638, %for.body1626
    #dbg_value(i64 1, !897, !DIExpression(), !967)
  %109 = load i32, ptr %dstW3, align 8, !dbg !1836, !tbaa !993
  %add1628.1 = add nsw i32 %109, 2, !dbg !1839
  %conv1629.1 = sext i32 %add1628.1 to i64, !dbg !1840
  %mul1630.1 = mul nsw i64 %conv1629.1, 4, !dbg !1841
  %call1631.1 = call noalias ptr @av_mallocz(i64 noundef %mul1630.1), !dbg !1857
  %arrayidx1633.1 = getelementptr inbounds nuw [4 x ptr], ptr %dither_error, i64 0, i64 1, !dbg !1858
  store ptr %call1631.1, ptr %arrayidx1633.1, align 8, !dbg !1859, !tbaa !1844
  %tobool1637.1 = icmp ne ptr %call1631.1, null, !dbg !1860
  br i1 %tobool1637.1, label %for.inc1647.1, label %land.lhs.true1638.1, !dbg !1861

land.lhs.true1638.1:                              ; preds = %for.inc1647
  %110 = load i32, ptr %dstW3, align 8, !dbg !1848, !tbaa !993
  %add1640.1 = add nsw i32 %110, 2, !dbg !1849
  %conv1641.1 = sext i32 %add1640.1 to i64, !dbg !1850
  %mul1642.1 = mul nsw i64 %conv1641.1, 4, !dbg !1851
  %cmp1643.1 = icmp ne i64 %mul1642.1, 0, !dbg !1862
  br i1 %cmp1643.1, label %if.then1645, label %for.inc1647.1, !dbg !1863

for.inc1647.1:                                    ; preds = %land.lhs.true1638.1, %for.inc1647
    #dbg_value(i64 2, !897, !DIExpression(), !967)
  %111 = load i32, ptr %dstW3, align 8, !dbg !1836, !tbaa !993
  %add1628.2 = add nsw i32 %111, 2, !dbg !1839
  %conv1629.2 = sext i32 %add1628.2 to i64, !dbg !1840
  %mul1630.2 = mul nsw i64 %conv1629.2, 4, !dbg !1841
  %call1631.2 = call noalias ptr @av_mallocz(i64 noundef %mul1630.2), !dbg !1864
  %arrayidx1633.2 = getelementptr inbounds nuw [4 x ptr], ptr %dither_error, i64 0, i64 2, !dbg !1858
  store ptr %call1631.2, ptr %arrayidx1633.2, align 8, !dbg !1865, !tbaa !1844
  %tobool1637.2 = icmp ne ptr %call1631.2, null, !dbg !1866
  br i1 %tobool1637.2, label %for.inc1647.2, label %land.lhs.true1638.2, !dbg !1867

land.lhs.true1638.2:                              ; preds = %for.inc1647.1
  %112 = load i32, ptr %dstW3, align 8, !dbg !1848, !tbaa !993
  %add1640.2 = add nsw i32 %112, 2, !dbg !1849
  %conv1641.2 = sext i32 %add1640.2 to i64, !dbg !1850
  %mul1642.2 = mul nsw i64 %conv1641.2, 4, !dbg !1851
  %cmp1643.2 = icmp ne i64 %mul1642.2, 0, !dbg !1868
  br i1 %cmp1643.2, label %if.then1645, label %for.inc1647.2, !dbg !1869

for.inc1647.2:                                    ; preds = %land.lhs.true1638.2, %for.inc1647.1
    #dbg_value(i64 3, !897, !DIExpression(), !967)
  %113 = load i32, ptr %dstW3, align 8, !dbg !1836, !tbaa !993
  %add1628.3 = add nsw i32 %113, 2, !dbg !1839
  %conv1629.3 = sext i32 %add1628.3 to i64, !dbg !1840
  %mul1630.3 = mul nsw i64 %conv1629.3, 4, !dbg !1841
  %call1631.3 = call noalias ptr @av_mallocz(i64 noundef %mul1630.3), !dbg !1870
  %arrayidx1633.3 = getelementptr inbounds nuw [4 x ptr], ptr %dither_error, i64 0, i64 3, !dbg !1858
  store ptr %call1631.3, ptr %arrayidx1633.3, align 8, !dbg !1871, !tbaa !1844
  %tobool1637.3 = icmp ne ptr %call1631.3, null, !dbg !1872
  br i1 %tobool1637.3, label %for.inc1647.3, label %land.lhs.true1638.3, !dbg !1873

land.lhs.true1638.3:                              ; preds = %for.inc1647.2
  %114 = load i32, ptr %dstW3, align 8, !dbg !1848, !tbaa !993
  %add1640.3 = add nsw i32 %114, 2, !dbg !1849
  %conv1641.3 = sext i32 %add1640.3 to i64, !dbg !1850
  %mul1642.3 = mul nsw i64 %conv1641.3, 4, !dbg !1851
  %cmp1643.3 = icmp ne i64 %mul1642.3, 0, !dbg !1874
  br i1 %cmp1643.3, label %if.then1645, label %for.inc1647.3, !dbg !1875

for.inc1647.3:                                    ; preds = %land.lhs.true1638.3, %for.inc1647.2
    #dbg_value(i64 4, !897, !DIExpression(), !967)
  %115 = load i32, ptr %vLumBufSize, align 8, !dbg !1876, !tbaa !1770
  %mul1651 = mul nsw i32 %115, 3, !dbg !1878
  %conv1652 = sext i32 %mul1651 to i64, !dbg !1879
  %mul1653 = mul nsw i64 %conv1652, 8, !dbg !1880
  %call1654 = call noalias ptr @av_malloc(i64 noundef %mul1653), !dbg !1881
  %lumPixBuf = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 38, !dbg !1882
  store ptr %call1654, ptr %lumPixBuf, align 8, !dbg !1883, !tbaa !1884
  %tobool1656 = icmp ne ptr %call1654, null, !dbg !1885
  br i1 %tobool1656, label %if.end1665, label %land.lhs.true1657, !dbg !1887

land.lhs.true1657:                                ; preds = %for.inc1647.3
  %116 = load i32, ptr %vLumBufSize, align 8, !dbg !1888, !tbaa !1770
  %mul1659 = mul nsw i32 %116, 3, !dbg !1889
  %conv1660 = sext i32 %mul1659 to i64, !dbg !1890
  %mul1661 = mul nsw i64 %conv1660, 8, !dbg !1891
  %cmp1662 = icmp ne i64 %mul1661, 0, !dbg !1892
  br i1 %cmp1662, label %if.then1664, label %if.end1665, !dbg !1893

if.then1664:                                      ; preds = %land.lhs.true1657
  call void (ptr, i32, ptr, ...) @av_log(ptr noundef %c, i32 noundef 16, ptr noundef @.str.13), !dbg !1894
  br label %fail, !dbg !1896

if.end1665:                                       ; preds = %land.lhs.true1657, %for.inc1647.3
  %117 = load i32, ptr %vChrBufSize, align 4, !dbg !1897, !tbaa !1776
  %mul1667 = mul nsw i32 %117, 3, !dbg !1899
  %conv1668 = sext i32 %mul1667 to i64, !dbg !1900
  %mul1669 = mul nsw i64 %conv1668, 8, !dbg !1901
  %call1670 = call noalias ptr @av_malloc(i64 noundef %mul1669), !dbg !1902
  %chrUPixBuf = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 39, !dbg !1903
  store ptr %call1670, ptr %chrUPixBuf, align 16, !dbg !1904, !tbaa !1905
  %tobool1672 = icmp ne ptr %call1670, null, !dbg !1906
  br i1 %tobool1672, label %if.end1681, label %land.lhs.true1673, !dbg !1908

land.lhs.true1673:                                ; preds = %if.end1665
  %118 = load i32, ptr %vChrBufSize, align 4, !dbg !1909, !tbaa !1776
  %mul1675 = mul nsw i32 %118, 3, !dbg !1910
  %conv1676 = sext i32 %mul1675 to i64, !dbg !1911
  %mul1677 = mul nsw i64 %conv1676, 8, !dbg !1912
  %cmp1678 = icmp ne i64 %mul1677, 0, !dbg !1913
  br i1 %cmp1678, label %if.then1680, label %if.end1681, !dbg !1914

if.then1680:                                      ; preds = %land.lhs.true1673
  call void (ptr, i32, ptr, ...) @av_log(ptr noundef %c, i32 noundef 16, ptr noundef @.str.13), !dbg !1915
  br label %fail, !dbg !1917

if.end1681:                                       ; preds = %land.lhs.true1673, %if.end1665
  %119 = load i32, ptr %vChrBufSize, align 4, !dbg !1918, !tbaa !1776
  %mul1683 = mul nsw i32 %119, 3, !dbg !1920
  %conv1684 = sext i32 %mul1683 to i64, !dbg !1921
  %mul1685 = mul nsw i64 %conv1684, 8, !dbg !1922
  %call1686 = call noalias ptr @av_malloc(i64 noundef %mul1685), !dbg !1923
  %chrVPixBuf = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 40, !dbg !1924
  store ptr %call1686, ptr %chrVPixBuf, align 8, !dbg !1925, !tbaa !1926
  %tobool1688 = icmp ne ptr %call1686, null, !dbg !1927
  br i1 %tobool1688, label %if.end1697, label %land.lhs.true1689, !dbg !1929

land.lhs.true1689:                                ; preds = %if.end1681
  %120 = load i32, ptr %vChrBufSize, align 4, !dbg !1930, !tbaa !1776
  %mul1691 = mul nsw i32 %120, 3, !dbg !1931
  %conv1692 = sext i32 %mul1691 to i64, !dbg !1932
  %mul1693 = mul nsw i64 %conv1692, 8, !dbg !1933
  %cmp1694 = icmp ne i64 %mul1693, 0, !dbg !1934
  br i1 %cmp1694, label %if.then1696, label %if.end1697, !dbg !1935

if.then1696:                                      ; preds = %land.lhs.true1689
  call void (ptr, i32, ptr, ...) @av_log(ptr noundef %c, i32 noundef 16, ptr noundef @.str.13), !dbg !1936
  br label %fail, !dbg !1938

if.end1697:                                       ; preds = %land.lhs.true1689, %if.end1681
  %121 = load i32, ptr %srcFormat7, align 16, !dbg !1939, !tbaa !1004
  %call1699 = call fastcc i32 @isALPHA(i32 noundef %121), !dbg !1941
  %tobool1700 = icmp ne i32 %call1699, 0, !dbg !1942
  br i1 %tobool1700, label %land.lhs.true1701, label %if.end1722, !dbg !1943

land.lhs.true1701:                                ; preds = %if.end1697
  %122 = load i32, ptr %dstFormat8, align 4, !dbg !1944, !tbaa !1007
  %call1703 = call fastcc i32 @isALPHA(i32 noundef %122), !dbg !1945
  %tobool1704 = icmp ne i32 %call1703, 0, !dbg !1946
  br i1 %tobool1704, label %if.then1705, label %if.end1722, !dbg !1947

if.then1705:                                      ; preds = %land.lhs.true1701
  %123 = load i32, ptr %vLumBufSize, align 8, !dbg !1948, !tbaa !1770
  %mul1707 = mul nsw i32 %123, 3, !dbg !1950
  %conv1708 = sext i32 %mul1707 to i64, !dbg !1951
  %mul1709 = mul nsw i64 %conv1708, 8, !dbg !1952
  %call1710 = call noalias ptr @av_mallocz(i64 noundef %mul1709), !dbg !1953
  %alpPixBuf = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 41, !dbg !1954
  store ptr %call1710, ptr %alpPixBuf, align 16, !dbg !1955, !tbaa !1956
  %tobool1712 = icmp ne ptr %call1710, null, !dbg !1957
  br i1 %tobool1712, label %if.end1722, label %land.lhs.true1713, !dbg !1959

land.lhs.true1713:                                ; preds = %if.then1705
  %124 = load i32, ptr %vLumBufSize, align 8, !dbg !1960, !tbaa !1770
  %mul1715 = mul nsw i32 %124, 3, !dbg !1961
  %conv1716 = sext i32 %mul1715 to i64, !dbg !1962
  %mul1717 = mul nsw i64 %conv1716, 8, !dbg !1963
  %cmp1718 = icmp ne i64 %mul1717, 0, !dbg !1964
  br i1 %cmp1718, label %if.then1720, label %if.end1722, !dbg !1965

if.then1720:                                      ; preds = %land.lhs.true1713
  call void (ptr, i32, ptr, ...) @av_log(ptr noundef %c, i32 noundef 16, ptr noundef @.str.13), !dbg !1966
  br label %fail, !dbg !1968

if.end1722:                                       ; preds = %land.lhs.true1713, %if.then1705, %land.lhs.true1701, %if.end1697
    #dbg_value(i32 0, !897, !DIExpression(), !967)
  %add1728 = add nsw i32 %dst_stride.0, 16
  %conv1729 = sext i32 %add1728 to i64
  %cmp1744 = icmp ne i32 %add1728, 0
    #dbg_value(i32 0, !897, !DIExpression(), !967)
  %125 = load i32, ptr %vLumBufSize, align 8, !dbg !1969, !tbaa !1770
  %cmp17251283 = icmp slt i32 0, %125, !dbg !1972
  br i1 %cmp17251283, label %for.body1727.lr.ph, label %for.end1758, !dbg !1973

for.body1727.lr.ph:                               ; preds = %if.end1722
  br label %for.body1727, !dbg !1973

for.body1727:                                     ; preds = %if.end1747, %for.body1727.lr.ph
  %indvars.iv1285 = phi i64 [ 0, %for.body1727.lr.ph ], [ %indvars.iv.next1286, %if.end1747 ]
    #dbg_value(i64 %indvars.iv1285, !897, !DIExpression(), !967)
  %call1730 = call noalias ptr @av_mallocz(i64 noundef %conv1729), !dbg !1974
  %126 = load ptr, ptr %lumPixBuf, align 8, !dbg !1977, !tbaa !1884
  %127 = load i32, ptr %vLumBufSize, align 8, !dbg !1978, !tbaa !1770
  %128 = sext i32 %127 to i64, !dbg !1979
  %129 = add nsw i64 %128, %indvars.iv1285, !dbg !1979
  %arrayidx1735 = getelementptr inbounds ptr, ptr %126, i64 %129, !dbg !1980
  store ptr %call1730, ptr %arrayidx1735, align 8, !dbg !1981, !tbaa !1982
  %130 = load ptr, ptr %lumPixBuf, align 8, !dbg !1983, !tbaa !1884
  %131 = load i32, ptr %vLumBufSize, align 8, !dbg !1985, !tbaa !1770
  %132 = sext i32 %131 to i64, !dbg !1986
  %133 = add nsw i64 %132, %indvars.iv1285, !dbg !1986
  %arrayidx1740 = getelementptr inbounds ptr, ptr %130, i64 %133, !dbg !1987
  %134 = load ptr, ptr %arrayidx1740, align 8, !dbg !1987, !tbaa !1982
  %tobool1741 = icmp ne ptr %134, null, !dbg !1988
  br i1 %tobool1741, label %if.end1747, label %land.lhs.true1742, !dbg !1989

land.lhs.true1742:                                ; preds = %for.body1727
  br i1 %cmp1744, label %if.then1746, label %if.end1747, !dbg !1990

if.then1746:                                      ; preds = %land.lhs.true1742
  call void (ptr, i32, ptr, ...) @av_log(ptr noundef %c, i32 noundef 16, ptr noundef @.str.13), !dbg !1991
  br label %fail, !dbg !1993

if.end1747:                                       ; preds = %land.lhs.true1742, %for.body1727
  %135 = load ptr, ptr %lumPixBuf, align 8, !dbg !1994, !tbaa !1884
  %136 = load i32, ptr %vLumBufSize, align 8, !dbg !1995, !tbaa !1770
  %137 = sext i32 %136 to i64, !dbg !1996
  %138 = add nsw i64 %137, %indvars.iv1285, !dbg !1996
  %arrayidx1752 = getelementptr inbounds ptr, ptr %135, i64 %138, !dbg !1997
  %139 = load ptr, ptr %arrayidx1752, align 8, !dbg !1998, !tbaa !1982
  %arrayidx1755 = getelementptr inbounds ptr, ptr %135, i64 %indvars.iv1285, !dbg !1999
  store ptr %139, ptr %arrayidx1755, align 8, !dbg !2000, !tbaa !1982
  %indvars.iv.next1286 = add nuw nsw i64 %indvars.iv1285, 1, !dbg !2001
    #dbg_value(i64 %indvars.iv.next1286, !897, !DIExpression(), !967)
  %140 = load i32, ptr %vLumBufSize, align 8, !dbg !1969, !tbaa !1770
  %141 = sext i32 %140 to i64, !dbg !2002
  %cmp1725 = icmp slt i64 %indvars.iv.next1286, %141, !dbg !2002
  br i1 %cmp1725, label %for.body1727, label %for.cond1723.for.end1758_crit_edge, !dbg !2003, !llvm.loop !2004

for.cond1723.for.end1758_crit_edge:               ; preds = %if.end1747
  br label %for.end1758, !dbg !2003

for.end1758:                                      ; preds = %for.cond1723.for.end1758_crit_edge, %if.end1722
  %shr1759 = ashr i32 %dst_stride.0, 1, !dbg !2007
  %142 = load i32, ptr %dstBpc, align 4, !dbg !2008, !tbaa !1500
  %and1761 = and i32 %142, -8, !dbg !2009
  %div1762 = sdiv i32 64, %and1761, !dbg !2010
  %add1763 = add nsw i32 %div1762, %shr1759, !dbg !2011
  %conv1764 = sext i32 %add1763 to i64, !dbg !2012
  %uv_off = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 117, !dbg !2013
  store i64 %conv1764, ptr %uv_off, align 8, !dbg !2014, !tbaa !2015
  %add1765 = add nsw i32 %dst_stride.0, 16, !dbg !2016
  %conv1766 = sext i32 %add1765 to i64, !dbg !2017
  %uv_offx2 = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 118, !dbg !2018
  store i64 %conv1766, ptr %uv_offx2, align 16, !dbg !2019, !tbaa !2020
    #dbg_value(i32 0, !897, !DIExpression(), !967)
  %mul1772 = mul nsw i32 %dst_stride.0, 2
  %add1773 = add nsw i32 %mul1772, 32
  %conv1774 = sext i32 %add1773 to i64
  %cmp1790 = icmp ne i32 %add1773, 0
  %idx.ext = sext i32 %shr1759 to i64
    #dbg_value(i32 0, !897, !DIExpression(), !967)
  %143 = load i32, ptr %vChrBufSize, align 4, !dbg !2021, !tbaa !1776
  %cmp17691291 = icmp slt i32 0, %143, !dbg !2024
  br i1 %cmp17691291, label %for.body1771.lr.ph, label %for.end1817, !dbg !2025

for.body1771.lr.ph:                               ; preds = %for.end1758
  br label %for.body1771, !dbg !2025

for.body1771:                                     ; preds = %if.end1793, %for.body1771.lr.ph
  %indvars.iv1293 = phi i64 [ 0, %for.body1771.lr.ph ], [ %indvars.iv.next1294, %if.end1793 ]
    #dbg_value(i64 %indvars.iv1293, !897, !DIExpression(), !967)
  %call1775 = call noalias ptr @av_malloc(i64 noundef %conv1774), !dbg !2026
  %144 = load ptr, ptr %chrUPixBuf, align 16, !dbg !2029, !tbaa !1905
  %145 = load i32, ptr %vChrBufSize, align 4, !dbg !2030, !tbaa !1776
  %146 = sext i32 %145 to i64, !dbg !2031
  %147 = add nsw i64 %146, %indvars.iv1293, !dbg !2031
  %arrayidx1780 = getelementptr inbounds ptr, ptr %144, i64 %147, !dbg !2032
  store ptr %call1775, ptr %arrayidx1780, align 8, !dbg !2033, !tbaa !1982
  %148 = load ptr, ptr %chrUPixBuf, align 16, !dbg !2034, !tbaa !1905
  %149 = load i32, ptr %vChrBufSize, align 4, !dbg !2036, !tbaa !1776
  %150 = sext i32 %149 to i64, !dbg !2037
  %151 = add nsw i64 %150, %indvars.iv1293, !dbg !2037
  %arrayidx1785 = getelementptr inbounds ptr, ptr %148, i64 %151, !dbg !2038
  %152 = load ptr, ptr %arrayidx1785, align 8, !dbg !2038, !tbaa !1982
  %tobool1786 = icmp ne ptr %152, null, !dbg !2039
  br i1 %tobool1786, label %if.end1793, label %land.lhs.true1787, !dbg !2040

land.lhs.true1787:                                ; preds = %for.body1771
  br i1 %cmp1790, label %if.then1792, label %if.end1793, !dbg !2041

if.then1792:                                      ; preds = %land.lhs.true1787
  call void (ptr, i32, ptr, ...) @av_log(ptr noundef %c, i32 noundef 16, ptr noundef @.str.13), !dbg !2042
  br label %fail, !dbg !2044

if.end1793:                                       ; preds = %land.lhs.true1787, %for.body1771
  %153 = load ptr, ptr %chrUPixBuf, align 16, !dbg !2045, !tbaa !1905
  %154 = load i32, ptr %vChrBufSize, align 4, !dbg !2046, !tbaa !1776
  %155 = sext i32 %154 to i64, !dbg !2047
  %156 = add nsw i64 %155, %indvars.iv1293, !dbg !2047
  %arrayidx1798 = getelementptr inbounds ptr, ptr %153, i64 %156, !dbg !2048
  %157 = load ptr, ptr %arrayidx1798, align 8, !dbg !2049, !tbaa !1982
  %arrayidx1801 = getelementptr inbounds ptr, ptr %153, i64 %indvars.iv1293, !dbg !2050
  store ptr %157, ptr %arrayidx1801, align 8, !dbg !2051, !tbaa !1982
  %158 = load ptr, ptr %chrUPixBuf, align 16, !dbg !2052, !tbaa !1905
  %arrayidx1804 = getelementptr inbounds ptr, ptr %158, i64 %indvars.iv1293, !dbg !2053
  %159 = load ptr, ptr %arrayidx1804, align 8, !dbg !2053, !tbaa !1982
  %add.ptr = getelementptr inbounds i16, ptr %159, i64 %idx.ext, !dbg !2054
  %add.ptr1806 = getelementptr inbounds nuw i16, ptr %add.ptr, i64 8, !dbg !2055
  %160 = load ptr, ptr %chrVPixBuf, align 8, !dbg !2056, !tbaa !1926
  %161 = load i32, ptr %vChrBufSize, align 4, !dbg !2057, !tbaa !1776
  %162 = sext i32 %161 to i64, !dbg !2058
  %163 = add nsw i64 %162, %indvars.iv1293, !dbg !2058
  %arrayidx1811 = getelementptr inbounds ptr, ptr %160, i64 %163, !dbg !2059
  store ptr %add.ptr1806, ptr %arrayidx1811, align 8, !dbg !2060, !tbaa !1982
  %164 = load ptr, ptr %chrVPixBuf, align 8, !dbg !2061, !tbaa !1926
  %arrayidx1814 = getelementptr inbounds ptr, ptr %164, i64 %indvars.iv1293, !dbg !2062
  store ptr %add.ptr1806, ptr %arrayidx1814, align 8, !dbg !2063, !tbaa !1982
  %indvars.iv.next1294 = add nuw nsw i64 %indvars.iv1293, 1, !dbg !2064
    #dbg_value(i64 %indvars.iv.next1294, !897, !DIExpression(), !967)
  %165 = load i32, ptr %vChrBufSize, align 4, !dbg !2021, !tbaa !1776
  %166 = sext i32 %165 to i64, !dbg !2065
  %cmp1769 = icmp slt i64 %indvars.iv.next1294, %166, !dbg !2065
  br i1 %cmp1769, label %for.body1771, label %for.cond1767.for.end1817_crit_edge, !dbg !2066, !llvm.loop !2067

for.cond1767.for.end1817_crit_edge:               ; preds = %if.end1793
  br label %for.end1817, !dbg !2066

for.end1817:                                      ; preds = %for.cond1767.for.end1817_crit_edge, %for.end1758
  %alpPixBuf1818 = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 41, !dbg !2070
  %167 = load ptr, ptr %alpPixBuf1818, align 16, !dbg !2070, !tbaa !1956
  %tobool1819 = icmp ne ptr %167, null, !dbg !2072
  br i1 %tobool1819, label %if.then1820, label %if.end1857, !dbg !2073

if.then1820:                                      ; preds = %for.end1817
    #dbg_value(i32 0, !897, !DIExpression(), !967)
  %cmp1842 = icmp ne i32 %add1765, 0
    #dbg_value(i32 0, !897, !DIExpression(), !967)
  %168 = load i32, ptr %vLumBufSize, align 8, !dbg !2074, !tbaa !1770
  %cmp18231300 = icmp slt i32 0, %168, !dbg !2077
  br i1 %cmp18231300, label %for.body1825.lr.ph, label %if.end1857.loopexit, !dbg !2078

for.body1825.lr.ph:                               ; preds = %if.then1820
  br label %for.body1825, !dbg !2078

for.body1825:                                     ; preds = %if.end1845, %for.body1825.lr.ph
  %indvars.iv1302 = phi i64 [ 0, %for.body1825.lr.ph ], [ %indvars.iv.next1303, %if.end1845 ]
    #dbg_value(i64 %indvars.iv1302, !897, !DIExpression(), !967)
  %call1828 = call noalias ptr @av_mallocz(i64 noundef %conv1766), !dbg !2079
  %169 = load ptr, ptr %alpPixBuf1818, align 16, !dbg !2082, !tbaa !1956
  %170 = load i32, ptr %vLumBufSize, align 8, !dbg !2083, !tbaa !1770
  %171 = sext i32 %170 to i64, !dbg !2084
  %172 = add nsw i64 %171, %indvars.iv1302, !dbg !2084
  %arrayidx1833 = getelementptr inbounds ptr, ptr %169, i64 %172, !dbg !2085
  store ptr %call1828, ptr %arrayidx1833, align 8, !dbg !2086, !tbaa !1982
  %173 = load ptr, ptr %alpPixBuf1818, align 16, !dbg !2087, !tbaa !1956
  %174 = load i32, ptr %vLumBufSize, align 8, !dbg !2089, !tbaa !1770
  %175 = sext i32 %174 to i64, !dbg !2090
  %176 = add nsw i64 %175, %indvars.iv1302, !dbg !2090
  %arrayidx1838 = getelementptr inbounds ptr, ptr %173, i64 %176, !dbg !2091
  %177 = load ptr, ptr %arrayidx1838, align 8, !dbg !2091, !tbaa !1982
  %tobool1839 = icmp ne ptr %177, null, !dbg !2092
  br i1 %tobool1839, label %if.end1845, label %land.lhs.true1840, !dbg !2093

land.lhs.true1840:                                ; preds = %for.body1825
  br i1 %cmp1842, label %if.then1844, label %if.end1845, !dbg !2094

if.then1844:                                      ; preds = %land.lhs.true1840
  call void (ptr, i32, ptr, ...) @av_log(ptr noundef %c, i32 noundef 16, ptr noundef @.str.13), !dbg !2095
  br label %fail, !dbg !2097

if.end1845:                                       ; preds = %land.lhs.true1840, %for.body1825
  %178 = load ptr, ptr %alpPixBuf1818, align 16, !dbg !2098, !tbaa !1956
  %179 = load i32, ptr %vLumBufSize, align 8, !dbg !2099, !tbaa !1770
  %180 = sext i32 %179 to i64, !dbg !2100
  %181 = add nsw i64 %180, %indvars.iv1302, !dbg !2100
  %arrayidx1850 = getelementptr inbounds ptr, ptr %178, i64 %181, !dbg !2101
  %182 = load ptr, ptr %arrayidx1850, align 8, !dbg !2102, !tbaa !1982
  %arrayidx1853 = getelementptr inbounds ptr, ptr %178, i64 %indvars.iv1302, !dbg !2103
  store ptr %182, ptr %arrayidx1853, align 8, !dbg !2104, !tbaa !1982
  %indvars.iv.next1303 = add nuw nsw i64 %indvars.iv1302, 1, !dbg !2105
    #dbg_value(i64 %indvars.iv.next1303, !897, !DIExpression(), !967)
  %183 = load i32, ptr %vLumBufSize, align 8, !dbg !2074, !tbaa !1770
  %184 = sext i32 %183 to i64, !dbg !2106
  %cmp1823 = icmp slt i64 %indvars.iv.next1303, %184, !dbg !2106
  br i1 %cmp1823, label %for.body1825, label %for.cond1821.if.end1857.loopexit_crit_edge, !dbg !2107, !llvm.loop !2108

for.cond1821.if.end1857.loopexit_crit_edge:       ; preds = %if.end1845
  br label %if.end1857.loopexit, !dbg !2107

if.end1857.loopexit:                              ; preds = %for.cond1821.if.end1857.loopexit_crit_edge, %if.then1820
  br label %if.end1857, !dbg !2111

if.end1857:                                       ; preds = %if.end1857.loopexit, %for.end1817
    #dbg_value(i32 0, !897, !DIExpression(), !967)
  %185 = add nuw nsw i32 %dst_stride.0, 1, !dbg !2111
  %add1893 = add nsw i32 %dst_stride.0, 1
  %cmp18941308 = icmp slt i32 0, %add1893
  %wide.trip.count1313 = zext i32 %185 to i64
  %div1878 = sdiv i32 %dst_stride.0, 2
  %add1879 = add nsw i32 %div1878, 1
  %cmp18801315 = icmp slt i32 0, %add1879
  %wide.trip.count1320 = zext i32 %add1879 to i64
    #dbg_value(i32 0, !897, !DIExpression(), !967)
  %186 = load i32, ptr %vChrBufSize, align 4, !dbg !2113, !tbaa !1776
  %cmp18601322 = icmp slt i32 0, %186, !dbg !2115
  br i1 %cmp18601322, label %for.body1862.lr.ph, label %do.body1909, !dbg !2116

for.body1862.lr.ph:                               ; preds = %if.end1857
  %187 = zext i32 %dst_stride.0 to i64, !dbg !2116
  %188 = add nsw i64 %wide.trip.count1320, -1, !dbg !2116
  br label %for.body1862, !dbg !2116

for.body1862:                                     ; preds = %for.inc1906, %for.body1862.lr.ph
  %indvars.iv1324 = phi i64 [ 0, %for.body1862.lr.ph ], [ %indvars.iv.next1325, %for.inc1906 ]
    #dbg_value(i64 %indvars.iv1324, !897, !DIExpression(), !967)
  %bf.load1865 = load i16, ptr %comp1098, align 4, !dbg !2117
  %bf.lshr1866 = lshr i16 %bf.load1865, 11, !dbg !2117
  %bf.clear1867 = and i16 %bf.lshr1866, 15, !dbg !2117
  %conv1868 = zext nneg i16 %bf.clear1867 to i32, !dbg !2119
  %cmp1869 = icmp eq i32 %conv1868, 15, !dbg !2120
  br i1 %cmp1869, label %do.body, label %if.else1891, !dbg !2121

do.body:                                          ; preds = %for.body1862
  %189 = load i32, ptr %dstBpc, align 4, !dbg !2122, !tbaa !1500
  %cmp1873 = icmp sgt i32 %189, 14, !dbg !2126
  br i1 %cmp1873, label %do.end, label %if.then1875, !dbg !2127

if.then1875:                                      ; preds = %do.body
  call void (ptr, i32, ptr, ...) @av_log(ptr noundef null, i32 noundef 0, ptr noundef @.str.14, ptr noundef @.str.15, ptr noundef @.str.16, i32 noundef 1532), !dbg !2128
  call void @abort() #15, !dbg !2128
  unreachable, !dbg !2128

do.end:                                           ; preds = %do.body
    #dbg_value(i32 0, !898, !DIExpression(), !967)
    #dbg_value(i32 0, !898, !DIExpression(), !967)
  br i1 %cmp18801315, label %for.body1882.lr.ph, label %for.inc1906.loopexit, !dbg !2130

for.body1882.lr.ph:                               ; preds = %do.end
  %xtraiter1330 = and i64 %wide.trip.count1320, 3, !dbg !2132
  %190 = icmp ult i64 %188, 3, !dbg !2132
  br i1 %190, label %for.body1882.epil.preheader, label %for.body1882.lr.ph.new, !dbg !2132

for.body1882.lr.ph.new:                           ; preds = %for.body1882.lr.ph
  %unroll_iter1334 = sub nsw i64 %wide.trip.count1320, %xtraiter1330, !dbg !2130
  br label %for.body1882, !dbg !2130

for.body1882:                                     ; preds = %for.body1882, %for.body1882.lr.ph.new
  %indvars.iv1317 = phi i64 [ 0, %for.body1882.lr.ph.new ], [ %indvars.iv.next1318.3, %for.body1882 ]
  %niter1335 = phi i64 [ 0, %for.body1882.lr.ph.new ], [ %niter1335.next.3, %for.body1882 ]
    #dbg_value(i64 %indvars.iv1317, !898, !DIExpression(), !967)
  %191 = load ptr, ptr %chrUPixBuf, align 16, !dbg !2133, !tbaa !1905
  %arrayidx1885 = getelementptr inbounds ptr, ptr %191, i64 %indvars.iv1324, !dbg !2135
  %192 = load ptr, ptr %arrayidx1885, align 8, !dbg !2135, !tbaa !1982
  %arrayidx1887 = getelementptr inbounds i32, ptr %192, i64 %indvars.iv1317, !dbg !2136
  store i32 262144, ptr %arrayidx1887, align 4, !dbg !2137, !tbaa !1788
  %indvars.iv.next1318 = add nuw nsw i64 %indvars.iv1317, 1, !dbg !2138
    #dbg_value(i64 %indvars.iv.next1318, !898, !DIExpression(), !967)
  %arrayidx1887.1 = getelementptr inbounds i32, ptr %192, i64 %indvars.iv.next1318, !dbg !2136
  store i32 262144, ptr %arrayidx1887.1, align 4, !dbg !2139, !tbaa !1788
  %indvars.iv.next1318.1 = add nuw nsw i64 %indvars.iv1317, 2, !dbg !2140
    #dbg_value(i64 %indvars.iv.next1318.1, !898, !DIExpression(), !967)
  %arrayidx1887.2 = getelementptr inbounds i32, ptr %192, i64 %indvars.iv.next1318.1, !dbg !2136
  store i32 262144, ptr %arrayidx1887.2, align 4, !dbg !2141, !tbaa !1788
  %indvars.iv.next1318.2 = add nuw nsw i64 %indvars.iv1317, 3, !dbg !2142
    #dbg_value(i64 %indvars.iv.next1318.2, !898, !DIExpression(), !967)
  %arrayidx1887.3 = getelementptr inbounds i32, ptr %192, i64 %indvars.iv.next1318.2, !dbg !2136
  store i32 262144, ptr %arrayidx1887.3, align 4, !dbg !2143, !tbaa !1788
  %indvars.iv.next1318.3 = add nuw nsw i64 %indvars.iv1317, 4, !dbg !2144
    #dbg_value(i64 %indvars.iv.next1318.3, !898, !DIExpression(), !967)
  %niter1335.next.3 = add nuw i64 %niter1335, 4, !dbg !2145
  %niter1335.ncmp.3 = icmp ne i64 %niter1335.next.3, %unroll_iter1334, !dbg !2145
  br i1 %niter1335.ncmp.3, label %for.body1882, label %for.cond1877.for.inc1906.loopexit_crit_edge.unr-lcssa, !dbg !2145, !llvm.loop !2146

if.else1891:                                      ; preds = %for.body1862
    #dbg_value(i32 0, !898, !DIExpression(), !967)
    #dbg_value(i32 0, !898, !DIExpression(), !967)
  br i1 %cmp18941308, label %for.body1896.lr.ph, label %for.inc1906.loopexit1274, !dbg !2148

for.body1896.lr.ph:                               ; preds = %if.else1891
  %xtraiter = and i64 %wide.trip.count1313, 3, !dbg !2150
  %193 = icmp ult i64 %187, 3, !dbg !2150
  br i1 %193, label %for.body1896.epil.preheader, label %for.body1896.lr.ph.new, !dbg !2150

for.body1896.lr.ph.new:                           ; preds = %for.body1896.lr.ph
  %unroll_iter = sub nsw i64 %wide.trip.count1313, %xtraiter, !dbg !2148
  br label %for.body1896, !dbg !2148

for.body1896:                                     ; preds = %for.body1896, %for.body1896.lr.ph.new
  %indvars.iv1310 = phi i64 [ 0, %for.body1896.lr.ph.new ], [ %indvars.iv.next1311.3, %for.body1896 ]
  %niter = phi i64 [ 0, %for.body1896.lr.ph.new ], [ %niter.next.3, %for.body1896 ]
    #dbg_value(i64 %indvars.iv1310, !898, !DIExpression(), !967)
  %194 = load ptr, ptr %chrUPixBuf, align 16, !dbg !2151, !tbaa !1905
  %arrayidx1899 = getelementptr inbounds ptr, ptr %194, i64 %indvars.iv1324, !dbg !2153
  %195 = load ptr, ptr %arrayidx1899, align 8, !dbg !2153, !tbaa !1982
  %arrayidx1901 = getelementptr inbounds i16, ptr %195, i64 %indvars.iv1310, !dbg !2154
  store i16 16384, ptr %arrayidx1901, align 2, !dbg !2155, !tbaa !2156
  %indvars.iv.next1311 = add nuw nsw i64 %indvars.iv1310, 1, !dbg !2158
    #dbg_value(i64 %indvars.iv.next1311, !898, !DIExpression(), !967)
  %arrayidx1901.1 = getelementptr inbounds i16, ptr %195, i64 %indvars.iv.next1311, !dbg !2154
  store i16 16384, ptr %arrayidx1901.1, align 2, !dbg !2159, !tbaa !2156
  %indvars.iv.next1311.1 = add nuw nsw i64 %indvars.iv1310, 2, !dbg !2160
    #dbg_value(i64 %indvars.iv.next1311.1, !898, !DIExpression(), !967)
  %arrayidx1901.2 = getelementptr inbounds i16, ptr %195, i64 %indvars.iv.next1311.1, !dbg !2154
  store i16 16384, ptr %arrayidx1901.2, align 2, !dbg !2161, !tbaa !2156
  %indvars.iv.next1311.2 = add nuw nsw i64 %indvars.iv1310, 3, !dbg !2162
    #dbg_value(i64 %indvars.iv.next1311.2, !898, !DIExpression(), !967)
  %arrayidx1901.3 = getelementptr inbounds i16, ptr %195, i64 %indvars.iv.next1311.2, !dbg !2154
  store i16 16384, ptr %arrayidx1901.3, align 2, !dbg !2163, !tbaa !2156
  %indvars.iv.next1311.3 = add nuw nsw i64 %indvars.iv1310, 4, !dbg !2164
    #dbg_value(i64 %indvars.iv.next1311.3, !898, !DIExpression(), !967)
  %niter.next.3 = add i64 %niter, 4, !dbg !2165
  %niter.ncmp.3 = icmp ne i64 %niter.next.3, %unroll_iter, !dbg !2165
  br i1 %niter.ncmp.3, label %for.body1896, label %for.cond1892.for.inc1906.loopexit1274_crit_edge.unr-lcssa, !dbg !2165, !llvm.loop !2166

for.cond1877.for.inc1906.loopexit_crit_edge.unr-lcssa: ; preds = %for.body1882
  %lcmp.mod1332 = icmp ne i64 %xtraiter1330, 0, !dbg !2132
  br i1 %lcmp.mod1332, label %for.body1882.epil.preheader, label %for.cond1877.for.inc1906.loopexit_crit_edge, !dbg !2132

for.body1882.epil.preheader:                      ; preds = %for.cond1877.for.inc1906.loopexit_crit_edge.unr-lcssa, %for.body1882.lr.ph
  %indvars.iv1317.epil.init = phi i64 [ 0, %for.body1882.lr.ph ], [ %indvars.iv.next1318.3, %for.cond1877.for.inc1906.loopexit_crit_edge.unr-lcssa ]
  %lcmp.mod1333 = icmp ne i64 %xtraiter1330, 0, !dbg !2168
  call void @llvm.assume(i1 %lcmp.mod1333), !dbg !2168
  br label %for.body1882.epil, !dbg !2168

for.body1882.epil:                                ; preds = %for.body1882.epil, %for.body1882.epil.preheader
  %indvars.iv1317.epil = phi i64 [ %indvars.iv1317.epil.init, %for.body1882.epil.preheader ], [ %indvars.iv.next1318.epil, %for.body1882.epil ]
  %epil.iter1331 = phi i64 [ 0, %for.body1882.epil.preheader ], [ %epil.iter1331.next, %for.body1882.epil ]
    #dbg_value(i64 %indvars.iv1317.epil, !898, !DIExpression(), !967)
  %196 = load ptr, ptr %chrUPixBuf, align 16, !dbg !2133, !tbaa !1905
  %arrayidx1885.epil = getelementptr inbounds ptr, ptr %196, i64 %indvars.iv1324, !dbg !2135
  %197 = load ptr, ptr %arrayidx1885.epil, align 8, !dbg !2135, !tbaa !1982
  %arrayidx1887.epil = getelementptr inbounds i32, ptr %197, i64 %indvars.iv1317.epil, !dbg !2136
  store i32 262144, ptr %arrayidx1887.epil, align 4, !dbg !2169, !tbaa !1788
  %indvars.iv.next1318.epil = add nuw nsw i64 %indvars.iv1317.epil, 1, !dbg !2170
    #dbg_value(i64 %indvars.iv.next1318.epil, !898, !DIExpression(), !967)
  %epil.iter1331.next = add i64 %epil.iter1331, 1, !dbg !2171
  %epil.iter1331.cmp = icmp ne i64 %epil.iter1331.next, %xtraiter1330, !dbg !2171
  br i1 %epil.iter1331.cmp, label %for.body1882.epil, label %for.cond1877.for.inc1906.loopexit_crit_edge.epilog-lcssa, !dbg !2171, !llvm.loop !2172

for.cond1877.for.inc1906.loopexit_crit_edge.epilog-lcssa: ; preds = %for.body1882.epil
  br label %for.cond1877.for.inc1906.loopexit_crit_edge, !dbg !2168

for.cond1877.for.inc1906.loopexit_crit_edge:      ; preds = %for.cond1877.for.inc1906.loopexit_crit_edge.epilog-lcssa, %for.cond1877.for.inc1906.loopexit_crit_edge.unr-lcssa
  br label %for.inc1906.loopexit, !dbg !2168

for.inc1906.loopexit:                             ; preds = %for.cond1877.for.inc1906.loopexit_crit_edge, %do.end
  br label %for.inc1906, !dbg !2174

for.cond1892.for.inc1906.loopexit1274_crit_edge.unr-lcssa: ; preds = %for.body1896
  %lcmp.mod = icmp ne i64 %xtraiter, 0, !dbg !2150
  br i1 %lcmp.mod, label %for.body1896.epil.preheader, label %for.cond1892.for.inc1906.loopexit1274_crit_edge, !dbg !2150

for.body1896.epil.preheader:                      ; preds = %for.cond1892.for.inc1906.loopexit1274_crit_edge.unr-lcssa, %for.body1896.lr.ph
  %indvars.iv1310.epil.init = phi i64 [ 0, %for.body1896.lr.ph ], [ %indvars.iv.next1311.3, %for.cond1892.for.inc1906.loopexit1274_crit_edge.unr-lcssa ]
  %lcmp.mod1329 = icmp ne i64 %xtraiter, 0, !dbg !2175
  call void @llvm.assume(i1 %lcmp.mod1329), !dbg !2175
  br label %for.body1896.epil, !dbg !2175

for.body1896.epil:                                ; preds = %for.body1896.epil, %for.body1896.epil.preheader
  %indvars.iv1310.epil = phi i64 [ %indvars.iv1310.epil.init, %for.body1896.epil.preheader ], [ %indvars.iv.next1311.epil, %for.body1896.epil ]
  %epil.iter = phi i64 [ 0, %for.body1896.epil.preheader ], [ %epil.iter.next, %for.body1896.epil ]
    #dbg_value(i64 %indvars.iv1310.epil, !898, !DIExpression(), !967)
  %198 = load ptr, ptr %chrUPixBuf, align 16, !dbg !2151, !tbaa !1905
  %arrayidx1899.epil = getelementptr inbounds ptr, ptr %198, i64 %indvars.iv1324, !dbg !2153
  %199 = load ptr, ptr %arrayidx1899.epil, align 8, !dbg !2153, !tbaa !1982
  %arrayidx1901.epil = getelementptr inbounds i16, ptr %199, i64 %indvars.iv1310.epil, !dbg !2154
  store i16 16384, ptr %arrayidx1901.epil, align 2, !dbg !2176, !tbaa !2156
  %indvars.iv.next1311.epil = add nuw nsw i64 %indvars.iv1310.epil, 1, !dbg !2177
    #dbg_value(i64 %indvars.iv.next1311.epil, !898, !DIExpression(), !967)
  %epil.iter.next = add i64 %epil.iter, 1, !dbg !2178
  %epil.iter.cmp = icmp ne i64 %epil.iter.next, %xtraiter, !dbg !2178
  br i1 %epil.iter.cmp, label %for.body1896.epil, label %for.cond1892.for.inc1906.loopexit1274_crit_edge.epilog-lcssa, !dbg !2178, !llvm.loop !2179

for.cond1892.for.inc1906.loopexit1274_crit_edge.epilog-lcssa: ; preds = %for.body1896.epil
  br label %for.cond1892.for.inc1906.loopexit1274_crit_edge, !dbg !2175

for.cond1892.for.inc1906.loopexit1274_crit_edge:  ; preds = %for.cond1892.for.inc1906.loopexit1274_crit_edge.epilog-lcssa, %for.cond1892.for.inc1906.loopexit1274_crit_edge.unr-lcssa
  br label %for.inc1906.loopexit1274, !dbg !2175

for.inc1906.loopexit1274:                         ; preds = %for.cond1892.for.inc1906.loopexit1274_crit_edge, %if.else1891
  br label %for.inc1906, !dbg !2174

for.inc1906:                                      ; preds = %for.inc1906.loopexit1274, %for.inc1906.loopexit
  %indvars.iv.next1325 = add nuw nsw i64 %indvars.iv1324, 1, !dbg !2174
    #dbg_value(i64 %indvars.iv.next1325, !897, !DIExpression(), !967)
  %200 = load i32, ptr %vChrBufSize, align 4, !dbg !2113, !tbaa !1776
  %201 = sext i32 %200 to i64, !dbg !2180
  %cmp1860 = icmp slt i64 %indvars.iv.next1325, %201, !dbg !2180
  br i1 %cmp1860, label %for.body1862, label %for.cond1858.do.body1909_crit_edge, !dbg !2181, !llvm.loop !2182

for.cond1858.do.body1909_crit_edge:               ; preds = %for.inc1906
  br label %do.body1909, !dbg !2181

do.body1909:                                      ; preds = %for.cond1858.do.body1909_crit_edge, %if.end1857
  %202 = load i32, ptr %chrDstH, align 8, !dbg !2185, !tbaa !1466
  %cmp1911 = icmp sle i32 %202, %3, !dbg !2188
  br i1 %cmp1911, label %do.end1916, label %if.then1913, !dbg !2189

if.then1913:                                      ; preds = %do.body1909
  call void (ptr, i32, ptr, ...) @av_log(ptr noundef null, i32 noundef 0, ptr noundef @.str.14, ptr noundef @.str.17, ptr noundef @.str.16, i32 noundef 1539), !dbg !2190
  call void @abort() #15, !dbg !2190
  unreachable, !dbg !2190

do.end1916:                                       ; preds = %do.body1909
  %and1917 = and i32 %flags.7, 4096, !dbg !2192
  %tobool1918 = icmp ne i32 %and1917, 0, !dbg !2193
  br i1 %tobool1918, label %if.then1919, label %if.end1973, !dbg !2194

if.then1919:                                      ; preds = %do.end1916
    #dbg_value(ptr null, !957, !DIExpression(), !2195)
    #dbg_value(i32 0, !897, !DIExpression(), !967)
  br label %for.body1924, !dbg !2196

for.cond1920:                                     ; preds = %for.body1924
    #dbg_value(i32 %inc1934, !897, !DIExpression(), !967)
  %conv1921 = sext i32 %inc1934 to i64, !dbg !2198
  %cmp1922 = icmp ult i64 %conv1921, 11, !dbg !2200
  br i1 %cmp1922, label %for.body1924, label %for.end1935.loopexit, !dbg !2201, !llvm.loop !2202

for.body1924:                                     ; preds = %for.cond1920, %if.then1919
  %conv19211328 = phi i64 [ 0, %if.then1919 ], [ %conv1921, %for.cond1920 ]
  %i.61327 = phi i32 [ 0, %if.then1919 ], [ %inc1934, %for.cond1920 ]
    #dbg_value(i32 %i.61327, !897, !DIExpression(), !967)
  %arrayidx1926 = getelementptr inbounds nuw [11 x %struct.ScaleAlgorithm], ptr @scale_algorithms, i64 0, i64 %conv19211328, !dbg !2205
  %203 = load i32, ptr %arrayidx1926, align 8, !dbg !2208, !tbaa !2209
  %and1927 = and i32 %203, %flags.7, !dbg !2211
  %tobool1928 = icmp ne i32 %and1927, 0, !dbg !2212
  %inc1934 = add i32 %i.61327, 1, !dbg !2213
    #dbg_value(i32 %inc1934, !897, !DIExpression(), !967)
  br i1 %tobool1928, label %if.then1929, label %for.cond1920, !dbg !2214

if.then1929:                                      ; preds = %for.body1924
  %description = getelementptr inbounds nuw %struct.ScaleAlgorithm, ptr %arrayidx1926, i32 0, i32 1, !dbg !2215
  %204 = load ptr, ptr %description, align 8, !dbg !2217, !tbaa !2218
    #dbg_value(ptr %204, !957, !DIExpression(), !2195)
  br label %for.end1935, !dbg !2219

for.end1935.loopexit:                             ; preds = %for.cond1920
  br label %for.end1935, !dbg !2220

for.end1935:                                      ; preds = %for.end1935.loopexit, %if.then1929
  %scaler.0 = phi ptr [ %204, %if.then1929 ], [ null, %for.end1935.loopexit ], !dbg !2195
    #dbg_value(ptr %scaler.0, !957, !DIExpression(), !2195)
  %tobool1936 = icmp ne ptr %scaler.0, null, !dbg !2220
  %spec.store.select = select i1 %tobool1936, ptr %scaler.0, ptr @.str.18, !dbg !2222
    #dbg_value(ptr %spec.store.select, !957, !DIExpression(), !2195)
  %call1939 = call ptr @av_get_pix_fmt_name(i32 noundef %17), !dbg !2223
  %or.cond288 = select i1 %cmp301, i1 true, i1 %cmp295, !dbg !2224
  %or.cond289 = select i1 %or.cond288, i1 true, i1 %cmp250, !dbg !2224
  %or.cond290 = select i1 %or.cond289, i1 true, i1 %cmp253, !dbg !2224
  %or.cond291 = select i1 %or.cond290, i1 true, i1 %cmp304, !dbg !2224
  br i1 %or.cond291, label %lor.end1957, label %lor.rhs1954, !dbg !2224

lor.rhs1954:                                      ; preds = %for.end1935
  br label %lor.end1957, !dbg !2225

lor.end1957:                                      ; preds = %lor.rhs1954, %for.end1935
  %205 = phi i1 [ true, %for.end1935 ], [ %cmp307, %lor.rhs1954 ]
  %cond1959 = select i1 %205, ptr @.str.20, ptr @.str.21, !dbg !2226
  %call1960 = call ptr @av_get_pix_fmt_name(i32 noundef %18), !dbg !2227
  call void (ptr, i32, ptr, ...) @av_log(ptr noundef %c, i32 noundef 32, ptr noundef @.str.19, ptr noundef %spec.store.select, ptr noundef %call1939, ptr noundef %cond1959, ptr noundef %call1960), !dbg !2228
    #dbg_value(ptr @.str.22, !960, !DIExpression(), !2195)
  call void (ptr, i32, ptr, ...) @av_log(ptr noundef %c, i32 noundef 32, ptr noundef @.str.23, ptr noundef @.str.22), !dbg !2229
  call void (ptr, i32, ptr, ...) @av_log(ptr noundef %c, i32 noundef 40, ptr noundef @.str.24, i32 noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3), !dbg !2230
  %206 = load i32, ptr %srcW1, align 16, !dbg !2231, !tbaa !978
  %207 = load i32, ptr %srcH2, align 4, !dbg !2232, !tbaa !990
  %208 = load i32, ptr %dstW3, align 8, !dbg !2233, !tbaa !993
  %209 = load i32, ptr %dstH4, align 8, !dbg !2234, !tbaa !996
  %210 = load i32, ptr %lumXInc, align 4, !dbg !2235, !tbaa !1133
  %211 = load i32, ptr %lumYInc, align 4, !dbg !2236, !tbaa !1144
  call void (ptr, i32, ptr, ...) @av_log(ptr noundef %c, i32 noundef 48, ptr noundef @.str.25, i32 noundef %206, i32 noundef %207, i32 noundef %208, i32 noundef %209, i32 noundef %210, i32 noundef %211), !dbg !2237
  %212 = load i32, ptr %chrSrcW, align 4, !dbg !2238, !tbaa !1447
  %213 = load i32, ptr %chrSrcH, align 16, !dbg !2239, !tbaa !1453
  %214 = load i32, ptr %chrDstW, align 4, !dbg !2240, !tbaa !1459
  %215 = load i32, ptr %chrDstH, align 8, !dbg !2241, !tbaa !1466
  %216 = load i32, ptr %chrXInc, align 16, !dbg !2242, !tbaa !1535
  %217 = load i32, ptr %chrYInc, align 8, !dbg !2243, !tbaa !1548
  call void (ptr, i32, ptr, ...) @av_log(ptr noundef %c, i32 noundef 48, ptr noundef @.str.26, i32 noundef %212, i32 noundef %213, i32 noundef %214, i32 noundef %215, i32 noundef %216, i32 noundef %217), !dbg !2244
  br label %if.end1973, !dbg !2245

if.end1973:                                       ; preds = %lor.end1957, %do.end1916
  %tobool1974 = icmp eq i32 %land.ext, 0, !dbg !2246
  %or.cond292 = select i1 %tobool1974, i1 true, i1 %26, !dbg !2248
  %or.cond293 = select i1 %or.cond292, i1 true, i1 %22, !dbg !2248
  br i1 %or.cond293, label %if.end2141, label %land.lhs.true1979, !dbg !2248

land.lhs.true1979:                                ; preds = %if.end1973
  %218 = load i32, ptr %srcRange, align 4, !dbg !2249, !tbaa !1020
  %219 = load i32, ptr %dstRange, align 16, !dbg !2250, !tbaa !1026
  %cmp1982 = icmp eq i32 %218, %219, !dbg !2251
  %or.cond294 = select i1 %cmp1982, i1 true, i1 %cmp187, !dbg !2252
  %or.cond295 = select i1 %or.cond294, i1 true, i1 %cmp190, !dbg !2252
  %or.cond296 = select i1 %or.cond295, i1 true, i1 %cmp193, !dbg !2252
  %or.cond297 = select i1 %or.cond296, i1 true, i1 %cmp196, !dbg !2252
  %or.cond298 = select i1 %or.cond297, i1 true, i1 %cmp199, !dbg !2252
  %or.cond299 = select i1 %or.cond298, i1 true, i1 %cmp202, !dbg !2252
  %or.cond300 = select i1 %or.cond299, i1 true, i1 %cmp205, !dbg !2252
  %or.cond301 = select i1 %or.cond300, i1 true, i1 %cmp208, !dbg !2252
  %or.cond302 = select i1 %or.cond301, i1 true, i1 %cmp211, !dbg !2252
  %or.cond303 = select i1 %or.cond302, i1 true, i1 %cmp214, !dbg !2252
  %or.cond304 = select i1 %or.cond303, i1 true, i1 %cmp217, !dbg !2252
  %or.cond305 = select i1 %or.cond304, i1 true, i1 %cmp220, !dbg !2252
  %or.cond306 = select i1 %or.cond305, i1 true, i1 %cmp223, !dbg !2252
  %or.cond307 = select i1 %or.cond306, i1 true, i1 %cmp226, !dbg !2252
  %or.cond308 = select i1 %or.cond307, i1 true, i1 %cmp229, !dbg !2252
  %or.cond309 = select i1 %or.cond308, i1 true, i1 %cmp232, !dbg !2252
  %or.cond310 = select i1 %or.cond309, i1 true, i1 %cmp235, !dbg !2252
  %or.cond311 = select i1 %or.cond310, i1 true, i1 %cmp238, !dbg !2252
  %or.cond312 = select i1 %or.cond311, i1 true, i1 %cmp241, !dbg !2252
  %or.cond313 = select i1 %or.cond312, i1 true, i1 %cmp244, !dbg !2252
  %or.cond314 = select i1 %or.cond313, i1 true, i1 %cmp247, !dbg !2252
  %or.cond315 = select i1 %or.cond314, i1 true, i1 %cmp250, !dbg !2252
  %or.cond316 = select i1 %or.cond315, i1 true, i1 %cmp253, !dbg !2252
  %or.cond317 = select i1 %or.cond316, i1 true, i1 %cmp256, !dbg !2252
  %or.cond318 = select i1 %or.cond317, i1 true, i1 %cmp259, !dbg !2252
  %or.cond319 = select i1 %or.cond318, i1 true, i1 %cmp262, !dbg !2252
  %or.cond320 = select i1 %or.cond319, i1 true, i1 %cmp265, !dbg !2252
  %or.cond321 = select i1 %or.cond320, i1 true, i1 %cmp268, !dbg !2252
  %or.cond322 = select i1 %or.cond321, i1 true, i1 %cmp271, !dbg !2252
  %or.cond323 = select i1 %or.cond322, i1 true, i1 %cmp274, !dbg !2252
  %or.cond324 = select i1 %or.cond323, i1 true, i1 %cmp277, !dbg !2252
  %or.cond325 = select i1 %or.cond324, i1 true, i1 %cmp280, !dbg !2252
  %or.cond326 = select i1 %or.cond325, i1 true, i1 %cmp283, !dbg !2252
  %or.cond327 = select i1 %or.cond326, i1 true, i1 %cmp286, !dbg !2252
  %or.cond328 = select i1 %or.cond327, i1 true, i1 %cmp289, !dbg !2252
  %or.cond329 = select i1 %or.cond328, i1 true, i1 %cmp292, !dbg !2252
  %or.cond330 = select i1 %or.cond329, i1 true, i1 %cmp295, !dbg !2252
  %or.cond331 = select i1 %or.cond330, i1 true, i1 %cmp298, !dbg !2252
  %or.cond332 = select i1 %or.cond331, i1 true, i1 %cmp301, !dbg !2252
  %or.cond333 = select i1 %or.cond332, i1 true, i1 %cmp304, !dbg !2252
  %or.cond334 = select i1 %or.cond333, i1 true, i1 %cmp307, !dbg !2252
  %or.cond335 = select i1 %or.cond334, i1 true, i1 %cmp310, !dbg !2252
  %or.cond336 = select i1 %or.cond335, i1 true, i1 %cmp313, !dbg !2252
  %or.cond337 = select i1 %or.cond336, i1 true, i1 %cmp316, !dbg !2252
  %or.cond338 = select i1 %or.cond337, i1 true, i1 %cmp319, !dbg !2252
  %or.cond339 = select i1 %or.cond338, i1 true, i1 %cmp322, !dbg !2252
  %or.cond340 = select i1 %or.cond339, i1 true, i1 %cmp271, !dbg !2252
  %or.cond341 = select i1 %or.cond340, i1 true, i1 %cmp274, !dbg !2252
  br i1 %or.cond341, label %if.then2131, label %lor.lhs.false2128, !dbg !2252

lor.lhs.false2128:                                ; preds = %land.lhs.true1979
  %call2129 = call fastcc i32 @isRGB(i32 noundef %18), !dbg !2253
  %tobool2130 = icmp ne i32 %call2129, 0, !dbg !2254
  br i1 %tobool2130, label %if.then2131, label %if.end2141, !dbg !2255

if.then2131:                                      ; preds = %lor.lhs.false2128, %land.lhs.true1979
  call void @ff_get_unscaled_swscale(ptr noundef %c), !dbg !2256
  %swscale = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 1, !dbg !2258
  %220 = load ptr, ptr %swscale, align 8, !dbg !2258, !tbaa !2260
  %tobool2132 = icmp ne ptr %220, null, !dbg !2261
  br i1 %tobool2132, label %if.then2133, label %if.end2141, !dbg !2262

if.then2133:                                      ; preds = %if.then2131
  br i1 %tobool1918, label %if.then2136, label %if.end2139, !dbg !2263

if.then2136:                                      ; preds = %if.then2133
  %call2137 = call ptr @av_get_pix_fmt_name(i32 noundef %17), !dbg !2266
  %call2138 = call ptr @av_get_pix_fmt_name(i32 noundef %18), !dbg !2267
  call void (ptr, i32, ptr, ...) @av_log(ptr noundef %c, i32 noundef 32, ptr noundef @.str.27, ptr noundef %call2137, ptr noundef %call2138), !dbg !2268
  br label %if.end2139, !dbg !2268

if.end2139:                                       ; preds = %if.then2136, %if.then2133
  br label %cleanup2202, !dbg !2269

if.end2141:                                       ; preds = %if.then2131, %lor.lhs.false2128, %if.end1973
  %call2142 = call ptr @ff_getSwsFunc(ptr noundef %c), !dbg !2270
  %swscale2143 = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 1, !dbg !2271
  store ptr %call2142, ptr %swscale2143, align 8, !dbg !2272, !tbaa !2260
  br label %cleanup2202, !dbg !2273

fail:                                             ; preds = %if.then1844, %if.then1792, %if.then1746, %if.then1720, %if.then1696, %if.then1680, %if.then1664, %if.then1645, %cleanup1540, %cleanup1496, %if.then1088
  %ret.2 = phi i32 [ %ret.1, %if.then1645 ], [ %ret.1, %if.then1746 ], [ %ret.1, %if.then1792 ], [ %ret.1, %if.then1844 ], [ %ret.1, %if.then1720 ], [ %ret.1, %if.then1696 ], [ %ret.1, %if.then1680 ], [ %ret.1, %if.then1664 ], [ %ret.1, %cleanup1540 ], [ %ret.0, %cleanup1496 ], [ 0, %if.then1088 ], !dbg !967
    #dbg_value(i32 %ret.2, !936, !DIExpression(), !967)
    #dbg_label(!961, !2274)
  %cmp2144 = icmp eq i32 %ret.2, -12345, !dbg !2275
  br i1 %cmp2144, label %if.then2146, label %if.end2201, !dbg !2276

if.then2146:                                      ; preds = %fail
  %mul2149 = mul nsw i64 %conv, %conv107, !dbg !2277
  %conv2150 = sitofp nsz i64 %mul2149 to double, !dbg !2278
  %221 = call nsz double @llvm.sqrt.f64(double %conv2150), !dbg !2279
  %conv2151 = fptosi double %221 to i32, !dbg !2280
    #dbg_value(i32 %conv2151, !962, !DIExpression(), !2281)
  %mul2154 = mul nuw nsw i64 %conv117, %conv112, !dbg !2282
  %conv2155 = uitofp nneg i64 %mul2154 to double, !dbg !2283
  %222 = call nsz double @llvm.sqrt.f64(double %conv2155), !dbg !2284
  %conv2156 = fptosi double %222 to i32, !dbg !2285
    #dbg_value(i32 %conv2156, !965, !DIExpression(), !2281)
    #dbg_value(i32 0, !966, !DIExpression(), !2281)
  %mul2160 = mul nuw nsw i64 %conv112, %conv107, !dbg !2286
  %mul2162 = mul nsw i64 %conv, 4, !dbg !2288
  %mul2164 = mul nsw i64 %mul2162, %conv117, !dbg !2289
  %cmp2165 = icmp sle i64 %mul2160, %mul2164, !dbg !2290
  br i1 %cmp2165, label %if.then2167, label %if.end2168, !dbg !2291

if.then2167:                                      ; preds = %if.then2146
  br label %cleanup2198, !dbg !2292

if.end2168:                                       ; preds = %if.then2146
  %cascaded_tmp2169 = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 28, !dbg !2293
  %cascaded_tmpStride2171 = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 27, !dbg !2294
  %call2173 = call i32 @av_image_alloc(ptr noundef %cascaded_tmp2169, ptr noundef %cascaded_tmpStride2171, i32 noundef %conv2151, i32 noundef %conv2156, i32 noundef 0, i32 noundef 64), !dbg !2295
    #dbg_value(i32 %call2173, !936, !DIExpression(), !967)
  %cmp2174 = icmp slt i32 %call2173, 0, !dbg !2296
  br i1 %cmp2174, label %if.then2176, label %if.end2177, !dbg !2298

if.then2176:                                      ; preds = %if.end2168
  br label %cleanup2198, !dbg !2299

if.end2177:                                       ; preds = %if.end2168
  %223 = load ptr, ptr %srcFilter.addr, align 8, !dbg !2300, !tbaa !968
  %param2178 = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 25, !dbg !2301
  %call2180 = call ptr @sws_getContext_vuln(i32 noundef %0, i32 noundef %1, i32 noundef %17, i32 noundef %conv2151, i32 noundef %conv2156, i32 noundef 0, i32 noundef %flags.7, ptr noundef %223, ptr noundef null, ptr noundef %param2178), !dbg !2302
  %cascaded_context2181 = getelementptr inbounds nuw %struct.SwsContext, ptr %c, i32 0, i32 26, !dbg !2303
  store ptr %call2180, ptr %cascaded_context2181, align 16, !dbg !2304, !tbaa !1580
  %tobool2185 = icmp ne ptr %call2180, null, !dbg !2305
  br i1 %tobool2185, label %if.end2187, label %if.then2186, !dbg !2307

if.then2186:                                      ; preds = %if.end2177
  br label %cleanup2198, !dbg !2308

if.end2187:                                       ; preds = %if.end2177
  %224 = load ptr, ptr %dstFilter.addr, align 8, !dbg !2309, !tbaa !968
  %call2190 = call ptr @sws_getContext_vuln(i32 noundef %conv2151, i32 noundef %conv2156, i32 noundef 0, i32 noundef %2, i32 noundef %3, i32 noundef %18, i32 noundef %flags.7, ptr noundef null, ptr noundef %224, ptr noundef %param2178), !dbg !2310
  %arrayidx2192 = getelementptr inbounds nuw [3 x ptr], ptr %cascaded_context2181, i64 0, i64 1, !dbg !2311
  store ptr %call2190, ptr %arrayidx2192, align 8, !dbg !2312, !tbaa !1580
  %tobool2195 = icmp ne ptr %call2190, null, !dbg !2313
  br i1 %tobool2195, label %if.end2197, label %if.then2196, !dbg !2315

if.then2196:                                      ; preds = %if.end2187
  br label %cleanup2198, !dbg !2316

if.end2197:                                       ; preds = %if.end2187
  br label %cleanup2198, !dbg !2317

cleanup2198:                                      ; preds = %if.end2197, %if.then2196, %if.then2186, %if.then2176, %if.then2167
  %retval.2 = phi i32 [ -22, %if.then2167 ], [ %call2173, %if.then2176 ], [ 0, %if.end2197 ], [ -1, %if.then2196 ], [ -1, %if.then2186 ], !dbg !2281
  br label %cleanup2202

if.end2201:                                       ; preds = %fail
  br label %cleanup2202, !dbg !2318

cleanup2202:                                      ; preds = %if.end2201, %cleanup2198, %if.end2141, %if.end2139, %cleanup1540, %cleanup1496, %cleanup1451, %cleanup, %if.then99, %if.then85, %if.then55, %if.then50
  %retval.3 = phi i32 [ -22, %if.then85 ], [ -22, %if.then99 ], [ %retval.1, %cleanup1451 ], [ undef, %cleanup1496 ], [ undef, %cleanup1540 ], [ %retval.2, %cleanup2198 ], [ -1, %if.end2201 ], [ 0, %if.end2141 ], [ 0, %if.end2139 ], [ %retval.0, %cleanup ], [ -22, %if.then55 ], [ -22, %if.then50 ]
  call void @llvm.lifetime.end.p0(ptr %dummyFilter) #14, !dbg !2319
  ret i32 %retval.3, !dbg !2320
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr writeonly captures(none), i8, i64, i1 immarg) #5

declare i32 @av_get_cpu_flags() local_unnamed_addr #4

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite) uwtable
declare hidden fastcc range(i32 0, 2) i32 @handle_jpeg(ptr nofree noundef captures(none)) unnamed_addr #6

declare void @av_log(ptr noundef, i32 noundef, ptr noundef, ...) local_unnamed_addr #4

declare i32 @av_pix_fmt_swap_endianness(i32 noundef) local_unnamed_addr #4

declare ptr @av_get_pix_fmt_name(i32 noundef) local_unnamed_addr #4

declare i32 @av_pix_fmt_get_chroma_sub_sample(i32 noundef, ptr noundef, ptr noundef) local_unnamed_addr #4

; Function Attrs: alwaysinline nounwind uwtable
declare hidden fastcc range(i32 0, 33) i32 @isRGB(i32 noundef) unnamed_addr #7

; Function Attrs: alwaysinline nounwind uwtable
declare hidden fastcc range(i32 0, 2) i32 @isPlanarRGB(i32 noundef) unnamed_addr #7

declare i32 @av_image_alloc(ptr noundef, ptr noundef, i32 noundef, i32 noundef, i32 noundef, i32 noundef) local_unnamed_addr #4

; Function Attrs: nounwind uwtable
declare ptr @sws_getContext_vuln(i32 noundef, i32 noundef, i32 noundef, i32 noundef, i32 noundef, i32 noundef, i32 noundef, ptr noundef, ptr noundef, ptr nofree noundef readonly captures(address_is_null)) local_unnamed_addr #1

; Function Attrs: nounwind uwtable
declare hidden fastcc ptr @alloc_gamma_tbl(double noundef) unnamed_addr #1

; Function Attrs: nounwind uwtable
declare hidden fastcc i32 @initFilter(ptr nofree noundef captures(none), ptr nofree noundef captures(none) initializes((0, 8)), ptr nofree noundef captures(none), i32 noundef, i32 noundef, i32 noundef, i32 noundef, i32 noundef range(i32 4096, 16385), i32 noundef, i32 noundef, ptr nofree noundef readonly captures(address_is_null), ptr nofree noundef readonly captures(address_is_null), ptr nofree noundef readonly captures(none), i32 noundef range(i32 -2147483520, -2147483648), i32 noundef range(i32 -2147483520, -2147483648)) unnamed_addr #1

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none) uwtable
declare hidden fastcc range(i32 -2147483520, -2147483648) i32 @get_local_pos(ptr nofree noundef readnone captures(none), i32 noundef, i32 noundef, i32 noundef range(i32 0, 2)) unnamed_addr #0

declare noalias ptr @av_malloc(i64 noundef) local_unnamed_addr #4

; Function Attrs: alwaysinline nounwind uwtable
declare hidden fastcc range(i32 0, 129) i32 @isALPHA(i32 noundef) unnamed_addr #7

; Function Attrs: cold nofree noreturn nounwind
declare void @abort() local_unnamed_addr #8

declare void @ff_get_unscaled_swscale(ptr noundef) local_unnamed_addr #4

declare ptr @ff_getSwsFunc(ptr noundef) local_unnamed_addr #4

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.sqrt.f64(double) #9

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(argmem: readwrite) uwtable
declare hidden fastcc void @pv_shared_0(ptr nofree nonnull captures(none), ptr nonnull) unnamed_addr #10

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(argmem: readwrite) uwtable
declare hidden fastcc void @pv_shared_1(ptr nofree nonnull captures(none), ptr nonnull) unnamed_addr #10

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(read, argmem: readwrite, inaccessiblemem: none, target_mem: none) uwtable
declare hidden fastcc void @pv_shared_2(ptr nofree nonnull readonly captures(none), ptr nofree nonnull readonly captures(none), ptr nofree nonnull writeonly captures(none) initializes((0, 1))) unnamed_addr #11

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(read, argmem: readwrite, inaccessiblemem: none, target_mem: none) uwtable
declare hidden fastcc void @pv_shared_3(ptr nofree nonnull readonly captures(none), ptr nofree nonnull readonly captures(none), ptr nofree nonnull writeonly captures(none) initializes((0, 1))) unnamed_addr #11

; Function Attrs: noinline nounwind uwtable
declare hidden fastcc void @pv_shared_4() unnamed_addr #12

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write)
declare void @llvm.assume(i1 noundef) #13

attributes #0 = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) uwtable "min-legal-vector-width"="0" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind uwtable "min-legal-vector-width"="0" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #3 = { nofree norecurse nosync nounwind memory(readwrite, inaccessiblemem: none, target_mem: none) uwtable "min-legal-vector-width"="0" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }
attributes #6 = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite) uwtable "min-legal-vector-width"="0" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #7 = { alwaysinline nounwind uwtable "min-legal-vector-width"="0" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #8 = { cold nofree noreturn nounwind "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #9 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #10 = { mustprogress nofree noinline norecurse nosync nounwind willreturn memory(argmem: readwrite) uwtable "min-legal-vector-width"="0" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #11 = { mustprogress nofree noinline norecurse nosync nounwind willreturn memory(read, argmem: readwrite, inaccessiblemem: none, target_mem: none) uwtable "min-legal-vector-width"="0" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #12 = { noinline nounwind uwtable "min-legal-vector-width"="0" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #13 = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write) }
attributes #14 = { nounwind }
attributes #15 = { noreturn nounwind }

!llvm.dbg.cu = !{!120}
!llvm.module.flags = !{!524, !525, !526, !527}
!llvm.ident = !{!528, !528}
!llvm.errno.tbaa = !{!529, !529}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(scope: null, file: !2, line: 1013, type: !3, isLocal: true, isDefinition: true)
!2 = !DIFile(filename: "libswscale/utils.c", directory: "/ffmpeg/repo", checksumkind: CSK_MD5, checksum: "848373626a67e3c95040c81a3255a766")
!3 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 552, elements: !6)
!4 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !5)
!5 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!6 = !{!7}
!7 = !DISubrange(count: 69)
!8 = !DIGlobalVariableExpression(var: !9, expr: !DIExpression())
!9 = distinct !DIGlobalVariable(scope: null, file: !2, line: 1029, type: !10, isLocal: true, isDefinition: true)
!10 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 344, elements: !11)
!11 = !{!12}
!12 = !DISubrange(count: 43)
!13 = !DIGlobalVariableExpression(var: !14, expr: !DIExpression())
!14 = distinct !DIGlobalVariable(scope: null, file: !2, line: 1034, type: !15, isLocal: true, isDefinition: true)
!15 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 352, elements: !16)
!16 = !{!17}
!17 = !DISubrange(count: 44)
!18 = !DIGlobalVariableExpression(var: !19, expr: !DIExpression())
!19 = distinct !DIGlobalVariable(scope: null, file: !2, line: 1064, type: !20, isLocal: true, isDefinition: true)
!20 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 424, elements: !21)
!21 = !{!22}
!22 = !DISubrange(count: 53)
!23 = !DIGlobalVariableExpression(var: !24, expr: !DIExpression())
!24 = distinct !DIGlobalVariable(scope: null, file: !2, line: 1071, type: !25, isLocal: true, isDefinition: true)
!25 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 360, elements: !26)
!26 = !{!27}
!27 = !DISubrange(count: 45)
!28 = !DIGlobalVariableExpression(var: !29, expr: !DIExpression())
!29 = distinct !DIGlobalVariable(scope: null, file: !2, line: 1101, type: !30, isLocal: true, isDefinition: true)
!30 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 440, elements: !31)
!31 = !{!32}
!32 = !DISubrange(count: 55)
!33 = !DIGlobalVariableExpression(var: !34, expr: !DIExpression())
!34 = distinct !DIGlobalVariable(scope: null, file: !2, line: 1111, type: !35, isLocal: true, isDefinition: true)
!35 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 592, elements: !36)
!36 = !{!37}
!37 = !DISubrange(count: 74)
!38 = !DIGlobalVariableExpression(var: !39, expr: !DIExpression())
!39 = distinct !DIGlobalVariable(scope: null, file: !2, line: 1131, type: !40, isLocal: true, isDefinition: true)
!40 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 728, elements: !41)
!41 = !{!42}
!42 = !DISubrange(count: 91)
!43 = !DIGlobalVariableExpression(var: !44, expr: !DIExpression())
!44 = distinct !DIGlobalVariable(scope: null, file: !2, line: 1140, type: !45, isLocal: true, isDefinition: true)
!45 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 720, elements: !46)
!46 = !{!47}
!47 = !DISubrange(count: 90)
!48 = !DIGlobalVariableExpression(var: !49, expr: !DIExpression())
!49 = distinct !DIGlobalVariable(scope: null, file: !2, line: 1149, type: !50, isLocal: true, isDefinition: true)
!50 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 600, elements: !51)
!51 = !{!52}
!52 = !DISubrange(count: 75)
!53 = !DIGlobalVariableExpression(var: !54, expr: !DIExpression())
!54 = distinct !DIGlobalVariable(scope: null, file: !2, line: 1181, type: !50, isLocal: true, isDefinition: true)
!55 = !DIGlobalVariableExpression(var: !56, expr: !DIExpression())
!56 = distinct !DIGlobalVariable(scope: null, file: !2, line: 1215, type: !57, isLocal: true, isDefinition: true)
!57 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 200, elements: !58)
!58 = !{!59}
!59 = !DISubrange(count: 25)
!60 = !DIGlobalVariableExpression(var: !61, expr: !DIExpression())
!61 = distinct !DIGlobalVariable(scope: null, file: !2, line: 1532, type: !62, isLocal: true, isDefinition: true)
!62 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 240, elements: !63)
!63 = !{!64}
!64 = !DISubrange(count: 30)
!65 = !DIGlobalVariableExpression(var: !66, expr: !DIExpression())
!66 = distinct !DIGlobalVariable(scope: null, file: !2, line: 1532, type: !67, isLocal: true, isDefinition: true)
!67 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 120, elements: !68)
!68 = !{!69}
!69 = !DISubrange(count: 15)
!70 = !DIGlobalVariableExpression(var: !71, expr: !DIExpression())
!71 = distinct !DIGlobalVariable(scope: null, file: !2, line: 1532, type: !72, isLocal: true, isDefinition: true)
!72 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 256, elements: !73)
!73 = !{!74}
!74 = !DISubrange(count: 32)
!75 = !DIGlobalVariableExpression(var: !76, expr: !DIExpression())
!76 = distinct !DIGlobalVariable(scope: null, file: !2, line: 1539, type: !77, isLocal: true, isDefinition: true)
!77 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 152, elements: !78)
!78 = !{!79}
!79 = !DISubrange(count: 19)
!80 = !DIGlobalVariableExpression(var: !81, expr: !DIExpression())
!81 = distinct !DIGlobalVariable(scope: null, file: !2, line: 1551, type: !82, isLocal: true, isDefinition: true)
!82 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 160, elements: !83)
!83 = !{!84}
!84 = !DISubrange(count: 20)
!85 = !DIGlobalVariableExpression(var: !86, expr: !DIExpression())
!86 = distinct !DIGlobalVariable(scope: null, file: !2, line: 1552, type: !87, isLocal: true, isDefinition: true)
!87 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 224, elements: !88)
!88 = !{!89}
!89 = !DISubrange(count: 28)
!90 = !DIGlobalVariableExpression(var: !91, expr: !DIExpression())
!91 = distinct !DIGlobalVariable(scope: null, file: !2, line: 1559, type: !92, isLocal: true, isDefinition: true)
!92 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 80, elements: !93)
!93 = !{!94}
!94 = !DISubrange(count: 10)
!95 = !DIGlobalVariableExpression(var: !96, expr: !DIExpression())
!96 = distinct !DIGlobalVariable(scope: null, file: !2, line: 1559, type: !97, isLocal: true, isDefinition: true)
!97 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 8, elements: !98)
!98 = !{!99}
!99 = !DISubrange(count: 1)
!100 = !DIGlobalVariableExpression(var: !101, expr: !DIExpression())
!101 = distinct !DIGlobalVariable(scope: null, file: !2, line: 1574, type: !102, isLocal: true, isDefinition: true)
!102 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 16, elements: !103)
!103 = !{!104}
!104 = !DISubrange(count: 2)
!105 = !DIGlobalVariableExpression(var: !106, expr: !DIExpression())
!106 = distinct !DIGlobalVariable(scope: null, file: !2, line: 1576, type: !92, isLocal: true, isDefinition: true)
!107 = !DIGlobalVariableExpression(var: !108, expr: !DIExpression())
!108 = distinct !DIGlobalVariable(scope: null, file: !2, line: 1578, type: !109, isLocal: true, isDefinition: true)
!109 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 128, elements: !110)
!110 = !{!111}
!111 = !DISubrange(count: 16)
!112 = !DIGlobalVariableExpression(var: !113, expr: !DIExpression())
!113 = distinct !DIGlobalVariable(scope: null, file: !2, line: 1580, type: !20, isLocal: true, isDefinition: true)
!114 = !DIGlobalVariableExpression(var: !115, expr: !DIExpression())
!115 = distinct !DIGlobalVariable(scope: null, file: !2, line: 1583, type: !20, isLocal: true, isDefinition: true)
!116 = !DIGlobalVariableExpression(var: !117, expr: !DIExpression())
!117 = distinct !DIGlobalVariable(scope: null, file: !2, line: 1596, type: !10, isLocal: true, isDefinition: true)
!118 = !DIGlobalVariableExpression(var: !119, expr: !DIExpression())
!119 = distinct !DIGlobalVariable(name: "scale_algorithms", scope: !120, file: !2, line: 276, type: !513, isLocal: true, isDefinition: true)
!120 = distinct !DICompileUnit(language: DW_LANG_C99, file: !121, producer: "Ubuntu clang version 23.1.1 (++20260901122056+5340f7cc8814-1~exp1~20260901122107.62)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !122, retainedTypes: !484, globals: !512, splitDebugInlining: false, nameTableKind: None)
!121 = !DIFile(filename: "/ffmpeg/repo/libswscale/utils.c", directory: "/ffmpeg/repo/build-FFM001-vuln", checksumkind: CSK_MD5, checksum: "848373626a67e3c95040c81a3255a766")
!122 = !{!123, !423, !453, !474}
!123 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "AVPixelFormat", file: !124, line: 61, baseType: !125, size: 32, elements: !126)
!124 = !DIFile(filename: "libavutil/pixfmt.h", directory: "/ffmpeg/repo", checksumkind: CSK_MD5, checksum: "21f3672a1337a877fc2829117d69ff70")
!125 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!126 = !{!127, !128, !129, !130, !131, !132, !133, !134, !135, !136, !137, !138, !139, !140, !141, !142, !143, !144, !145, !146, !147, !148, !149, !150, !151, !152, !153, !154, !155, !156, !157, !158, !159, !160, !161, !162, !163, !164, !165, !166, !167, !168, !169, !170, !171, !172, !173, !174, !175, !176, !177, !178, !179, !180, !181, !182, !183, !184, !185, !186, !187, !188, !189, !190, !191, !192, !193, !194, !195, !196, !197, !198, !199, !200, !201, !202, !203, !204, !205, !206, !207, !208, !209, !210, !211, !212, !213, !214, !215, !216, !217, !218, !219, !220, !221, !222, !223, !224, !225, !226, !227, !228, !229, !230, !231, !232, !233, !234, !235, !236, !237, !238, !239, !240, !241, !242, !243, !244, !245, !246, !247, !248, !249, !250, !251, !252, !253, !254, !255, !256, !257, !258, !259, !260, !261, !262, !263, !264, !265, !266, !267, !268, !269, !270, !271, !272, !273, !274, !275, !276, !277, !278, !279, !280, !281, !282, !283, !284, !285, !286, !287, !288, !289, !290, !291, !292, !293, !294, !295, !296, !297, !298, !299, !300, !301, !302, !303, !304, !305, !306, !307, !308, !309, !310, !311, !312, !313, !314, !315, !316, !317, !318, !319, !320, !321, !322, !323, !324, !325, !326, !327, !328, !329, !330, !331, !332, !333, !334, !335, !336, !337, !338, !339, !340, !341, !342, !343, !344, !345, !346, !347, !348, !349, !350, !351, !352, !353, !354, !355, !356, !357, !358, !359, !360, !361, !362, !363, !364, !365, !366, !367, !368, !369, !370, !371, !372, !373, !374, !375, !376, !377, !378, !379, !380, !381, !382, !383, !384, !385, !386, !387, !388, !389, !390, !391, !392, !393, !394, !395, !396, !397, !398, !399, !400, !401, !402, !403, !404, !405, !406, !407, !408, !409, !410, !411, !412, !413, !414, !415, !416, !417, !418, !419, !420, !421, !422}
!127 = !DIEnumerator(name: "AV_PIX_FMT_NONE", value: -1)
!128 = !DIEnumerator(name: "AV_PIX_FMT_YUV420P", value: 0)
!129 = !DIEnumerator(name: "AV_PIX_FMT_YUYV422", value: 1)
!130 = !DIEnumerator(name: "AV_PIX_FMT_RGB24", value: 2)
!131 = !DIEnumerator(name: "AV_PIX_FMT_BGR24", value: 3)
!132 = !DIEnumerator(name: "AV_PIX_FMT_YUV422P", value: 4)
!133 = !DIEnumerator(name: "AV_PIX_FMT_YUV444P", value: 5)
!134 = !DIEnumerator(name: "AV_PIX_FMT_YUV410P", value: 6)
!135 = !DIEnumerator(name: "AV_PIX_FMT_YUV411P", value: 7)
!136 = !DIEnumerator(name: "AV_PIX_FMT_GRAY8", value: 8)
!137 = !DIEnumerator(name: "AV_PIX_FMT_MONOWHITE", value: 9)
!138 = !DIEnumerator(name: "AV_PIX_FMT_MONOBLACK", value: 10)
!139 = !DIEnumerator(name: "AV_PIX_FMT_PAL8", value: 11)
!140 = !DIEnumerator(name: "AV_PIX_FMT_YUVJ420P", value: 12)
!141 = !DIEnumerator(name: "AV_PIX_FMT_YUVJ422P", value: 13)
!142 = !DIEnumerator(name: "AV_PIX_FMT_YUVJ444P", value: 14)
!143 = !DIEnumerator(name: "AV_PIX_FMT_XVMC_MPEG2_MC", value: 15)
!144 = !DIEnumerator(name: "AV_PIX_FMT_XVMC_MPEG2_IDCT", value: 16)
!145 = !DIEnumerator(name: "AV_PIX_FMT_UYVY422", value: 17)
!146 = !DIEnumerator(name: "AV_PIX_FMT_UYYVYY411", value: 18)
!147 = !DIEnumerator(name: "AV_PIX_FMT_BGR8", value: 19)
!148 = !DIEnumerator(name: "AV_PIX_FMT_BGR4", value: 20)
!149 = !DIEnumerator(name: "AV_PIX_FMT_BGR4_BYTE", value: 21)
!150 = !DIEnumerator(name: "AV_PIX_FMT_RGB8", value: 22)
!151 = !DIEnumerator(name: "AV_PIX_FMT_RGB4", value: 23)
!152 = !DIEnumerator(name: "AV_PIX_FMT_RGB4_BYTE", value: 24)
!153 = !DIEnumerator(name: "AV_PIX_FMT_NV12", value: 25)
!154 = !DIEnumerator(name: "AV_PIX_FMT_NV21", value: 26)
!155 = !DIEnumerator(name: "AV_PIX_FMT_ARGB", value: 27)
!156 = !DIEnumerator(name: "AV_PIX_FMT_RGBA", value: 28)
!157 = !DIEnumerator(name: "AV_PIX_FMT_ABGR", value: 29)
!158 = !DIEnumerator(name: "AV_PIX_FMT_BGRA", value: 30)
!159 = !DIEnumerator(name: "AV_PIX_FMT_GRAY16BE", value: 31)
!160 = !DIEnumerator(name: "AV_PIX_FMT_GRAY16LE", value: 32)
!161 = !DIEnumerator(name: "AV_PIX_FMT_YUV440P", value: 33)
!162 = !DIEnumerator(name: "AV_PIX_FMT_YUVJ440P", value: 34)
!163 = !DIEnumerator(name: "AV_PIX_FMT_YUVA420P", value: 35)
!164 = !DIEnumerator(name: "AV_PIX_FMT_VDPAU_H264", value: 36)
!165 = !DIEnumerator(name: "AV_PIX_FMT_VDPAU_MPEG1", value: 37)
!166 = !DIEnumerator(name: "AV_PIX_FMT_VDPAU_MPEG2", value: 38)
!167 = !DIEnumerator(name: "AV_PIX_FMT_VDPAU_WMV3", value: 39)
!168 = !DIEnumerator(name: "AV_PIX_FMT_VDPAU_VC1", value: 40)
!169 = !DIEnumerator(name: "AV_PIX_FMT_RGB48BE", value: 41)
!170 = !DIEnumerator(name: "AV_PIX_FMT_RGB48LE", value: 42)
!171 = !DIEnumerator(name: "AV_PIX_FMT_RGB565BE", value: 43)
!172 = !DIEnumerator(name: "AV_PIX_FMT_RGB565LE", value: 44)
!173 = !DIEnumerator(name: "AV_PIX_FMT_RGB555BE", value: 45)
!174 = !DIEnumerator(name: "AV_PIX_FMT_RGB555LE", value: 46)
!175 = !DIEnumerator(name: "AV_PIX_FMT_BGR565BE", value: 47)
!176 = !DIEnumerator(name: "AV_PIX_FMT_BGR565LE", value: 48)
!177 = !DIEnumerator(name: "AV_PIX_FMT_BGR555BE", value: 49)
!178 = !DIEnumerator(name: "AV_PIX_FMT_BGR555LE", value: 50)
!179 = !DIEnumerator(name: "AV_PIX_FMT_VAAPI_MOCO", value: 51)
!180 = !DIEnumerator(name: "AV_PIX_FMT_VAAPI_IDCT", value: 52)
!181 = !DIEnumerator(name: "AV_PIX_FMT_VAAPI_VLD", value: 53)
!182 = !DIEnumerator(name: "AV_PIX_FMT_YUV420P16LE", value: 54)
!183 = !DIEnumerator(name: "AV_PIX_FMT_YUV420P16BE", value: 55)
!184 = !DIEnumerator(name: "AV_PIX_FMT_YUV422P16LE", value: 56)
!185 = !DIEnumerator(name: "AV_PIX_FMT_YUV422P16BE", value: 57)
!186 = !DIEnumerator(name: "AV_PIX_FMT_YUV444P16LE", value: 58)
!187 = !DIEnumerator(name: "AV_PIX_FMT_YUV444P16BE", value: 59)
!188 = !DIEnumerator(name: "AV_PIX_FMT_VDPAU_MPEG4", value: 60)
!189 = !DIEnumerator(name: "AV_PIX_FMT_DXVA2_VLD", value: 61)
!190 = !DIEnumerator(name: "AV_PIX_FMT_RGB444LE", value: 62)
!191 = !DIEnumerator(name: "AV_PIX_FMT_RGB444BE", value: 63)
!192 = !DIEnumerator(name: "AV_PIX_FMT_BGR444LE", value: 64)
!193 = !DIEnumerator(name: "AV_PIX_FMT_BGR444BE", value: 65)
!194 = !DIEnumerator(name: "AV_PIX_FMT_YA8", value: 66)
!195 = !DIEnumerator(name: "AV_PIX_FMT_Y400A", value: 66)
!196 = !DIEnumerator(name: "AV_PIX_FMT_GRAY8A", value: 66)
!197 = !DIEnumerator(name: "AV_PIX_FMT_BGR48BE", value: 67)
!198 = !DIEnumerator(name: "AV_PIX_FMT_BGR48LE", value: 68)
!199 = !DIEnumerator(name: "AV_PIX_FMT_YUV420P9BE", value: 69)
!200 = !DIEnumerator(name: "AV_PIX_FMT_YUV420P9LE", value: 70)
!201 = !DIEnumerator(name: "AV_PIX_FMT_YUV420P10BE", value: 71)
!202 = !DIEnumerator(name: "AV_PIX_FMT_YUV420P10LE", value: 72)
!203 = !DIEnumerator(name: "AV_PIX_FMT_YUV422P10BE", value: 73)
!204 = !DIEnumerator(name: "AV_PIX_FMT_YUV422P10LE", value: 74)
!205 = !DIEnumerator(name: "AV_PIX_FMT_YUV444P9BE", value: 75)
!206 = !DIEnumerator(name: "AV_PIX_FMT_YUV444P9LE", value: 76)
!207 = !DIEnumerator(name: "AV_PIX_FMT_YUV444P10BE", value: 77)
!208 = !DIEnumerator(name: "AV_PIX_FMT_YUV444P10LE", value: 78)
!209 = !DIEnumerator(name: "AV_PIX_FMT_YUV422P9BE", value: 79)
!210 = !DIEnumerator(name: "AV_PIX_FMT_YUV422P9LE", value: 80)
!211 = !DIEnumerator(name: "AV_PIX_FMT_VDA_VLD", value: 81)
!212 = !DIEnumerator(name: "AV_PIX_FMT_GBRP", value: 82)
!213 = !DIEnumerator(name: "AV_PIX_FMT_GBRP9BE", value: 83)
!214 = !DIEnumerator(name: "AV_PIX_FMT_GBRP9LE", value: 84)
!215 = !DIEnumerator(name: "AV_PIX_FMT_GBRP10BE", value: 85)
!216 = !DIEnumerator(name: "AV_PIX_FMT_GBRP10LE", value: 86)
!217 = !DIEnumerator(name: "AV_PIX_FMT_GBRP16BE", value: 87)
!218 = !DIEnumerator(name: "AV_PIX_FMT_GBRP16LE", value: 88)
!219 = !DIEnumerator(name: "AV_PIX_FMT_YUVA422P_LIBAV", value: 89)
!220 = !DIEnumerator(name: "AV_PIX_FMT_YUVA444P_LIBAV", value: 90)
!221 = !DIEnumerator(name: "AV_PIX_FMT_YUVA420P9BE", value: 91)
!222 = !DIEnumerator(name: "AV_PIX_FMT_YUVA420P9LE", value: 92)
!223 = !DIEnumerator(name: "AV_PIX_FMT_YUVA422P9BE", value: 93)
!224 = !DIEnumerator(name: "AV_PIX_FMT_YUVA422P9LE", value: 94)
!225 = !DIEnumerator(name: "AV_PIX_FMT_YUVA444P9BE", value: 95)
!226 = !DIEnumerator(name: "AV_PIX_FMT_YUVA444P9LE", value: 96)
!227 = !DIEnumerator(name: "AV_PIX_FMT_YUVA420P10BE", value: 97)
!228 = !DIEnumerator(name: "AV_PIX_FMT_YUVA420P10LE", value: 98)
!229 = !DIEnumerator(name: "AV_PIX_FMT_YUVA422P10BE", value: 99)
!230 = !DIEnumerator(name: "AV_PIX_FMT_YUVA422P10LE", value: 100)
!231 = !DIEnumerator(name: "AV_PIX_FMT_YUVA444P10BE", value: 101)
!232 = !DIEnumerator(name: "AV_PIX_FMT_YUVA444P10LE", value: 102)
!233 = !DIEnumerator(name: "AV_PIX_FMT_YUVA420P16BE", value: 103)
!234 = !DIEnumerator(name: "AV_PIX_FMT_YUVA420P16LE", value: 104)
!235 = !DIEnumerator(name: "AV_PIX_FMT_YUVA422P16BE", value: 105)
!236 = !DIEnumerator(name: "AV_PIX_FMT_YUVA422P16LE", value: 106)
!237 = !DIEnumerator(name: "AV_PIX_FMT_YUVA444P16BE", value: 107)
!238 = !DIEnumerator(name: "AV_PIX_FMT_YUVA444P16LE", value: 108)
!239 = !DIEnumerator(name: "AV_PIX_FMT_VDPAU", value: 109)
!240 = !DIEnumerator(name: "AV_PIX_FMT_XYZ12LE", value: 110)
!241 = !DIEnumerator(name: "AV_PIX_FMT_XYZ12BE", value: 111)
!242 = !DIEnumerator(name: "AV_PIX_FMT_NV16", value: 112)
!243 = !DIEnumerator(name: "AV_PIX_FMT_NV20LE", value: 113)
!244 = !DIEnumerator(name: "AV_PIX_FMT_NV20BE", value: 114)
!245 = !DIEnumerator(name: "AV_PIX_FMT_RGBA64BE_LIBAV", value: 115)
!246 = !DIEnumerator(name: "AV_PIX_FMT_RGBA64LE_LIBAV", value: 116)
!247 = !DIEnumerator(name: "AV_PIX_FMT_BGRA64BE_LIBAV", value: 117)
!248 = !DIEnumerator(name: "AV_PIX_FMT_BGRA64LE_LIBAV", value: 118)
!249 = !DIEnumerator(name: "AV_PIX_FMT_YVYU422", value: 119)
!250 = !DIEnumerator(name: "AV_PIX_FMT_VDA", value: 120)
!251 = !DIEnumerator(name: "AV_PIX_FMT_YA16BE", value: 121)
!252 = !DIEnumerator(name: "AV_PIX_FMT_YA16LE", value: 122)
!253 = !DIEnumerator(name: "AV_PIX_FMT_GBRAP_LIBAV", value: 123)
!254 = !DIEnumerator(name: "AV_PIX_FMT_GBRAP16BE_LIBAV", value: 124)
!255 = !DIEnumerator(name: "AV_PIX_FMT_GBRAP16LE_LIBAV", value: 125)
!256 = !DIEnumerator(name: "AV_PIX_FMT_QSV", value: 126)
!257 = !DIEnumerator(name: "AV_PIX_FMT_MMAL", value: 127)
!258 = !DIEnumerator(name: "AV_PIX_FMT_D3D11VA_VLD", value: 128)
!259 = !DIEnumerator(name: "AV_PIX_FMT_RGBA64BE", value: 291)
!260 = !DIEnumerator(name: "AV_PIX_FMT_RGBA64LE", value: 292)
!261 = !DIEnumerator(name: "AV_PIX_FMT_BGRA64BE", value: 293)
!262 = !DIEnumerator(name: "AV_PIX_FMT_BGRA64LE", value: 294)
!263 = !DIEnumerator(name: "AV_PIX_FMT_0RGB", value: 295)
!264 = !DIEnumerator(name: "AV_PIX_FMT_RGB0", value: 296)
!265 = !DIEnumerator(name: "AV_PIX_FMT_0BGR", value: 297)
!266 = !DIEnumerator(name: "AV_PIX_FMT_BGR0", value: 298)
!267 = !DIEnumerator(name: "AV_PIX_FMT_YUVA444P", value: 299)
!268 = !DIEnumerator(name: "AV_PIX_FMT_YUVA422P", value: 300)
!269 = !DIEnumerator(name: "AV_PIX_FMT_YUV420P12BE", value: 301)
!270 = !DIEnumerator(name: "AV_PIX_FMT_YUV420P12LE", value: 302)
!271 = !DIEnumerator(name: "AV_PIX_FMT_YUV420P14BE", value: 303)
!272 = !DIEnumerator(name: "AV_PIX_FMT_YUV420P14LE", value: 304)
!273 = !DIEnumerator(name: "AV_PIX_FMT_YUV422P12BE", value: 305)
!274 = !DIEnumerator(name: "AV_PIX_FMT_YUV422P12LE", value: 306)
!275 = !DIEnumerator(name: "AV_PIX_FMT_YUV422P14BE", value: 307)
!276 = !DIEnumerator(name: "AV_PIX_FMT_YUV422P14LE", value: 308)
!277 = !DIEnumerator(name: "AV_PIX_FMT_YUV444P12BE", value: 309)
!278 = !DIEnumerator(name: "AV_PIX_FMT_YUV444P12LE", value: 310)
!279 = !DIEnumerator(name: "AV_PIX_FMT_YUV444P14BE", value: 311)
!280 = !DIEnumerator(name: "AV_PIX_FMT_YUV444P14LE", value: 312)
!281 = !DIEnumerator(name: "AV_PIX_FMT_GBRP12BE", value: 313)
!282 = !DIEnumerator(name: "AV_PIX_FMT_GBRP12LE", value: 314)
!283 = !DIEnumerator(name: "AV_PIX_FMT_GBRP14BE", value: 315)
!284 = !DIEnumerator(name: "AV_PIX_FMT_GBRP14LE", value: 316)
!285 = !DIEnumerator(name: "AV_PIX_FMT_GBRAP", value: 317)
!286 = !DIEnumerator(name: "AV_PIX_FMT_GBRAP16BE", value: 318)
!287 = !DIEnumerator(name: "AV_PIX_FMT_GBRAP16LE", value: 319)
!288 = !DIEnumerator(name: "AV_PIX_FMT_YUVJ411P", value: 320)
!289 = !DIEnumerator(name: "AV_PIX_FMT_BAYER_BGGR8", value: 321)
!290 = !DIEnumerator(name: "AV_PIX_FMT_BAYER_RGGB8", value: 322)
!291 = !DIEnumerator(name: "AV_PIX_FMT_BAYER_GBRG8", value: 323)
!292 = !DIEnumerator(name: "AV_PIX_FMT_BAYER_GRBG8", value: 324)
!293 = !DIEnumerator(name: "AV_PIX_FMT_BAYER_BGGR16LE", value: 325)
!294 = !DIEnumerator(name: "AV_PIX_FMT_BAYER_BGGR16BE", value: 326)
!295 = !DIEnumerator(name: "AV_PIX_FMT_BAYER_RGGB16LE", value: 327)
!296 = !DIEnumerator(name: "AV_PIX_FMT_BAYER_RGGB16BE", value: 328)
!297 = !DIEnumerator(name: "AV_PIX_FMT_BAYER_GBRG16LE", value: 329)
!298 = !DIEnumerator(name: "AV_PIX_FMT_BAYER_GBRG16BE", value: 330)
!299 = !DIEnumerator(name: "AV_PIX_FMT_BAYER_GRBG16LE", value: 331)
!300 = !DIEnumerator(name: "AV_PIX_FMT_BAYER_GRBG16BE", value: 332)
!301 = !DIEnumerator(name: "AV_PIX_FMT_YUV440P10LE", value: 333)
!302 = !DIEnumerator(name: "AV_PIX_FMT_YUV440P10BE", value: 334)
!303 = !DIEnumerator(name: "AV_PIX_FMT_YUV440P12LE", value: 335)
!304 = !DIEnumerator(name: "AV_PIX_FMT_YUV440P12BE", value: 336)
!305 = !DIEnumerator(name: "AV_PIX_FMT_NB", value: 337)
!306 = !DIEnumerator(name: "PIX_FMT_NONE", value: -1)
!307 = !DIEnumerator(name: "PIX_FMT_YUV420P", value: 0)
!308 = !DIEnumerator(name: "PIX_FMT_YUYV422", value: 1)
!309 = !DIEnumerator(name: "PIX_FMT_RGB24", value: 2)
!310 = !DIEnumerator(name: "PIX_FMT_BGR24", value: 3)
!311 = !DIEnumerator(name: "PIX_FMT_YUV422P", value: 4)
!312 = !DIEnumerator(name: "PIX_FMT_YUV444P", value: 5)
!313 = !DIEnumerator(name: "PIX_FMT_YUV410P", value: 6)
!314 = !DIEnumerator(name: "PIX_FMT_YUV411P", value: 7)
!315 = !DIEnumerator(name: "PIX_FMT_GRAY8", value: 8)
!316 = !DIEnumerator(name: "PIX_FMT_MONOWHITE", value: 9)
!317 = !DIEnumerator(name: "PIX_FMT_MONOBLACK", value: 10)
!318 = !DIEnumerator(name: "PIX_FMT_PAL8", value: 11)
!319 = !DIEnumerator(name: "PIX_FMT_YUVJ420P", value: 12)
!320 = !DIEnumerator(name: "PIX_FMT_YUVJ422P", value: 13)
!321 = !DIEnumerator(name: "PIX_FMT_YUVJ444P", value: 14)
!322 = !DIEnumerator(name: "PIX_FMT_XVMC_MPEG2_MC", value: 15)
!323 = !DIEnumerator(name: "PIX_FMT_XVMC_MPEG2_IDCT", value: 16)
!324 = !DIEnumerator(name: "PIX_FMT_UYVY422", value: 17)
!325 = !DIEnumerator(name: "PIX_FMT_UYYVYY411", value: 18)
!326 = !DIEnumerator(name: "PIX_FMT_BGR8", value: 19)
!327 = !DIEnumerator(name: "PIX_FMT_BGR4", value: 20)
!328 = !DIEnumerator(name: "PIX_FMT_BGR4_BYTE", value: 21)
!329 = !DIEnumerator(name: "PIX_FMT_RGB8", value: 22)
!330 = !DIEnumerator(name: "PIX_FMT_RGB4", value: 23)
!331 = !DIEnumerator(name: "PIX_FMT_RGB4_BYTE", value: 24)
!332 = !DIEnumerator(name: "PIX_FMT_NV12", value: 25)
!333 = !DIEnumerator(name: "PIX_FMT_NV21", value: 26)
!334 = !DIEnumerator(name: "PIX_FMT_ARGB", value: 27)
!335 = !DIEnumerator(name: "PIX_FMT_RGBA", value: 28)
!336 = !DIEnumerator(name: "PIX_FMT_ABGR", value: 29)
!337 = !DIEnumerator(name: "PIX_FMT_BGRA", value: 30)
!338 = !DIEnumerator(name: "PIX_FMT_GRAY16BE", value: 31)
!339 = !DIEnumerator(name: "PIX_FMT_GRAY16LE", value: 32)
!340 = !DIEnumerator(name: "PIX_FMT_YUV440P", value: 33)
!341 = !DIEnumerator(name: "PIX_FMT_YUVJ440P", value: 34)
!342 = !DIEnumerator(name: "PIX_FMT_YUVA420P", value: 35)
!343 = !DIEnumerator(name: "PIX_FMT_VDPAU_H264", value: 36)
!344 = !DIEnumerator(name: "PIX_FMT_VDPAU_MPEG1", value: 37)
!345 = !DIEnumerator(name: "PIX_FMT_VDPAU_MPEG2", value: 38)
!346 = !DIEnumerator(name: "PIX_FMT_VDPAU_WMV3", value: 39)
!347 = !DIEnumerator(name: "PIX_FMT_VDPAU_VC1", value: 40)
!348 = !DIEnumerator(name: "PIX_FMT_RGB48BE", value: 41)
!349 = !DIEnumerator(name: "PIX_FMT_RGB48LE", value: 42)
!350 = !DIEnumerator(name: "PIX_FMT_RGB565BE", value: 43)
!351 = !DIEnumerator(name: "PIX_FMT_RGB565LE", value: 44)
!352 = !DIEnumerator(name: "PIX_FMT_RGB555BE", value: 45)
!353 = !DIEnumerator(name: "PIX_FMT_RGB555LE", value: 46)
!354 = !DIEnumerator(name: "PIX_FMT_BGR565BE", value: 47)
!355 = !DIEnumerator(name: "PIX_FMT_BGR565LE", value: 48)
!356 = !DIEnumerator(name: "PIX_FMT_BGR555BE", value: 49)
!357 = !DIEnumerator(name: "PIX_FMT_BGR555LE", value: 50)
!358 = !DIEnumerator(name: "PIX_FMT_VAAPI_MOCO", value: 51)
!359 = !DIEnumerator(name: "PIX_FMT_VAAPI_IDCT", value: 52)
!360 = !DIEnumerator(name: "PIX_FMT_VAAPI_VLD", value: 53)
!361 = !DIEnumerator(name: "PIX_FMT_YUV420P16LE", value: 54)
!362 = !DIEnumerator(name: "PIX_FMT_YUV420P16BE", value: 55)
!363 = !DIEnumerator(name: "PIX_FMT_YUV422P16LE", value: 56)
!364 = !DIEnumerator(name: "PIX_FMT_YUV422P16BE", value: 57)
!365 = !DIEnumerator(name: "PIX_FMT_YUV444P16LE", value: 58)
!366 = !DIEnumerator(name: "PIX_FMT_YUV444P16BE", value: 59)
!367 = !DIEnumerator(name: "PIX_FMT_VDPAU_MPEG4", value: 60)
!368 = !DIEnumerator(name: "PIX_FMT_DXVA2_VLD", value: 61)
!369 = !DIEnumerator(name: "PIX_FMT_RGB444LE", value: 62)
!370 = !DIEnumerator(name: "PIX_FMT_RGB444BE", value: 63)
!371 = !DIEnumerator(name: "PIX_FMT_BGR444LE", value: 64)
!372 = !DIEnumerator(name: "PIX_FMT_BGR444BE", value: 65)
!373 = !DIEnumerator(name: "PIX_FMT_GRAY8A", value: 66)
!374 = !DIEnumerator(name: "PIX_FMT_BGR48BE", value: 67)
!375 = !DIEnumerator(name: "PIX_FMT_BGR48LE", value: 68)
!376 = !DIEnumerator(name: "PIX_FMT_YUV420P9BE", value: 69)
!377 = !DIEnumerator(name: "PIX_FMT_YUV420P9LE", value: 70)
!378 = !DIEnumerator(name: "PIX_FMT_YUV420P10BE", value: 71)
!379 = !DIEnumerator(name: "PIX_FMT_YUV420P10LE", value: 72)
!380 = !DIEnumerator(name: "PIX_FMT_YUV422P10BE", value: 73)
!381 = !DIEnumerator(name: "PIX_FMT_YUV422P10LE", value: 74)
!382 = !DIEnumerator(name: "PIX_FMT_YUV444P9BE", value: 75)
!383 = !DIEnumerator(name: "PIX_FMT_YUV444P9LE", value: 76)
!384 = !DIEnumerator(name: "PIX_FMT_YUV444P10BE", value: 77)
!385 = !DIEnumerator(name: "PIX_FMT_YUV444P10LE", value: 78)
!386 = !DIEnumerator(name: "PIX_FMT_YUV422P9BE", value: 79)
!387 = !DIEnumerator(name: "PIX_FMT_YUV422P9LE", value: 80)
!388 = !DIEnumerator(name: "PIX_FMT_VDA_VLD", value: 81)
!389 = !DIEnumerator(name: "PIX_FMT_GBRP", value: 82)
!390 = !DIEnumerator(name: "PIX_FMT_GBRP9BE", value: 83)
!391 = !DIEnumerator(name: "PIX_FMT_GBRP9LE", value: 84)
!392 = !DIEnumerator(name: "PIX_FMT_GBRP10BE", value: 85)
!393 = !DIEnumerator(name: "PIX_FMT_GBRP10LE", value: 86)
!394 = !DIEnumerator(name: "PIX_FMT_GBRP16BE", value: 87)
!395 = !DIEnumerator(name: "PIX_FMT_GBRP16LE", value: 88)
!396 = !DIEnumerator(name: "PIX_FMT_RGBA64BE", value: 291)
!397 = !DIEnumerator(name: "PIX_FMT_RGBA64LE", value: 292)
!398 = !DIEnumerator(name: "PIX_FMT_BGRA64BE", value: 293)
!399 = !DIEnumerator(name: "PIX_FMT_BGRA64LE", value: 294)
!400 = !DIEnumerator(name: "PIX_FMT_0RGB", value: 295)
!401 = !DIEnumerator(name: "PIX_FMT_RGB0", value: 296)
!402 = !DIEnumerator(name: "PIX_FMT_0BGR", value: 297)
!403 = !DIEnumerator(name: "PIX_FMT_BGR0", value: 298)
!404 = !DIEnumerator(name: "PIX_FMT_YUVA444P", value: 299)
!405 = !DIEnumerator(name: "PIX_FMT_YUVA422P", value: 300)
!406 = !DIEnumerator(name: "PIX_FMT_YUV420P12BE", value: 301)
!407 = !DIEnumerator(name: "PIX_FMT_YUV420P12LE", value: 302)
!408 = !DIEnumerator(name: "PIX_FMT_YUV420P14BE", value: 303)
!409 = !DIEnumerator(name: "PIX_FMT_YUV420P14LE", value: 304)
!410 = !DIEnumerator(name: "PIX_FMT_YUV422P12BE", value: 305)
!411 = !DIEnumerator(name: "PIX_FMT_YUV422P12LE", value: 306)
!412 = !DIEnumerator(name: "PIX_FMT_YUV422P14BE", value: 307)
!413 = !DIEnumerator(name: "PIX_FMT_YUV422P14LE", value: 308)
!414 = !DIEnumerator(name: "PIX_FMT_YUV444P12BE", value: 309)
!415 = !DIEnumerator(name: "PIX_FMT_YUV444P12LE", value: 310)
!416 = !DIEnumerator(name: "PIX_FMT_YUV444P14BE", value: 311)
!417 = !DIEnumerator(name: "PIX_FMT_YUV444P14LE", value: 312)
!418 = !DIEnumerator(name: "PIX_FMT_GBRP12BE", value: 313)
!419 = !DIEnumerator(name: "PIX_FMT_GBRP12LE", value: 314)
!420 = !DIEnumerator(name: "PIX_FMT_GBRP14BE", value: 315)
!421 = !DIEnumerator(name: "PIX_FMT_GBRP14LE", value: 316)
!422 = !DIEnumerator(name: "PIX_FMT_NB", value: 317)
!423 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "AVOptionType", file: !424, line: 221, baseType: !425, size: 32, elements: !426)
!424 = !DIFile(filename: "libavutil/opt.h", directory: "/ffmpeg/repo", checksumkind: CSK_MD5, checksum: "412b47ed411dbf4759aa69ec3c23854e")
!425 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!426 = !{!427, !428, !429, !430, !431, !432, !433, !434, !435, !436, !437, !438, !439, !440, !441, !442, !443, !444, !445, !446, !447, !448, !449, !450, !451, !452}
!427 = !DIEnumerator(name: "AV_OPT_TYPE_FLAGS", value: 0)
!428 = !DIEnumerator(name: "AV_OPT_TYPE_INT", value: 1)
!429 = !DIEnumerator(name: "AV_OPT_TYPE_INT64", value: 2)
!430 = !DIEnumerator(name: "AV_OPT_TYPE_DOUBLE", value: 3)
!431 = !DIEnumerator(name: "AV_OPT_TYPE_FLOAT", value: 4)
!432 = !DIEnumerator(name: "AV_OPT_TYPE_STRING", value: 5)
!433 = !DIEnumerator(name: "AV_OPT_TYPE_RATIONAL", value: 6)
!434 = !DIEnumerator(name: "AV_OPT_TYPE_BINARY", value: 7)
!435 = !DIEnumerator(name: "AV_OPT_TYPE_DICT", value: 8)
!436 = !DIEnumerator(name: "AV_OPT_TYPE_CONST", value: 128)
!437 = !DIEnumerator(name: "AV_OPT_TYPE_IMAGE_SIZE", value: 1397316165)
!438 = !DIEnumerator(name: "AV_OPT_TYPE_PIXEL_FMT", value: 1346784596)
!439 = !DIEnumerator(name: "AV_OPT_TYPE_SAMPLE_FMT", value: 1397116244)
!440 = !DIEnumerator(name: "AV_OPT_TYPE_VIDEO_RATE", value: 1448231252)
!441 = !DIEnumerator(name: "AV_OPT_TYPE_DURATION", value: 1146442272)
!442 = !DIEnumerator(name: "AV_OPT_TYPE_COLOR", value: 1129270354)
!443 = !DIEnumerator(name: "AV_OPT_TYPE_CHANNEL_LAYOUT", value: 1128811585)
!444 = !DIEnumerator(name: "FF_OPT_TYPE_FLAGS", value: 0)
!445 = !DIEnumerator(name: "FF_OPT_TYPE_INT", value: 1)
!446 = !DIEnumerator(name: "FF_OPT_TYPE_INT64", value: 2)
!447 = !DIEnumerator(name: "FF_OPT_TYPE_DOUBLE", value: 3)
!448 = !DIEnumerator(name: "FF_OPT_TYPE_FLOAT", value: 4)
!449 = !DIEnumerator(name: "FF_OPT_TYPE_STRING", value: 5)
!450 = !DIEnumerator(name: "FF_OPT_TYPE_RATIONAL", value: 6)
!451 = !DIEnumerator(name: "FF_OPT_TYPE_BINARY", value: 7)
!452 = !DIEnumerator(name: "FF_OPT_TYPE_CONST", value: 128)
!453 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !454, line: 29, baseType: !425, size: 32, elements: !455)
!454 = !DIFile(filename: "libavutil/log.h", directory: "/ffmpeg/repo", checksumkind: CSK_MD5, checksum: "c24985d73935e74a3c87e8ada17b5435")
!455 = !{!456, !457, !458, !459, !460, !461, !462, !463, !464, !465, !466, !467, !468, !469, !470, !471, !472, !473}
!456 = !DIEnumerator(name: "AV_CLASS_CATEGORY_NA", value: 0)
!457 = !DIEnumerator(name: "AV_CLASS_CATEGORY_INPUT", value: 1)
!458 = !DIEnumerator(name: "AV_CLASS_CATEGORY_OUTPUT", value: 2)
!459 = !DIEnumerator(name: "AV_CLASS_CATEGORY_MUXER", value: 3)
!460 = !DIEnumerator(name: "AV_CLASS_CATEGORY_DEMUXER", value: 4)
!461 = !DIEnumerator(name: "AV_CLASS_CATEGORY_ENCODER", value: 5)
!462 = !DIEnumerator(name: "AV_CLASS_CATEGORY_DECODER", value: 6)
!463 = !DIEnumerator(name: "AV_CLASS_CATEGORY_FILTER", value: 7)
!464 = !DIEnumerator(name: "AV_CLASS_CATEGORY_BITSTREAM_FILTER", value: 8)
!465 = !DIEnumerator(name: "AV_CLASS_CATEGORY_SWSCALER", value: 9)
!466 = !DIEnumerator(name: "AV_CLASS_CATEGORY_SWRESAMPLER", value: 10)
!467 = !DIEnumerator(name: "AV_CLASS_CATEGORY_DEVICE_VIDEO_OUTPUT", value: 40)
!468 = !DIEnumerator(name: "AV_CLASS_CATEGORY_DEVICE_VIDEO_INPUT", value: 41)
!469 = !DIEnumerator(name: "AV_CLASS_CATEGORY_DEVICE_AUDIO_OUTPUT", value: 42)
!470 = !DIEnumerator(name: "AV_CLASS_CATEGORY_DEVICE_AUDIO_INPUT", value: 43)
!471 = !DIEnumerator(name: "AV_CLASS_CATEGORY_DEVICE_OUTPUT", value: 44)
!472 = !DIEnumerator(name: "AV_CLASS_CATEGORY_DEVICE_INPUT", value: 45)
!473 = !DIEnumerator(name: "AV_CLASS_CATEGORY_NB", value: 46)
!474 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "SwsDither", file: !475, line: 68, baseType: !425, size: 32, elements: !476)
!475 = !DIFile(filename: "libswscale/swscale_internal.h", directory: "/ffmpeg/repo", checksumkind: CSK_MD5, checksum: "5edee57c0c25d55983af180e45adf435")
!476 = !{!477, !478, !479, !480, !481, !482, !483}
!477 = !DIEnumerator(name: "SWS_DITHER_NONE", value: 0)
!478 = !DIEnumerator(name: "SWS_DITHER_AUTO", value: 1)
!479 = !DIEnumerator(name: "SWS_DITHER_BAYER", value: 2)
!480 = !DIEnumerator(name: "SWS_DITHER_ED", value: 3)
!481 = !DIEnumerator(name: "SWS_DITHER_A_DITHER", value: 4)
!482 = !DIEnumerator(name: "SWS_DITHER_X_DITHER", value: 5)
!483 = !DIEnumerator(name: "NB_SWS_DITHER", value: 6)
!484 = !{!425, !485, !486, !491, !494, !125, !498, !503, !511}
!485 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!486 = !DIDerivedType(tag: DW_TAG_typedef, name: "int64_t", file: !487, line: 27, baseType: !488)
!487 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/stdint-intn.h", directory: "", checksumkind: CSK_MD5, checksum: "649b383a60bfa3eb90e85840b2b0be20")
!488 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int64_t", file: !489, line: 44, baseType: !490)
!489 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types.h", directory: "", checksumkind: CSK_MD5, checksum: "e1865d9fe29fe1b5ced550b7ba458f9e")
!490 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!491 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !492, size: 64)
!492 = !DIDerivedType(tag: DW_TAG_typedef, name: "int32_t", file: !487, line: 26, baseType: !493)
!493 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int32_t", file: !489, line: 41, baseType: !125)
!494 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !495, size: 64)
!495 = !DIDerivedType(tag: DW_TAG_typedef, name: "int16_t", file: !487, line: 25, baseType: !496)
!496 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int16_t", file: !489, line: 39, baseType: !497)
!497 = !DIBasicType(name: "short", size: 16, encoding: DW_ATE_signed)
!498 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !499, size: 64)
!499 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", file: !500, line: 24, baseType: !501)
!500 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/stdint-uintn.h", directory: "", checksumkind: CSK_MD5, checksum: "256fcabbefa27ca8cf5e6d37525e6e16")
!501 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint8_t", file: !489, line: 38, baseType: !502)
!502 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!503 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !504, size: 64)
!504 = distinct !DICompositeType(tag: DW_TAG_union_type, name: "unaligned_16", file: !505, line: 222, size: 16, elements: !506)
!505 = !DIFile(filename: "libavutil/intreadwrite.h", directory: "/ffmpeg/repo", checksumkind: CSK_MD5, checksum: "f116c91e8280003fda29a856263eca63")
!506 = !{!507}
!507 = !DIDerivedType(tag: DW_TAG_member, name: "l", scope: !504, file: !505, line: 222, baseType: !508, size: 16)
!508 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint16_t", file: !500, line: 25, baseType: !509)
!509 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint16_t", file: !489, line: 40, baseType: !510)
!510 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!511 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !508, size: 64)
!512 = !{!0, !8, !13, !18, !23, !28, !33, !38, !43, !48, !53, !55, !60, !65, !70, !75, !80, !85, !90, !95, !100, !105, !107, !112, !114, !116, !118}
!513 = !DICompositeType(tag: DW_TAG_array_type, baseType: !514, size: 2112, elements: !522)
!514 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !515)
!515 = !DIDerivedType(tag: DW_TAG_typedef, name: "ScaleAlgorithm", file: !2, line: 274, baseType: !516)
!516 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !2, line: 270, size: 192, elements: !517)
!517 = !{!518, !519, !521}
!518 = !DIDerivedType(tag: DW_TAG_member, name: "flag", scope: !516, file: !2, line: 271, baseType: !125, size: 32)
!519 = !DIDerivedType(tag: DW_TAG_member, name: "description", scope: !516, file: !2, line: 272, baseType: !520, size: 64, offset: 64)
!520 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4, size: 64)
!521 = !DIDerivedType(tag: DW_TAG_member, name: "size_factor", scope: !516, file: !2, line: 273, baseType: !125, size: 32, offset: 128)
!522 = !{!523}
!523 = !DISubrange(count: 11)
!524 = !{i32 7, !"Dwarf Version", i32 5}
!525 = !{i32 2, !"Debug Info Version", i32 3}
!526 = !{i32 8, !"PIC Level", i32 2}
!527 = !{i32 7, !"uwtable", i32 2}
!528 = !{!"Ubuntu clang version 23.1.1 (++20260901122056+5340f7cc8814-1~exp1~20260901122107.62)"}
!529 = !{!530, !531, i64 0}
!530 = !{!"__libc_errno", !531, i64 0}
!531 = !{!"int", !532, i64 0}
!532 = !{!"omnipotent char", !533, i64 0}
!533 = !{!"Simple C/C++ TBAA"}
!534 = distinct !DISubprogram(name: "sws_init_context", scope: !2, file: !2, line: 981, type: !535, scopeLine: 983, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !120, retainedNodes: !893, keyInstructions: true)
!535 = !DISubroutineType(types: !536)
!536 = !{!125, !537, !877, !877}
!537 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !538, size: 64)
!538 = !DIDerivedType(tag: DW_TAG_typedef, name: "SwsContext", file: !475, line: 614, baseType: !539)
!539 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "SwsContext", file: !475, line: 273, size: 301056, elements: !540)
!540 = !{!541, !620, !631, !632, !633, !634, !635, !636, !637, !638, !639, !640, !641, !642, !643, !644, !645, !646, !647, !648, !649, !650, !651, !652, !653, !654, !656, !660, !664, !666, !667, !668, !669, !670, !671, !672, !673, !679, !680, !682, !683, !684, !685, !686, !687, !688, !689, !690, !691, !692, !693, !694, !695, !696, !697, !698, !699, !700, !701, !702, !703, !704, !705, !706, !707, !708, !709, !710, !711, !712, !716, !718, !719, !720, !724, !726, !727, !728, !729, !730, !731, !732, !733, !734, !735, !736, !737, !738, !739, !740, !741, !742, !743, !744, !745, !746, !747, !751, !752, !753, !754, !755, !756, !757, !758, !759, !760, !761, !765, !766, !767, !768, !769, !770, !771, !772, !773, !776, !777, !781, !783, !784, !785, !786, !787, !788, !789, !790, !793, !794, !801, !807, !812, !817, !822, !827, !832, !837, !838, !842, !846, !850, !851, !855, !859, !865, !866, !870, !874, !875}
!541 = !DIDerivedType(tag: DW_TAG_member, name: "av_class", scope: !539, file: !475, line: 277, baseType: !542, size: 64)
!542 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !543, size: 64)
!543 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !544)
!544 = !DIDerivedType(tag: DW_TAG_typedef, name: "AVClass", file: !454, line: 143, baseType: !545)
!545 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "AVClass", file: !454, line: 67, size: 640, elements: !546)
!546 = !{!547, !548, !552, !579, !580, !581, !582, !586, !592, !594, !598}
!547 = !DIDerivedType(tag: DW_TAG_member, name: "class_name", scope: !545, file: !454, line: 72, baseType: !520, size: 64)
!548 = !DIDerivedType(tag: DW_TAG_member, name: "item_name", scope: !545, file: !454, line: 78, baseType: !549, size: 64, offset: 64)
!549 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !550, size: 64)
!550 = !DISubroutineType(types: !551)
!551 = !{!520, !485}
!552 = !DIDerivedType(tag: DW_TAG_member, name: "option", scope: !545, file: !454, line: 85, baseType: !553, size: 64, offset: 128)
!553 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !554, size: 64)
!554 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !555)
!555 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "AVOption", file: !424, line: 255, size: 512, elements: !556)
!556 = !{!557, !558, !559, !560, !561, !575, !576, !577, !578}
!557 = !DIDerivedType(tag: DW_TAG_member, name: "name", scope: !555, file: !424, line: 256, baseType: !520, size: 64)
!558 = !DIDerivedType(tag: DW_TAG_member, name: "help", scope: !555, file: !424, line: 262, baseType: !520, size: 64, offset: 64)
!559 = !DIDerivedType(tag: DW_TAG_member, name: "offset", scope: !555, file: !424, line: 268, baseType: !125, size: 32, offset: 128)
!560 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !555, file: !424, line: 269, baseType: !423, size: 32, offset: 160)
!561 = !DIDerivedType(tag: DW_TAG_member, name: "default_val", scope: !555, file: !424, line: 280, baseType: !562, size: 64, offset: 192)
!562 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !555, file: !424, line: 274, size: 64, elements: !563)
!563 = !{!564, !565, !567, !568}
!564 = !DIDerivedType(tag: DW_TAG_member, name: "i64", scope: !562, file: !424, line: 275, baseType: !486, size: 64)
!565 = !DIDerivedType(tag: DW_TAG_member, name: "dbl", scope: !562, file: !424, line: 276, baseType: !566, size: 64)
!566 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!567 = !DIDerivedType(tag: DW_TAG_member, name: "str", scope: !562, file: !424, line: 277, baseType: !520, size: 64)
!568 = !DIDerivedType(tag: DW_TAG_member, name: "q", scope: !562, file: !424, line: 279, baseType: !569, size: 64)
!569 = !DIDerivedType(tag: DW_TAG_typedef, name: "AVRational", file: !570, line: 46, baseType: !571)
!570 = !DIFile(filename: "libavutil/rational.h", directory: "/ffmpeg/repo", checksumkind: CSK_MD5, checksum: "8017fc897eb2c5d8105948c15928a680")
!571 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "AVRational", file: !570, line: 43, size: 64, elements: !572)
!572 = !{!573, !574}
!573 = !DIDerivedType(tag: DW_TAG_member, name: "num", scope: !571, file: !570, line: 44, baseType: !125, size: 32)
!574 = !DIDerivedType(tag: DW_TAG_member, name: "den", scope: !571, file: !570, line: 45, baseType: !125, size: 32, offset: 32)
!575 = !DIDerivedType(tag: DW_TAG_member, name: "min", scope: !555, file: !424, line: 281, baseType: !566, size: 64, offset: 256)
!576 = !DIDerivedType(tag: DW_TAG_member, name: "max", scope: !555, file: !424, line: 282, baseType: !566, size: 64, offset: 320)
!577 = !DIDerivedType(tag: DW_TAG_member, name: "flags", scope: !555, file: !424, line: 284, baseType: !125, size: 32, offset: 384)
!578 = !DIDerivedType(tag: DW_TAG_member, name: "unit", scope: !555, file: !424, line: 310, baseType: !520, size: 64, offset: 448)
!579 = !DIDerivedType(tag: DW_TAG_member, name: "version", scope: !545, file: !454, line: 93, baseType: !125, size: 32, offset: 192)
!580 = !DIDerivedType(tag: DW_TAG_member, name: "log_level_offset_offset", scope: !545, file: !454, line: 99, baseType: !125, size: 32, offset: 224)
!581 = !DIDerivedType(tag: DW_TAG_member, name: "parent_log_context_offset", scope: !545, file: !454, line: 108, baseType: !125, size: 32, offset: 256)
!582 = !DIDerivedType(tag: DW_TAG_member, name: "child_next", scope: !545, file: !454, line: 113, baseType: !583, size: 64, offset: 320)
!583 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !584, size: 64)
!584 = !DISubroutineType(types: !585)
!585 = !{!485, !485, !485}
!586 = !DIDerivedType(tag: DW_TAG_member, name: "child_class_next", scope: !545, file: !454, line: 123, baseType: !587, size: 64, offset: 384)
!587 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !588, size: 64)
!588 = !DISubroutineType(types: !589)
!589 = !{!590, !590}
!590 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !591, size: 64)
!591 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !545)
!592 = !DIDerivedType(tag: DW_TAG_member, name: "category", scope: !545, file: !454, line: 130, baseType: !593, size: 32, offset: 448)
!593 = !DIDerivedType(tag: DW_TAG_typedef, name: "AVClassCategory", file: !454, line: 48, baseType: !453)
!594 = !DIDerivedType(tag: DW_TAG_member, name: "get_category", scope: !545, file: !454, line: 136, baseType: !595, size: 64, offset: 512)
!595 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !596, size: 64)
!596 = !DISubroutineType(types: !597)
!597 = !{!593, !485}
!598 = !DIDerivedType(tag: DW_TAG_member, name: "query_ranges", scope: !545, file: !454, line: 142, baseType: !599, size: 64, offset: 576)
!599 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !600, size: 64)
!600 = !DISubroutineType(types: !601)
!601 = !{!125, !602, !485, !520, !125}
!602 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !603, size: 64)
!603 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !604, size: 64)
!604 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "AVOptionRanges", file: !424, line: 339, size: 128, elements: !605)
!605 = !{!606, !618, !619}
!606 = !DIDerivedType(tag: DW_TAG_member, name: "range", scope: !604, file: !424, line: 370, baseType: !607, size: 64)
!607 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !608, size: 64)
!608 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !609, size: 64)
!609 = !DIDerivedType(tag: DW_TAG_typedef, name: "AVOptionRange", file: !424, line: 334, baseType: !610)
!610 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "AVOptionRange", file: !424, line: 316, size: 384, elements: !611)
!611 = !{!612, !613, !614, !615, !616, !617}
!612 = !DIDerivedType(tag: DW_TAG_member, name: "str", scope: !610, file: !424, line: 317, baseType: !520, size: 64)
!613 = !DIDerivedType(tag: DW_TAG_member, name: "value_min", scope: !610, file: !424, line: 323, baseType: !566, size: 64, offset: 64)
!614 = !DIDerivedType(tag: DW_TAG_member, name: "value_max", scope: !610, file: !424, line: 323, baseType: !566, size: 64, offset: 128)
!615 = !DIDerivedType(tag: DW_TAG_member, name: "component_min", scope: !610, file: !424, line: 328, baseType: !566, size: 64, offset: 192)
!616 = !DIDerivedType(tag: DW_TAG_member, name: "component_max", scope: !610, file: !424, line: 328, baseType: !566, size: 64, offset: 256)
!617 = !DIDerivedType(tag: DW_TAG_member, name: "is_range", scope: !610, file: !424, line: 333, baseType: !125, size: 32, offset: 320)
!618 = !DIDerivedType(tag: DW_TAG_member, name: "nb_ranges", scope: !604, file: !424, line: 374, baseType: !125, size: 32, offset: 64)
!619 = !DIDerivedType(tag: DW_TAG_member, name: "nb_components", scope: !604, file: !424, line: 378, baseType: !125, size: 32, offset: 96)
!620 = !DIDerivedType(tag: DW_TAG_member, name: "swscale", scope: !539, file: !475, line: 283, baseType: !621, size: 64, offset: 64)
!621 = !DIDerivedType(tag: DW_TAG_typedef, name: "SwsFunc", file: !475, line: 78, baseType: !622)
!622 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !623, size: 64)
!623 = !DISubroutineType(types: !624)
!624 = !{!125, !625, !626, !629, !125, !125, !630, !629}
!625 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !539, size: 64)
!626 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !627, size: 64)
!627 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !628, size: 64)
!628 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !499)
!629 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !125, size: 64)
!630 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !498, size: 64)
!631 = !DIDerivedType(tag: DW_TAG_member, name: "srcW", scope: !539, file: !475, line: 284, baseType: !125, size: 32, offset: 128)
!632 = !DIDerivedType(tag: DW_TAG_member, name: "srcH", scope: !539, file: !475, line: 285, baseType: !125, size: 32, offset: 160)
!633 = !DIDerivedType(tag: DW_TAG_member, name: "dstH", scope: !539, file: !475, line: 286, baseType: !125, size: 32, offset: 192)
!634 = !DIDerivedType(tag: DW_TAG_member, name: "chrSrcW", scope: !539, file: !475, line: 287, baseType: !125, size: 32, offset: 224)
!635 = !DIDerivedType(tag: DW_TAG_member, name: "chrSrcH", scope: !539, file: !475, line: 288, baseType: !125, size: 32, offset: 256)
!636 = !DIDerivedType(tag: DW_TAG_member, name: "chrDstW", scope: !539, file: !475, line: 289, baseType: !125, size: 32, offset: 288)
!637 = !DIDerivedType(tag: DW_TAG_member, name: "chrDstH", scope: !539, file: !475, line: 290, baseType: !125, size: 32, offset: 320)
!638 = !DIDerivedType(tag: DW_TAG_member, name: "lumXInc", scope: !539, file: !475, line: 291, baseType: !125, size: 32, offset: 352)
!639 = !DIDerivedType(tag: DW_TAG_member, name: "chrXInc", scope: !539, file: !475, line: 291, baseType: !125, size: 32, offset: 384)
!640 = !DIDerivedType(tag: DW_TAG_member, name: "lumYInc", scope: !539, file: !475, line: 292, baseType: !125, size: 32, offset: 416)
!641 = !DIDerivedType(tag: DW_TAG_member, name: "chrYInc", scope: !539, file: !475, line: 292, baseType: !125, size: 32, offset: 448)
!642 = !DIDerivedType(tag: DW_TAG_member, name: "dstFormat", scope: !539, file: !475, line: 293, baseType: !123, size: 32, offset: 480)
!643 = !DIDerivedType(tag: DW_TAG_member, name: "srcFormat", scope: !539, file: !475, line: 294, baseType: !123, size: 32, offset: 512)
!644 = !DIDerivedType(tag: DW_TAG_member, name: "dstFormatBpp", scope: !539, file: !475, line: 295, baseType: !125, size: 32, offset: 544)
!645 = !DIDerivedType(tag: DW_TAG_member, name: "srcFormatBpp", scope: !539, file: !475, line: 296, baseType: !125, size: 32, offset: 576)
!646 = !DIDerivedType(tag: DW_TAG_member, name: "dstBpc", scope: !539, file: !475, line: 297, baseType: !125, size: 32, offset: 608)
!647 = !DIDerivedType(tag: DW_TAG_member, name: "srcBpc", scope: !539, file: !475, line: 297, baseType: !125, size: 32, offset: 640)
!648 = !DIDerivedType(tag: DW_TAG_member, name: "chrSrcHSubSample", scope: !539, file: !475, line: 298, baseType: !125, size: 32, offset: 672)
!649 = !DIDerivedType(tag: DW_TAG_member, name: "chrSrcVSubSample", scope: !539, file: !475, line: 299, baseType: !125, size: 32, offset: 704)
!650 = !DIDerivedType(tag: DW_TAG_member, name: "chrDstHSubSample", scope: !539, file: !475, line: 300, baseType: !125, size: 32, offset: 736)
!651 = !DIDerivedType(tag: DW_TAG_member, name: "chrDstVSubSample", scope: !539, file: !475, line: 301, baseType: !125, size: 32, offset: 768)
!652 = !DIDerivedType(tag: DW_TAG_member, name: "vChrDrop", scope: !539, file: !475, line: 302, baseType: !125, size: 32, offset: 800)
!653 = !DIDerivedType(tag: DW_TAG_member, name: "sliceDir", scope: !539, file: !475, line: 303, baseType: !125, size: 32, offset: 832)
!654 = !DIDerivedType(tag: DW_TAG_member, name: "param", scope: !539, file: !475, line: 304, baseType: !655, size: 128, offset: 896)
!655 = !DICompositeType(tag: DW_TAG_array_type, baseType: !566, size: 128, elements: !103)
!656 = !DIDerivedType(tag: DW_TAG_member, name: "cascaded_context", scope: !539, file: !475, line: 310, baseType: !657, size: 192, offset: 1024)
!657 = !DICompositeType(tag: DW_TAG_array_type, baseType: !625, size: 192, elements: !658)
!658 = !{!659}
!659 = !DISubrange(count: 3)
!660 = !DIDerivedType(tag: DW_TAG_member, name: "cascaded_tmpStride", scope: !539, file: !475, line: 311, baseType: !661, size: 128, offset: 1216)
!661 = !DICompositeType(tag: DW_TAG_array_type, baseType: !125, size: 128, elements: !662)
!662 = !{!663}
!663 = !DISubrange(count: 4)
!664 = !DIDerivedType(tag: DW_TAG_member, name: "cascaded_tmp", scope: !539, file: !475, line: 312, baseType: !665, size: 256, offset: 1344)
!665 = !DICompositeType(tag: DW_TAG_array_type, baseType: !498, size: 256, elements: !662)
!666 = !DIDerivedType(tag: DW_TAG_member, name: "cascaded1_tmpStride", scope: !539, file: !475, line: 313, baseType: !661, size: 128, offset: 1600)
!667 = !DIDerivedType(tag: DW_TAG_member, name: "cascaded1_tmp", scope: !539, file: !475, line: 314, baseType: !665, size: 256, offset: 1728)
!668 = !DIDerivedType(tag: DW_TAG_member, name: "gamma_value", scope: !539, file: !475, line: 316, baseType: !566, size: 64, offset: 1984)
!669 = !DIDerivedType(tag: DW_TAG_member, name: "gamma_flag", scope: !539, file: !475, line: 317, baseType: !125, size: 32, offset: 2048)
!670 = !DIDerivedType(tag: DW_TAG_member, name: "is_internal_gamma", scope: !539, file: !475, line: 318, baseType: !125, size: 32, offset: 2080)
!671 = !DIDerivedType(tag: DW_TAG_member, name: "gamma", scope: !539, file: !475, line: 319, baseType: !511, size: 64, offset: 2112)
!672 = !DIDerivedType(tag: DW_TAG_member, name: "inv_gamma", scope: !539, file: !475, line: 320, baseType: !511, size: 64, offset: 2176)
!673 = !DIDerivedType(tag: DW_TAG_member, name: "pal_yuv", scope: !539, file: !475, line: 322, baseType: !674, size: 8192, offset: 2240)
!674 = !DICompositeType(tag: DW_TAG_array_type, baseType: !675, size: 8192, elements: !677)
!675 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32_t", file: !500, line: 26, baseType: !676)
!676 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint32_t", file: !489, line: 42, baseType: !425)
!677 = !{!678}
!678 = !DISubrange(count: 256)
!679 = !DIDerivedType(tag: DW_TAG_member, name: "pal_rgb", scope: !539, file: !475, line: 323, baseType: !674, size: 8192, offset: 10432)
!680 = !DIDerivedType(tag: DW_TAG_member, name: "lumPixBuf", scope: !539, file: !475, line: 335, baseType: !681, size: 64, offset: 18624)
!681 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !494, size: 64)
!682 = !DIDerivedType(tag: DW_TAG_member, name: "chrUPixBuf", scope: !539, file: !475, line: 336, baseType: !681, size: 64, offset: 18688)
!683 = !DIDerivedType(tag: DW_TAG_member, name: "chrVPixBuf", scope: !539, file: !475, line: 337, baseType: !681, size: 64, offset: 18752)
!684 = !DIDerivedType(tag: DW_TAG_member, name: "alpPixBuf", scope: !539, file: !475, line: 338, baseType: !681, size: 64, offset: 18816)
!685 = !DIDerivedType(tag: DW_TAG_member, name: "vLumBufSize", scope: !539, file: !475, line: 339, baseType: !125, size: 32, offset: 18880)
!686 = !DIDerivedType(tag: DW_TAG_member, name: "vChrBufSize", scope: !539, file: !475, line: 340, baseType: !125, size: 32, offset: 18912)
!687 = !DIDerivedType(tag: DW_TAG_member, name: "lastInLumBuf", scope: !539, file: !475, line: 341, baseType: !125, size: 32, offset: 18944)
!688 = !DIDerivedType(tag: DW_TAG_member, name: "lastInChrBuf", scope: !539, file: !475, line: 342, baseType: !125, size: 32, offset: 18976)
!689 = !DIDerivedType(tag: DW_TAG_member, name: "lumBufIndex", scope: !539, file: !475, line: 343, baseType: !125, size: 32, offset: 19008)
!690 = !DIDerivedType(tag: DW_TAG_member, name: "chrBufIndex", scope: !539, file: !475, line: 344, baseType: !125, size: 32, offset: 19040)
!691 = !DIDerivedType(tag: DW_TAG_member, name: "formatConvBuffer", scope: !539, file: !475, line: 347, baseType: !498, size: 64, offset: 19072)
!692 = !DIDerivedType(tag: DW_TAG_member, name: "hLumFilter", scope: !539, file: !475, line: 363, baseType: !494, size: 64, offset: 19136)
!693 = !DIDerivedType(tag: DW_TAG_member, name: "hChrFilter", scope: !539, file: !475, line: 364, baseType: !494, size: 64, offset: 19200)
!694 = !DIDerivedType(tag: DW_TAG_member, name: "vLumFilter", scope: !539, file: !475, line: 365, baseType: !494, size: 64, offset: 19264)
!695 = !DIDerivedType(tag: DW_TAG_member, name: "vChrFilter", scope: !539, file: !475, line: 366, baseType: !494, size: 64, offset: 19328)
!696 = !DIDerivedType(tag: DW_TAG_member, name: "hLumFilterPos", scope: !539, file: !475, line: 367, baseType: !491, size: 64, offset: 19392)
!697 = !DIDerivedType(tag: DW_TAG_member, name: "hChrFilterPos", scope: !539, file: !475, line: 368, baseType: !491, size: 64, offset: 19456)
!698 = !DIDerivedType(tag: DW_TAG_member, name: "vLumFilterPos", scope: !539, file: !475, line: 369, baseType: !491, size: 64, offset: 19520)
!699 = !DIDerivedType(tag: DW_TAG_member, name: "vChrFilterPos", scope: !539, file: !475, line: 370, baseType: !491, size: 64, offset: 19584)
!700 = !DIDerivedType(tag: DW_TAG_member, name: "hLumFilterSize", scope: !539, file: !475, line: 371, baseType: !125, size: 32, offset: 19648)
!701 = !DIDerivedType(tag: DW_TAG_member, name: "hChrFilterSize", scope: !539, file: !475, line: 372, baseType: !125, size: 32, offset: 19680)
!702 = !DIDerivedType(tag: DW_TAG_member, name: "vLumFilterSize", scope: !539, file: !475, line: 373, baseType: !125, size: 32, offset: 19712)
!703 = !DIDerivedType(tag: DW_TAG_member, name: "vChrFilterSize", scope: !539, file: !475, line: 374, baseType: !125, size: 32, offset: 19744)
!704 = !DIDerivedType(tag: DW_TAG_member, name: "lumMmxextFilterCodeSize", scope: !539, file: !475, line: 377, baseType: !125, size: 32, offset: 19776)
!705 = !DIDerivedType(tag: DW_TAG_member, name: "chrMmxextFilterCodeSize", scope: !539, file: !475, line: 378, baseType: !125, size: 32, offset: 19808)
!706 = !DIDerivedType(tag: DW_TAG_member, name: "lumMmxextFilterCode", scope: !539, file: !475, line: 379, baseType: !498, size: 64, offset: 19840)
!707 = !DIDerivedType(tag: DW_TAG_member, name: "chrMmxextFilterCode", scope: !539, file: !475, line: 380, baseType: !498, size: 64, offset: 19904)
!708 = !DIDerivedType(tag: DW_TAG_member, name: "canMMXEXTBeUsed", scope: !539, file: !475, line: 382, baseType: !125, size: 32, offset: 19968)
!709 = !DIDerivedType(tag: DW_TAG_member, name: "dstY", scope: !539, file: !475, line: 384, baseType: !125, size: 32, offset: 20000)
!710 = !DIDerivedType(tag: DW_TAG_member, name: "flags", scope: !539, file: !475, line: 385, baseType: !125, size: 32, offset: 20032)
!711 = !DIDerivedType(tag: DW_TAG_member, name: "yuvTable", scope: !539, file: !475, line: 386, baseType: !485, size: 64, offset: 20096)
!712 = !DIDerivedType(tag: DW_TAG_member, name: "table_gV", scope: !539, file: !475, line: 389, baseType: !713, size: 24576, align: 128, offset: 20224)
!713 = !DICompositeType(tag: DW_TAG_array_type, baseType: !125, size: 24576, elements: !714)
!714 = !{!715}
!715 = !DISubrange(count: 768)
!716 = !DIDerivedType(tag: DW_TAG_member, name: "table_rV", scope: !539, file: !475, line: 390, baseType: !717, size: 49152, offset: 44800)
!717 = !DICompositeType(tag: DW_TAG_array_type, baseType: !498, size: 49152, elements: !714)
!718 = !DIDerivedType(tag: DW_TAG_member, name: "table_gU", scope: !539, file: !475, line: 391, baseType: !717, size: 49152, offset: 93952)
!719 = !DIDerivedType(tag: DW_TAG_member, name: "table_bU", scope: !539, file: !475, line: 392, baseType: !717, size: 49152, offset: 143104)
!720 = !DIDerivedType(tag: DW_TAG_member, name: "input_rgb2yuv_table", scope: !539, file: !475, line: 393, baseType: !721, size: 5632, align: 128, offset: 192256)
!721 = !DICompositeType(tag: DW_TAG_array_type, baseType: !492, size: 5632, elements: !722)
!722 = !{!723}
!723 = !DISubrange(count: 176)
!724 = !DIDerivedType(tag: DW_TAG_member, name: "dither_error", scope: !539, file: !475, line: 405, baseType: !725, size: 256, offset: 197888)
!725 = !DICompositeType(tag: DW_TAG_array_type, baseType: !629, size: 256, elements: !662)
!726 = !DIDerivedType(tag: DW_TAG_member, name: "contrast", scope: !539, file: !475, line: 408, baseType: !125, size: 32, offset: 198144)
!727 = !DIDerivedType(tag: DW_TAG_member, name: "brightness", scope: !539, file: !475, line: 408, baseType: !125, size: 32, offset: 198176)
!728 = !DIDerivedType(tag: DW_TAG_member, name: "saturation", scope: !539, file: !475, line: 408, baseType: !125, size: 32, offset: 198208)
!729 = !DIDerivedType(tag: DW_TAG_member, name: "srcColorspaceTable", scope: !539, file: !475, line: 409, baseType: !661, size: 128, offset: 198240)
!730 = !DIDerivedType(tag: DW_TAG_member, name: "dstColorspaceTable", scope: !539, file: !475, line: 410, baseType: !661, size: 128, offset: 198368)
!731 = !DIDerivedType(tag: DW_TAG_member, name: "srcRange", scope: !539, file: !475, line: 411, baseType: !125, size: 32, offset: 198496)
!732 = !DIDerivedType(tag: DW_TAG_member, name: "dstRange", scope: !539, file: !475, line: 412, baseType: !125, size: 32, offset: 198528)
!733 = !DIDerivedType(tag: DW_TAG_member, name: "src0Alpha", scope: !539, file: !475, line: 413, baseType: !125, size: 32, offset: 198560)
!734 = !DIDerivedType(tag: DW_TAG_member, name: "dst0Alpha", scope: !539, file: !475, line: 414, baseType: !125, size: 32, offset: 198592)
!735 = !DIDerivedType(tag: DW_TAG_member, name: "srcXYZ", scope: !539, file: !475, line: 415, baseType: !125, size: 32, offset: 198624)
!736 = !DIDerivedType(tag: DW_TAG_member, name: "dstXYZ", scope: !539, file: !475, line: 416, baseType: !125, size: 32, offset: 198656)
!737 = !DIDerivedType(tag: DW_TAG_member, name: "src_h_chr_pos", scope: !539, file: !475, line: 417, baseType: !125, size: 32, offset: 198688)
!738 = !DIDerivedType(tag: DW_TAG_member, name: "dst_h_chr_pos", scope: !539, file: !475, line: 418, baseType: !125, size: 32, offset: 198720)
!739 = !DIDerivedType(tag: DW_TAG_member, name: "src_v_chr_pos", scope: !539, file: !475, line: 419, baseType: !125, size: 32, offset: 198752)
!740 = !DIDerivedType(tag: DW_TAG_member, name: "dst_v_chr_pos", scope: !539, file: !475, line: 420, baseType: !125, size: 32, offset: 198784)
!741 = !DIDerivedType(tag: DW_TAG_member, name: "yuv2rgb_y_offset", scope: !539, file: !475, line: 421, baseType: !125, size: 32, offset: 198816)
!742 = !DIDerivedType(tag: DW_TAG_member, name: "yuv2rgb_y_coeff", scope: !539, file: !475, line: 422, baseType: !125, size: 32, offset: 198848)
!743 = !DIDerivedType(tag: DW_TAG_member, name: "yuv2rgb_v2r_coeff", scope: !539, file: !475, line: 423, baseType: !125, size: 32, offset: 198880)
!744 = !DIDerivedType(tag: DW_TAG_member, name: "yuv2rgb_v2g_coeff", scope: !539, file: !475, line: 424, baseType: !125, size: 32, offset: 198912)
!745 = !DIDerivedType(tag: DW_TAG_member, name: "yuv2rgb_u2g_coeff", scope: !539, file: !475, line: 425, baseType: !125, size: 32, offset: 198944)
!746 = !DIDerivedType(tag: DW_TAG_member, name: "yuv2rgb_u2b_coeff", scope: !539, file: !475, line: 426, baseType: !125, size: 32, offset: 198976)
!747 = !DIDerivedType(tag: DW_TAG_member, name: "redDither", scope: !539, file: !475, line: 454, baseType: !748, size: 64, align: 64, offset: 199040)
!748 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint64_t", file: !500, line: 27, baseType: !749)
!749 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint64_t", file: !489, line: 45, baseType: !750)
!750 = !DIBasicType(name: "unsigned long", size: 64, encoding: DW_ATE_unsigned)
!751 = !DIDerivedType(tag: DW_TAG_member, name: "greenDither", scope: !539, file: !475, line: 455, baseType: !748, size: 64, align: 64, offset: 199104)
!752 = !DIDerivedType(tag: DW_TAG_member, name: "blueDither", scope: !539, file: !475, line: 456, baseType: !748, size: 64, align: 64, offset: 199168)
!753 = !DIDerivedType(tag: DW_TAG_member, name: "yCoeff", scope: !539, file: !475, line: 458, baseType: !748, size: 64, align: 64, offset: 199232)
!754 = !DIDerivedType(tag: DW_TAG_member, name: "vrCoeff", scope: !539, file: !475, line: 459, baseType: !748, size: 64, align: 64, offset: 199296)
!755 = !DIDerivedType(tag: DW_TAG_member, name: "ubCoeff", scope: !539, file: !475, line: 460, baseType: !748, size: 64, align: 64, offset: 199360)
!756 = !DIDerivedType(tag: DW_TAG_member, name: "vgCoeff", scope: !539, file: !475, line: 461, baseType: !748, size: 64, align: 64, offset: 199424)
!757 = !DIDerivedType(tag: DW_TAG_member, name: "ugCoeff", scope: !539, file: !475, line: 462, baseType: !748, size: 64, align: 64, offset: 199488)
!758 = !DIDerivedType(tag: DW_TAG_member, name: "yOffset", scope: !539, file: !475, line: 463, baseType: !748, size: 64, align: 64, offset: 199552)
!759 = !DIDerivedType(tag: DW_TAG_member, name: "uOffset", scope: !539, file: !475, line: 464, baseType: !748, size: 64, align: 64, offset: 199616)
!760 = !DIDerivedType(tag: DW_TAG_member, name: "vOffset", scope: !539, file: !475, line: 465, baseType: !748, size: 64, align: 64, offset: 199680)
!761 = !DIDerivedType(tag: DW_TAG_member, name: "lumMmxFilter", scope: !539, file: !475, line: 466, baseType: !762, size: 32768, offset: 199744)
!762 = !DICompositeType(tag: DW_TAG_array_type, baseType: !492, size: 32768, elements: !763)
!763 = !{!764}
!764 = !DISubrange(count: 1024)
!765 = !DIDerivedType(tag: DW_TAG_member, name: "chrMmxFilter", scope: !539, file: !475, line: 467, baseType: !762, size: 32768, offset: 232512)
!766 = !DIDerivedType(tag: DW_TAG_member, name: "dstW", scope: !539, file: !475, line: 468, baseType: !125, size: 32, offset: 265280)
!767 = !DIDerivedType(tag: DW_TAG_member, name: "esp", scope: !539, file: !475, line: 469, baseType: !748, size: 64, align: 64, offset: 265344)
!768 = !DIDerivedType(tag: DW_TAG_member, name: "vRounder", scope: !539, file: !475, line: 470, baseType: !748, size: 64, align: 64, offset: 265408)
!769 = !DIDerivedType(tag: DW_TAG_member, name: "u_temp", scope: !539, file: !475, line: 471, baseType: !748, size: 64, align: 64, offset: 265472)
!770 = !DIDerivedType(tag: DW_TAG_member, name: "v_temp", scope: !539, file: !475, line: 472, baseType: !748, size: 64, align: 64, offset: 265536)
!771 = !DIDerivedType(tag: DW_TAG_member, name: "y_temp", scope: !539, file: !475, line: 473, baseType: !748, size: 64, align: 64, offset: 265600)
!772 = !DIDerivedType(tag: DW_TAG_member, name: "alpMmxFilter", scope: !539, file: !475, line: 474, baseType: !762, size: 32768, offset: 265664)
!773 = !DIDerivedType(tag: DW_TAG_member, name: "uv_off", scope: !539, file: !475, line: 478, baseType: !774, size: 64, align: 64, offset: 298432)
!774 = !DIDerivedType(tag: DW_TAG_typedef, name: "ptrdiff_t", file: !775, line: 18, baseType: !490)
!775 = !DIFile(filename: "/usr/lib/llvm-23/lib/clang/23/include/__stddef_ptrdiff_t.h", directory: "", checksumkind: CSK_MD5, checksum: "21e0c40f3315797d915cc7ea60040a98")
!776 = !DIDerivedType(tag: DW_TAG_member, name: "uv_offx2", scope: !539, file: !475, line: 479, baseType: !774, size: 64, align: 64, offset: 298496)
!777 = !DIDerivedType(tag: DW_TAG_member, name: "dither16", scope: !539, file: !475, line: 480, baseType: !778, size: 128, align: 64, offset: 298560)
!778 = !DICompositeType(tag: DW_TAG_array_type, baseType: !508, size: 128, elements: !779)
!779 = !{!780}
!780 = !DISubrange(count: 8)
!781 = !DIDerivedType(tag: DW_TAG_member, name: "dither32", scope: !539, file: !475, line: 481, baseType: !782, size: 256, align: 64, offset: 298688)
!782 = !DICompositeType(tag: DW_TAG_array_type, baseType: !675, size: 256, elements: !779)
!783 = !DIDerivedType(tag: DW_TAG_member, name: "chrDither8", scope: !539, file: !475, line: 483, baseType: !627, size: 64, offset: 298944)
!784 = !DIDerivedType(tag: DW_TAG_member, name: "lumDither8", scope: !539, file: !475, line: 483, baseType: !627, size: 64, offset: 299008)
!785 = !DIDerivedType(tag: DW_TAG_member, name: "use_mmx_vfilter", scope: !539, file: !475, line: 496, baseType: !125, size: 32, offset: 299072)
!786 = !DIDerivedType(tag: DW_TAG_member, name: "xyzgamma", scope: !539, file: !475, line: 501, baseType: !494, size: 64, offset: 299136)
!787 = !DIDerivedType(tag: DW_TAG_member, name: "rgbgamma", scope: !539, file: !475, line: 502, baseType: !494, size: 64, offset: 299200)
!788 = !DIDerivedType(tag: DW_TAG_member, name: "xyzgammainv", scope: !539, file: !475, line: 503, baseType: !494, size: 64, offset: 299264)
!789 = !DIDerivedType(tag: DW_TAG_member, name: "rgbgammainv", scope: !539, file: !475, line: 504, baseType: !494, size: 64, offset: 299328)
!790 = !DIDerivedType(tag: DW_TAG_member, name: "xyz2rgb_matrix", scope: !539, file: !475, line: 505, baseType: !791, size: 192, offset: 299392)
!791 = !DICompositeType(tag: DW_TAG_array_type, baseType: !495, size: 192, elements: !792)
!792 = !{!659, !663}
!793 = !DIDerivedType(tag: DW_TAG_member, name: "rgb2xyz_matrix", scope: !539, file: !475, line: 506, baseType: !791, size: 192, offset: 299584)
!794 = !DIDerivedType(tag: DW_TAG_member, name: "yuv2plane1", scope: !539, file: !475, line: 509, baseType: !795, size: 64, offset: 299776)
!795 = !DIDerivedType(tag: DW_TAG_typedef, name: "yuv2planar1_fn", file: !475, line: 94, baseType: !796)
!796 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !797, size: 64)
!797 = !DISubroutineType(types: !798)
!798 = !{null, !799, !498, !125, !627, !125}
!799 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !800, size: 64)
!800 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !495)
!801 = !DIDerivedType(tag: DW_TAG_member, name: "yuv2planeX", scope: !539, file: !475, line: 510, baseType: !802, size: 64, offset: 299840)
!802 = !DIDerivedType(tag: DW_TAG_typedef, name: "yuv2planarX_fn", file: !475, line: 110, baseType: !803)
!803 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !804, size: 64)
!804 = !DISubroutineType(types: !805)
!805 = !{null, !799, !125, !806, !498, !125, !627, !125}
!806 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !799, size: 64)
!807 = !DIDerivedType(tag: DW_TAG_member, name: "yuv2nv12cX", scope: !539, file: !475, line: 511, baseType: !808, size: 64, offset: 299904)
!808 = !DIDerivedType(tag: DW_TAG_typedef, name: "yuv2interleavedX_fn", file: !475, line: 129, baseType: !809)
!809 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !810, size: 64)
!810 = !DISubroutineType(types: !811)
!811 = !{null, !625, !799, !125, !806, !806, !498, !125}
!812 = !DIDerivedType(tag: DW_TAG_member, name: "yuv2packed1", scope: !539, file: !475, line: 512, baseType: !813, size: 64, offset: 299968)
!813 = !DIDerivedType(tag: DW_TAG_typedef, name: "yuv2packed1_fn", file: !475, line: 165, baseType: !814)
!814 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !815, size: 64)
!815 = !DISubroutineType(types: !816)
!816 = !{null, !625, !799, !806, !806, !799, !498, !125, !125, !125}
!817 = !DIDerivedType(tag: DW_TAG_member, name: "yuv2packed2", scope: !539, file: !475, line: 513, baseType: !818, size: 64, offset: 300032)
!818 = !DIDerivedType(tag: DW_TAG_typedef, name: "yuv2packed2_fn", file: !475, line: 198, baseType: !819)
!819 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !820, size: 64)
!820 = !DISubroutineType(types: !821)
!821 = !{null, !625, !806, !806, !806, !806, !498, !125, !125, !125, !125}
!822 = !DIDerivedType(tag: DW_TAG_member, name: "yuv2packedX", scope: !539, file: !475, line: 514, baseType: !823, size: 64, offset: 300096)
!823 = !DIDerivedType(tag: DW_TAG_typedef, name: "yuv2packedX_fn", file: !475, line: 230, baseType: !824)
!824 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !825, size: 64)
!825 = !DISubroutineType(types: !826)
!826 = !{null, !625, !799, !806, !125, !799, !806, !806, !125, !806, !498, !125, !125}
!827 = !DIDerivedType(tag: DW_TAG_member, name: "yuv2anyX", scope: !539, file: !475, line: 515, baseType: !828, size: 64, offset: 300160)
!828 = !DIDerivedType(tag: DW_TAG_typedef, name: "yuv2anyX_fn", file: !475, line: 264, baseType: !829)
!829 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !830, size: 64)
!830 = !DISubroutineType(types: !831)
!831 = !{null, !625, !799, !806, !125, !799, !806, !806, !125, !806, !630, !125, !125}
!832 = !DIDerivedType(tag: DW_TAG_member, name: "lumToYV12", scope: !539, file: !475, line: 518, baseType: !833, size: 64, offset: 300224)
!833 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !834, size: 64)
!834 = !DISubroutineType(types: !835)
!835 = !{null, !498, !627, !627, !627, !125, !836}
!836 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !675, size: 64)
!837 = !DIDerivedType(tag: DW_TAG_member, name: "alpToYV12", scope: !539, file: !475, line: 521, baseType: !833, size: 64, offset: 300288)
!838 = !DIDerivedType(tag: DW_TAG_member, name: "chrToYV12", scope: !539, file: !475, line: 524, baseType: !839, size: 64, offset: 300352)
!839 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !840, size: 64)
!840 = !DISubroutineType(types: !841)
!841 = !{null, !498, !498, !627, !627, !627, !125, !836}
!842 = !DIDerivedType(tag: DW_TAG_member, name: "readLumPlanar", scope: !539, file: !475, line: 533, baseType: !843, size: 64, offset: 300416)
!843 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !844, size: 64)
!844 = !DISubroutineType(types: !845)
!845 = !{null, !498, !626, !125, !491}
!846 = !DIDerivedType(tag: DW_TAG_member, name: "readChrPlanar", scope: !539, file: !475, line: 534, baseType: !847, size: 64, offset: 300480)
!847 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !848, size: 64)
!848 = !DISubroutineType(types: !849)
!849 = !{null, !498, !498, !626, !125, !491}
!850 = !DIDerivedType(tag: DW_TAG_member, name: "readAlpPlanar", scope: !539, file: !475, line: 536, baseType: !843, size: 64, offset: 300544)
!851 = !DIDerivedType(tag: DW_TAG_member, name: "hyscale_fast", scope: !539, file: !475, line: 558, baseType: !852, size: 64, offset: 300608)
!852 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !853, size: 64)
!853 = !DISubroutineType(types: !854)
!854 = !{null, !625, !494, !125, !627, !125, !125}
!855 = !DIDerivedType(tag: DW_TAG_member, name: "hcscale_fast", scope: !539, file: !475, line: 561, baseType: !856, size: 64, offset: 300672)
!856 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !857, size: 64)
!857 = !DISubroutineType(types: !858)
!858 = !{null, !625, !494, !494, !125, !627, !627, !125, !125}
!859 = !DIDerivedType(tag: DW_TAG_member, name: "hyScale", scope: !539, file: !475, line: 598, baseType: !860, size: 64, offset: 300736)
!860 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !861, size: 64)
!861 = !DISubroutineType(types: !862)
!862 = !{null, !625, !494, !125, !627, !799, !863, !125}
!863 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !864, size: 64)
!864 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !492)
!865 = !DIDerivedType(tag: DW_TAG_member, name: "hcScale", scope: !539, file: !475, line: 601, baseType: !860, size: 64, offset: 300800)
!866 = !DIDerivedType(tag: DW_TAG_member, name: "lumConvertRange", scope: !539, file: !475, line: 607, baseType: !867, size: 64, offset: 300864)
!867 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !868, size: 64)
!868 = !DISubroutineType(types: !869)
!869 = !{null, !494, !125}
!870 = !DIDerivedType(tag: DW_TAG_member, name: "chrConvertRange", scope: !539, file: !475, line: 609, baseType: !871, size: 64, offset: 300928)
!871 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !872, size: 64)
!872 = !DISubroutineType(types: !873)
!873 = !{null, !494, !494, !125}
!874 = !DIDerivedType(tag: DW_TAG_member, name: "needs_hcscale", scope: !539, file: !475, line: 611, baseType: !125, size: 32, offset: 300992)
!875 = !DIDerivedType(tag: DW_TAG_member, name: "dither", scope: !539, file: !475, line: 613, baseType: !876, size: 32, offset: 301024)
!876 = !DIDerivedType(tag: DW_TAG_typedef, name: "SwsDither", file: !475, line: 76, baseType: !474)
!877 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !878, size: 64)
!878 = !DIDerivedType(tag: DW_TAG_typedef, name: "SwsFilter", file: !879, line: 133, baseType: !880)
!879 = !DIFile(filename: "libswscale/swscale.h", directory: "/ffmpeg/repo", checksumkind: CSK_MD5, checksum: "942eb35f36f35c62a49b98927d18fb6c")
!880 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "SwsFilter", file: !879, line: 128, size: 256, elements: !881)
!881 = !{!882, !890, !891, !892}
!882 = !DIDerivedType(tag: DW_TAG_member, name: "lumH", scope: !880, file: !879, line: 129, baseType: !883, size: 64)
!883 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !884, size: 64)
!884 = !DIDerivedType(tag: DW_TAG_typedef, name: "SwsVector", file: !879, line: 125, baseType: !885)
!885 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "SwsVector", file: !879, line: 122, size: 128, elements: !886)
!886 = !{!887, !889}
!887 = !DIDerivedType(tag: DW_TAG_member, name: "coeff", scope: !885, file: !879, line: 123, baseType: !888, size: 64)
!888 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !566, size: 64)
!889 = !DIDerivedType(tag: DW_TAG_member, name: "length", scope: !885, file: !879, line: 124, baseType: !125, size: 32, offset: 64)
!890 = !DIDerivedType(tag: DW_TAG_member, name: "lumV", scope: !880, file: !879, line: 130, baseType: !883, size: 64, offset: 64)
!891 = !DIDerivedType(tag: DW_TAG_member, name: "chrH", scope: !880, file: !879, line: 131, baseType: !883, size: 64, offset: 128)
!892 = !DIDerivedType(tag: DW_TAG_member, name: "chrV", scope: !880, file: !879, line: 132, baseType: !883, size: 64, offset: 192)
!893 = !{!894, !895, !896, !897, !898, !899, !900, !901, !902, !903, !904, !905, !906, !907, !908, !909, !910, !911, !912, !935, !936, !937, !938, !941, !946, !950, !952, !956, !957, !960, !961, !962, !965, !966}
!894 = !DILocalVariable(name: "c", arg: 1, scope: !534, file: !2, line: 981, type: !537)
!895 = !DILocalVariable(name: "srcFilter", arg: 2, scope: !534, file: !2, line: 981, type: !877)
!896 = !DILocalVariable(name: "dstFilter", arg: 3, scope: !534, file: !2, line: 982, type: !877)
!897 = !DILocalVariable(name: "i", scope: !534, file: !2, line: 984, type: !125)
!898 = !DILocalVariable(name: "j", scope: !534, file: !2, line: 984, type: !125)
!899 = !DILocalVariable(name: "usesVFilter", scope: !534, file: !2, line: 985, type: !125)
!900 = !DILocalVariable(name: "usesHFilter", scope: !534, file: !2, line: 985, type: !125)
!901 = !DILocalVariable(name: "unscaled", scope: !534, file: !2, line: 986, type: !125)
!902 = !DILocalVariable(name: "dummyFilter", scope: !534, file: !2, line: 987, type: !878)
!903 = !DILocalVariable(name: "srcW", scope: !534, file: !2, line: 988, type: !125)
!904 = !DILocalVariable(name: "srcH", scope: !534, file: !2, line: 989, type: !125)
!905 = !DILocalVariable(name: "dstW", scope: !534, file: !2, line: 990, type: !125)
!906 = !DILocalVariable(name: "dstH", scope: !534, file: !2, line: 991, type: !125)
!907 = !DILocalVariable(name: "dst_stride", scope: !534, file: !2, line: 992, type: !125)
!908 = !DILocalVariable(name: "flags", scope: !534, file: !2, line: 993, type: !125)
!909 = !DILocalVariable(name: "cpu_flags", scope: !534, file: !2, line: 993, type: !125)
!910 = !DILocalVariable(name: "srcFormat", scope: !534, file: !2, line: 994, type: !123)
!911 = !DILocalVariable(name: "dstFormat", scope: !534, file: !2, line: 995, type: !123)
!912 = !DILocalVariable(name: "desc_src", scope: !534, file: !2, line: 996, type: !913)
!913 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !914, size: 64)
!914 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !915)
!915 = !DIDerivedType(tag: DW_TAG_typedef, name: "AVPixFmtDescriptor", file: !916, line: 106, baseType: !917)
!916 = !DIFile(filename: "libavutil/pixdesc.h", directory: "/ffmpeg/repo", checksumkind: CSK_MD5, checksum: "9993cd0e774db9fbfe300ed297c042e5")
!917 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "AVPixFmtDescriptor", file: !916, line: 69, size: 256, elements: !918)
!918 = !{!919, !920, !921, !922, !923, !924, !934}
!919 = !DIDerivedType(tag: DW_TAG_member, name: "name", scope: !917, file: !916, line: 70, baseType: !520, size: 64)
!920 = !DIDerivedType(tag: DW_TAG_member, name: "nb_components", scope: !917, file: !916, line: 71, baseType: !499, size: 8, offset: 64)
!921 = !DIDerivedType(tag: DW_TAG_member, name: "log2_chroma_w", scope: !917, file: !916, line: 80, baseType: !499, size: 8, offset: 72)
!922 = !DIDerivedType(tag: DW_TAG_member, name: "log2_chroma_h", scope: !917, file: !916, line: 89, baseType: !499, size: 8, offset: 80)
!923 = !DIDerivedType(tag: DW_TAG_member, name: "flags", scope: !917, file: !916, line: 90, baseType: !499, size: 8, offset: 88)
!924 = !DIDerivedType(tag: DW_TAG_member, name: "comp", scope: !917, file: !916, line: 100, baseType: !925, size: 64, offset: 96)
!925 = !DICompositeType(tag: DW_TAG_array_type, baseType: !926, size: 64, elements: !662)
!926 = !DIDerivedType(tag: DW_TAG_typedef, name: "AVComponentDescriptor", file: !916, line: 58, baseType: !927)
!927 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "AVComponentDescriptor", file: !916, line: 30, size: 16, elements: !928)
!928 = !{!929, !930, !931, !932, !933}
!929 = !DIDerivedType(tag: DW_TAG_member, name: "plane", scope: !927, file: !916, line: 34, baseType: !508, size: 2, flags: DIFlagBitField, extraData: i64 0)
!930 = !DIDerivedType(tag: DW_TAG_member, name: "step_minus1", scope: !927, file: !916, line: 40, baseType: !508, size: 3, offset: 2, flags: DIFlagBitField, extraData: i64 0)
!931 = !DIDerivedType(tag: DW_TAG_member, name: "offset_plus1", scope: !927, file: !916, line: 46, baseType: !508, size: 3, offset: 5, flags: DIFlagBitField, extraData: i64 0)
!932 = !DIDerivedType(tag: DW_TAG_member, name: "shift", scope: !927, file: !916, line: 52, baseType: !508, size: 3, offset: 8, flags: DIFlagBitField, extraData: i64 0)
!933 = !DIDerivedType(tag: DW_TAG_member, name: "depth_minus1", scope: !927, file: !916, line: 57, baseType: !508, size: 4, offset: 11, flags: DIFlagBitField, extraData: i64 0)
!934 = !DIDerivedType(tag: DW_TAG_member, name: "alias", scope: !917, file: !916, line: 105, baseType: !520, size: 64, offset: 192)
!935 = !DILocalVariable(name: "desc_dst", scope: !534, file: !2, line: 997, type: !913)
!936 = !DILocalVariable(name: "ret", scope: !534, file: !2, line: 998, type: !125)
!937 = !DILocalVariable(name: "tmpFmt", scope: !534, file: !2, line: 999, type: !123)
!938 = !DILocalVariable(name: "c2", scope: !939, file: !2, line: 1272, type: !537)
!939 = distinct !DILexicalBlock(scope: !940, file: !2, line: 1271, column: 85)
!940 = distinct !DILexicalBlock(scope: !534, file: !2, line: 1271, column: 9)
!941 = !DILocalVariable(name: "tmpFormat", scope: !942, file: !2, line: 1320, type: !123)
!942 = distinct !DILexicalBlock(scope: !943, file: !2, line: 1319, column: 81)
!943 = distinct !DILexicalBlock(scope: !944, file: !2, line: 1318, column: 13)
!944 = distinct !DILexicalBlock(scope: !945, file: !2, line: 1317, column: 29)
!945 = distinct !DILexicalBlock(scope: !534, file: !2, line: 1317, column: 9)
!946 = !DILocalVariable(name: "filterAlign", scope: !947, file: !2, line: 1407, type: !949)
!947 = distinct !DILexicalBlock(scope: !948, file: !2, line: 1406, column: 9)
!948 = distinct !DILexicalBlock(scope: !534, file: !2, line: 1345, column: 5)
!949 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !125)
!950 = !DILocalVariable(name: "filterAlign", scope: !951, file: !2, line: 1433, type: !949)
!951 = distinct !DILexicalBlock(scope: !534, file: !2, line: 1432, column: 5)
!952 = !DILocalVariable(name: "chrI", scope: !953, file: !2, line: 1479, type: !125)
!953 = distinct !DILexicalBlock(scope: !954, file: !2, line: 1478, column: 32)
!954 = distinct !DILexicalBlock(scope: !955, file: !2, line: 1478, column: 5)
!955 = distinct !DILexicalBlock(scope: !534, file: !2, line: 1478, column: 5)
!956 = !DILocalVariable(name: "nextSlice", scope: !953, file: !2, line: 1480, type: !125)
!957 = !DILocalVariable(name: "scaler", scope: !958, file: !2, line: 1542, type: !520)
!958 = distinct !DILexicalBlock(scope: !959, file: !2, line: 1541, column: 33)
!959 = distinct !DILexicalBlock(scope: !534, file: !2, line: 1541, column: 9)
!960 = !DILocalVariable(name: "cpucaps", scope: !958, file: !2, line: 1542, type: !520)
!961 = !DILabel(scope: !534, name: "fail", file: !2, line: 1604, column: 1)
!962 = !DILocalVariable(name: "tmpW", scope: !963, file: !2, line: 1606, type: !125)
!963 = distinct !DILexicalBlock(scope: !964, file: !2, line: 1605, column: 38)
!964 = distinct !DILexicalBlock(scope: !534, file: !2, line: 1605, column: 9)
!965 = !DILocalVariable(name: "tmpH", scope: !963, file: !2, line: 1607, type: !125)
!966 = !DILocalVariable(name: "tmpFormat", scope: !963, file: !2, line: 1608, type: !123)
!967 = !DILocation(line: 0, scope: !534)
!968 = !{!969, !969, i64 0}
!969 = !{!"p1 _ZTS9SwsFilter", !970, i64 0}
!970 = !{!"any pointer", !532, i64 0}
!971 = !DILocation(line: 981, column: 56, scope: !534)
!972 = !DILocation(line: 982, column: 41, scope: !534)
!973 = !DILocation(line: 987, column: 5, scope: !534)
!974 = !DILocation(line: 987, column: 15, scope: !534)
!975 = !DILocation(line: 987, column: 15, scope: !534, atomGroup: 1, atomRank: 1)
!976 = !DILocation(line: 988, column: 32, scope: !534)
!977 = !DILocation(line: 988, column: 32, scope: !534, atomGroup: 2, atomRank: 2)
!978 = !{!979, !531, i64 16}
!979 = !{!"SwsContext", !980, i64 0, !970, i64 8, !531, i64 16, !531, i64 20, !531, i64 24, !531, i64 28, !531, i64 32, !531, i64 36, !531, i64 40, !531, i64 44, !531, i64 48, !531, i64 52, !531, i64 56, !531, i64 60, !531, i64 64, !531, i64 68, !531, i64 72, !531, i64 76, !531, i64 80, !531, i64 84, !531, i64 88, !531, i64 92, !531, i64 96, !531, i64 100, !531, i64 104, !532, i64 112, !532, i64 128, !532, i64 152, !532, i64 168, !532, i64 200, !532, i64 216, !981, i64 248, !531, i64 256, !531, i64 260, !982, i64 264, !982, i64 272, !532, i64 280, !532, i64 1304, !983, i64 2328, !983, i64 2336, !983, i64 2344, !983, i64 2352, !531, i64 2360, !531, i64 2364, !531, i64 2368, !531, i64 2372, !531, i64 2376, !531, i64 2380, !985, i64 2384, !982, i64 2392, !982, i64 2400, !982, i64 2408, !982, i64 2416, !986, i64 2424, !986, i64 2432, !986, i64 2440, !986, i64 2448, !531, i64 2456, !531, i64 2460, !531, i64 2464, !531, i64 2468, !531, i64 2472, !531, i64 2476, !985, i64 2480, !985, i64 2488, !531, i64 2496, !531, i64 2500, !531, i64 2504, !970, i64 2512, !532, i64 2528, !532, i64 5600, !532, i64 11744, !532, i64 17888, !532, i64 24032, !532, i64 24736, !531, i64 24768, !531, i64 24772, !531, i64 24776, !532, i64 24780, !532, i64 24796, !531, i64 24812, !531, i64 24816, !531, i64 24820, !531, i64 24824, !531, i64 24828, !531, i64 24832, !531, i64 24836, !531, i64 24840, !531, i64 24844, !531, i64 24848, !531, i64 24852, !531, i64 24856, !531, i64 24860, !531, i64 24864, !531, i64 24868, !531, i64 24872, !987, i64 24880, !987, i64 24888, !987, i64 24896, !987, i64 24904, !987, i64 24912, !987, i64 24920, !987, i64 24928, !987, i64 24936, !987, i64 24944, !987, i64 24952, !987, i64 24960, !532, i64 24968, !532, i64 29064, !531, i64 33160, !987, i64 33168, !987, i64 33176, !987, i64 33184, !987, i64 33192, !987, i64 33200, !532, i64 33208, !987, i64 37304, !987, i64 37312, !532, i64 37320, !532, i64 37336, !985, i64 37368, !985, i64 37376, !531, i64 37384, !982, i64 37392, !982, i64 37400, !982, i64 37408, !982, i64 37416, !532, i64 37424, !532, i64 37448, !970, i64 37472, !970, i64 37480, !970, i64 37488, !970, i64 37496, !970, i64 37504, !970, i64 37512, !970, i64 37520, !970, i64 37528, !970, i64 37536, !970, i64 37544, !970, i64 37552, !970, i64 37560, !970, i64 37568, !970, i64 37576, !970, i64 37584, !970, i64 37592, !970, i64 37600, !970, i64 37608, !970, i64 37616, !531, i64 37624, !531, i64 37628}
!980 = !{!"p1 _ZTS7AVClass", !970, i64 0}
!981 = !{!"double", !532, i64 0}
!982 = !{!"p1 short", !970, i64 0}
!983 = !{!"p2 short", !984, i64 0}
!984 = !{!"any p2 pointer", !970, i64 0}
!985 = !{!"p1 omnipotent char", !970, i64 0}
!986 = !{!"p1 int", !970, i64 0}
!987 = !{!"long", !532, i64 0}
!988 = !DILocation(line: 989, column: 32, scope: !534)
!989 = !DILocation(line: 989, column: 32, scope: !534, atomGroup: 3, atomRank: 2)
!990 = !{!979, !531, i64 20}
!991 = !DILocation(line: 990, column: 32, scope: !534)
!992 = !DILocation(line: 990, column: 32, scope: !534, atomGroup: 4, atomRank: 2)
!993 = !{!979, !531, i64 33160}
!994 = !DILocation(line: 991, column: 32, scope: !534)
!995 = !DILocation(line: 991, column: 32, scope: !534, atomGroup: 5, atomRank: 2)
!996 = !{!979, !531, i64 24}
!997 = !DILocation(line: 992, column: 37, scope: !534)
!998 = !DILocation(line: 992, column: 42, scope: !534)
!999 = !DILocation(line: 992, column: 29, scope: !534)
!1000 = !DILocation(line: 992, column: 29, scope: !534, atomGroup: 6, atomRank: 3)
!1001 = !DILocation(line: 992, column: 29, scope: !534, atomGroup: 6, atomRank: 2)
!1002 = !DILocation(line: 994, column: 39, scope: !534)
!1003 = !DILocation(line: 994, column: 39, scope: !534, atomGroup: 7, atomRank: 2)
!1004 = !{!979, !531, i64 64}
!1005 = !DILocation(line: 995, column: 39, scope: !534)
!1006 = !DILocation(line: 995, column: 39, scope: !534, atomGroup: 8, atomRank: 2)
!1007 = !{!979, !531, i64 60}
!1008 = !DILocation(line: 1001, column: 17, scope: !534, atomGroup: 10, atomRank: 2)
!1009 = !DILocation(line: 1002, column: 20, scope: !534)
!1010 = !DILocation(line: 1002, column: 20, scope: !534, atomGroup: 11, atomRank: 2)
!1011 = !{!979, !531, i64 2504}
!1012 = !DILocation(line: 1004, column: 10, scope: !1013)
!1013 = distinct !DILexicalBlock(scope: !534, file: !2, line: 1004, column: 9)
!1014 = !DILocation(line: 1007, column: 22, scope: !534, atomGroup: 15, atomRank: 2)
!1015 = !DILocation(line: 1007, column: 30, scope: !534, atomGroup: 15, atomRank: 1)
!1016 = !DILocation(line: 1007, column: 30, scope: !534, atomGroup: 14, atomRank: 2)
!1017 = !DILocation(line: 1009, column: 20, scope: !534)
!1018 = !DILocation(line: 1009, column: 8, scope: !534)
!1019 = !DILocation(line: 1009, column: 17, scope: !534)
!1020 = !{!979, !531, i64 24812}
!1021 = !DILocation(line: 1009, column: 17, scope: !534, atomGroup: 16, atomRank: 2)
!1022 = !DILocation(line: 1009, column: 17, scope: !534, atomGroup: 16, atomRank: 1)
!1023 = !DILocation(line: 1010, column: 20, scope: !534)
!1024 = !DILocation(line: 1010, column: 8, scope: !534)
!1025 = !DILocation(line: 1010, column: 17, scope: !534)
!1026 = !{!979, !531, i64 24816}
!1027 = !DILocation(line: 1010, column: 17, scope: !534, atomGroup: 17, atomRank: 2)
!1028 = !DILocation(line: 1010, column: 17, scope: !534, atomGroup: 17, atomRank: 1)
!1029 = !DILocation(line: 1012, column: 22, scope: !1030)
!1030 = distinct !DILexicalBlock(scope: !534, file: !2, line: 1012, column: 8)
!1031 = !DILocation(line: 1012, column: 17, scope: !1030, atomGroup: 18, atomRank: 2)
!1032 = !DILocation(line: 1012, column: 32, scope: !1030, atomGroup: 18, atomRank: 1)
!1033 = !DILocation(line: 1012, column: 49, scope: !1030)
!1034 = !DILocation(line: 1012, column: 44, scope: !1030, atomGroup: 19, atomRank: 2)
!1035 = !DILocation(line: 1012, column: 32, scope: !1030, atomGroup: 19, atomRank: 1)
!1036 = !DILocation(line: 1013, column: 9, scope: !1030)
!1037 = !DILocation(line: 1015, column: 13, scope: !1038)
!1038 = distinct !DILexicalBlock(scope: !534, file: !2, line: 1015, column: 9)
!1039 = !{!979, !531, i64 24768}
!1040 = !DILocation(line: 1015, column: 10, scope: !1038, atomGroup: 20, atomRank: 2)
!1041 = !DILocation(line: 1015, column: 22, scope: !1038, atomGroup: 20, atomRank: 1)
!1042 = !DILocation(line: 1015, column: 29, scope: !1038)
!1043 = !{!979, !531, i64 24776}
!1044 = !DILocation(line: 1015, column: 26, scope: !1038, atomGroup: 21, atomRank: 2)
!1045 = !DILocation(line: 1015, column: 40, scope: !1038, atomGroup: 21, atomRank: 1)
!1046 = !DILocation(line: 1015, column: 47, scope: !1038)
!1047 = !{!979, !531, i64 68}
!1048 = !DILocation(line: 1015, column: 44, scope: !1038, atomGroup: 22, atomRank: 2)
!1049 = !DILocation(line: 1015, column: 40, scope: !1038, atomGroup: 22, atomRank: 1)
!1050 = !DILocation(line: 1016, column: 75, scope: !1038)
!1051 = !DILocation(line: 1018, column: 37, scope: !1038)
!1052 = !DILocation(line: 1016, column: 9, scope: !1038)
!1053 = !DILocation(line: 1020, column: 5, scope: !534)
!1054 = !DILocation(line: 1021, column: 20, scope: !534, atomGroup: 23, atomRank: 2)
!1055 = !DILocation(line: 1022, column: 20, scope: !534, atomGroup: 24, atomRank: 2)
!1056 = !DILocation(line: 1023, column: 16, scope: !534, atomGroup: 25, atomRank: 2)
!1057 = !DILocation(line: 1024, column: 16, scope: !534, atomGroup: 26, atomRank: 2)
!1058 = !DILocation(line: 1026, column: 20, scope: !1059, atomGroup: 27, atomRank: 1)
!1059 = distinct !DILexicalBlock(scope: !534, file: !2, line: 1026, column: 9)
!1060 = !DILocation(line: 1026, column: 23, scope: !1059)
!1061 = !DILocation(line: 1026, column: 23, scope: !1059, atomGroup: 28, atomRank: 2)
!1062 = !DILocation(line: 1026, column: 70, scope: !1059, atomGroup: 28, atomRank: 1)
!1063 = !DILocation(line: 1027, column: 11, scope: !1059)
!1064 = !DILocation(line: 1027, column: 49, scope: !1059, atomGroup: 29, atomRank: 2)
!1065 = !DILocation(line: 1026, column: 9, scope: !1059, atomGroup: 29, atomRank: 1)
!1066 = !DILocation(line: 1028, column: 10, scope: !1067)
!1067 = distinct !DILexicalBlock(scope: !1068, file: !2, line: 1028, column: 9)
!1068 = distinct !DILexicalBlock(scope: !1059, file: !2, line: 1027, column: 64)
!1069 = !DILocation(line: 1028, column: 10, scope: !1067, atomGroup: 30, atomRank: 2)
!1070 = !DILocation(line: 1028, column: 9, scope: !1067, atomGroup: 30, atomRank: 1)
!1071 = !DILocation(line: 1030, column: 16, scope: !1072)
!1072 = distinct !DILexicalBlock(scope: !1067, file: !2, line: 1028, column: 43)
!1073 = !DILocation(line: 1029, column: 9, scope: !1072)
!1074 = !DILocation(line: 1031, column: 9, scope: !1072, atomGroup: 31, atomRank: 1)
!1075 = !DILocation(line: 1033, column: 10, scope: !1076)
!1076 = distinct !DILexicalBlock(scope: !1068, file: !2, line: 1033, column: 9)
!1077 = !DILocation(line: 1033, column: 10, scope: !1076, atomGroup: 32, atomRank: 2)
!1078 = !DILocation(line: 1033, column: 9, scope: !1076, atomGroup: 32, atomRank: 1)
!1079 = !DILocation(line: 1035, column: 16, scope: !1080)
!1080 = distinct !DILexicalBlock(scope: !1076, file: !2, line: 1033, column: 44)
!1081 = !DILocation(line: 1034, column: 9, scope: !1080)
!1082 = !DILocation(line: 1036, column: 9, scope: !1080, atomGroup: 33, atomRank: 1)
!1083 = !DILocation(line: 1041, column: 15, scope: !534, atomGroup: 34, atomRank: 2)
!1084 = !DILocation(line: 1054, column: 10, scope: !1085, atomGroup: 35, atomRank: 2)
!1085 = distinct !DILexicalBlock(scope: !534, file: !2, line: 1054, column: 9)
!1086 = !DILocation(line: 1054, column: 9, scope: !1085, atomGroup: 35, atomRank: 1)
!1087 = !DILocation(line: 1055, column: 18, scope: !1088, atomGroup: 36, atomRank: 2)
!1088 = distinct !DILexicalBlock(scope: !1089, file: !2, line: 1055, column: 13)
!1089 = distinct !DILexicalBlock(scope: !1085, file: !2, line: 1054, column: 13)
!1090 = !DILocation(line: 1055, column: 25, scope: !1088, atomGroup: 36, atomRank: 1)
!1091 = !DILocation(line: 1055, column: 33, scope: !1088, atomGroup: 37, atomRank: 2)
!1092 = !DILocation(line: 1055, column: 25, scope: !1088, atomGroup: 37, atomRank: 1)
!1093 = !DILocation(line: 1056, column: 19, scope: !1088, atomGroup: 38, atomRank: 2)
!1094 = !DILocation(line: 1056, column: 13, scope: !1088)
!1095 = !DILocation(line: 1057, column: 23, scope: !1096, atomGroup: 39, atomRank: 2)
!1096 = distinct !DILexicalBlock(scope: !1088, file: !2, line: 1057, column: 18)
!1097 = !DILocation(line: 1057, column: 30, scope: !1096, atomGroup: 39, atomRank: 1)
!1098 = !DILocation(line: 1057, column: 38, scope: !1096, atomGroup: 40, atomRank: 2)
!1099 = !DILocation(line: 1057, column: 30, scope: !1096, atomGroup: 40, atomRank: 1)
!1100 = !DILocation(line: 1058, column: 19, scope: !1096, atomGroup: 41, atomRank: 2)
!1101 = !DILocation(line: 1058, column: 13, scope: !1096)
!1102 = !DILocation(line: 1060, column: 19, scope: !1096, atomGroup: 42, atomRank: 2)
!1103 = !DILocation(line: 0, scope: !1088)
!1104 = !DILocation(line: 1061, column: 18, scope: !1089, atomGroup: 43, atomRank: 1)
!1105 = !DILocation(line: 1062, column: 5, scope: !1089)
!1106 = !DILocation(line: 1062, column: 23, scope: !1107)
!1107 = distinct !DILexicalBlock(scope: !1085, file: !2, line: 1062, column: 16)
!1108 = !DILocation(line: 1062, column: 18, scope: !1107)
!1109 = !DILocation(line: 1062, column: 18, scope: !1107, atomGroup: 44, atomRank: 2)
!1110 = !DILocation(line: 1062, column: 18, scope: !1107, atomGroup: 44, atomRank: 1)
!1111 = !DILocation(line: 1063, column: 9, scope: !1112)
!1112 = distinct !DILexicalBlock(scope: !1107, file: !2, line: 1062, column: 29)
!1113 = !DILocation(line: 1065, column: 9, scope: !1112, atomGroup: 45, atomRank: 1)
!1114 = !DILocation(line: 1068, column: 14, scope: !1115, atomGroup: 46, atomRank: 2)
!1115 = distinct !DILexicalBlock(scope: !534, file: !2, line: 1068, column: 9)
!1116 = !DILocation(line: 1068, column: 18, scope: !1115, atomGroup: 46, atomRank: 1)
!1117 = !DILocation(line: 1071, column: 9, scope: !1118)
!1118 = distinct !DILexicalBlock(scope: !1115, file: !2, line: 1068, column: 55)
!1119 = !DILocation(line: 1073, column: 9, scope: !1118, atomGroup: 50, atomRank: 1)
!1120 = !DILocation(line: 1076, column: 10, scope: !1121)
!1121 = distinct !DILexicalBlock(scope: !534, file: !2, line: 1076, column: 9)
!1122 = !DILocation(line: 1078, column: 10, scope: !1123)
!1123 = distinct !DILexicalBlock(scope: !534, file: !2, line: 1078, column: 9)
!1124 = !DILocation(line: 1081, column: 25, scope: !534)
!1125 = !DILocation(line: 1081, column: 39, scope: !534)
!1126 = !DILocation(line: 1081, column: 54, scope: !534)
!1127 = !DILocation(line: 1081, column: 48, scope: !534)
!1128 = !DILocation(line: 1081, column: 46, scope: !534)
!1129 = !DILocation(line: 1081, column: 61, scope: !534, atomGroup: 55, atomRank: 3)
!1130 = !DILocation(line: 1081, column: 23, scope: !534, atomGroup: 55, atomRank: 2)
!1131 = !DILocation(line: 1081, column: 8, scope: !534)
!1132 = !DILocation(line: 1081, column: 21, scope: !534, atomGroup: 55, atomRank: 1)
!1133 = !{!979, !531, i64 44}
!1134 = !DILocation(line: 1082, column: 25, scope: !534)
!1135 = !DILocation(line: 1082, column: 39, scope: !534)
!1136 = !DILocation(line: 1082, column: 54, scope: !534)
!1137 = !DILocation(line: 1082, column: 48, scope: !534)
!1138 = !DILocation(line: 1082, column: 46, scope: !534)
!1139 = !DILocation(line: 1082, column: 63, scope: !534)
!1140 = !DILocation(line: 1082, column: 61, scope: !534, atomGroup: 56, atomRank: 3)
!1141 = !DILocation(line: 1082, column: 23, scope: !534, atomGroup: 56, atomRank: 2)
!1142 = !DILocation(line: 1082, column: 8, scope: !534)
!1143 = !DILocation(line: 1082, column: 21, scope: !534, atomGroup: 56, atomRank: 1)
!1144 = !{!979, !531, i64 52}
!1145 = !DILocation(line: 1083, column: 23, scope: !534, atomGroup: 57, atomRank: 2)
!1146 = !DILocation(line: 1083, column: 8, scope: !534)
!1147 = !DILocation(line: 1083, column: 21, scope: !534, atomGroup: 57, atomRank: 1)
!1148 = !DILocation(line: 1084, column: 23, scope: !534, atomGroup: 58, atomRank: 2)
!1149 = !DILocation(line: 1084, column: 8, scope: !534)
!1150 = !DILocation(line: 1084, column: 21, scope: !534, atomGroup: 58, atomRank: 1)
!1151 = !{!979, !531, i64 72}
!1152 = !DILocation(line: 1085, column: 8, scope: !534)
!1153 = !DILocation(line: 1085, column: 21, scope: !534, atomGroup: 59, atomRank: 1)
!1154 = !{!979, !987, i64 33176}
!1155 = !DILocation(line: 1087, column: 20, scope: !534)
!1156 = !DILocation(line: 1087, column: 31, scope: !534)
!1157 = !{!1158, !1159, i64 8}
!1158 = !{!"SwsFilter", !1159, i64 0, !1159, i64 8, !1159, i64 16, !1159, i64 24}
!1159 = !{!"p1 _ZTS9SwsVector", !970, i64 0}
!1160 = !DILocation(line: 1087, column: 20, scope: !534, atomGroup: 61, atomRank: 2)
!1161 = !DILocation(line: 1087, column: 36, scope: !534, atomGroup: 61, atomRank: 1)
!1162 = !DILocation(line: 1087, column: 56, scope: !534)
!1163 = !{!1164, !531, i64 8}
!1164 = !{!"SwsVector", !1165, i64 0, !531, i64 8}
!1165 = !{!"p1 double", !970, i64 0}
!1166 = !DILocation(line: 1087, column: 63, scope: !534, atomGroup: 62, atomRank: 2)
!1167 = !DILocation(line: 1087, column: 68, scope: !534, atomGroup: 62, atomRank: 1)
!1168 = !DILocation(line: 1088, column: 20, scope: !534)
!1169 = !DILocation(line: 1091, column: 20, scope: !534)
!1170 = !DILocation(line: 1091, column: 31, scope: !534)
!1171 = !{!1158, !1159, i64 0}
!1172 = !DILocation(line: 1091, column: 20, scope: !534, atomGroup: 69, atomRank: 2)
!1173 = !DILocation(line: 1091, column: 36, scope: !534, atomGroup: 69, atomRank: 1)
!1174 = !DILocation(line: 1091, column: 56, scope: !534)
!1175 = !DILocation(line: 1091, column: 63, scope: !534, atomGroup: 70, atomRank: 2)
!1176 = !DILocation(line: 1091, column: 68, scope: !534, atomGroup: 70, atomRank: 1)
!1177 = !DILocation(line: 1092, column: 20, scope: !534)
!1178 = !DILocation(line: 1096, column: 53, scope: !534)
!1179 = !DILocation(line: 1096, column: 75, scope: !534)
!1180 = !DILocation(line: 1096, column: 5, scope: !534)
!1181 = !DILocation(line: 1097, column: 53, scope: !534)
!1182 = !DILocation(line: 1097, column: 75, scope: !534)
!1183 = !DILocation(line: 1097, column: 5, scope: !534)
!1184 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 76, atomRank: 2)
!1185 = distinct !DILexicalBlock(scope: !534, file: !2, line: 1099, column: 9)
!1186 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 696, atomRank: 2)
!1187 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 76, atomRank: 1)
!1188 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 697, atomRank: 2)
!1189 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 698, atomRank: 2)
!1190 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 699, atomRank: 2)
!1191 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 700, atomRank: 2)
!1192 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 701, atomRank: 2)
!1193 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 702, atomRank: 2)
!1194 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 703, atomRank: 2)
!1195 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 704, atomRank: 2)
!1196 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 705, atomRank: 2)
!1197 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 706, atomRank: 2)
!1198 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 707, atomRank: 2)
!1199 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 708, atomRank: 2)
!1200 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 709, atomRank: 2)
!1201 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 710, atomRank: 2)
!1202 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 711, atomRank: 2)
!1203 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 712, atomRank: 2)
!1204 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 713, atomRank: 2)
!1205 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 714, atomRank: 2)
!1206 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 715, atomRank: 2)
!1207 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 716, atomRank: 2)
!1208 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 717, atomRank: 2)
!1209 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 718, atomRank: 2)
!1210 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 719, atomRank: 2)
!1211 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 720, atomRank: 2)
!1212 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 721, atomRank: 2)
!1213 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 722, atomRank: 2)
!1214 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 723, atomRank: 2)
!1215 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 724, atomRank: 2)
!1216 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 725, atomRank: 2)
!1217 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 726, atomRank: 2)
!1218 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 727, atomRank: 2)
!1219 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 728, atomRank: 2)
!1220 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 729, atomRank: 2)
!1221 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 730, atomRank: 2)
!1222 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 731, atomRank: 2)
!1223 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 732, atomRank: 2)
!1224 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 733, atomRank: 2)
!1225 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 734, atomRank: 2)
!1226 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 735, atomRank: 2)
!1227 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 736, atomRank: 2)
!1228 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 737, atomRank: 2)
!1229 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 738, atomRank: 2)
!1230 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 739, atomRank: 2)
!1231 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 740, atomRank: 2)
!1232 = !DILocation(line: 1099, column: 9, scope: !1185)
!1233 = !DILocation(line: 1099, column: 9, scope: !1185, atomGroup: 124, atomRank: 2)
!1234 = !DILocation(line: 1099, column: 29, scope: !1185, atomGroup: 124, atomRank: 1)
!1235 = !DILocation(line: 1099, column: 39, scope: !1185)
!1236 = !DILocation(line: 1099, column: 39, scope: !1185, atomGroup: 125, atomRank: 2)
!1237 = !DILocation(line: 1099, column: 29, scope: !1185, atomGroup: 125, atomRank: 1)
!1238 = !DILocation(line: 1100, column: 17, scope: !1239)
!1239 = distinct !DILexicalBlock(scope: !1240, file: !2, line: 1100, column: 13)
!1240 = distinct !DILexicalBlock(scope: !1185, file: !2, line: 1099, column: 61)
!1241 = !DILocation(line: 1100, column: 17, scope: !1239, atomGroup: 126, atomRank: 2)
!1242 = !DILocation(line: 1100, column: 17, scope: !1239, atomGroup: 126, atomRank: 1)
!1243 = !DILocation(line: 1101, column: 13, scope: !1244)
!1244 = distinct !DILexicalBlock(scope: !1239, file: !2, line: 1100, column: 21)
!1245 = !DILocation(line: 1102, column: 19, scope: !1244, atomGroup: 127, atomRank: 2)
!1246 = !DILocation(line: 1103, column: 22, scope: !1244, atomGroup: 128, atomRank: 1)
!1247 = !DILocation(line: 1104, column: 9, scope: !1244)
!1248 = !DILocation(line: 1106, column: 19, scope: !1249)
!1249 = distinct !DILexicalBlock(scope: !1240, file: !2, line: 1106, column: 16)
!1250 = !{!979, !531, i64 84}
!1251 = !DILocation(line: 1106, column: 36, scope: !1249, atomGroup: 129, atomRank: 2)
!1252 = !DILocation(line: 1107, column: 13, scope: !1249, atomGroup: 129, atomRank: 1)
!1253 = !DILocation(line: 1107, column: 19, scope: !1249)
!1254 = !{!979, !531, i64 88}
!1255 = !DILocation(line: 1107, column: 36, scope: !1249, atomGroup: 130, atomRank: 2)
!1256 = !DILocation(line: 1108, column: 13, scope: !1249, atomGroup: 130, atomRank: 1)
!1257 = !DILocation(line: 1108, column: 19, scope: !1249)
!1258 = !{!979, !531, i64 37628}
!1259 = !DILocation(line: 1108, column: 26, scope: !1249, atomGroup: 131, atomRank: 2)
!1260 = !DILocation(line: 1109, column: 13, scope: !1249, atomGroup: 131, atomRank: 1)
!1261 = !DILocation(line: 1109, column: 21, scope: !1249)
!1262 = !DILocation(line: 1109, column: 27, scope: !1249)
!1263 = !DILocation(line: 1109, column: 27, scope: !1249, atomGroup: 132, atomRank: 2)
!1264 = !DILocation(line: 1109, column: 13, scope: !1249, atomGroup: 132, atomRank: 1)
!1265 = !DILocation(line: 1111, column: 13, scope: !1266)
!1266 = distinct !DILexicalBlock(scope: !1249, file: !2, line: 1110, column: 11)
!1267 = !DILocation(line: 1112, column: 19, scope: !1266, atomGroup: 133, atomRank: 2)
!1268 = !DILocation(line: 1113, column: 22, scope: !1266, atomGroup: 134, atomRank: 1)
!1269 = !DILocation(line: 1114, column: 9, scope: !1266)
!1270 = !DILocation(line: 1117, column: 12, scope: !1271)
!1271 = distinct !DILexicalBlock(scope: !534, file: !2, line: 1117, column: 9)
!1272 = !DILocation(line: 1117, column: 19, scope: !1271, atomGroup: 135, atomRank: 2)
!1273 = !DILocation(line: 1117, column: 19, scope: !1271, atomGroup: 135, atomRank: 1)
!1274 = !DILocation(line: 1118, column: 19, scope: !1275)
!1275 = distinct !DILexicalBlock(scope: !1276, file: !2, line: 1118, column: 13)
!1276 = distinct !DILexicalBlock(scope: !1271, file: !2, line: 1117, column: 39)
!1277 = !DILocation(line: 1118, column: 19, scope: !1275, atomGroup: 136, atomRank: 2)
!1278 = !DILocation(line: 1118, column: 19, scope: !1275, atomGroup: 136, atomRank: 1)
!1279 = !DILocation(line: 1119, column: 23, scope: !1275, atomGroup: 137, atomRank: 1)
!1280 = !DILocation(line: 1119, column: 13, scope: !1275)
!1281 = !DILocation(line: 1122, column: 42, scope: !1282, atomGroup: 138, atomRank: 1)
!1282 = distinct !DILexicalBlock(scope: !534, file: !2, line: 1122, column: 8)
!1283 = !DILocation(line: 1126, column: 16, scope: !1284)
!1284 = distinct !DILexicalBlock(scope: !1285, file: !2, line: 1126, column: 13)
!1285 = distinct !DILexicalBlock(scope: !1282, file: !2, line: 1125, column: 38)
!1286 = !DILocation(line: 1126, column: 23, scope: !1284, atomGroup: 142, atomRank: 2)
!1287 = !DILocation(line: 1126, column: 23, scope: !1284, atomGroup: 142, atomRank: 1)
!1288 = !DILocation(line: 1127, column: 32, scope: !1284)
!1289 = !DILocation(line: 1127, column: 25, scope: !1284)
!1290 = !DILocation(line: 1127, column: 25, scope: !1284, atomGroup: 143, atomRank: 2)
!1291 = !DILocation(line: 1127, column: 23, scope: !1284, atomGroup: 143, atomRank: 1)
!1292 = !DILocation(line: 1127, column: 13, scope: !1284)
!1293 = !DILocation(line: 1128, column: 21, scope: !1294)
!1294 = distinct !DILexicalBlock(scope: !1285, file: !2, line: 1128, column: 13)
!1295 = !DILocation(line: 1128, column: 21, scope: !1294, atomGroup: 144, atomRank: 2)
!1296 = !DILocation(line: 1128, column: 13, scope: !1294, atomGroup: 144, atomRank: 1)
!1297 = !DILocation(line: 1129, column: 20, scope: !1298)
!1298 = distinct !DILexicalBlock(scope: !1299, file: !2, line: 1129, column: 17)
!1299 = distinct !DILexicalBlock(scope: !1294, file: !2, line: 1128, column: 44)
!1300 = !DILocation(line: 1129, column: 27, scope: !1298, atomGroup: 145, atomRank: 2)
!1301 = !DILocation(line: 1129, column: 44, scope: !1298, atomGroup: 145, atomRank: 1)
!1302 = !DILocation(line: 1129, column: 57, scope: !1298, atomGroup: 146, atomRank: 2)
!1303 = !DILocation(line: 1129, column: 80, scope: !1298, atomGroup: 146, atomRank: 1)
!1304 = !DILocation(line: 1129, column: 93, scope: !1298, atomGroup: 147, atomRank: 2)
!1305 = !DILocation(line: 1129, column: 80, scope: !1298, atomGroup: 147, atomRank: 1)
!1306 = !DILocation(line: 1132, column: 21, scope: !1307)
!1307 = distinct !DILexicalBlock(scope: !1298, file: !2, line: 1129, column: 117)
!1308 = !DILocation(line: 1130, column: 17, scope: !1307)
!1309 = !DILocation(line: 1133, column: 25, scope: !1307, atomGroup: 148, atomRank: 2)
!1310 = !DILocation(line: 1134, column: 26, scope: !1307, atomGroup: 149, atomRank: 1)
!1311 = !DILocation(line: 1135, column: 13, scope: !1307)
!1312 = !DILocation(line: 1137, column: 19, scope: !1313)
!1313 = distinct !DILexicalBlock(scope: !1285, file: !2, line: 1137, column: 13)
!1314 = !DILocation(line: 1137, column: 19, scope: !1313, atomGroup: 150, atomRank: 2)
!1315 = !DILocation(line: 1137, column: 19, scope: !1313, atomGroup: 150, atomRank: 1)
!1316 = !DILocation(line: 1138, column: 20, scope: !1317)
!1317 = distinct !DILexicalBlock(scope: !1318, file: !2, line: 1138, column: 17)
!1318 = distinct !DILexicalBlock(scope: !1313, file: !2, line: 1137, column: 41)
!1319 = !DILocation(line: 1138, column: 27, scope: !1317, atomGroup: 151, atomRank: 2)
!1320 = !DILocation(line: 1138, column: 27, scope: !1317, atomGroup: 151, atomRank: 1)
!1321 = !DILocation(line: 1141, column: 21, scope: !1322)
!1322 = distinct !DILexicalBlock(scope: !1317, file: !2, line: 1138, column: 48)
!1323 = !DILocation(line: 1139, column: 17, scope: !1322)
!1324 = !DILocation(line: 1142, column: 27, scope: !1322, atomGroup: 152, atomRank: 1)
!1325 = !DILocation(line: 1143, column: 13, scope: !1322)
!1326 = !DILocation(line: 1002, column: 15, scope: !534, atomGroup: 11, atomRank: 1)
!1327 = !DILocation(line: 1146, column: 9, scope: !1328)
!1328 = distinct !DILexicalBlock(scope: !534, file: !2, line: 1146, column: 9)
!1329 = !DILocation(line: 1146, column: 9, scope: !1328, atomGroup: 153, atomRank: 2)
!1330 = !DILocation(line: 1146, column: 9, scope: !1328, atomGroup: 153, atomRank: 1)
!1331 = !DILocation(line: 1147, column: 21, scope: !1332)
!1332 = distinct !DILexicalBlock(scope: !1333, file: !2, line: 1147, column: 13)
!1333 = distinct !DILexicalBlock(scope: !1328, file: !2, line: 1146, column: 33)
!1334 = !DILocation(line: 1147, column: 21, scope: !1332, atomGroup: 154, atomRank: 2)
!1335 = !DILocation(line: 1147, column: 13, scope: !1332, atomGroup: 154, atomRank: 1)
!1336 = !DILocation(line: 1150, column: 20, scope: !1337)
!1337 = distinct !DILexicalBlock(scope: !1332, file: !2, line: 1147, column: 44)
!1338 = !DILocation(line: 1148, column: 13, scope: !1337)
!1339 = !DILocation(line: 1151, column: 21, scope: !1337, atomGroup: 155, atomRank: 2)
!1340 = !DILocation(line: 1152, column: 22, scope: !1337, atomGroup: 156, atomRank: 1)
!1341 = !DILocation(line: 1153, column: 9, scope: !1337)
!1342 = !DILocation(line: 1158, column: 15, scope: !1343)
!1343 = distinct !DILexicalBlock(scope: !534, file: !2, line: 1158, column: 9)
!1344 = !DILocation(line: 1158, column: 15, scope: !1343, atomGroup: 157, atomRank: 2)
!1345 = !DILocation(line: 1158, column: 36, scope: !1343, atomGroup: 157, atomRank: 1)
!1346 = !DILocation(line: 1159, column: 9, scope: !1343, atomGroup: 158, atomRank: 1)
!1347 = !DILocation(line: 1159, column: 9, scope: !1343)
!1348 = !DILocation(line: 1159, column: 9, scope: !1343, atomGroup: 206, atomRank: 2)
!1349 = !DILocation(line: 1159, column: 36, scope: !1343, atomGroup: 206, atomRank: 1)
!1350 = !DILocation(line: 1160, column: 10, scope: !1343)
!1351 = !DILocation(line: 1160, column: 10, scope: !1343, atomGroup: 207, atomRank: 2)
!1352 = !DILocation(line: 1160, column: 36, scope: !1343, atomGroup: 207, atomRank: 1)
!1353 = !DILocation(line: 1182, column: 16, scope: !1354)
!1354 = distinct !DILexicalBlock(scope: !1343, file: !2, line: 1179, column: 7)
!1355 = !DILocation(line: 1180, column: 9, scope: !1354)
!1356 = !DILocation(line: 1183, column: 17, scope: !1354, atomGroup: 226, atomRank: 2)
!1357 = !DILocation(line: 1184, column: 18, scope: !1354, atomGroup: 227, atomRank: 1)
!1358 = !DILocation(line: 1185, column: 5, scope: !1354)
!1359 = !DILocation(line: 1186, column: 9, scope: !1360, atomGroup: 228, atomRank: 1)
!1360 = distinct !DILexicalBlock(scope: !534, file: !2, line: 1186, column: 9)
!1361 = !DILocation(line: 1186, column: 9, scope: !1360)
!1362 = !DILocation(line: 1186, column: 9, scope: !1360, atomGroup: 276, atomRank: 2)
!1363 = !DILocation(line: 1186, column: 29, scope: !1360, atomGroup: 276, atomRank: 1)
!1364 = !DILocation(line: 1186, column: 40, scope: !1360)
!1365 = !DILocation(line: 1186, column: 40, scope: !1360, atomGroup: 277, atomRank: 2)
!1366 = !DILocation(line: 1186, column: 29, scope: !1360, atomGroup: 277, atomRank: 1)
!1367 = !DILocation(line: 1187, column: 29, scope: !1360, atomGroup: 278, atomRank: 1)
!1368 = !{!979, !531, i64 92}
!1369 = !DILocation(line: 1187, column: 9, scope: !1360)
!1370 = !DILocation(line: 1190, column: 35, scope: !534)
!1371 = !DILocation(line: 1190, column: 62, scope: !534, atomGroup: 279, atomRank: 2)
!1372 = !DILocation(line: 1190, column: 8, scope: !534)
!1373 = !DILocation(line: 1190, column: 26, scope: !534, atomGroup: 279, atomRank: 1)
!1374 = !{!979, !531, i64 100}
!1375 = !DILocation(line: 1192, column: 25, scope: !534)
!1376 = !DILocation(line: 1192, column: 25, scope: !534, atomGroup: 280, atomRank: 2)
!1377 = !DILocation(line: 1192, column: 25, scope: !534, atomGroup: 280, atomRank: 1)
!1378 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 281, atomRank: 2)
!1379 = distinct !DILexicalBlock(scope: !534, file: !2, line: 1196, column: 9)
!1380 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 837, atomRank: 2)
!1381 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 281, atomRank: 1)
!1382 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 838, atomRank: 2)
!1383 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 839, atomRank: 2)
!1384 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 840, atomRank: 2)
!1385 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 841, atomRank: 2)
!1386 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 842, atomRank: 2)
!1387 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 843, atomRank: 2)
!1388 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 844, atomRank: 2)
!1389 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 845, atomRank: 2)
!1390 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 846, atomRank: 2)
!1391 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 847, atomRank: 2)
!1392 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 848, atomRank: 2)
!1393 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 849, atomRank: 2)
!1394 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 850, atomRank: 2)
!1395 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 851, atomRank: 2)
!1396 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 852, atomRank: 2)
!1397 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 853, atomRank: 2)
!1398 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 854, atomRank: 2)
!1399 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 855, atomRank: 2)
!1400 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 856, atomRank: 2)
!1401 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 857, atomRank: 2)
!1402 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 858, atomRank: 2)
!1403 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 859, atomRank: 2)
!1404 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 860, atomRank: 2)
!1405 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 861, atomRank: 2)
!1406 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 862, atomRank: 2)
!1407 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 863, atomRank: 2)
!1408 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 864, atomRank: 2)
!1409 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 865, atomRank: 2)
!1410 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 866, atomRank: 2)
!1411 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 867, atomRank: 2)
!1412 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 868, atomRank: 2)
!1413 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 869, atomRank: 2)
!1414 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 870, atomRank: 2)
!1415 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 871, atomRank: 2)
!1416 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 872, atomRank: 2)
!1417 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 873, atomRank: 2)
!1418 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 874, atomRank: 2)
!1419 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 875, atomRank: 2)
!1420 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 876, atomRank: 2)
!1421 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 877, atomRank: 2)
!1422 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 878, atomRank: 2)
!1423 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 879, atomRank: 2)
!1424 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 880, atomRank: 2)
!1425 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 881, atomRank: 2)
!1426 = !DILocation(line: 1196, column: 9, scope: !1379)
!1427 = !DILocation(line: 1196, column: 9, scope: !1379, atomGroup: 329, atomRank: 2)
!1428 = !DILocation(line: 1196, column: 29, scope: !1379, atomGroup: 329, atomRank: 1)
!1429 = !DILocation(line: 1196, column: 40, scope: !1379)
!1430 = !DILocation(line: 1196, column: 40, scope: !1379, atomGroup: 330, atomRank: 2)
!1431 = !DILocation(line: 1196, column: 64, scope: !1379, atomGroup: 330, atomRank: 1)
!1432 = !DILocation(line: 1205, column: 22, scope: !1379)
!1433 = !DILocation(line: 1205, column: 16, scope: !1379)
!1434 = !DILocation(line: 1205, column: 49, scope: !1379)
!1435 = !DILocation(line: 1205, column: 40, scope: !1379, atomGroup: 347, atomRank: 2)
!1436 = !DILocation(line: 1205, column: 55, scope: !1379, atomGroup: 347, atomRank: 1)
!1437 = !DILocation(line: 1206, column: 17, scope: !1379)
!1438 = !DILocation(line: 1206, column: 17, scope: !1379, atomGroup: 348, atomRank: 2)
!1439 = !DILocation(line: 1204, column: 79, scope: !1379, atomGroup: 348, atomRank: 1)
!1440 = !DILocation(line: 1207, column: 29, scope: !1379, atomGroup: 349, atomRank: 1)
!1441 = !DILocation(line: 1207, column: 9, scope: !1379)
!1442 = !DILocation(line: 1210, column: 42, scope: !534)
!1443 = !DILocation(line: 1210, column: 18, scope: !534, atomGroup: 351, atomRank: 1)
!1444 = !DILocation(line: 1210, column: 18, scope: !534)
!1445 = !DILocation(line: 1210, column: 8, scope: !534)
!1446 = !DILocation(line: 1210, column: 16, scope: !534, atomGroup: 350, atomRank: 1)
!1447 = !{!979, !531, i64 28}
!1448 = !DILocation(line: 1211, column: 42, scope: !534)
!1449 = !DILocation(line: 1211, column: 18, scope: !534, atomGroup: 353, atomRank: 1)
!1450 = !DILocation(line: 1211, column: 18, scope: !534)
!1451 = !DILocation(line: 1211, column: 8, scope: !534)
!1452 = !DILocation(line: 1211, column: 16, scope: !534, atomGroup: 352, atomRank: 1)
!1453 = !{!979, !531, i64 32}
!1454 = !DILocation(line: 1212, column: 42, scope: !534)
!1455 = !DILocation(line: 1212, column: 18, scope: !534, atomGroup: 355, atomRank: 1)
!1456 = !DILocation(line: 1212, column: 18, scope: !534)
!1457 = !DILocation(line: 1212, column: 8, scope: !534)
!1458 = !DILocation(line: 1212, column: 16, scope: !534, atomGroup: 354, atomRank: 1)
!1459 = !{!979, !531, i64 36}
!1460 = !DILocation(line: 1213, column: 42, scope: !534)
!1461 = !{!979, !531, i64 96}
!1462 = !DILocation(line: 1213, column: 18, scope: !534, atomGroup: 357, atomRank: 1)
!1463 = !DILocation(line: 1213, column: 18, scope: !534)
!1464 = !DILocation(line: 1213, column: 8, scope: !534)
!1465 = !DILocation(line: 1213, column: 16, scope: !534, atomGroup: 356, atomRank: 1)
!1466 = !{!979, !531, i64 40}
!1467 = !DILocation(line: 1215, column: 59, scope: !1468)
!1468 = distinct !DILexicalBlock(scope: !534, file: !2, line: 1215, column: 5)
!1469 = !DILocation(line: 1215, column: 47, scope: !1468)
!1470 = !DILocation(line: 1215, column: 70, scope: !1468)
!1471 = !DILocation(line: 1215, column: 5, scope: !1468, atomGroup: 358, atomRank: 2)
!1472 = !DILocation(line: 1215, column: 29, scope: !1468)
!1473 = !DILocation(line: 1215, column: 5, scope: !1468, atomGroup: 358, atomRank: 1)
!1474 = !{!979, !985, i64 2384}
!1475 = !DILocation(line: 1215, column: 5, scope: !1476, atomGroup: 359, atomRank: 2)
!1476 = distinct !DILexicalBlock(scope: !1468, file: !2, line: 1215, column: 5)
!1477 = !DILocation(line: 1215, column: 5, scope: !1476, atomGroup: 359, atomRank: 1)
!1478 = !DILocation(line: 1215, column: 5, scope: !1476, atomGroup: 360, atomRank: 1)
!1479 = !DILocation(line: 1215, column: 5, scope: !1480)
!1480 = distinct !DILexicalBlock(scope: !1476, file: !2, line: 1215, column: 5)
!1481 = !DILocation(line: 1215, column: 5, scope: !1480, atomGroup: 361, atomRank: 1)
!1482 = !DILocation(line: 1217, column: 31, scope: !534)
!1483 = !DILocation(line: 1217, column: 39, scope: !534)
!1484 = !DILocation(line: 1217, column: 21, scope: !534)
!1485 = !DILocation(line: 1217, column: 19, scope: !534, atomGroup: 362, atomRank: 2)
!1486 = !DILocation(line: 1217, column: 8, scope: !534)
!1487 = !DILocation(line: 1217, column: 15, scope: !534, atomGroup: 362, atomRank: 1)
!1488 = !{!979, !531, i64 80}
!1489 = !DILocation(line: 1218, column: 19, scope: !1490, atomGroup: 363, atomRank: 2)
!1490 = distinct !DILexicalBlock(scope: !534, file: !2, line: 1218, column: 9)
!1491 = !DILocation(line: 1218, column: 19, scope: !1490, atomGroup: 363, atomRank: 1)
!1492 = !DILocation(line: 1219, column: 19, scope: !1490, atomGroup: 364, atomRank: 1)
!1493 = !DILocation(line: 1219, column: 9, scope: !1490)
!1494 = !DILocation(line: 1220, column: 31, scope: !534)
!1495 = !DILocation(line: 1220, column: 39, scope: !534)
!1496 = !DILocation(line: 1220, column: 21, scope: !534)
!1497 = !DILocation(line: 1220, column: 19, scope: !534, atomGroup: 365, atomRank: 2)
!1498 = !DILocation(line: 1220, column: 8, scope: !534)
!1499 = !DILocation(line: 1220, column: 15, scope: !534, atomGroup: 365, atomRank: 1)
!1500 = !{!979, !531, i64 76}
!1501 = !DILocation(line: 1221, column: 19, scope: !1502, atomGroup: 366, atomRank: 2)
!1502 = distinct !DILexicalBlock(scope: !534, file: !2, line: 1221, column: 9)
!1503 = !DILocation(line: 1221, column: 19, scope: !1502, atomGroup: 366, atomRank: 1)
!1504 = !DILocation(line: 1222, column: 19, scope: !1502, atomGroup: 367, atomRank: 1)
!1505 = !DILocation(line: 1222, column: 9, scope: !1502)
!1506 = !DILocation(line: 1223, column: 9, scope: !1507, atomGroup: 368, atomRank: 1)
!1507 = distinct !DILexicalBlock(scope: !534, file: !2, line: 1223, column: 9)
!1508 = !DILocation(line: 1223, column: 9, scope: !1507)
!1509 = !DILocation(line: 1223, column: 9, scope: !1507, atomGroup: 416, atomRank: 2)
!1510 = !DILocation(line: 1223, column: 29, scope: !1507, atomGroup: 416, atomRank: 1)
!1511 = !DILocation(line: 1224, column: 19, scope: !1507, atomGroup: 418, atomRank: 1)
!1512 = !DILocation(line: 1224, column: 9, scope: !1507)
!1513 = !DILocation(line: 1225, column: 12, scope: !1514)
!1514 = distinct !DILexicalBlock(scope: !534, file: !2, line: 1225, column: 9)
!1515 = !DILocation(line: 1225, column: 19, scope: !1514, atomGroup: 419, atomRank: 2)
!1516 = !DILocation(line: 1225, column: 19, scope: !1514, atomGroup: 419, atomRank: 1)
!1517 = !DILocation(line: 1226, column: 20, scope: !1514, atomGroup: 420, atomRank: 2)
!1518 = !DILocation(line: 1226, column: 9, scope: !1514)
!1519 = !DILocation(line: 1242, column: 12, scope: !1520)
!1520 = distinct !DILexicalBlock(scope: !534, file: !2, line: 1228, column: 9)
!1521 = !DILocation(line: 1242, column: 28, scope: !1520, atomGroup: 421, atomRank: 1)
!1522 = !{!979, !531, i64 2496}
!1523 = !DILocation(line: 1244, column: 32, scope: !534)
!1524 = !DILocation(line: 1244, column: 20, scope: !534)
!1525 = !DILocation(line: 1244, column: 40, scope: !534)
!1526 = !DILocation(line: 1244, column: 53, scope: !534)
!1527 = !DILocation(line: 1244, column: 61, scope: !534)
!1528 = !DILocation(line: 1244, column: 49, scope: !534)
!1529 = !DILocation(line: 1244, column: 47, scope: !534)
!1530 = !DILocation(line: 1244, column: 70, scope: !534)
!1531 = !DILocation(line: 1244, column: 68, scope: !534, atomGroup: 422, atomRank: 3)
!1532 = !DILocation(line: 1244, column: 18, scope: !534, atomGroup: 422, atomRank: 2)
!1533 = !DILocation(line: 1244, column: 8, scope: !534)
!1534 = !DILocation(line: 1244, column: 16, scope: !534, atomGroup: 422, atomRank: 1)
!1535 = !{!979, !531, i64 48}
!1536 = !DILocation(line: 1245, column: 32, scope: !534)
!1537 = !DILocation(line: 1245, column: 20, scope: !534)
!1538 = !DILocation(line: 1245, column: 40, scope: !534)
!1539 = !DILocation(line: 1245, column: 53, scope: !534)
!1540 = !DILocation(line: 1245, column: 61, scope: !534)
!1541 = !DILocation(line: 1245, column: 49, scope: !534)
!1542 = !DILocation(line: 1245, column: 47, scope: !534)
!1543 = !DILocation(line: 1245, column: 70, scope: !534)
!1544 = !DILocation(line: 1245, column: 68, scope: !534, atomGroup: 423, atomRank: 3)
!1545 = !DILocation(line: 1245, column: 18, scope: !534, atomGroup: 423, atomRank: 2)
!1546 = !DILocation(line: 1245, column: 8, scope: !534)
!1547 = !DILocation(line: 1245, column: 16, scope: !534, atomGroup: 423, atomRank: 1)
!1548 = !{!979, !531, i64 56}
!1549 = !DILocation(line: 1254, column: 15, scope: !1550)
!1550 = distinct !DILexicalBlock(scope: !534, file: !2, line: 1254, column: 9)
!1551 = !DILocation(line: 1254, column: 15, scope: !1550, atomGroup: 424, atomRank: 2)
!1552 = !DILocation(line: 1254, column: 15, scope: !1550, atomGroup: 424, atomRank: 1)
!1553 = !DILocation(line: 1255, column: 16, scope: !1554)
!1554 = distinct !DILexicalBlock(scope: !1555, file: !2, line: 1255, column: 13)
!1555 = distinct !DILexicalBlock(scope: !1550, file: !2, line: 1254, column: 36)
!1556 = !DILocation(line: 1255, column: 13, scope: !1554, atomGroup: 425, atomRank: 2)
!1557 = !DILocation(line: 1255, column: 13, scope: !1554, atomGroup: 425, atomRank: 1)
!1558 = !DILocation(line: 1256, column: 24, scope: !1559)
!1559 = distinct !DILexicalBlock(scope: !1554, file: !2, line: 1255, column: 33)
!1560 = !DILocation(line: 1256, column: 24, scope: !1559, atomGroup: 426, atomRank: 2)
!1561 = !DILocation(line: 1256, column: 24, scope: !1559, atomGroup: 426, atomRank: 1)
!1562 = !DILocation(line: 1257, column: 24, scope: !1559)
!1563 = !DILocation(line: 1257, column: 24, scope: !1559, atomGroup: 427, atomRank: 2)
!1564 = !DILocation(line: 1257, column: 24, scope: !1559, atomGroup: 427, atomRank: 1)
!1565 = !DILocation(line: 1258, column: 9, scope: !1559)
!1566 = !DILocation(line: 1267, column: 8, scope: !534)
!1567 = !DILocation(line: 1267, column: 20, scope: !534, atomGroup: 428, atomRank: 1)
!1568 = !{!979, !981, i64 248}
!1569 = !DILocation(line: 1271, column: 19, scope: !940, atomGroup: 430, atomRank: 1)
!1570 = !DILocation(line: 1271, column: 25, scope: !940)
!1571 = !{!979, !531, i64 256}
!1572 = !DILocation(line: 1271, column: 22, scope: !940, atomGroup: 431, atomRank: 2)
!1573 = !DILocation(line: 1271, column: 36, scope: !940, atomGroup: 431, atomRank: 1)
!1574 = !DILocation(line: 1271, column: 50, scope: !940, atomGroup: 432, atomRank: 2)
!1575 = !DILocation(line: 1271, column: 60, scope: !940, atomGroup: 432, atomRank: 1)
!1576 = !DILocation(line: 1271, column: 73, scope: !940, atomGroup: 433, atomRank: 2)
!1577 = !DILocation(line: 1271, column: 36, scope: !940, atomGroup: 433, atomRank: 1)
!1578 = !DILocation(line: 1273, column: 12, scope: !939)
!1579 = !DILocation(line: 1273, column: 32, scope: !939, atomGroup: 434, atomRank: 1)
!1580 = !{!1581, !1581, i64 0}
!1581 = !{!"p1 _ZTS10SwsContext", !970, i64 0}
!1582 = !DILocation(line: 1275, column: 33, scope: !939)
!1583 = !DILocation(line: 1275, column: 50, scope: !939)
!1584 = !DILocation(line: 1275, column: 15, scope: !939, atomGroup: 435, atomRank: 2)
!1585 = !DILocation(line: 1277, column: 17, scope: !1586, atomGroup: 436, atomRank: 2)
!1586 = distinct !DILexicalBlock(scope: !939, file: !2, line: 1277, column: 13)
!1587 = !DILocation(line: 1277, column: 17, scope: !1586, atomGroup: 436, atomRank: 1)
!1588 = !DILocation(line: 1278, column: 13, scope: !1586, atomGroup: 437, atomRank: 1)
!1589 = !DILocation(line: 1282, column: 71, scope: !939)
!1590 = !DILocation(line: 1280, column: 34, scope: !939, atomGroup: 438, atomRank: 2)
!1591 = !DILocation(line: 1280, column: 32, scope: !939, atomGroup: 438, atomRank: 1)
!1592 = !DILocation(line: 1283, column: 14, scope: !1593, atomGroup: 439, atomRank: 2)
!1593 = distinct !DILexicalBlock(scope: !939, file: !2, line: 1283, column: 13)
!1594 = !DILocation(line: 1283, column: 13, scope: !1593, atomGroup: 439, atomRank: 1)
!1595 = !DILocation(line: 1284, column: 13, scope: !1596, atomGroup: 440, atomRank: 1)
!1596 = distinct !DILexicalBlock(scope: !1593, file: !2, line: 1283, column: 38)
!1597 = !DILocation(line: 1289, column: 56, scope: !939)
!1598 = !DILocation(line: 1289, column: 67, scope: !939)
!1599 = !DILocation(line: 1287, column: 34, scope: !939, atomGroup: 441, atomRank: 2)
!1600 = !DILocation(line: 1287, column: 9, scope: !939)
!1601 = !DILocation(line: 1287, column: 32, scope: !939, atomGroup: 441, atomRank: 1)
!1602 = !DILocation(line: 1291, column: 14, scope: !1603, atomGroup: 442, atomRank: 2)
!1603 = distinct !DILexicalBlock(scope: !939, file: !2, line: 1291, column: 13)
!1604 = !DILocation(line: 1291, column: 13, scope: !1603, atomGroup: 442, atomRank: 1)
!1605 = !DILocation(line: 1292, column: 13, scope: !1603, atomGroup: 443, atomRank: 1)
!1606 = !DILocation(line: 0, scope: !939)
!1607 = !DILocation(line: 1295, column: 13, scope: !939)
!1608 = !DILocation(line: 1295, column: 31, scope: !939, atomGroup: 445, atomRank: 1)
!1609 = !{!979, !531, i64 260}
!1610 = !DILocation(line: 1296, column: 48, scope: !939)
!1611 = !DILocation(line: 1296, column: 25, scope: !939, atomGroup: 446, atomRank: 2)
!1612 = !DILocation(line: 1296, column: 13, scope: !939)
!1613 = !DILocation(line: 1296, column: 23, scope: !939, atomGroup: 446, atomRank: 1)
!1614 = !{!979, !982, i64 264}
!1615 = !DILocation(line: 1297, column: 48, scope: !939)
!1616 = !DILocation(line: 1297, column: 44, scope: !939)
!1617 = !DILocation(line: 1297, column: 25, scope: !939, atomGroup: 447, atomRank: 2)
!1618 = !DILocation(line: 1297, column: 13, scope: !939)
!1619 = !DILocation(line: 1297, column: 23, scope: !939, atomGroup: 447, atomRank: 1)
!1620 = !{!979, !982, i64 272}
!1621 = !DILocation(line: 1298, column: 18, scope: !1622)
!1622 = distinct !DILexicalBlock(scope: !939, file: !2, line: 1298, column: 13)
!1623 = !DILocation(line: 1298, column: 14, scope: !1622, atomGroup: 448, atomRank: 2)
!1624 = !DILocation(line: 1298, column: 24, scope: !1622, atomGroup: 448, atomRank: 1)
!1625 = !DILocation(line: 1298, column: 28, scope: !1622, atomGroup: 449, atomRank: 2)
!1626 = !DILocation(line: 1298, column: 24, scope: !1622, atomGroup: 449, atomRank: 1)
!1627 = !DILocation(line: 1299, column: 13, scope: !1622, atomGroup: 450, atomRank: 1)
!1628 = !DILocation(line: 1301, column: 9, scope: !939)
!1629 = !DILocation(line: 1301, column: 32, scope: !939, atomGroup: 451, atomRank: 1)
!1630 = !DILocation(line: 1302, column: 23, scope: !1631, atomGroup: 452, atomRank: 2)
!1631 = distinct !DILexicalBlock(scope: !939, file: !2, line: 1302, column: 13)
!1632 = !DILocation(line: 1302, column: 23, scope: !1631, atomGroup: 452, atomRank: 1)
!1633 = !DILocation(line: 1303, column: 37, scope: !1634)
!1634 = distinct !DILexicalBlock(scope: !1631, file: !2, line: 1302, column: 34)
!1635 = !DILocation(line: 1303, column: 55, scope: !1634)
!1636 = !DILocation(line: 1303, column: 19, scope: !1634, atomGroup: 453, atomRank: 2)
!1637 = !DILocation(line: 1305, column: 21, scope: !1638, atomGroup: 454, atomRank: 2)
!1638 = distinct !DILexicalBlock(scope: !1634, file: !2, line: 1305, column: 17)
!1639 = !DILocation(line: 1305, column: 21, scope: !1638, atomGroup: 454, atomRank: 1)
!1640 = !DILocation(line: 1306, column: 17, scope: !1638, atomGroup: 455, atomRank: 1)
!1641 = !DILocation(line: 1308, column: 38, scope: !1634, atomGroup: 456, atomRank: 2)
!1642 = !DILocation(line: 1308, column: 36, scope: !1634, atomGroup: 456, atomRank: 1)
!1643 = !DILocation(line: 1311, column: 18, scope: !1644, atomGroup: 457, atomRank: 2)
!1644 = distinct !DILexicalBlock(scope: !1634, file: !2, line: 1311, column: 17)
!1645 = !DILocation(line: 1311, column: 17, scope: !1644, atomGroup: 457, atomRank: 1)
!1646 = !DILocation(line: 1312, column: 17, scope: !1644, atomGroup: 458, atomRank: 1)
!1647 = !DILocation(line: 1314, column: 9, scope: !939, atomGroup: 459, atomRank: 1)
!1648 = !DILocation(line: 1317, column: 9, scope: !945, atomGroup: 460, atomRank: 1)
!1649 = !DILocation(line: 1318, column: 23, scope: !943, atomGroup: 472, atomRank: 1)
!1650 = !DILocation(line: 1319, column: 24, scope: !943, atomGroup: 473, atomRank: 2)
!1651 = !DILocation(line: 1319, column: 44, scope: !943, atomGroup: 473, atomRank: 1)
!1652 = !DILocation(line: 0, scope: !942)
!1653 = !DILocation(line: 1322, column: 37, scope: !942)
!1654 = !DILocation(line: 1322, column: 54, scope: !942)
!1655 = !DILocation(line: 1322, column: 19, scope: !942, atomGroup: 476, atomRank: 2)
!1656 = !DILocation(line: 1324, column: 21, scope: !1657, atomGroup: 477, atomRank: 2)
!1657 = distinct !DILexicalBlock(scope: !942, file: !2, line: 1324, column: 17)
!1658 = !DILocation(line: 1324, column: 21, scope: !1657, atomGroup: 477, atomRank: 1)
!1659 = !DILocation(line: 1325, column: 17, scope: !1657, atomGroup: 478, atomRank: 1)
!1660 = !DILocation(line: 1329, column: 60, scope: !942)
!1661 = !DILocation(line: 1329, column: 80, scope: !942)
!1662 = !DILocation(line: 1327, column: 38, scope: !942, atomGroup: 479, atomRank: 2)
!1663 = !DILocation(line: 1327, column: 16, scope: !942)
!1664 = !DILocation(line: 1327, column: 36, scope: !942, atomGroup: 479, atomRank: 1)
!1665 = !DILocation(line: 1330, column: 18, scope: !1666, atomGroup: 480, atomRank: 2)
!1666 = distinct !DILexicalBlock(scope: !942, file: !2, line: 1330, column: 17)
!1667 = !DILocation(line: 1330, column: 17, scope: !1666, atomGroup: 480, atomRank: 1)
!1668 = !DILocation(line: 1331, column: 17, scope: !1666, atomGroup: 481, atomRank: 1)
!1669 = !DILocation(line: 1335, column: 66, scope: !942)
!1670 = !DILocation(line: 1333, column: 38, scope: !942, atomGroup: 482, atomRank: 2)
!1671 = !DILocation(line: 1333, column: 13, scope: !942)
!1672 = !DILocation(line: 1333, column: 36, scope: !942, atomGroup: 482, atomRank: 1)
!1673 = !DILocation(line: 1336, column: 18, scope: !1674, atomGroup: 483, atomRank: 2)
!1674 = distinct !DILexicalBlock(scope: !942, file: !2, line: 1336, column: 17)
!1675 = !DILocation(line: 1336, column: 17, scope: !1674, atomGroup: 483, atomRank: 1)
!1676 = !DILocation(line: 1337, column: 17, scope: !1674, atomGroup: 484, atomRank: 1)
!1677 = !DILocation(line: 1338, column: 13, scope: !942, atomGroup: 485, atomRank: 1)
!1678 = !DILocation(line: 0, scope: !947)
!1679 = !DILocation(line: 1410, column: 39, scope: !1680)
!1680 = distinct !DILexicalBlock(scope: !947, file: !2, line: 1410, column: 17)
!1681 = !DILocation(line: 1410, column: 55, scope: !1680)
!1682 = !DILocation(line: 1411, column: 32, scope: !1680)
!1683 = !DILocation(line: 1411, column: 51, scope: !1680)
!1684 = !DILocation(line: 1413, column: 35, scope: !1680)
!1685 = !DILocation(line: 1413, column: 35, scope: !1680, atomGroup: 488, atomRank: 2)
!1686 = !DILocation(line: 1413, column: 28, scope: !1680, atomGroup: 488, atomRank: 1)
!1687 = !DILocation(line: 1414, column: 39, scope: !1680)
!1688 = !DILocation(line: 1414, column: 50, scope: !1680)
!1689 = !DILocation(line: 1414, column: 56, scope: !1680)
!1690 = !DILocation(line: 1414, column: 67, scope: !1680)
!1691 = !DILocation(line: 1415, column: 31, scope: !1680)
!1692 = !DILocation(line: 1416, column: 28, scope: !1680)
!1693 = !DILocation(line: 1417, column: 28, scope: !1680)
!1694 = !DILocation(line: 1410, column: 24, scope: !1680, atomGroup: 487, atomRank: 2)
!1695 = !DILocation(line: 1417, column: 56, scope: !1680, atomGroup: 489, atomRank: 2)
!1696 = !DILocation(line: 1417, column: 56, scope: !1680, atomGroup: 489, atomRank: 1)
!1697 = !DILocation(line: 1418, column: 17, scope: !1680, atomGroup: 490, atomRank: 1)
!1698 = !DILocation(line: 1419, column: 39, scope: !1699)
!1699 = distinct !DILexicalBlock(scope: !947, file: !2, line: 1419, column: 17)
!1700 = !DILocation(line: 1419, column: 55, scope: !1699)
!1701 = !DILocation(line: 1420, column: 32, scope: !1699)
!1702 = !DILocation(line: 1420, column: 51, scope: !1699)
!1703 = !DILocation(line: 1421, column: 31, scope: !1699)
!1704 = !DILocation(line: 1421, column: 43, scope: !1699)
!1705 = !DILocation(line: 1422, column: 28, scope: !1699, atomGroup: 492, atomRank: 1)
!1706 = !DILocation(line: 1423, column: 39, scope: !1699)
!1707 = !DILocation(line: 1423, column: 50, scope: !1699)
!1708 = !{!1158, !1159, i64 16}
!1709 = !DILocation(line: 1423, column: 56, scope: !1699)
!1710 = !DILocation(line: 1423, column: 67, scope: !1699)
!1711 = !DILocation(line: 1425, column: 48, scope: !1699)
!1712 = !DILocation(line: 1425, column: 69, scope: !1699)
!1713 = !{!979, !531, i64 24836}
!1714 = !DILocation(line: 1425, column: 28, scope: !1699)
!1715 = !DILocation(line: 1426, column: 48, scope: !1699)
!1716 = !DILocation(line: 1426, column: 69, scope: !1699)
!1717 = !{!979, !531, i64 24840}
!1718 = !DILocation(line: 1426, column: 28, scope: !1699)
!1719 = !DILocation(line: 1419, column: 24, scope: !1699, atomGroup: 491, atomRank: 2)
!1720 = !DILocation(line: 1426, column: 89, scope: !1699, atomGroup: 493, atomRank: 2)
!1721 = !DILocation(line: 1426, column: 89, scope: !1699, atomGroup: 493, atomRank: 1)
!1722 = !DILocation(line: 1427, column: 17, scope: !1699, atomGroup: 494, atomRank: 1)
!1723 = !DILocation(line: 1428, column: 9, scope: !948)
!1724 = !DILocation(line: 0, scope: !951)
!1725 = !DILocation(line: 1436, column: 35, scope: !1726)
!1726 = distinct !DILexicalBlock(scope: !951, file: !2, line: 1436, column: 13)
!1727 = !DILocation(line: 1436, column: 51, scope: !1726)
!1728 = !DILocation(line: 1436, column: 70, scope: !1726)
!1729 = !DILocation(line: 1437, column: 27, scope: !1726)
!1730 = !DILocation(line: 1439, column: 35, scope: !1726)
!1731 = !DILocation(line: 1439, column: 46, scope: !1726)
!1732 = !DILocation(line: 1439, column: 52, scope: !1726)
!1733 = !DILocation(line: 1439, column: 63, scope: !1726)
!1734 = !DILocation(line: 1441, column: 24, scope: !1726)
!1735 = !DILocation(line: 1442, column: 24, scope: !1726)
!1736 = !DILocation(line: 1436, column: 20, scope: !1726, atomGroup: 496, atomRank: 2)
!1737 = !DILocation(line: 1442, column: 52, scope: !1726, atomGroup: 498, atomRank: 2)
!1738 = !DILocation(line: 1442, column: 52, scope: !1726, atomGroup: 498, atomRank: 1)
!1739 = !DILocation(line: 1443, column: 13, scope: !1726, atomGroup: 499, atomRank: 1)
!1740 = !DILocation(line: 1444, column: 35, scope: !1741)
!1741 = distinct !DILexicalBlock(scope: !951, file: !2, line: 1444, column: 13)
!1742 = !DILocation(line: 1444, column: 51, scope: !1741)
!1743 = !DILocation(line: 1444, column: 70, scope: !1741)
!1744 = !DILocation(line: 1445, column: 27, scope: !1741)
!1745 = !DILocation(line: 1445, column: 39, scope: !1741)
!1746 = !DILocation(line: 1445, column: 51, scope: !1741)
!1747 = !DILocation(line: 1447, column: 24, scope: !1741, atomGroup: 501, atomRank: 1)
!1748 = !DILocation(line: 1448, column: 35, scope: !1741)
!1749 = !DILocation(line: 1448, column: 46, scope: !1741)
!1750 = !{!1158, !1159, i64 24}
!1751 = !DILocation(line: 1448, column: 52, scope: !1741)
!1752 = !DILocation(line: 1448, column: 63, scope: !1741)
!1753 = !DILocation(line: 1450, column: 44, scope: !1741)
!1754 = !DILocation(line: 1450, column: 65, scope: !1741)
!1755 = !{!979, !531, i64 24844}
!1756 = !DILocation(line: 1450, column: 24, scope: !1741)
!1757 = !DILocation(line: 1451, column: 44, scope: !1741)
!1758 = !DILocation(line: 1451, column: 65, scope: !1741)
!1759 = !{!979, !531, i64 24848}
!1760 = !DILocation(line: 1451, column: 24, scope: !1741)
!1761 = !DILocation(line: 1444, column: 20, scope: !1741, atomGroup: 500, atomRank: 2)
!1762 = !DILocation(line: 1451, column: 85, scope: !1741, atomGroup: 502, atomRank: 2)
!1763 = !DILocation(line: 1451, column: 85, scope: !1741, atomGroup: 502, atomRank: 1)
!1764 = !DILocation(line: 1453, column: 13, scope: !1741, atomGroup: 503, atomRank: 1)
!1765 = !DILocation(line: 1473, column: 5, scope: !534)
!1766 = !DILocation(line: 1476, column: 25, scope: !534, atomGroup: 504, atomRank: 2)
!1767 = !{!979, !531, i64 2464}
!1768 = !DILocation(line: 1476, column: 8, scope: !534)
!1769 = !DILocation(line: 1476, column: 20, scope: !534, atomGroup: 504, atomRank: 1)
!1770 = !{!979, !531, i64 2360}
!1771 = !DILocation(line: 1477, column: 25, scope: !534)
!1772 = !DILocation(line: 1477, column: 25, scope: !534, atomGroup: 505, atomRank: 2)
!1773 = !{!979, !531, i64 2468}
!1774 = !DILocation(line: 1477, column: 8, scope: !534)
!1775 = !DILocation(line: 1477, column: 20, scope: !534, atomGroup: 505, atomRank: 1)
!1776 = !{!979, !531, i64 2364}
!1777 = !DILocation(line: 1478, column: 5, scope: !955, atomGroup: 1196, atomRank: 1)
!1778 = !DILocation(line: 1478, column: 19, scope: !954, atomGroup: 507, atomRank: 1)
!1779 = !DILocation(line: 1479, column: 41, scope: !953)
!1780 = !DILocation(line: 1479, column: 38, scope: !953)
!1781 = !DILocation(line: 1479, column: 36, scope: !953)
!1782 = !DILocation(line: 1479, column: 49, scope: !953, atomGroup: 509, atomRank: 3)
!1783 = !DILocation(line: 1479, column: 25, scope: !953, atomGroup: 509, atomRank: 2)
!1784 = !DILocation(line: 0, scope: !953)
!1785 = !DILocation(line: 1480, column: 34, scope: !953)
!1786 = !{!979, !986, i64 2440}
!1787 = !DILocation(line: 1480, column: 31, scope: !953)
!1788 = !{!531, !531, i64 0}
!1789 = !DILocation(line: 1480, column: 56, scope: !953)
!1790 = !DILocation(line: 1480, column: 51, scope: !953)
!1791 = !DILocation(line: 1480, column: 71, scope: !953)
!1792 = !DILocation(line: 1481, column: 36, scope: !953)
!1793 = !{!979, !986, i64 2448}
!1794 = !DILocation(line: 1481, column: 33, scope: !953)
!1795 = !DILocation(line: 1481, column: 61, scope: !953)
!1796 = !DILocation(line: 1481, column: 56, scope: !953)
!1797 = !DILocation(line: 1481, column: 76, scope: !953)
!1798 = !DILocation(line: 1482, column: 38, scope: !953)
!1799 = !DILocation(line: 1482, column: 32, scope: !953)
!1800 = !DILocation(line: 1480, column: 25, scope: !953, atomGroup: 511, atomRank: 2)
!1801 = !DILocation(line: 1480, column: 25, scope: !953, atomGroup: 511, atomRank: 1)
!1802 = !DILocation(line: 1480, column: 25, scope: !953)
!1803 = !DILocation(line: 1480, column: 25, scope: !953, atomGroup: 510, atomRank: 2)
!1804 = !DILocation(line: 1484, column: 26, scope: !953)
!1805 = !DILocation(line: 1484, column: 19, scope: !953, atomGroup: 512, atomRank: 2)
!1806 = !DILocation(line: 1485, column: 19, scope: !953, atomGroup: 513, atomRank: 2)
!1807 = !DILocation(line: 1486, column: 16, scope: !1808)
!1808 = distinct !DILexicalBlock(scope: !953, file: !2, line: 1486, column: 13)
!1809 = !DILocation(line: 1486, column: 13, scope: !1808)
!1810 = !DILocation(line: 1486, column: 38, scope: !1808)
!1811 = !DILocation(line: 1486, column: 33, scope: !1808)
!1812 = !DILocation(line: 1486, column: 50, scope: !1808, atomGroup: 514, atomRank: 2)
!1813 = !DILocation(line: 1486, column: 50, scope: !1808, atomGroup: 514, atomRank: 1)
!1814 = !DILocation(line: 1487, column: 40, scope: !1808, atomGroup: 515, atomRank: 2)
!1815 = !DILocation(line: 1487, column: 28, scope: !1808, atomGroup: 515, atomRank: 1)
!1816 = !DILocation(line: 1487, column: 13, scope: !1808)
!1817 = !DILocation(line: 1488, column: 16, scope: !1818)
!1818 = distinct !DILexicalBlock(scope: !953, file: !2, line: 1488, column: 13)
!1819 = !DILocation(line: 1488, column: 13, scope: !1818)
!1820 = !DILocation(line: 1488, column: 41, scope: !1818)
!1821 = !DILocation(line: 1488, column: 36, scope: !1818)
!1822 = !DILocation(line: 1489, column: 30, scope: !1818)
!1823 = !DILocation(line: 1489, column: 24, scope: !1818)
!1824 = !DILocation(line: 1488, column: 53, scope: !1818, atomGroup: 516, atomRank: 2)
!1825 = !DILocation(line: 1488, column: 53, scope: !1818, atomGroup: 516, atomRank: 1)
!1826 = !DILocation(line: 1490, column: 65, scope: !1818, atomGroup: 517, atomRank: 2)
!1827 = !DILocation(line: 1490, column: 28, scope: !1818, atomGroup: 517, atomRank: 1)
!1828 = !DILocation(line: 1490, column: 13, scope: !1818)
!1829 = !DILocation(line: 1478, column: 28, scope: !954, atomGroup: 518, atomRank: 2)
!1830 = !DILocation(line: 1478, column: 5, scope: !955, atomGroup: 508, atomRank: 1)
!1831 = distinct !{!1831, !1832, !1833}
!1832 = !DILocation(line: 1478, column: 5, scope: !955)
!1833 = !DILocation(line: 1492, column: 5, scope: !955)
!1834 = !DILocation(line: 1494, column: 5, scope: !1835, atomGroup: 1198, atomRank: 1)
!1835 = distinct !DILexicalBlock(scope: !534, file: !2, line: 1494, column: 5)
!1836 = !DILocation(line: 1495, column: 54, scope: !1837)
!1837 = distinct !DILexicalBlock(scope: !1838, file: !2, line: 1495, column: 9)
!1838 = distinct !DILexicalBlock(scope: !1835, file: !2, line: 1494, column: 5)
!1839 = !DILocation(line: 1495, column: 58, scope: !1837)
!1840 = !DILocation(line: 1495, column: 50, scope: !1837)
!1841 = !DILocation(line: 1495, column: 62, scope: !1837)
!1842 = !DILocation(line: 1495, column: 9, scope: !1837, atomGroup: 523, atomRank: 2)
!1843 = !DILocation(line: 1495, column: 9, scope: !1837, atomGroup: 523, atomRank: 1)
!1844 = !{!986, !986, i64 0}
!1845 = !DILocation(line: 1495, column: 9, scope: !1846, atomGroup: 524, atomRank: 2)
!1846 = distinct !DILexicalBlock(scope: !1837, file: !2, line: 1495, column: 9)
!1847 = !DILocation(line: 1495, column: 9, scope: !1846, atomGroup: 524, atomRank: 1)
!1848 = !DILocation(line: 1495, column: 54, scope: !1846)
!1849 = !DILocation(line: 1495, column: 58, scope: !1846)
!1850 = !DILocation(line: 1495, column: 50, scope: !1846)
!1851 = !DILocation(line: 1495, column: 62, scope: !1846)
!1852 = !DILocation(line: 1495, column: 9, scope: !1846, atomGroup: 525, atomRank: 2)
!1853 = !DILocation(line: 1495, column: 9, scope: !1846, atomGroup: 525, atomRank: 1)
!1854 = !DILocation(line: 1495, column: 9, scope: !1855)
!1855 = distinct !DILexicalBlock(scope: !1846, file: !2, line: 1495, column: 9)
!1856 = !DILocation(line: 1495, column: 9, scope: !1855, atomGroup: 526, atomRank: 1)
!1857 = !DILocation(line: 1495, column: 9, scope: !1837, atomGroup: 1213, atomRank: 2)
!1858 = !DILocation(line: 1495, column: 30, scope: !1837)
!1859 = !DILocation(line: 1495, column: 9, scope: !1837, atomGroup: 1213, atomRank: 1)
!1860 = !DILocation(line: 1495, column: 9, scope: !1846, atomGroup: 1214, atomRank: 2)
!1861 = !DILocation(line: 1495, column: 9, scope: !1846, atomGroup: 1214, atomRank: 1)
!1862 = !DILocation(line: 1495, column: 9, scope: !1846, atomGroup: 1215, atomRank: 2)
!1863 = !DILocation(line: 1495, column: 9, scope: !1846, atomGroup: 1215, atomRank: 1)
!1864 = !DILocation(line: 1495, column: 9, scope: !1837, atomGroup: 1219, atomRank: 2)
!1865 = !DILocation(line: 1495, column: 9, scope: !1837, atomGroup: 1219, atomRank: 1)
!1866 = !DILocation(line: 1495, column: 9, scope: !1846, atomGroup: 1220, atomRank: 2)
!1867 = !DILocation(line: 1495, column: 9, scope: !1846, atomGroup: 1220, atomRank: 1)
!1868 = !DILocation(line: 1495, column: 9, scope: !1846, atomGroup: 1221, atomRank: 2)
!1869 = !DILocation(line: 1495, column: 9, scope: !1846, atomGroup: 1221, atomRank: 1)
!1870 = !DILocation(line: 1495, column: 9, scope: !1837, atomGroup: 1225, atomRank: 2)
!1871 = !DILocation(line: 1495, column: 9, scope: !1837, atomGroup: 1225, atomRank: 1)
!1872 = !DILocation(line: 1495, column: 9, scope: !1846, atomGroup: 1226, atomRank: 2)
!1873 = !DILocation(line: 1495, column: 9, scope: !1846, atomGroup: 1226, atomRank: 1)
!1874 = !DILocation(line: 1495, column: 9, scope: !1846, atomGroup: 1227, atomRank: 2)
!1875 = !DILocation(line: 1495, column: 9, scope: !1846, atomGroup: 1227, atomRank: 1)
!1876 = !DILocation(line: 1499, column: 43, scope: !1877)
!1877 = distinct !DILexicalBlock(scope: !534, file: !2, line: 1499, column: 5)
!1878 = !DILocation(line: 1499, column: 55, scope: !1877)
!1879 = !DILocation(line: 1499, column: 40, scope: !1877)
!1880 = !DILocation(line: 1499, column: 59, scope: !1877)
!1881 = !DILocation(line: 1499, column: 5, scope: !1877, atomGroup: 529, atomRank: 2)
!1882 = !DILocation(line: 1499, column: 28, scope: !1877)
!1883 = !DILocation(line: 1499, column: 5, scope: !1877, atomGroup: 529, atomRank: 1)
!1884 = !{!979, !983, i64 2328}
!1885 = !DILocation(line: 1499, column: 5, scope: !1886, atomGroup: 530, atomRank: 2)
!1886 = distinct !DILexicalBlock(scope: !1877, file: !2, line: 1499, column: 5)
!1887 = !DILocation(line: 1499, column: 5, scope: !1886, atomGroup: 530, atomRank: 1)
!1888 = !DILocation(line: 1499, column: 43, scope: !1886)
!1889 = !DILocation(line: 1499, column: 55, scope: !1886)
!1890 = !DILocation(line: 1499, column: 40, scope: !1886)
!1891 = !DILocation(line: 1499, column: 59, scope: !1886)
!1892 = !DILocation(line: 1499, column: 5, scope: !1886, atomGroup: 531, atomRank: 2)
!1893 = !DILocation(line: 1499, column: 5, scope: !1886, atomGroup: 531, atomRank: 1)
!1894 = !DILocation(line: 1499, column: 5, scope: !1895)
!1895 = distinct !DILexicalBlock(scope: !1886, file: !2, line: 1499, column: 5)
!1896 = !DILocation(line: 1499, column: 5, scope: !1895, atomGroup: 532, atomRank: 1)
!1897 = !DILocation(line: 1500, column: 43, scope: !1898)
!1898 = distinct !DILexicalBlock(scope: !534, file: !2, line: 1500, column: 5)
!1899 = !DILocation(line: 1500, column: 55, scope: !1898)
!1900 = !DILocation(line: 1500, column: 40, scope: !1898)
!1901 = !DILocation(line: 1500, column: 59, scope: !1898)
!1902 = !DILocation(line: 1500, column: 5, scope: !1898, atomGroup: 533, atomRank: 2)
!1903 = !DILocation(line: 1500, column: 28, scope: !1898)
!1904 = !DILocation(line: 1500, column: 5, scope: !1898, atomGroup: 533, atomRank: 1)
!1905 = !{!979, !983, i64 2336}
!1906 = !DILocation(line: 1500, column: 5, scope: !1907, atomGroup: 534, atomRank: 2)
!1907 = distinct !DILexicalBlock(scope: !1898, file: !2, line: 1500, column: 5)
!1908 = !DILocation(line: 1500, column: 5, scope: !1907, atomGroup: 534, atomRank: 1)
!1909 = !DILocation(line: 1500, column: 43, scope: !1907)
!1910 = !DILocation(line: 1500, column: 55, scope: !1907)
!1911 = !DILocation(line: 1500, column: 40, scope: !1907)
!1912 = !DILocation(line: 1500, column: 59, scope: !1907)
!1913 = !DILocation(line: 1500, column: 5, scope: !1907, atomGroup: 535, atomRank: 2)
!1914 = !DILocation(line: 1500, column: 5, scope: !1907, atomGroup: 535, atomRank: 1)
!1915 = !DILocation(line: 1500, column: 5, scope: !1916)
!1916 = distinct !DILexicalBlock(scope: !1907, file: !2, line: 1500, column: 5)
!1917 = !DILocation(line: 1500, column: 5, scope: !1916, atomGroup: 536, atomRank: 1)
!1918 = !DILocation(line: 1501, column: 43, scope: !1919)
!1919 = distinct !DILexicalBlock(scope: !534, file: !2, line: 1501, column: 5)
!1920 = !DILocation(line: 1501, column: 55, scope: !1919)
!1921 = !DILocation(line: 1501, column: 40, scope: !1919)
!1922 = !DILocation(line: 1501, column: 59, scope: !1919)
!1923 = !DILocation(line: 1501, column: 5, scope: !1919, atomGroup: 537, atomRank: 2)
!1924 = !DILocation(line: 1501, column: 28, scope: !1919)
!1925 = !DILocation(line: 1501, column: 5, scope: !1919, atomGroup: 537, atomRank: 1)
!1926 = !{!979, !983, i64 2344}
!1927 = !DILocation(line: 1501, column: 5, scope: !1928, atomGroup: 538, atomRank: 2)
!1928 = distinct !DILexicalBlock(scope: !1919, file: !2, line: 1501, column: 5)
!1929 = !DILocation(line: 1501, column: 5, scope: !1928, atomGroup: 538, atomRank: 1)
!1930 = !DILocation(line: 1501, column: 43, scope: !1928)
!1931 = !DILocation(line: 1501, column: 55, scope: !1928)
!1932 = !DILocation(line: 1501, column: 40, scope: !1928)
!1933 = !DILocation(line: 1501, column: 59, scope: !1928)
!1934 = !DILocation(line: 1501, column: 5, scope: !1928, atomGroup: 539, atomRank: 2)
!1935 = !DILocation(line: 1501, column: 5, scope: !1928, atomGroup: 539, atomRank: 1)
!1936 = !DILocation(line: 1501, column: 5, scope: !1937)
!1937 = distinct !DILexicalBlock(scope: !1928, file: !2, line: 1501, column: 5)
!1938 = !DILocation(line: 1501, column: 5, scope: !1937, atomGroup: 540, atomRank: 1)
!1939 = !DILocation(line: 1502, column: 44, scope: !1940)
!1940 = distinct !DILexicalBlock(scope: !534, file: !2, line: 1502, column: 9)
!1941 = !DILocation(line: 1502, column: 33, scope: !1940)
!1942 = !DILocation(line: 1502, column: 33, scope: !1940, atomGroup: 541, atomRank: 2)
!1943 = !DILocation(line: 1502, column: 55, scope: !1940, atomGroup: 541, atomRank: 1)
!1944 = !DILocation(line: 1502, column: 69, scope: !1940)
!1945 = !DILocation(line: 1502, column: 58, scope: !1940)
!1946 = !DILocation(line: 1502, column: 58, scope: !1940, atomGroup: 542, atomRank: 2)
!1947 = !DILocation(line: 1502, column: 55, scope: !1940, atomGroup: 542, atomRank: 1)
!1948 = !DILocation(line: 1503, column: 47, scope: !1949)
!1949 = distinct !DILexicalBlock(scope: !1940, file: !2, line: 1503, column: 9)
!1950 = !DILocation(line: 1503, column: 59, scope: !1949)
!1951 = !DILocation(line: 1503, column: 44, scope: !1949)
!1952 = !DILocation(line: 1503, column: 63, scope: !1949)
!1953 = !DILocation(line: 1503, column: 9, scope: !1949, atomGroup: 543, atomRank: 2)
!1954 = !DILocation(line: 1503, column: 33, scope: !1949)
!1955 = !DILocation(line: 1503, column: 9, scope: !1949, atomGroup: 543, atomRank: 1)
!1956 = !{!979, !983, i64 2352}
!1957 = !DILocation(line: 1503, column: 9, scope: !1958, atomGroup: 544, atomRank: 2)
!1958 = distinct !DILexicalBlock(scope: !1949, file: !2, line: 1503, column: 9)
!1959 = !DILocation(line: 1503, column: 9, scope: !1958, atomGroup: 544, atomRank: 1)
!1960 = !DILocation(line: 1503, column: 47, scope: !1958)
!1961 = !DILocation(line: 1503, column: 59, scope: !1958)
!1962 = !DILocation(line: 1503, column: 44, scope: !1958)
!1963 = !DILocation(line: 1503, column: 63, scope: !1958)
!1964 = !DILocation(line: 1503, column: 9, scope: !1958, atomGroup: 545, atomRank: 2)
!1965 = !DILocation(line: 1503, column: 9, scope: !1958, atomGroup: 545, atomRank: 1)
!1966 = !DILocation(line: 1503, column: 9, scope: !1967)
!1967 = distinct !DILexicalBlock(scope: !1958, file: !2, line: 1503, column: 9)
!1968 = !DILocation(line: 1503, column: 9, scope: !1967, atomGroup: 546, atomRank: 1)
!1969 = !DILocation(line: 1507, column: 24, scope: !1970)
!1970 = distinct !DILexicalBlock(scope: !1971, file: !2, line: 1507, column: 5)
!1971 = distinct !DILexicalBlock(scope: !534, file: !2, line: 1507, column: 5)
!1972 = !DILocation(line: 1507, column: 19, scope: !1970, atomGroup: 1199, atomRank: 1)
!1973 = !DILocation(line: 1507, column: 5, scope: !1971, atomGroup: 1200, atomRank: 1)
!1974 = !DILocation(line: 1508, column: 9, scope: !1975, atomGroup: 550, atomRank: 2)
!1975 = distinct !DILexicalBlock(scope: !1976, file: !2, line: 1508, column: 9)
!1976 = distinct !DILexicalBlock(scope: !1970, file: !2, line: 1507, column: 42)
!1977 = !DILocation(line: 1508, column: 33, scope: !1975)
!1978 = !DILocation(line: 1508, column: 50, scope: !1975)
!1979 = !DILocation(line: 1508, column: 45, scope: !1975)
!1980 = !DILocation(line: 1508, column: 30, scope: !1975)
!1981 = !DILocation(line: 1508, column: 9, scope: !1975, atomGroup: 550, atomRank: 1)
!1982 = !{!982, !982, i64 0}
!1983 = !DILocation(line: 1508, column: 33, scope: !1984)
!1984 = distinct !DILexicalBlock(scope: !1975, file: !2, line: 1508, column: 9)
!1985 = !DILocation(line: 1508, column: 50, scope: !1984)
!1986 = !DILocation(line: 1508, column: 45, scope: !1984)
!1987 = !DILocation(line: 1508, column: 30, scope: !1984)
!1988 = !DILocation(line: 1508, column: 9, scope: !1984, atomGroup: 551, atomRank: 2)
!1989 = !DILocation(line: 1508, column: 9, scope: !1984, atomGroup: 551, atomRank: 1)
!1990 = !DILocation(line: 1508, column: 9, scope: !1984, atomGroup: 552, atomRank: 1)
!1991 = !DILocation(line: 1508, column: 9, scope: !1992)
!1992 = distinct !DILexicalBlock(scope: !1984, file: !2, line: 1508, column: 9)
!1993 = !DILocation(line: 1508, column: 9, scope: !1992, atomGroup: 553, atomRank: 1)
!1994 = !DILocation(line: 1510, column: 30, scope: !1976)
!1995 = !DILocation(line: 1510, column: 47, scope: !1976)
!1996 = !DILocation(line: 1510, column: 42, scope: !1976)
!1997 = !DILocation(line: 1510, column: 27, scope: !1976)
!1998 = !DILocation(line: 1510, column: 27, scope: !1976, atomGroup: 554, atomRank: 2)
!1999 = !DILocation(line: 1510, column: 9, scope: !1976)
!2000 = !DILocation(line: 1510, column: 25, scope: !1976, atomGroup: 554, atomRank: 1)
!2001 = !DILocation(line: 1507, column: 38, scope: !1970, atomGroup: 555, atomRank: 2)
!2002 = !DILocation(line: 1507, column: 19, scope: !1970, atomGroup: 548, atomRank: 1)
!2003 = !DILocation(line: 1507, column: 5, scope: !1971, atomGroup: 549, atomRank: 1)
!2004 = distinct !{!2004, !2005, !2006}
!2005 = !DILocation(line: 1507, column: 5, scope: !1971)
!2006 = !DILocation(line: 1511, column: 5, scope: !1971)
!2007 = !DILocation(line: 1513, column: 30, scope: !534)
!2008 = !DILocation(line: 1513, column: 46, scope: !534)
!2009 = !DILocation(line: 1513, column: 53, scope: !534)
!2010 = !DILocation(line: 1513, column: 40, scope: !534)
!2011 = !DILocation(line: 1513, column: 35, scope: !534, atomGroup: 557, atomRank: 3)
!2012 = !DILocation(line: 1513, column: 19, scope: !534, atomGroup: 557, atomRank: 2)
!2013 = !DILocation(line: 1513, column: 8, scope: !534)
!2014 = !DILocation(line: 1513, column: 17, scope: !534, atomGroup: 557, atomRank: 1)
!2015 = !{!979, !987, i64 37304}
!2016 = !DILocation(line: 1514, column: 30, scope: !534, atomGroup: 558, atomRank: 3)
!2017 = !DILocation(line: 1514, column: 19, scope: !534, atomGroup: 558, atomRank: 2)
!2018 = !DILocation(line: 1514, column: 8, scope: !534)
!2019 = !DILocation(line: 1514, column: 17, scope: !534, atomGroup: 558, atomRank: 1)
!2020 = !{!979, !987, i64 37312}
!2021 = !DILocation(line: 1515, column: 24, scope: !2022)
!2022 = distinct !DILexicalBlock(scope: !2023, file: !2, line: 1515, column: 5)
!2023 = distinct !DILexicalBlock(scope: !534, file: !2, line: 1515, column: 5)
!2024 = !DILocation(line: 1515, column: 19, scope: !2022, atomGroup: 1201, atomRank: 1)
!2025 = !DILocation(line: 1515, column: 5, scope: !2023, atomGroup: 1202, atomRank: 1)
!2026 = !DILocation(line: 1516, column: 9, scope: !2027, atomGroup: 562, atomRank: 2)
!2027 = distinct !DILexicalBlock(scope: !2028, file: !2, line: 1516, column: 9)
!2028 = distinct !DILexicalBlock(scope: !2022, file: !2, line: 1515, column: 42)
!2029 = !DILocation(line: 1516, column: 32, scope: !2027)
!2030 = !DILocation(line: 1516, column: 50, scope: !2027)
!2031 = !DILocation(line: 1516, column: 45, scope: !2027)
!2032 = !DILocation(line: 1516, column: 29, scope: !2027)
!2033 = !DILocation(line: 1516, column: 9, scope: !2027, atomGroup: 562, atomRank: 1)
!2034 = !DILocation(line: 1516, column: 32, scope: !2035)
!2035 = distinct !DILexicalBlock(scope: !2027, file: !2, line: 1516, column: 9)
!2036 = !DILocation(line: 1516, column: 50, scope: !2035)
!2037 = !DILocation(line: 1516, column: 45, scope: !2035)
!2038 = !DILocation(line: 1516, column: 29, scope: !2035)
!2039 = !DILocation(line: 1516, column: 9, scope: !2035, atomGroup: 563, atomRank: 2)
!2040 = !DILocation(line: 1516, column: 9, scope: !2035, atomGroup: 563, atomRank: 1)
!2041 = !DILocation(line: 1516, column: 9, scope: !2035, atomGroup: 564, atomRank: 1)
!2042 = !DILocation(line: 1516, column: 9, scope: !2043)
!2043 = distinct !DILexicalBlock(scope: !2035, file: !2, line: 1516, column: 9)
!2044 = !DILocation(line: 1516, column: 9, scope: !2043, atomGroup: 565, atomRank: 1)
!2045 = !DILocation(line: 1518, column: 31, scope: !2028)
!2046 = !DILocation(line: 1518, column: 49, scope: !2028)
!2047 = !DILocation(line: 1518, column: 44, scope: !2028)
!2048 = !DILocation(line: 1518, column: 28, scope: !2028)
!2049 = !DILocation(line: 1518, column: 28, scope: !2028, atomGroup: 566, atomRank: 2)
!2050 = !DILocation(line: 1518, column: 9, scope: !2028)
!2051 = !DILocation(line: 1518, column: 26, scope: !2028, atomGroup: 566, atomRank: 1)
!2052 = !DILocation(line: 1520, column: 31, scope: !2028)
!2053 = !DILocation(line: 1520, column: 28, scope: !2028)
!2054 = !DILocation(line: 1520, column: 45, scope: !2028)
!2055 = !DILocation(line: 1520, column: 65, scope: !2028, atomGroup: 567, atomRank: 2)
!2056 = !DILocation(line: 1519, column: 31, scope: !2028)
!2057 = !DILocation(line: 1519, column: 49, scope: !2028)
!2058 = !DILocation(line: 1519, column: 44, scope: !2028)
!2059 = !DILocation(line: 1519, column: 28, scope: !2028)
!2060 = !DILocation(line: 1520, column: 26, scope: !2028, atomGroup: 568, atomRank: 1)
!2061 = !DILocation(line: 1519, column: 12, scope: !2028)
!2062 = !DILocation(line: 1519, column: 9, scope: !2028)
!2063 = !DILocation(line: 1519, column: 26, scope: !2028, atomGroup: 567, atomRank: 1)
!2064 = !DILocation(line: 1515, column: 38, scope: !2022, atomGroup: 569, atomRank: 2)
!2065 = !DILocation(line: 1515, column: 19, scope: !2022, atomGroup: 560, atomRank: 1)
!2066 = !DILocation(line: 1515, column: 5, scope: !2023, atomGroup: 561, atomRank: 1)
!2067 = distinct !{!2067, !2068, !2069}
!2068 = !DILocation(line: 1515, column: 5, scope: !2023)
!2069 = !DILocation(line: 1521, column: 5, scope: !2023)
!2070 = !DILocation(line: 1522, column: 36, scope: !2071)
!2071 = distinct !DILexicalBlock(scope: !534, file: !2, line: 1522, column: 9)
!2072 = !DILocation(line: 1522, column: 33, scope: !2071, atomGroup: 571, atomRank: 2)
!2073 = !DILocation(line: 1522, column: 30, scope: !2071, atomGroup: 571, atomRank: 1)
!2074 = !DILocation(line: 1523, column: 28, scope: !2075)
!2075 = distinct !DILexicalBlock(scope: !2076, file: !2, line: 1523, column: 9)
!2076 = distinct !DILexicalBlock(scope: !2071, file: !2, line: 1523, column: 9)
!2077 = !DILocation(line: 1523, column: 23, scope: !2075, atomGroup: 1203, atomRank: 1)
!2078 = !DILocation(line: 1523, column: 9, scope: !2076, atomGroup: 1204, atomRank: 1)
!2079 = !DILocation(line: 1524, column: 13, scope: !2080, atomGroup: 575, atomRank: 2)
!2080 = distinct !DILexicalBlock(scope: !2081, file: !2, line: 1524, column: 13)
!2081 = distinct !DILexicalBlock(scope: !2075, file: !2, line: 1523, column: 46)
!2082 = !DILocation(line: 1524, column: 37, scope: !2080)
!2083 = !DILocation(line: 1524, column: 54, scope: !2080)
!2084 = !DILocation(line: 1524, column: 49, scope: !2080)
!2085 = !DILocation(line: 1524, column: 34, scope: !2080)
!2086 = !DILocation(line: 1524, column: 13, scope: !2080, atomGroup: 575, atomRank: 1)
!2087 = !DILocation(line: 1524, column: 37, scope: !2088)
!2088 = distinct !DILexicalBlock(scope: !2080, file: !2, line: 1524, column: 13)
!2089 = !DILocation(line: 1524, column: 54, scope: !2088)
!2090 = !DILocation(line: 1524, column: 49, scope: !2088)
!2091 = !DILocation(line: 1524, column: 34, scope: !2088)
!2092 = !DILocation(line: 1524, column: 13, scope: !2088, atomGroup: 576, atomRank: 2)
!2093 = !DILocation(line: 1524, column: 13, scope: !2088, atomGroup: 576, atomRank: 1)
!2094 = !DILocation(line: 1524, column: 13, scope: !2088, atomGroup: 577, atomRank: 1)
!2095 = !DILocation(line: 1524, column: 13, scope: !2096)
!2096 = distinct !DILexicalBlock(scope: !2088, file: !2, line: 1524, column: 13)
!2097 = !DILocation(line: 1524, column: 13, scope: !2096, atomGroup: 578, atomRank: 1)
!2098 = !DILocation(line: 1526, column: 34, scope: !2081)
!2099 = !DILocation(line: 1526, column: 51, scope: !2081)
!2100 = !DILocation(line: 1526, column: 46, scope: !2081)
!2101 = !DILocation(line: 1526, column: 31, scope: !2081)
!2102 = !DILocation(line: 1526, column: 31, scope: !2081, atomGroup: 579, atomRank: 2)
!2103 = !DILocation(line: 1526, column: 13, scope: !2081)
!2104 = !DILocation(line: 1526, column: 29, scope: !2081, atomGroup: 579, atomRank: 1)
!2105 = !DILocation(line: 1523, column: 42, scope: !2075, atomGroup: 580, atomRank: 2)
!2106 = !DILocation(line: 1523, column: 23, scope: !2075, atomGroup: 573, atomRank: 1)
!2107 = !DILocation(line: 1523, column: 9, scope: !2076, atomGroup: 574, atomRank: 1)
!2108 = distinct !{!2108, !2109, !2110}
!2109 = !DILocation(line: 1523, column: 9, scope: !2076)
!2110 = !DILocation(line: 1527, column: 9, scope: !2076)
!2111 = !DILocation(line: 1530, column: 10, scope: !2112)
!2112 = distinct !DILexicalBlock(scope: !534, file: !2, line: 1530, column: 5)
!2113 = !DILocation(line: 1530, column: 24, scope: !2114)
!2114 = distinct !DILexicalBlock(scope: !2112, file: !2, line: 1530, column: 5)
!2115 = !DILocation(line: 1530, column: 19, scope: !2114, atomGroup: 1209, atomRank: 1)
!2116 = !DILocation(line: 1530, column: 5, scope: !2112, atomGroup: 1210, atomRank: 1)
!2117 = !DILocation(line: 1531, column: 30, scope: !2118)
!2118 = distinct !DILexicalBlock(scope: !2114, file: !2, line: 1531, column: 12)
!2119 = !DILocation(line: 1531, column: 12, scope: !2118)
!2120 = !DILocation(line: 1531, column: 43, scope: !2118, atomGroup: 585, atomRank: 2)
!2121 = !DILocation(line: 1531, column: 43, scope: !2118, atomGroup: 585, atomRank: 1)
!2122 = !DILocation(line: 1532, column: 27, scope: !2123)
!2123 = distinct !DILexicalBlock(scope: !2124, file: !2, line: 1532, column: 13)
!2124 = distinct !DILexicalBlock(scope: !2125, file: !2, line: 1532, column: 13)
!2125 = distinct !DILexicalBlock(scope: !2118, file: !2, line: 1531, column: 49)
!2126 = !DILocation(line: 1532, column: 34, scope: !2123, atomGroup: 586, atomRank: 2)
!2127 = !DILocation(line: 1532, column: 13, scope: !2123, atomGroup: 586, atomRank: 1)
!2128 = !DILocation(line: 1532, column: 13, scope: !2129)
!2129 = distinct !DILexicalBlock(scope: !2123, file: !2, line: 1532, column: 13)
!2130 = !DILocation(line: 1533, column: 13, scope: !2131, atomGroup: 1208, atomRank: 1)
!2131 = distinct !DILexicalBlock(scope: !2125, file: !2, line: 1533, column: 13)
!2132 = !DILocation(line: 1533, column: 13, scope: !2131)
!2133 = !DILocation(line: 1534, column: 32, scope: !2134)
!2134 = distinct !DILexicalBlock(scope: !2131, file: !2, line: 1533, column: 13)
!2135 = !DILocation(line: 1534, column: 29, scope: !2134)
!2136 = !DILocation(line: 1534, column: 17, scope: !2134)
!2137 = !DILocation(line: 1534, column: 51, scope: !2134, atomGroup: 590, atomRank: 1)
!2138 = !DILocation(line: 1533, column: 41, scope: !2134, atomGroup: 591, atomRank: 2)
!2139 = !DILocation(line: 1534, column: 51, scope: !2134, atomGroup: 1251, atomRank: 1)
!2140 = !DILocation(line: 1533, column: 41, scope: !2134, atomGroup: 1252, atomRank: 2)
!2141 = !DILocation(line: 1534, column: 51, scope: !2134, atomGroup: 1255, atomRank: 1)
!2142 = !DILocation(line: 1533, column: 41, scope: !2134, atomGroup: 1256, atomRank: 2)
!2143 = !DILocation(line: 1534, column: 51, scope: !2134, atomGroup: 1259, atomRank: 1)
!2144 = !DILocation(line: 1533, column: 41, scope: !2134, atomGroup: 1260, atomRank: 2)
!2145 = !DILocation(line: 1533, column: 13, scope: !2131, atomGroup: 1262, atomRank: 1)
!2146 = distinct !{!2146, !2132, !2147}
!2147 = !DILocation(line: 1534, column: 56, scope: !2131)
!2148 = !DILocation(line: 1536, column: 13, scope: !2149, atomGroup: 1206, atomRank: 1)
!2149 = distinct !DILexicalBlock(scope: !2118, file: !2, line: 1536, column: 13)
!2150 = !DILocation(line: 1536, column: 13, scope: !2149)
!2151 = !DILocation(line: 1537, column: 32, scope: !2152)
!2152 = distinct !DILexicalBlock(scope: !2149, file: !2, line: 1536, column: 13)
!2153 = !DILocation(line: 1537, column: 29, scope: !2152)
!2154 = !DILocation(line: 1537, column: 17, scope: !2152)
!2155 = !DILocation(line: 1537, column: 51, scope: !2152, atomGroup: 596, atomRank: 1)
!2156 = !{!2157, !2157, i64 0}
!2157 = !{!"short", !532, i64 0}
!2158 = !DILocation(line: 1536, column: 39, scope: !2152, atomGroup: 597, atomRank: 2)
!2159 = !DILocation(line: 1537, column: 51, scope: !2152, atomGroup: 1235, atomRank: 1)
!2160 = !DILocation(line: 1536, column: 39, scope: !2152, atomGroup: 1236, atomRank: 2)
!2161 = !DILocation(line: 1537, column: 51, scope: !2152, atomGroup: 1239, atomRank: 1)
!2162 = !DILocation(line: 1536, column: 39, scope: !2152, atomGroup: 1240, atomRank: 2)
!2163 = !DILocation(line: 1537, column: 51, scope: !2152, atomGroup: 1243, atomRank: 1)
!2164 = !DILocation(line: 1536, column: 39, scope: !2152, atomGroup: 1244, atomRank: 2)
!2165 = !DILocation(line: 1536, column: 13, scope: !2149, atomGroup: 1246, atomRank: 1)
!2166 = distinct !{!2166, !2150, !2167}
!2167 = !DILocation(line: 1537, column: 56, scope: !2149)
!2168 = !DILocation(line: 1533, column: 13, scope: !2131, atomGroup: 589, atomRank: 1)
!2169 = !DILocation(line: 1534, column: 51, scope: !2134, atomGroup: 1247, atomRank: 1)
!2170 = !DILocation(line: 1533, column: 41, scope: !2134, atomGroup: 1248, atomRank: 2)
!2171 = !DILocation(line: 1533, column: 13, scope: !2131, atomGroup: 1250, atomRank: 1)
!2172 = distinct !{!2172, !2173}
!2173 = !{!"llvm.loop.unroll.disable"}
!2174 = !DILocation(line: 1530, column: 38, scope: !2114, atomGroup: 599, atomRank: 2)
!2175 = !DILocation(line: 1536, column: 13, scope: !2149, atomGroup: 595, atomRank: 1)
!2176 = !DILocation(line: 1537, column: 51, scope: !2152, atomGroup: 1231, atomRank: 1)
!2177 = !DILocation(line: 1536, column: 39, scope: !2152, atomGroup: 1232, atomRank: 2)
!2178 = !DILocation(line: 1536, column: 13, scope: !2149, atomGroup: 1234, atomRank: 1)
!2179 = distinct !{!2179, !2173}
!2180 = !DILocation(line: 1530, column: 19, scope: !2114, atomGroup: 583, atomRank: 1)
!2181 = !DILocation(line: 1530, column: 5, scope: !2112, atomGroup: 584, atomRank: 1)
!2182 = distinct !{!2182, !2183, !2184}
!2183 = !DILocation(line: 1530, column: 5, scope: !2112)
!2184 = !DILocation(line: 1537, column: 56, scope: !2112)
!2185 = !DILocation(line: 1539, column: 19, scope: !2186)
!2186 = distinct !DILexicalBlock(scope: !2187, file: !2, line: 1539, column: 5)
!2187 = distinct !DILexicalBlock(scope: !534, file: !2, line: 1539, column: 5)
!2188 = !DILocation(line: 1539, column: 27, scope: !2186, atomGroup: 601, atomRank: 2)
!2189 = !DILocation(line: 1539, column: 5, scope: !2186, atomGroup: 601, atomRank: 1)
!2190 = !DILocation(line: 1539, column: 5, scope: !2191)
!2191 = distinct !DILexicalBlock(scope: !2186, file: !2, line: 1539, column: 5)
!2192 = !DILocation(line: 1541, column: 15, scope: !959)
!2193 = !DILocation(line: 1541, column: 15, scope: !959, atomGroup: 602, atomRank: 2)
!2194 = !DILocation(line: 1541, column: 15, scope: !959, atomGroup: 602, atomRank: 1)
!2195 = !DILocation(line: 0, scope: !958)
!2196 = !DILocation(line: 1544, column: 9, scope: !2197, atomGroup: 1212, atomRank: 1)
!2197 = distinct !DILexicalBlock(scope: !958, file: !2, line: 1544, column: 9)
!2198 = !DILocation(line: 1544, column: 21, scope: !2199)
!2199 = distinct !DILexicalBlock(scope: !2197, file: !2, line: 1544, column: 9)
!2200 = !DILocation(line: 1544, column: 23, scope: !2199, atomGroup: 605, atomRank: 1)
!2201 = !DILocation(line: 1544, column: 9, scope: !2197, atomGroup: 606, atomRank: 1)
!2202 = distinct !{!2202, !2203, !2204}
!2203 = !DILocation(line: 1544, column: 9, scope: !2197)
!2204 = !DILocation(line: 1549, column: 9, scope: !2197)
!2205 = !DILocation(line: 1545, column: 25, scope: !2206)
!2206 = distinct !DILexicalBlock(scope: !2207, file: !2, line: 1545, column: 17)
!2207 = distinct !DILexicalBlock(scope: !2199, file: !2, line: 1544, column: 64)
!2208 = !DILocation(line: 1545, column: 45, scope: !2206)
!2209 = !{!2210, !531, i64 0}
!2210 = !{!"", !531, i64 0, !985, i64 8, !531, i64 16}
!2211 = !DILocation(line: 1545, column: 23, scope: !2206)
!2212 = !DILocation(line: 1545, column: 23, scope: !2206, atomGroup: 607, atomRank: 2)
!2213 = !DILocation(line: 1544, column: 60, scope: !2199, atomGroup: 610, atomRank: 2)
!2214 = !DILocation(line: 1545, column: 23, scope: !2206, atomGroup: 607, atomRank: 1)
!2215 = !DILocation(line: 1546, column: 46, scope: !2216)
!2216 = distinct !DILexicalBlock(scope: !2206, file: !2, line: 1545, column: 51)
!2217 = !DILocation(line: 1546, column: 46, scope: !2216, atomGroup: 608, atomRank: 2)
!2218 = !{!2210, !985, i64 8}
!2219 = !DILocation(line: 1547, column: 17, scope: !2216, atomGroup: 609, atomRank: 1)
!2220 = !DILocation(line: 1550, column: 14, scope: !2221, atomGroup: 612, atomRank: 2)
!2221 = distinct !DILexicalBlock(scope: !958, file: !2, line: 1550, column: 13)
!2222 = !DILocation(line: 1550, column: 13, scope: !2221, atomGroup: 612, atomRank: 1)
!2223 = !DILocation(line: 1554, column: 16, scope: !958)
!2224 = !DILocation(line: 1556, column: 49, scope: !958, atomGroup: 614, atomRank: 1)
!2225 = !DILocation(line: 1558, column: 49, scope: !958)
!2226 = !DILocation(line: 1556, column: 16, scope: !958)
!2227 = !DILocation(line: 1563, column: 16, scope: !958)
!2228 = !DILocation(line: 1552, column: 9, scope: !958)
!2229 = !DILocation(line: 1576, column: 9, scope: !958)
!2230 = !DILocation(line: 1578, column: 9, scope: !958)
!2231 = !DILocation(line: 1581, column: 19, scope: !958)
!2232 = !DILocation(line: 1581, column: 28, scope: !958)
!2233 = !DILocation(line: 1581, column: 37, scope: !958)
!2234 = !DILocation(line: 1581, column: 46, scope: !958)
!2235 = !DILocation(line: 1581, column: 55, scope: !958)
!2236 = !DILocation(line: 1581, column: 67, scope: !958)
!2237 = !DILocation(line: 1579, column: 9, scope: !958)
!2238 = !DILocation(line: 1584, column: 19, scope: !958)
!2239 = !DILocation(line: 1584, column: 31, scope: !958)
!2240 = !DILocation(line: 1584, column: 43, scope: !958)
!2241 = !DILocation(line: 1584, column: 55, scope: !958)
!2242 = !DILocation(line: 1585, column: 19, scope: !958)
!2243 = !DILocation(line: 1585, column: 31, scope: !958)
!2244 = !DILocation(line: 1582, column: 9, scope: !958)
!2245 = !DILocation(line: 1586, column: 5, scope: !958)
!2246 = !DILocation(line: 1589, column: 9, scope: !2247, atomGroup: 620, atomRank: 2)
!2247 = distinct !DILexicalBlock(scope: !534, file: !2, line: 1589, column: 9)
!2248 = !DILocation(line: 1589, column: 18, scope: !2247, atomGroup: 620, atomRank: 1)
!2249 = !DILocation(line: 1590, column: 13, scope: !2247)
!2250 = !DILocation(line: 1590, column: 28, scope: !2247)
!2251 = !DILocation(line: 1590, column: 22, scope: !2247, atomGroup: 623, atomRank: 2)
!2252 = !DILocation(line: 1590, column: 37, scope: !2247, atomGroup: 623, atomRank: 1)
!2253 = !DILocation(line: 1590, column: 40, scope: !2247)
!2254 = !DILocation(line: 1590, column: 40, scope: !2247, atomGroup: 672, atomRank: 2)
!2255 = !DILocation(line: 1589, column: 50, scope: !2247, atomGroup: 672, atomRank: 1)
!2256 = !DILocation(line: 1591, column: 9, scope: !2257)
!2257 = distinct !DILexicalBlock(scope: !2247, file: !2, line: 1590, column: 62)
!2258 = !DILocation(line: 1593, column: 16, scope: !2259)
!2259 = distinct !DILexicalBlock(scope: !2257, file: !2, line: 1593, column: 13)
!2260 = !{!979, !970, i64 8}
!2261 = !DILocation(line: 1593, column: 13, scope: !2259, atomGroup: 673, atomRank: 2)
!2262 = !DILocation(line: 1593, column: 13, scope: !2259, atomGroup: 673, atomRank: 1)
!2263 = !DILocation(line: 1594, column: 23, scope: !2264, atomGroup: 674, atomRank: 1)
!2264 = distinct !DILexicalBlock(scope: !2265, file: !2, line: 1594, column: 17)
!2265 = distinct !DILexicalBlock(scope: !2259, file: !2, line: 1593, column: 25)
!2266 = !DILocation(line: 1597, column: 24, scope: !2264)
!2267 = !DILocation(line: 1597, column: 56, scope: !2264)
!2268 = !DILocation(line: 1595, column: 17, scope: !2264)
!2269 = !DILocation(line: 1598, column: 13, scope: !2265, atomGroup: 675, atomRank: 1)
!2270 = !DILocation(line: 1602, column: 18, scope: !534, atomGroup: 676, atomRank: 2)
!2271 = !DILocation(line: 1602, column: 8, scope: !534)
!2272 = !DILocation(line: 1602, column: 16, scope: !534, atomGroup: 676, atomRank: 1)
!2273 = !DILocation(line: 1603, column: 5, scope: !534, atomGroup: 677, atomRank: 1)
!2274 = !DILocation(line: 1604, column: 1, scope: !534)
!2275 = !DILocation(line: 1605, column: 13, scope: !964, atomGroup: 678, atomRank: 2)
!2276 = !DILocation(line: 1605, column: 13, scope: !964, atomGroup: 678, atomRank: 1)
!2277 = !DILocation(line: 1606, column: 30, scope: !963)
!2278 = !DILocation(line: 1606, column: 25, scope: !963)
!2279 = !DILocation(line: 1606, column: 20, scope: !963, atomGroup: 679, atomRank: 3)
!2280 = !DILocation(line: 1606, column: 20, scope: !963, atomGroup: 679, atomRank: 2)
!2281 = !DILocation(line: 0, scope: !963)
!2282 = !DILocation(line: 1607, column: 30, scope: !963)
!2283 = !DILocation(line: 1607, column: 25, scope: !963)
!2284 = !DILocation(line: 1607, column: 20, scope: !963, atomGroup: 680, atomRank: 3)
!2285 = !DILocation(line: 1607, column: 20, scope: !963, atomGroup: 680, atomRank: 2)
!2286 = !DILocation(line: 1610, column: 17, scope: !2287)
!2287 = distinct !DILexicalBlock(scope: !963, file: !2, line: 1610, column: 13)
!2288 = !DILocation(line: 1610, column: 38, scope: !2287)
!2289 = !DILocation(line: 1610, column: 43, scope: !2287)
!2290 = !DILocation(line: 1610, column: 32, scope: !2287, atomGroup: 682, atomRank: 2)
!2291 = !DILocation(line: 1610, column: 32, scope: !2287, atomGroup: 682, atomRank: 1)
!2292 = !DILocation(line: 1611, column: 13, scope: !2287, atomGroup: 683, atomRank: 1)
!2293 = !DILocation(line: 1613, column: 33, scope: !963)
!2294 = !DILocation(line: 1613, column: 50, scope: !963)
!2295 = !DILocation(line: 1613, column: 15, scope: !963, atomGroup: 684, atomRank: 2)
!2296 = !DILocation(line: 1615, column: 17, scope: !2297, atomGroup: 685, atomRank: 2)
!2297 = distinct !DILexicalBlock(scope: !963, file: !2, line: 1615, column: 13)
!2298 = !DILocation(line: 1615, column: 17, scope: !2297, atomGroup: 685, atomRank: 1)
!2299 = !DILocation(line: 1616, column: 13, scope: !2297, atomGroup: 686, atomRank: 1)
!2300 = !DILocation(line: 1620, column: 56, scope: !963)
!2301 = !DILocation(line: 1620, column: 76, scope: !963)
!2302 = !DILocation(line: 1618, column: 34, scope: !963, atomGroup: 687, atomRank: 2)
!2303 = !DILocation(line: 1618, column: 12, scope: !963)
!2304 = !DILocation(line: 1618, column: 32, scope: !963, atomGroup: 687, atomRank: 1)
!2305 = !DILocation(line: 1621, column: 14, scope: !2306, atomGroup: 688, atomRank: 2)
!2306 = distinct !DILexicalBlock(scope: !963, file: !2, line: 1621, column: 13)
!2307 = !DILocation(line: 1621, column: 13, scope: !2306, atomGroup: 688, atomRank: 1)
!2308 = !DILocation(line: 1622, column: 13, scope: !2306, atomGroup: 689, atomRank: 1)
!2309 = !DILocation(line: 1626, column: 62, scope: !963)
!2310 = !DILocation(line: 1624, column: 34, scope: !963, atomGroup: 690, atomRank: 2)
!2311 = !DILocation(line: 1624, column: 9, scope: !963)
!2312 = !DILocation(line: 1624, column: 32, scope: !963, atomGroup: 690, atomRank: 1)
!2313 = !DILocation(line: 1627, column: 14, scope: !2314, atomGroup: 691, atomRank: 2)
!2314 = distinct !DILexicalBlock(scope: !963, file: !2, line: 1627, column: 13)
!2315 = !DILocation(line: 1627, column: 13, scope: !2314, atomGroup: 691, atomRank: 1)
!2316 = !DILocation(line: 1628, column: 13, scope: !2314, atomGroup: 692, atomRank: 1)
!2317 = !DILocation(line: 1629, column: 9, scope: !963, atomGroup: 693, atomRank: 1)
!2318 = !DILocation(line: 1631, column: 5, scope: !534, atomGroup: 694, atomRank: 1)
!2319 = !DILocation(line: 1632, column: 1, scope: !534)
!2320 = !DILocation(line: 1632, column: 1, scope: !534, atomGroup: 695, atomRank: 1)

define dso_local i32 @patch() {
entry:
  ret i32 0
}
