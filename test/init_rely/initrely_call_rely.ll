; An InitRely whose proposition calls a function with a Rely inside.
;
;   Definition checked_pos (x: Z) : option bool := rely (x <? 1000); Some (x >? 0).
;   Hint InitRely f_vuln ((checked_pos x) = (Some true)).   (and f_patch)
;
;   vuln:  0 < x < 1000 ? 1 : 2
;   patch: 1
;
; The patch refines the vuln only where 0 < x < 1000.  The InitRely gives
; x > 0 through the call's result, and x < 1000 only through the Rely inside
; it: where that Rely fails the call is None, not Some true.

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i32 @f_vuln(i32 %x) {
entry:
  %pos = icmp sgt i32 %x, 0
  %small = icmp slt i32 %x, 1000
  %in = and i1 %pos, %small
  br i1 %in, label %one, label %two
one:
  ret i32 1
two:
  ret i32 2
}

define dso_local i32 @f_patch(i32 %x) {
entry:
  ret i32 1
}
