; The same literal twice, and a near neighbour of it.
;
; 2.0 must be one constant wherever it appears, or the spec cannot see that the
; two multiplications are by the same thing.  The double nearest 2.0 from above
; must be a different one, which is why the name comes from the exact bits
; rather than from a printed decimal.

define double @vuln(double %a) {
entry:
  %x = fmul double %a, 2.0
  %y = fmul double %x, 2.0
  %z = fmul double %y, 0x4000000000000001
  ret double %z
}
