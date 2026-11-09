; vuln reads q->n and returns 0 when n is outside [1, 1024]; the patch returns 1.
; With valid_at_s_cfg (state_validity.py --heap) an access of an invalid heap cfg is UB, so they agree.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.cfg = type { i32, i32 }
declare void @touch(ptr noundef)

define i32 @entry_sec0_vuln(ptr %c) {
  %n.p = getelementptr inbounds nuw %struct.cfg, ptr %c, i32 0, i32 1
  %n = load i32, ptr %n.p, align 4
  %lo = icmp slt i32 %n, 1
  %hi = icmp sgt i32 %n, 1024
  %bad = or i1 %lo, %hi
  %r = select i1 %bad, i32 0, i32 1
  ret i32 %r
}

define i32 @entry_sec0_patch(ptr %c) {
  ret i32 1
}
