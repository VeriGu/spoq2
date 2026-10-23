; The overflow flag of llvm.umul.with.overflow, read with extractvalue from the
; { i64, i1 } the call returns, as clang emits for the size of new[]
; (openexr cve-2020-16588, Imf::Array2D's constructor).
;
;   vuln(n)  = n * 8 overflows ? -1 : (n * 8) mod 2^64     (as i64)
;   patch(n) = the same
;
; The two functions are identical, so the refinement holds; the case checks
; that a field of a record-typed call result can be read.

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare { i64, i1 } @llvm.umul.with.overflow.i64(i64, i64)

define dso_local i64 @entry_vuln(i64 %n) {
entry:
  %r = call { i64, i1 } @llvm.umul.with.overflow.i64(i64 %n, i64 8)
  %ovf = extractvalue { i64, i1 } %r, 1
  %prod = extractvalue { i64, i1 } %r, 0
  %s = select i1 %ovf, i64 -1, i64 %prod
  ret i64 %s
}

define dso_local i64 @entry_patch(i64 %n) {
entry:
  %r = call { i64, i1 } @llvm.umul.with.overflow.i64(i64 %n, i64 8)
  %ovf = extractvalue { i64, i1 } %r, 1
  %prod = extractvalue { i64, i1 } %r, 0
  %s = select i1 %ovf, i64 -1, i64 %prod
  ret i64 %s
}
