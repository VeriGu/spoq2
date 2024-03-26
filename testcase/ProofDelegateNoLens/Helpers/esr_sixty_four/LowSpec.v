Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Helpers_esr_sixty_four_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition esr_sixty_four_spec_low (v_esr: Z) (st: RData) : (option (bool * RData)) :=
    let v_and := (v_esr & (32768)) in
    let v_cmp := (v_and <>? (0)) in
    let __return__ := true in
    let __retval__ := v_cmp in
    (Some (__retval__, st)).

End Helpers_esr_sixty_four_LowSpec.

#[global] Hint Unfold esr_sixty_four_spec_low: spec.
