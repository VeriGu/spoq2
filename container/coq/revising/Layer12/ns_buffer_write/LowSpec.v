Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer5.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer12_ns_buffer_write_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition ns_buffer_write_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Ptr) (st: RData) : (option (bool * RData)) :=
    when v_5, st_0 == ((granule_pa_to_va_spec v_1 st));
    when v_6, st_1 == ((memcpy_ns_write_spec v_5 v_3 v_2 st_0));
    (Some (v_6, st_1)).

End Layer12_ns_buffer_write_LowSpec.

#[global] Hint Unfold ns_buffer_write_spec_low: spec.
