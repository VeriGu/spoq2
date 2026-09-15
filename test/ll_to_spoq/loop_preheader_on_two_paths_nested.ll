; A two-path preheader one level down: the inner loop is entered from two places
; inside the outer loop's body.
;
; The inner loop's parent link is recorded when the walk reaches its preheader,
; and its pass_in/pass_out are computed against the loop stack, so reaching that
; preheader twice exercises the nesting bookkeeping as well as the body sharing.
; %acc comes in from the outer header phi; %sum.next goes back out to the merge.

define i32 @vuln(i32 %n, i32 %m) {
entry:
  br label %outer

outer:
  %k = phi i32 [ 0, %entry ], [ %k.next, %outer.latch ]
  %acc = phi i32 [ 0, %entry ], [ %acc.next, %outer.latch ]
  %c0 = icmp sgt i32 %k, 0
  br i1 %c0, label %A, label %B

A:
  %c1 = icmp sgt i32 %n, 5
  br i1 %c1, label %P, label %X

B:
  br label %P

X:
  br label %merge

P:
  br label %inner

inner:
  %i = phi i32 [ 0, %P ], [ %i.next, %inner ]
  %sum = phi i32 [ %acc, %P ], [ %sum.next, %inner ]
  %sum.next = add nsw i32 %sum, %i
  %i.next = add nsw i32 %i, 1
  %cc = icmp slt i32 %i.next, %m
  br i1 %cc, label %inner, label %merge

merge:
  %v = phi i32 [ %acc, %X ], [ %sum.next, %inner ]
  br label %outer.latch

outer.latch:
  %acc.next = add nsw i32 %v, 1
  %k.next = add nsw i32 %k, 1
  %ko = icmp slt i32 %k.next, %n
  br i1 %ko, label %outer, label %done

done:
  ret i32 %acc.next
}
