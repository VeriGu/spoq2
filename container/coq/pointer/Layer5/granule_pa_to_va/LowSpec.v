Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer5_granule_pa_to_va_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition granule_pa_to_va_spec_low (v_0: Z) (st: RData) : (option (Ptr * RData)) :=
    rely (((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - ((MEM0_PHYS + (MEM0_SIZE)))) < (0)))) \/ ((((v_0 - (MEM1_PHYS)) >= (0)) /\ (((v_0 - ((MEM1_PHYS + (MEM1_SIZE)))) < (0)))))));
    if ((v_0 & (549755813888)) =? (0))
    then (Some ((int_to_ptr (v_0 + (18446744004990074880))), st))
    else (Some ((int_to_ptr (v_0 + (18446743457381744640))), st)).

End Layer5_granule_pa_to_va_LowSpec.

#[global] Hint Unfold granule_pa_to_va_spec_low: spec.
