; Straight-line arithmetic: one basic block, no control flow at all.
; The simplest thing llvm_ir_to_spoq_ir can be asked to do.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i32 @vuln(i32 %a, i32 %b) {
entry:
  %sum = add nsw i32 %a, %b
  %prod = mul nsw i32 %sum, 3
  %diff = sub nsw i32 %prod, %b
  %shifted = shl i32 %diff, 2
  %masked = and i32 %shifted, 255
  ret i32 %masked
}
