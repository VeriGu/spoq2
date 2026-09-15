; End-to-end: a function that calls through a function pointer and then returns
; a value that does not depend on the call.
;
;   vuln(fp, x) = fp(x); return (x > 0) ? 1 : 0
;
; The postconditions are about the return value alone, so they hold whatever the
; pointer does.  The .main.v says nothing about `fp_1_fptr_vuln_spec`: the
; translator declares it on seeing an indirect call with no spec, as an external
; declaration's spec is declared.  What this pins is that an opaque callee the
; proof does not need needs no configuration and does not block the proof.

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i32 @vuln(ptr %fp, i32 %x) {
entry:
  %ignored = call i32 %fp(i32 %x)
  %cmp = icmp sgt i32 %x, 0
  %sel = select i1 %cmp, i32 1, i32 0
  ret i32 %sel
}
