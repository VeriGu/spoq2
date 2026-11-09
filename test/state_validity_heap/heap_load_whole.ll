; valid_s_cfg := a <= n names two fields, so a load of a or n is checked of
; the other in the state (valid_rel_s_cfg_e_a, _e_n).  vuln returns whether
; a <= n, the patch 1: they agree.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.cfg = type { i32, i32 }
declare void @touch(ptr noundef)

define i32 @entry_sec0_vuln(ptr %c) {
  %a.p = getelementptr inbounds nuw %struct.cfg, ptr %c, i32 0, i32 0
  %a = load i32, ptr %a.p, align 4
  %n.p = getelementptr inbounds nuw %struct.cfg, ptr %c, i32 0, i32 1
  %n = load i32, ptr %n.p, align 4
  %ok = icmp sle i32 %a, %n
  %r = zext i1 %ok to i32
  ret i32 %r
}

define i32 @entry_sec0_patch(ptr %c) {
  ret i32 1
}
