; Ordered and unordered comparisons of each kind.  Only oeq is mapped today; the
; rest reach `assert(false && "Binary Cmp operation not supported")`.  Ordered
; and unordered differ only over NaN, so they must stay distinct symbols.

define i32 @vuln(double %a, double %b) {
entry:
  %oeq = fcmp oeq double %a, %b
  %olt = fcmp olt double %a, %b
  %ole = fcmp ole double %a, %b
  %ogt = fcmp ogt double %a, %b
  %oge = fcmp oge double %a, %b
  %one = fcmp one double %a, %b
  %ult = fcmp ult double %a, %b
  %uno = fcmp uno double %a, %b
  %t0 = and i1 %oeq, %olt
  %t1 = and i1 %t0, %ole
  %t2 = and i1 %t1, %ogt
  %t3 = and i1 %t2, %oge
  %t4 = and i1 %t3, %one
  %t5 = and i1 %t4, %ult
  %t6 = and i1 %t5, %uno
  %r = zext i1 %t6 to i32
  ret i32 %r
}
