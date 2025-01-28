Require Import String.
Require Export ZArith Zquot.
Require Export List.
Require Import SMap.
Require Import IR.
Require Import Maps.
Local Open Scope string_scope.
Local Open Scope Z_scope.

Class Semof (data: Type) T :=
  semof : T -> value_list -> data -> option value -> data -> Prop.

Section SemofVoid.

  Context {data : Type}.

  Inductive semof_nil_void: Semof data (data -> option data) :=
  | semof_nil_void_intro f d d':
      f d = Some d' ->
      semof f VNil d None d'.
  Global Existing Instance semof_nil_void.

End SemofVoid.

Section SemofInt.
  Context {data : Type}.

  Inductive semof_nil_int_pure
    : Semof data (data -> option Z) :=
  | semof_nil_int_pure_intro f d z:
      f d = Some z ->
      semof f VNil d (Some (VInt z)) d.
  Global Existing Instance semof_nil_int_pure.

  Inductive semof_nil_int
    : Semof data (data -> option (Z * data)) :=
  | semof_nil_int_intro f d z d':
      f d = Some (z, d') ->
      semof f VNil d (Some (VInt z)) d'.
  Global Existing Instance semof_nil_int.

  Inductive semof_int_cons `{Semof data}
    : Semof data (Z -> T) :=
  | semof_int_cons_intro f z l d v d':
    semof (f z) l d v d' ->
    semof f (VCons (VInt z) l) d v d'.
  Global Existing Instance semof_int_cons.

End SemofInt.

Section SemofBool.
  Context {data : Type}.

  Inductive semof_nil_bool_pure
    : Semof data (data -> option bool) :=
  | semof_nil_bool_pure_intro f d b:
      f d = Some b ->
      semof f VNil d (Some (VBool b)) d.
  Global Existing Instance semof_nil_bool_pure.

  Inductive semof_nil_bool
    : Semof data (data -> option (bool * data)) :=
  | semof_nil_bool_intro f d b d':
      f d = Some (b, d') ->
      semof f VNil d (Some (VBool b)) d'.
  Global Existing Instance semof_nil_bool.

  Inductive semof_bool_cons `{Semof data}
    : Semof data (bool -> T) :=
  | semof_bool_cons_intro f b l d v d':
    semof (f b) l d v d' ->
    semof f (VCons (VBool b) l) d v d'.
  Global Existing Instance semof_bool_cons.

End SemofBool.

Section SemofPtr.
  Context {data : Type}.

  Inductive semof_nil_ptr_pure: Semof data (data -> option Ptr) :=
  | semof_nil_ptr_pure_intro f d p:
      f d = Some p ->
      semof f VNil d (Some (VPtr p)) d.
  Global Existing Instance semof_nil_ptr_pure.

  Inductive semof_nil_ptr
    : Semof data (data -> option (Ptr * data)) :=
  | semof_nil_ptr_intro f d p d':
      f d = Some (p, d') ->
      semof f VNil d (Some (VPtr p)) d'.
  Global Existing Instance semof_nil_ptr.

  Inductive semof_ptr_cons {T} `{Semof data T}
    : Semof data (Ptr -> T) :=
  | semof_ptr_cons_intro f p l d v d':
    semof (f p) l d v d' ->
    semof f (VCons (VPtr p) l) d v d'.
  Global Existing Instance semof_ptr_cons.

End SemofPtr.

Section SemofArray.
  Context {data : Type}.

  Fixpoint list_to_value_list (l: list Z) : value_list :=
    match l with
    | nil => VNil
    | cons x l => VCons (VInt x) (list_to_value_list l)
    end.

  Inductive semof_nil_array_pure : Semof data (data -> option (list Z)) :=
  | semof_nil_array_pure_intro f d a:
      f d = Some a ->
      semof f VNil d (Some (VStruct (list_to_value_list a))) d.
  Global Existing Instance semof_nil_array_pure.

  Inductive semof_nil_array : Semof data (data -> option (list Z * data)) :=
  | semof_nil_array_intro f d a d':
      f d = Some (a, d') ->
      semof f VNil d (Some (VStruct (list_to_value_list a))) d'.
  Global Existing Instance semof_nil_array.

  Inductive semof_array_cons {T} `{Semof data T}
    : Semof data (list Z -> T) :=
  | semof_array_cons_intro f a l d v d':
    semof (f a) l d v d' ->
    semof f (VCons (VStruct (list_to_value_list a)) l) d v d'.
  Global Existing Instance semof_array_cons.
End SemofArray.

Inductive primitive (data: Type) :=
| PRIM (T: Type) (f: T) (sem: value_list -> data -> option value -> data -> Prop).

Definition prim {data: Type} {T} (f: T) {sem: Semof data T}  := PRIM data T f (semof f).
