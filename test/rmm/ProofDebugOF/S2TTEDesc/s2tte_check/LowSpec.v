Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section S2TTEDesc_s2tte_check_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2tte_check_spec_low (v_s2tte: Z) (v_level: Z) (v_ns: Z) (st: RData) : (option (bool * RData)) :=
    match (
      if (((v_s2tte & (36028797018963968)) - (v_ns)) =? (0))
      then (
        match (
          if ((v_level =? (3)) && (((v_s2tte & (3)) =? (3))))
          then (Some (false, false, st))
          else (
            match (
              if ((v_level =? (2)) && (((v_s2tte & (3)) =? (1))))
              then (Some (false, false, st))
              else (Some (true, false, st))
            ) with
            | (Some (return___1, retval___1, st_0)) =>
              if return___1
              then (Some (true, retval___1, st_0))
              else (Some (false, retval___1, st_0))
            | None => None
            end)
        ) with
        | (Some (__return___0, __retval___0, st_0)) =>
          if __return___0
          then (Some (true, __retval___0, st_0))
          else (Some (true, true, st_0))
        | None => None
        end)
      else (Some (true, false, st))
    ) with
    | (Some (__return__, __retval__, st_0)) =>
      if __return__
      then (Some (__retval__, st_0))
      else (Some (__retval__, st_0))
    | None => None
    end.

End S2TTEDesc_s2tte_check_LowSpec.

#[global] Hint Unfold s2tte_check_spec_low: spec.
