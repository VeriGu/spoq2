; A global initialised with a floating point literal, then loaded.

@scale = dso_local local_unnamed_addr global double 2.500000e+00, align 8

define i32 @vuln(i32 noundef %n) local_unnamed_addr {
entry:
  %conv = sitofp i32 %n to double
  %s = load double, ptr @scale, align 8
  %mul = fmul double %conv, %s
  %back = fptosi double %mul to i32
  ret i32 %back
}
