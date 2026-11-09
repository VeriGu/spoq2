; valid_s_cfg := a <= n.  vuln stores v in q->a if v <= n (n otherwise), the
; patch stores v: only the patch can write an a above n, so it does not refine.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.cfg = type { i32, i32 }
declare void @touch(ptr noundef)

define i32 @entry_sec0_vuln(ptr %c, i32 %v) {
  %n.p = getelementptr inbounds nuw %struct.cfg, ptr %c, i32 0, i32 1
  %n = load i32, ptr %n.p, align 4
  %ok = icmp sle i32 %v, %n
  %w = select i1 %ok, i32 %v, i32 %n
  %a.p = getelementptr inbounds nuw %struct.cfg, ptr %c, i32 0, i32 0
  store i32 %w, ptr %a.p, align 4
  ret i32 0
}

define i32 @entry_sec0_patch(ptr %c, i32 %v) {
  %a.p = getelementptr inbounds nuw %struct.cfg, ptr %c, i32 0, i32 0
  store i32 %v, ptr %a.p, align 4
  ret i32 0
}
