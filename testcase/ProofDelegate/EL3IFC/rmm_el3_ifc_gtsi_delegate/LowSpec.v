Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section EL3IFC_rmm_el3_ifc_gtsi_delegate_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition rmm_el3_ifc_gtsi_delegate_spec_low (v_addr: Z) (st: RData) : (option (Z * RData)) :=
    when v_call, st == ((monitor_call_spec 3288334768 v_addr 0 0 0 0 0 st));
    let __return__ := true in
    let __retval__ := v_call in
    (Some (__retval__, st)).

End EL3IFC_rmm_el3_ifc_gtsi_delegate_LowSpec.

#[global] Hint Unfold rmm_el3_ifc_gtsi_delegate_spec_low: spec.
