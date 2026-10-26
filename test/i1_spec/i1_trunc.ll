; trunc to i1, which keeps bit 0, used as a branch condition, as a select
; condition, through zext, and as the i1 result of a defined function.
;
;   vuln:  b = trunc x;  if b then (b ? y : 0) + zext b + zext (low y) else 0
;          where low v = trunc (trunc v to i8) to i1
;   patch: the same with x & 1 and y & 1
;
; spoq maps i1 to Bool, so the truncated value must be a Bool where it is
; used as one; a Z there is a bool/int type error.

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i1 @low(i32 %v) {
entry:
  %w = trunc i32 %v to i8
  %b = trunc i8 %w to i1
  ret i1 %b
}

define dso_local i32 @f_vuln(i32 %x, i32 %y) {
entry:
  %b = trunc i32 %x to i1
  br i1 %b, label %odd, label %even
odd:
  %s = select i1 %b, i32 %y, i32 0
  %z = zext i1 %b to i32
  %c = call i1 @low(i32 %y)
  %cz = zext i1 %c to i32
  %t = add i32 %s, %z
  %r = add i32 %t, %cz
  ret i32 %r
even:
  ret i32 0
}

define dso_local i32 @f_patch(i32 %x, i32 %y) {
entry:
  %a = and i32 %x, 1
  %c = icmp ne i32 %a, 0
  br i1 %c, label %odd, label %even
odd:
  %ly = and i32 %y, 1
  %t = add i32 %y, 1
  %r = add i32 %t, %ly
  ret i32 %r
even:
  ret i32 0
}
