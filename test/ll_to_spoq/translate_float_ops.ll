; Every floating point arithmetic opcode plus fneg, which has no renderer at all
; today -- Expr::stream has no branch for the `unops` alternative, so printing
; one throws bad_variant_access.

define double @vuln(double %a, double %b) {
entry:
  %add = fadd double %a, %b
  %sub = fsub double %add, %b
  %mul = fmul double %sub, %a
  %div = fdiv double %mul, %b
  %rem = frem double %div, %a
  %neg = fneg double %rem
  ret double %neg
}
