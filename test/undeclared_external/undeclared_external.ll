; A call to an external function the project gives no spec.
;
; The pipeline declares a spec for each function its input IR declares, but an
; optimizer pass can introduce a call to one it did not: loop-idiom turns a
; copy loop into llvm.memmove (mruby's mrb_ary_shift and mrb_ary_splice).
; main.v here declares no llvm_memmove_p0_p0_i64_spec.  Without one, type
; inference of vuln's spec fails:
;
;   unknown expr op (llvm_memmove_p0_p0_i64_spec dst src 8 false st)
;
; spoq declares the missing spec as an oracle of the arguments and the state.

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare void @llvm.memmove.p0.p0.i64(ptr, ptr, i64, i1)

define dso_local i32 @vuln(ptr %dst, ptr %src) {
entry:
  call void @llvm.memmove.p0.p0.i64(ptr %dst, ptr %src, i64 8, i1 false)
  ret i32 0
}
