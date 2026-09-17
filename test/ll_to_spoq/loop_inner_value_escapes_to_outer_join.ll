; A value defined in an inner loop, escaping through a join that sits inside the
; outer loop and is also reachable without entering the inner loop.
;
; Reduced with llvm-reduce from initFilter (ffm001, libswscale/utils.c), where
; the whole run aborts in check_well_typed with
;   Unknown symbol: indvars_iv_next552_1
; -- an induction variable of a 2x-unrolled inner loop, read by the phi that
; seeds the epilogue loop.
;
; %v is defined strictly inside the inner loop, so it cannot be an input to the
; outer one; it is recorded as a pass_in of the outer loop all the same, and the
; outer loop's call site then names it before anything binds it:
;
;   match ((vuln_loop_0_low skip_inner v outer_again inner_again 0 st)) with
;                                      ^ free
;
; The skip edge is what makes the difference: with `outer.header` branching
; unconditionally to `inner.preheader` the same shape translates cleanly, so it
; is the join being reachable both around and through the inner loop that
; misplaces the value.

define i32 @vuln(i1 %skip.inner, i1 %inner.again, i1 %outer.again) {
entry:
  br label %outer.header

outer.header:
  br i1 %skip.inner, label %join, label %inner.preheader

inner.preheader:
  br label %inner

inner:
  %v = add i64 1, 2
  br i1 %inner.again, label %inner, label %join

join:
  %p = phi i64 [ 0, %outer.header ], [ %v, %inner ]
  br i1 %outer.again, label %outer.header, label %done

done:
  ret i32 0
}
