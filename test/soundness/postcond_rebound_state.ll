; set stores to *q and rebinds the state (when st == (store_RData .. st)), so
; the postcondition st = st_old is false; st_old must denote the state at entry,
; not the rebound st.  The vuln reads *q before set, the patch after it.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local void @set(ptr %q) {
entry:
  store i32 1, ptr %q, align 4
  ret void
}

define dso_local i32 @vuln(ptr %q) {
entry:
  %x = load i32, ptr %q, align 4
  call void @set(ptr %q)
  ret i32 %x
}

define dso_local i32 @patch(ptr %q) {
entry:
  call void @set(ptr %q)
  %x = load i32, ptr %q, align 4
  ret i32 %x
}
