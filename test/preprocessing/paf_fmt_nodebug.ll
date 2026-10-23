; paf_fmt_debuginfo.ll without debug info (opt -strip-debug).  Nothing names
; the fields, so they are numbered: e_s_PAF_FMT_0 ... e_s_PAF_FMT_5.  This is
; what snd001 produces today, because pv-function-prune erases the functions
; that referenced PAF_FMT's debug info.
; ModuleID = 'raw.ll'
source_filename = "paf_fmt.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.PAF_FMT = type { i32, i32, i32, i32, i32, i32 }

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @paf_samplerate(i32 noundef %x) #0 {
entry:
  %x.addr = alloca i32, align 4
  %paf_fmt = alloca %struct.PAF_FMT, align 4
  store i32 %x, ptr %x.addr, align 4
  %0 = load i32, ptr %x.addr, align 4
  %samplerate = getelementptr inbounds nuw %struct.PAF_FMT, ptr %paf_fmt, i32 0, i32 2
  store i32 %0, ptr %samplerate, align 4
  %channels = getelementptr inbounds nuw %struct.PAF_FMT, ptr %paf_fmt, i32 0, i32 4
  store i32 1, ptr %channels, align 4
  %samplerate1 = getelementptr inbounds nuw %struct.PAF_FMT, ptr %paf_fmt, i32 0, i32 2
  %1 = load i32, ptr %samplerate1, align 4
  ret i32 %1
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2, !3, !4, !5}

!0 = !{i32 7, !"Dwarf Version", i32 5}
!1 = !{i32 2, !"Debug Info Version", i32 3}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"PIE Level", i32 2}
!4 = !{i32 7, !"uwtable", i32 2}
!5 = !{i32 7, !"frame-pointer", i32 2}
