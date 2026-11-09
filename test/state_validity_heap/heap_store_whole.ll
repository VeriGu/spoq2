; valid_s_cfg := a <= n names two fields, so a store of a is checked of the n
; in the state (valid_rel_s_cfg_e_a).  Both store q->a = v; vuln returns
; whether v > n, the patch 0: an a above n is UB in both.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.cfg = type { i32, i32 }
declare void @touch(ptr noundef)

define i32 @entry_sec0_vuln(ptr %c, i32 %v) {
  %a.p = getelementptr inbounds nuw %struct.cfg, ptr %c, i32 0, i32 0
  store i32 %v, ptr %a.p, align 4
  %n.p = getelementptr inbounds nuw %struct.cfg, ptr %c, i32 0, i32 1
  %n = load i32, ptr %n.p, align 4
  %bad = icmp sgt i32 %v, %n
  %r = zext i1 %bad to i32
  ret i32 %r
}

define i32 @entry_sec0_patch(ptr %c, i32 %v) {
  %a.p = getelementptr inbounds nuw %struct.cfg, ptr %c, i32 0, i32 0
  store i32 %v, ptr %a.p, align 4
  ret i32 0
}
