; vuln returns q->n, the patch q->n + 1: they differ on every valid cfg, so the
; heap validity check must not make them agree.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.cfg = type { i32, i32 }
declare void @touch(ptr noundef)

define i32 @entry_sec0_vuln(ptr %c) {
  %n.p = getelementptr inbounds nuw %struct.cfg, ptr %c, i32 0, i32 1
  %n = load i32, ptr %n.p, align 4
  ret i32 %n
}

define i32 @entry_sec0_patch(ptr %c) {
  %n.p = getelementptr inbounds nuw %struct.cfg, ptr %c, i32 0, i32 1
  %n = load i32, ptr %n.p, align 4
  %m = add i32 %n, 1
  ret i32 %m
}
