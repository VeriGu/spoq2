; A call through a function pointer.  decode_unit_vuln in ffm054 makes two, and
; the spec it emits for them names a function nothing defines.

define i32 @vuln(ptr noundef %fp, i32 noundef %n) local_unnamed_addr {
entry:
  %call = call i32 %fp(i32 noundef %n)
  %r = add nsw i32 %call, 1
  ret i32 %r
}
