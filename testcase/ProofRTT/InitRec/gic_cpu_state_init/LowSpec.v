Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section InitRec_gic_cpu_state_init_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition gic_cpu_state_init_spec_low (v_gicstate: Ptr) (st: RData) : (option RData) :=
    rely (((v_gicstate.(poffset)) = (584)));
    rely (((v_gicstate.(pbase)) = ("slot_rec")));
    when v_call, st_0 == ((memset_spec v_gicstate 0 216 st));
    when st_1 == ((store_RData 8 (ptr_offset v_gicstate 72) 33025 st_0));
    (Some st_1).

End InitRec_gic_cpu_state_init_LowSpec.

#[global] Hint Unfold gic_cpu_state_init_spec_low: spec.
