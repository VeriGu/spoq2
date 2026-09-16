; A function whose result is i1 in LLVM but Z in its Coq spec, branched on.
;
; ExtractBasics maps i1 to Z, so a generated `Parameter <fn>_spec` for an
; i1-returning function returns `option (Z * RData)`.  spoq maps i1 to Bool and
; builds an If over the result, so the condition is a Z where a bool is wanted
; and z3_eval aborts negating it for the else branch:
;
;   z3++.h:1674: expr z3::operator!(const expr &): Assertion `a.is_bool()' failed.
;
; This is snd014's `llvm.is.fpclass.f64`, whose spec the project supplies and
; whose result `d2alaw_array` branches on.  A C int used as a condition, needing
; the coercion C does implicitly.

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare dso_local i1 @pred(i32)

define dso_local i32 @vuln(i32 %x) {
entry:
  %p = call i1 @pred(i32 %x)
  br i1 %p, label %yes, label %no

yes:
  br label %join

no:
  br label %join

join:
  %r = phi i32 [ 1, %yes ], [ 0, %no ]
  ret i32 %r
}
