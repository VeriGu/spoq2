; A phi of i1 joining the constant false and the result of an i1-returning
; external, branched on.
;
; ExtractBasics maps i1 to Z, so pred's generated spec returns option (Z *
; RData), while spoq maps i1 to Bool.  The arms of the If that joins at the
; phi yield false on one edge and pred's Z on the other, and type inference
; asserts as in i1_return_load.  This is mruby's check_method_noarg, where
; pred is mrb_hash_empty_p.

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare dso_local i1 @pred(i32)

define dso_local i32 @vuln(i32 %x) {
entry:
  %c = icmp eq i32 %x, 0
  br i1 %c, label %join, label %call

call:
  %p = call i1 @pred(i32 %x)
  br label %join

join:
  %b = phi i1 [ false, %entry ], [ %p, %call ]
  br i1 %b, label %yes, label %no

yes:
  br label %done

no:
  br label %done

done:
  %r = phi i32 [ 1, %yes ], [ 0, %no ]
  ret i32 %r
}
