; Two returns of an i1 on different paths: the constant false, and an i1
; loaded from memory.
;
; spoq maps i1 to Bool, so false is a Bool, but the load yields the memory
; word, a Z.  The function's two arms then have different types and type
; inference asserts:
;
;   type_inference.cpp:869: Assertion `if_->then_body->type ==
;   if_->else_body->type || ...' failed.
;
; Reduced by llvm-reduce from mruby's check_method_noarg.

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@g = dso_local global i8 0

define dso_local i1 @vuln(i32 %x) {
entry:
  %c = icmp eq i32 %x, 0
  br i1 %c, label %const, label %loaded

const:
  ret i1 false

loaded:
  %v = load i1, ptr @g, align 1
  ret i1 %v
}
