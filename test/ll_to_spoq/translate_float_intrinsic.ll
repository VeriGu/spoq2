; A floating point intrinsic.  llvm.fabs is the most common in the corpus
; (1328 uses); llvm.fmuladd takes three operands and checks the argument list is
; carried through, and is not the call's operand list -- that ends with the
; callee.

declare double @llvm.fabs.f64(double)
declare double @llvm.fmuladd.f64(double, double, double)

define double @vuln(double %a, double %b) {
entry:
  %abs = call double @llvm.fabs.f64(double %a)
  %fma = call double @llvm.fmuladd.f64(double %abs, double %b, double %a)
  ret double %fma
}
