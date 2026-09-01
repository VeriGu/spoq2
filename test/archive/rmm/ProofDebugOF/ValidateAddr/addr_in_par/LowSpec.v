Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import RealmInfo.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section ValidateAddr_addr_in_par_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition addr_in_par_spec_low (v_rd: Ptr) (v_addr: Z) (st: RData) : (option (bool * RData)) :=
    rely ((rd_is_locked st));
    rely (((v_rd.(poffset)) = (0)));
    rely (((v_rd.(pbase)) = ("slot_rd")));
    when v_call, st_0 == ((realm_par_size_spec v_rd st));
    (Some (((v_call - (v_addr)) >? (0)), st_0)).

End ValidateAddr_addr_in_par_LowSpec.

#[global] Hint Unfold addr_in_par_spec_low: spec.
