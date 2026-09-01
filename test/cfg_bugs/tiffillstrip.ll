; ModuleID = '/home/rjs2247/workspace/patchverification/examples/libtiff/tif003/build/tif_read.ll'
source_filename = "../../libtiff/tif_read.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@TIFFFillStrip.module = external hidden constant [14 x i8], align 1
@.str.3 = external hidden unnamed_addr constant [39 x i8], align 1
@.str.5 = external hidden unnamed_addr constant [52 x i8], align 1
@.str.7 = external hidden unnamed_addr constant [39 x i8], align 1
@TIFFReadBufferSetup.module = external hidden constant [20 x i8], align 16
@.str.13 = external hidden unnamed_addr constant [35 x i8], align 1
@.str.14 = external hidden unnamed_addr constant [25 x i8], align 1
@__PRETTY_FUNCTION__.TIFFReadBufferSetup = external hidden unnamed_addr constant [50 x i8], align 1
@.str.15 = external hidden unnamed_addr constant [20 x i8], align 1
@.str.16 = external hidden unnamed_addr constant [40 x i8], align 1
@.str.28 = external hidden unnamed_addr constant [38 x i8], align 1
@__PRETTY_FUNCTION__.TIFFReadAndRealloc = external hidden unnamed_addr constant [80 x i8], align 1
@.str.29 = external hidden unnamed_addr constant [55 x i8], align 1
@.str.30 = external hidden unnamed_addr constant [67 x i8], align 1
@__PRETTY_FUNCTION__.TIFFReadRawStrip1 = external hidden unnamed_addr constant [77 x i8], align 1
@.str.31 = external hidden unnamed_addr constant [36 x i8], align 1
@.str.32 = external hidden unnamed_addr constant [65 x i8], align 1
@.str.33 = external hidden unnamed_addr constant [15 x i8], align 1
@__PRETTY_FUNCTION__.TIFFReadRawStripOrTile2 = external hidden unnamed_addr constant [80 x i8], align 1
@.str.34 = external hidden unnamed_addr constant [38 x i8], align 1

; Function Attrs: nounwind uwtable
define hidden fastcc noundef i64 @TIFFReadRawStrip1(ptr noundef %tif, i32 noundef %strip, ptr noundef %buf, i64 noundef %size, ptr noundef %module) unnamed_addr #0 {
entry:
  %tif_flags = getelementptr inbounds nuw i8, ptr %tif, i64 16
  %0 = load i32, ptr %tif_flags, align 8, !tbaa !7
  %and = and i32 %0, 131072
  %cmp = icmp eq i32 %and, 0
  br i1 %cmp, label %if.end, label %if.else

if.else:                                          ; preds = %entry
  call void @__assert_fail(ptr noundef nonnull @.str.13, ptr noundef nonnull @.str.14, i32 noundef 596, ptr noundef nonnull @__PRETTY_FUNCTION__.TIFFReadRawStrip1) #5
  unreachable

if.end:                                           ; preds = %entry
  %and2 = and i32 %0, 2048
  %cmp3.not = icmp eq i32 %and2, 0
  br i1 %cmp3.not, label %if.then4, label %if.else15

if.then4:                                         ; preds = %if.end
  %call = call i64 @TIFFGetStrileOffset(ptr noundef %tif, i32 noundef %strip) #6
  %call5 = call i32 @_TIFFSeekOK(ptr noundef %tif, i64 noundef %call) #6
  %tobool.not = icmp eq i32 %call5, 0
  br i1 %tobool.not, label %if.then6, label %if.end7

if.then6:                                         ; preds = %if.then4
  %tif_clientdata = getelementptr inbounds nuw i8, ptr %tif, i64 1112
  %1 = load ptr, ptr %tif_clientdata, align 8, !tbaa !19
  %tif_row = getelementptr inbounds nuw i8, ptr %tif, i64 796
  %2 = load i32, ptr %tif_row, align 4, !tbaa !20
  call void (ptr, ptr, ptr, ...) @TIFFErrorExt(ptr noundef %1, ptr noundef %module, ptr noundef nonnull @.str.31, i32 noundef %2, i32 noundef %strip) #6
  br label %cleanup

if.end7:                                          ; preds = %if.then4
  %tif_readproc = getelementptr inbounds nuw i8, ptr %tif, i64 1120
  %3 = load ptr, ptr %tif_readproc, align 8, !tbaa !21
  %tif_clientdata8 = getelementptr inbounds nuw i8, ptr %tif, i64 1112
  %4 = load ptr, ptr %tif_clientdata8, align 8, !tbaa !19
  %call9 = call i64 %3(ptr noundef %4, ptr noundef %buf, i64 noundef %size) #6
  %cmp10.not = icmp eq i64 %call9, %size
  br i1 %cmp10.not, label %if.end14, label %if.then11

if.then11:                                        ; preds = %if.end7
  %5 = load ptr, ptr %tif_clientdata8, align 8, !tbaa !19
  %tif_row13 = getelementptr inbounds nuw i8, ptr %tif, i64 796
  %6 = load i32, ptr %tif_row13, align 4, !tbaa !20
  call void (ptr, ptr, ptr, ...) @TIFFErrorExt(ptr noundef %5, ptr noundef %module, ptr noundef nonnull @.str.29, i32 noundef %6, i64 noundef %call9, i64 noundef %size) #6
  br label %cleanup

if.end14:                                         ; preds = %if.end7
  br label %cleanup

cleanup:                                          ; preds = %if.end14, %if.then11, %if.then6
  %cleanup.dest.slot.0 = phi i1 [ true, %if.then11 ], [ false, %if.end14 ], [ true, %if.then6 ]
  switch i1 %cleanup.dest.slot.0, label %default.unreachable [
    i1 false, label %if.end43
    i1 true, label %return
  ]

if.else15:                                        ; preds = %if.end
  %call16 = call i64 @TIFFGetStrileOffset(ptr noundef %tif, i32 noundef %strip) #6
  %cmp17 = icmp slt i64 %call16, 0
  br i1 %cmp17, label %if.then20, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %if.else15
  %call18 = call i64 @TIFFGetStrileOffset(ptr noundef %tif, i32 noundef %strip) #6
  %tif_size = getelementptr inbounds nuw i8, ptr %tif, i64 1088
  %7 = load i64, ptr %tif_size, align 8, !tbaa !22
  %cmp19 = icmp sgt i64 %call18, %7
  br i1 %cmp19, label %if.then20, label %if.else21

if.then20:                                        ; preds = %lor.lhs.false, %if.else15
  %ma.0 = phi i64 [ 0, %if.else15 ], [ %call18, %lor.lhs.false ]
  br label %if.end33

if.else21:                                        ; preds = %lor.lhs.false
  %sub = sub nsw i64 9223372036854775807, %size
  %cmp22 = icmp sgt i64 %call18, %sub
  br i1 %cmp22, label %if.then23, label %if.else24

if.then23:                                        ; preds = %if.else21
  br label %if.end33

if.else24:                                        ; preds = %if.else21
  %add = add nsw i64 %call18, %size
  %cmp26 = icmp sgt i64 %add, %7
  br i1 %cmp26, label %if.then27, label %if.else30

if.then27:                                        ; preds = %if.else24
  %sub29 = sub nsw i64 %7, %call18
  br label %if.end31

if.else30:                                        ; preds = %if.else24
  br label %if.end31

if.end31:                                         ; preds = %if.else30, %if.then27
  %n.0 = phi i64 [ %sub29, %if.then27 ], [ %size, %if.else30 ]
  br label %if.end33

if.end33:                                         ; preds = %if.end31, %if.then23, %if.then20
  %ma.1 = phi i64 [ %ma.0, %if.then20 ], [ %call18, %if.then23 ], [ %call18, %if.end31 ]
  %n.1 = phi i64 [ 0, %if.then20 ], [ 0, %if.then23 ], [ %n.0, %if.end31 ]
  %cmp34.not = icmp ne i64 %n.1, %size
  br i1 %cmp34.not, label %if.then35, label %if.end38

if.then35:                                        ; preds = %if.end33
  %tif_clientdata36 = getelementptr inbounds nuw i8, ptr %tif, i64 1112
  %8 = load ptr, ptr %tif_clientdata36, align 8, !tbaa !19
  %tif_row37 = getelementptr inbounds nuw i8, ptr %tif, i64 796
  %9 = load i32, ptr %tif_row37, align 4, !tbaa !20
  call void (ptr, ptr, ptr, ...) @TIFFErrorExt(ptr noundef %8, ptr noundef %module, ptr noundef nonnull @.str.32, i32 noundef %9, i32 noundef %strip, i64 noundef %n.1, i64 noundef %size) #6
  br label %cleanup39

if.end38:                                         ; preds = %if.end33
  %tif_base = getelementptr inbounds nuw i8, ptr %tif, i64 1080
  %10 = load ptr, ptr %tif_base, align 8, !tbaa !23
  %add.ptr = getelementptr inbounds i8, ptr %10, i64 %ma.1
  call void @_TIFFmemcpy(ptr noundef %buf, ptr noundef %add.ptr, i64 noundef %size) #6
  br label %cleanup39

cleanup39:                                        ; preds = %if.end38, %if.then35
  switch i1 %cmp34.not, label %default.unreachable [
    i1 false, label %if.end43
    i1 true, label %return
  ]

if.end43:                                         ; preds = %cleanup39, %cleanup
  br label %return

return:                                           ; preds = %if.end43, %cleanup39, %cleanup
  %retval.2 = phi i64 [ %size, %if.end43 ], [ -1, %cleanup39 ], [ -1, %cleanup ]
  ret i64 %retval.2

default.unreachable:                              ; preds = %cleanup39, %cleanup
  unreachable
}

declare void @TIFFReverseBits(ptr noundef, i64 noundef) local_unnamed_addr #1

; Function Attrs: nounwind uwtable
define dso_local range(i32 0, 2) i32 @TIFFFillStrip(ptr noundef %tif, i32 noundef %strip) local_unnamed_addr #0 {
entry:
  %tif_flags = getelementptr inbounds nuw i8, ptr %tif, i64 16
  %0 = load i32, ptr %tif_flags, align 8, !tbaa !7
  %and = and i32 %0, 131072
  %cmp = icmp eq i32 %and, 0
  br i1 %cmp, label %if.then, label %if.end136

if.then:                                          ; preds = %entry
  %call = call i64 @TIFFGetStrileByteCount(ptr noundef %tif, i32 noundef %strip) #6
  %or.cond = icmp slt i64 %call, 1
  br i1 %or.cond, label %if.then3, label %if.end

if.then3:                                         ; preds = %if.then
  %tif_clientdata = getelementptr inbounds nuw i8, ptr %tif, i64 1112
  %1 = load ptr, ptr %tif_clientdata, align 8, !tbaa !19
  call void (ptr, ptr, ptr, ...) @TIFFErrorExt(ptr noundef %1, ptr noundef nonnull @TIFFFillStrip.module, ptr noundef nonnull @.str.3, i64 noundef %call, i32 noundef %strip) #6
  br label %cleanup133

if.end:                                           ; preds = %if.then
  %cmp4 = icmp ugt i64 %call, 1048576
  br i1 %cmp4, label %if.then5, label %if.end17

if.then5:                                         ; preds = %if.end
  %call6 = call i64 @TIFFStripSize(ptr noundef %tif) #6
  br label %if.end16

land.lhs.true:                                    ; No predecessors!
  br label %if.end16

if.then9:                                         ; No predecessors!
  br label %if.end15

if.end15:                                         ; preds = %if.then9
  br label %if.end16

if.end16:                                         ; preds = %if.end15, %land.lhs.true, %if.then5
  br label %if.end17

if.end17:                                         ; preds = %if.end16, %if.end
  %2 = load i32, ptr %tif_flags, align 8, !tbaa !7
  %and19 = and i32 %2, 2048
  %cmp20.not = icmp eq i32 %and19, 0
  br i1 %cmp20.not, label %if.end34, label %if.then21

if.then21:                                        ; preds = %if.end17
  %tif_size = getelementptr inbounds nuw i8, ptr %tif, i64 1088
  %3 = load i64, ptr %tif_size, align 8, !tbaa !22
  %cmp22 = icmp ugt i64 %call, %3
  br i1 %cmp22, label %if.then28, label %lor.lhs.false23

lor.lhs.false23:                                  ; preds = %if.then21
  %call24 = call i64 @TIFFGetStrileOffset(ptr noundef %tif, i32 noundef %strip) #6
  %4 = load i64, ptr %tif_size, align 8, !tbaa !22
  %sub26 = sub i64 %4, %call
  %cmp27 = icmp ugt i64 %call24, %sub26
  br i1 %cmp27, label %if.then28, label %if.end34

if.then28:                                        ; preds = %lor.lhs.false23, %if.then21
  %tif_clientdata29 = getelementptr inbounds nuw i8, ptr %tif, i64 1112
  %5 = load ptr, ptr %tif_clientdata29, align 8, !tbaa !19
  %6 = load i64, ptr %tif_size, align 8, !tbaa !22
  %call31 = call i64 @TIFFGetStrileOffset(ptr noundef %tif, i32 noundef %strip) #6
  %call32 = call fastcc i64 @NoSanitizeSubUInt64(i64 noundef %6, i64 noundef %call31)
  call void (ptr, ptr, ptr, ...) @TIFFErrorExt(ptr noundef %5, ptr noundef nonnull @TIFFFillStrip.module, ptr noundef nonnull @.str.5, i32 noundef %strip, i64 noundef %call32, i64 noundef %call) #6
  %tif_curstrip = getelementptr inbounds nuw i8, ptr %tif, i64 804
  store i32 -1, ptr %tif_curstrip, align 4, !tbaa !24
  br label %cleanup133

if.end34:                                         ; preds = %lor.lhs.false23, %if.end17
  %7 = load i32, ptr %tif_flags, align 8, !tbaa !7
  %and36 = and i32 %7, 2048
  %cmp37.not = icmp eq i32 %and36, 0
  br i1 %cmp37.not, label %if.else, label %land.lhs.true38

land.lhs.true38:                                  ; preds = %if.end34
  %td_fillorder = getelementptr inbounds nuw i8, ptr %tif, i64 126
  %8 = load i16, ptr %td_fillorder, align 2, !tbaa !25
  %conv = zext i16 %8 to i32
  %and40 = and i32 %conv, %7
  %cmp41.not = icmp eq i32 %and40, 0
  br i1 %cmp41.not, label %lor.lhs.false43, label %if.then46

lor.lhs.false43:                                  ; preds = %land.lhs.true38
  %and45 = and i32 %7, 256
  %tobool.not = icmp eq i32 %and45, 0
  br i1 %tobool.not, label %if.else, label %if.then46

if.then46:                                        ; preds = %lor.lhs.false43, %land.lhs.true38
  %9 = load i32, ptr %tif_flags, align 8, !tbaa !7
  %and48 = and i32 %9, 512
  %tobool49.not = icmp eq i32 %and48, 0
  br i1 %tobool49.not, label %if.end55, label %land.lhs.true50

land.lhs.true50:                                  ; preds = %if.then46
  %tif_rawdata = getelementptr inbounds nuw i8, ptr %tif, i64 1032
  %10 = load ptr, ptr %tif_rawdata, align 8, !tbaa !26
  %tobool51.not = icmp eq ptr %10, null
  br i1 %tobool51.not, label %if.end55, label %if.then52

if.then52:                                        ; preds = %land.lhs.true50
  call void @_TIFFfree(ptr noundef nonnull %10) #6
  call void @llvm.memset.p0.i64(ptr align 8 %tif_rawdata, i8 0, i64 16, i1 false)
  br label %if.end55

if.end55:                                         ; preds = %if.then52, %land.lhs.true50, %if.then46
  %11 = load i32, ptr %tif_flags, align 8, !tbaa !7
  %and57 = and i32 %11, -513
  store i32 %and57, ptr %tif_flags, align 8, !tbaa !7
  %tif_rawdatasize58 = getelementptr inbounds nuw i8, ptr %tif, i64 1040
  store i64 %call, ptr %tif_rawdatasize58, align 8, !tbaa !27
  %tif_base = getelementptr inbounds nuw i8, ptr %tif, i64 1080
  %12 = load ptr, ptr %tif_base, align 8, !tbaa !23
  %call59 = call i64 @TIFFGetStrileOffset(ptr noundef %tif, i32 noundef %strip) #6
  %add.ptr = getelementptr inbounds i8, ptr %12, i64 %call59
  %tif_rawdata60 = getelementptr inbounds nuw i8, ptr %tif, i64 1032
  store ptr %add.ptr, ptr %tif_rawdata60, align 8, !tbaa !26
  %tif_rawdataoff = getelementptr inbounds nuw i8, ptr %tif, i64 1048
  store i64 0, ptr %tif_rawdataoff, align 8, !tbaa !28
  %tif_rawdataloaded = getelementptr inbounds nuw i8, ptr %tif, i64 1056
  store i64 %call, ptr %tif_rawdataloaded, align 8, !tbaa !29
  %13 = load i32, ptr %tif_flags, align 8, !tbaa !7
  %or = or i32 %13, 8388608
  store i32 %or, ptr %tif_flags, align 8, !tbaa !7
  br label %if.end132

if.else:                                          ; preds = %lor.lhs.false43, %if.end34
  br label %if.end66

if.end66:                                         ; preds = %if.else
  %tif_rawdatasize67 = getelementptr inbounds nuw i8, ptr %tif, i64 1040
  %14 = load i64, ptr %tif_rawdatasize67, align 8, !tbaa !27
  %cmp68 = icmp sgt i64 %call, %14
  br i1 %cmp68, label %if.then70, label %if.end79

if.then70:                                        ; preds = %if.end66
  %tif_curstrip71 = getelementptr inbounds nuw i8, ptr %tif, i64 804
  store i32 -1, ptr %tif_curstrip71, align 4, !tbaa !24
  %15 = load i32, ptr %tif_flags, align 8, !tbaa !7
  %and73 = and i32 %15, 512
  %cmp74 = icmp eq i32 %and73, 0
  br i1 %cmp74, label %if.then76, label %if.end79

if.then76:                                        ; preds = %if.then70
  %tif_clientdata77 = getelementptr inbounds nuw i8, ptr %tif, i64 1112
  %16 = load ptr, ptr %tif_clientdata77, align 8, !tbaa !19
  call void (ptr, ptr, ptr, ...) @TIFFErrorExt(ptr noundef %16, ptr noundef nonnull @TIFFFillStrip.module, ptr noundef nonnull @.str.7, i32 noundef %strip) #6
  br label %cleanup

if.end79:                                         ; preds = %if.then70, %if.end66
  %17 = load i32, ptr %tif_flags, align 8, !tbaa !7
  %and81 = and i32 %17, 8388608
  %tobool82.not = icmp eq i32 %and81, 0
  br i1 %tobool82.not, label %if.end89, label %if.then83

if.then83:                                        ; preds = %if.end79
  %tif_curstrip84 = getelementptr inbounds nuw i8, ptr %tif, i64 804
  store i32 -1, ptr %tif_curstrip84, align 4, !tbaa !24
  %tif_rawdata85 = getelementptr inbounds nuw i8, ptr %tif, i64 1032
  call void @llvm.memset.p0.i64(ptr align 8 %tif_rawdata85, i8 0, i64 16, i1 false)
  %18 = load i32, ptr %tif_flags, align 8, !tbaa !7
  %and88 = and i32 %18, -8388609
  store i32 %and88, ptr %tif_flags, align 8, !tbaa !7
  br label %if.end89

if.end89:                                         ; preds = %if.then83, %if.end79
  %19 = load i32, ptr %tif_flags, align 8, !tbaa !7
  %and91 = and i32 %19, 2048
  %cmp92.not = icmp eq i32 %and91, 0
  br i1 %cmp92.not, label %if.else109, label %if.then94

if.then94:                                        ; preds = %if.end89
  %20 = load i64, ptr %tif_rawdatasize67, align 8, !tbaa !27
  %cmp96 = icmp sgt i64 %call, %20
  br i1 %cmp96, label %land.lhs.true98, label %if.end102

land.lhs.true98:                                  ; preds = %if.then94
  %call99 = call i32 @TIFFReadBufferSetup(ptr noundef %tif, ptr noundef null, i64 noundef %call)
  %tobool100.not = icmp eq i32 %call99, 0
  br i1 %tobool100.not, label %if.then101, label %if.end102

if.then101:                                       ; preds = %land.lhs.true98
  br label %cleanup

if.end102:                                        ; preds = %land.lhs.true98, %if.then94
  %tif_rawdata103 = getelementptr inbounds nuw i8, ptr %tif, i64 1032
  %21 = load ptr, ptr %tif_rawdata103, align 8, !tbaa !26
  %call104 = call fastcc i64 @TIFFReadRawStrip1(ptr noundef %tif, i32 noundef %strip, ptr noundef %21, i64 noundef %call, ptr noundef nonnull @TIFFFillStrip.module)
  %cmp105.not = icmp eq i64 %call104, %call
  br i1 %cmp105.not, label %if.end115, label %if.then107

if.then107:                                       ; preds = %if.end102
  br label %cleanup

if.else109:                                       ; preds = %if.end89
  %call110 = call fastcc i64 @TIFFReadRawStripOrTile2(ptr noundef %tif, i32 noundef %strip, i32 noundef 1, i64 noundef %call, ptr noundef nonnull @TIFFFillStrip.module)
  %cmp111.not = icmp eq i64 %call110, %call
  br i1 %cmp111.not, label %if.end115, label %if.then113

if.then113:                                       ; preds = %if.else109
  br label %cleanup

if.end115:                                        ; preds = %if.else109, %if.end102
  %tif_rawdataoff116 = getelementptr inbounds nuw i8, ptr %tif, i64 1048
  store i64 0, ptr %tif_rawdataoff116, align 8, !tbaa !28
  %tif_rawdataloaded117 = getelementptr inbounds nuw i8, ptr %tif, i64 1056
  store i64 %call, ptr %tif_rawdataloaded117, align 8, !tbaa !29
  %22 = load i32, ptr %tif_flags, align 8, !tbaa !7
  %td_fillorder119 = getelementptr inbounds nuw i8, ptr %tif, i64 126
  %23 = load i16, ptr %td_fillorder119, align 2, !tbaa !25
  %conv120 = zext i16 %23 to i32
  %and121 = and i32 %conv120, %22
  %cmp122.not = icmp eq i32 %and121, 0
  br i1 %cmp122.not, label %land.lhs.true124, label %if.end131

land.lhs.true124:                                 ; preds = %if.end115
  %and126 = and i32 %22, 256
  %cmp127 = icmp eq i32 %and126, 0
  br i1 %cmp127, label %if.then129, label %if.end131

if.then129:                                       ; preds = %land.lhs.true124
  %tif_rawdata130 = getelementptr inbounds nuw i8, ptr %tif, i64 1032
  %24 = load ptr, ptr %tif_rawdata130, align 8, !tbaa !26
  call void @TIFFReverseBits(ptr noundef %24, i64 noundef %call) #6
  br label %if.end131

if.end131:                                        ; preds = %if.then129, %land.lhs.true124, %if.end115
  br label %cleanup

cleanup:                                          ; preds = %if.end131, %if.then113, %if.then107, %if.then101, %if.then76
  %cond = phi i1 [ false, %if.then113 ], [ false, %if.then76 ], [ false, %if.then107 ], [ true, %if.end131 ], [ false, %if.then101 ]
  br i1 %cond, label %if.end132, label %cleanup133

if.end132:                                        ; preds = %cleanup, %if.end55
  br label %cleanup133

cleanup133:                                       ; preds = %if.end132, %cleanup, %if.then28, %if.then3
  %cond1 = phi i1 [ false, %if.then3 ], [ false, %if.then28 ], [ true, %if.end132 ], [ false, %cleanup ]
  br i1 %cond1, label %if.end136, label %cleanup138

if.end136:                                        ; preds = %cleanup133, %entry
  %call137 = call fastcc i32 @TIFFStartStrip(ptr noundef %tif, i32 noundef %strip)
  br label %cleanup138

cleanup138:                                       ; preds = %if.end136, %cleanup133
  %retval.3 = phi i32 [ %call137, %if.end136 ], [ 0, %cleanup133 ]
  ret i32 %retval.3
}

declare void @TIFFErrorExt(ptr noundef, ptr noundef, ptr noundef, ...) local_unnamed_addr #1

declare i64 @TIFFGetStrileByteCount(ptr noundef, i32 noundef) local_unnamed_addr #1

declare i64 @TIFFStripSize(ptr noundef) local_unnamed_addr #1

declare i64 @TIFFGetStrileOffset(ptr noundef, i32 noundef) local_unnamed_addr #1

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none) uwtable
define hidden fastcc noundef i64 @NoSanitizeSubUInt64(i64 noundef %a, i64 noundef %b) unnamed_addr #2 {
entry:
  %sub = sub i64 %a, %b
  ret i64 %sub
}

declare void @_TIFFfree(ptr noundef) local_unnamed_addr #1

; Function Attrs: nounwind uwtable
define dso_local range(i32 0, 2) i32 @TIFFReadBufferSetup(ptr nofree noundef captures(none) %tif, ptr noundef %bp, i64 noundef %size) local_unnamed_addr #0 {
entry:
  %tif_flags = getelementptr inbounds nuw i8, ptr %tif, i64 16
  %0 = load i32, ptr %tif_flags, align 8, !tbaa !7
  %and = and i32 %0, 131072
  %cmp = icmp eq i32 %and, 0
  br i1 %cmp, label %if.end, label %if.else

if.else:                                          ; preds = %entry
  call void @__assert_fail(ptr noundef nonnull @.str.13, ptr noundef nonnull @.str.14, i32 noundef 1290, ptr noundef nonnull @__PRETTY_FUNCTION__.TIFFReadBufferSetup) #5
  unreachable

if.end:                                           ; preds = %entry
  %and2 = and i32 %0, -8519681
  store i32 %and2, ptr %tif_flags, align 8, !tbaa !7
  %tif_rawdata = getelementptr inbounds nuw i8, ptr %tif, i64 1032
  %1 = load ptr, ptr %tif_rawdata, align 8, !tbaa !26
  %tobool.not = icmp eq ptr %1, null
  br i1 %tobool.not, label %if.end11, label %if.then3

if.then3:                                         ; preds = %if.end
  %and5 = and i32 %0, 512
  %tobool6.not = icmp eq i32 %and5, 0
  br i1 %tobool6.not, label %if.end9, label %if.then7

if.then7:                                         ; preds = %if.then3
  call void @_TIFFfree(ptr noundef nonnull %1) #6
  br label %if.end9

if.end9:                                          ; preds = %if.then7, %if.then3
  call void @llvm.memset.p0.i64(ptr align 8 %tif_rawdata, i8 0, i64 16, i1 false)
  br label %if.end11

if.end11:                                         ; preds = %if.end9, %if.end
  %tobool12.not = icmp eq ptr %bp, null
  br i1 %tobool12.not, label %if.else18, label %if.then13

if.then13:                                        ; preds = %if.end11
  %tif_rawdatasize14 = getelementptr inbounds nuw i8, ptr %tif, i64 1040
  store i64 %size, ptr %tif_rawdatasize14, align 8, !tbaa !27
  store ptr %bp, ptr %tif_rawdata, align 8, !tbaa !26
  %2 = load i32, ptr %tif_flags, align 8, !tbaa !7
  %and17 = and i32 %2, -513
  br label %if.end27

if.else18:                                        ; preds = %if.end11
  %add = add i64 %size, 1023
  %div22 = and i64 %add, -1024
  %tif_rawdatasize19 = getelementptr inbounds nuw i8, ptr %tif, i64 1040
  store i64 %div22, ptr %tif_rawdatasize19, align 8, !tbaa !27
  %cmp21 = icmp eq i64 %div22, 0
  br i1 %cmp21, label %if.then22, label %if.end23

if.then22:                                        ; preds = %if.else18
  %tif_clientdata = getelementptr inbounds nuw i8, ptr %tif, i64 1112
  %3 = load ptr, ptr %tif_clientdata, align 8, !tbaa !19
  call void (ptr, ptr, ptr, ...) @TIFFErrorExt(ptr noundef %3, ptr noundef nonnull @TIFFReadBufferSetup.module, ptr noundef nonnull @.str.15) #6
  br label %return

if.end23:                                         ; preds = %if.else18
  %call = call ptr @_TIFFcalloc(i64 noundef 1, i64 noundef %div22) #6
  store ptr %call, ptr %tif_rawdata, align 8, !tbaa !26
  %4 = load i32, ptr %tif_flags, align 8, !tbaa !7
  %or = or i32 %4, 512
  br label %if.end27

if.end27:                                         ; preds = %if.end23, %if.then13
  %storemerge = phi i32 [ %or, %if.end23 ], [ %and17, %if.then13 ]
  store i32 %storemerge, ptr %tif_flags, align 8, !tbaa !7
  %5 = load ptr, ptr %tif_rawdata, align 8, !tbaa !26
  %cmp29 = icmp eq ptr %5, null
  br i1 %cmp29, label %if.then30, label %if.end33

if.then30:                                        ; preds = %if.end27
  %tif_clientdata31 = getelementptr inbounds nuw i8, ptr %tif, i64 1112
  %6 = load ptr, ptr %tif_clientdata31, align 8, !tbaa !19
  %tif_row = getelementptr inbounds nuw i8, ptr %tif, i64 796
  %7 = load i32, ptr %tif_row, align 4, !tbaa !20
  call void (ptr, ptr, ptr, ...) @TIFFErrorExt(ptr noundef %6, ptr noundef nonnull @TIFFReadBufferSetup.module, ptr noundef nonnull @.str.16, i32 noundef %7) #6
  %tif_rawdatasize32 = getelementptr inbounds nuw i8, ptr %tif, i64 1040
  store i64 0, ptr %tif_rawdatasize32, align 8, !tbaa !27
  br label %return

if.end33:                                         ; preds = %if.end27
  br label %return

return:                                           ; preds = %if.end33, %if.then30, %if.then22
  %retval.0 = phi i32 [ 0, %if.then30 ], [ 1, %if.end33 ], [ 0, %if.then22 ]
  ret i32 %retval.0
}

; Function Attrs: nounwind uwtable
define hidden fastcc range(i64 -1, -9223372036854775808) i64 @TIFFReadRawStripOrTile2(ptr noundef %tif, i32 noundef %strip_or_tile, i32 noundef range(i32 0, 2) %is_strip, i64 noundef range(i64 1, -9223372036854775808) %size, ptr noundef %module) unnamed_addr #0 {
entry:
  %tif_flags = getelementptr inbounds nuw i8, ptr %tif, i64 16
  %0 = load i32, ptr %tif_flags, align 8, !tbaa !7
  %and = and i32 %0, 2048
  %cmp.not = icmp eq i32 %and, 0
  br i1 %cmp.not, label %if.end, label %if.else

if.else:                                          ; preds = %entry
  call void @__assert_fail(ptr noundef nonnull @.str.33, ptr noundef nonnull @.str.14, i32 noundef 654, ptr noundef nonnull @__PRETTY_FUNCTION__.TIFFReadRawStripOrTile2) #5
  unreachable

if.end:                                           ; preds = %entry
  %and2 = and i32 %0, 131072
  %cmp3 = icmp eq i32 %and2, 0
  br i1 %cmp3, label %if.end6, label %if.else5

if.else5:                                         ; preds = %if.end
  call void @__assert_fail(ptr noundef nonnull @.str.13, ptr noundef nonnull @.str.14, i32 noundef 655, ptr noundef nonnull @__PRETTY_FUNCTION__.TIFFReadRawStripOrTile2) #5
  unreachable

if.end6:                                          ; preds = %if.end
  %call = call i64 @TIFFGetStrileOffset(ptr noundef %tif, i32 noundef %strip_or_tile) #6
  %call7 = call i32 @_TIFFSeekOK(ptr noundef %tif, i64 noundef %call) #6
  %tobool.not = icmp eq i32 %call7, 0
  br i1 %tobool.not, label %if.then8, label %if.end15

if.then8:                                         ; preds = %if.end6
  %tobool9.not = icmp eq i32 %is_strip, 0
  br i1 %tobool9.not, label %if.else11, label %if.then10

if.then10:                                        ; preds = %if.then8
  %tif_clientdata = getelementptr inbounds nuw i8, ptr %tif, i64 1112
  %1 = load ptr, ptr %tif_clientdata, align 8, !tbaa !19
  %tif_row = getelementptr inbounds nuw i8, ptr %tif, i64 796
  %2 = load i32, ptr %tif_row, align 4, !tbaa !20
  call void (ptr, ptr, ptr, ...) @TIFFErrorExt(ptr noundef %1, ptr noundef %module, ptr noundef nonnull @.str.31, i32 noundef %2, i32 noundef %strip_or_tile) #6
  br label %if.end14

if.else11:                                        ; preds = %if.then8
  %tif_clientdata12 = getelementptr inbounds nuw i8, ptr %tif, i64 1112
  %3 = load ptr, ptr %tif_clientdata12, align 8, !tbaa !19
  %tif_row13 = getelementptr inbounds nuw i8, ptr %tif, i64 796
  %4 = load i32, ptr %tif_row13, align 4, !tbaa !20
  %tif_col = getelementptr inbounds nuw i8, ptr %tif, i64 840
  %5 = load i32, ptr %tif_col, align 8, !tbaa !30
  call void (ptr, ptr, ptr, ...) @TIFFErrorExt(ptr noundef %3, ptr noundef %module, ptr noundef nonnull @.str.34, i32 noundef %4, i32 noundef %5, i32 noundef %strip_or_tile) #6
  br label %if.end14

if.end14:                                         ; preds = %if.else11, %if.then10
  br label %return

if.end15:                                         ; preds = %if.end6
  %call16 = call fastcc i32 @TIFFReadAndRealloc(ptr noundef %tif, i64 noundef %size, i64 noundef 0, i32 noundef %is_strip, i32 noundef %strip_or_tile, ptr noundef %module)
  %tobool17.not = icmp eq i32 %call16, 0
  br i1 %tobool17.not, label %if.then18, label %if.end19

if.then18:                                        ; preds = %if.end15
  br label %return

if.end19:                                         ; preds = %if.end15
  br label %return

return:                                           ; preds = %if.end19, %if.then18, %if.end14
  %retval.0 = phi i64 [ %size, %if.end19 ], [ -1, %if.then18 ], [ -1, %if.end14 ]
  ret i64 %retval.0
}

; Function Attrs: nounwind uwtable
define hidden fastcc range(i32 0, 2) i32 @TIFFStartStrip(ptr noundef %tif, i32 noundef %strip) unnamed_addr #0 {
entry:
  %tif_flags = getelementptr inbounds nuw i8, ptr %tif, i64 16
  %0 = load i32, ptr %tif_flags, align 8, !tbaa !7
  %and = and i32 %0, 32
  %cmp = icmp eq i32 %and, 0
  br i1 %cmp, label %if.then, label %if.end3

if.then:                                          ; preds = %entry
  %tif_setupdecode = getelementptr inbounds nuw i8, ptr %tif, i64 872
  %1 = load ptr, ptr %tif_setupdecode, align 8, !tbaa !31
  %call = call i32 %1(ptr noundef %tif) #6
  %tobool.not = icmp eq i32 %call, 0
  br i1 %tobool.not, label %if.then1, label %if.end

if.then1:                                         ; preds = %if.then
  br label %cleanup

if.end:                                           ; preds = %if.then
  %2 = load i32, ptr %tif_flags, align 8, !tbaa !7
  %or = or i32 %2, 32
  store i32 %or, ptr %tif_flags, align 8, !tbaa !7
  br label %if.end3

if.end3:                                          ; preds = %if.end, %entry
  %tif_curstrip = getelementptr inbounds nuw i8, ptr %tif, i64 804
  store i32 %strip, ptr %tif_curstrip, align 4, !tbaa !24
  %td_stripsperimage = getelementptr inbounds nuw i8, ptr %tif, i64 224
  %3 = load i32, ptr %td_stripsperimage, align 8, !tbaa !32
  %rem = urem i32 %strip, %3
  %td_rowsperstrip = getelementptr inbounds nuw i8, ptr %tif, i64 132
  %4 = load i32, ptr %td_rowsperstrip, align 4, !tbaa !33
  %mul = mul i32 %4, %rem
  %tif_row = getelementptr inbounds nuw i8, ptr %tif, i64 796
  store i32 %mul, ptr %tif_row, align 4, !tbaa !20
  %5 = load i32, ptr %tif_flags, align 8, !tbaa !7
  %and5 = and i32 %5, -1048577
  store i32 %and5, ptr %tif_flags, align 8, !tbaa !7
  %and7 = and i32 %5, 131072
  %tobool8.not = icmp eq i32 %and7, 0
  br i1 %tobool8.not, label %if.else, label %if.then9

if.then9:                                         ; preds = %if.end3
  %tif_rawcp = getelementptr inbounds nuw i8, ptr %tif, i64 1064
  call void @llvm.memset.p0.i64(ptr align 8 %tif_rawcp, i8 0, i64 16, i1 false)
  br label %if.end19

if.else:                                          ; preds = %if.end3
  %tif_rawdata = getelementptr inbounds nuw i8, ptr %tif, i64 1032
  %6 = load ptr, ptr %tif_rawdata, align 8, !tbaa !26
  %tif_rawcp10 = getelementptr inbounds nuw i8, ptr %tif, i64 1064
  store ptr %6, ptr %tif_rawcp10, align 8, !tbaa !34
  %tif_rawdataloaded = getelementptr inbounds nuw i8, ptr %tif, i64 1056
  %7 = load i64, ptr %tif_rawdataloaded, align 8, !tbaa !29
  %cmp11 = icmp sgt i64 %7, 0
  br i1 %cmp11, label %if.then12, label %if.else15

if.then12:                                        ; preds = %if.else
  %tif_rawcc14 = getelementptr inbounds nuw i8, ptr %tif, i64 1072
  store i64 %7, ptr %tif_rawcc14, align 8, !tbaa !35
  br label %if.end19

if.else15:                                        ; preds = %if.else
  %call16 = call i64 @TIFFGetStrileByteCount(ptr noundef %tif, i32 noundef %strip) #6
  %tif_rawcc17 = getelementptr inbounds nuw i8, ptr %tif, i64 1072
  store i64 %call16, ptr %tif_rawcc17, align 8, !tbaa !35
  br label %if.end19

if.end19:                                         ; preds = %if.else15, %if.then12, %if.then9
  %tif_predecode = getelementptr inbounds nuw i8, ptr %tif, i64 880
  %8 = load ptr, ptr %tif_predecode, align 8, !tbaa !36
  %9 = load i32, ptr %td_stripsperimage, align 8, !tbaa !32
  %div = udiv i32 %strip, %9
  %conv = trunc i32 %div to i16
  %call21 = call i32 %8(ptr noundef %tif, i16 noundef zeroext %conv) #6
  %cmp22 = icmp eq i32 %call21, 0
  br i1 %cmp22, label %if.then24, label %if.end26

if.then24:                                        ; preds = %if.end19
  store i32 -1, ptr %tif_curstrip, align 4, !tbaa !24
  br label %cleanup

if.end26:                                         ; preds = %if.end19
  br label %cleanup

cleanup:                                          ; preds = %if.end26, %if.then24, %if.then1
  %retval.0 = phi i32 [ 0, %if.then24 ], [ 1, %if.end26 ], [ 0, %if.then1 ]
  ret i32 %retval.0
}

; Function Attrs: noreturn nounwind
declare void @__assert_fail(ptr noundef, ptr noundef, i32 noundef, ptr noundef) local_unnamed_addr #3

declare ptr @_TIFFcalloc(i64 noundef, i64 noundef) local_unnamed_addr #1

declare i32 @_TIFFSeekOK(ptr noundef, i64 noundef) local_unnamed_addr #1

; Function Attrs: nounwind uwtable
define hidden fastcc range(i32 0, 2) i32 @TIFFReadAndRealloc(ptr nofree noundef captures(none) %tif, i64 noundef %size, i64 noundef range(i64 -9223372036854775806, -9223372036854775808) %rawdata_offset, i32 noundef range(i32 0, 2) %is_strip, i32 noundef %strip_or_tile, ptr noundef %module) unnamed_addr #0 {
entry:
  %add4 = add nsw i64 %rawdata_offset, %size
  %tif_rawdatasize = getelementptr inbounds nuw i8, ptr %tif, i64 1040
  %tif_rawdatasize8 = getelementptr inbounds nuw i8, ptr %tif, i64 1040
  %tif_flags = getelementptr inbounds nuw i8, ptr %tif, i64 16
  %tif_rawdata = getelementptr inbounds nuw i8, ptr %tif, i64 1032
  %tif_clientdata26 = getelementptr inbounds nuw i8, ptr %tif, i64 1112
  %tif_row = getelementptr inbounds nuw i8, ptr %tif, i64 796
  %tif_clientdata = getelementptr inbounds nuw i8, ptr %tif, i64 1112
  %tif_rawdata33 = getelementptr inbounds nuw i8, ptr %tif, i64 1032
  %tif_readproc = getelementptr inbounds nuw i8, ptr %tif, i64 1120
  %tif_clientdata37 = getelementptr inbounds nuw i8, ptr %tif, i64 1112
  %rawdata_offset.neg = sub nsw i64 0, %rawdata_offset
  %tobool.not = icmp eq i32 %is_strip, 0
  %tif_row52 = getelementptr inbounds nuw i8, ptr %tif, i64 796
  %tif_row55 = getelementptr inbounds nuw i8, ptr %tif, i64 796
  %tif_col = getelementptr inbounds nuw i8, ptr %tif, i64 840
  br label %while.cond

while.cond:                                       ; preds = %cleanup58, %entry
  %already_read.0 = phi i64 [ 0, %entry ], [ %already_read.1, %cleanup58 ]
  %threshold.0 = phi i64 [ 1048576, %entry ], [ %threshold.1, %cleanup58 ]
  %cmp = icmp slt i64 %already_read.0, %size
  br i1 %cmp, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %sub = sub nsw i64 %size, %already_read.0
  %cmp1 = icmp sge i64 %sub, %threshold.0
  %cmp2 = icmp slt i64 %threshold.0, 1048576000
  %or.cond = and i1 %cmp1, %cmp2
  br i1 %or.cond, label %land.lhs.true3, label %if.end

land.lhs.true3:                                   ; preds = %while.body
  %0 = load i64, ptr %tif_rawdatasize, align 8, !tbaa !27
  %cmp5 = icmp sgt i64 %add4, %0
  br i1 %cmp5, label %if.then, label %if.end

if.then:                                          ; preds = %land.lhs.true3
  %mul = mul nsw i64 %threshold.0, 10
  br label %if.end

if.end:                                           ; preds = %if.then, %land.lhs.true3, %while.body
  %threshold.1 = phi i64 [ %mul, %if.then ], [ %threshold.0, %land.lhs.true3 ], [ %threshold.0, %while.body ]
  %to_read.0 = phi i64 [ %threshold.0, %if.then ], [ %sub, %land.lhs.true3 ], [ %sub, %while.body ]
  %add6 = add i64 %already_read.0, %rawdata_offset
  %add7 = add i64 %add6, %to_read.0
  %1 = load i64, ptr %tif_rawdatasize8, align 8, !tbaa !27
  %cmp9 = icmp sgt i64 %add7, %1
  br i1 %cmp9, label %if.then10, label %if.end32

if.then10:                                        ; preds = %if.end
  %2 = load i32, ptr %tif_flags, align 8, !tbaa !7
  %and = and i32 %2, 512
  %cmp11.not = icmp eq i32 %and, 0
  br i1 %cmp11.not, label %if.else, label %if.end13

if.else:                                          ; preds = %if.then10
  call void @__assert_fail(ptr noundef nonnull @.str.28, ptr noundef nonnull @.str.14, i32 noundef 99, ptr noundef nonnull @__PRETTY_FUNCTION__.TIFFReadAndRealloc) #5
  unreachable

if.end13:                                         ; preds = %if.then10
  %add16 = add i64 %add7, 1023
  %div58 = and i64 %add16, -1024
  store i64 %div58, ptr %tif_rawdatasize8, align 8, !tbaa !27
  %cmp20 = icmp eq i64 %div58, 0
  br i1 %cmp20, label %if.then21, label %if.end22

if.then21:                                        ; preds = %if.end13
  %3 = load ptr, ptr %tif_clientdata, align 8, !tbaa !19
  call void (ptr, ptr, ptr, ...) @TIFFErrorExt(ptr noundef %3, ptr noundef %module, ptr noundef nonnull @.str.15) #6
  br label %cleanup

if.end22:                                         ; preds = %if.end13
  %4 = load ptr, ptr %tif_rawdata, align 8, !tbaa !26
  %call = call ptr @_TIFFrealloc(ptr noundef %4, i64 noundef %div58) #6
  %cmp24 = icmp eq ptr %call, null
  br i1 %cmp24, label %if.then25, label %if.end30

if.then25:                                        ; preds = %if.end22
  %5 = load ptr, ptr %tif_clientdata26, align 8, !tbaa !19
  %6 = load i32, ptr %tif_row, align 4, !tbaa !20
  call void (ptr, ptr, ptr, ...) @TIFFErrorExt(ptr noundef %5, ptr noundef %module, ptr noundef nonnull @.str.16, i32 noundef %6) #6
  %7 = load ptr, ptr %tif_rawdata, align 8, !tbaa !26
  call void @_TIFFfree(ptr noundef %7) #6
  call void @llvm.memset.p0.i64(ptr align 8 %tif_rawdata, i8 0, i64 16, i1 false)
  br label %cleanup

if.end30:                                         ; preds = %if.end22
  store ptr %call, ptr %tif_rawdata, align 8, !tbaa !26
  br label %cleanup

cleanup:                                          ; preds = %if.end30, %if.then25, %if.then21
  %cond1 = phi i1 [ false, %if.then21 ], [ false, %if.then25 ], [ true, %if.end30 ]
  br i1 %cond1, label %if.end32, label %cleanup58

if.end32:                                         ; preds = %cleanup, %if.end
  %8 = load ptr, ptr %tif_rawdata33, align 8, !tbaa !26
  %cmp34 = icmp eq ptr %8, null
  br i1 %cmp34, label %if.then35, label %if.end36

if.then35:                                        ; preds = %if.end32
  br label %cleanup58

if.end36:                                         ; preds = %if.end32
  %9 = load ptr, ptr %tif_readproc, align 8, !tbaa !21
  %10 = load ptr, ptr %tif_clientdata37, align 8, !tbaa !19
  %add.ptr = getelementptr inbounds i8, ptr %8, i64 %rawdata_offset
  %add.ptr39 = getelementptr inbounds i8, ptr %add.ptr, i64 %already_read.0
  %call40 = call i64 %9(ptr noundef %10, ptr noundef nonnull %add.ptr39, i64 noundef %to_read.0) #6
  %add41 = add nsw i64 %call40, %already_read.0
  %cmp42.not = icmp eq i64 %call40, %to_read.0
  br i1 %cmp42.not, label %if.end57, label %if.then43

if.then43:                                        ; preds = %if.end36
  %11 = load ptr, ptr %tif_rawdata33, align 8, !tbaa !26
  %add.ptr45 = getelementptr inbounds i8, ptr %11, i64 %rawdata_offset
  %add.ptr46 = getelementptr inbounds i8, ptr %add.ptr45, i64 %add41
  %12 = load i64, ptr %tif_rawdatasize8, align 8, !tbaa !27
  %add41.neg = sub i64 0, %add41
  %.neg = add i64 %add41.neg, %rawdata_offset.neg
  %sub49 = add i64 %.neg, %12
  call void @llvm.memset.p0.i64(ptr align 1 %add.ptr46, i8 0, i64 %sub49, i1 false)
  br i1 %tobool.not, label %if.else53, label %if.then50

if.then50:                                        ; preds = %if.then43
  %13 = load ptr, ptr %tif_clientdata37, align 8, !tbaa !19
  %14 = load i32, ptr %tif_row52, align 4, !tbaa !20
  call void (ptr, ptr, ptr, ...) @TIFFErrorExt(ptr noundef %13, ptr noundef %module, ptr noundef nonnull @.str.29, i32 noundef %14, i64 noundef %add41, i64 noundef %size) #6
  br label %if.end56

if.else53:                                        ; preds = %if.then43
  %15 = load ptr, ptr %tif_clientdata37, align 8, !tbaa !19
  %16 = load i32, ptr %tif_row55, align 4, !tbaa !20
  %17 = load i32, ptr %tif_col, align 8, !tbaa !30
  call void (ptr, ptr, ptr, ...) @TIFFErrorExt(ptr noundef %15, ptr noundef %module, ptr noundef nonnull @.str.30, i32 noundef %16, i32 noundef %17, i32 noundef %strip_or_tile, i64 noundef %add41, i64 noundef %size) #6
  br label %if.end56

if.end56:                                         ; preds = %if.else53, %if.then50
  br label %cleanup58

if.end57:                                         ; preds = %if.end36
  br label %cleanup58

cleanup58:                                        ; preds = %if.end57, %if.end56, %if.then35, %cleanup
  %already_read.1 = phi i64 [ %already_read.0, %if.then35 ], [ %add41, %if.end56 ], [ %add41, %if.end57 ], [ %already_read.0, %cleanup ]
  %cond = phi i1 [ false, %if.then35 ], [ false, %if.end56 ], [ true, %if.end57 ], [ false, %cleanup ]
  br i1 %cond, label %while.cond, label %cleanup62.loopexit, !llvm.loop !37

while.end:                                        ; preds = %while.cond
  br label %cleanup62

cleanup62.loopexit:                               ; preds = %cleanup58
  br label %cleanup62

cleanup62:                                        ; preds = %cleanup62.loopexit, %while.end
  %retval.4 = phi i32 [ 1, %while.end ], [ 0, %cleanup62.loopexit ]
  ret i32 %retval.4
}

declare ptr @_TIFFrealloc(ptr noundef, i64 noundef) local_unnamed_addr #1

declare void @_TIFFmemcpy(ptr noundef, ptr noundef, i64 noundef) local_unnamed_addr #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr writeonly captures(none), i8, i64, i1 immarg) #4

attributes #0 = { nounwind uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { noreturn nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }
attributes #5 = { noreturn nounwind }
attributes #6 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3, !4, !5}
!llvm.ident = !{!6, !6}

!0 = !{i32 7, !"Dwarf Version", i32 5}
!1 = !{i32 2, !"Debug Info Version", i32 3}
!2 = !{i32 1, !"wchar_size", i32 4}
!3 = !{i32 8, !"PIC Level", i32 2}
!4 = !{i32 7, !"PIE Level", i32 2}
!5 = !{i32 7, !"uwtable", i32 1}
!6 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
!7 = !{!8, !12, i64 16}
!8 = !{!"tiff", !9, i64 0, !12, i64 8, !12, i64 12, !12, i64 16, !13, i64 24, !13, i64 32, !9, i64 40, !14, i64 48, !14, i64 50, !15, i64 56, !15, i64 416, !10, i64 776, !14, i64 792, !12, i64 796, !14, i64 800, !12, i64 804, !13, i64 808, !13, i64 816, !14, i64 824, !13, i64 832, !12, i64 840, !12, i64 844, !13, i64 848, !12, i64 856, !9, i64 864, !9, i64 872, !9, i64 880, !9, i64 888, !12, i64 896, !9, i64 904, !9, i64 912, !9, i64 920, !9, i64 928, !9, i64 936, !9, i64 944, !9, i64 952, !9, i64 960, !9, i64 968, !9, i64 976, !9, i64 984, !9, i64 992, !9, i64 1000, !9, i64 1008, !13, i64 1016, !13, i64 1024, !9, i64 1032, !13, i64 1040, !13, i64 1048, !13, i64 1056, !9, i64 1064, !13, i64 1072, !9, i64 1080, !13, i64 1088, !9, i64 1096, !9, i64 1104, !9, i64 1112, !9, i64 1120, !9, i64 1128, !9, i64 1136, !9, i64 1144, !9, i64 1152, !9, i64 1160, !9, i64 1168, !13, i64 1176, !9, i64 1184, !18, i64 1192, !9, i64 1216, !9, i64 1224, !13, i64 1232}
!9 = !{!"any pointer", !10, i64 0}
!10 = !{!"omnipotent char", !11, i64 0}
!11 = !{!"Simple C/C++ TBAA"}
!12 = !{!"int", !10, i64 0}
!13 = !{!"long", !10, i64 0}
!14 = !{!"short", !10, i64 0}
!15 = !{!"", !10, i64 0, !12, i64 32, !12, i64 36, !12, i64 40, !12, i64 44, !12, i64 48, !12, i64 52, !12, i64 56, !14, i64 60, !14, i64 62, !14, i64 64, !14, i64 66, !14, i64 68, !14, i64 70, !14, i64 72, !14, i64 74, !12, i64 76, !14, i64 80, !14, i64 82, !9, i64 88, !9, i64 96, !16, i64 104, !16, i64 108, !14, i64 112, !14, i64 114, !16, i64 116, !16, i64 120, !10, i64 124, !10, i64 128, !10, i64 152, !14, i64 156, !9, i64 160, !12, i64 168, !12, i64 172, !9, i64 176, !9, i64 184, !12, i64 192, !17, i64 200, !17, i64 232, !14, i64 264, !9, i64 272, !10, i64 280, !14, i64 284, !10, i64 288, !9, i64 312, !12, i64 320, !9, i64 328, !12, i64 336, !9, i64 344, !10, i64 352}
!16 = !{!"float", !10, i64 0}
!17 = !{!"", !14, i64 0, !14, i64 2, !13, i64 8, !10, i64 16, !10, i64 24}
!18 = !{!"", !9, i64 0, !9, i64 8, !9, i64 16}
!19 = !{!8, !9, i64 1112}
!20 = !{!8, !12, i64 796}
!21 = !{!8, !9, i64 1120}
!22 = !{!8, !13, i64 1088}
!23 = !{!8, !9, i64 1080}
!24 = !{!8, !12, i64 804}
!25 = !{!15, !14, i64 70}
!26 = !{!8, !9, i64 1032}
!27 = !{!8, !13, i64 1040}
!28 = !{!8, !13, i64 1048}
!29 = !{!8, !13, i64 1056}
!30 = !{!8, !12, i64 840}
!31 = !{!8, !9, i64 872}
!32 = !{!15, !12, i64 168}
!33 = !{!15, !12, i64 76}
!34 = !{!8, !9, i64 1064}
!35 = !{!8, !13, i64 1072}
!36 = !{!8, !9, i64 880}
!37 = distinct !{!37, !38, !39}
!38 = !{!"llvm.loop.mustprogress"}
!39 = !{!"llvm.loop.unroll.disable"}
