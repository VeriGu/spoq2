target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

define i32 @TIFFFillStrip() {
entry:
  br label %cleanup138

if.then21:                                        ; No predecessors!
  br i1 false, label %cleanup138, label %cleanup138

cleanup138:                                       ; preds = %if.then21, %if.then21, %entry
  %retval.3 = phi i32 [ 0, %entry ], [ 0, %if.then21 ], [ 0, %if.then21 ]
  ret i32 0
}
