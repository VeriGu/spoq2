Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section RealmInfo_addr_in_rec_par_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition addr_in_rec_par_spec_low (v_rec: Ptr) (v_addr: Z) (st: RData) : (option (bool * RData)) :=
    when v_call, st == ((rec_par_size_spec v_rec st));
    let v_cmp := (v_call >? (v_addr)) in
    let __return__ := true in
    let __retval__ := v_cmp in
    (Some (__retval__, st)).

End RealmInfo_addr_in_rec_par_LowSpec.

#[global] Hint Unfold addr_in_rec_par_spec_low: spec.
