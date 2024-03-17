


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


Section move_rely_out_when.
  Variable T: Type.
  Variable T1: Type.
  Lemma move_rely_out_when_correct :
    forall (p: Prop) (body: option T) (e: T -> option T1),
      match (rely p; body) with
      | Some x => e x
      | None => None
      end = (rely p; match body with
                     | Some x => e x
                     | None => None
                     end).
  Proof.
    intros.
    simpl.
    unfold Assertion.
    destruct (prop p).
    reflexivity.
    reflexivity.
  Qed.
End move_rely_out_when.


Section move_when_out_when.
  Variable T: Type.
  Variable T1: Type.
  Variable T2: Type.
  Lemma move_when_out_when_correct :
    forall (A: option T) (B: T -> option T1) (f: T1 -> option T2),
      match match A with
            | Some x => B x
            | None => None
            end
              
      with
      | Some x => f x
      | None => None
      end =
              match A with
              | Some x => match B x with
                          | Some x => f x
                          | None => None
                          end
              | None => None
              end.
  Proof.
    intros.
    destruct A.
    reflexivity.
    reflexivity.
  Qed.
End move_when_out_when.


(* T6 *)
Section substitution_lemma.
  Variable T: Type.
  Variable T1: Type.
  Variable f: T -> T1.

                       
  Theorem rule_6_correct :
    forall (V: T) (P1 : T) (f : T -> T1),
       V = P1 -> f V = f P1.
  Proof.
    intros. f_equal. auto.
  Qed.

End substitution_lemma.


(*
when X == (if c then (Some Y) else (Some Z)); body
=> if c then (match Y with X => body) else (match Z with X => body)
 *)
Section move_if_out_of_when.
  Variable T: Type.
  Variable T1: Type.
  Theorem move_if_out_of_when_correct:
    forall (c: bool) (Y: T) (Z: T) (body: T -> option T1),
      (match (if c then (Some Y) else (Some Z)) with
       | Some x => body x   
       | None => None           
       end)
      = if c then (match Y with x => body x end) else (match Z with x => body x end).
  Proof.
    intros. destruct c. reflexivity. reflexivity.
  Qed.
End move_if_out_of_when.


Section eliminate_when.
  Variable T: Type.
  Variable T1: Type.
  Theorem eliminate_when_correct :
    forall (Y:T) (body: T -> option T1),
               match (Some Y) with
               | Some x => body x
               | None => None
               end = body Y.
  Proof.
    intros. simpl. reflexivity.
  Qed.
End eliminate_when.

Require Import Coq.ZArith.Znumtheory.


  
Section arithmatic_simplify.
  Theorem eq_move_left :
    forall a b: Z,
      a = b -> a - b = 0.
  Proof.
     intros.
     rewrite <- Z.sub_cancel_r with (p:=b) in H.
     rewrite Z.sub_diag in H.
     auto.
  Qed.

  Theorem eqb_move_left :
    forall a b : Z,
      a =? b = true -> a - b =? 0 = true.
  Proof.
    intros.
    rewrite Z.eqb_eq in H |- *.
    apply eq_move_left.
    auto.
  Qed.

  Theorem neq_move_left :
    forall a b: Z,
      a <> b -> a - b <> 0.
  Proof.
    unfold not.
    intros.
    rewrite <- Z.sub_cancel_r with (p:=b) in H.
    rewrite Z.sub_diag in H.
    apply H.
    auto.
  Qed.

  Theorem neqb_move_left :
    forall a b: Z,
      a <>? b = true -> a - b <>? 0 = true.
  Proof.
    intros.
    unfold negb in *.
    destruct (a =? b) eqn:Heq. inversion H.
    rewrite Z.eqb_neq in Heq.
    destruct (a - b =? 0) eqn:Heq2.
    rewrite <- Z.sub_cancel_r with (p:=b) in Heq.
    rewrite Z.sub_diag in Heq.
    rewrite Z.eqb_eq in Heq2.
    contradiction. auto.
  Qed.

  Theorem lt_move_left :
    forall a b : Z,
      a < b -> a - b < 0.
  Proof.
    intros.
    rewrite Z.sub_lt_mono_r with (p:=b) in H.
    rewrite Z.sub_diag in H.
    auto.
  Qed.


  Theorem ltb_move_left :
    forall a b : Z,
      a <? b = true -> a - b <? 0 = true.
  Proof.
    intros.
    apply Zlt_is_lt_bool in H.
    apply Zlt_is_lt_bool.
    apply lt_move_left. auto.
  Qed.

  
  Theorem lte_move_left :
    forall a b: Z, 
      a <= b -> a - b <= 0.
  Proof.
    intros.
    rewrite Z.sub_le_mono_r with (p:=b) in H.
    rewrite Z.sub_diag in H.
    intuition.
  Qed.

  Theorem leb_move_left :
    forall a b: Z,
      a <=? b = true -> a - b <=? 0 = true.
  Proof.
    intros.
 
    apply Zle_bool_imp_le in H.
    rewrite Z.sub_le_mono_r with (p:=b) in H.
    rewrite Z.sub_diag in H.

    apply Zle_imp_le_bool.
    auto.    
  Qed.


  Theorem gt_move_left :
    forall a b : Z,
      a > b -> a - b > 0.
  Proof.
    intros.
    
    apply Z.lt_gt.

    rewrite Z.gt_lt_iff in H.
    
    rewrite Z.sub_lt_mono_r with (p:=b) in H.
    rewrite Z.sub_diag in H.
    auto.
  Qed.


  Theorem gtb_move_left :
    forall a b : Z,
      a >? b = true -> a - b >? 0 = true.
  Proof.
    intros.
    rewrite Z.gtb_ltb in H |- *.
    apply Zlt_is_lt_bool in H.
    apply Zlt_is_lt_bool.
    rewrite Z.sub_lt_mono_r with (p:=b) in H.
    rewrite Z.sub_diag in H.
    auto.    
  Qed.


  Theorem ge_move_left :
    forall a b: Z, 
      a >= b -> a - b >= 0.
  Proof.
    intros.
    apply Z.ge_le in H.
    apply Z.le_ge.
    rewrite Z.sub_le_mono_r with (p:=b) in H.
    rewrite Z.sub_diag in H.
    auto.    
  Qed.

  Theorem geb_move_left :
    forall a b: Z, 
      a >=? b = true -> a - b >=? 0 = true.
  Proof.
    intros a b.
    rewrite Z.geb_leb.
    rewrite Z.geb_leb.
    intros.
    apply Zle_bool_imp_le in H.
    rewrite Z.sub_le_mono_r with (p:=b) in H.
    rewrite Z.sub_diag in H.
    apply Zle_imp_le_bool.
    auto.       
  Qed.
 
  Theorem add_divide_constant_factor :
    forall a b c : Z,
     0 < c -> (c | a) -> (c | b) -> a + b = c * (a / c + b / c).
  Proof.
    intros.
    rewrite Z.mul_add_distr_l.
    rewrite <- Zdivide_Zdiv_eq with (a := c) (b := a).
    rewrite <- Zdivide_Zdiv_eq with (a := c) (b := b).
    reflexivity.
    exact H.
    exact H1.
    exact H.
    exact H0.
  Qed.

  Theorem minus_divide_constant_factor :
     forall a b c : Z,
     0 < c -> (c | a) -> (c | b) -> a - b = c * (a / c - b / c).
  Proof.
    intros.
    rewrite Z.mul_sub_distr_l.
    rewrite <- Zdivide_Zdiv_eq with (a := c) (b := a).
    rewrite <- Zdivide_Zdiv_eq with (a := c) (b := b).
    reflexivity.
    exact H.
    exact H1.
    exact H.
    exact H0.
  Qed.

End arithmatic_simplify.


Tactic Notation "eliminate_match" constr(e):=
  let y := eval cbv iota delta [e] in e in
        idtac y; exact y.
                                    

Module Type RECORD.
  Parameter keyType : Type.
  Parameter key_elem_eq : forall (a : keyType) (b: keyType), {a = b} + {a <> b}.
  Print sigT.
  Parameter t : (forall x: keyType, Type) -> Type.
  Parameter init: forall {record: forall x: keyType, Type}, (forall x: keyType, record x) -> t record.
  Parameter proj: forall {record: forall x: keyType, Type} (x: keyType), t record -> record x.
  Parameter set: forall {record: forall x: keyType, Type} (x:keyType), t record -> record x -> t record.
  Axiom projection_gss :
    forall (record: forall x : keyType, Type) (x : keyType) (rec: t record),
      set x rec (proj x rec) = rec.
End RECORD.


Import Coq.Logic.FunctionalExtensionality.
Module string_record <: RECORD.
  Definition keyType := string.
  Definition key_elem_eq := string_dec.
  Definition record_type := forall x: keyType, Type.
  Definition t (f: record_type) := forall x: keyType, f x.

  (* record only init the values that are not type Empty*)
  Definition init {record: record_type} (ini: forall x: keyType, record x) : t record.
    unfold t. intro. unfold record_type in *.
    exact (ini x).
  Defined.

  Print init.
    
  Definition proj {record: record_type} (x: keyType) (rec: t record) : record x :=
    rec x.
    
  Check proj.

  Definition set {record: record_type} (x: keyType) (rec: t record) (v : record x) : t record.
    intros. unfold t. intro.
    destruct (string_dec x x0). rewrite <- e.
    exact v.
    exact (rec x0).
  Defined.

  Print set.
  Theorem projection_gss' :
    forall (record: record_type) (x : keyType) (rec: t record) y,
      set x rec (proj x rec) y = rec y.
  Proof.
    intros.
    unfold proj, set. 
    destruct (string_dec x y).  unfold eq_rect.
    simpl. rewrite e. reflexivity. reflexivity.
  Qed.

  Theorem projection_gss :
    forall (record: record_type) (x : keyType) (rec: t record),
      set x rec (proj x rec) = rec.
  Proof.
    unfold t in *. intros.
    apply functional_extensionality_dep.
    apply projection_gss'.
  Qed.
  

  Theorem projection_gso :
    forall (record: record_type) (x: string) (y:string) (rec: t record) (v: record y),
      y <> x -> proj x (set y rec v) = proj x rec.
  Proof.
    intros. unfold proj, set.
    destruct (string_dec y x) eqn: He. contradiction. reflexivity.
  Qed.    
End string_record.



(* Ltac record_conversion e := *)
(*   match e with *)
(*   | context G [ {| a := a (?X); b := b (?X)|} ]  => let y := context G [X] in change e with y *)
(*   | context G [ {| a := ?X; b := _  |}.(a) ] => let y := context G [X] in change e with y *)
(*   | context G [ {| a := _ ; b := ?X |}.(b) ] =>  let y := context G [X] in change e with y *)
(*   end. *)
                                                          


(* Lemma record_sgs : *)
(*   forall (p: record) v1, *)
(*     {|a := v1; b := b p|}.(a) = v1. *)
(* Proof. *)
(*   intros. cbv. simpl. reflexivity. *)
(* Qed. *)


(* Lemma record_sgd : *)
(*   forall (p: record) v1, *)
(*     {|a := v1; b := b p|}.(b) = p.(b). *)
(* Proof. *)
(*   intros. cbv. simpl. reflexivity. *)
(* Qed. *)


(* Lemma record_sgd : *)
(*   forall (p: record) v1, *)
(*     {|a := v1; b := b p|}.(b) = p.(b). *)
(* Proof. *)
(*   intros. cbv. simpl. reflexivity. *)
(* Qed. *)






(* Tactic Notation "record_gss" constr(e) "[" ne_smart_global_list(l) "]":= *)
(*   let y := eval cbv beta iota delta [ ltac:(l) ] in e in *)
(*     idtac y; pose y. *)


(* Definition p2 (p: record) : record. *)
(*   record_gss ({|a := a p; b := b p|}) [a b]. *)
(* Defined. *)

      

(* Section hlist. *)
(*   Variable A : Type. *)
(*   Variable B : A -> Type. *)

(*   Inductive hlist : list A -> Type := *)
(*   | HNil : hlist nil *)
(*   | HCons : forall (x : A) (ls : list A), B x -> hlist ls -> hlist (x :: ls). *)
    
(* End hlist. *)

(*  Arguments HNil {A B}. *)
(*  Arguments HCons [A B x ls] _ _. *)
(*  Infix ":::" := HCons (right associativity, at level 60). *)

(*  Section record. *)

(*   (* record is a partial map of (string * Type) *) *)
(*   Definition constructor : Type := string -> Type. *)
                                

(*   (* Definition recordType := list constructor. *) *)
(*   Inductive Empty : Type := . *)
  
(*   Definition emptyrecord : constructor := (fun x => Empty). *)
  
(*   Definition unit_record : constructor := (fun x => *)
(*                                            if String.eqb x "a" then unit *)
(*                                            else emptyrecord x). *)
  
(*   (* Definition two_elem_record : recordType := (Con "a" Z) :: (Con "b" Z) :: nil. *) *)
  

(*   Section denote. *)
(*     Definition constructorDenote (c : constructor) := *)
(*       retType c. *)
    
(*     Definition recordBuild := hlist constructor constructorDenote.   *)
(*   End denote. *)

(*   Notation "[ x ]" := (x : constructorDenote (Con _ _)). *)

(*   Definition empty_record_v : recordBuild unit_record := *)
(*     [ tt ] ::: HNil. *)


(*   Definition two_element_record_v : recordBuild two_elem_record := *)
(*     [ 1 ] ::: [ 2 ] :::  HNil. *)


(*   Definition proj (s : string) := *)
    
(* End record. *)



(* Definition not_simplified_2 := *)
(*   Eval cbv delta iota in not_test. *)

(* Print not_simplified_2. *)

(* Theorem t : *)
(*   not_test = not_simplified. *)
(* Proof. *)
(*   unfold not_test. unfold not_simplified. *)
(*   reflexivity. *)
(* Qed. *)


(* Print not_simplified. *)


(* Ltac match_subst e := *)
(*   match e with *)
(*   | [ match ?X with *)
(*         | Some x => ?B *)
(*         | None  => ?C *)
(*         end ] => simpl *)
(*   end. *)
    

(* Inductive type : Type := *)
(* | Z_t : type *)
(* | BOOL_t : type *)
(* | STRING_t : type *)
(* | LIST_t : type -> type *)
(* | RECORD_t : list (string * type) -> type. *)


(* Inductive biop := *)
(* | ADD. *)

(* Inductive uop := *)
(*  | Not. *)

(* Inductive SpecNode : type -> Type := *)
(* | z_const : Z -> SpecNode Z_t *)
(* | b_const : bool -> SpecNode BOOL_t *)
(* | s_const : string -> SpecNode STRING_t *)
(* | record : list (string * SpecNode t) -> SpecNode (RECORD_t) *)
(* | biopexpr : biop -> SpecNode -> SpecNode -> SpecNode *)
(* | uopexpr : uop -> SpecNode -> SpecNode *)
(* | func : string -> (string -> SpecNode). *)

(* Inductive SpecValue := *)
(* | constV : Const -> SpecValue *)
(* | funcV : string -> (string -> SpecNode) -> SpecValue. *)
  
(* Inductive dynamic_eval : SpecNode -> SpecValue -> Prop := *)
(* | CONST_eval : forall C, dynamic_eval (const C) (constV C) *)
(* | ADD_eval : forall e1 e2 z1 z2, *)
(*     dynamic_eval e1 (constV (Int z1)) -> *)
(*     dynamic_eval e2 (constV (Int z2)) -> *)
(*     dynamic_eval (biopexpr ADD e1 e2) (constV (Int (z1 + z2))). *)


(* eliminate match is not expressable *)


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


(* Copied from metacoq tutorial *)

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
(* Check ($quote {| a := 3 ; b := 4 |}). *)


(* Parameter X : Type. *)
(* Parameter x : bool. *)
(* Parameter y : list Z. *)
(* Parameter f : nat -> nat. *)
(* Check ($quote (if x then X else X)). *)
(* Check ($quote (match (1 :: y) with *)
(*                | a :: b :: [] => hd (a :: b :: []) *)
(*                | [] => hd y *)
(*                | c :: xs => hd y *)
(*                end)). *)


(* Print map_branch. *)

               
(* Fixpoint subst_expr (e: term) (from: term) (to: term) := *)
(*   if from == e then to *)
(*   else *)
(*   match e with *)
(*   | tRel n => tRel n *)
(*   | tVar id => tVar id *)
(*   | tEvar ev args => tEvar ev (map (fun arg => subst_expr arg from to) args) *)
(*   | tSort s => tSort s *)
(*   | tCast t kind v => tCast (subst_expr t from to) kind (subst_expr v from to) *)
(*   | tProd na ty body => tProd na (subst_expr ty from to) (subst_expr body from to) *)
(*   | tLambda na ty body => tLambda na (subst_expr ty from to) (subst_expr body from to) *)
(*   | tLetIn na def def_ty body => tLetIn na (subst_expr def from to) (subst_expr def_ty from to) (subst_expr body from to) *)
(*   | tApp f args => tApp (subst_expr f from to) (map (fun arg => subst_expr arg from to) args) *)
(*   | tConst c u => tConst c u *)
(*   | tInd ind u => tInd ind u *)
(*   | tConstruct ind idx u => tConstruct ind idx u *)
(*   | tCase ind p discr brs => *)
(*      let p' := map_predicate id (fun arg => subst_expr arg from to) (fun arg => subst_expr arg from to) p in *)
(*      let brs' := map_branches (fun arg => subst_expr arg from to) brs in *)
(*       tCase ind p' (subst_expr discr from to) brs' *)
(*   | tProj proj t => tProj proj (subst_expr t from to) *)
(*   | tFix mfix idx => tFix (map (map_def (fun arg => subst_expr arg from to) (fun arg => subst_expr arg from to)) mfix) idx *)
(*   | tCoFix mfix idx => tCoFix (map (map_def (fun arg => subst_expr arg from to) (fun arg => subst_expr arg from to)) mfix) idx *)
(*   | tInt i => tInt i *)
(*   | tFloat f => tFloat f *)
(*   end. *)


(* Print subst. *)

(* Check $unquote (subst_expr ($quote (5 + 3)) ($quote 5) ($quote 6)). *)


(* Theorem subst_lemma : *)
(*   forall (x: Z) (y: Z), *)
(*     $unquote (subst_expr ($quote (x + 3)) ($quote x) ($quote y)) = $unquote (subst_expr ($quote (4 + 3)) ($quote 4) ($quote y)). *)
(* Proof. *)
(*   intros. reflexivity. *)
(* Qed. *)

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
