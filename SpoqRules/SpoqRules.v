


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
(* Record RData := mkRData { *)
(*                     a : Z; *)
(*                     b : Z *)
(*                   }. *)


(* Definition low_spec_test (v:Z) (st: RData) := *)
(*   (v + 1, mkRData (a st) ((a st) + v)). *)

(* Parameter oracle : Z -> RData -> (Z * RData). *)

(* Definition high_spec_test (v: Z) (st: RData) := *)
(*   (oracle v st). *)

(* Inductive refrel_v : Z -> Z -> Prop := *)
(* | hiding_Z : forall hv lv hst , refrel_v hv lv -> refrel_v (fst (oracle hv hst)) (lv + 1) *)
(* | normal_Z : forall v v', v = v' -> refrel_v v v'. *)


(* Inductive refrel : RData -> RData -> Prop := *)
(* | hiding : forall hst lst hv lv, refrel_v hv lv -> refrel hst lst -> refrel (snd (oracle hv hst)) {| a := a lst; b := a lst + lv |} *)
(* | normal : forall lst hst, hst = lst -> refrel hst lst. *)


(* Lemma refinement : *)
(*   forall hst hst' lst hv lv hv', *)
(*     refrel hst lst -> *)
(*     refrel_v hv lv ->  *)
(*     high_spec_test hv hst = (hv',hst') -> *)
(*     exists lst' lv', *)
(*     low_spec_test lv lst = (lv',lst') /\ refrel hst' lst' /\ refrel_v hv' lv'. *)
(* Proof. *)
(*   intros. *)
(*   unfold low_spec_test, high_spec_test in *. *)
(*   exists {| a := a lst; b := a lst + lv |}. exists (lv + 1). *)
(*   split. reflexivity. *)
(*   assert ((fst (oracle hv hst)) = hv'). rewrite H1. *)
(*   simpl. reflexivity. *)
(*   assert ((snd (oracle hv hst)) = hst'). rewrite H1. *)
(*   simpl. reflexivity. *)
(*   split. *)
(*   rewrite <- H3. *)
(*   apply hiding. apply H0. apply H. *)
(*   rewrite <- H2. *)
(*   apply hiding_Z. apply H0. *)
(* Qed. *)


(* (* Copied from metacoq tutorial *) *)

(* From MetaCoq.Template Require Export All Checker Reduction. *)

(* Notation "'$quote' x" := ltac:((let p y := exact y in *)
(*                              quote_term *)
(*                              x *)
(*                              p)) (at level 0). *)

(* Notation "'$run' f" := ltac:(let p y := exact y in *)
(*                              run_template_program *)
(*                              f *)
(*                              p) (at level 0). *)

(* Notation "'$quote_rec' x" := ($run (tmQuoteRec x)) (at level 0). *)

(* Notation "'$unquote' x" := ltac:((let p y := match y with *)
(*                                                existT_typed_term ?T ?b => exact b *)
(*                                              end in *)
(*                              run_template_program *)
(*                              (tmUnquote x) *)
(*                              p)) (at level 0). *)

(* Notation "'$unquote' x : T" := ($run (tmUnquoteTyped T x)) (at level 0, T at level 100, x at next level). *)

(* Definition unfold_toplevel {A} (x : A) := *)
(*   tmBind (tmQuote x) (fun y => *)
(*                         match y with *)
(*                         | tConst na _ => *)
(*                             tmEval (unfold na) x *)
(*                         | y => tmReturn x *)
(*                         end). *)

(* Notation "'$Quote' x" := ($run (tmBind (unfold_toplevel x) (tmQuote))) (at level 0). *)

(* Definition term_eqb (t1 t2 : term) := *)
(*   @eq_term config.default_checker_flags init_graph t1 t2. *)

(* Notation "t == u" := (term_eqb t u) (at level 70). *)

(* Open Scope bs. *)
(* Open Scope bool. *)
(* Open Scope list. *)

(* Definition tLam x A b := *)
(*   tLambda {| binder_name := nNamed x; binder_relevance := Relevant |} A b. *)

(* Definition tLet x A t b := *)
(*   tLetIn {| binder_name := nNamed x; binder_relevance := Relevant |} t A b. *)

(* Require Export Nat. *)

(* Notation "'__'" := (hole) (no associativity, at level 0). *)

(* From Coq Require Import List Utf8. *)

(* Unset Guard Checking. *)


(* Check ($quote (3 + 2)). *)


(* Parameter X : Type. *)
(* Parameter x : bool. *)
(* Parameter y : list nat. *)
(* Parameter f : nat -> nat. *)
(* Check ($quote (if x then X else X)). *)
(* Check ($quote (match y with *)
(*                | a :: b :: [] => hd (a :: b :: [])                  *)
(*                | [] => hd y *)
(*                | c :: xs => hd y             *)
(*                end)).             *)


(* Print map_branch. *)

(* Fixpoint match_subst (t : term) := *)
(*   match t with *)
(*   | tRel n => tRel n *)
(*   | tVar id => tVar id *)
(*   | tEvar ev args => tEvar ev (map match_subst args) *)
(*   | tSort s => tSort s *)
(*   | tCast t kind v => tCast (match_subst t) kind (match_subst v) *)
(*   | tProd na ty body => tProd na (match_subst ty) (match_subst body) *)
(*   | tLambda na ty body => tLambda na (match_subst ty) (let_to_lambda body) *)
(*   | tLetIn na def def_ty body => tLetIn na (match_subst def) (match_subst def_ty) (match_subst body) *)
(*   | tApp f args => tApp (match_subst f) (map match_subst args) *)
(*   | tConst c u => tConst c u *)
(*   | tInd ind u => tInd ind u *)
(*   | tConstruct ind idx u => tConstruct ind idx u *)
(*   | tCase ind p discr brs => *)
(*       let brs' := map_branches (fun bbody => subs bbody discr ) brs in *)
(*       tCase ind p' discr brs' *)
(*   | tProj proj t => tProj proj (let_to_lambda t) *)
(*   | tFix mfix idx => tFix (map (map_def let_to_lambda let_to_lambda) mfix) idx *)
(*   | tCoFix mfix idx => tCoFix (map (map_def let_to_lambda let_to_lambda) mfix) idx *)
(*   | tInt i => tInt i *)
(*   | tFloat f => tFloat f *)
(*   end. *)
