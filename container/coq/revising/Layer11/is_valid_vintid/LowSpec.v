Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer11_is_valid_vintid_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition is_valid_vintid_spec_low (v_0: Z) (st: RData) : (option (bool * RData)) :=
    if (v_0 <? (1020))
    then (Some (true, st))
    else (
      if ((v_0 & (18446744073709550592)) =? (4096))
      then (Some (true, st))
      else (
        when v_11, st_0 == ((load_RData 8 (mkPtr "max_vintid" 0) st));
        if (v_0 >? (8191))
        then (Some (((v_11 - (v_0)) >=? (0)), st_0))
        else (Some (false, st_0)))).

End Layer11_is_valid_vintid_LowSpec.

#[global] Hint Unfold is_valid_vintid_spec_low: spec.
