; The vuln loads *p, calls the opaque @step, loads *p again, and divides by
; (x == y): division by zero exactly when @step changed *p.  The patch returns
; x == y without dividing, so it eliminates that UB.
;
; The generated spec binds @step's result state with `when st == (step_spec st)`,
; re-binding the name of the entry state.  In Coq the inner st is the post-call
; state.  If spoq keeps the entry state for the re-bound name, both loads read
; one state, x = y is decided while the divisor is checked, the vuln spec loses
; its division by zero, and impl_eliminates_ub comes out false.
; ModuleID = 'rebind_after_call'
source_filename = "rebind_after_call.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i32 @entry_vuln(ptr noundef %p) #0 {
entry:
  %p.addr = alloca ptr, align 8
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  store ptr %p, ptr %p.addr, align 8
  %0 = load ptr, ptr %p.addr, align 8
  %1 = load i32, ptr %0, align 4
  store i32 %1, ptr %x, align 4
  call void @step()
  %2 = load ptr, ptr %p.addr, align 8
  %3 = load i32, ptr %2, align 4
  store i32 %3, ptr %y, align 4
  %4 = load i32, ptr %x, align 4
  %5 = load i32, ptr %y, align 4
  %cmp = icmp eq i32 %4, %5
  %conv = zext i1 %cmp to i32
  %div = sdiv i32 1, %conv
  ret i32 %div
}

declare void @step() #2

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

define dso_local i32 @entry_patch(ptr noundef %p) #0 {
entry:
  %p.addr = alloca ptr, align 8
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  store ptr %p, ptr %p.addr, align 8
  %0 = load ptr, ptr %p.addr, align 8
  %1 = load i32, ptr %0, align 4
  store i32 %1, ptr %x, align 4
  call void @step()
  %2 = load ptr, ptr %p.addr, align 8
  %3 = load i32, ptr %2, align 4
  store i32 %3, ptr %y, align 4
  %4 = load i32, ptr %x, align 4
  %5 = load i32, ptr %y, align 4
  %cmp = icmp eq i32 %4, %5
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}
