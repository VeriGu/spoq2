; An LLVM register named the same as something the project declares.
;
; clang names the result of `fneg` `%fneg`, which is exactly the name the
; uninterpreted float negation is declared under, so the binding shadowed the
; declaration: the spec read `let fneg := (fneg x) in ...`, and `fneg` was then
; a Z where the declaration said Z -> Z.  Reached in ffm001 (libswscale/utils.c,
; initFilter), where the sort mismatch segfaulted z3_eval.
;
; The declaration is global and the binding is not, so it is the binding that
; moves: `v_fneg`.

define double @vuln(double %x) {
entry:
  %fneg = fneg double %x
  %m = fmul double %fneg, %x
  ret double %m
}
