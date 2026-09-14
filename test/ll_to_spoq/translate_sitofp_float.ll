; The same round trip through a 32-bit float rather than a double.  Float is one
; type in the spec language, so both widths translate the same way.

define i32 @vuln(i32 noundef %n) local_unnamed_addr {
entry:
  %conv = sitofp i32 %n to float
  %back = fptosi float %conv to i32
  ret i32 %back
}
