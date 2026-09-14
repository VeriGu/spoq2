; A join whose two predecessors are a loop exit and a path that skipped the
; loop, where the phi's loop-side incoming value is defined *inside* the loop
; body rather than being the header phi itself.
;
; Reduced from luaG_getfuncline (lua002):
;   while.end: preds = {while.cond.while.end_crit_edge, if.else}
;     %baseline.0.lcssa = phi [ %add, %crit_edge ], [ %call, %if.else ]
;   where %add is the loop's backedge source, defined in while.body.

define i32 @vuln(i32 noundef %n) local_unnamed_addr {
entry:
  %cmp = icmp slt i32 %n, 0
  br i1 %cmp, label %if.then, label %if.else

if.then:
  br label %return

if.else:
  %call = mul nsw i32 %n, 3
  %cmp17 = icmp sgt i32 %n, 0
  br i1 %cmp17, label %while.body.lr.ph, label %while.end

while.body.lr.ph:
  br label %while.body

while.body:
  %i = phi i32 [ 0, %while.body.lr.ph ], [ %i.next, %while.body ]
  %baseline.08 = phi i32 [ %call, %while.body.lr.ph ], [ %add, %while.body ]
  %add = add nsw i32 %baseline.08, %i
  %i.next = add nsw i32 %i, 1
  %exitcond = icmp slt i32 %i.next, %n
  br i1 %exitcond, label %while.body, label %while.cond.while.end_crit_edge

while.cond.while.end_crit_edge:
  br label %while.end

while.end:
  %baseline.0.lcssa = phi i32 [ %add, %while.cond.while.end_crit_edge ], [ %call, %if.else ]
  br label %return

return:
  %retval.0 = phi i32 [ -1, %if.then ], [ %baseline.0.lcssa, %while.end ]
  ret i32 %retval.0
}
