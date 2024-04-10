Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section SMCHandler_smc_version_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition smc_version_spec_low (st: RData) : (option (Z * RData)) :=
    let __return__ := true in
    let __retval__ := 3670016 in
    (Some (__retval__, st)).

End SMCHandler_smc_version_LowSpec.

#[global] Hint Unfold smc_version_spec_low: spec.
