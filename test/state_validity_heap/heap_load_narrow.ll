; vuln reads the low byte of q->n as an i8 and returns 0 when it is 0; the
; patch returns 1.  valid_field_s_cfg_e_n is a predicate of the i32 field, not
; of a byte: n = 256 is valid with a zero low byte, so they differ.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.cfg = type { i32, i32 }
declare void @touch(ptr noundef)

define i32 @entry_sec0_vuln(ptr %c) {
  %n.p = getelementptr inbounds nuw %struct.cfg, ptr %c, i32 0, i32 1
  %b = load i8, ptr %n.p, align 4
  %z = icmp eq i8 %b, 0
  %r = select i1 %z, i32 0, i32 1
  ret i32 %r
}

define i32 @entry_sec0_patch(ptr %c) {
  ret i32 1
}
