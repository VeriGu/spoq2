; An ordering comparison between two pointers.
;
; `icmp uge ptr` is the bound check a buffer walk ends with; FFM021's
; nsv_parse_NSVf_header has `%cmp27 = icmp uge ptr %p.1, %add.ptr26`, which
; aborted translation before icmp_ptr existed.
;
; Both pointers are into the same block and their offsets differ by a constant,
; so the comparison has one answer and the return value is pinned by it.

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i32 @vuln(ptr %p) {
entry:
  %end = getelementptr inbounds i8, ptr %p, i64 8
  %cmp = icmp uge ptr %p, %end
  br i1 %cmp, label %past, label %within

past:
  br label %join

within:
  br label %join

join:
  %r = phi i32 [ 1, %past ], [ 0, %within ]
  ret i32 %r
}
