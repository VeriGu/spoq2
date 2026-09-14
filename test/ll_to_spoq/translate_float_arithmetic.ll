; Arithmetic on the floating point value between the two casts.

define i32 @vuln(i32 noundef %n) local_unnamed_addr {
entry:
  %conv = sitofp i32 %n to double
  %mul = fmul double %conv, 2.000000e+00
  %back = fptosi double %mul to i32
  ret i32 %back
}
