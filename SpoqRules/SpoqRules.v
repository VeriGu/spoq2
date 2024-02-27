


(* Verify rules *)

Require Import String.
Require Import List.
Require Import CommonDeps.
Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Open Scope list_scope.


(* let a := x + y in a + b => (x + y) + b*)
Section rule2.
Definition rule2_pre {T} {T1} (y: T) (X: T -> T1) :=
  let a := y in
  X a.


Lemma rule_2_correct :
  forall (T1: Type) (T: Type) (y:T)  (X: T->T1),
    rule2_pre y X = X y.
Proof.
  intros. unfold rule2_pre.
  reflexivity.
Qed.
End rule2.


  
(* If c then X else X => X *)
Definition rule3_pre {s: Type} (c : bool) (X:s) : s :=
  if c then X else X.


Lemma rule_3_correct :
  forall (s: Type) (c:bool) (X:s),
    rule3_pre c X = X.
Proof.
  intros. unfold rule3_pre.
  destruct c; reflexivity. 
Qed.

(* F a b := a + b; F (x+1) (y+1) => let a := x + 1 in let b := y + 1 in a + b*)
Section rule1.
  Variable T1 : Type.
  Variable T2 : Type.

  Parameter F : T1 -> T2.

  Definition rule1_pre a := F a.

  Definition rule1_post a := let b := a in F b.

  Lemma rule1_correct :
    forall a,
      rule1_pre a = rule1_post a.
  Proof.
    intros. unfold rule1_pre. unfold rule1_post. reflexivity.
  Qed.

End rule1.

(* T4 *)
Section rule4.
  Variable T : Type.
  Variable T1 : Type.
  Variable e1 : T.
  Variable e2 : T.
  Variable tl : list T.

  Definition term := e1 :: e2 :: tl.

  Lemma rule4_correct:
    forall (X:T1) (Y:T1), match (e1 :: e2 :: tl) with
                | nil  => X
                | e :: lst => Y
                end =
                  let e := e1 in
                  let lst := e2 :: tl in
                  Y.
  Proof.
    simpl. intros. reflexivity.
  Qed.
End rule4.



(* stronger version of move_if_out_match *)
Section if_distributive.

  Variable T: Type.
  Variable T1: Type.
  Lemma if_distributive :
    forall (c: bool) (A:T) (B: T) (f: T -> T1), 
      f (if c then A else B) = if c then f A else f B.
  Proof.
    intros.
    destruct c. reflexivity.
    reflexivity.
  Qed.
End if_distributive.


Section rely_body.

  Variable p: Prop.
  Variable T: Type.
  Variable body: option T.
  
  Lemma rely_body :
    p -> ((rely(p); body) = body).
  Proof.
    intro.
    unfold Assertion.
    destruct (prop p).
    reflexivity.
    contradiction.
  Qed.

  Lemma rely_body_false :
    ~p -> (rely(p); body) = None.
  Proof.
    intro.
    unfold Assertion.
    destruct (prop p).
    contradiction.
    reflexivity.
  Qed.
  
End rely_body.


Section if_condition.
  Variable T: Type.
  Lemma if_true_body :
    forall p (X:T) (Y:T),
      p = true -> (if p then X else Y) = X.
  Proof.
    intros. rewrite H. reflexivity.
  Qed.
  
  Lemma if_false_body :
    forall p (X:T) (Y:T),
      p = false -> (if p then X else Y) = Y.
  Proof.
    intros. rewrite H. reflexivity.
  Qed.
End if_condition.


(* eliminate match is not expressable *)


(* Test refinement *)
Record RData := mkRData {
                    a : Z;
                    b : Z
                  }.


Definition low_spec_test (st: RData) :=
  mkRData (a st) ((a st) + 1).

Parameter oracle : RData -> RData.

Definition high_spec_test (st: RData) :=
  (oracle st).

Inductive refrel : RData -> RData -> Prop :=
| hiding : forall hst lst, refrel hst lst -> refrel (oracle hst) {| a := a lst; b := a lst + 1 |}
| normal : forall lst hst, hst = lst -> refrel hst lst.

Lemma refinement :
  forall hst hst' lst,
    refrel hst lst ->
    high_spec_test hst = hst' ->
    exists lst',
    low_spec_test lst = lst' /\ refrel hst' lst'.
Proof.
  intros.
  unfold low_spec_test, high_spec_test in *.
  exists {| a := a lst; b := a lst + 1 |}.
  split. reflexivity. rewrite <- H0. apply hiding. apply H.
Qed.






