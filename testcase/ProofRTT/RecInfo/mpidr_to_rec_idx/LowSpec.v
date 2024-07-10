Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section RecInfo_mpidr_to_rec_idx_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition mpidr_to_rec_idx_spec_low (v_mpidr: Z) (st: RData) : (option (Z * RData)) :=
    (Some ((((((v_mpidr >> (4)) & (4080)) |' ((v_mpidr & (15)))) |' (((v_mpidr >> (4)) & (1044480)))) |' (((v_mpidr >> (12)) & (267386880)))), st)).

End RecInfo_mpidr_to_rec_idx_LowSpec.

#[global] Hint Unfold mpidr_to_rec_idx_spec_low: spec.
