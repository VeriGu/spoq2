; Both store q->n = v; the vuln returns whether v is outside [1, 1024], the patch 0.
; Control: no valid_at_s_cfg, so heap accesses are unchecked and they differ.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.cfg = type { i32, i32 }
declare void @touch(ptr noundef)

define i32 @entry_sec0_vuln(ptr %c, i32 %v) {
  %n.p = getelementptr inbounds nuw %struct.cfg, ptr %c, i32 0, i32 1
  store i32 %v, ptr %n.p, align 4
  %lo = icmp slt i32 %v, 1
  %hi = icmp sgt i32 %v, 1024
  %bad = or i1 %lo, %hi
  %r = zext i1 %bad to i32
  ret i32 %r
}

define i32 @entry_sec0_patch(ptr %c, i32 %v) {
  %n.p = getelementptr inbounds nuw %struct.cfg, ptr %c, i32 0, i32 1
  store i32 %v, ptr %n.p, align 4
  ret i32 0
}
