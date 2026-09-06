; Sanity case: an ordinary nested loop must convert.  Guards the negative
; result of the ffm001 case -- if this ever stops converting, the problem is
; not specific to the ffm001 CFG.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i32 @vuln(i32 %n) {
entry:
  br label %outer

outer:
  %i = phi i32 [ 0, %entry ], [ %i.next, %inner.exit ]
  br label %inner

inner:
  %j = phi i32 [ 0, %outer ], [ %j.next, %inner ]
  %j.next = add i32 %j, 1
  %ci = icmp slt i32 %j.next, %n
  br i1 %ci, label %inner, label %inner.exit

inner.exit:
  %i.next = add i32 %i, 1
  %co = icmp slt i32 %i.next, %n
  br i1 %co, label %outer, label %done

done:
  ret i32 %i.next
}
