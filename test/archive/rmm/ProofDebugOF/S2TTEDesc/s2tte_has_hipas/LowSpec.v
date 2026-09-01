Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section S2TTEDesc_s2tte_has_hipas_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2tte_has_hipas_spec_low (v_s2tte: Z) (v_hipas: Z) (st: RData) : (option (bool * RData)) :=
    match (
      if ((v_s2tte & (3)) =? (0))
      then (
        match (
          if (((v_s2tte & (60)) - (v_hipas)) =? (0))
          then (Some (true, true, st))
          else (Some (false, false, st))
        ) with
        | (Some (__return___0, __retval___0, st_0)) =>
          if __return___0
          then (Some (true, __retval___0, st_0))
          else (Some (false, __retval___0, st_0))
        | None => None
        end)
      else (Some (false, false, st))
    ) with
    | (Some (__return__, __retval__, st_0)) =>
      if __return__
      then (Some (__retval__, st_0))
      else (Some (false, st_0))
    | None => None
    end.

End S2TTEDesc_s2tte_has_hipas_LowSpec.

#[global] Hint Unfold s2tte_has_hipas_spec_low: spec.
