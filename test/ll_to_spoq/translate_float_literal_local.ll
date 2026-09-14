; A floating point literal as an inline operand.  Under `Float := Z` it has to
; render as an integer; ffm001 fails on `(indvars_iv / ((4095.000000)))`.

define i32 @vuln(i32 noundef %n) local_unnamed_addr {
entry:
  %conv = sitofp i32 %n to double
  %mul = fmul double %conv, 4.095000e+03
  %back = fptosi double %mul to i32
  ret i32 %back
}
