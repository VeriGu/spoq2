Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section S2TTEState_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2tte_is_unassigned_spec (v_s2tte: Z) (st: RData) : (option (bool * RData)) :=
    match (
      if ((v_s2tte & (3)) =? (0))
      then (
        match (
          if ((v_s2tte & (60)) =? (0))
          then (Some (true, true, st))
          else (Some (false, false, st))
        ) with
        | (Some (__return___0, __retval___0, st_1)) =>
          if __return___0
          then (Some (true, __retval___0, st_1))
          else (Some (false, __retval___0, st_1))
        | None => None
        end)
      else (Some (false, false, st))
    ) with
    | (Some (__return__, __retval__, st_1)) =>
      if __return__
      then (Some (__retval__, st_1))
      else (Some (false, st_1))
    | None => None
    end.

  Definition s2tte_is_valid_ns_spec (v_s2tte: Z) (v_level: Z) (st: RData) : (option (bool * RData)) :=
    match (
      if (((v_s2tte & (36028797018963968)) - (36028797018963968)) =? (0))
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
            | (Some (return___1, retval___1, st_1)) =>
              if return___1
              then (Some (true, retval___1, st_1))
              else (Some (false, retval___1, st_1))
            | None => None
            end)
        ) with
        | (Some (__return___0, __retval___0, st_1)) =>
          if __return___0
          then (Some (true, __retval___0, st_1))
          else (Some (true, true, st_1))
        | None => None
        end)
      else (Some (true, false, st))
    ) with
    | (Some (__return__, __retval__, st_1)) =>
      if __return__
      then (Some (__retval__, st_1))
      else (Some (__retval__, st_1))
    | None => None
    end.

  Definition host_ns_s2tte_is_valid_spec (v_s2tte: Z) (v_level: Z) (st: RData) : (option (bool * RData)) :=
    if (
      (((Z.lxor
        ((((- 1) & (281474976710655)) & (((- 1) << (((((((v_level * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |' (988))
        (- 1)) &
        (v_s2tte)) =?
        (0)))
    then (
      if ((v_s2tte & (28)) =? (16))
      then (Some (false, st))
      else (
        if ((v_s2tte & (768)) =? (256))
        then (Some (false, st))
        else (Some (true, st))))
    else (Some (false, st)).

  Definition addr_is_level_aligned_spec (v_addr: Z) (v_level: Z) (st: RData) : (option (bool * RData)) :=
    (Some (
      ((((v_addr & (281474976710655)) & (((- 1) << (((((((v_level * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) - (v_addr)) =? (0))  ,
      st
    )).

End S2TTEState_Spec.

#[global] Hint Unfold s2tte_is_unassigned_spec: spec.
#[global] Hint Unfold s2tte_is_valid_ns_spec: spec.
#[global] Hint Unfold host_ns_s2tte_is_valid_spec: spec.
#[global] Hint Unfold addr_is_level_aligned_spec: spec.
