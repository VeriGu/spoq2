Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section ValidateAddr_addr_in_par_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition addr_in_par_spec_low (v_rd: Ptr) (v_addr: Z) (st: RData) : (option (bool * RData)) :=
    rely ((rd_is_locked st));
    rely (((v_rd.(poffset)) = (0)));
    rely (((v_rd.(pbase)) = ("slot_rd")));
    when v_call, st == ((realm_par_size_spec v_rd st));
    let v_cmp := (v_call >? (v_addr)) in
    let __return__ := true in
    let __retval__ := v_cmp in
    (Some (__retval__, st)).

End ValidateAddr_addr_in_par_LowSpec.

#[global] Hint Unfold addr_in_par_spec_low: spec.
