; Memory operations: alloca / store / load / getelementptr, plus a global.
; Exercises the load/store and GEP arms of spoq_inst_to_spec.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@g = dso_local global i32 0, align 4

define dso_local i32 @vuln(i32 %n) {
entry:
  %slot = alloca i32, align 4
  %arr = alloca [4 x i32], align 16
  store i32 %n, ptr %slot, align 4
  store i32 7, ptr @g, align 4
  %elem = getelementptr inbounds [4 x i32], ptr %arr, i64 0, i64 2
  store i32 3, ptr %elem, align 4
  %a = load i32, ptr %slot, align 4
  %b = load i32, ptr @g, align 4
  %c = load i32, ptr %elem, align 4
  %s1 = add nsw i32 %a, %b
  %s2 = add nsw i32 %s1, %c
  ret i32 %s2
}
