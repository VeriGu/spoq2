; Integer -> floating point and back.  Reduced from fill_xyztables in ffm001,
; which contains `%conv = sitofp nsz i32 %1 to double`.

define i32 @vuln(i32 noundef %n) local_unnamed_addr {
entry:
  %conv = sitofp i32 %n to double
  %back = fptosi double %conv to i32
  ret i32 %back
}
