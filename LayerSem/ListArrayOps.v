Require Import List.
Require Import Coqlib.
Require Import CommonLib.
Import ListNotations.

Local Open Scope list_scope.
Local Open Scope nat_scope.

Section ListArrayOps.
  Fixpoint update_at {A : Type} (i : nat) (v : A) (l : list A) : list A :=
    match l with
    | [] => []
    | hd :: tl =>
        match i with
        | O => v :: tl
        | S n => hd :: update_at n v tl
        end
            end.
  Definition get {A : Type} (i : nat) (l : list A) : option A :=
    nth_error l i.

  Definition set {A : Type} (i : nat) (v : A) (l : list A) : list A :=
    update_at i v l.

  Lemma update_at_length : forall A (l : list A) i v,
      length l = i -> update_at i v l = l.
  Proof.
    intros A l. induction l as [| hd tl IH]; intros i v Hlen.
    - destruct i; reflexivity.
    - destruct i; try discriminate. simpl in Hlen. apply eq_add_S in Hlen.
      simpl. rewrite IH; try assumption. reflexivity.
  Qed.

  Lemma gss:
    forall {A: Type} (i: nat) (v: A) (l: list A),
      i < length l /\ l <> [] -> get i (set i v l) = Some v.
  Proof.
    intros A i v l.
    intros H. destruct H as [H1 H2].
    revert l H1 H2.
    induction i as [| i' IH]; intros l H1 H2.
    - destruct l.
      + inversion H1.
      + simpl. reflexivity.
    - destruct l as [| h t].
      + inversion H1.
      + simpl. apply IH.
        * simpl in H1. apply Nat.succ_lt_mono. assumption.
        * intros H. destruct t; [inversion H1; lia | discriminate].
  Qed.

  (* Lemma gso: *)
  (*   forall {A: Type} (i j: nat) (v: A) (l: list A), *)
  (*     i <> j -> i < length l -> get i (set j v l) = get i l. *)
  (* Proof. *)
  (*   intros A i j v l Hneq Hilen. *)
  (*   revert l j v Hilen Hneq. *)
  (*   induction i; intros l j v Hilen Hneq. *)
  (*   - destruct l. *)
  (*     + simpl in Hilen. lia. *)
  (*     + destruct j. *)
  (*       * lia. *)
  (*       * reflexivity. *)
  (*   - destruct l, j. *)
  (*     * auto. *)
  (*     * auto. *)
  (*     * reflexivity. *)
  (*     * simpl. apply IHi. simpl in Hilen. lia. lia. *)
  (* Qed. *)

  Lemma get_ge_None:
    forall {A: Type} (i: nat) (l: list A),
      i >= length l -> get i l = None.
  Proof.
    intros A i l Hge.
    revert l Hge.
    induction i; intros l Hge.
    - assert (length l = 0) by lia. rewrite length_zero_iff_nil in H. rewrite H.
      reflexivity.
    - unfold get. apply nth_error_None. lia.
  Qed.

  Lemma set_nil_nil:
    forall {A: Type} (i: nat) (v: A),
      set i v [] = [].
  Proof.
    intros. induction i; reflexivity.
  Qed.

  Lemma gso:
    forall {A: Type} (i j: nat) (v: A) (l: list A),
      i <> j -> get i (set j v l) = get i l.
  Proof.
    intros A i j v l Hneq.
    revert l j v Hneq.
    induction i; intros l j v Hneq.
    - destruct l.
      + rewrite set_nil_nil; reflexivity.
      + destruct j.
        * lia.
        * reflexivity.
    - destruct l, j.
      * reflexivity.
      * reflexivity.
      * reflexivity.
      * simpl. apply IHi. lia.
  Qed.

End ListArrayOps.
