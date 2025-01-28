Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer6.Spec.
Require Import Layer8.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer9_rsi_data_write_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Fixpoint rsi_data_write_loop104_low (_N_: nat) (__return__: bool) (__break__: bool) (v_0: Ptr) (v_1: Z) (v_2: Z) (v_3: Z) (v_4: Z) (v_6: Ptr) (v__027: Z) (st: RData) : (option (bool * bool * Ptr * Z * Z * Z * Z * Ptr * Z * RData)) :=
    match (_N_) with
    | O => (Some (__return__, __break__, v_0, v_1, v_2, v_3, v_4, v_6, v__027, st))
    | (S _N__0) =>
      match ((rsi_data_write_loop104_low _N__0 __return__ __break__ v_0 v_1 v_2 v_3 v_4 v_6 v__027 st)) with
      | (Some (__return___0, __break___0, v_11, v_8, v_10, v_5, v_9, v_7, v__28, st_0)) =>
        if __break___0
        then (Some (__return___0, true, v_11, v_8, v_10, v_5, v_9, v_7, v__28, st_0))
        else (
          if __return___0
          then (Some (true, false, v_11, v_8, v_10, v_5, v_9, v_7, v__28, st_0))
          else (
            when v_13, st_1 == ((virt_to_phys_spec (v__28 + (v_8)) 1 v_7 v_9 st_0));
            if (v_13 =? (0))
            then (
              when v_14, st_2 == ((pack_return_code_spec 8 0 st_1));
              when st_3 == ((store_RData 8 (ptr_offset v_11 0) v_14 st_2));
              when st_4 == ((store_RData 8 (ptr_offset v_11 8) 2516582464 st_3));
              when v_18, st_5 == ((load_RData 8 v_7 st_4));
              when st_6 == ((store_RData 8 (ptr_offset v_11 8) (((v_18 >> (1)) & (63)) |' (2516582464)) st_5));
              when st_7 == ((store_RData 8 (ptr_offset v_11 16) (v__28 + (v_8)) st_6));
              (Some (true, false, v_11, v_8, v_10, v_5, v_9, v_7, v__28, st_7)))
            else (
              when v_26, st_2 == ((next_granule_spec (v__28 + (v_10)) st_1));
              when v_28, st_3 == ((next_granule_spec v_13 st_2));
              when v_30, st_4 == ((min_spec (v_5 - (v__28)) (v_26 - ((v__28 + (v_10)))) (v_28 - (v_13)) st_3));
              when v_31, st_5 == ((ns_buffer_read_byte_spec (v__28 + (v_10)) v_30 v_13 st_4));
              if v_31
              then (
                if (((v_30 + (v__28)) - (v_5)) <? (0))
                then (Some (false, false, v_11, v_8, v_10, v_5, v_9, v_7, (v_30 + (v__28)), st_5))
                else (Some (false, true, v_11, v_8, v_10, v_5, v_9, v_7, v__28, st_5)))
              else (
                when v_34, st_6 == ((pack_return_code_spec 1 139 st_5));
                when st_7 == ((store_RData 8 (ptr_offset v_11 0) v_34 st_6));
                (Some (true, false, v_11, v_8, v_10, v_5, v_9, v_7, v__28, st_7))))))
      | None => None
      end
    end.

  Definition rsi_data_write_loop104_rank (v_0: Ptr) (v_1: Z) (v_2: Z) (v_3: Z) (v_4: Z) (v_6: Ptr) (v__027: Z) : Z :=
    0.

  Definition rsi_data_write_spec_low (v_0: Ptr) (v_1: Z) (v_2: Z) (v_3: Z) (v_4: Z) (st: RData) : (option RData) :=
    when st_0 == ((new_frame "rsi_data_write" st));
    when st_1 == ((rc_update_ttbr0_el12_spec v_4 st_0));
    if ((0 - (v_3)) <? (0))
    then (
      rely (((rsi_data_write_loop104_rank v_0 v_1 v_2 v_3 v_4 (mkPtr "stack_type_3" 0) 0) >= (0)));
      match (
        (rsi_data_write_loop104_low
          (z_to_nat (rsi_data_write_loop104_rank v_0 v_1 v_2 v_3 v_4 (mkPtr "stack_type_3" 0) 0))
          false
          false
          v_0
          v_1
          v_2
          v_3
          v_4
          (mkPtr "stack_type_3" 0)
          0
          st_1)
      ) with
      | (Some (__return___0, __break__, v_12, v_9, v_11, v_5, v_10, v_8, v__28, st_2)) =>
        if __return___0
        then (
          when st_4 == ((free_stack "rsi_data_write" st_0 st_2));
          (Some st_4))
        else (
          when st_4 == ((store_RData 8 (ptr_offset v_0 0) 0 st_2));
          when st_5 == ((free_stack "rsi_data_write" st_0 st_4));
          (Some st_5))
      | None => None
      end)
    else (
      when st_3 == ((store_RData 8 (ptr_offset v_0 0) 0 st_1));
      when st_4 == ((free_stack "rsi_data_write" st_0 st_3));
      (Some st_4)).

End Layer9_rsi_data_write_LowSpec.

#[global] Hint Unfold rsi_data_write_loop104_low: spec.
#[global] Hint Unfold rsi_data_write_loop104_rank: spec.
#[global] Hint Unfold rsi_data_write_spec_low: spec.
