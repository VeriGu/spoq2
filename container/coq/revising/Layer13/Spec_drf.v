Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer1.Spec.
Require Import Layer10.Spec.
Require Import Layer11.Spec.
Require Import Layer12.Spec.
Require Import Layer12.complete_hvc_exit.LowSpec.
Require Import Layer12.complete_mmio_emulation.LowSpec.
Require Import Layer12.copy_gic_state_from_ns.LowSpec.
Require Import Layer12.copy_gic_state_to_ns.LowSpec.
Require Import Layer12.data_create.LowSpec.
Require Import Layer13.smc_data_destroy.LowSpec.
Require Import Layer13.smc_data_dispose.LowSpec.
Require Import Layer13.smc_rec_enter.LowSpec.
Require Import Layer13.smc_rtt_create.LowSpec.
Require Import Layer13.smc_rtt_destroy.LowSpec.
Require Import Layer13.smc_rtt_map_protected.LowSpec.
Require Import Layer13.smc_rtt_read_entry.LowSpec.
Require Import Layer2.Spec.
Require Import Layer3.Spec.
Require Import Layer4.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer7.Spec.
Require Import Layer7.data_create_internal.LowSpec.
Require Import Layer8.Spec.
Require Import Layer8.map_unmap_ns_s1.LowSpec.
Require Import Layer9.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer13_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition s1tte_is_writable_spec (v_0: Z) (st: RData) : (option (bool * RData)) :=
    (Some (((v_0 & (128)) =? (0)), st)).

  Definition stage1_tlbi_va_spec (v_0: Z) (v_1: Z) (st: RData) : (option RData) :=
    when st_0 == ((iasm_261_spec (((v_0 >> (12)) & (17592186044415)) + ((v_1 << (48)))) st));
    when st_1 == ((iasm_10_spec st_0));
    when st_2 == ((iasm_12_isb_spec st_1));
    (Some st_2).

  (* Definition smc_realm_activate_spec (v_0: Z) (st: RData) : (option (Z * RData)) :=
    when v_2, st_0 == ((find_lock_granule_spec v_0 2 st));
    rely (((((v_2.(poffset)) mod (16)) = (0)) /\ (((v_2.(poffset)) >= (0)))));
    rely ((((v_2.(pbase)) = ("granules")) \/ (((v_2.(pbase)) = ("null")))));
    if (ptr_eqb v_2 (mkPtr "null" 0))
    then (
      when v_4, st_1 == ((pack_return_code_spec 1 1 st_0));
      (Some (v_4, st_1)))
    else (
      when v_7, st_1 == ((granule_map_spec v_2 2 st_0));
      when v_9, st_2 == ((get_rd_state_locked_spec v_7 st_1));
      if (v_9 =? (0))
      then (
        when st_3 == ((measurement_finish_spec (ptr_offset v_7 72) (ptr_offset v_7 184) st_2));
        when st_4 == ((set_rd_state_spec v_7 1 st_3));
        when st_6 == ((granule_unlock_spec v_2 st_4));
        (Some (0, st_6)))
      else (
        when v_17, st_3 == ((pack_return_code_spec 5 0 st_2));
        when st_5 == ((granule_unlock_spec v_2 st_3));
        (Some (v_17, st_5)))). *)

  Definition stage1_tlbi_val_spec (v_0: Z) (v_1: Z) (st: RData) : (option RData) :=
    when st_0 == ((iasm_264_spec (((v_0 >> (12)) & (17592186044415)) + ((v_1 << (48)))) st));
    when st_1 == ((iasm_10_spec st_0));
    when st_2 == ((iasm_12_isb_spec st_1));
    (Some st_2).

  Definition smc_rec_enter_spec (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Ptr) (st: RData) : (option RData) :=
    when st_0 == ((new_frame "smc_rec_enter" st));
    if ((v_0 & (1)) =? (0))
    then (
      when v_13, st_1 == ((validate_ns_struct_spec v_1 232 st_0));
      if (ptr_eqb v_13 (mkPtr "null" 0))
      then (
        when v_15, st_2 == ((pack_return_code_spec 1 2 st_1));
        when st_3 == ((store_RData 8 (ptr_offset v_3 0) v_15 st_2));
        when v_19, st_5 == ((validate_ns_struct_spec v_2 304 st_3));
        if (ptr_eqb v_19 (mkPtr "null" 0))
        then (
          when v_21, st_6 == ((pack_return_code_spec 1 3 st_5));
          when st_7 == ((store_RData 8 (ptr_offset v_3 0) v_21 st_6));
          when v_25, st_9 == ((ranges_intersect_spec v_1 232 v_2 304 st_7));
          if v_25
          then (
            when v_27, st_10 == ((pack_return_code_spec 3 0 st_9));
            when st_11 == ((store_RData 8 (ptr_offset v_3 0) v_27 st_10));
            when v_31, st_13 == ((find_lock_unused_granule_spec v_0 3 st_11));
            when st_14 == ((atomic_granule_get_spec v_31 st_13));
            when st_15 == ((granule_unlock_spec v_31 st_14));
            when v_34, st_16 == ((ns_buffer_read_spec 0 v_1 232 (mkPtr "stack_s_rec_entry" 0) st_15));
            when st_17 == ((ns_buffer_unmap_spec 0 st_16));
            if v_34
            then (
              when v_40, st_19 == ((granule_map_spec v_31 3 st_17));
              when v_44_tmp, st_20 == ((load_RData 8 (ptr_offset v_40 944) st_19));
              when v_45, st_21 == ((granule_map_spec (int_to_ptr v_44_tmp) 2 st_20));
              when v_47, st_22 == ((get_rd_state_unlocked_spec v_45 st_21));
              if (v_47 =? (2))
              then (
                when v_51, st_23 == ((pack_return_code_spec 5 1 st_22));
                if (v_51 =? (0))
                then (
                  when v_95, st_25 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_23));
                  when st_26 == ((ns_buffer_unmap_spec 0 st_25));
                  when st_28 == ((atomic_granule_put_release_spec v_31 st_26));
                  when st_30 == ((free_stack "smc_rec_enter" st_0 st_28));
                  (Some st_30))
                else (
                  when st_26 == ((atomic_granule_put_release_spec v_31 st_23));
                  when st_28 == ((free_stack "smc_rec_enter" st_0 st_26));
                  (Some st_28)))
              else (
                if (v_47 =? (0))
                then (
                  when v_49, st_23 == ((pack_return_code_spec 5 0 st_22));
                  if (v_49 =? (0))
                  then (
                    when v_95, st_26 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_23));
                    when st_27 == ((ns_buffer_unmap_spec 0 st_26));
                    when st_29 == ((atomic_granule_put_release_spec v_31 st_27));
                    when st_31 == ((free_stack "smc_rec_enter" st_0 st_29));
                    (Some st_31))
                  else (
                    when st_27 == ((atomic_granule_put_release_spec v_31 st_23));
                    when st_29 == ((free_stack "smc_rec_enter" st_0 st_27));
                    (Some st_29)))
                else (
                  when v_54, st_23 == ((load_RData 1 (ptr_offset v_40 16) st_22));
                  if ((v_54 & (1)) =? (0))
                  then (
                    when v_57, st_24 == ((pack_return_code_spec 7 0 st_23));
                    if (v_57 =? (0))
                    then (
                      when v_95, st_28 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_24));
                      when st_29 == ((ns_buffer_unmap_spec 0 st_28));
                      when st_31 == ((atomic_granule_put_release_spec v_31 st_29));
                      when st_33 == ((free_stack "smc_rec_enter" st_0 st_31));
                      (Some st_33))
                    else (
                      when st_29 == ((atomic_granule_put_release_spec v_31 st_24));
                      when st_31 == ((free_stack "smc_rec_enter" st_0 st_29));
                      (Some st_31)))
                  else (
                    when v_60, st_24 == ((load_RData 1 (ptr_offset v_40 1512) st_23));
                    if ((v_60 & (1)) =? (0))
                    then (
                      when st_25 == ((copy_gic_state_from_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_entry" 0) st_24));
                      when v_67, st_26 == ((validate_gic_state_spec (ptr_offset v_40 584) st_25));
                      if v_67
                      then (
                        when v_71, st_27 == ((complete_mmio_emulation_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_26));
                        if v_71
                        then (
                          when st_28 == ((complete_sysreg_emulation_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_27));
                          when st_29 == ((complete_hvc_exit_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_28));
                          when st_30 == ((reset_last_run_info_spec v_40 st_29));
                          when st_31 == ((process_disposed_info_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_30));
                          when v_77, st_32 == ((load_RData 8 (ptr_offset v_40 856) st_31));
                          when st_33 == ((store_RData 8 (ptr_offset v_40 808) v_77 st_32));
                          when v_81, st_34 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 216) st_33));
                          if (v_81 =? (0))
                          then (
                            when v_86, st_36 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 224) st_34));
                            if (v_86 =? (0))
                            then (smc_rec_enter_0_low st_0 st_36 v_2 v_31 v_40 v_86)
                            else (
                              when v_88, st_37 == ((load_RData 8 (ptr_offset v_40 808) st_36));
                              when st_38 == ((store_RData 8 (ptr_offset v_40 808) (v_88 |' (16384)) st_37));
                              when st_40 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_38));
                              when st_41 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_40));
                              when v_95, st_48 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_41));
                              when st_49 == ((ns_buffer_unmap_spec 0 st_48));
                              when st_51 == ((atomic_granule_put_release_spec v_31 st_49));
                              when st_53 == ((free_stack "smc_rec_enter" st_0 st_51));
                              (Some st_53)))
                          else (
                            when st_35 == ((store_RData 8 (ptr_offset v_40 808) (v_77 |' (8192)) st_34));
                            when v_86, st_37 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 224) st_35));
                            if (v_86 =? (0))
                            then (smc_rec_enter_1_low st_0 st_37 v_2 v_31 v_40 v_86)
                            else (
                              when v_88, st_38 == ((load_RData 8 (ptr_offset v_40 808) st_37));
                              when st_39 == ((store_RData 8 (ptr_offset v_40 808) (v_88 |' (16384)) st_38));
                              when st_41 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_39));
                              when st_42 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_41));
                              when v_95, st_49 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_42));
                              when st_50 == ((ns_buffer_unmap_spec 0 st_49));
                              when st_52 == ((atomic_granule_put_release_spec v_31 st_50));
                              when st_54 == ((free_stack "smc_rec_enter" st_0 st_52));
                              (Some st_54))))
                        else (
                          when v_73, st_28 == ((pack_return_code_spec 7 0 st_27));
                          if (v_73 =? (0))
                          then (
                            when v_95, st_35 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_28));
                            when st_36 == ((ns_buffer_unmap_spec 0 st_35));
                            when st_38 == ((atomic_granule_put_release_spec v_31 st_36));
                            when st_40 == ((free_stack "smc_rec_enter" st_0 st_38));
                            (Some st_40))
                          else (
                            when st_36 == ((atomic_granule_put_release_spec v_31 st_28));
                            when st_38 == ((free_stack "smc_rec_enter" st_0 st_36));
                            (Some st_38))))
                      else (
                        when v_69, st_27 == ((pack_return_code_spec 7 0 st_26));
                        if (v_69 =? (0))
                        then (
                          when v_95, st_33 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_27));
                          when st_34 == ((ns_buffer_unmap_spec 0 st_33));
                          when st_36 == ((atomic_granule_put_release_spec v_31 st_34));
                          when st_38 == ((free_stack "smc_rec_enter" st_0 st_36));
                          (Some st_38))
                        else (
                          when st_34 == ((atomic_granule_put_release_spec v_31 st_27));
                          when st_36 == ((free_stack "smc_rec_enter" st_0 st_34));
                          (Some st_36))))
                    else (
                      when v_63, st_25 == ((pack_return_code_spec 7 0 st_24));
                      if (v_63 =? (0))
                      then (
                        when v_95, st_30 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_25));
                        when st_31 == ((ns_buffer_unmap_spec 0 st_30));
                        when st_33 == ((atomic_granule_put_release_spec v_31 st_31));
                        when st_35 == ((free_stack "smc_rec_enter" st_0 st_33));
                        (Some st_35))
                      else (
                        when st_31 == ((atomic_granule_put_release_spec v_31 st_25));
                        when st_33 == ((free_stack "smc_rec_enter" st_0 st_31));
                        (Some st_33)))))))
            else (
              when st_18 == ((atomic_granule_put_release_spec v_31 st_17));
              when v_36, st_19 == ((pack_return_code_spec 1 2 st_18));
              when st_20 == ((store_RData 8 (ptr_offset v_3 0) v_36 st_19));
              when v_40, st_22 == ((granule_map_spec v_31 3 st_20));
              when v_44_tmp, st_23 == ((load_RData 8 (ptr_offset v_40 944) st_22));
              when v_45, st_24 == ((granule_map_spec (int_to_ptr v_44_tmp) 2 st_23));
              when v_47, st_25 == ((get_rd_state_unlocked_spec v_45 st_24));
              if (v_47 =? (2))
              then (
                when v_51, st_26 == ((pack_return_code_spec 5 1 st_25));
                if (v_51 =? (0))
                then (
                  when v_95, st_28 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_26));
                  when st_29 == ((ns_buffer_unmap_spec 0 st_28));
                  when st_31 == ((atomic_granule_put_release_spec v_31 st_29));
                  when st_33 == ((free_stack "smc_rec_enter" st_0 st_31));
                  (Some st_33))
                else (
                  when st_29 == ((atomic_granule_put_release_spec v_31 st_26));
                  when st_31 == ((free_stack "smc_rec_enter" st_0 st_29));
                  (Some st_31)))
              else (
                if (v_47 =? (0))
                then (
                  when v_49, st_26 == ((pack_return_code_spec 5 0 st_25));
                  if (v_49 =? (0))
                  then (
                    when v_95, st_29 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_26));
                    when st_30 == ((ns_buffer_unmap_spec 0 st_29));
                    when st_32 == ((atomic_granule_put_release_spec v_31 st_30));
                    when st_34 == ((free_stack "smc_rec_enter" st_0 st_32));
                    (Some st_34))
                  else (
                    when st_30 == ((atomic_granule_put_release_spec v_31 st_26));
                    when st_32 == ((free_stack "smc_rec_enter" st_0 st_30));
                    (Some st_32)))
                else (
                  when v_54, st_26 == ((load_RData 1 (ptr_offset v_40 16) st_25));
                  if ((v_54 & (1)) =? (0))
                  then (
                    when v_57, st_27 == ((pack_return_code_spec 7 0 st_26));
                    if (v_57 =? (0))
                    then (
                      when v_95, st_31 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_27));
                      when st_32 == ((ns_buffer_unmap_spec 0 st_31));
                      when st_34 == ((atomic_granule_put_release_spec v_31 st_32));
                      when st_36 == ((free_stack "smc_rec_enter" st_0 st_34));
                      (Some st_36))
                    else (
                      when st_32 == ((atomic_granule_put_release_spec v_31 st_27));
                      when st_34 == ((free_stack "smc_rec_enter" st_0 st_32));
                      (Some st_34)))
                  else (
                    when v_60, st_27 == ((load_RData 1 (ptr_offset v_40 1512) st_26));
                    if ((v_60 & (1)) =? (0))
                    then (
                      when st_28 == ((copy_gic_state_from_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_entry" 0) st_27));
                      when v_67, st_29 == ((validate_gic_state_spec (ptr_offset v_40 584) st_28));
                      if v_67
                      then (
                        when v_71, st_30 == ((complete_mmio_emulation_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_29));
                        if v_71
                        then (
                          when st_31 == ((complete_sysreg_emulation_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_30));
                          when st_32 == ((complete_hvc_exit_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_31));
                          when st_33 == ((reset_last_run_info_spec v_40 st_32));
                          when st_34 == ((process_disposed_info_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_33));
                          when v_77, st_35 == ((load_RData 8 (ptr_offset v_40 856) st_34));
                          when st_36 == ((store_RData 8 (ptr_offset v_40 808) v_77 st_35));
                          when v_81, st_37 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 216) st_36));
                          if (v_81 =? (0))
                          then (
                            when v_86, st_39 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 224) st_37));
                            if (v_86 =? (0))
                            then (smc_rec_enter_2_low st_0 st_39 v_2 v_31 v_40 v_86)
                            else (
                              when v_88, st_40 == ((load_RData 8 (ptr_offset v_40 808) st_39));
                              when st_41 == ((store_RData 8 (ptr_offset v_40 808) (v_88 |' (16384)) st_40));
                              when st_43 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_41));
                              when st_44 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_43));
                              when v_95, st_51 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_44));
                              when st_52 == ((ns_buffer_unmap_spec 0 st_51));
                              when st_54 == ((atomic_granule_put_release_spec v_31 st_52));
                              when st_56 == ((free_stack "smc_rec_enter" st_0 st_54));
                              (Some st_56)))
                          else (
                            when st_38 == ((store_RData 8 (ptr_offset v_40 808) (v_77 |' (8192)) st_37));
                            when v_86, st_40 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 224) st_38));
                            if (v_86 =? (0))
                            then (smc_rec_enter_3_low st_0 st_40 v_2 v_31 v_40 v_86)
                            else (
                              when v_88, st_41 == ((load_RData 8 (ptr_offset v_40 808) st_40));
                              when st_42 == ((store_RData 8 (ptr_offset v_40 808) (v_88 |' (16384)) st_41));
                              when st_44 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_42));
                              when st_45 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_44));
                              when v_95, st_52 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_45));
                              when st_53 == ((ns_buffer_unmap_spec 0 st_52));
                              when st_55 == ((atomic_granule_put_release_spec v_31 st_53));
                              when st_57 == ((free_stack "smc_rec_enter" st_0 st_55));
                              (Some st_57))))
                        else (
                          when v_73, st_31 == ((pack_return_code_spec 7 0 st_30));
                          if (v_73 =? (0))
                          then (
                            when v_95, st_38 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_31));
                            when st_39 == ((ns_buffer_unmap_spec 0 st_38));
                            when st_41 == ((atomic_granule_put_release_spec v_31 st_39));
                            when st_43 == ((free_stack "smc_rec_enter" st_0 st_41));
                            (Some st_43))
                          else (
                            when st_39 == ((atomic_granule_put_release_spec v_31 st_31));
                            when st_41 == ((free_stack "smc_rec_enter" st_0 st_39));
                            (Some st_41))))
                      else (
                        when v_69, st_30 == ((pack_return_code_spec 7 0 st_29));
                        if (v_69 =? (0))
                        then (
                          when v_95, st_36 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_30));
                          when st_37 == ((ns_buffer_unmap_spec 0 st_36));
                          when st_39 == ((atomic_granule_put_release_spec v_31 st_37));
                          when st_41 == ((free_stack "smc_rec_enter" st_0 st_39));
                          (Some st_41))
                        else (
                          when st_37 == ((atomic_granule_put_release_spec v_31 st_30));
                          when st_39 == ((free_stack "smc_rec_enter" st_0 st_37));
                          (Some st_39))))
                    else (
                      when v_63, st_28 == ((pack_return_code_spec 7 0 st_27));
                      if (v_63 =? (0))
                      then (
                        when v_95, st_33 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_28));
                        when st_34 == ((ns_buffer_unmap_spec 0 st_33));
                        when st_36 == ((atomic_granule_put_release_spec v_31 st_34));
                        when st_38 == ((free_stack "smc_rec_enter" st_0 st_36));
                        (Some st_38))
                      else (
                        when st_34 == ((atomic_granule_put_release_spec v_31 st_28));
                        when st_36 == ((free_stack "smc_rec_enter" st_0 st_34));
                        (Some st_36))))))))
          else (
            when v_31, st_11 == ((find_lock_unused_granule_spec v_0 3 st_9));
            when st_12 == ((atomic_granule_get_spec v_31 st_11));
            when st_13 == ((granule_unlock_spec v_31 st_12));
            when v_34, st_14 == ((ns_buffer_read_spec 0 v_1 232 (mkPtr "stack_s_rec_entry" 0) st_13));
            when st_15 == ((ns_buffer_unmap_spec 0 st_14));
            if v_34
            then (
              when v_40, st_17 == ((granule_map_spec v_31 3 st_15));
              when v_44_tmp, st_18 == ((load_RData 8 (ptr_offset v_40 944) st_17));
              when v_45, st_19 == ((granule_map_spec (int_to_ptr v_44_tmp) 2 st_18));
              when v_47, st_20 == ((get_rd_state_unlocked_spec v_45 st_19));
              if (v_47 =? (2))
              then (
                when v_51, st_21 == ((pack_return_code_spec 5 1 st_20));
                if (v_51 =? (0))
                then (
                  when v_95, st_23 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_21));
                  when st_24 == ((ns_buffer_unmap_spec 0 st_23));
                  when st_26 == ((atomic_granule_put_release_spec v_31 st_24));
                  when st_28 == ((free_stack "smc_rec_enter" st_0 st_26));
                  (Some st_28))
                else (
                  when st_24 == ((atomic_granule_put_release_spec v_31 st_21));
                  when st_26 == ((free_stack "smc_rec_enter" st_0 st_24));
                  (Some st_26)))
              else (
                if (v_47 =? (0))
                then (
                  when v_49, st_21 == ((pack_return_code_spec 5 0 st_20));
                  if (v_49 =? (0))
                  then (
                    when v_95, st_24 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_21));
                    when st_25 == ((ns_buffer_unmap_spec 0 st_24));
                    when st_27 == ((atomic_granule_put_release_spec v_31 st_25));
                    when st_29 == ((free_stack "smc_rec_enter" st_0 st_27));
                    (Some st_29))
                  else (
                    when st_25 == ((atomic_granule_put_release_spec v_31 st_21));
                    when st_27 == ((free_stack "smc_rec_enter" st_0 st_25));
                    (Some st_27)))
                else (
                  when v_54, st_21 == ((load_RData 1 (ptr_offset v_40 16) st_20));
                  if ((v_54 & (1)) =? (0))
                  then (
                    when v_57, st_22 == ((pack_return_code_spec 7 0 st_21));
                    if (v_57 =? (0))
                    then (
                      when v_95, st_26 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_22));
                      when st_27 == ((ns_buffer_unmap_spec 0 st_26));
                      when st_29 == ((atomic_granule_put_release_spec v_31 st_27));
                      when st_31 == ((free_stack "smc_rec_enter" st_0 st_29));
                      (Some st_31))
                    else (
                      when st_27 == ((atomic_granule_put_release_spec v_31 st_22));
                      when st_29 == ((free_stack "smc_rec_enter" st_0 st_27));
                      (Some st_29)))
                  else (
                    when v_60, st_22 == ((load_RData 1 (ptr_offset v_40 1512) st_21));
                    if ((v_60 & (1)) =? (0))
                    then (
                      when st_23 == ((copy_gic_state_from_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_entry" 0) st_22));
                      when v_67, st_24 == ((validate_gic_state_spec (ptr_offset v_40 584) st_23));
                      if v_67
                      then (
                        when v_71, st_25 == ((complete_mmio_emulation_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_24));
                        if v_71
                        then (
                          when st_26 == ((complete_sysreg_emulation_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_25));
                          when st_27 == ((complete_hvc_exit_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_26));
                          when st_28 == ((reset_last_run_info_spec v_40 st_27));
                          when st_29 == ((process_disposed_info_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_28));
                          when v_77, st_30 == ((load_RData 8 (ptr_offset v_40 856) st_29));
                          when st_31 == ((store_RData 8 (ptr_offset v_40 808) v_77 st_30));
                          when v_81, st_32 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 216) st_31));
                          if (v_81 =? (0))
                          then (
                            when v_86, st_34 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 224) st_32));
                            if (v_86 =? (0))
                            then (smc_rec_enter_4_low st_0 st_34 v_2 v_31 v_40 v_86)
                            else (
                              when v_88, st_35 == ((load_RData 8 (ptr_offset v_40 808) st_34));
                              when st_36 == ((store_RData 8 (ptr_offset v_40 808) (v_88 |' (16384)) st_35));
                              when st_38 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_36));
                              when st_39 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_38));
                              when v_95, st_46 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_39));
                              when st_47 == ((ns_buffer_unmap_spec 0 st_46));
                              when st_49 == ((atomic_granule_put_release_spec v_31 st_47));
                              when st_51 == ((free_stack "smc_rec_enter" st_0 st_49));
                              (Some st_51)))
                          else (
                            when st_33 == ((store_RData 8 (ptr_offset v_40 808) (v_77 |' (8192)) st_32));
                            when v_86, st_35 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 224) st_33));
                            if (v_86 =? (0))
                            then (smc_rec_enter_5_low st_0 st_35 v_2 v_31 v_40 v_86)
                            else (
                              when v_88, st_36 == ((load_RData 8 (ptr_offset v_40 808) st_35));
                              when st_37 == ((store_RData 8 (ptr_offset v_40 808) (v_88 |' (16384)) st_36));
                              when st_39 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_37));
                              when st_40 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_39));
                              when v_95, st_47 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_40));
                              when st_48 == ((ns_buffer_unmap_spec 0 st_47));
                              when st_50 == ((atomic_granule_put_release_spec v_31 st_48));
                              when st_52 == ((free_stack "smc_rec_enter" st_0 st_50));
                              (Some st_52))))
                        else (
                          when v_73, st_26 == ((pack_return_code_spec 7 0 st_25));
                          if (v_73 =? (0))
                          then (
                            when v_95, st_33 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_26));
                            when st_34 == ((ns_buffer_unmap_spec 0 st_33));
                            when st_36 == ((atomic_granule_put_release_spec v_31 st_34));
                            when st_38 == ((free_stack "smc_rec_enter" st_0 st_36));
                            (Some st_38))
                          else (
                            when st_34 == ((atomic_granule_put_release_spec v_31 st_26));
                            when st_36 == ((free_stack "smc_rec_enter" st_0 st_34));
                            (Some st_36))))
                      else (
                        when v_69, st_25 == ((pack_return_code_spec 7 0 st_24));
                        if (v_69 =? (0))
                        then (
                          when v_95, st_31 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_25));
                          when st_32 == ((ns_buffer_unmap_spec 0 st_31));
                          when st_34 == ((atomic_granule_put_release_spec v_31 st_32));
                          when st_36 == ((free_stack "smc_rec_enter" st_0 st_34));
                          (Some st_36))
                        else (
                          when st_32 == ((atomic_granule_put_release_spec v_31 st_25));
                          when st_34 == ((free_stack "smc_rec_enter" st_0 st_32));
                          (Some st_34))))
                    else (
                      when v_63, st_23 == ((pack_return_code_spec 7 0 st_22));
                      if (v_63 =? (0))
                      then (
                        when v_95, st_28 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_23));
                        when st_29 == ((ns_buffer_unmap_spec 0 st_28));
                        when st_31 == ((atomic_granule_put_release_spec v_31 st_29));
                        when st_33 == ((free_stack "smc_rec_enter" st_0 st_31));
                        (Some st_33))
                      else (
                        when st_29 == ((atomic_granule_put_release_spec v_31 st_23));
                        when st_31 == ((free_stack "smc_rec_enter" st_0 st_29));
                        (Some st_31)))))))
            else (
              when st_16 == ((atomic_granule_put_release_spec v_31 st_15));
              when v_36, st_17 == ((pack_return_code_spec 1 2 st_16));
              when st_18 == ((store_RData 8 (ptr_offset v_3 0) v_36 st_17));
              when v_40, st_20 == ((granule_map_spec v_31 3 st_18));
              when v_44_tmp, st_21 == ((load_RData 8 (ptr_offset v_40 944) st_20));
              when v_45, st_22 == ((granule_map_spec (int_to_ptr v_44_tmp) 2 st_21));
              when v_47, st_23 == ((get_rd_state_unlocked_spec v_45 st_22));
              if (v_47 =? (2))
              then (
                when v_51, st_24 == ((pack_return_code_spec 5 1 st_23));
                if (v_51 =? (0))
                then (
                  when v_95, st_26 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_24));
                  when st_27 == ((ns_buffer_unmap_spec 0 st_26));
                  when st_29 == ((atomic_granule_put_release_spec v_31 st_27));
                  when st_31 == ((free_stack "smc_rec_enter" st_0 st_29));
                  (Some st_31))
                else (
                  when st_27 == ((atomic_granule_put_release_spec v_31 st_24));
                  when st_29 == ((free_stack "smc_rec_enter" st_0 st_27));
                  (Some st_29)))
              else (
                if (v_47 =? (0))
                then (
                  when v_49, st_24 == ((pack_return_code_spec 5 0 st_23));
                  if (v_49 =? (0))
                  then (
                    when v_95, st_27 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_24));
                    when st_28 == ((ns_buffer_unmap_spec 0 st_27));
                    when st_30 == ((atomic_granule_put_release_spec v_31 st_28));
                    when st_32 == ((free_stack "smc_rec_enter" st_0 st_30));
                    (Some st_32))
                  else (
                    when st_28 == ((atomic_granule_put_release_spec v_31 st_24));
                    when st_30 == ((free_stack "smc_rec_enter" st_0 st_28));
                    (Some st_30)))
                else (
                  when v_54, st_24 == ((load_RData 1 (ptr_offset v_40 16) st_23));
                  if ((v_54 & (1)) =? (0))
                  then (
                    when v_57, st_25 == ((pack_return_code_spec 7 0 st_24));
                    if (v_57 =? (0))
                    then (
                      when v_95, st_29 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_25));
                      when st_30 == ((ns_buffer_unmap_spec 0 st_29));
                      when st_32 == ((atomic_granule_put_release_spec v_31 st_30));
                      when st_34 == ((free_stack "smc_rec_enter" st_0 st_32));
                      (Some st_34))
                    else (
                      when st_30 == ((atomic_granule_put_release_spec v_31 st_25));
                      when st_32 == ((free_stack "smc_rec_enter" st_0 st_30));
                      (Some st_32)))
                  else (
                    when v_60, st_25 == ((load_RData 1 (ptr_offset v_40 1512) st_24));
                    if ((v_60 & (1)) =? (0))
                    then (
                      when st_26 == ((copy_gic_state_from_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_entry" 0) st_25));
                      when v_67, st_27 == ((validate_gic_state_spec (ptr_offset v_40 584) st_26));
                      if v_67
                      then (
                        when v_71, st_28 == ((complete_mmio_emulation_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_27));
                        if v_71
                        then (
                          when st_29 == ((complete_sysreg_emulation_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_28));
                          when st_30 == ((complete_hvc_exit_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_29));
                          when st_31 == ((reset_last_run_info_spec v_40 st_30));
                          when st_32 == ((process_disposed_info_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_31));
                          when v_77, st_33 == ((load_RData 8 (ptr_offset v_40 856) st_32));
                          when st_34 == ((store_RData 8 (ptr_offset v_40 808) v_77 st_33));
                          when v_81, st_35 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 216) st_34));
                          if (v_81 =? (0))
                          then (
                            when v_86, st_37 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 224) st_35));
                            if (v_86 =? (0))
                            then (smc_rec_enter_6_low st_0 st_37 v_2 v_31 v_40 v_86)
                            else (
                              when v_88, st_38 == ((load_RData 8 (ptr_offset v_40 808) st_37));
                              when st_39 == ((store_RData 8 (ptr_offset v_40 808) (v_88 |' (16384)) st_38));
                              when st_41 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_39));
                              when st_42 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_41));
                              when v_95, st_49 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_42));
                              when st_50 == ((ns_buffer_unmap_spec 0 st_49));
                              when st_52 == ((atomic_granule_put_release_spec v_31 st_50));
                              when st_54 == ((free_stack "smc_rec_enter" st_0 st_52));
                              (Some st_54)))
                          else (
                            when st_36 == ((store_RData 8 (ptr_offset v_40 808) (v_77 |' (8192)) st_35));
                            when v_86, st_38 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 224) st_36));
                            if (v_86 =? (0))
                            then (smc_rec_enter_7_low st_0 st_38 v_2 v_31 v_40 v_86)
                            else (
                              when v_88, st_39 == ((load_RData 8 (ptr_offset v_40 808) st_38));
                              when st_40 == ((store_RData 8 (ptr_offset v_40 808) (v_88 |' (16384)) st_39));
                              when st_42 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_40));
                              when st_43 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_42));
                              when v_95, st_50 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_43));
                              when st_51 == ((ns_buffer_unmap_spec 0 st_50));
                              when st_53 == ((atomic_granule_put_release_spec v_31 st_51));
                              when st_55 == ((free_stack "smc_rec_enter" st_0 st_53));
                              (Some st_55))))
                        else (
                          when v_73, st_29 == ((pack_return_code_spec 7 0 st_28));
                          if (v_73 =? (0))
                          then (
                            when v_95, st_36 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_29));
                            when st_37 == ((ns_buffer_unmap_spec 0 st_36));
                            when st_39 == ((atomic_granule_put_release_spec v_31 st_37));
                            when st_41 == ((free_stack "smc_rec_enter" st_0 st_39));
                            (Some st_41))
                          else (
                            when st_37 == ((atomic_granule_put_release_spec v_31 st_29));
                            when st_39 == ((free_stack "smc_rec_enter" st_0 st_37));
                            (Some st_39))))
                      else (
                        when v_69, st_28 == ((pack_return_code_spec 7 0 st_27));
                        if (v_69 =? (0))
                        then (
                          when v_95, st_34 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_28));
                          when st_35 == ((ns_buffer_unmap_spec 0 st_34));
                          when st_37 == ((atomic_granule_put_release_spec v_31 st_35));
                          when st_39 == ((free_stack "smc_rec_enter" st_0 st_37));
                          (Some st_39))
                        else (
                          when st_35 == ((atomic_granule_put_release_spec v_31 st_28));
                          when st_37 == ((free_stack "smc_rec_enter" st_0 st_35));
                          (Some st_37))))
                    else (
                      when v_63, st_26 == ((pack_return_code_spec 7 0 st_25));
                      if (v_63 =? (0))
                      then (
                        when v_95, st_31 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_26));
                        when st_32 == ((ns_buffer_unmap_spec 0 st_31));
                        when st_34 == ((atomic_granule_put_release_spec v_31 st_32));
                        when st_36 == ((free_stack "smc_rec_enter" st_0 st_34));
                        (Some st_36))
                      else (
                        when st_32 == ((atomic_granule_put_release_spec v_31 st_26));
                        when st_34 == ((free_stack "smc_rec_enter" st_0 st_32));
                        (Some st_34)))))))))
        else (
          when v_25, st_7 == ((ranges_intersect_spec v_1 232 v_2 304 st_5));
          if v_25
          then (
            when v_27, st_8 == ((pack_return_code_spec 3 0 st_7));
            when st_9 == ((store_RData 8 (ptr_offset v_3 0) v_27 st_8));
            when v_31, st_11 == ((find_lock_unused_granule_spec v_0 3 st_9));
            when st_12 == ((atomic_granule_get_spec v_31 st_11));
            when st_13 == ((granule_unlock_spec v_31 st_12));
            when v_34, st_14 == ((ns_buffer_read_spec 0 v_1 232 (mkPtr "stack_s_rec_entry" 0) st_13));
            when st_15 == ((ns_buffer_unmap_spec 0 st_14));
            if v_34
            then (
              when v_40, st_17 == ((granule_map_spec v_31 3 st_15));
              when v_44_tmp, st_18 == ((load_RData 8 (ptr_offset v_40 944) st_17));
              when v_45, st_19 == ((granule_map_spec (int_to_ptr v_44_tmp) 2 st_18));
              when v_47, st_20 == ((get_rd_state_unlocked_spec v_45 st_19));
              if (v_47 =? (2))
              then (
                when v_51, st_21 == ((pack_return_code_spec 5 1 st_20));
                if (v_51 =? (0))
                then (
                  when v_95, st_23 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_21));
                  when st_24 == ((ns_buffer_unmap_spec 0 st_23));
                  when st_26 == ((atomic_granule_put_release_spec v_31 st_24));
                  when st_28 == ((free_stack "smc_rec_enter" st_0 st_26));
                  (Some st_28))
                else (
                  when st_24 == ((atomic_granule_put_release_spec v_31 st_21));
                  when st_26 == ((free_stack "smc_rec_enter" st_0 st_24));
                  (Some st_26)))
              else (
                if (v_47 =? (0))
                then (
                  when v_49, st_21 == ((pack_return_code_spec 5 0 st_20));
                  if (v_49 =? (0))
                  then (
                    when v_95, st_24 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_21));
                    when st_25 == ((ns_buffer_unmap_spec 0 st_24));
                    when st_27 == ((atomic_granule_put_release_spec v_31 st_25));
                    when st_29 == ((free_stack "smc_rec_enter" st_0 st_27));
                    (Some st_29))
                  else (
                    when st_25 == ((atomic_granule_put_release_spec v_31 st_21));
                    when st_27 == ((free_stack "smc_rec_enter" st_0 st_25));
                    (Some st_27)))
                else (
                  when v_54, st_21 == ((load_RData 1 (ptr_offset v_40 16) st_20));
                  if ((v_54 & (1)) =? (0))
                  then (
                    when v_57, st_22 == ((pack_return_code_spec 7 0 st_21));
                    if (v_57 =? (0))
                    then (
                      when v_95, st_26 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_22));
                      when st_27 == ((ns_buffer_unmap_spec 0 st_26));
                      when st_29 == ((atomic_granule_put_release_spec v_31 st_27));
                      when st_31 == ((free_stack "smc_rec_enter" st_0 st_29));
                      (Some st_31))
                    else (
                      when st_27 == ((atomic_granule_put_release_spec v_31 st_22));
                      when st_29 == ((free_stack "smc_rec_enter" st_0 st_27));
                      (Some st_29)))
                  else (
                    when v_60, st_22 == ((load_RData 1 (ptr_offset v_40 1512) st_21));
                    if ((v_60 & (1)) =? (0))
                    then (
                      when st_23 == ((copy_gic_state_from_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_entry" 0) st_22));
                      when v_67, st_24 == ((validate_gic_state_spec (ptr_offset v_40 584) st_23));
                      if v_67
                      then (
                        when v_71, st_25 == ((complete_mmio_emulation_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_24));
                        if v_71
                        then (
                          when st_26 == ((complete_sysreg_emulation_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_25));
                          when st_27 == ((complete_hvc_exit_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_26));
                          when st_28 == ((reset_last_run_info_spec v_40 st_27));
                          when st_29 == ((process_disposed_info_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_28));
                          when v_77, st_30 == ((load_RData 8 (ptr_offset v_40 856) st_29));
                          when st_31 == ((store_RData 8 (ptr_offset v_40 808) v_77 st_30));
                          when v_81, st_32 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 216) st_31));
                          if (v_81 =? (0))
                          then (
                            when v_86, st_34 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 224) st_32));
                            if (v_86 =? (0))
                            then (smc_rec_enter_8_low st_0 st_34 v_2 v_31 v_40 v_86)
                            else (
                              when v_88, st_35 == ((load_RData 8 (ptr_offset v_40 808) st_34));
                              when st_36 == ((store_RData 8 (ptr_offset v_40 808) (v_88 |' (16384)) st_35));
                              when st_38 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_36));
                              when st_39 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_38));
                              when v_95, st_46 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_39));
                              when st_47 == ((ns_buffer_unmap_spec 0 st_46));
                              when st_49 == ((atomic_granule_put_release_spec v_31 st_47));
                              when st_51 == ((free_stack "smc_rec_enter" st_0 st_49));
                              (Some st_51)))
                          else (
                            when st_33 == ((store_RData 8 (ptr_offset v_40 808) (v_77 |' (8192)) st_32));
                            when v_86, st_35 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 224) st_33));
                            if (v_86 =? (0))
                            then (smc_rec_enter_9_low st_0 st_35 v_2 v_31 v_40 v_86)
                            else (
                              when v_88, st_36 == ((load_RData 8 (ptr_offset v_40 808) st_35));
                              when st_37 == ((store_RData 8 (ptr_offset v_40 808) (v_88 |' (16384)) st_36));
                              when st_39 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_37));
                              when st_40 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_39));
                              when v_95, st_47 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_40));
                              when st_48 == ((ns_buffer_unmap_spec 0 st_47));
                              when st_50 == ((atomic_granule_put_release_spec v_31 st_48));
                              when st_52 == ((free_stack "smc_rec_enter" st_0 st_50));
                              (Some st_52))))
                        else (
                          when v_73, st_26 == ((pack_return_code_spec 7 0 st_25));
                          if (v_73 =? (0))
                          then (
                            when v_95, st_33 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_26));
                            when st_34 == ((ns_buffer_unmap_spec 0 st_33));
                            when st_36 == ((atomic_granule_put_release_spec v_31 st_34));
                            when st_38 == ((free_stack "smc_rec_enter" st_0 st_36));
                            (Some st_38))
                          else (
                            when st_34 == ((atomic_granule_put_release_spec v_31 st_26));
                            when st_36 == ((free_stack "smc_rec_enter" st_0 st_34));
                            (Some st_36))))
                      else (
                        when v_69, st_25 == ((pack_return_code_spec 7 0 st_24));
                        if (v_69 =? (0))
                        then (
                          when v_95, st_31 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_25));
                          when st_32 == ((ns_buffer_unmap_spec 0 st_31));
                          when st_34 == ((atomic_granule_put_release_spec v_31 st_32));
                          when st_36 == ((free_stack "smc_rec_enter" st_0 st_34));
                          (Some st_36))
                        else (
                          when st_32 == ((atomic_granule_put_release_spec v_31 st_25));
                          when st_34 == ((free_stack "smc_rec_enter" st_0 st_32));
                          (Some st_34))))
                    else (
                      when v_63, st_23 == ((pack_return_code_spec 7 0 st_22));
                      if (v_63 =? (0))
                      then (
                        when v_95, st_28 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_23));
                        when st_29 == ((ns_buffer_unmap_spec 0 st_28));
                        when st_31 == ((atomic_granule_put_release_spec v_31 st_29));
                        when st_33 == ((free_stack "smc_rec_enter" st_0 st_31));
                        (Some st_33))
                      else (
                        when st_29 == ((atomic_granule_put_release_spec v_31 st_23));
                        when st_31 == ((free_stack "smc_rec_enter" st_0 st_29));
                        (Some st_31)))))))
            else (
              when st_16 == ((atomic_granule_put_release_spec v_31 st_15));
              when v_36, st_17 == ((pack_return_code_spec 1 2 st_16));
              when st_18 == ((store_RData 8 (ptr_offset v_3 0) v_36 st_17));
              when v_40, st_20 == ((granule_map_spec v_31 3 st_18));
              when v_44_tmp, st_21 == ((load_RData 8 (ptr_offset v_40 944) st_20));
              when v_45, st_22 == ((granule_map_spec (int_to_ptr v_44_tmp) 2 st_21));
              when v_47, st_23 == ((get_rd_state_unlocked_spec v_45 st_22));
              if (v_47 =? (2))
              then (
                when v_51, st_24 == ((pack_return_code_spec 5 1 st_23));
                if (v_51 =? (0))
                then (
                  when v_95, st_26 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_24));
                  when st_27 == ((ns_buffer_unmap_spec 0 st_26));
                  when st_29 == ((atomic_granule_put_release_spec v_31 st_27));
                  when st_31 == ((free_stack "smc_rec_enter" st_0 st_29));
                  (Some st_31))
                else (
                  when st_27 == ((atomic_granule_put_release_spec v_31 st_24));
                  when st_29 == ((free_stack "smc_rec_enter" st_0 st_27));
                  (Some st_29)))
              else (
                if (v_47 =? (0))
                then (
                  when v_49, st_24 == ((pack_return_code_spec 5 0 st_23));
                  if (v_49 =? (0))
                  then (
                    when v_95, st_27 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_24));
                    when st_28 == ((ns_buffer_unmap_spec 0 st_27));
                    when st_30 == ((atomic_granule_put_release_spec v_31 st_28));
                    when st_32 == ((free_stack "smc_rec_enter" st_0 st_30));
                    (Some st_32))
                  else (
                    when st_28 == ((atomic_granule_put_release_spec v_31 st_24));
                    when st_30 == ((free_stack "smc_rec_enter" st_0 st_28));
                    (Some st_30)))
                else (
                  when v_54, st_24 == ((load_RData 1 (ptr_offset v_40 16) st_23));
                  if ((v_54 & (1)) =? (0))
                  then (
                    when v_57, st_25 == ((pack_return_code_spec 7 0 st_24));
                    if (v_57 =? (0))
                    then (
                      when v_95, st_29 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_25));
                      when st_30 == ((ns_buffer_unmap_spec 0 st_29));
                      when st_32 == ((atomic_granule_put_release_spec v_31 st_30));
                      when st_34 == ((free_stack "smc_rec_enter" st_0 st_32));
                      (Some st_34))
                    else (
                      when st_30 == ((atomic_granule_put_release_spec v_31 st_25));
                      when st_32 == ((free_stack "smc_rec_enter" st_0 st_30));
                      (Some st_32)))
                  else (
                    when v_60, st_25 == ((load_RData 1 (ptr_offset v_40 1512) st_24));
                    if ((v_60 & (1)) =? (0))
                    then (
                      when st_26 == ((copy_gic_state_from_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_entry" 0) st_25));
                      when v_67, st_27 == ((validate_gic_state_spec (ptr_offset v_40 584) st_26));
                      if v_67
                      then (
                        when v_71, st_28 == ((complete_mmio_emulation_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_27));
                        if v_71
                        then (
                          when st_29 == ((complete_sysreg_emulation_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_28));
                          when st_30 == ((complete_hvc_exit_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_29));
                          when st_31 == ((reset_last_run_info_spec v_40 st_30));
                          when st_32 == ((process_disposed_info_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_31));
                          when v_77, st_33 == ((load_RData 8 (ptr_offset v_40 856) st_32));
                          when st_34 == ((store_RData 8 (ptr_offset v_40 808) v_77 st_33));
                          when v_81, st_35 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 216) st_34));
                          if (v_81 =? (0))
                          then (
                            when v_86, st_37 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 224) st_35));
                            if (v_86 =? (0))
                            then (smc_rec_enter_10_low st_0 st_37 v_2 v_31 v_40 v_86)
                            else (
                              when v_88, st_38 == ((load_RData 8 (ptr_offset v_40 808) st_37));
                              when st_39 == ((store_RData 8 (ptr_offset v_40 808) (v_88 |' (16384)) st_38));
                              when st_41 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_39));
                              when st_42 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_41));
                              when v_95, st_49 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_42));
                              when st_50 == ((ns_buffer_unmap_spec 0 st_49));
                              when st_52 == ((atomic_granule_put_release_spec v_31 st_50));
                              when st_54 == ((free_stack "smc_rec_enter" st_0 st_52));
                              (Some st_54)))
                          else (
                            when st_36 == ((store_RData 8 (ptr_offset v_40 808) (v_77 |' (8192)) st_35));
                            when v_86, st_38 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 224) st_36));
                            if (v_86 =? (0))
                            then (smc_rec_enter_11_low st_0 st_38 v_2 v_31 v_40 v_86)
                            else (
                              when v_88, st_39 == ((load_RData 8 (ptr_offset v_40 808) st_38));
                              when st_40 == ((store_RData 8 (ptr_offset v_40 808) (v_88 |' (16384)) st_39));
                              when st_42 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_40));
                              when st_43 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_42));
                              when v_95, st_50 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_43));
                              when st_51 == ((ns_buffer_unmap_spec 0 st_50));
                              when st_53 == ((atomic_granule_put_release_spec v_31 st_51));
                              when st_55 == ((free_stack "smc_rec_enter" st_0 st_53));
                              (Some st_55))))
                        else (
                          when v_73, st_29 == ((pack_return_code_spec 7 0 st_28));
                          if (v_73 =? (0))
                          then (
                            when v_95, st_36 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_29));
                            when st_37 == ((ns_buffer_unmap_spec 0 st_36));
                            when st_39 == ((atomic_granule_put_release_spec v_31 st_37));
                            when st_41 == ((free_stack "smc_rec_enter" st_0 st_39));
                            (Some st_41))
                          else (
                            when st_37 == ((atomic_granule_put_release_spec v_31 st_29));
                            when st_39 == ((free_stack "smc_rec_enter" st_0 st_37));
                            (Some st_39))))
                      else (
                        when v_69, st_28 == ((pack_return_code_spec 7 0 st_27));
                        if (v_69 =? (0))
                        then (
                          when v_95, st_34 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_28));
                          when st_35 == ((ns_buffer_unmap_spec 0 st_34));
                          when st_37 == ((atomic_granule_put_release_spec v_31 st_35));
                          when st_39 == ((free_stack "smc_rec_enter" st_0 st_37));
                          (Some st_39))
                        else (
                          when st_35 == ((atomic_granule_put_release_spec v_31 st_28));
                          when st_37 == ((free_stack "smc_rec_enter" st_0 st_35));
                          (Some st_37))))
                    else (
                      when v_63, st_26 == ((pack_return_code_spec 7 0 st_25));
                      if (v_63 =? (0))
                      then (
                        when v_95, st_31 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_26));
                        when st_32 == ((ns_buffer_unmap_spec 0 st_31));
                        when st_34 == ((atomic_granule_put_release_spec v_31 st_32));
                        when st_36 == ((free_stack "smc_rec_enter" st_0 st_34));
                        (Some st_36))
                      else (
                        when st_32 == ((atomic_granule_put_release_spec v_31 st_26));
                        when st_34 == ((free_stack "smc_rec_enter" st_0 st_32));
                        (Some st_34))))))))
          else (
            when v_31, st_9 == ((find_lock_unused_granule_spec v_0 3 st_7));
            when st_10 == ((atomic_granule_get_spec v_31 st_9));
            when st_11 == ((granule_unlock_spec v_31 st_10));
            when v_34, st_12 == ((ns_buffer_read_spec 0 v_1 232 (mkPtr "stack_s_rec_entry" 0) st_11));
            when st_13 == ((ns_buffer_unmap_spec 0 st_12));
            if v_34
            then (
              when v_40, st_15 == ((granule_map_spec v_31 3 st_13));
              when v_44_tmp, st_16 == ((load_RData 8 (ptr_offset v_40 944) st_15));
              when v_45, st_17 == ((granule_map_spec (int_to_ptr v_44_tmp) 2 st_16));
              when v_47, st_18 == ((get_rd_state_unlocked_spec v_45 st_17));
              if (v_47 =? (2))
              then (
                when v_51, st_19 == ((pack_return_code_spec 5 1 st_18));
                if (v_51 =? (0))
                then (
                  when v_95, st_21 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_19));
                  when st_22 == ((ns_buffer_unmap_spec 0 st_21));
                  when st_24 == ((atomic_granule_put_release_spec v_31 st_22));
                  when st_26 == ((free_stack "smc_rec_enter" st_0 st_24));
                  (Some st_26))
                else (
                  when st_22 == ((atomic_granule_put_release_spec v_31 st_19));
                  when st_24 == ((free_stack "smc_rec_enter" st_0 st_22));
                  (Some st_24)))
              else (
                if (v_47 =? (0))
                then (
                  when v_49, st_19 == ((pack_return_code_spec 5 0 st_18));
                  if (v_49 =? (0))
                  then (
                    when v_95, st_22 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_19));
                    when st_23 == ((ns_buffer_unmap_spec 0 st_22));
                    when st_25 == ((atomic_granule_put_release_spec v_31 st_23));
                    when st_27 == ((free_stack "smc_rec_enter" st_0 st_25));
                    (Some st_27))
                  else (
                    when st_23 == ((atomic_granule_put_release_spec v_31 st_19));
                    when st_25 == ((free_stack "smc_rec_enter" st_0 st_23));
                    (Some st_25)))
                else (
                  when v_54, st_19 == ((load_RData 1 (ptr_offset v_40 16) st_18));
                  if ((v_54 & (1)) =? (0))
                  then (
                    when v_57, st_20 == ((pack_return_code_spec 7 0 st_19));
                    if (v_57 =? (0))
                    then (
                      when v_95, st_24 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_20));
                      when st_25 == ((ns_buffer_unmap_spec 0 st_24));
                      when st_27 == ((atomic_granule_put_release_spec v_31 st_25));
                      when st_29 == ((free_stack "smc_rec_enter" st_0 st_27));
                      (Some st_29))
                    else (
                      when st_25 == ((atomic_granule_put_release_spec v_31 st_20));
                      when st_27 == ((free_stack "smc_rec_enter" st_0 st_25));
                      (Some st_27)))
                  else (
                    when v_60, st_20 == ((load_RData 1 (ptr_offset v_40 1512) st_19));
                    if ((v_60 & (1)) =? (0))
                    then (
                      when st_21 == ((copy_gic_state_from_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_entry" 0) st_20));
                      when v_67, st_22 == ((validate_gic_state_spec (ptr_offset v_40 584) st_21));
                      if v_67
                      then (
                        when v_71, st_23 == ((complete_mmio_emulation_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_22));
                        if v_71
                        then (
                          when st_24 == ((complete_sysreg_emulation_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_23));
                          when st_25 == ((complete_hvc_exit_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_24));
                          when st_26 == ((reset_last_run_info_spec v_40 st_25));
                          when st_27 == ((process_disposed_info_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_26));
                          when v_77, st_28 == ((load_RData 8 (ptr_offset v_40 856) st_27));
                          when st_29 == ((store_RData 8 (ptr_offset v_40 808) v_77 st_28));
                          when v_81, st_30 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 216) st_29));
                          if (v_81 =? (0))
                          then (
                            when v_86, st_32 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 224) st_30));
                            if (v_86 =? (0))
                            then (smc_rec_enter_12_low st_0 st_32 v_2 v_31 v_40 v_86)
                            else (
                              when v_88, st_33 == ((load_RData 8 (ptr_offset v_40 808) st_32));
                              when st_34 == ((store_RData 8 (ptr_offset v_40 808) (v_88 |' (16384)) st_33));
                              when st_36 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_34));
                              when st_37 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_36));
                              when v_95, st_44 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_37));
                              when st_45 == ((ns_buffer_unmap_spec 0 st_44));
                              when st_47 == ((atomic_granule_put_release_spec v_31 st_45));
                              when st_49 == ((free_stack "smc_rec_enter" st_0 st_47));
                              (Some st_49)))
                          else (
                            when st_31 == ((store_RData 8 (ptr_offset v_40 808) (v_77 |' (8192)) st_30));
                            when v_86, st_33 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 224) st_31));
                            if (v_86 =? (0))
                            then (smc_rec_enter_13_low st_0 st_33 v_2 v_31 v_40 v_86)
                            else (
                              when v_88, st_34 == ((load_RData 8 (ptr_offset v_40 808) st_33));
                              when st_35 == ((store_RData 8 (ptr_offset v_40 808) (v_88 |' (16384)) st_34));
                              when st_37 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_35));
                              when st_38 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_37));
                              when v_95, st_45 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_38));
                              when st_46 == ((ns_buffer_unmap_spec 0 st_45));
                              when st_48 == ((atomic_granule_put_release_spec v_31 st_46));
                              when st_50 == ((free_stack "smc_rec_enter" st_0 st_48));
                              (Some st_50))))
                        else (
                          when v_73, st_24 == ((pack_return_code_spec 7 0 st_23));
                          if (v_73 =? (0))
                          then (
                            when v_95, st_31 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_24));
                            when st_32 == ((ns_buffer_unmap_spec 0 st_31));
                            when st_34 == ((atomic_granule_put_release_spec v_31 st_32));
                            when st_36 == ((free_stack "smc_rec_enter" st_0 st_34));
                            (Some st_36))
                          else (
                            when st_32 == ((atomic_granule_put_release_spec v_31 st_24));
                            when st_34 == ((free_stack "smc_rec_enter" st_0 st_32));
                            (Some st_34))))
                      else (
                        when v_69, st_23 == ((pack_return_code_spec 7 0 st_22));
                        if (v_69 =? (0))
                        then (
                          when v_95, st_29 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_23));
                          when st_30 == ((ns_buffer_unmap_spec 0 st_29));
                          when st_32 == ((atomic_granule_put_release_spec v_31 st_30));
                          when st_34 == ((free_stack "smc_rec_enter" st_0 st_32));
                          (Some st_34))
                        else (
                          when st_30 == ((atomic_granule_put_release_spec v_31 st_23));
                          when st_32 == ((free_stack "smc_rec_enter" st_0 st_30));
                          (Some st_32))))
                    else (
                      when v_63, st_21 == ((pack_return_code_spec 7 0 st_20));
                      if (v_63 =? (0))
                      then (
                        when v_95, st_26 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_21));
                        when st_27 == ((ns_buffer_unmap_spec 0 st_26));
                        when st_29 == ((atomic_granule_put_release_spec v_31 st_27));
                        when st_31 == ((free_stack "smc_rec_enter" st_0 st_29));
                        (Some st_31))
                      else (
                        when st_27 == ((atomic_granule_put_release_spec v_31 st_21));
                        when st_29 == ((free_stack "smc_rec_enter" st_0 st_27));
                        (Some st_29)))))))
            else (
              when st_14 == ((atomic_granule_put_release_spec v_31 st_13));
              when v_36, st_15 == ((pack_return_code_spec 1 2 st_14));
              when st_16 == ((store_RData 8 (ptr_offset v_3 0) v_36 st_15));
              when v_40, st_18 == ((granule_map_spec v_31 3 st_16));
              when v_44_tmp, st_19 == ((load_RData 8 (ptr_offset v_40 944) st_18));
              when v_45, st_20 == ((granule_map_spec (int_to_ptr v_44_tmp) 2 st_19));
              when v_47, st_21 == ((get_rd_state_unlocked_spec v_45 st_20));
              if (v_47 =? (2))
              then (
                when v_51, st_22 == ((pack_return_code_spec 5 1 st_21));
                if (v_51 =? (0))
                then (
                  when v_95, st_24 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_22));
                  when st_25 == ((ns_buffer_unmap_spec 0 st_24));
                  when st_27 == ((atomic_granule_put_release_spec v_31 st_25));
                  when st_29 == ((free_stack "smc_rec_enter" st_0 st_27));
                  (Some st_29))
                else (
                  when st_25 == ((atomic_granule_put_release_spec v_31 st_22));
                  when st_27 == ((free_stack "smc_rec_enter" st_0 st_25));
                  (Some st_27)))
              else (
                if (v_47 =? (0))
                then (
                  when v_49, st_22 == ((pack_return_code_spec 5 0 st_21));
                  if (v_49 =? (0))
                  then (
                    when v_95, st_25 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_22));
                    when st_26 == ((ns_buffer_unmap_spec 0 st_25));
                    when st_28 == ((atomic_granule_put_release_spec v_31 st_26));
                    when st_30 == ((free_stack "smc_rec_enter" st_0 st_28));
                    (Some st_30))
                  else (
                    when st_26 == ((atomic_granule_put_release_spec v_31 st_22));
                    when st_28 == ((free_stack "smc_rec_enter" st_0 st_26));
                    (Some st_28)))
                else (
                  when v_54, st_22 == ((load_RData 1 (ptr_offset v_40 16) st_21));
                  if ((v_54 & (1)) =? (0))
                  then (
                    when v_57, st_23 == ((pack_return_code_spec 7 0 st_22));
                    if (v_57 =? (0))
                    then (
                      when v_95, st_27 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_23));
                      when st_28 == ((ns_buffer_unmap_spec 0 st_27));
                      when st_30 == ((atomic_granule_put_release_spec v_31 st_28));
                      when st_32 == ((free_stack "smc_rec_enter" st_0 st_30));
                      (Some st_32))
                    else (
                      when st_28 == ((atomic_granule_put_release_spec v_31 st_23));
                      when st_30 == ((free_stack "smc_rec_enter" st_0 st_28));
                      (Some st_30)))
                  else (
                    when v_60, st_23 == ((load_RData 1 (ptr_offset v_40 1512) st_22));
                    if ((v_60 & (1)) =? (0))
                    then (
                      when st_24 == ((copy_gic_state_from_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_entry" 0) st_23));
                      when v_67, st_25 == ((validate_gic_state_spec (ptr_offset v_40 584) st_24));
                      if v_67
                      then (
                        when v_71, st_26 == ((complete_mmio_emulation_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_25));
                        if v_71
                        then (
                          when st_27 == ((complete_sysreg_emulation_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_26));
                          when st_28 == ((complete_hvc_exit_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_27));
                          when st_29 == ((reset_last_run_info_spec v_40 st_28));
                          when st_30 == ((process_disposed_info_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_29));
                          when v_77, st_31 == ((load_RData 8 (ptr_offset v_40 856) st_30));
                          when st_32 == ((store_RData 8 (ptr_offset v_40 808) v_77 st_31));
                          when v_81, st_33 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 216) st_32));
                          if (v_81 =? (0))
                          then (
                            when v_86, st_35 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 224) st_33));
                            if (v_86 =? (0))
                            then (smc_rec_enter_14_low st_0 st_35 v_2 v_31 v_40 v_86)
                            else (
                              when v_88, st_36 == ((load_RData 8 (ptr_offset v_40 808) st_35));
                              when st_37 == ((store_RData 8 (ptr_offset v_40 808) (v_88 |' (16384)) st_36));
                              when st_39 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_37));
                              when st_40 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_39));
                              when v_95, st_47 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_40));
                              when st_48 == ((ns_buffer_unmap_spec 0 st_47));
                              when st_50 == ((atomic_granule_put_release_spec v_31 st_48));
                              when st_52 == ((free_stack "smc_rec_enter" st_0 st_50));
                              (Some st_52)))
                          else (
                            when st_34 == ((store_RData 8 (ptr_offset v_40 808) (v_77 |' (8192)) st_33));
                            when v_86, st_36 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 224) st_34));
                            if (v_86 =? (0))
                            then (smc_rec_enter_15_low st_0 st_36 v_2 v_31 v_40 v_86)
                            else (
                              when v_88, st_37 == ((load_RData 8 (ptr_offset v_40 808) st_36));
                              when st_38 == ((store_RData 8 (ptr_offset v_40 808) (v_88 |' (16384)) st_37));
                              when st_40 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_38));
                              when st_41 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_40));
                              when v_95, st_48 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_41));
                              when st_49 == ((ns_buffer_unmap_spec 0 st_48));
                              when st_51 == ((atomic_granule_put_release_spec v_31 st_49));
                              when st_53 == ((free_stack "smc_rec_enter" st_0 st_51));
                              (Some st_53))))
                        else (
                          when v_73, st_27 == ((pack_return_code_spec 7 0 st_26));
                          if (v_73 =? (0))
                          then (
                            when v_95, st_34 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_27));
                            when st_35 == ((ns_buffer_unmap_spec 0 st_34));
                            when st_37 == ((atomic_granule_put_release_spec v_31 st_35));
                            when st_39 == ((free_stack "smc_rec_enter" st_0 st_37));
                            (Some st_39))
                          else (
                            when st_35 == ((atomic_granule_put_release_spec v_31 st_27));
                            when st_37 == ((free_stack "smc_rec_enter" st_0 st_35));
                            (Some st_37))))
                      else (
                        when v_69, st_26 == ((pack_return_code_spec 7 0 st_25));
                        if (v_69 =? (0))
                        then (
                          when v_95, st_32 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_26));
                          when st_33 == ((ns_buffer_unmap_spec 0 st_32));
                          when st_35 == ((atomic_granule_put_release_spec v_31 st_33));
                          when st_37 == ((free_stack "smc_rec_enter" st_0 st_35));
                          (Some st_37))
                        else (
                          when st_33 == ((atomic_granule_put_release_spec v_31 st_26));
                          when st_35 == ((free_stack "smc_rec_enter" st_0 st_33));
                          (Some st_35))))
                    else (
                      when v_63, st_24 == ((pack_return_code_spec 7 0 st_23));
                      if (v_63 =? (0))
                      then (
                        when v_95, st_29 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_24));
                        when st_30 == ((ns_buffer_unmap_spec 0 st_29));
                        when st_32 == ((atomic_granule_put_release_spec v_31 st_30));
                        when st_34 == ((free_stack "smc_rec_enter" st_0 st_32));
                        (Some st_34))
                      else (
                        when st_30 == ((atomic_granule_put_release_spec v_31 st_24));
                        when st_32 == ((free_stack "smc_rec_enter" st_0 st_30));
                        (Some st_32))))))))))
      else (
        when v_19, st_3 == ((validate_ns_struct_spec v_2 304 st_1));
        if (ptr_eqb v_19 (mkPtr "null" 0))
        then (
          when v_21, st_4 == ((pack_return_code_spec 1 3 st_3));
          when st_5 == ((store_RData 8 (ptr_offset v_3 0) v_21 st_4));
          when v_25, st_7 == ((ranges_intersect_spec v_1 232 v_2 304 st_5));
          if v_25
          then (
            when v_27, st_8 == ((pack_return_code_spec 3 0 st_7));
            when st_9 == ((store_RData 8 (ptr_offset v_3 0) v_27 st_8));
            when v_31, st_11 == ((find_lock_unused_granule_spec v_0 3 st_9));
            when st_12 == ((atomic_granule_get_spec v_31 st_11));
            when st_13 == ((granule_unlock_spec v_31 st_12));
            when v_34, st_14 == ((ns_buffer_read_spec 0 v_1 232 (mkPtr "stack_s_rec_entry" 0) st_13));
            when st_15 == ((ns_buffer_unmap_spec 0 st_14));
            if v_34
            then (
              when v_40, st_17 == ((granule_map_spec v_31 3 st_15));
              when v_44_tmp, st_18 == ((load_RData 8 (ptr_offset v_40 944) st_17));
              when v_45, st_19 == ((granule_map_spec (int_to_ptr v_44_tmp) 2 st_18));
              when v_47, st_20 == ((get_rd_state_unlocked_spec v_45 st_19));
              if (v_47 =? (2))
              then (
                when v_51, st_21 == ((pack_return_code_spec 5 1 st_20));
                if (v_51 =? (0))
                then (
                  when v_95, st_23 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_21));
                  when st_24 == ((ns_buffer_unmap_spec 0 st_23));
                  when st_26 == ((atomic_granule_put_release_spec v_31 st_24));
                  when st_28 == ((free_stack "smc_rec_enter" st_0 st_26));
                  (Some st_28))
                else (
                  when st_24 == ((atomic_granule_put_release_spec v_31 st_21));
                  when st_26 == ((free_stack "smc_rec_enter" st_0 st_24));
                  (Some st_26)))
              else (
                if (v_47 =? (0))
                then (
                  when v_49, st_21 == ((pack_return_code_spec 5 0 st_20));
                  if (v_49 =? (0))
                  then (
                    when v_95, st_24 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_21));
                    when st_25 == ((ns_buffer_unmap_spec 0 st_24));
                    when st_27 == ((atomic_granule_put_release_spec v_31 st_25));
                    when st_29 == ((free_stack "smc_rec_enter" st_0 st_27));
                    (Some st_29))
                  else (
                    when st_25 == ((atomic_granule_put_release_spec v_31 st_21));
                    when st_27 == ((free_stack "smc_rec_enter" st_0 st_25));
                    (Some st_27)))
                else (
                  when v_54, st_21 == ((load_RData 1 (ptr_offset v_40 16) st_20));
                  if ((v_54 & (1)) =? (0))
                  then (
                    when v_57, st_22 == ((pack_return_code_spec 7 0 st_21));
                    if (v_57 =? (0))
                    then (
                      when v_95, st_26 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_22));
                      when st_27 == ((ns_buffer_unmap_spec 0 st_26));
                      when st_29 == ((atomic_granule_put_release_spec v_31 st_27));
                      when st_31 == ((free_stack "smc_rec_enter" st_0 st_29));
                      (Some st_31))
                    else (
                      when st_27 == ((atomic_granule_put_release_spec v_31 st_22));
                      when st_29 == ((free_stack "smc_rec_enter" st_0 st_27));
                      (Some st_29)))
                  else (
                    when v_60, st_22 == ((load_RData 1 (ptr_offset v_40 1512) st_21));
                    if ((v_60 & (1)) =? (0))
                    then (
                      when st_23 == ((copy_gic_state_from_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_entry" 0) st_22));
                      when v_67, st_24 == ((validate_gic_state_spec (ptr_offset v_40 584) st_23));
                      if v_67
                      then (
                        when v_71, st_25 == ((complete_mmio_emulation_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_24));
                        if v_71
                        then (
                          when st_26 == ((complete_sysreg_emulation_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_25));
                          when st_27 == ((complete_hvc_exit_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_26));
                          when st_28 == ((reset_last_run_info_spec v_40 st_27));
                          when st_29 == ((process_disposed_info_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_28));
                          when v_77, st_30 == ((load_RData 8 (ptr_offset v_40 856) st_29));
                          when st_31 == ((store_RData 8 (ptr_offset v_40 808) v_77 st_30));
                          when v_81, st_32 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 216) st_31));
                          if (v_81 =? (0))
                          then (
                            when v_86, st_34 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 224) st_32));
                            if (v_86 =? (0))
                            then (smc_rec_enter_16_low st_0 st_34 v_2 v_31 v_40 v_86)
                            else (
                              when v_88, st_35 == ((load_RData 8 (ptr_offset v_40 808) st_34));
                              when st_36 == ((store_RData 8 (ptr_offset v_40 808) (v_88 |' (16384)) st_35));
                              when st_38 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_36));
                              when st_39 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_38));
                              when v_95, st_46 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_39));
                              when st_47 == ((ns_buffer_unmap_spec 0 st_46));
                              when st_49 == ((atomic_granule_put_release_spec v_31 st_47));
                              when st_51 == ((free_stack "smc_rec_enter" st_0 st_49));
                              (Some st_51)))
                          else (
                            when st_33 == ((store_RData 8 (ptr_offset v_40 808) (v_77 |' (8192)) st_32));
                            when v_86, st_35 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 224) st_33));
                            if (v_86 =? (0))
                            then (smc_rec_enter_17_low st_0 st_35 v_2 v_31 v_40 v_86)
                            else (
                              when v_88, st_36 == ((load_RData 8 (ptr_offset v_40 808) st_35));
                              when st_37 == ((store_RData 8 (ptr_offset v_40 808) (v_88 |' (16384)) st_36));
                              when st_39 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_37));
                              when st_40 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_39));
                              when v_95, st_47 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_40));
                              when st_48 == ((ns_buffer_unmap_spec 0 st_47));
                              when st_50 == ((atomic_granule_put_release_spec v_31 st_48));
                              when st_52 == ((free_stack "smc_rec_enter" st_0 st_50));
                              (Some st_52))))
                        else (
                          when v_73, st_26 == ((pack_return_code_spec 7 0 st_25));
                          if (v_73 =? (0))
                          then (
                            when v_95, st_33 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_26));
                            when st_34 == ((ns_buffer_unmap_spec 0 st_33));
                            when st_36 == ((atomic_granule_put_release_spec v_31 st_34));
                            when st_38 == ((free_stack "smc_rec_enter" st_0 st_36));
                            (Some st_38))
                          else (
                            when st_34 == ((atomic_granule_put_release_spec v_31 st_26));
                            when st_36 == ((free_stack "smc_rec_enter" st_0 st_34));
                            (Some st_36))))
                      else (
                        when v_69, st_25 == ((pack_return_code_spec 7 0 st_24));
                        if (v_69 =? (0))
                        then (
                          when v_95, st_31 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_25));
                          when st_32 == ((ns_buffer_unmap_spec 0 st_31));
                          when st_34 == ((atomic_granule_put_release_spec v_31 st_32));
                          when st_36 == ((free_stack "smc_rec_enter" st_0 st_34));
                          (Some st_36))
                        else (
                          when st_32 == ((atomic_granule_put_release_spec v_31 st_25));
                          when st_34 == ((free_stack "smc_rec_enter" st_0 st_32));
                          (Some st_34))))
                    else (
                      when v_63, st_23 == ((pack_return_code_spec 7 0 st_22));
                      if (v_63 =? (0))
                      then (
                        when v_95, st_28 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_23));
                        when st_29 == ((ns_buffer_unmap_spec 0 st_28));
                        when st_31 == ((atomic_granule_put_release_spec v_31 st_29));
                        when st_33 == ((free_stack "smc_rec_enter" st_0 st_31));
                        (Some st_33))
                      else (
                        when st_29 == ((atomic_granule_put_release_spec v_31 st_23));
                        when st_31 == ((free_stack "smc_rec_enter" st_0 st_29));
                        (Some st_31)))))))
            else (
              when st_16 == ((atomic_granule_put_release_spec v_31 st_15));
              when v_36, st_17 == ((pack_return_code_spec 1 2 st_16));
              when st_18 == ((store_RData 8 (ptr_offset v_3 0) v_36 st_17));
              when v_40, st_20 == ((granule_map_spec v_31 3 st_18));
              when v_44_tmp, st_21 == ((load_RData 8 (ptr_offset v_40 944) st_20));
              when v_45, st_22 == ((granule_map_spec (int_to_ptr v_44_tmp) 2 st_21));
              when v_47, st_23 == ((get_rd_state_unlocked_spec v_45 st_22));
              if (v_47 =? (2))
              then (
                when v_51, st_24 == ((pack_return_code_spec 5 1 st_23));
                if (v_51 =? (0))
                then (
                  when v_95, st_26 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_24));
                  when st_27 == ((ns_buffer_unmap_spec 0 st_26));
                  when st_29 == ((atomic_granule_put_release_spec v_31 st_27));
                  when st_31 == ((free_stack "smc_rec_enter" st_0 st_29));
                  (Some st_31))
                else (
                  when st_27 == ((atomic_granule_put_release_spec v_31 st_24));
                  when st_29 == ((free_stack "smc_rec_enter" st_0 st_27));
                  (Some st_29)))
              else (
                if (v_47 =? (0))
                then (
                  when v_49, st_24 == ((pack_return_code_spec 5 0 st_23));
                  if (v_49 =? (0))
                  then (
                    when v_95, st_27 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_24));
                    when st_28 == ((ns_buffer_unmap_spec 0 st_27));
                    when st_30 == ((atomic_granule_put_release_spec v_31 st_28));
                    when st_32 == ((free_stack "smc_rec_enter" st_0 st_30));
                    (Some st_32))
                  else (
                    when st_28 == ((atomic_granule_put_release_spec v_31 st_24));
                    when st_30 == ((free_stack "smc_rec_enter" st_0 st_28));
                    (Some st_30)))
                else (
                  when v_54, st_24 == ((load_RData 1 (ptr_offset v_40 16) st_23));
                  if ((v_54 & (1)) =? (0))
                  then (
                    when v_57, st_25 == ((pack_return_code_spec 7 0 st_24));
                    if (v_57 =? (0))
                    then (
                      when v_95, st_29 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_25));
                      when st_30 == ((ns_buffer_unmap_spec 0 st_29));
                      when st_32 == ((atomic_granule_put_release_spec v_31 st_30));
                      when st_34 == ((free_stack "smc_rec_enter" st_0 st_32));
                      (Some st_34))
                    else (
                      when st_30 == ((atomic_granule_put_release_spec v_31 st_25));
                      when st_32 == ((free_stack "smc_rec_enter" st_0 st_30));
                      (Some st_32)))
                  else (
                    when v_60, st_25 == ((load_RData 1 (ptr_offset v_40 1512) st_24));
                    if ((v_60 & (1)) =? (0))
                    then (
                      when st_26 == ((copy_gic_state_from_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_entry" 0) st_25));
                      when v_67, st_27 == ((validate_gic_state_spec (ptr_offset v_40 584) st_26));
                      if v_67
                      then (
                        when v_71, st_28 == ((complete_mmio_emulation_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_27));
                        if v_71
                        then (
                          when st_29 == ((complete_sysreg_emulation_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_28));
                          when st_30 == ((complete_hvc_exit_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_29));
                          when st_31 == ((reset_last_run_info_spec v_40 st_30));
                          when st_32 == ((process_disposed_info_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_31));
                          when v_77, st_33 == ((load_RData 8 (ptr_offset v_40 856) st_32));
                          when st_34 == ((store_RData 8 (ptr_offset v_40 808) v_77 st_33));
                          when v_81, st_35 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 216) st_34));
                          if (v_81 =? (0))
                          then (
                            when v_86, st_37 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 224) st_35));
                            if (v_86 =? (0))
                            then (smc_rec_enter_18_low st_0 st_37 v_2 v_31 v_40 v_86)
                            else (
                              when v_88, st_38 == ((load_RData 8 (ptr_offset v_40 808) st_37));
                              when st_39 == ((store_RData 8 (ptr_offset v_40 808) (v_88 |' (16384)) st_38));
                              when st_41 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_39));
                              when st_42 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_41));
                              when v_95, st_49 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_42));
                              when st_50 == ((ns_buffer_unmap_spec 0 st_49));
                              when st_52 == ((atomic_granule_put_release_spec v_31 st_50));
                              when st_54 == ((free_stack "smc_rec_enter" st_0 st_52));
                              (Some st_54)))
                          else (
                            when st_36 == ((store_RData 8 (ptr_offset v_40 808) (v_77 |' (8192)) st_35));
                            when v_86, st_38 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 224) st_36));
                            if (v_86 =? (0))
                            then (smc_rec_enter_19_low st_0 st_38 v_2 v_31 v_40 v_86)
                            else (
                              when v_88, st_39 == ((load_RData 8 (ptr_offset v_40 808) st_38));
                              when st_40 == ((store_RData 8 (ptr_offset v_40 808) (v_88 |' (16384)) st_39));
                              when st_42 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_40));
                              when st_43 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_42));
                              when v_95, st_50 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_43));
                              when st_51 == ((ns_buffer_unmap_spec 0 st_50));
                              when st_53 == ((atomic_granule_put_release_spec v_31 st_51));
                              when st_55 == ((free_stack "smc_rec_enter" st_0 st_53));
                              (Some st_55))))
                        else (
                          when v_73, st_29 == ((pack_return_code_spec 7 0 st_28));
                          if (v_73 =? (0))
                          then (
                            when v_95, st_36 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_29));
                            when st_37 == ((ns_buffer_unmap_spec 0 st_36));
                            when st_39 == ((atomic_granule_put_release_spec v_31 st_37));
                            when st_41 == ((free_stack "smc_rec_enter" st_0 st_39));
                            (Some st_41))
                          else (
                            when st_37 == ((atomic_granule_put_release_spec v_31 st_29));
                            when st_39 == ((free_stack "smc_rec_enter" st_0 st_37));
                            (Some st_39))))
                      else (
                        when v_69, st_28 == ((pack_return_code_spec 7 0 st_27));
                        if (v_69 =? (0))
                        then (
                          when v_95, st_34 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_28));
                          when st_35 == ((ns_buffer_unmap_spec 0 st_34));
                          when st_37 == ((atomic_granule_put_release_spec v_31 st_35));
                          when st_39 == ((free_stack "smc_rec_enter" st_0 st_37));
                          (Some st_39))
                        else (
                          when st_35 == ((atomic_granule_put_release_spec v_31 st_28));
                          when st_37 == ((free_stack "smc_rec_enter" st_0 st_35));
                          (Some st_37))))
                    else (
                      when v_63, st_26 == ((pack_return_code_spec 7 0 st_25));
                      if (v_63 =? (0))
                      then (
                        when v_95, st_31 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_26));
                        when st_32 == ((ns_buffer_unmap_spec 0 st_31));
                        when st_34 == ((atomic_granule_put_release_spec v_31 st_32));
                        when st_36 == ((free_stack "smc_rec_enter" st_0 st_34));
                        (Some st_36))
                      else (
                        when st_32 == ((atomic_granule_put_release_spec v_31 st_26));
                        when st_34 == ((free_stack "smc_rec_enter" st_0 st_32));
                        (Some st_34))))))))
          else (
            when v_31, st_9 == ((find_lock_unused_granule_spec v_0 3 st_7));
            when st_10 == ((atomic_granule_get_spec v_31 st_9));
            when st_11 == ((granule_unlock_spec v_31 st_10));
            when v_34, st_12 == ((ns_buffer_read_spec 0 v_1 232 (mkPtr "stack_s_rec_entry" 0) st_11));
            when st_13 == ((ns_buffer_unmap_spec 0 st_12));
            if v_34
            then (
              when v_40, st_15 == ((granule_map_spec v_31 3 st_13));
              when v_44_tmp, st_16 == ((load_RData 8 (ptr_offset v_40 944) st_15));
              when v_45, st_17 == ((granule_map_spec (int_to_ptr v_44_tmp) 2 st_16));
              when v_47, st_18 == ((get_rd_state_unlocked_spec v_45 st_17));
              if (v_47 =? (2))
              then (
                when v_51, st_19 == ((pack_return_code_spec 5 1 st_18));
                if (v_51 =? (0))
                then (
                  when v_95, st_21 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_19));
                  when st_22 == ((ns_buffer_unmap_spec 0 st_21));
                  when st_24 == ((atomic_granule_put_release_spec v_31 st_22));
                  when st_26 == ((free_stack "smc_rec_enter" st_0 st_24));
                  (Some st_26))
                else (
                  when st_22 == ((atomic_granule_put_release_spec v_31 st_19));
                  when st_24 == ((free_stack "smc_rec_enter" st_0 st_22));
                  (Some st_24)))
              else (
                if (v_47 =? (0))
                then (
                  when v_49, st_19 == ((pack_return_code_spec 5 0 st_18));
                  if (v_49 =? (0))
                  then (
                    when v_95, st_22 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_19));
                    when st_23 == ((ns_buffer_unmap_spec 0 st_22));
                    when st_25 == ((atomic_granule_put_release_spec v_31 st_23));
                    when st_27 == ((free_stack "smc_rec_enter" st_0 st_25));
                    (Some st_27))
                  else (
                    when st_23 == ((atomic_granule_put_release_spec v_31 st_19));
                    when st_25 == ((free_stack "smc_rec_enter" st_0 st_23));
                    (Some st_25)))
                else (
                  when v_54, st_19 == ((load_RData 1 (ptr_offset v_40 16) st_18));
                  if ((v_54 & (1)) =? (0))
                  then (
                    when v_57, st_20 == ((pack_return_code_spec 7 0 st_19));
                    if (v_57 =? (0))
                    then (
                      when v_95, st_24 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_20));
                      when st_25 == ((ns_buffer_unmap_spec 0 st_24));
                      when st_27 == ((atomic_granule_put_release_spec v_31 st_25));
                      when st_29 == ((free_stack "smc_rec_enter" st_0 st_27));
                      (Some st_29))
                    else (
                      when st_25 == ((atomic_granule_put_release_spec v_31 st_20));
                      when st_27 == ((free_stack "smc_rec_enter" st_0 st_25));
                      (Some st_27)))
                  else (
                    when v_60, st_20 == ((load_RData 1 (ptr_offset v_40 1512) st_19));
                    if ((v_60 & (1)) =? (0))
                    then (
                      when st_21 == ((copy_gic_state_from_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_entry" 0) st_20));
                      when v_67, st_22 == ((validate_gic_state_spec (ptr_offset v_40 584) st_21));
                      if v_67
                      then (
                        when v_71, st_23 == ((complete_mmio_emulation_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_22));
                        if v_71
                        then (
                          when st_24 == ((complete_sysreg_emulation_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_23));
                          when st_25 == ((complete_hvc_exit_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_24));
                          when st_26 == ((reset_last_run_info_spec v_40 st_25));
                          when st_27 == ((process_disposed_info_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_26));
                          when v_77, st_28 == ((load_RData 8 (ptr_offset v_40 856) st_27));
                          when st_29 == ((store_RData 8 (ptr_offset v_40 808) v_77 st_28));
                          when v_81, st_30 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 216) st_29));
                          if (v_81 =? (0))
                          then (
                            when v_86, st_32 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 224) st_30));
                            if (v_86 =? (0))
                            then (smc_rec_enter_20_low st_0 st_32 v_2 v_31 v_40 v_86)
                            else (
                              when v_88, st_33 == ((load_RData 8 (ptr_offset v_40 808) st_32));
                              when st_34 == ((store_RData 8 (ptr_offset v_40 808) (v_88 |' (16384)) st_33));
                              when st_36 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_34));
                              when st_37 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_36));
                              when v_95, st_44 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_37));
                              when st_45 == ((ns_buffer_unmap_spec 0 st_44));
                              when st_47 == ((atomic_granule_put_release_spec v_31 st_45));
                              when st_49 == ((free_stack "smc_rec_enter" st_0 st_47));
                              (Some st_49)))
                          else (
                            when st_31 == ((store_RData 8 (ptr_offset v_40 808) (v_77 |' (8192)) st_30));
                            when v_86, st_33 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 224) st_31));
                            if (v_86 =? (0))
                            then (smc_rec_enter_21_low st_0 st_33 v_2 v_31 v_40 v_86)
                            else (
                              when v_88, st_34 == ((load_RData 8 (ptr_offset v_40 808) st_33));
                              when st_35 == ((store_RData 8 (ptr_offset v_40 808) (v_88 |' (16384)) st_34));
                              when st_37 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_35));
                              when st_38 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_37));
                              when v_95, st_45 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_38));
                              when st_46 == ((ns_buffer_unmap_spec 0 st_45));
                              when st_48 == ((atomic_granule_put_release_spec v_31 st_46));
                              when st_50 == ((free_stack "smc_rec_enter" st_0 st_48));
                              (Some st_50))))
                        else (
                          when v_73, st_24 == ((pack_return_code_spec 7 0 st_23));
                          if (v_73 =? (0))
                          then (
                            when v_95, st_31 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_24));
                            when st_32 == ((ns_buffer_unmap_spec 0 st_31));
                            when st_34 == ((atomic_granule_put_release_spec v_31 st_32));
                            when st_36 == ((free_stack "smc_rec_enter" st_0 st_34));
                            (Some st_36))
                          else (
                            when st_32 == ((atomic_granule_put_release_spec v_31 st_24));
                            when st_34 == ((free_stack "smc_rec_enter" st_0 st_32));
                            (Some st_34))))
                      else (
                        when v_69, st_23 == ((pack_return_code_spec 7 0 st_22));
                        if (v_69 =? (0))
                        then (
                          when v_95, st_29 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_23));
                          when st_30 == ((ns_buffer_unmap_spec 0 st_29));
                          when st_32 == ((atomic_granule_put_release_spec v_31 st_30));
                          when st_34 == ((free_stack "smc_rec_enter" st_0 st_32));
                          (Some st_34))
                        else (
                          when st_30 == ((atomic_granule_put_release_spec v_31 st_23));
                          when st_32 == ((free_stack "smc_rec_enter" st_0 st_30));
                          (Some st_32))))
                    else (
                      when v_63, st_21 == ((pack_return_code_spec 7 0 st_20));
                      if (v_63 =? (0))
                      then (
                        when v_95, st_26 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_21));
                        when st_27 == ((ns_buffer_unmap_spec 0 st_26));
                        when st_29 == ((atomic_granule_put_release_spec v_31 st_27));
                        when st_31 == ((free_stack "smc_rec_enter" st_0 st_29));
                        (Some st_31))
                      else (
                        when st_27 == ((atomic_granule_put_release_spec v_31 st_21));
                        when st_29 == ((free_stack "smc_rec_enter" st_0 st_27));
                        (Some st_29)))))))
            else (
              when st_14 == ((atomic_granule_put_release_spec v_31 st_13));
              when v_36, st_15 == ((pack_return_code_spec 1 2 st_14));
              when st_16 == ((store_RData 8 (ptr_offset v_3 0) v_36 st_15));
              when v_40, st_18 == ((granule_map_spec v_31 3 st_16));
              when v_44_tmp, st_19 == ((load_RData 8 (ptr_offset v_40 944) st_18));
              when v_45, st_20 == ((granule_map_spec (int_to_ptr v_44_tmp) 2 st_19));
              when v_47, st_21 == ((get_rd_state_unlocked_spec v_45 st_20));
              if (v_47 =? (2))
              then (
                when v_51, st_22 == ((pack_return_code_spec 5 1 st_21));
                if (v_51 =? (0))
                then (
                  when v_95, st_24 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_22));
                  when st_25 == ((ns_buffer_unmap_spec 0 st_24));
                  when st_27 == ((atomic_granule_put_release_spec v_31 st_25));
                  when st_29 == ((free_stack "smc_rec_enter" st_0 st_27));
                  (Some st_29))
                else (
                  when st_25 == ((atomic_granule_put_release_spec v_31 st_22));
                  when st_27 == ((free_stack "smc_rec_enter" st_0 st_25));
                  (Some st_27)))
              else (
                if (v_47 =? (0))
                then (
                  when v_49, st_22 == ((pack_return_code_spec 5 0 st_21));
                  if (v_49 =? (0))
                  then (
                    when v_95, st_25 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_22));
                    when st_26 == ((ns_buffer_unmap_spec 0 st_25));
                    when st_28 == ((atomic_granule_put_release_spec v_31 st_26));
                    when st_30 == ((free_stack "smc_rec_enter" st_0 st_28));
                    (Some st_30))
                  else (
                    when st_26 == ((atomic_granule_put_release_spec v_31 st_22));
                    when st_28 == ((free_stack "smc_rec_enter" st_0 st_26));
                    (Some st_28)))
                else (
                  when v_54, st_22 == ((load_RData 1 (ptr_offset v_40 16) st_21));
                  if ((v_54 & (1)) =? (0))
                  then (
                    when v_57, st_23 == ((pack_return_code_spec 7 0 st_22));
                    if (v_57 =? (0))
                    then (
                      when v_95, st_27 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_23));
                      when st_28 == ((ns_buffer_unmap_spec 0 st_27));
                      when st_30 == ((atomic_granule_put_release_spec v_31 st_28));
                      when st_32 == ((free_stack "smc_rec_enter" st_0 st_30));
                      (Some st_32))
                    else (
                      when st_28 == ((atomic_granule_put_release_spec v_31 st_23));
                      when st_30 == ((free_stack "smc_rec_enter" st_0 st_28));
                      (Some st_30)))
                  else (
                    when v_60, st_23 == ((load_RData 1 (ptr_offset v_40 1512) st_22));
                    if ((v_60 & (1)) =? (0))
                    then (
                      when st_24 == ((copy_gic_state_from_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_entry" 0) st_23));
                      when v_67, st_25 == ((validate_gic_state_spec (ptr_offset v_40 584) st_24));
                      if v_67
                      then (
                        when v_71, st_26 == ((complete_mmio_emulation_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_25));
                        if v_71
                        then (
                          when st_27 == ((complete_sysreg_emulation_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_26));
                          when st_28 == ((complete_hvc_exit_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_27));
                          when st_29 == ((reset_last_run_info_spec v_40 st_28));
                          when st_30 == ((process_disposed_info_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_29));
                          when v_77, st_31 == ((load_RData 8 (ptr_offset v_40 856) st_30));
                          when st_32 == ((store_RData 8 (ptr_offset v_40 808) v_77 st_31));
                          when v_81, st_33 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 216) st_32));
                          if (v_81 =? (0))
                          then (
                            when v_86, st_35 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 224) st_33));
                            if (v_86 =? (0))
                            then (smc_rec_enter_22_low st_0 st_35 v_2 v_31 v_40 v_86)
                            else (
                              when v_88, st_36 == ((load_RData 8 (ptr_offset v_40 808) st_35));
                              when st_37 == ((store_RData 8 (ptr_offset v_40 808) (v_88 |' (16384)) st_36));
                              when st_39 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_37));
                              when st_40 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_39));
                              when v_95, st_47 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_40));
                              when st_48 == ((ns_buffer_unmap_spec 0 st_47));
                              when st_50 == ((atomic_granule_put_release_spec v_31 st_48));
                              when st_52 == ((free_stack "smc_rec_enter" st_0 st_50));
                              (Some st_52)))
                          else (
                            when st_34 == ((store_RData 8 (ptr_offset v_40 808) (v_77 |' (8192)) st_33));
                            when v_86, st_36 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 224) st_34));
                            if (v_86 =? (0))
                            then (smc_rec_enter_23_low st_0 st_36 v_2 v_31 v_40 v_86)
                            else (
                              when v_88, st_37 == ((load_RData 8 (ptr_offset v_40 808) st_36));
                              when st_38 == ((store_RData 8 (ptr_offset v_40 808) (v_88 |' (16384)) st_37));
                              when st_40 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_38));
                              when st_41 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_40));
                              when v_95, st_48 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_41));
                              when st_49 == ((ns_buffer_unmap_spec 0 st_48));
                              when st_51 == ((atomic_granule_put_release_spec v_31 st_49));
                              when st_53 == ((free_stack "smc_rec_enter" st_0 st_51));
                              (Some st_53))))
                        else (
                          when v_73, st_27 == ((pack_return_code_spec 7 0 st_26));
                          if (v_73 =? (0))
                          then (
                            when v_95, st_34 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_27));
                            when st_35 == ((ns_buffer_unmap_spec 0 st_34));
                            when st_37 == ((atomic_granule_put_release_spec v_31 st_35));
                            when st_39 == ((free_stack "smc_rec_enter" st_0 st_37));
                            (Some st_39))
                          else (
                            when st_35 == ((atomic_granule_put_release_spec v_31 st_27));
                            when st_37 == ((free_stack "smc_rec_enter" st_0 st_35));
                            (Some st_37))))
                      else (
                        when v_69, st_26 == ((pack_return_code_spec 7 0 st_25));
                        if (v_69 =? (0))
                        then (
                          when v_95, st_32 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_26));
                          when st_33 == ((ns_buffer_unmap_spec 0 st_32));
                          when st_35 == ((atomic_granule_put_release_spec v_31 st_33));
                          when st_37 == ((free_stack "smc_rec_enter" st_0 st_35));
                          (Some st_37))
                        else (
                          when st_33 == ((atomic_granule_put_release_spec v_31 st_26));
                          when st_35 == ((free_stack "smc_rec_enter" st_0 st_33));
                          (Some st_35))))
                    else (
                      when v_63, st_24 == ((pack_return_code_spec 7 0 st_23));
                      if (v_63 =? (0))
                      then (
                        when v_95, st_29 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_24));
                        when st_30 == ((ns_buffer_unmap_spec 0 st_29));
                        when st_32 == ((atomic_granule_put_release_spec v_31 st_30));
                        when st_34 == ((free_stack "smc_rec_enter" st_0 st_32));
                        (Some st_34))
                      else (
                        when st_30 == ((atomic_granule_put_release_spec v_31 st_24));
                        when st_32 == ((free_stack "smc_rec_enter" st_0 st_30));
                        (Some st_32)))))))))
        else (
          when v_25, st_5 == ((ranges_intersect_spec v_1 232 v_2 304 st_3));
          if v_25
          then (
            when v_27, st_6 == ((pack_return_code_spec 3 0 st_5));
            when st_7 == ((store_RData 8 (ptr_offset v_3 0) v_27 st_6));
            when v_31, st_9 == ((find_lock_unused_granule_spec v_0 3 st_7));
            when st_10 == ((atomic_granule_get_spec v_31 st_9));
            when st_11 == ((granule_unlock_spec v_31 st_10));
            when v_34, st_12 == ((ns_buffer_read_spec 0 v_1 232 (mkPtr "stack_s_rec_entry" 0) st_11));
            when st_13 == ((ns_buffer_unmap_spec 0 st_12));
            if v_34
            then (
              when v_40, st_15 == ((granule_map_spec v_31 3 st_13));
              when v_44_tmp, st_16 == ((load_RData 8 (ptr_offset v_40 944) st_15));
              when v_45, st_17 == ((granule_map_spec (int_to_ptr v_44_tmp) 2 st_16));
              when v_47, st_18 == ((get_rd_state_unlocked_spec v_45 st_17));
              if (v_47 =? (2))
              then (
                when v_51, st_19 == ((pack_return_code_spec 5 1 st_18));
                if (v_51 =? (0))
                then (
                  when v_95, st_21 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_19));
                  when st_22 == ((ns_buffer_unmap_spec 0 st_21));
                  when st_24 == ((atomic_granule_put_release_spec v_31 st_22));
                  when st_26 == ((free_stack "smc_rec_enter" st_0 st_24));
                  (Some st_26))
                else (
                  when st_22 == ((atomic_granule_put_release_spec v_31 st_19));
                  when st_24 == ((free_stack "smc_rec_enter" st_0 st_22));
                  (Some st_24)))
              else (
                if (v_47 =? (0))
                then (
                  when v_49, st_19 == ((pack_return_code_spec 5 0 st_18));
                  if (v_49 =? (0))
                  then (
                    when v_95, st_22 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_19));
                    when st_23 == ((ns_buffer_unmap_spec 0 st_22));
                    when st_25 == ((atomic_granule_put_release_spec v_31 st_23));
                    when st_27 == ((free_stack "smc_rec_enter" st_0 st_25));
                    (Some st_27))
                  else (
                    when st_23 == ((atomic_granule_put_release_spec v_31 st_19));
                    when st_25 == ((free_stack "smc_rec_enter" st_0 st_23));
                    (Some st_25)))
                else (
                  when v_54, st_19 == ((load_RData 1 (ptr_offset v_40 16) st_18));
                  if ((v_54 & (1)) =? (0))
                  then (
                    when v_57, st_20 == ((pack_return_code_spec 7 0 st_19));
                    if (v_57 =? (0))
                    then (
                      when v_95, st_24 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_20));
                      when st_25 == ((ns_buffer_unmap_spec 0 st_24));
                      when st_27 == ((atomic_granule_put_release_spec v_31 st_25));
                      when st_29 == ((free_stack "smc_rec_enter" st_0 st_27));
                      (Some st_29))
                    else (
                      when st_25 == ((atomic_granule_put_release_spec v_31 st_20));
                      when st_27 == ((free_stack "smc_rec_enter" st_0 st_25));
                      (Some st_27)))
                  else (
                    when v_60, st_20 == ((load_RData 1 (ptr_offset v_40 1512) st_19));
                    if ((v_60 & (1)) =? (0))
                    then (
                      when st_21 == ((copy_gic_state_from_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_entry" 0) st_20));
                      when v_67, st_22 == ((validate_gic_state_spec (ptr_offset v_40 584) st_21));
                      if v_67
                      then (
                        when v_71, st_23 == ((complete_mmio_emulation_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_22));
                        if v_71
                        then (
                          when st_24 == ((complete_sysreg_emulation_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_23));
                          when st_25 == ((complete_hvc_exit_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_24));
                          when st_26 == ((reset_last_run_info_spec v_40 st_25));
                          when st_27 == ((process_disposed_info_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_26));
                          when v_77, st_28 == ((load_RData 8 (ptr_offset v_40 856) st_27));
                          when st_29 == ((store_RData 8 (ptr_offset v_40 808) v_77 st_28));
                          when v_81, st_30 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 216) st_29));
                          if (v_81 =? (0))
                          then (
                            when v_86, st_32 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 224) st_30));
                            if (v_86 =? (0))
                            then (smc_rec_enter_24_low st_0 st_32 v_2 v_31 v_40 v_86)
                            else (
                              when v_88, st_33 == ((load_RData 8 (ptr_offset v_40 808) st_32));
                              when st_34 == ((store_RData 8 (ptr_offset v_40 808) (v_88 |' (16384)) st_33));
                              when st_36 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_34));
                              when st_37 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_36));
                              when v_95, st_44 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_37));
                              when st_45 == ((ns_buffer_unmap_spec 0 st_44));
                              when st_47 == ((atomic_granule_put_release_spec v_31 st_45));
                              when st_49 == ((free_stack "smc_rec_enter" st_0 st_47));
                              (Some st_49)))
                          else (
                            when st_31 == ((store_RData 8 (ptr_offset v_40 808) (v_77 |' (8192)) st_30));
                            when v_86, st_33 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 224) st_31));
                            if (v_86 =? (0))
                            then (smc_rec_enter_25_low st_0 st_33 v_2 v_31 v_40 v_86)
                            else (
                              when v_88, st_34 == ((load_RData 8 (ptr_offset v_40 808) st_33));
                              when st_35 == ((store_RData 8 (ptr_offset v_40 808) (v_88 |' (16384)) st_34));
                              when st_37 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_35));
                              when st_38 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_37));
                              when v_95, st_45 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_38));
                              when st_46 == ((ns_buffer_unmap_spec 0 st_45));
                              when st_48 == ((atomic_granule_put_release_spec v_31 st_46));
                              when st_50 == ((free_stack "smc_rec_enter" st_0 st_48));
                              (Some st_50))))
                        else (
                          when v_73, st_24 == ((pack_return_code_spec 7 0 st_23));
                          if (v_73 =? (0))
                          then (
                            when v_95, st_31 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_24));
                            when st_32 == ((ns_buffer_unmap_spec 0 st_31));
                            when st_34 == ((atomic_granule_put_release_spec v_31 st_32));
                            when st_36 == ((free_stack "smc_rec_enter" st_0 st_34));
                            (Some st_36))
                          else (
                            when st_32 == ((atomic_granule_put_release_spec v_31 st_24));
                            when st_34 == ((free_stack "smc_rec_enter" st_0 st_32));
                            (Some st_34))))
                      else (
                        when v_69, st_23 == ((pack_return_code_spec 7 0 st_22));
                        if (v_69 =? (0))
                        then (
                          when v_95, st_29 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_23));
                          when st_30 == ((ns_buffer_unmap_spec 0 st_29));
                          when st_32 == ((atomic_granule_put_release_spec v_31 st_30));
                          when st_34 == ((free_stack "smc_rec_enter" st_0 st_32));
                          (Some st_34))
                        else (
                          when st_30 == ((atomic_granule_put_release_spec v_31 st_23));
                          when st_32 == ((free_stack "smc_rec_enter" st_0 st_30));
                          (Some st_32))))
                    else (
                      when v_63, st_21 == ((pack_return_code_spec 7 0 st_20));
                      if (v_63 =? (0))
                      then (
                        when v_95, st_26 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_21));
                        when st_27 == ((ns_buffer_unmap_spec 0 st_26));
                        when st_29 == ((atomic_granule_put_release_spec v_31 st_27));
                        when st_31 == ((free_stack "smc_rec_enter" st_0 st_29));
                        (Some st_31))
                      else (
                        when st_27 == ((atomic_granule_put_release_spec v_31 st_21));
                        when st_29 == ((free_stack "smc_rec_enter" st_0 st_27));
                        (Some st_29)))))))
            else (
              when st_14 == ((atomic_granule_put_release_spec v_31 st_13));
              when v_36, st_15 == ((pack_return_code_spec 1 2 st_14));
              when st_16 == ((store_RData 8 (ptr_offset v_3 0) v_36 st_15));
              when v_40, st_18 == ((granule_map_spec v_31 3 st_16));
              when v_44_tmp, st_19 == ((load_RData 8 (ptr_offset v_40 944) st_18));
              when v_45, st_20 == ((granule_map_spec (int_to_ptr v_44_tmp) 2 st_19));
              when v_47, st_21 == ((get_rd_state_unlocked_spec v_45 st_20));
              if (v_47 =? (2))
              then (
                when v_51, st_22 == ((pack_return_code_spec 5 1 st_21));
                if (v_51 =? (0))
                then (
                  when v_95, st_24 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_22));
                  when st_25 == ((ns_buffer_unmap_spec 0 st_24));
                  when st_27 == ((atomic_granule_put_release_spec v_31 st_25));
                  when st_29 == ((free_stack "smc_rec_enter" st_0 st_27));
                  (Some st_29))
                else (
                  when st_25 == ((atomic_granule_put_release_spec v_31 st_22));
                  when st_27 == ((free_stack "smc_rec_enter" st_0 st_25));
                  (Some st_27)))
              else (
                if (v_47 =? (0))
                then (
                  when v_49, st_22 == ((pack_return_code_spec 5 0 st_21));
                  if (v_49 =? (0))
                  then (
                    when v_95, st_25 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_22));
                    when st_26 == ((ns_buffer_unmap_spec 0 st_25));
                    when st_28 == ((atomic_granule_put_release_spec v_31 st_26));
                    when st_30 == ((free_stack "smc_rec_enter" st_0 st_28));
                    (Some st_30))
                  else (
                    when st_26 == ((atomic_granule_put_release_spec v_31 st_22));
                    when st_28 == ((free_stack "smc_rec_enter" st_0 st_26));
                    (Some st_28)))
                else (
                  when v_54, st_22 == ((load_RData 1 (ptr_offset v_40 16) st_21));
                  if ((v_54 & (1)) =? (0))
                  then (
                    when v_57, st_23 == ((pack_return_code_spec 7 0 st_22));
                    if (v_57 =? (0))
                    then (
                      when v_95, st_27 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_23));
                      when st_28 == ((ns_buffer_unmap_spec 0 st_27));
                      when st_30 == ((atomic_granule_put_release_spec v_31 st_28));
                      when st_32 == ((free_stack "smc_rec_enter" st_0 st_30));
                      (Some st_32))
                    else (
                      when st_28 == ((atomic_granule_put_release_spec v_31 st_23));
                      when st_30 == ((free_stack "smc_rec_enter" st_0 st_28));
                      (Some st_30)))
                  else (
                    when v_60, st_23 == ((load_RData 1 (ptr_offset v_40 1512) st_22));
                    if ((v_60 & (1)) =? (0))
                    then (
                      when st_24 == ((copy_gic_state_from_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_entry" 0) st_23));
                      when v_67, st_25 == ((validate_gic_state_spec (ptr_offset v_40 584) st_24));
                      if v_67
                      then (
                        when v_71, st_26 == ((complete_mmio_emulation_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_25));
                        if v_71
                        then (
                          when st_27 == ((complete_sysreg_emulation_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_26));
                          when st_28 == ((complete_hvc_exit_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_27));
                          when st_29 == ((reset_last_run_info_spec v_40 st_28));
                          when st_30 == ((process_disposed_info_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_29));
                          when v_77, st_31 == ((load_RData 8 (ptr_offset v_40 856) st_30));
                          when st_32 == ((store_RData 8 (ptr_offset v_40 808) v_77 st_31));
                          when v_81, st_33 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 216) st_32));
                          if (v_81 =? (0))
                          then (
                            when v_86, st_35 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 224) st_33));
                            if (v_86 =? (0))
                            then (smc_rec_enter_26_low st_0 st_35 v_2 v_31 v_40 v_86)
                            else (
                              when v_88, st_36 == ((load_RData 8 (ptr_offset v_40 808) st_35));
                              when st_37 == ((store_RData 8 (ptr_offset v_40 808) (v_88 |' (16384)) st_36));
                              when st_39 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_37));
                              when st_40 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_39));
                              when v_95, st_47 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_40));
                              when st_48 == ((ns_buffer_unmap_spec 0 st_47));
                              when st_50 == ((atomic_granule_put_release_spec v_31 st_48));
                              when st_52 == ((free_stack "smc_rec_enter" st_0 st_50));
                              (Some st_52)))
                          else (
                            when st_34 == ((store_RData 8 (ptr_offset v_40 808) (v_77 |' (8192)) st_33));
                            when v_86, st_36 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 224) st_34));
                            if (v_86 =? (0))
                            then (smc_rec_enter_27_low st_0 st_36 v_2 v_31 v_40 v_86)
                            else (
                              when v_88, st_37 == ((load_RData 8 (ptr_offset v_40 808) st_36));
                              when st_38 == ((store_RData 8 (ptr_offset v_40 808) (v_88 |' (16384)) st_37));
                              when st_40 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_38));
                              when st_41 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_40));
                              when v_95, st_48 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_41));
                              when st_49 == ((ns_buffer_unmap_spec 0 st_48));
                              when st_51 == ((atomic_granule_put_release_spec v_31 st_49));
                              when st_53 == ((free_stack "smc_rec_enter" st_0 st_51));
                              (Some st_53))))
                        else (
                          when v_73, st_27 == ((pack_return_code_spec 7 0 st_26));
                          if (v_73 =? (0))
                          then (
                            when v_95, st_34 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_27));
                            when st_35 == ((ns_buffer_unmap_spec 0 st_34));
                            when st_37 == ((atomic_granule_put_release_spec v_31 st_35));
                            when st_39 == ((free_stack "smc_rec_enter" st_0 st_37));
                            (Some st_39))
                          else (
                            when st_35 == ((atomic_granule_put_release_spec v_31 st_27));
                            when st_37 == ((free_stack "smc_rec_enter" st_0 st_35));
                            (Some st_37))))
                      else (
                        when v_69, st_26 == ((pack_return_code_spec 7 0 st_25));
                        if (v_69 =? (0))
                        then (
                          when v_95, st_32 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_26));
                          when st_33 == ((ns_buffer_unmap_spec 0 st_32));
                          when st_35 == ((atomic_granule_put_release_spec v_31 st_33));
                          when st_37 == ((free_stack "smc_rec_enter" st_0 st_35));
                          (Some st_37))
                        else (
                          when st_33 == ((atomic_granule_put_release_spec v_31 st_26));
                          when st_35 == ((free_stack "smc_rec_enter" st_0 st_33));
                          (Some st_35))))
                    else (
                      when v_63, st_24 == ((pack_return_code_spec 7 0 st_23));
                      if (v_63 =? (0))
                      then (
                        when v_95, st_29 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_24));
                        when st_30 == ((ns_buffer_unmap_spec 0 st_29));
                        when st_32 == ((atomic_granule_put_release_spec v_31 st_30));
                        when st_34 == ((free_stack "smc_rec_enter" st_0 st_32));
                        (Some st_34))
                      else (
                        when st_30 == ((atomic_granule_put_release_spec v_31 st_24));
                        when st_32 == ((free_stack "smc_rec_enter" st_0 st_30));
                        (Some st_32))))))))
          else (
            when v_31, st_7 == ((find_lock_unused_granule_spec v_0 3 st_5));
            when st_8 == ((atomic_granule_get_spec v_31 st_7));
            when st_9 == ((granule_unlock_spec v_31 st_8));
            when v_34, st_10 == ((ns_buffer_read_spec 0 v_1 232 (mkPtr "stack_s_rec_entry" 0) st_9));
            when st_11 == ((ns_buffer_unmap_spec 0 st_10));
            if v_34
            then (
              when v_40, st_13 == ((granule_map_spec v_31 3 st_11));
              when v_44_tmp, st_14 == ((load_RData 8 (ptr_offset v_40 944) st_13));
              when v_45, st_15 == ((granule_map_spec (int_to_ptr v_44_tmp) 2 st_14));
              when v_47, st_16 == ((get_rd_state_unlocked_spec v_45 st_15));
              if (v_47 =? (2))
              then (
                when v_51, st_17 == ((pack_return_code_spec 5 1 st_16));
                if (v_51 =? (0))
                then (
                  when v_95, st_19 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_17));
                  when st_20 == ((ns_buffer_unmap_spec 0 st_19));
                  when st_22 == ((atomic_granule_put_release_spec v_31 st_20));
                  when st_24 == ((free_stack "smc_rec_enter" st_0 st_22));
                  (Some st_24))
                else (
                  when st_20 == ((atomic_granule_put_release_spec v_31 st_17));
                  when st_22 == ((free_stack "smc_rec_enter" st_0 st_20));
                  (Some st_22)))
              else (
                if (v_47 =? (0))
                then (
                  when v_49, st_17 == ((pack_return_code_spec 5 0 st_16));
                  if (v_49 =? (0))
                  then (
                    when v_95, st_20 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_17));
                    when st_21 == ((ns_buffer_unmap_spec 0 st_20));
                    when st_23 == ((atomic_granule_put_release_spec v_31 st_21));
                    when st_25 == ((free_stack "smc_rec_enter" st_0 st_23));
                    (Some st_25))
                  else (
                    when st_21 == ((atomic_granule_put_release_spec v_31 st_17));
                    when st_23 == ((free_stack "smc_rec_enter" st_0 st_21));
                    (Some st_23)))
                else (
                  when v_54, st_17 == ((load_RData 1 (ptr_offset v_40 16) st_16));
                  if ((v_54 & (1)) =? (0))
                  then (
                    when v_57, st_18 == ((pack_return_code_spec 7 0 st_17));
                    if (v_57 =? (0))
                    then (
                      when v_95, st_22 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_18));
                      when st_23 == ((ns_buffer_unmap_spec 0 st_22));
                      when st_25 == ((atomic_granule_put_release_spec v_31 st_23));
                      when st_27 == ((free_stack "smc_rec_enter" st_0 st_25));
                      (Some st_27))
                    else (
                      when st_23 == ((atomic_granule_put_release_spec v_31 st_18));
                      when st_25 == ((free_stack "smc_rec_enter" st_0 st_23));
                      (Some st_25)))
                  else (
                    when v_60, st_18 == ((load_RData 1 (ptr_offset v_40 1512) st_17));
                    if ((v_60 & (1)) =? (0))
                    then (
                      when st_19 == ((copy_gic_state_from_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_entry" 0) st_18));
                      when v_67, st_20 == ((validate_gic_state_spec (ptr_offset v_40 584) st_19));
                      if v_67
                      then (
                        when v_71, st_21 == ((complete_mmio_emulation_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_20));
                        if v_71
                        then (
                          when st_22 == ((complete_sysreg_emulation_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_21));
                          when st_23 == ((complete_hvc_exit_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_22));
                          when st_24 == ((reset_last_run_info_spec v_40 st_23));
                          when st_25 == ((process_disposed_info_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_24));
                          when v_77, st_26 == ((load_RData 8 (ptr_offset v_40 856) st_25));
                          when st_27 == ((store_RData 8 (ptr_offset v_40 808) v_77 st_26));
                          when v_81, st_28 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 216) st_27));
                          if (v_81 =? (0))
                          then (
                            when v_86, st_30 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 224) st_28));
                            if (v_86 =? (0))
                            then (smc_rec_enter_28_low st_0 st_30 v_2 v_31 v_40 v_86)
                            else (
                              when v_88, st_31 == ((load_RData 8 (ptr_offset v_40 808) st_30));
                              when st_32 == ((store_RData 8 (ptr_offset v_40 808) (v_88 |' (16384)) st_31));
                              when st_34 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_32));
                              when st_35 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_34));
                              when v_95, st_42 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_35));
                              when st_43 == ((ns_buffer_unmap_spec 0 st_42));
                              when st_45 == ((atomic_granule_put_release_spec v_31 st_43));
                              when st_47 == ((free_stack "smc_rec_enter" st_0 st_45));
                              (Some st_47)))
                          else (
                            when st_29 == ((store_RData 8 (ptr_offset v_40 808) (v_77 |' (8192)) st_28));
                            when v_86, st_31 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 224) st_29));
                            if (v_86 =? (0))
                            then (smc_rec_enter_29_low st_0 st_31 v_2 v_31 v_40 v_86)
                            else (
                              when v_88, st_32 == ((load_RData 8 (ptr_offset v_40 808) st_31));
                              when st_33 == ((store_RData 8 (ptr_offset v_40 808) (v_88 |' (16384)) st_32));
                              when st_35 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_33));
                              when st_36 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_35));
                              when v_95, st_43 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_36));
                              when st_44 == ((ns_buffer_unmap_spec 0 st_43));
                              when st_46 == ((atomic_granule_put_release_spec v_31 st_44));
                              when st_48 == ((free_stack "smc_rec_enter" st_0 st_46));
                              (Some st_48))))
                        else (
                          when v_73, st_22 == ((pack_return_code_spec 7 0 st_21));
                          if (v_73 =? (0))
                          then (
                            when v_95, st_29 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_22));
                            when st_30 == ((ns_buffer_unmap_spec 0 st_29));
                            when st_32 == ((atomic_granule_put_release_spec v_31 st_30));
                            when st_34 == ((free_stack "smc_rec_enter" st_0 st_32));
                            (Some st_34))
                          else (
                            when st_30 == ((atomic_granule_put_release_spec v_31 st_22));
                            when st_32 == ((free_stack "smc_rec_enter" st_0 st_30));
                            (Some st_32))))
                      else (
                        when v_69, st_21 == ((pack_return_code_spec 7 0 st_20));
                        if (v_69 =? (0))
                        then (
                          when v_95, st_27 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_21));
                          when st_28 == ((ns_buffer_unmap_spec 0 st_27));
                          when st_30 == ((atomic_granule_put_release_spec v_31 st_28));
                          when st_32 == ((free_stack "smc_rec_enter" st_0 st_30));
                          (Some st_32))
                        else (
                          when st_28 == ((atomic_granule_put_release_spec v_31 st_21));
                          when st_30 == ((free_stack "smc_rec_enter" st_0 st_28));
                          (Some st_30))))
                    else (
                      when v_63, st_19 == ((pack_return_code_spec 7 0 st_18));
                      if (v_63 =? (0))
                      then (
                        when v_95, st_24 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_19));
                        when st_25 == ((ns_buffer_unmap_spec 0 st_24));
                        when st_27 == ((atomic_granule_put_release_spec v_31 st_25));
                        when st_29 == ((free_stack "smc_rec_enter" st_0 st_27));
                        (Some st_29))
                      else (
                        when st_25 == ((atomic_granule_put_release_spec v_31 st_19));
                        when st_27 == ((free_stack "smc_rec_enter" st_0 st_25));
                        (Some st_27)))))))
            else (
              when st_12 == ((atomic_granule_put_release_spec v_31 st_11));
              when v_36, st_13 == ((pack_return_code_spec 1 2 st_12));
              when st_14 == ((store_RData 8 (ptr_offset v_3 0) v_36 st_13));
              when v_40, st_16 == ((granule_map_spec v_31 3 st_14));
              when v_44_tmp, st_17 == ((load_RData 8 (ptr_offset v_40 944) st_16));
              when v_45, st_18 == ((granule_map_spec (int_to_ptr v_44_tmp) 2 st_17));
              when v_47, st_19 == ((get_rd_state_unlocked_spec v_45 st_18));
              if (v_47 =? (2))
              then (
                when v_51, st_20 == ((pack_return_code_spec 5 1 st_19));
                if (v_51 =? (0))
                then (
                  when v_95, st_22 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_20));
                  when st_23 == ((ns_buffer_unmap_spec 0 st_22));
                  when st_25 == ((atomic_granule_put_release_spec v_31 st_23));
                  when st_27 == ((free_stack "smc_rec_enter" st_0 st_25));
                  (Some st_27))
                else (
                  when st_23 == ((atomic_granule_put_release_spec v_31 st_20));
                  when st_25 == ((free_stack "smc_rec_enter" st_0 st_23));
                  (Some st_25)))
              else (
                if (v_47 =? (0))
                then (
                  when v_49, st_20 == ((pack_return_code_spec 5 0 st_19));
                  if (v_49 =? (0))
                  then (
                    when v_95, st_23 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_20));
                    when st_24 == ((ns_buffer_unmap_spec 0 st_23));
                    when st_26 == ((atomic_granule_put_release_spec v_31 st_24));
                    when st_28 == ((free_stack "smc_rec_enter" st_0 st_26));
                    (Some st_28))
                  else (
                    when st_24 == ((atomic_granule_put_release_spec v_31 st_20));
                    when st_26 == ((free_stack "smc_rec_enter" st_0 st_24));
                    (Some st_26)))
                else (
                  when v_54, st_20 == ((load_RData 1 (ptr_offset v_40 16) st_19));
                  if ((v_54 & (1)) =? (0))
                  then (
                    when v_57, st_21 == ((pack_return_code_spec 7 0 st_20));
                    if (v_57 =? (0))
                    then (
                      when v_95, st_25 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_21));
                      when st_26 == ((ns_buffer_unmap_spec 0 st_25));
                      when st_28 == ((atomic_granule_put_release_spec v_31 st_26));
                      when st_30 == ((free_stack "smc_rec_enter" st_0 st_28));
                      (Some st_30))
                    else (
                      when st_26 == ((atomic_granule_put_release_spec v_31 st_21));
                      when st_28 == ((free_stack "smc_rec_enter" st_0 st_26));
                      (Some st_28)))
                  else (
                    when v_60, st_21 == ((load_RData 1 (ptr_offset v_40 1512) st_20));
                    if ((v_60 & (1)) =? (0))
                    then (
                      when st_22 == ((copy_gic_state_from_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_entry" 0) st_21));
                      when v_67, st_23 == ((validate_gic_state_spec (ptr_offset v_40 584) st_22));
                      if v_67
                      then (
                        when v_71, st_24 == ((complete_mmio_emulation_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_23));
                        if v_71
                        then (
                          when st_25 == ((complete_sysreg_emulation_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_24));
                          when st_26 == ((complete_hvc_exit_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_25));
                          when st_27 == ((reset_last_run_info_spec v_40 st_26));
                          when st_28 == ((process_disposed_info_spec v_40 (mkPtr "stack_s_rec_entry" 0) st_27));
                          when v_77, st_29 == ((load_RData 8 (ptr_offset v_40 856) st_28));
                          when st_30 == ((store_RData 8 (ptr_offset v_40 808) v_77 st_29));
                          when v_81, st_31 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 216) st_30));
                          if (v_81 =? (0))
                          then (
                            when v_86, st_33 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 224) st_31));
                            if (v_86 =? (0))
                            then (smc_rec_enter_30_low st_0 st_33 v_2 v_31 v_40 v_86)
                            else (
                              when v_88, st_34 == ((load_RData 8 (ptr_offset v_40 808) st_33));
                              when st_35 == ((store_RData 8 (ptr_offset v_40 808) (v_88 |' (16384)) st_34));
                              when st_37 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_35));
                              when st_38 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_37));
                              when v_95, st_45 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_38));
                              when st_46 == ((ns_buffer_unmap_spec 0 st_45));
                              when st_48 == ((atomic_granule_put_release_spec v_31 st_46));
                              when st_50 == ((free_stack "smc_rec_enter" st_0 st_48));
                              (Some st_50)))
                          else (
                            when st_32 == ((store_RData 8 (ptr_offset v_40 808) (v_77 |' (8192)) st_31));
                            when v_86, st_34 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rec_entry" 0) 224) st_32));
                            if (v_86 =? (0))
                            then (smc_rec_enter_31_low st_0 st_34 v_2 v_31 v_40 v_86)
                            else (
                              when v_88, st_35 == ((load_RData 8 (ptr_offset v_40 808) st_34));
                              when st_36 == ((store_RData 8 (ptr_offset v_40 808) (v_88 |' (16384)) st_35));
                              when st_38 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_36));
                              when st_39 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_38));
                              when v_95, st_46 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_39));
                              when st_47 == ((ns_buffer_unmap_spec 0 st_46));
                              when st_49 == ((atomic_granule_put_release_spec v_31 st_47));
                              when st_51 == ((free_stack "smc_rec_enter" st_0 st_49));
                              (Some st_51))))
                        else (
                          when v_73, st_25 == ((pack_return_code_spec 7 0 st_24));
                          if (v_73 =? (0))
                          then (
                            when v_95, st_32 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_25));
                            when st_33 == ((ns_buffer_unmap_spec 0 st_32));
                            when st_35 == ((atomic_granule_put_release_spec v_31 st_33));
                            when st_37 == ((free_stack "smc_rec_enter" st_0 st_35));
                            (Some st_37))
                          else (
                            when st_33 == ((atomic_granule_put_release_spec v_31 st_25));
                            when st_35 == ((free_stack "smc_rec_enter" st_0 st_33));
                            (Some st_35))))
                      else (
                        when v_69, st_24 == ((pack_return_code_spec 7 0 st_23));
                        if (v_69 =? (0))
                        then (
                          when v_95, st_30 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_24));
                          when st_31 == ((ns_buffer_unmap_spec 0 st_30));
                          when st_33 == ((atomic_granule_put_release_spec v_31 st_31));
                          when st_35 == ((free_stack "smc_rec_enter" st_0 st_33));
                          (Some st_35))
                        else (
                          when st_31 == ((atomic_granule_put_release_spec v_31 st_24));
                          when st_33 == ((free_stack "smc_rec_enter" st_0 st_31));
                          (Some st_33))))
                    else (
                      when v_63, st_22 == ((pack_return_code_spec 7 0 st_21));
                      if (v_63 =? (0))
                      then (
                        when v_95, st_27 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_22));
                        when st_28 == ((ns_buffer_unmap_spec 0 st_27));
                        when st_30 == ((atomic_granule_put_release_spec v_31 st_28));
                        when st_32 == ((free_stack "smc_rec_enter" st_0 st_30));
                        (Some st_32))
                      else (
                        when st_28 == ((atomic_granule_put_release_spec v_31 st_22));
                        when st_30 == ((free_stack "smc_rec_enter" st_0 st_28));
                        (Some st_30)))))))))))
    else (
      when v_10, st_1 == ((granule_pa_to_va_spec (v_0 & ((- 2))) st_0));
      when st_2 == ((pico_rec_enter_spec v_10 v_1 v_2 v_3 st_1));
      when st_4 == ((free_stack "smc_rec_enter" st_0 st_2));
      (Some st_4)).

  (*
  Definition smc_data_dispose_spec (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    when st_0 == ((new_frame "smc_data_dispose" st));
    when v_8, st_1 == ((find_lock_two_granules_spec v_0 2 (mkPtr "stack_type_4" 0) v_1 3 (mkPtr "stack_type_4__1" 0) st_0));
    if (v_8 =? (3))
    then (
      when v_11, st_2 == ((pack_return_code_spec 3 0 st_1));
      when st_4 == ((free_stack "smc_data_dispose" st_0 st_2));
      (Some (v_11, st_4)))
    else (
      if (v_8 =? (0))
      then (
        when v_19_tmp, st_2 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_1));
        when v_20, st_3 == ((granule_refcount_read_acquire_spec (int_to_ptr v_19_tmp) st_2));
        if (v_20 =? (0))
        then (
          when v_24_tmp, st_4 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_3));
          when v_25, st_5 == ((granule_map_spec (int_to_ptr v_24_tmp) 3 st_4));
          when v_26_tmp, st_6 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_5));
          when v_29_tmp, st_7 == ((load_RData 8 (ptr_offset v_25 944) st_6));
          if (ptr_eqb (int_to_ptr v_26_tmp) (int_to_ptr v_29_tmp))
          then (
            when v_34, st_8 == ((load_RData 1 (ptr_offset v_25 896) st_7));
            if ((v_34 & (1)) =? (0))
            then (smc_data_dispose_1_low st_0 st_8 v_34)
            else (
              when v_41, st_9 == ((load_RData 8 (ptr_offset v_25 904) st_8));
              when v_44, st_10 == ((load_RData 8 (ptr_offset v_25 912) st_9));
              when v_47, st_11 == ((s2tte_map_size_spec v_3 st_10));
              when v_49, st_12 == ((region_is_contained_spec v_41 (v_44 + (v_41)) v_2 (v_47 + (v_2)) st_11));
              if v_49
              then (
                when v_53_tmp, st_13 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_12));
                when v_54, st_14 == ((granule_map_spec (int_to_ptr v_53_tmp) 2 st_13));
                when v_56, st_15 == ((validate_rtt_map_cmds_spec v_2 v_3 v_54 st_14));
                if (v_56 =? (0))
                then (
                  when v_63_tmp, st_16 == ((load_RData 8 (ptr_offset v_54 32) st_15));
                  when v_64, st_17 == ((realm_rtt_starting_level_spec v_54 st_16));
                  when v_65, st_18 == ((realm_ipa_bits_spec v_54 st_17));
                  when st_19 == ((granule_lock_spec (int_to_ptr v_63_tmp) 5 st_18));
                  when st_20 == ((rtt_walk_lock_unlock_spec (mkPtr "stack_s_rtt_walk" 0) (int_to_ptr v_63_tmp) v_64 v_65 v_2 v_3 st_19));
                  rely ((((st_20.(share)).(granule_data)) = (((st_19.(share)).(granule_data)))));
                  when v__sroa_032_0_copyload_tmp, st_21 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 0) st_20));
                  when v__sroa_5_0_copyload, st_22 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 16) st_21));
                  if ((v__sroa_5_0_copyload - (v_3)) =? (0))
                  then (
                    when v__sroa_3_0_copyload, st_23 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 8) st_22));
                    when v_70, st_24 == ((granule_map_spec (int_to_ptr v__sroa_032_0_copyload_tmp) 6 st_23));
                    when v_73, st_25 == ((__tte_read_spec (ptr_offset v_70 (8 * (v__sroa_3_0_copyload))) st_24));
                    when v_74, st_26 == ((s2tte_is_destroyed_spec v_73 st_25));
                    if v_74
                    then (smc_data_dispose_0_low st_0 st_26 v_70 v_74 v__sroa_032_0_copyload_tmp v__sroa_3_0_copyload)
                    else (
                      when v_76, st_27 == ((pack_return_code_spec 9 0 st_26));
                      when st_30 == ((granule_unlock_spec (int_to_ptr v__sroa_032_0_copyload_tmp) st_27));
                      when v_83_tmp, st_36 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_30));
                      when st_37 == ((granule_unlock_spec (int_to_ptr v_83_tmp) st_36));
                      when v_84_tmp, st_38 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_37));
                      when st_39 == ((granule_unlock_spec (int_to_ptr v_84_tmp) st_38));
                      when st_42 == ((free_stack "smc_data_dispose" st_0 st_39));
                      (Some (v_76, st_42))))
                  else (
                    when v_68, st_23 == ((pack_return_code_spec 8 v__sroa_5_0_copyload st_22));
                    when st_25 == ((granule_unlock_spec (int_to_ptr v__sroa_032_0_copyload_tmp) st_23));
                    when v_83_tmp, st_31 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_25));
                    when st_32 == ((granule_unlock_spec (int_to_ptr v_83_tmp) st_31));
                    when v_84_tmp, st_33 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_32));
                    when st_34 == ((granule_unlock_spec (int_to_ptr v_84_tmp) st_33));
                    when st_37 == ((free_stack "smc_data_dispose" st_0 st_34));
                    (Some (v_68, st_37))))
                else (
                  when v_59, st_16 == ((pack_return_code_spec v_56 ((v_56 >> (32)) + (3)) st_15));
                  when v_83_tmp, st_22 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_16));
                  when st_23 == ((granule_unlock_spec (int_to_ptr v_83_tmp) st_22));
                  when v_84_tmp, st_24 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_23));
                  when st_25 == ((granule_unlock_spec (int_to_ptr v_84_tmp) st_24));
                  when st_28 == ((free_stack "smc_data_dispose" st_0 st_25));
                  (Some (v_59, st_28))))
              else (
                when v_51, st_13 == ((pack_return_code_spec 1 3 st_12));
                when v_83_tmp, st_18 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_13));
                when st_19 == ((granule_unlock_spec (int_to_ptr v_83_tmp) st_18));
                when v_84_tmp, st_20 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_19));
                when st_21 == ((granule_unlock_spec (int_to_ptr v_84_tmp) st_20));
                when st_24 == ((free_stack "smc_data_dispose" st_0 st_21));
                (Some (v_51, st_24)))))
          else (
            when v_31, st_8 == ((pack_return_code_spec 6 0 st_7));
            when v_83_tmp, st_11 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_8));
            when st_12 == ((granule_unlock_spec (int_to_ptr v_83_tmp) st_11));
            when v_84_tmp, st_13 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_12));
            when st_14 == ((granule_unlock_spec (int_to_ptr v_84_tmp) st_13));
            when st_17 == ((free_stack "smc_data_dispose" st_0 st_14));
            (Some (v_31, st_17))))
        else (
          when v_22, st_4 == ((pack_return_code_spec 4 0 st_3));
          when v_83_tmp, st_6 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_4));
          when st_7 == ((granule_unlock_spec (int_to_ptr v_83_tmp) st_6));
          when v_84_tmp, st_8 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_7));
          when st_9 == ((granule_unlock_spec (int_to_ptr v_84_tmp) st_8));
          when st_12 == ((free_stack "smc_data_dispose" st_0 st_9));
          (Some (v_22, st_12))))
      else (
        when v_16, st_2 == ((pack_return_code_spec 1 ((v_8 >> (32)) + (1)) st_1));
        when st_5 == ((free_stack "smc_data_dispose" st_0 st_2));
        (Some (v_16, st_5)))).

  Definition smc_read_feature_register_spec (v_0: Z) (v_1: Ptr) (st: RData) : (option RData) :=
    if (v_0 =? (0))
    then (
      when v_4, st_0 == ((rmm_feature_register_0_value_spec st));
      when st_1 == ((store_RData 8 (ptr_offset v_1 8) v_4 st_0));
      when st_2 == ((store_RData 8 (ptr_offset v_1 0) 0 st_1));
      (Some st_2))
    else (
      when v_8, st_0 == ((pack_return_code_spec 1 1 st));
      when st_1 == ((store_RData 8 (ptr_offset v_1 0) v_8 st_0));
      (Some st_1)).

  Definition smc_rtt_destroy_spec (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    when st_0 == ((new_frame "smc_rtt_destroy" st));
    when v_7, st_1 == ((find_lock_granule_spec v_1 2 st_0));
    rely (((((v_7.(poffset)) mod (16)) = (0)) /\ (((v_7.(poffset)) >= (0)))));
    rely ((((v_7.(pbase)) = ("granules")) \/ (((v_7.(pbase)) = ("null")))));
    if (ptr_eqb v_7 (mkPtr "null" 0))
    then (
      when v_9, st_2 == ((pack_return_code_spec 1 2 st_1));
      when st_4 == ((free_stack "smc_rtt_destroy" st_0 st_2));
      (Some (v_9, st_4)))
    else (
      when v_11, st_2 == ((granule_map_spec v_7 2 st_1));
      when v_13, st_3 == ((validate_rtt_structure_cmds_spec v_2 v_3 v_11 st_2));
      if (v_13 =? (0))
      then (
        when v_22_tmp, st_4 == ((load_RData 8 (ptr_offset v_11 32) st_3));
        when v_23, st_5 == ((realm_rtt_starting_level_spec v_11 st_4));
        when v_24, st_6 == ((realm_ipa_bits_spec v_11 st_5));
        when st_7 == ((llvm_memcpy_p0i8_p0i8_i64_spec (mkPtr "stack_s_realm_s2_context" 0) (ptr_offset v_11 16) 32 false st_6));
        when st_8 == ((granule_lock_spec (int_to_ptr v_22_tmp) 5 st_7));
        when st_9 == ((granule_unlock_spec v_7 st_8));
        when st_10 == ((rtt_walk_lock_unlock_spec (mkPtr "stack_s_rtt_walk" 0) (int_to_ptr v_22_tmp) v_23 v_24 v_2 (v_3 + ((- 1))) st_9));
        rely ((((st_10.(share)).(granule_data)) = (((st_9.(share)).(granule_data)))));
        when v__sroa_019_0_copyload_tmp, st_11 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 0) st_10));
        when v__sroa_7_0_copyload, st_12 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 16) st_11));
        if ((v__sroa_7_0_copyload - ((v_3 + ((- 1))))) =? (0))
        then (
          when v__sroa_4_0_copyload, st_13 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 8) st_12));
          when v_31, st_14 == ((granule_map_spec (int_to_ptr v__sroa_019_0_copyload_tmp) 6 st_13));
          when v_34, st_15 == ((__tte_read_spec (ptr_offset v_31 (8 * (v__sroa_4_0_copyload))) st_14));
          when v_35, st_16 == ((s2tte_is_table_spec v_34 (v_3 + ((- 1))) st_15));
          if v_35
          then (
            when v_40, st_17 == ((s2tte_pa_spec v_34 (v_3 + ((- 1))) st_16));
            if ((v_40 - (v_0)) =? (0))
            then (
              when v_44, st_18 == ((find_lock_granule_spec v_0 5 st_17));
              rely (((((v_44.(poffset)) mod (16)) = (0)) /\ (((v_44.(poffset)) >= (0)))));
              rely ((((v_44.(pbase)) = ("granules")) \/ (((v_44.(pbase)) = ("null")))));
              when v_45, st_19 == ((g_refcount_spec v_44 st_18));
              if (v_45 =? (0))
              then (smc_rtt_destroy_0_low st_0 st_19 v_2 v_31 v_44 v_45 v__sroa_019_0_copyload_tmp v__sroa_4_0_copyload)
              else (
                when v_47, st_20 == ((pack_return_code_spec 4 0 st_19));
                when st_22 == ((granule_unlock_spec v_44 st_20));
                when st_26 == ((granule_unlock_spec (int_to_ptr v__sroa_019_0_copyload_tmp) st_22));
                when st_23 == ((free_stack "smc_rtt_destroy" st_0 st_26));
                (Some (v_47, st_23))))
            else (
              when v_42, st_18 == ((pack_return_code_spec 1 1 st_17));
              when st_22 == ((granule_unlock_spec (int_to_ptr v__sroa_019_0_copyload_tmp) st_18));
              when st_20 == ((free_stack "smc_rtt_destroy" st_0 st_22));
              (Some (v_42, st_20))))
          else (
            when v_38, st_17 == ((pack_return_code_spec 8 (v_3 + ((- 1))) st_16));
            when st_20 == ((granule_unlock_spec (int_to_ptr v__sroa_019_0_copyload_tmp) st_17));
            when st_19 == ((free_stack "smc_rtt_destroy" st_0 st_20));
            (Some (v_38, st_19))))
        else (
          when v_29, st_13 == ((pack_return_code_spec 8 v__sroa_7_0_copyload st_12));
          when st_15 == ((granule_unlock_spec (int_to_ptr v__sroa_019_0_copyload_tmp) st_13));
          when st_16 == ((free_stack "smc_rtt_destroy" st_0 st_15));
          (Some (v_29, st_16))))
      else (
        when st_4 == ((granule_unlock_spec v_7 st_3));
        when v_16, st_5 == ((pack_return_code_spec v_13 ((v_13 >> (32)) + (3)) st_4));
        when st_7 == ((free_stack "smc_rtt_destroy" st_0 st_5));
        (Some (v_16, st_7)))).


  Definition s2tte_create_destroyed_spec (st: RData) : (option (Z * RData)) :=
    (Some (8, st)).

  Definition smc_data_destroy_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    when st_0 == ((new_frame "smc_data_destroy" st));
    when v_4, st_1 == ((find_lock_granule_spec v_0 2 st_0));
    rely (((((v_4.(poffset)) mod (16)) = (0)) /\ (((v_4.(poffset)) >= (0)))));
    rely ((((v_4.(pbase)) = ("granules")) \/ (((v_4.(pbase)) = ("null")))));
    if (ptr_eqb v_4 (mkPtr "null" 0))
    then (
      when v_6, st_2 == ((pack_return_code_spec 1 1 st_1));
      when st_4 == ((free_stack "smc_data_destroy" st_0 st_2));
      (Some (v_6, st_4)))
    else (
      when v_9, st_2 == ((granule_map_spec v_4 2 st_1));
      when v_11, st_3 == ((validate_map_addr_spec v_1 3 v_9 st_2));
      if (v_11 =? (0))
      then (
        when v_18_tmp, st_4 == ((load_RData 8 (ptr_offset v_9 32) st_3));
        when v_19, st_5 == ((realm_rtt_starting_level_spec v_9 st_4));
        when v_20, st_6 == ((realm_ipa_bits_spec v_9 st_5));
        when st_7 == ((granule_lock_spec (int_to_ptr v_18_tmp) 5 st_6));
        when st_8 == ((granule_unlock_spec v_4 st_7));
        when st_9 == ((rtt_walk_lock_unlock_spec (mkPtr "stack_s_rtt_walk" 0) (int_to_ptr v_18_tmp) v_19 v_20 v_1 3 st_8));
        rely ((((st_9.(share)).(granule_data)) = (((st_8.(share)).(granule_data)))));
        when v__sroa_016_0_copyload_tmp, st_10 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 0) st_9));
        when v__sroa_6_0_copyload, st_11 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 16) st_10));
        if (v__sroa_6_0_copyload =? (3))
        then (
          when v__sroa_4_0_copyload, st_12 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 8) st_11));
          when v_25, st_13 == ((granule_map_spec (int_to_ptr v__sroa_016_0_copyload_tmp) 6 st_12));
          when v_28, st_14 == ((__tte_read_spec (ptr_offset v_25 (8 * (v__sroa_4_0_copyload))) st_13));
          when v_29, st_15 == ((s2tte_is_assigned_spec v_28 3 st_14));
          if v_29
          then (smc_data_destroy_0_low st_0 st_15 v_25 v_28 v_29 v__sroa_016_0_copyload_tmp v__sroa_4_0_copyload)
          else (
            when v_31, st_16 == ((pack_return_code_spec 9 0 st_15));
            when st_19 == ((granule_unlock_spec (int_to_ptr v__sroa_016_0_copyload_tmp) st_16));
            when st_22 == ((free_stack "smc_data_destroy" st_0 st_19));
            (Some (v_31, st_22))))
        else (
          when v_23, st_12 == ((pack_return_code_spec 8 v__sroa_6_0_copyload st_11));
          when st_14 == ((granule_unlock_spec (int_to_ptr v__sroa_016_0_copyload_tmp) st_12));
          when st_17 == ((free_stack "smc_data_destroy" st_0 st_14));
          (Some (v_23, st_17))))
      else (
        when st_4 == ((granule_unlock_spec v_4 st_3));
        when v_13, st_5 == ((pack_return_code_spec 1 2 st_4));
        when st_8 == ((free_stack "smc_data_destroy" st_0 st_5));
        (Some (v_13, st_8)))).

  Definition smc_rtt_create_spec (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    when st_0 == ((new_frame "smc_rtt_create" st));
    if ((v_1 & (1)) =? (0))
    then (
      when v_22, st_1 == ((find_lock_two_granules_spec v_0 1 (mkPtr "stack_type_4__1" 0) v_1 2 (mkPtr "stack_type_4" 0) st_0));
      if (v_22 =? (3))
      then (
        when v_25, st_2 == ((pack_return_code_spec 3 0 st_1));
        when st_4 == ((free_stack "smc_rtt_create" st_0 st_2));
        (Some (v_25, st_4)))
      else (
        if (v_22 =? (0))
        then (
          when v_33_tmp, st_2 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_1));
          when v_40, st_3 == ((granule_map_spec (int_to_ptr v_33_tmp) 2 st_2));
          when v_42, st_4 == ((validate_rtt_structure_cmds_spec v_2 v_3 v_40 st_3));
          if (v_42 =? (0))
          then (
            when v_47_tmp, st_6 == ((load_RData 8 (ptr_offset v_40 32) st_4));
            when v_48, st_7 == ((realm_rtt_starting_level_spec v_40 st_6));
            when v_49, st_8 == ((realm_ipa_bits_spec v_40 st_7));
            when st_9 == ((llvm_memcpy_p0i8_p0i8_i64_spec (mkPtr "stack_s_realm_s2_context" 0) (ptr_offset v_40 16) 32 false st_8));
            when st_10 == ((granule_lock_spec (int_to_ptr v_47_tmp) 5 st_9));
            when v_51_tmp, st_11 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_10));
            when st_12 == ((granule_unlock_spec (int_to_ptr v_51_tmp) st_11));
            when st_13 == ((rtt_walk_lock_unlock_spec (mkPtr "stack_s_rtt_walk__1" 0) (int_to_ptr v_47_tmp) v_48 v_49 v_2 (v_3 + ((- 1))) st_12));
            rely ((((st_13.(share)).(granule_data)) = (((st_12.(share)).(granule_data)))));
            when v__sroa_053_0_copyload_tmp, st_14 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk__1" 0) 0) st_13));
            when v__sroa_9_0_copyload, st_15 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk__1" 0) 16) st_14));
            if ((v__sroa_9_0_copyload - ((v_3 + ((- 1))))) =? (0))
            then (
              when v__sroa_5_0_copyload, st_16 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk__1" 0) 8) st_15));
              when v_57, st_17 == ((granule_map_spec (int_to_ptr v__sroa_053_0_copyload_tmp) 6 st_16));
              when v_60, st_18 == ((__tte_read_spec (ptr_offset v_57 (8 * (v__sroa_5_0_copyload))) st_17));
              when v_61_tmp, st_19 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_18));
              when v_62, st_20 == ((granule_map_spec (int_to_ptr v_61_tmp) 1 st_19));
              when v_64, st_21 == ((s2tte_is_unassigned_spec v_60 st_20));
              if v_64
              then (smc_rtt_create_4_low st_0 st_21 v_0 v_3 v_57 v_60 v_62 v_64 v__sroa_053_0_copyload_tmp v__sroa_5_0_copyload)
              else (
                when v_68, st_22 == ((s2tte_is_destroyed_spec v_60 st_21));
                if v_68
                then (smc_rtt_create_3_low st_0 st_22 v_0 v_3 v_57 v_62 v_68 v__sroa_053_0_copyload_tmp v__sroa_5_0_copyload)
                else (
                  when v_71, st_23 == ((s2tte_is_assigned_spec v_60 (v_3 + ((- 1))) st_22));
                  if v_71
                  then (smc_rtt_create_2_low st_0 st_23 v_0 v_3 v_57 v_60 v_62 v_71 v__sroa_053_0_copyload_tmp v__sroa_5_0_copyload)
                  else (
                    when v_76, st_24 == ((s2tte_is_valid_spec v_60 (v_3 + ((- 1))) st_23));
                    if v_76
                    then (smc_rtt_create_1_low st_0 st_24 v_0 v_2 v_3 v_57 v_60 v_62 v_76 v__sroa_053_0_copyload_tmp v__sroa_5_0_copyload)
                    else (
                      when v_81, st_25 == ((s2tte_is_valid_ns_spec v_60 (v_3 + ((- 1))) st_24));
                      if v_81
                      then (smc_rtt_create_0_low st_0 st_25 v_0 v_2 v_3 v_57 v_60 v_62 v_81 v__sroa_053_0_copyload_tmp v__sroa_5_0_copyload)
                      else (
                        when v_86, st_26 == ((s2tte_is_table_spec v_60 (v_3 + ((- 1))) st_25));
                        if v_86
                        then (
                          when v_88, st_27 == ((pack_return_code_spec 9 0 st_26));
                          when st_28 == ((granule_unlock_spec (int_to_ptr v__sroa_053_0_copyload_tmp) st_27));
                          when v_94_tmp, st_29 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_28));
                          when st_30 == ((granule_unlock_spec (int_to_ptr v_94_tmp) st_29));
                          when st_32 == ((free_stack "smc_rtt_create" st_0 st_30));
                          (Some (v_88, st_32)))
                        else (
                          when v_90_tmp, st_28 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_26));
                          when st_29 == ((granule_set_state_spec (int_to_ptr v_90_tmp) 5 st_28));
                          when v_91, st_30 == ((s2tte_create_table_spec v_0 (v_3 + ((- 1))) st_29));
                          when st_31 == ((__tte_write_spec (ptr_offset v_57 (8 * (v__sroa_5_0_copyload))) v_91 st_30));
                          when st_32 == ((granule_unlock_spec (int_to_ptr v__sroa_053_0_copyload_tmp) st_31));
                          when v_94_tmp, st_33 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_32));
                          when st_34 == ((granule_unlock_spec (int_to_ptr v_94_tmp) st_33));
                          when st_35 == ((free_stack "smc_rtt_create" st_0 st_34));
                          (Some (0, st_35)))))))))
            else (
              when v_55, st_16 == ((pack_return_code_spec 8 v__sroa_9_0_copyload st_15));
              when st_17 == ((granule_unlock_spec (int_to_ptr v__sroa_053_0_copyload_tmp) st_16));
              when v_94_tmp, st_18 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_17));
              when st_19 == ((granule_unlock_spec (int_to_ptr v_94_tmp) st_18));
              when st_21 == ((free_stack "smc_rtt_create" st_0 st_19));
              (Some (v_55, st_21))))
          else (
            when v_38_tmp, st_5 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_4));
            when st_6 == ((granule_unlock_spec (int_to_ptr v_38_tmp) st_5));
            when v_39_tmp, st_7 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_6));
            when st_8 == ((granule_unlock_spec (int_to_ptr v_39_tmp) st_7));
            when v_46, st_9 == ((pack_return_code_spec v_42 ((v_42 >> (32)) + (3)) st_8));
            when st_11 == ((free_stack "smc_rtt_create" st_0 st_9));
            (Some (v_46, st_11))))
        else (
          when v_30, st_2 == ((pack_return_code_spec 1 ((v_22 >> (32)) + (1)) st_1));
          when st_4 == ((free_stack "smc_rtt_create" st_0 st_2));
          (Some (v_30, st_4)))))
    else (
      when v_12, st_1 == ((find_lock_granule_spec (v_1 & ((- 2))) 3 st_0));
      rely (((((v_12.(poffset)) mod (16)) = (0)) /\ (((v_12.(poffset)) >= (0)))));
      rely ((((v_12.(pbase)) = ("granules")) \/ (((v_12.(pbase)) = ("null")))));
      if (ptr_eqb v_12 (mkPtr "null" 0))
      then (
        when v_14, st_2 == ((pack_return_code_spec 1 2 st_1));
        when st_4 == ((free_stack "smc_rtt_create" st_0 st_2));
        (Some (v_14, st_4)))
      else (
        when v_17, st_2 == ((granule_map_spec v_12 3 st_1));
        when v_19, st_3 == ((rtt_create_s1_el1_spec v_17 v_0 v_2 v_3 st_2));
        when st_4 == ((granule_unlock_spec v_12 st_3));
        when st_6 == ((free_stack "smc_rtt_create" st_0 st_4));
        (Some (((v_19 << (32)) >> (32)), st_6)))).

  Definition smc_rtt_map_protected_spec (v_0: Z) (v_1: Z) (v_2: Z) (st: RData) : (option (Z * RData)) :=
    when st_0 == ((new_frame "smc_rtt_map_protected" st));
    when v_5, st_1 == ((find_lock_granule_spec v_0 2 st_0));
    rely (((((v_5.(poffset)) mod (16)) = (0)) /\ (((v_5.(poffset)) >= (0)))));
    rely ((((v_5.(pbase)) = ("granules")) \/ (((v_5.(pbase)) = ("null")))));
    if (ptr_eqb v_5 (mkPtr "null" 0))
    then (
      when v_7, st_2 == ((pack_return_code_spec 1 1 st_1));
      when st_4 == ((free_stack "smc_rtt_map_protected" st_0 st_2));
      (Some (v_7, st_4)))
    else (
      when v_9, st_2 == ((granule_map_spec v_5 2 st_1));
      when v_11, st_3 == ((validate_rtt_map_cmds_spec v_1 v_2 v_9 st_2));
      if (v_11 =? (0))
      then (
        when v_19_tmp, st_4 == ((load_RData 8 (ptr_offset v_9 32) st_3));
        when v_20, st_5 == ((realm_rtt_starting_level_spec v_9 st_4));
        when v_21, st_6 == ((realm_ipa_bits_spec v_9 st_5));
        when st_7 == ((granule_lock_spec (int_to_ptr v_19_tmp) 5 st_6));
        when st_8 == ((granule_unlock_spec v_5 st_7));
        when st_9 == ((rtt_walk_lock_unlock_spec (mkPtr "stack_s_rtt_walk" 0) (int_to_ptr v_19_tmp) v_20 v_21 v_1 v_2 st_8));
        rely ((((st_9.(share)).(granule_data)) = (((st_8.(share)).(granule_data)))));
        when v__sroa_018_0_copyload_tmp, st_10 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 0) st_9));
        when v__sroa_5_0_copyload, st_11 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 16) st_10));
        if ((v__sroa_5_0_copyload - (v_2)) =? (0))
        then (
          when v__sroa_320_0_copyload, st_12 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 8) st_11));
          when v_26, st_13 == ((granule_map_spec (int_to_ptr v__sroa_018_0_copyload_tmp) 6 st_12));
          when v_29, st_14 == ((__tte_read_spec (ptr_offset v_26 (8 * (v__sroa_320_0_copyload))) st_13));
          when v_30, st_15 == ((s2tte_is_assigned_spec v_29 v_2 st_14));
          if v_30
          then (smc_rtt_map_protected_0_low st_0 st_15 v_2 v_26 v_29 v_30 v__sroa_018_0_copyload_tmp v__sroa_320_0_copyload)
          else (
            when v_32, st_16 == ((pack_return_code_spec 9 0 st_15));
            when st_19 == ((granule_unlock_spec (int_to_ptr v__sroa_018_0_copyload_tmp) st_16));
            when st_18 == ((free_stack "smc_rtt_map_protected" st_0 st_19));
            (Some (v_32, st_18))))
        else (
          when v_24, st_12 == ((pack_return_code_spec 8 v__sroa_5_0_copyload st_11));
          when st_14 == ((granule_unlock_spec (int_to_ptr v__sroa_018_0_copyload_tmp) st_12));
          when st_15 == ((free_stack "smc_rtt_map_protected" st_0 st_14));
          (Some (v_24, st_15))))
      else (
        when st_4 == ((granule_unlock_spec v_5 st_3));
        when v_14, st_5 == ((pack_return_code_spec v_11 ((v_11 >> (32)) + (2)) st_4));
        when st_7 == ((free_stack "smc_rtt_map_protected" st_0 st_5));
        (Some (v_14, st_7)))).

  Definition s2tte_addr_type_mask_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    if ((v_0 & (3)) =? (0))
    then (Some (0, st))
    else (
      when v_7, st_0 == ((s2tte_pa_spec v_0 v_1 st));
      (Some ((v_7 |' ((v_0 & (3)))), st_0))).

  Definition data_granule_measure_spec (v_0: Ptr) (v_1: Ptr) (v_2: Z) (v_3: Z) (st: RData) : (option RData) :=
    when st_0 == ((new_frame "data_granule_measure" st));
    when st_1 == ((store_RData 8 (ptr_offset (mkPtr "stack_type_7" 0) 0) 4 st_0));
    when st_2 == ((store_RData 8 (ptr_offset (mkPtr "stack_type_7" 0) 8) v_2 st_1));
    when st_3 == ((store_RData 8 (ptr_offset (mkPtr "stack_type_7" 0) 16) 0 st_2));
    when st_4 == ((free_stack "data_granule_measure" st_0 st_3));
    (Some st_4).

  Definition smc_rtt_read_entry_spec (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Ptr) (st: RData) : (option RData) :=
    when st_0 == ((new_frame "smc_rtt_read_entry" st));
    when v_6, st_1 == ((find_lock_granule_spec v_0 2 st_0));
    rely (((((v_6.(poffset)) mod (16)) = (0)) /\ (((v_6.(poffset)) >= (0)))));
    rely ((((v_6.(pbase)) = ("granules")) \/ (((v_6.(pbase)) = ("null")))));
    if (ptr_eqb v_6 (mkPtr "null" 0))
    then (
      when v_8, st_2 == ((pack_return_code_spec 1 1 st_1));
      when st_3 == ((store_RData 8 (ptr_offset v_3 0) v_8 st_2));
      when st_5 == ((free_stack "smc_rtt_read_entry" st_0 st_3));
      (Some st_5))
    else (
      when v_12, st_2 == ((granule_map_spec v_6 2 st_1));
      when v_14, st_3 == ((validate_rtt_entry_cmds_spec v_1 v_2 v_12 st_2));
      if (v_14 =? (0))
      then (
        when v_23_tmp, st_4 == ((load_RData 8 (ptr_offset v_12 32) st_3));
        when v_24, st_5 == ((realm_rtt_starting_level_spec v_12 st_4));
        when v_25, st_6 == ((realm_ipa_bits_spec v_12 st_5));
        when st_7 == ((granule_lock_spec (int_to_ptr v_23_tmp) 5 st_6));
        when st_8 == ((granule_unlock_spec v_6 st_7));
        when st_9 == ((rtt_walk_lock_unlock_spec (mkPtr "stack_s_rtt_walk" 0) (int_to_ptr v_23_tmp) v_24 v_25 v_1 v_2 st_8));
        rely ((((st_9.(share)).(granule_data)) = (((st_8.(share)).(granule_data)))));
        when v__sroa_017_0_copyload_tmp, st_10 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 0) st_9));
        when v__sroa_319_0_copyload, st_11 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 8) st_10));
        when v__sroa_4_0_copyload, st_12 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 16) st_11));
        when v_26, st_13 == ((granule_map_spec (int_to_ptr v__sroa_017_0_copyload_tmp) 6 st_12));
        when v_29, st_14 == ((__tte_read_spec (ptr_offset v_26 (8 * (v__sroa_319_0_copyload))) st_13));
        when st_15 == ((store_RData 8 (ptr_offset v_3 8) v__sroa_4_0_copyload st_14));
        when st_16 == ((store_RData 8 (ptr_offset v_3 24) 0 st_15));
        when v_32, st_17 == ((s2tte_is_unassigned_spec v_29 st_16));
        if v_32
        then (
          when st_18 == ((store_RData 8 (ptr_offset v_3 16) 0 st_17));
          when st_20 == ((granule_unlock_spec (int_to_ptr v__sroa_017_0_copyload_tmp) st_18));
          when st_21 == ((store_RData 8 (ptr_offset v_3 0) 0 st_20));
          when st_24 == ((free_stack "smc_rtt_read_entry" st_0 st_21));
          (Some st_24))
        else (
          when v_36, st_18 == ((s2tte_is_destroyed_spec v_29 st_17));
          if v_36
          then (
            when st_19 == ((store_RData 8 (ptr_offset v_3 16) 1 st_18));
            when st_22 == ((granule_unlock_spec (int_to_ptr v__sroa_017_0_copyload_tmp) st_19));
            when st_23 == ((store_RData 8 (ptr_offset v_3 0) 0 st_22));
            when st_26 == ((free_stack "smc_rtt_read_entry" st_0 st_23));
            (Some st_26))
          else (
            when v_40, st_19 == ((s2tte_is_assigned_spec v_29 v__sroa_4_0_copyload st_18));
            if v_40
            then (smc_rtt_read_entry_3_low st_0 st_19 v_29 v_3 v_40 v__sroa_017_0_copyload_tmp v__sroa_4_0_copyload)
            else (
              when v_45, st_20 == ((s2tte_is_valid_spec v_29 v__sroa_4_0_copyload st_19));
              if v_45
              then (smc_rtt_read_entry_2_low st_0 st_20 v_29 v_3 v_45 v__sroa_017_0_copyload_tmp v__sroa_4_0_copyload)
              else (
                when v_50, st_21 == ((s2tte_is_valid_ns_spec v_29 v__sroa_4_0_copyload st_20));
                if v_50
                then (smc_rtt_read_entry_1_low st_0 st_21 v_29 v_3 v_50 v__sroa_017_0_copyload_tmp v__sroa_4_0_copyload)
                else (
                  when v_55, st_22 == ((s2tte_is_table_spec v_29 v__sroa_4_0_copyload st_21));
                  if v_55
                  then (smc_rtt_read_entry_0_low st_0 st_22 v_29 v_3 v_55 v__sroa_017_0_copyload_tmp v__sroa_4_0_copyload)
                  else (
                    when st_29 == ((granule_unlock_spec (int_to_ptr v__sroa_017_0_copyload_tmp) st_22));
                    when st_30 == ((store_RData 8 (ptr_offset v_3 0) 0 st_29));
                    when st_33 == ((free_stack "smc_rtt_read_entry" st_0 st_30));
                    (Some st_33))))))))
      else (
        when st_4 == ((granule_unlock_spec v_6 st_3));
        when v_17, st_5 == ((pack_return_code_spec v_14 ((v_14 >> (32)) + (2)) st_4));
        when st_6 == ((store_RData 8 (ptr_offset v_3 0) v_17 st_5));
        when st_9 == ((free_stack "smc_rtt_read_entry" st_0 st_6));
        (Some st_9))).

  Definition smc_rtt_unmap_protected_spec (v_0: Z) (v_1: Z) (v_2: Z) (st: RData) : (option (Z * RData)) :=
    when st_0 == ((new_frame "smc_rtt_unmap_protected" st));
    when v_6, st_1 == ((find_lock_granule_spec v_0 2 st_0));
    rely (((((v_6.(poffset)) mod (16)) = (0)) /\ (((v_6.(poffset)) >= (0)))));
    rely ((((v_6.(pbase)) = ("granules")) \/ (((v_6.(pbase)) = ("null")))));
    if (ptr_eqb v_6 (mkPtr "null" 0))
    then (
      when v_8, st_2 == ((pack_return_code_spec 1 1 st_1));
      when st_4 == ((free_stack "smc_rtt_unmap_protected" st_0 st_2));
      (Some (v_8, st_4)))
    else (
      when v_10, st_2 == ((granule_map_spec v_6 2 st_1));
      when v_12, st_3 == ((validate_rtt_map_cmds_spec v_1 v_2 v_10 st_2));
      if (v_12 =? (0))
      then (
        when v_21_tmp, st_4 == ((load_RData 8 (ptr_offset v_10 32) st_3));
        when v_22, st_5 == ((realm_rtt_starting_level_spec v_10 st_4));
        when v_23, st_6 == ((realm_ipa_bits_spec v_10 st_5));
        when st_7 == ((llvm_memcpy_p0i8_p0i8_i64_spec (mkPtr "stack_s_realm_s2_context" 0) (ptr_offset v_10 16) 32 false st_6));
        when st_8 == ((granule_lock_spec (int_to_ptr v_21_tmp) 5 st_7));
        when st_9 == ((granule_unlock_spec v_6 st_8));
        when st_10 == ((rtt_walk_lock_unlock_spec (mkPtr "stack_s_rtt_walk" 0) (int_to_ptr v_21_tmp) v_22 v_23 v_1 v_2 st_9));
        rely ((((st_10.(share)).(granule_data)) = (((st_9.(share)).(granule_data)))));
        when v__sroa_017_0_copyload_tmp, st_11 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 0) st_10));
        when v__sroa_5_0_copyload, st_12 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 16) st_11));
        if ((v__sroa_5_0_copyload - (v_2)) =? (0))
        then (
          when v__sroa_319_0_copyload, st_13 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 8) st_12));
          when v_29, st_14 == ((granule_map_spec (int_to_ptr v__sroa_017_0_copyload_tmp) 6 st_13));
          when v_32, st_15 == ((__tte_read_spec (ptr_offset v_29 (8 * (v__sroa_319_0_copyload))) st_14));
          when v_33, st_16 == ((s2tte_is_valid_spec v_32 v_2 st_15));
          if v_33
          then (
            when v_37, st_17 == ((s2tte_pa_spec v_32 v_2 st_16));
            when v_38, st_18 == ((s2tte_create_assigned_spec v_37 v_2 st_17));
            when st_19 == ((__tte_write_spec (ptr_offset v_29 (8 * (v__sroa_319_0_copyload))) v_38 st_18));
            if (v_2 =? (3))
            then (
              when st_20 == ((invalidate_page_spec (mkPtr "stack_s_realm_s2_context" 0) v_1 st_19));
              when st_24 == ((granule_unlock_spec (int_to_ptr v__sroa_017_0_copyload_tmp) st_20));
              when st_22 == ((free_stack "smc_rtt_unmap_protected" st_0 st_24));
              (Some (0, st_22)))
            else (
              when st_20 == ((invalidate_block_spec (mkPtr "stack_s_realm_s2_context" 0) v_1 st_19));
              when st_24 == ((granule_unlock_spec (int_to_ptr v__sroa_017_0_copyload_tmp) st_20));
              when st_22 == ((free_stack "smc_rtt_unmap_protected" st_0 st_24));
              (Some (0, st_22))))
          else (
            when v_35, st_17 == ((pack_return_code_spec 9 0 st_16));
            when st_20 == ((granule_unlock_spec (int_to_ptr v__sroa_017_0_copyload_tmp) st_17));
            when st_19 == ((free_stack "smc_rtt_unmap_protected" st_0 st_20));
            (Some (v_35, st_19))))
        else (
          when v_27, st_13 == ((pack_return_code_spec 8 v__sroa_5_0_copyload st_12));
          when st_15 == ((granule_unlock_spec (int_to_ptr v__sroa_017_0_copyload_tmp) st_13));
          when st_16 == ((free_stack "smc_rtt_unmap_protected" st_0 st_15));
          (Some (v_27, st_16))))
      else (
        when st_4 == ((granule_unlock_spec v_6 st_3));
        when v_15, st_5 == ((pack_return_code_spec v_12 ((v_12 >> (32)) + (2)) st_4));
        when st_7 == ((free_stack "smc_rtt_unmap_protected" st_0 st_5));
        (Some (v_15, st_7)))). 
  *)

	Definition smc_rtt_create_spec (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
		if ((v_1 & (1)) =? (0))
		then (
			when v_22, st_1 == ((find_lock_two_granules_spec v_0 1 (mkPtr "stack_type_4__1" 0) v_1 2 (mkPtr "stack_type_4" 0) st));
			if (v_22 =? (3))
			then (Some (3, st_1))
			else (
				if (v_22 =? (0))
				then (
					rely (((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
					rely ((((((st_1.(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0)) = (false)));
					rely ((((((st_1.(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0)) = (false)));
					rely ((((((st_1.(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0)) = (false)));
					rely (
						((((("granules" = ("granules")) /\ (((((st_1.(stack)).(stack_type_4)) mod (16)) = (0)))) /\ (((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)))) /\
							((2 >= (0)))) /\
							((2 <= (24)))));
					when ret == ((granule_addr_spec' (mkPtr "granules" (((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)))));
					when ret_0 == ((buffer_map_spec' 2 ret false));
					rely ((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))));
					rely (((((ret_0.(pbase)) = ("granule_data")) /\ ((((ret_0.(poffset)) mod (4096)) = (0)))) /\ (((ret_0.(poffset)) >= (0)))));
					rely (((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
					when ret_1, st' == ((validate_rtt_structure_cmds_spec' v_2 v_3 ret_0 st_1));
					if (ret_1 =? (0))
					then (
						if (((((ret_0.(poffset)) + (32)) mod (4096)) - (16)) =? (16))
						then (
							rely (((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)));
							rely (((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (MEM0_VIRT)) < (0)));
							when ret_2, st'_0 == ((realm_rtt_starting_level_spec' ret_0 st_1));
							when ret_3, st'_1 == ((realm_ipa_bits_spec' ret_0 st_1));
							when sh == (((st_1.(repl)) ((st_1.(oracle)) (st_1.(log))) (st_1.(share))));
							match ((((((sh.(globals)).(g_granules)) @ ((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val))) with
							| None =>
								rely (
									(((((((st_1.(share)).(globals)).(g_granules)) @ ((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
										(((((sh.(globals)).(g_granules)) @ ((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)))) =
										(0)));
								rely (
									((("granules" = ("granules")) /\ (((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) mod (16)) = (0)))) /\
										(((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)))));
								if (
									((((((sh.(globals)).(g_granules)) @ ((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
										(5)) =?
										(0)))
								then (
									when cid == (
											((((((sh.(globals)).(g_granules)) #
												((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
												((((sh.(globals)).(g_granules)) @ ((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
													(Some CPU_ID))) @ ((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
									when st_13 == (
											(rtt_walk_lock_unlock_spec
												(mkPtr "stack_s_rtt_walk__1" 0)
												(mkPtr "granules" (((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
												ret_2
												ret_3
												v_2
												(v_3 + ((- 1)))
												(lens 330 st_1)));
									rely ((((st_13.(share)).(granule_data)) = ((sh.(granule_data)))));
									rely ((((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
									rely ((((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
									if (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_last_level)) - ((v_3 + ((- 1))))) =? (0))
									then (
										rely (
											((((("granules" = ("granules")) /\ ((((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) mod (16)) = (0)))) /\
												((((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
												((6 >= (0)))) /\
												((6 <= (24)))));
										when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)))));
										when ret_5 == ((buffer_map_spec' 6 ret_4 false));
										rely ((((ret_5.(pbase)) = ("granule_data")) /\ (((ret_5.(poffset)) >= (0)))));
										when v_60, st_18 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk))))))) st_13));
										rely ((((st_18.(share)).(granule_data)) = (((st_13.(share)).(granule_data)))));
										rely (((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
										rely ((((((st_18.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0)) = (false)));
										rely ((((((st_18.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0)) = (false)));
										rely ((((((st_18.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0)) = (false)));
										rely (
											((((("granules" = ("granules")) /\ (((((st_18.(stack)).(stack_type_4__1)) mod (16)) = (0)))) /\ (((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)))) /\
												((1 >= (0)))) /\
												((1 <= (24)))));
										when ret_6 == ((granule_addr_spec' (mkPtr "granules" (((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)))));
										when ret_7 == ((buffer_map_spec' 1 ret_6 false));
										rely ((((ret_7.(pbase)) = ("granule_data")) /\ (((ret_7.(poffset)) >= (0)))));
										if ((v_60 & (63)) =? (0))
										then (
											when ret_8 == ((s2tte_get_ripas_spec' v_60));
											when ret_9 == ((s2tte_create_ripas_spec' ret_8));
											match (
												match ((s2tt_init_unassigned_loop759_0 (z_to_nat 0) false ret_7 ret_9 0 st_18)) with
												| (Some (__break__, v_7, v_6, v_index_0, st_2)) => (Some (true, 0, st_2))
												| None => None
												end
											) with
											| (Some (__return__, v_bc_resume_val, st_2)) =>
												if __return__
												then (
													rely (((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
													rely ((((((st_2.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0)) = (false)));
													rely ((((((st_2.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0)) = (false)));
													rely ((((((st_2.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0)) = (false)));
													rely (
														((((("granules" = ("granules")) /\ (((((st_2.(stack)).(stack_type_4__1)) mod (16)) = (0)))) /\ (((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)))) /\
															((5 >= (0)))) /\
															((5 <= (6)))));
													rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) >= (0)))));
													when cid_0 == (
															((((((((st_2.(share)).(globals)).(g_granules)) #
																(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																	((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																		(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																((((((st_2.(share)).(globals)).(g_granules)) #
																	(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																		((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																			(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																	5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
													when cid_1 == (
															(((((((((st_2.(share)).(globals)).(g_granules)) #
																(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																	((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																		(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																((((((st_2.(share)).(globals)).(g_granules)) #
																	(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																		((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																			(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																	5)) #
																(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																(((((((st_2.(share)).(globals)).(g_granules)) #
																	(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																		((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																			(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																	((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																	((((((st_2.(share)).(globals)).(g_granules)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																		5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																	None)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
													(Some (
														0  ,
														((lens 332 st_2).[share].[globals].[g_granules] :<
															(((((((st_2.(share)).(globals)).(g_granules)) #
																(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																	((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																		(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																((((((st_2.(share)).(globals)).(g_granules)) #
																	(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																		((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																			(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																	5)) #
																(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																(((((((st_2.(share)).(globals)).(g_granules)) #
																	(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																		((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																			(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																	((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																	((((((st_2.(share)).(globals)).(g_granules)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																		5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																	None)) #
																((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																((((((((st_2.(share)).(globals)).(g_granules)) #
																	(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																		((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																			(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																	((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																	((((((st_2.(share)).(globals)).(g_granules)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																		5)) #
																	(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((((st_2.(share)).(globals)).(g_granules)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																		((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																		((((((st_2.(share)).(globals)).(g_granules)) #
																			(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																			(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																				((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																					(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																			5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																		None)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																	None)))
													)))
												else (
													match ((s2tt_init_unassigned_loop759 (z_to_nat 0) false ret_7 ret_9 v_bc_resume_val st_2)) with
													| (Some (__break__, v_7, v_6, v_indvars_iv_0, st_3)) =>
														rely (((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
														rely ((((((st_3.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0)) = (false)));
														rely ((((((st_3.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0)) = (false)));
														rely ((((((st_3.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0)) = (false)));
														rely (
															((((("granules" = ("granules")) /\ (((((st_3.(stack)).(stack_type_4__1)) mod (16)) = (0)))) /\ (((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)))) /\
																((5 >= (0)))) /\
																((5 <= (6)))));
														rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) >= (0)))));
														when cid_0 == (
																((((((((st_3.(share)).(globals)).(g_granules)) #
																	(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																		((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																			(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																	((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																	((((((st_3.(share)).(globals)).(g_granules)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																		5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
														when cid_1 == (
																(((((((((st_3.(share)).(globals)).(g_granules)) #
																	(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																		((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																			(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																	((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																	((((((st_3.(share)).(globals)).(g_granules)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																		5)) #
																	(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((((st_3.(share)).(globals)).(g_granules)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																		((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																		((((((st_3.(share)).(globals)).(g_granules)) #
																			(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																			(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																				((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																					(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																			5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																		None)) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
														(Some (
															0  ,
															((lens 334 st_3).[share].[globals].[g_granules] :<
																(((((((st_3.(share)).(globals)).(g_granules)) #
																	(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																		((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																			(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																	((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																	((((((st_3.(share)).(globals)).(g_granules)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																		5)) #
																	(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((((st_3.(share)).(globals)).(g_granules)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																		((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																		((((((st_3.(share)).(globals)).(g_granules)) #
																			(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																			(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																				((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																					(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																			5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																		None)) #
																	((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																	((((((((st_3.(share)).(globals)).(g_granules)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																		((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																		((((((st_3.(share)).(globals)).(g_granules)) #
																			(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																			(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																				((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																					(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																			5)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((((st_3.(share)).(globals)).(g_granules)) #
																			(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																			(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																				((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																					(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																			((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																			((((((st_3.(share)).(globals)).(g_granules)) #
																				(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																				(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																					((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																						(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																				5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																			None)) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																		None)))
														))
													| None => None
													end)
											| None => None
											end)
										else (
											if ((v_60 & (63)) =? (8))
											then (
												rely (((((((st_18.(share)).(granule_data)) @ ((ret_7.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_DATA)) = (0)));
												match (
													match ((s2tt_init_destroyed_loop776_0 (z_to_nat 0) false ret_7 0 st_18)) with
													| (Some (__break__, v_5, v_index_0, st_2)) => (Some (true, 0, st_2))
													| None => None
													end
												) with
												| (Some (__return__, v_bc_resume_val, st_2)) =>
													if __return__
													then (
														rely (((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
														rely ((((((st_2.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0)) = (false)));
														rely ((((((st_2.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0)) = (false)));
														rely ((((((st_2.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0)) = (false)));
														rely (
															((((("granules" = ("granules")) /\ (((((st_2.(stack)).(stack_type_4__1)) mod (16)) = (0)))) /\ (((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)))) /\
																((5 >= (0)))) /\
																((5 <= (6)))));
														rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) >= (0)))));
														when cid_0 == (
																((((((((st_2.(share)).(globals)).(g_granules)) #
																	(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																		((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																			(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																	((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																	((((((st_2.(share)).(globals)).(g_granules)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																		5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
														when cid_1 == (
																(((((((((st_2.(share)).(globals)).(g_granules)) #
																	(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																		((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																			(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																	((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																	((((((st_2.(share)).(globals)).(g_granules)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																		5)) #
																	(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((((st_2.(share)).(globals)).(g_granules)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																		((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																		((((((st_2.(share)).(globals)).(g_granules)) #
																			(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																			(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																				((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																					(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																			5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																		None)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
														(Some (
															0  ,
															((lens 336 st_2).[share].[globals].[g_granules] :<
																(((((((st_2.(share)).(globals)).(g_granules)) #
																	(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																		((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																			(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																	((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																	((((((st_2.(share)).(globals)).(g_granules)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																		5)) #
																	(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((((st_2.(share)).(globals)).(g_granules)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																		((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																		((((((st_2.(share)).(globals)).(g_granules)) #
																			(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																			(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																				((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																					(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																			5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																		None)) #
																	((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																	((((((((st_2.(share)).(globals)).(g_granules)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																		((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																		((((((st_2.(share)).(globals)).(g_granules)) #
																			(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																			(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																				((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																					(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																			5)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((((st_2.(share)).(globals)).(g_granules)) #
																			(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																			(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																				((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																					(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																			((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																			((((((st_2.(share)).(globals)).(g_granules)) #
																				(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																				(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																					((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																						(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																				5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																			None)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																		None)))
														)))
													else (
														match ((s2tt_init_destroyed_loop776 (z_to_nat 0) false ret_7 v_bc_resume_val st_2)) with
														| (Some (__break__, v_5, v_indvars_iv_0, st_3)) =>
															rely (((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
															rely ((((((st_3.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0)) = (false)));
															rely ((((((st_3.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0)) = (false)));
															rely ((((((st_3.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0)) = (false)));
															rely (
																((((("granules" = ("granules")) /\ (((((st_3.(stack)).(stack_type_4__1)) mod (16)) = (0)))) /\ (((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)))) /\
																	((5 >= (0)))) /\
																	((5 <= (6)))));
															rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) >= (0)))));
															when cid_0 == (
																	((((((((st_3.(share)).(globals)).(g_granules)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																		((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																		((((((st_3.(share)).(globals)).(g_granules)) #
																			(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																			(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																				((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																					(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																			5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
															when cid_1 == (
																	(((((((((st_3.(share)).(globals)).(g_granules)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																		((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																		((((((st_3.(share)).(globals)).(g_granules)) #
																			(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																			(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																				((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																					(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																			5)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((((st_3.(share)).(globals)).(g_granules)) #
																			(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																			(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																				((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																					(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																			((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																			((((((st_3.(share)).(globals)).(g_granules)) #
																				(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																				(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																					((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																						(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																				5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																			None)) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
															(Some (
																0  ,
																((lens 338 st_3).[share].[globals].[g_granules] :<
																	(((((((st_3.(share)).(globals)).(g_granules)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																		((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																		((((((st_3.(share)).(globals)).(g_granules)) #
																			(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																			(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																				((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																					(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																			5)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((((st_3.(share)).(globals)).(g_granules)) #
																			(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																			(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																				((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																					(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																			((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																			((((((st_3.(share)).(globals)).(g_granules)) #
																				(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																				(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																					((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																						(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																				5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																			None)) #
																		((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																		((((((((st_3.(share)).(globals)).(g_granules)) #
																			(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																			(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																				((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																					(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																			((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																			((((((st_3.(share)).(globals)).(g_granules)) #
																				(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																				(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																					((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																						(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																				5)) #
																			(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																			(((((((st_3.(share)).(globals)).(g_granules)) #
																				(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																				(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																					((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																						(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																				((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																				((((((st_3.(share)).(globals)).(g_granules)) #
																					(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																					(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																						((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																							(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																					5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																				None)) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																			None)))
															))
														| None => None
														end)
												| None => None
												end)
											else (
												if ((v_60 & (63)) =? (4))
												then (
													when ret_8 == ((s2tte_pa_spec' v_60 (v_3 + ((- 1)))));
													rely (((((((st_18.(share)).(granule_data)) @ ((ret_7.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_DATA)) = (0)));
													match ((s2tt_init_assigned_loop801 (z_to_nat 512) false ret_7 v_3 (1 << ((39 + (((- 9) * (v_3)))))) ret_8 0 st_18)) with
													| (Some (__return__, v_7, v_9, v_8, v__11, v_indvars_iv_0, st_2)) =>
														rely (((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
														rely ((((((st_2.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0)) = (false)));
														rely ((((((st_2.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0)) = (false)));
														rely ((((((st_2.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0)) = (false)));
														rely (((("granules" = ("granules")) /\ (((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)))) /\ (((((st_2.(stack)).(stack_type_4__1)) mod (16)) = (0)))));
														rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) >= (0)))));
														when cid_0 == (
																(((((((st_2.(share)).(globals)).(g_granules)) #
																	((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																	((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																		((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																			(((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
																		5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
														when cid_1 == (
																((((((((st_2.(share)).(globals)).(g_granules)) #
																	((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																	((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																		((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																			(((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
																		5)) #
																	(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	((((((st_2.(share)).(globals)).(g_granules)) #
																		((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																		((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
																			5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																		None)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
														(Some (
															0  ,
															((lens 340 st_2).[share].[globals].[g_granules] :<
																((((((st_2.(share)).(globals)).(g_granules)) #
																	((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																	((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																		((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																			(((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
																		5)) #
																	(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	((((((st_2.(share)).(globals)).(g_granules)) #
																		((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																		((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
																			5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																		None)) #
																	((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																	(((((((st_2.(share)).(globals)).(g_granules)) #
																		((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																		((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
																			5)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		((((((st_2.(share)).(globals)).(g_granules)) #
																			((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																			((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																				((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																					(((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
																				5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																			None)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																		None)))
														))
													| None => None
													end)
												else (
													when ret_8 == ((s2tte_is_valid_spec' v_60 (v_3 + ((- 1)))));
													if ret_8
													then (
														rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) >= (0)))));
														when ret_9 == ((s2tte_pa_spec' v_60 (v_3 + ((- 1)))));
														rely (
															(((((((st_18.(share)).(granule_data)) #
																(((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096)) ==
																((((st_18.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
																	(((((st_18.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
																		(((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) mod (4096)) ==
																		0))) @ ((ret_7.(poffset)) / (4096))).(g_granule_state)) -
																(GRANULE_STATE_DATA)) =
																(0)));
														match ((s2tt_init_valid_loop820 (z_to_nat 512) false ret_7 v_3 (1 << ((39 + (((- 9) * (v_3)))))) ret_9 0 (lens 281 st_18))) with
														| (Some (__return__, v_7, v_9, v_8, v__11, v_indvars_iv_0, st_2)) =>
															rely (((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
															rely ((((((st_2.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0)) = (false)));
															rely ((((((st_2.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0)) = (false)));
															rely ((((((st_2.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0)) = (false)));
															rely (((("granules" = ("granules")) /\ (((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)))) /\ (((((st_2.(stack)).(stack_type_4__1)) mod (16)) = (0)))));
															when cid_0 == (
																	(((((((st_2.(share)).(globals)).(g_granules)) #
																		((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																		((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
																			5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
															when cid_1 == (
																	((((((((st_2.(share)).(globals)).(g_granules)) #
																		((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																		((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
																			5)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		((((((st_2.(share)).(globals)).(g_granules)) #
																			((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																			((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																				((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																					(((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
																				5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																			None)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
															(Some (
																0  ,
																((lens 342 st_2).[share].[globals].[g_granules] :<
																	((((((st_2.(share)).(globals)).(g_granules)) #
																		((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																		((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
																			5)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		((((((st_2.(share)).(globals)).(g_granules)) #
																			((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																			((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																				((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																					(((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
																				5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																			None)) #
																		((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																		(((((((st_2.(share)).(globals)).(g_granules)) #
																			((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																			((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																				((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																					(((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
																				5)) #
																			(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																			((((((st_2.(share)).(globals)).(g_granules)) #
																				((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																				((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																					((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																						(((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
																					5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																				None)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																			None)))
															))
														| None => None
														end)
													else (
														when ret_9 == ((s2tte_is_valid_ns_spec' v_60 (v_3 + ((- 1)))));
														if ret_9
														then (
															rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) >= (0)))));
															when ret_10 == ((s2tte_pa_spec' v_60 (v_3 + ((- 1)))));
															rely (
																(((((((st_18.(share)).(granule_data)) #
																	(((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096)) ==
																	((((st_18.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
																		(((((st_18.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
																			(((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) mod (4096)) ==
																			0))) @ ((ret_7.(poffset)) / (4096))).(g_granule_state)) -
																	(GRANULE_STATE_DATA)) =
																	(0)));
															match ((s2tt_init_valid_ns_loop839 (z_to_nat 512) false ret_7 v_3 (1 << ((39 + (((- 9) * (v_3)))))) ret_10 0 (lens 284 st_18))) with
															| (Some (__return__, v_7, v_9, v_8, v__11, v_indvars_iv_0, st_2)) =>
																rely (((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
																rely ((((((st_2.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0)) = (false)));
																rely ((((((st_2.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0)) = (false)));
																rely ((((((st_2.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0)) = (false)));
																rely (((("granules" = ("granules")) /\ (((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)))) /\ (((((st_2.(stack)).(stack_type_4__1)) mod (16)) = (0)))));
																when cid_0 == (
																		(((((((st_2.(share)).(globals)).(g_granules)) #
																			((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																			((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																				((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																					(((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
																				5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
																when cid_1 == (
																		((((((((st_2.(share)).(globals)).(g_granules)) #
																			((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																			((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																				((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																					(((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
																				5)) #
																			(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																			((((((st_2.(share)).(globals)).(g_granules)) #
																				((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																				((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																					((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																						(((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
																					5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																				None)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
																(Some (
																	0  ,
																	((lens 344 st_2).[share].[globals].[g_granules] :<
																		((((((st_2.(share)).(globals)).(g_granules)) #
																			((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																			((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																				((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																					(((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
																				5)) #
																			(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																			((((((st_2.(share)).(globals)).(g_granules)) #
																				((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																				((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																					((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																						(((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
																					5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																				None)) #
																			((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																			(((((((st_2.(share)).(globals)).(g_granules)) #
																				((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																				((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																					((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																						(((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
																					5)) #
																				(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																				((((((st_2.(share)).(globals)).(g_granules)) #
																					((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																					((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																						((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																							(((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
																						5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																					None)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																				None)))
																))
															| None => None
															end)
														else (
															if (((v_3 + ((- 1))) <? (3)) && (((v_60 & (3)) =? (3))))
															then (
																when cid_0 == (((((((st_18.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
																when cid_1 == (
																		(((((((st_18.(share)).(globals)).(g_granules)) #
																			(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																			(((((st_18.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
																(Some (
																	9  ,
																	((lens 287 st_18).[share].[globals].[g_granules] :<
																		(((((st_18.(share)).(globals)).(g_granules)) #
																			(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																			(((((st_18.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) #
																			((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																			((((((st_18.(share)).(globals)).(g_granules)) #
																				(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																				(((((st_18.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																				None)))
																)))
															else (
																rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) >= (0)))));
																when cid_0 == (
																		(((((((st_18.(share)).(globals)).(g_granules)) #
																			((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																			(((((st_18.(share)).(globals)).(g_granules)) @ ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :< 5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
																when cid_1 == (
																		((((((((st_18.(share)).(globals)).(g_granules)) #
																			((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																			(((((st_18.(share)).(globals)).(g_granules)) @ ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :< 5)) #
																			(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																			((((((st_18.(share)).(globals)).(g_granules)) #
																				((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																				(((((st_18.(share)).(globals)).(g_granules)) @ ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :< 5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																				None)) @ ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
																(Some (
																	0  ,
																	((lens 346 st_18).[share].[globals].[g_granules] :<
																		((((((st_18.(share)).(globals)).(g_granules)) #
																			((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																			(((((st_18.(share)).(globals)).(g_granules)) @ ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :< 5)) #
																			(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																			((((((st_18.(share)).(globals)).(g_granules)) #
																				((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																				(((((st_18.(share)).(globals)).(g_granules)) @ ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :< 5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																				None)) #
																			((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																			(((((((st_18.(share)).(globals)).(g_granules)) #
																				((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																				(((((st_18.(share)).(globals)).(g_granules)) @ ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :< 5)) #
																				(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																				((((((st_18.(share)).(globals)).(g_granules)) #
																					((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																					(((((st_18.(share)).(globals)).(g_granules)) @ ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :< 5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																					None)) @ ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																				None)))
																)))))))))
									else (
										when cid_0 == (((((((st_13.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
										rely (((((st_13.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
										if ((((st_13.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0))
										then None
										else (
											if ((((st_13.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0))
											then None
											else (
												if ((((st_13.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0))
												then None
												else (
													when cid_1 == (
															(((((((st_13.(share)).(globals)).(g_granules)) #
																(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																(((((st_13.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_13.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
													(Some (
														((((((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
															((((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_last_level)) << (32)) + (8))))  ,
														((lens 290 st_13).[share].[globals].[g_granules] :<
															(((((st_13.(share)).(globals)).(g_granules)) #
																(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																(((((st_13.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) #
																((((st_13.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																((((((st_13.(share)).(globals)).(g_granules)) #
																	(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((st_13.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_13.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																	None)))
													)))))))
								else (
									when cid == (
											((((((sh.(globals)).(g_granules)) #
												((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
												((((sh.(globals)).(g_granules)) @ ((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
													None)) @ ((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
									when st_13 == (
											(rtt_walk_lock_unlock_spec
												(mkPtr "stack_s_rtt_walk__1" 0)
												(mkPtr "granules" (((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
												ret_2
												ret_3
												v_2
												(v_3 + ((- 1)))
												(lens 347 st_1)));
									rely ((((st_13.(share)).(granule_data)) = ((sh.(granule_data)))));
									rely ((((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
									rely ((((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
									if (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_last_level)) - ((v_3 + ((- 1))))) =? (0))
									then (
										rely (
											((((("granules" = ("granules")) /\ ((((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) mod (16)) = (0)))) /\
												((((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
												((6 >= (0)))) /\
												((6 <= (24)))));
										when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)))));
										when ret_5 == ((buffer_map_spec' 6 ret_4 false));
										rely ((((ret_5.(pbase)) = ("granule_data")) /\ (((ret_5.(poffset)) >= (0)))));
										when v_60, st_18 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk))))))) st_13));
										rely ((((st_18.(share)).(granule_data)) = (((st_13.(share)).(granule_data)))));
										rely (((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
										rely ((((((st_18.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0)) = (false)));
										rely ((((((st_18.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0)) = (false)));
										rely ((((((st_18.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0)) = (false)));
										rely (
											((((("granules" = ("granules")) /\ (((((st_18.(stack)).(stack_type_4__1)) mod (16)) = (0)))) /\ (((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)))) /\
												((1 >= (0)))) /\
												((1 <= (24)))));
										when ret_6 == ((granule_addr_spec' (mkPtr "granules" (((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)))));
										when ret_7 == ((buffer_map_spec' 1 ret_6 false));
										rely ((((ret_7.(pbase)) = ("granule_data")) /\ (((ret_7.(poffset)) >= (0)))));
										if ((v_60 & (63)) =? (0))
										then (
											when ret_8 == ((s2tte_get_ripas_spec' v_60));
											when ret_9 == ((s2tte_create_ripas_spec' ret_8));
											match (
												match ((s2tt_init_unassigned_loop759_0 (z_to_nat 0) false ret_7 ret_9 0 st_18)) with
												| (Some (__break__, v_7, v_6, v_index_0, st_2)) => (Some (true, 0, st_2))
												| None => None
												end
											) with
											| (Some (__return__, v_bc_resume_val, st_2)) =>
												if __return__
												then (
													rely (((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
													rely ((((((st_2.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0)) = (false)));
													rely ((((((st_2.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0)) = (false)));
													rely ((((((st_2.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0)) = (false)));
													rely (
														((((("granules" = ("granules")) /\ (((((st_2.(stack)).(stack_type_4__1)) mod (16)) = (0)))) /\ (((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)))) /\
															((5 >= (0)))) /\
															((5 <= (6)))));
													rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) >= (0)))));
													when cid_0 == (
															((((((((st_2.(share)).(globals)).(g_granules)) #
																(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																	((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																		(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																((((((st_2.(share)).(globals)).(g_granules)) #
																	(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																		((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																			(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																	5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
													when cid_1 == (
															(((((((((st_2.(share)).(globals)).(g_granules)) #
																(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																	((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																		(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																((((((st_2.(share)).(globals)).(g_granules)) #
																	(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																		((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																			(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																	5)) #
																(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																(((((((st_2.(share)).(globals)).(g_granules)) #
																	(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																		((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																			(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																	((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																	((((((st_2.(share)).(globals)).(g_granules)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																		5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																	None)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
													(Some (
														0  ,
														((lens 349 st_2).[share].[globals].[g_granules] :<
															(((((((st_2.(share)).(globals)).(g_granules)) #
																(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																	((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																		(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																((((((st_2.(share)).(globals)).(g_granules)) #
																	(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																		((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																			(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																	5)) #
																(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																(((((((st_2.(share)).(globals)).(g_granules)) #
																	(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																		((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																			(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																	((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																	((((((st_2.(share)).(globals)).(g_granules)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																		5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																	None)) #
																((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																((((((((st_2.(share)).(globals)).(g_granules)) #
																	(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																		((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																			(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																	((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																	((((((st_2.(share)).(globals)).(g_granules)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																		5)) #
																	(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((((st_2.(share)).(globals)).(g_granules)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																		((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																		((((((st_2.(share)).(globals)).(g_granules)) #
																			(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																			(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																				((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																					(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																			5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																		None)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																	None)))
													)))
												else (
													match ((s2tt_init_unassigned_loop759 (z_to_nat 0) false ret_7 ret_9 v_bc_resume_val st_2)) with
													| (Some (__break__, v_7, v_6, v_indvars_iv_0, st_3)) =>
														rely (((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
														rely ((((((st_3.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0)) = (false)));
														rely ((((((st_3.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0)) = (false)));
														rely ((((((st_3.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0)) = (false)));
														rely (
															((((("granules" = ("granules")) /\ (((((st_3.(stack)).(stack_type_4__1)) mod (16)) = (0)))) /\ (((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)))) /\
																((5 >= (0)))) /\
																((5 <= (6)))));
														rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) >= (0)))));
														when cid_0 == (
																((((((((st_3.(share)).(globals)).(g_granules)) #
																	(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																		((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																			(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																	((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																	((((((st_3.(share)).(globals)).(g_granules)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																		5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
														when cid_1 == (
																(((((((((st_3.(share)).(globals)).(g_granules)) #
																	(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																		((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																			(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																	((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																	((((((st_3.(share)).(globals)).(g_granules)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																		5)) #
																	(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((((st_3.(share)).(globals)).(g_granules)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																		((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																		((((((st_3.(share)).(globals)).(g_granules)) #
																			(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																			(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																				((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																					(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																			5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																		None)) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
														(Some (
															0  ,
															((lens 351 st_3).[share].[globals].[g_granules] :<
																(((((((st_3.(share)).(globals)).(g_granules)) #
																	(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																		((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																			(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																	((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																	((((((st_3.(share)).(globals)).(g_granules)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																		5)) #
																	(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((((st_3.(share)).(globals)).(g_granules)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																		((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																		((((((st_3.(share)).(globals)).(g_granules)) #
																			(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																			(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																				((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																					(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																			5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																		None)) #
																	((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																	((((((((st_3.(share)).(globals)).(g_granules)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																		((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																		((((((st_3.(share)).(globals)).(g_granules)) #
																			(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																			(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																				((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																					(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																			5)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((((st_3.(share)).(globals)).(g_granules)) #
																			(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																			(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																				((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																					(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																			((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																			((((((st_3.(share)).(globals)).(g_granules)) #
																				(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																				(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																					((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																						(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																				5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																			None)) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																		None)))
														))
													| None => None
													end)
											| None => None
											end)
										else (
											if ((v_60 & (63)) =? (8))
											then (
												rely (((((((st_18.(share)).(granule_data)) @ ((ret_7.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_DATA)) = (0)));
												match (
													match ((s2tt_init_destroyed_loop776_0 (z_to_nat 0) false ret_7 0 st_18)) with
													| (Some (__break__, v_5, v_index_0, st_2)) => (Some (true, 0, st_2))
													| None => None
													end
												) with
												| (Some (__return__, v_bc_resume_val, st_2)) =>
													if __return__
													then (
														rely (((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
														rely ((((((st_2.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0)) = (false)));
														rely ((((((st_2.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0)) = (false)));
														rely ((((((st_2.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0)) = (false)));
														rely (
															((((("granules" = ("granules")) /\ (((((st_2.(stack)).(stack_type_4__1)) mod (16)) = (0)))) /\ (((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)))) /\
																((5 >= (0)))) /\
																((5 <= (6)))));
														rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) >= (0)))));
														when cid_0 == (
																((((((((st_2.(share)).(globals)).(g_granules)) #
																	(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																		((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																			(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																	((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																	((((((st_2.(share)).(globals)).(g_granules)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																		5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
														when cid_1 == (
																(((((((((st_2.(share)).(globals)).(g_granules)) #
																	(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																		((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																			(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																	((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																	((((((st_2.(share)).(globals)).(g_granules)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																		5)) #
																	(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((((st_2.(share)).(globals)).(g_granules)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																		((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																		((((((st_2.(share)).(globals)).(g_granules)) #
																			(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																			(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																				((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																					(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																			5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																		None)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
														(Some (
															0  ,
															((lens 353 st_2).[share].[globals].[g_granules] :<
																(((((((st_2.(share)).(globals)).(g_granules)) #
																	(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																		((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																			(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																	((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																	((((((st_2.(share)).(globals)).(g_granules)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																		5)) #
																	(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((((st_2.(share)).(globals)).(g_granules)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																		((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																		((((((st_2.(share)).(globals)).(g_granules)) #
																			(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																			(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																				((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																					(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																			5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																		None)) #
																	((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																	((((((((st_2.(share)).(globals)).(g_granules)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																		((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																		((((((st_2.(share)).(globals)).(g_granules)) #
																			(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																			(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																				((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																					(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																			5)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((((st_2.(share)).(globals)).(g_granules)) #
																			(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																			(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																				((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																					(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																			((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																			((((((st_2.(share)).(globals)).(g_granules)) #
																				(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																				(((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																					((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																						(((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																				5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																			None)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																		None)))
														)))
													else (
														match ((s2tt_init_destroyed_loop776 (z_to_nat 0) false ret_7 v_bc_resume_val st_2)) with
														| (Some (__break__, v_5, v_indvars_iv_0, st_3)) =>
															rely (((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
															rely ((((((st_3.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0)) = (false)));
															rely ((((((st_3.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0)) = (false)));
															rely ((((((st_3.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0)) = (false)));
															rely (
																((((("granules" = ("granules")) /\ (((((st_3.(stack)).(stack_type_4__1)) mod (16)) = (0)))) /\ (((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)))) /\
																	((5 >= (0)))) /\
																	((5 <= (6)))));
															rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) >= (0)))));
															when cid_0 == (
																	((((((((st_3.(share)).(globals)).(g_granules)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																		((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																		((((((st_3.(share)).(globals)).(g_granules)) #
																			(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																			(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																				((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																					(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																			5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
															when cid_1 == (
																	(((((((((st_3.(share)).(globals)).(g_granules)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																		((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																		((((((st_3.(share)).(globals)).(g_granules)) #
																			(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																			(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																				((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																					(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																			5)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((((st_3.(share)).(globals)).(g_granules)) #
																			(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																			(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																				((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																					(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																			((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																			((((((st_3.(share)).(globals)).(g_granules)) #
																				(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																				(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																					((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																						(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																				5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																			None)) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
															(Some (
																0  ,
																((lens 355 st_3).[share].[globals].[g_granules] :<
																	(((((((st_3.(share)).(globals)).(g_granules)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																		((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																		((((((st_3.(share)).(globals)).(g_granules)) #
																			(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																			(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																				((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																					(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																			5)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((((st_3.(share)).(globals)).(g_granules)) #
																			(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																			(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																				((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																					(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																			((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																			((((((st_3.(share)).(globals)).(g_granules)) #
																				(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																				(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																					((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																						(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																				5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																			None)) #
																		((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																		((((((((st_3.(share)).(globals)).(g_granules)) #
																			(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																			(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																				((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																					(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																			((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																			((((((st_3.(share)).(globals)).(g_granules)) #
																				(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																				(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																					((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																						(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																				5)) #
																			(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																			(((((((st_3.(share)).(globals)).(g_granules)) #
																				(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																				(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																					((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																						(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) #
																				((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																				((((((st_3.(share)).(globals)).(g_granules)) #
																					(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																					(((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																						((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																							(((((((st_3.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :<
																					5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																				None)) @ ((((st_3.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																			None)))
															))
														| None => None
														end)
												| None => None
												end)
											else (
												if ((v_60 & (63)) =? (4))
												then (
													when ret_8 == ((s2tte_pa_spec' v_60 (v_3 + ((- 1)))));
													rely (((((((st_18.(share)).(granule_data)) @ ((ret_7.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_DATA)) = (0)));
													match ((s2tt_init_assigned_loop801 (z_to_nat 512) false ret_7 v_3 (1 << ((39 + (((- 9) * (v_3)))))) ret_8 0 st_18)) with
													| (Some (__return__, v_7, v_9, v_8, v__11, v_indvars_iv_0, st_2)) =>
														rely (((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
														rely ((((((st_2.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0)) = (false)));
														rely ((((((st_2.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0)) = (false)));
														rely ((((((st_2.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0)) = (false)));
														rely (((("granules" = ("granules")) /\ (((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)))) /\ (((((st_2.(stack)).(stack_type_4__1)) mod (16)) = (0)))));
														rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) >= (0)))));
														when cid_0 == (
																(((((((st_2.(share)).(globals)).(g_granules)) #
																	((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																	((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																		((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																			(((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
																		5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
														when cid_1 == (
																((((((((st_2.(share)).(globals)).(g_granules)) #
																	((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																	((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																		((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																			(((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
																		5)) #
																	(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	((((((st_2.(share)).(globals)).(g_granules)) #
																		((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																		((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
																			5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																		None)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
														(Some (
															0  ,
															((lens 357 st_2).[share].[globals].[g_granules] :<
																((((((st_2.(share)).(globals)).(g_granules)) #
																	((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																	((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																		((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																			(((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
																		5)) #
																	(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	((((((st_2.(share)).(globals)).(g_granules)) #
																		((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																		((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
																			5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																		None)) #
																	((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																	(((((((st_2.(share)).(globals)).(g_granules)) #
																		((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																		((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
																			5)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		((((((st_2.(share)).(globals)).(g_granules)) #
																			((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																			((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																				((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																					(((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
																				5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																			None)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																		None)))
														))
													| None => None
													end)
												else (
													when ret_8 == ((s2tte_is_valid_spec' v_60 (v_3 + ((- 1)))));
													if ret_8
													then (
														rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) >= (0)))));
														when ret_9 == ((s2tte_pa_spec' v_60 (v_3 + ((- 1)))));
														rely (
															(((((((st_18.(share)).(granule_data)) #
																(((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096)) ==
																((((st_18.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
																	(((((st_18.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
																		(((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) mod (4096)) ==
																		0))) @ ((ret_7.(poffset)) / (4096))).(g_granule_state)) -
																(GRANULE_STATE_DATA)) =
																(0)));
														match ((s2tt_init_valid_loop820 (z_to_nat 512) false ret_7 v_3 (1 << ((39 + (((- 9) * (v_3)))))) ret_9 0 (lens 303 st_18))) with
														| (Some (__return__, v_7, v_9, v_8, v__11, v_indvars_iv_0, st_2)) =>
															rely (((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
															rely ((((((st_2.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0)) = (false)));
															rely ((((((st_2.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0)) = (false)));
															rely ((((((st_2.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0)) = (false)));
															rely (((("granules" = ("granules")) /\ (((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)))) /\ (((((st_2.(stack)).(stack_type_4__1)) mod (16)) = (0)))));
															when cid_0 == (
																	(((((((st_2.(share)).(globals)).(g_granules)) #
																		((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																		((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
																			5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
															when cid_1 == (
																	((((((((st_2.(share)).(globals)).(g_granules)) #
																		((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																		((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
																			5)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		((((((st_2.(share)).(globals)).(g_granules)) #
																			((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																			((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																				((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																					(((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
																				5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																			None)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
															(Some (
																0  ,
																((lens 359 st_2).[share].[globals].[g_granules] :<
																	((((((st_2.(share)).(globals)).(g_granules)) #
																		((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																		((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
																			5)) #
																		(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		((((((st_2.(share)).(globals)).(g_granules)) #
																			((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																			((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																				((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																					(((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
																				5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																			None)) #
																		((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																		(((((((st_2.(share)).(globals)).(g_granules)) #
																			((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																			((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																				((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																					(((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
																				5)) #
																			(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																			((((((st_2.(share)).(globals)).(g_granules)) #
																				((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																				((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																					((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																						(((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
																					5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																				None)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																			None)))
															))
														| None => None
														end)
													else (
														when ret_9 == ((s2tte_is_valid_ns_spec' v_60 (v_3 + ((- 1)))));
														if ret_9
														then (
															rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) >= (0)))));
															when ret_10 == ((s2tte_pa_spec' v_60 (v_3 + ((- 1)))));
															rely (
																(((((((st_18.(share)).(granule_data)) #
																	(((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096)) ==
																	((((st_18.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
																		(((((st_18.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
																			(((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) mod (4096)) ==
																			0))) @ ((ret_7.(poffset)) / (4096))).(g_granule_state)) -
																	(GRANULE_STATE_DATA)) =
																	(0)));
															match ((s2tt_init_valid_ns_loop839 (z_to_nat 512) false ret_7 v_3 (1 << ((39 + (((- 9) * (v_3)))))) ret_10 0 (lens 306 st_18))) with
															| (Some (__return__, v_7, v_9, v_8, v__11, v_indvars_iv_0, st_2)) =>
																rely (((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
																rely ((((((st_2.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0)) = (false)));
																rely ((((((st_2.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0)) = (false)));
																rely ((((((st_2.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0)) = (false)));
																rely (((("granules" = ("granules")) /\ (((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)))) /\ (((((st_2.(stack)).(stack_type_4__1)) mod (16)) = (0)))));
																when cid_0 == (
																		(((((((st_2.(share)).(globals)).(g_granules)) #
																			((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																			((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																				((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																					(((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
																				5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
																when cid_1 == (
																		((((((((st_2.(share)).(globals)).(g_granules)) #
																			((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																			((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																				((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																					(((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
																				5)) #
																			(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																			((((((st_2.(share)).(globals)).(g_granules)) #
																				((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																				((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																					((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																						(((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
																					5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																				None)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
																(Some (
																	0  ,
																	((lens 361 st_2).[share].[globals].[g_granules] :<
																		((((((st_2.(share)).(globals)).(g_granules)) #
																			((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																			((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																				((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																					(((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
																				5)) #
																			(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																			((((((st_2.(share)).(globals)).(g_granules)) #
																				((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																				((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																					((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																						(((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
																					5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																				None)) #
																			((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																			(((((((st_2.(share)).(globals)).(g_granules)) #
																				((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																				((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																					((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																						(((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
																					5)) #
																				(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																				((((((st_2.(share)).(globals)).(g_granules)) #
																					((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																					((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																						((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																							(((((((st_2.(share)).(globals)).(g_granules)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (512)))).[e_state_s_granule] :<
																						5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																					None)) @ ((((st_2.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																				None)))
																))
															| None => None
															end)
														else (
															if (((v_3 + ((- 1))) <? (3)) && (((v_60 & (3)) =? (3))))
															then (
																when cid_0 == (((((((st_18.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
																when cid_1 == (
																		(((((((st_18.(share)).(globals)).(g_granules)) #
																			(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																			(((((st_18.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
																(Some (
																	9  ,
																	((lens 309 st_18).[share].[globals].[g_granules] :<
																		(((((st_18.(share)).(globals)).(g_granules)) #
																			(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																			(((((st_18.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) #
																			((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																			((((((st_18.(share)).(globals)).(g_granules)) #
																				(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																				(((((st_18.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																				None)))
																)))
															else (
																rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_index_s_rtt_walk)))))) >= (0)))));
																when cid_0 == (
																		(((((((st_18.(share)).(globals)).(g_granules)) #
																			((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																			(((((st_18.(share)).(globals)).(g_granules)) @ ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :< 5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
																when cid_1 == (
																		((((((((st_18.(share)).(globals)).(g_granules)) #
																			((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																			(((((st_18.(share)).(globals)).(g_granules)) @ ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :< 5)) #
																			(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																			((((((st_18.(share)).(globals)).(g_granules)) #
																				((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																				(((((st_18.(share)).(globals)).(g_granules)) @ ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :< 5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																				None)) @ ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
																(Some (
																	0  ,
																	((lens 363 st_18).[share].[globals].[g_granules] :<
																		((((((st_18.(share)).(globals)).(g_granules)) #
																			((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																			(((((st_18.(share)).(globals)).(g_granules)) @ ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :< 5)) #
																			(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																			((((((st_18.(share)).(globals)).(g_granules)) #
																				((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																				(((((st_18.(share)).(globals)).(g_granules)) @ ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :< 5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																				None)) #
																			((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																			(((((((st_18.(share)).(globals)).(g_granules)) #
																				((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																				(((((st_18.(share)).(globals)).(g_granules)) @ ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :< 5)) #
																				(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																				((((((st_18.(share)).(globals)).(g_granules)) #
																					((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																					(((((st_18.(share)).(globals)).(g_granules)) @ ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_state_s_granule] :< 5)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																					None)) @ ((((st_18.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																				None)))
																)))))))))
									else (
										when cid_0 == (((((((st_13.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
										rely (((((st_13.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
										if ((((st_13.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0))
										then None
										else (
											if ((((st_13.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0))
											then None
											else (
												if ((((st_13.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0))
												then None
												else (
													when cid_1 == (
															(((((((st_13.(share)).(globals)).(g_granules)) #
																(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																(((((st_13.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_13.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
													(Some (
														((((((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
															((((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_last_level)) << (32)) + (8))))  ,
														((lens 312 st_13).[share].[globals].[g_granules] :<
															(((((st_13.(share)).(globals)).(g_granules)) #
																(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																(((((st_13.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) #
																((((st_13.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																((((((st_13.(share)).(globals)).(g_granules)) #
																	(((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((st_13.(share)).(globals)).(g_granules)) @ (((((st_13.(stack)).(stack_s_rtt_walk__1)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_13.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																	None)))
													)))))))
							| (Some cid) => None
							end)
						else None)
					else (
						when cid == (((((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
						rely (((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
						if ((((st_1.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0))
						then None
						else (
							if ((((st_1.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0))
							then None
							else (
								if ((((st_1.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0))
								then None
								else (
									when cid_0 == (
											(((((((st_1.(share)).(globals)).(g_granules)) #
												((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16)) ==
												(((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
									(Some (
										(((((((ret_1 >> (32)) + (3)) << (32)) + (ret_1)) >> (24)) & (4294967040)) |' (((((ret_1 >> (32)) + (3)) << (32)) + (ret_1))))  ,
										((lens 313 st_1).[share].[globals].[g_granules] :<
											(((((st_1.(share)).(globals)).(g_granules)) #
												((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16)) ==
												(((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) #
												((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
												((((((st_1.(share)).(globals)).(g_granules)) #
													((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16)) ==
													(((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
													None)))
									)))))))
				else (Some ((((((((v_22 >> (32)) + (1)) << (32)) + (1)) >> (24)) & (4294967040)) |' (((((v_22 >> (32)) + (1)) << (32)) + (1)))), st_1))))
		else (
			rely (
				((((((v_1 & ((- 2))) - (MEM0_PHYS)) >= (0)) /\ ((((v_1 & ((- 2))) - (4294967296)) < (0)))) \/
					(((((v_1 & ((- 2))) - (MEM1_PHYS)) >= (0)) /\ ((((v_1 & ((- 2))) - (556198264832)) < (0)))))) /\
					((((v_1 & ((- 2))) & (4095)) = (0)))));
			if (((v_1 & ((- 2))) - (MEM1_PHYS)) >=? (0))
			then (
				when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
				match ((((((sh.(globals)).(g_granules)) @ (((((v_1 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val))) with
				| None =>
					rely (
						(((((((st.(share)).(globals)).(g_granules)) @ (((((v_1 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) -
							(((((sh.(globals)).(g_granules)) @ (((((v_1 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)))) =
							(0)));
					if ((((((sh.(globals)).(g_granules)) @ (((((v_1 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) - (3)) =? (0))
					then (
						when ret == ((granule_addr_spec' (mkPtr "granules" ((((v_1 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)))));
						when ret_0 == ((buffer_map_spec' 3 ret false));
						rely ((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))));
						rely (((((ret_0.(pbase)) = ("granule_data")) /\ ((((ret_0.(poffset)) mod (4096)) = (0)))) /\ (((ret_0.(poffset)) >= (0)))));
						rely ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
						rely (
							((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) >= (0)) /\
								((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (MEM0_VIRT)) < (0)))));
						when sh_0 == (
								((st.(repl))
									((st.(oracle)) ((EVT CPU_ID (ACQ (((((v_1 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))
									(sh.[globals].[g_granules] :<
										(((sh.(globals)).(g_granules)) #
											(((((v_1 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
											((((sh.(globals)).(g_granules)) @ (((((v_1 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))))));
						match ((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val))) with
						| None =>
							rely (
								(((((((sh.(globals)).(g_granules)) #
									(((((v_1 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
									((((sh.(globals)).(g_granules)) @ (((((v_1 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
									(((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)))) =
									(0)));
							rely (
								((("granules" = ("granules")) /\ ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) mod (16)) = (0)))) /\
									((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) >= (0)))));
							if (
								((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
									(5)) =?
									(0)))
							then (
								when v_8, st_2 == (
										(rtt_create_internal_spec
											(mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)))
											v_0
											v_2
											v_3
											1
											(lens 364 st)));
								when cid == (((((((st_2.(share)).(globals)).(g_granules)) @ (((((v_1 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val)));
								(Some (
									((((v_8 << (32)) >> (32)) << (32)) >> (32))  ,
									((lens 316 st_2).[share].[globals].[g_granules] :<
										((((st_2.(share)).(globals)).(g_granules)) #
											(((((v_1 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
											(((((st_2.(share)).(globals)).(g_granules)) @ (((((v_1 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< None)))
								)))
							else (
								when v_8, st_2 == (
										(rtt_create_internal_spec
											(mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)))
											v_0
											v_2
											v_3
											1
											(lens 365 st)));
								when cid == (((((((st_2.(share)).(globals)).(g_granules)) @ (((((v_1 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val)));
								(Some (
									((((v_8 << (32)) >> (32)) << (32)) >> (32))  ,
									((lens 319 st_2).[share].[globals].[g_granules] :<
										((((st_2.(share)).(globals)).(g_granules)) #
											(((((v_1 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
											(((((st_2.(share)).(globals)).(g_granules)) @ (((((v_1 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< None)))
								)))
						| (Some cid) => None
						end)
					else (Some (8589935105, (lens 366 st)))
				| (Some cid) => None
				end)
			else (
				when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
				match ((((((sh.(globals)).(g_granules)) @ (((v_1 & ((- 2))) + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val))) with
				| None =>
					rely (
						(((((((st.(share)).(globals)).(g_granules)) @ (((v_1 & ((- 2))) + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) -
							(((((sh.(globals)).(g_granules)) @ (((v_1 & ((- 2))) + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)))) =
							(0)));
					if ((((((sh.(globals)).(g_granules)) @ (((v_1 & ((- 2))) + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (3)) =? (0))
					then (
						when ret == ((granule_addr_spec' (mkPtr "granules" ((((v_1 & ((- 2))) + ((- MEM0_PHYS))) >> (12)) * (16)))));
						when ret_0 == ((buffer_map_spec' 3 ret false));
						rely ((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))));
						rely (((((ret_0.(pbase)) = ("granule_data")) /\ ((((ret_0.(poffset)) mod (4096)) = (0)))) /\ (((ret_0.(poffset)) >= (0)))));
						rely ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
						rely (
							((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) >= (0)) /\
								((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (MEM0_VIRT)) < (0)))));
						when sh_0 == (
								((st.(repl))
									((st.(oracle)) ((EVT CPU_ID (ACQ (((v_1 & ((- 2))) + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))
									(sh.[globals].[g_granules] :<
										(((sh.(globals)).(g_granules)) #
											(((v_1 & ((- 2))) + ((- MEM0_PHYS))) >> (12)) ==
											((((sh.(globals)).(g_granules)) @ (((v_1 & ((- 2))) + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))))));
						match ((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val))) with
						| None =>
							rely (
								(((((((sh.(globals)).(g_granules)) #
									(((v_1 & ((- 2))) + ((- MEM0_PHYS))) >> (12)) ==
									((((sh.(globals)).(g_granules)) @ (((v_1 & ((- 2))) + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
									(((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)))) =
									(0)));
							rely (
								((("granules" = ("granules")) /\ ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) mod (16)) = (0)))) /\
									((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) >= (0)))));
							if (
								((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
									(5)) =?
									(0)))
							then (
								when v_8, st_2 == (
										(rtt_create_internal_spec
											(mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)))
											v_0
											v_2
											v_3
											1
											(lens 367 st)));
								when cid == (((((((st_2.(share)).(globals)).(g_granules)) @ (((v_1 & ((- 2))) + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val)));
								(Some (
									((((v_8 << (32)) >> (32)) << (32)) >> (32))  ,
									((lens 324 st_2).[share].[globals].[g_granules] :<
										((((st_2.(share)).(globals)).(g_granules)) #
											(((v_1 & ((- 2))) + ((- MEM0_PHYS))) >> (12)) ==
											(((((st_2.(share)).(globals)).(g_granules)) @ (((v_1 & ((- 2))) + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< None)))
								)))
							else (
								when v_8, st_2 == (
										(rtt_create_internal_spec
											(mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_s1_ctx)).(e_g_ttbr1)) - (GRANULES_BASE)))
											v_0
											v_2
											v_3
											1
											(lens 368 st)));
								when cid == (((((((st_2.(share)).(globals)).(g_granules)) @ (((v_1 & ((- 2))) + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val)));
								(Some (
									((((v_8 << (32)) >> (32)) << (32)) >> (32))  ,
									((lens 327 st_2).[share].[globals].[g_granules] :<
										((((st_2.(share)).(globals)).(g_granules)) #
											(((v_1 & ((- 2))) + ((- MEM0_PHYS))) >> (12)) ==
											(((((st_2.(share)).(globals)).(g_granules)) @ (((v_1 & ((- 2))) + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< None)))
								)))
						| (Some cid) => None
						end)
					else (Some (8589935105, (lens 369 st)))
				| (Some cid) => None
				end)).
	
	Definition smc_data_destroy_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
		rely (
			(((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - (4294967296)) < (0)))) \/ ((((v_0 - (MEM1_PHYS)) >= (0)) /\ (((v_0 - (556198264832)) < (0)))))) /\
				(((v_0 & (4095)) = (0)))));
		if ((v_0 - (MEM1_PHYS)) >=? (0))
		then (
			when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
			match ((((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val))) with
			| None =>
				rely (
					(((((((st.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) -
						(((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)))) =
						(0)));
				if ((((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) - (2)) =? (0))
				then (
					when ret == ((granule_addr_spec' (mkPtr "granules" (((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)))));
					when ret_0 == ((buffer_map_spec' 2 ret false));
					rely ((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))));
					rely (((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))) /\ ((((ret_0.(poffset)) mod (4096)) = (0)))));
					rely ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
					when ret_1, st' == ((validate_map_addr_spec' v_1 3 ret_0 (lens 270 st)));
					if (ret_1 =? (0))
					then (
						rely ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)));
						rely ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (MEM0_VIRT)) < (0)));
						when ret_2, st'_0 == ((realm_rtt_starting_level_spec' ret_0 (lens 271 st)));
						when ret_3, st'_1 == ((realm_ipa_bits_spec' ret_0 (lens 272 st)));
						when sh_0 == (
								((st.(repl))
									((st.(oracle)) ((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))
									(sh.[globals].[g_granules] :<
										(((sh.(globals)).(g_granules)) #
											((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
											((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))))));
						match ((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val))) with
						| None =>
							rely (
								(((((((sh.(globals)).(g_granules)) #
									((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
									((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
									(((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)))) =
									(0)));
							rely (
								((("granules" = ("granules")) /\ ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) mod (16)) = (0)))) /\
									((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)))));
							if (
								((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
									(5)) =?
									(0)))
							then (
								when cid == ((((((sh_0.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val)));
								when st_9 == (
										(rtt_walk_lock_unlock_spec
											(mkPtr "stack_s_rtt_walk" 0)
											(mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
											ret_2
											ret_3
											v_1
											3
											(lens 273 st)));
								rely ((((st_9.(share)).(granule_data)) = ((sh_0.(granule_data)))));
								rely ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
								rely ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
								if ((((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level)) =? (3))
								then (
									rely (
										((((("granules" = ("granules")) /\ ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
											((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
											((6 >= (0)))) /\
											((6 <= (24)))));
									when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
									when ret_5 == ((buffer_map_spec' 6 ret_4 false));
									rely ((((ret_5.(pbase)) = ("granule_data")) /\ (((ret_5.(poffset)) >= (0)))));
									when v_28, st_14 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_9));
									rely ((((st_14.(share)).(granule_data)) = (((st_9.(share)).(granule_data)))));
									if ((v_28 & (63)) =? (4))
									then (
										when ret_6 == ((s2tte_pa_spec' v_28 3));
										rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
										rely (
											(((((ret_6 - (MEM0_PHYS)) >= (0)) /\ (((ret_6 - (4294967296)) < (0)))) \/ ((((ret_6 - (MEM1_PHYS)) >= (0)) /\ (((ret_6 - (556198264832)) < (0)))))) /\
												(((ret_6 & (4095)) = (0)))));
										if ((ret_6 - (MEM1_PHYS)) >=? (0))
										then (
											when sh_1 == (
													((st_14.(repl))
														((st_14.(oracle)) (st_14.(log)))
														(((st_14.(share)).[globals].[g_granules] :<
															((((st_14.(share)).(globals)).(g_granules)) #
																(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																	((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																		(((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[granule_data] :<
															(((st_14.(share)).(granule_data)) #
																(((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
																((((st_14.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
																	(((((st_14.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
																		(((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
																		8))))));
											match ((((((sh_1.(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val))) with
											| None =>
												rely (
													((((((((st_14.(share)).(globals)).(g_granules)) #
														(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
														(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
															((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																(((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1)))))) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) -
														(((((sh_1.(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)))) =
														(0)));
												if ((((((sh_1.(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) - (4)) =? (0))
												then (
													rely (((0 = (0)) /\ (((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) >= (0)))));
													when st_20 == ((granule_memzero_spec (mkPtr "granules" (((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16))) 1 (lens 274 st_14)));
													when cid_0 == (((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val)));
													when cid_1 == (
															(((((((st_20.(share)).(globals)).(g_granules)) #
																((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< None).[e_state_s_granule] :< 1)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
													(Some (
														0  ,
														((lens 220 st_20).[share].[globals].[g_granules] :<
															(((((st_20.(share)).(globals)).(g_granules)) #
																((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< None).[e_state_s_granule] :< 1)) #
																(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																((((((st_20.(share)).(globals)).(g_granules)) #
																	((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																	((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< None).[e_state_s_granule] :< 1)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																	None)))
													)))
												else None
											| (Some cid_0) => None
											end)
										else (
											when sh_1 == (
													((st_14.(repl))
														((st_14.(oracle)) (st_14.(log)))
														(((st_14.(share)).[globals].[g_granules] :<
															((((st_14.(share)).(globals)).(g_granules)) #
																(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																	((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																		(((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[granule_data] :<
															(((st_14.(share)).(granule_data)) #
																(((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
																((((st_14.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
																	(((((st_14.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
																		(((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
																		8))))));
											match ((((((sh_1.(globals)).(g_granules)) @ ((ret_6 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val))) with
											| None =>
												rely (
													((((((((st_14.(share)).(globals)).(g_granules)) #
														(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
														(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
															((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																(((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1)))))) @ ((ret_6 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) -
														(((((sh_1.(globals)).(g_granules)) @ ((ret_6 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)))) =
														(0)));
												if ((((((sh_1.(globals)).(g_granules)) @ ((ret_6 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (4)) =? (0))
												then (
													when st_20 == ((granule_memzero_spec (mkPtr "granules" (((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16))) 1 (lens 275 st_14)));
													when cid_0 == (((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16))).(e_lock)).(e_val)));
													when cid_1 == (
															(((((((st_20.(share)).(globals)).(g_granules)) #
																((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16)) ==
																((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16))).[e_lock].[e_val] :< None).[e_state_s_granule] :< 1)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
													(Some (
														0  ,
														((lens 223 st_20).[share].[globals].[g_granules] :<
															(((((st_20.(share)).(globals)).(g_granules)) #
																((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16)) ==
																((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16))).[e_lock].[e_val] :< None).[e_state_s_granule] :< 1)) #
																(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																((((((st_20.(share)).(globals)).(g_granules)) #
																	((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16)) ==
																	((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16))).[e_lock].[e_val] :< None).[e_state_s_granule] :< 1)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																	None)))
													)))
												else None
											| (Some cid_0) => None
											end))
									else (
										when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
										(Some (
											9  ,
											((lens 224 st_14).[share].[globals].[g_granules] :<
												((((st_14.(share)).(globals)).(g_granules)) #
													(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
													(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
										))))
								else (
									when cid_0 == (((((((st_9.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
									(Some (
										((((((((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
											((((((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
										((lens 225 st_9).[share].[globals].[g_granules] :<
											((((st_9.(share)).(globals)).(g_granules)) #
												(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
												(((((st_9.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
									))))
							else (
								when cid == (
										((((((sh_0.(globals)).(g_granules)) #
											(((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
											((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
												None)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val)));
								when st_9 == (
										(rtt_walk_lock_unlock_spec
											(mkPtr "stack_s_rtt_walk" 0)
											(mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
											ret_2
											ret_3
											v_1
											3
											(lens 276 st)));
								rely ((((st_9.(share)).(granule_data)) = ((sh_0.(granule_data)))));
								rely ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
								rely ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
								if ((((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level)) =? (3))
								then (
									rely (
										((((("granules" = ("granules")) /\ ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
											((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
											((6 >= (0)))) /\
											((6 <= (24)))));
									when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
									when ret_5 == ((buffer_map_spec' 6 ret_4 false));
									rely ((((ret_5.(pbase)) = ("granule_data")) /\ (((ret_5.(poffset)) >= (0)))));
									when v_28, st_14 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_9));
									rely ((((st_14.(share)).(granule_data)) = (((st_9.(share)).(granule_data)))));
									if ((v_28 & (63)) =? (4))
									then (
										when ret_6 == ((s2tte_pa_spec' v_28 3));
										rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
										rely (
											(((((ret_6 - (MEM0_PHYS)) >= (0)) /\ (((ret_6 - (4294967296)) < (0)))) \/ ((((ret_6 - (MEM1_PHYS)) >= (0)) /\ (((ret_6 - (556198264832)) < (0)))))) /\
												(((ret_6 & (4095)) = (0)))));
										if ((ret_6 - (MEM1_PHYS)) >=? (0))
										then (
											when sh_1 == (
													((st_14.(repl))
														((st_14.(oracle)) (st_14.(log)))
														(((st_14.(share)).[globals].[g_granules] :<
															((((st_14.(share)).(globals)).(g_granules)) #
																(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																	((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																		(((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[granule_data] :<
															(((st_14.(share)).(granule_data)) #
																(((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
																((((st_14.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
																	(((((st_14.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
																		(((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
																		8))))));
											match ((((((sh_1.(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val))) with
											| None =>
												rely (
													((((((((st_14.(share)).(globals)).(g_granules)) #
														(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
														(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
															((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																(((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1)))))) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) -
														(((((sh_1.(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)))) =
														(0)));
												if ((((((sh_1.(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) - (4)) =? (0))
												then (
													rely (((0 = (0)) /\ (((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) >= (0)))));
													when st_20 == ((granule_memzero_spec (mkPtr "granules" (((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16))) 1 (lens 277 st_14)));
													when cid_0 == (((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val)));
													when cid_1 == (
															(((((((st_20.(share)).(globals)).(g_granules)) #
																((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< None).[e_state_s_granule] :< 1)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
													(Some (
														0  ,
														((lens 230 st_20).[share].[globals].[g_granules] :<
															(((((st_20.(share)).(globals)).(g_granules)) #
																((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< None).[e_state_s_granule] :< 1)) #
																(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																((((((st_20.(share)).(globals)).(g_granules)) #
																	((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																	((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< None).[e_state_s_granule] :< 1)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																	None)))
													)))
												else None
											| (Some cid_0) => None
											end)
										else (
											when sh_1 == (
													((st_14.(repl))
														((st_14.(oracle)) (st_14.(log)))
														(((st_14.(share)).[globals].[g_granules] :<
															((((st_14.(share)).(globals)).(g_granules)) #
																(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																	((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																		(((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[granule_data] :<
															(((st_14.(share)).(granule_data)) #
																(((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
																((((st_14.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
																	(((((st_14.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
																		(((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
																		8))))));
											match ((((((sh_1.(globals)).(g_granules)) @ ((ret_6 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val))) with
											| None =>
												rely (
													((((((((st_14.(share)).(globals)).(g_granules)) #
														(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
														(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
															((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																(((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1)))))) @ ((ret_6 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) -
														(((((sh_1.(globals)).(g_granules)) @ ((ret_6 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)))) =
														(0)));
												if ((((((sh_1.(globals)).(g_granules)) @ ((ret_6 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (4)) =? (0))
												then (
													when st_20 == ((granule_memzero_spec (mkPtr "granules" (((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16))) 1 (lens 278 st_14)));
													when cid_0 == (((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16))).(e_lock)).(e_val)));
													when cid_1 == (
															(((((((st_20.(share)).(globals)).(g_granules)) #
																((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16)) ==
																((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16))).[e_lock].[e_val] :< None).[e_state_s_granule] :< 1)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
													(Some (
														0  ,
														((lens 233 st_20).[share].[globals].[g_granules] :<
															(((((st_20.(share)).(globals)).(g_granules)) #
																((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16)) ==
																((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16))).[e_lock].[e_val] :< None).[e_state_s_granule] :< 1)) #
																(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																((((((st_20.(share)).(globals)).(g_granules)) #
																	((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16)) ==
																	((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16))).[e_lock].[e_val] :< None).[e_state_s_granule] :< 1)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																	None)))
													)))
												else None
											| (Some cid_0) => None
											end))
									else (
										when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
										(Some (
											9  ,
											((lens 234 st_14).[share].[globals].[g_granules] :<
												((((st_14.(share)).(globals)).(g_granules)) #
													(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
													(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
										))))
								else (
									when cid_0 == (((((((st_9.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
									(Some (
										((((((((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
											((((((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
										((lens 235 st_9).[share].[globals].[g_granules] :<
											((((st_9.(share)).(globals)).(g_granules)) #
												(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
												(((((st_9.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
									))))
						| (Some cid) => None
						end)
					else (Some (8589935105, (lens 279 st))))
				else (Some (4294967553, (lens 280 st)))
			| (Some cid) => None
			end)
		else (
			when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
			match ((((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val))) with
			| None =>
				rely (
					(((((((st.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) -
						(((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)))) =
						(0)));
				if ((((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (2)) =? (0))
				then (
					when ret == ((granule_addr_spec' (mkPtr "granules" (((v_0 + ((- MEM0_PHYS))) >> (12)) * (16)))));
					when ret_0 == ((buffer_map_spec' 2 ret false));
					rely ((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))));
					rely (((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))) /\ ((((ret_0.(poffset)) mod (4096)) = (0)))));
					rely ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
					when ret_1, st' == ((validate_map_addr_spec' v_1 3 ret_0 (lens 281 st)));
					if (ret_1 =? (0))
					then (
						rely ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)));
						rely ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (MEM0_VIRT)) < (0)));
						when ret_2, st'_0 == ((realm_rtt_starting_level_spec' ret_0 (lens 282 st)));
						when ret_3, st'_1 == ((realm_ipa_bits_spec' ret_0 (lens 283 st)));
						when sh_0 == (
								((st.(repl))
									((st.(oracle)) ((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))
									(sh.[globals].[g_granules] :<
										(((sh.(globals)).(g_granules)) #
											((v_0 + ((- MEM0_PHYS))) >> (12)) ==
											((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))))));
						match ((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val))) with
						| None =>
							rely (
								(((((((sh.(globals)).(g_granules)) #
									((v_0 + ((- MEM0_PHYS))) >> (12)) ==
									((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
									(((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)))) =
									(0)));
							rely (
								((("granules" = ("granules")) /\ ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) mod (16)) = (0)))) /\
									((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)))));
							if (
								((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
									(5)) =?
									(0)))
							then (
								when cid == ((((((sh_0.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val)));
								when st_9 == (
										(rtt_walk_lock_unlock_spec
											(mkPtr "stack_s_rtt_walk" 0)
											(mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
											ret_2
											ret_3
											v_1
											3
											(lens 284 st)));
								rely ((((st_9.(share)).(granule_data)) = ((sh_0.(granule_data)))));
								rely ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
								rely ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
								if ((((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level)) =? (3))
								then (
									rely (
										((((("granules" = ("granules")) /\ ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
											((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
											((6 >= (0)))) /\
											((6 <= (24)))));
									when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
									when ret_5 == ((buffer_map_spec' 6 ret_4 false));
									rely ((((ret_5.(pbase)) = ("granule_data")) /\ (((ret_5.(poffset)) >= (0)))));
									when v_28, st_14 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_9));
									rely ((((st_14.(share)).(granule_data)) = (((st_9.(share)).(granule_data)))));
									if ((v_28 & (63)) =? (4))
									then (
										when ret_6 == ((s2tte_pa_spec' v_28 3));
										rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
										rely (
											(((((ret_6 - (MEM0_PHYS)) >= (0)) /\ (((ret_6 - (4294967296)) < (0)))) \/ ((((ret_6 - (MEM1_PHYS)) >= (0)) /\ (((ret_6 - (556198264832)) < (0)))))) /\
												(((ret_6 & (4095)) = (0)))));
										if ((ret_6 - (MEM1_PHYS)) >=? (0))
										then (
											when sh_1 == (
													((st_14.(repl))
														((st_14.(oracle)) (st_14.(log)))
														(((st_14.(share)).[globals].[g_granules] :<
															((((st_14.(share)).(globals)).(g_granules)) #
																(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																	((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																		(((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[granule_data] :<
															(((st_14.(share)).(granule_data)) #
																(((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
																((((st_14.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
																	(((((st_14.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
																		(((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
																		8))))));
											match ((((((sh_1.(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val))) with
											| None =>
												rely (
													((((((((st_14.(share)).(globals)).(g_granules)) #
														(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
														(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
															((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																(((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1)))))) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) -
														(((((sh_1.(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)))) =
														(0)));
												if ((((((sh_1.(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) - (4)) =? (0))
												then (
													rely (((0 = (0)) /\ (((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) >= (0)))));
													when st_20 == ((granule_memzero_spec (mkPtr "granules" (((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16))) 1 (lens 285 st_14)));
													when cid_0 == (((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val)));
													when cid_1 == (
															(((((((st_20.(share)).(globals)).(g_granules)) #
																((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< None).[e_state_s_granule] :< 1)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
													(Some (
														0  ,
														((lens 250 st_20).[share].[globals].[g_granules] :<
															(((((st_20.(share)).(globals)).(g_granules)) #
																((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< None).[e_state_s_granule] :< 1)) #
																(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																((((((st_20.(share)).(globals)).(g_granules)) #
																	((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																	((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< None).[e_state_s_granule] :< 1)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																	None)))
													)))
												else None
											| (Some cid_0) => None
											end)
										else (
											when sh_1 == (
													((st_14.(repl))
														((st_14.(oracle)) (st_14.(log)))
														(((st_14.(share)).[globals].[g_granules] :<
															((((st_14.(share)).(globals)).(g_granules)) #
																(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																	((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																		(((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[granule_data] :<
															(((st_14.(share)).(granule_data)) #
																(((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
																((((st_14.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
																	(((((st_14.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
																		(((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
																		8))))));
											match ((((((sh_1.(globals)).(g_granules)) @ ((ret_6 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val))) with
											| None =>
												rely (
													((((((((st_14.(share)).(globals)).(g_granules)) #
														(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
														(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
															((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																(((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1)))))) @ ((ret_6 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) -
														(((((sh_1.(globals)).(g_granules)) @ ((ret_6 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)))) =
														(0)));
												if ((((((sh_1.(globals)).(g_granules)) @ ((ret_6 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (4)) =? (0))
												then (
													when st_20 == ((granule_memzero_spec (mkPtr "granules" (((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16))) 1 (lens 286 st_14)));
													when cid_0 == (((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16))).(e_lock)).(e_val)));
													when cid_1 == (
															(((((((st_20.(share)).(globals)).(g_granules)) #
																((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16)) ==
																((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16))).[e_lock].[e_val] :< None).[e_state_s_granule] :< 1)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
													(Some (
														0  ,
														((lens 253 st_20).[share].[globals].[g_granules] :<
															(((((st_20.(share)).(globals)).(g_granules)) #
																((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16)) ==
																((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16))).[e_lock].[e_val] :< None).[e_state_s_granule] :< 1)) #
																(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																((((((st_20.(share)).(globals)).(g_granules)) #
																	((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16)) ==
																	((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16))).[e_lock].[e_val] :< None).[e_state_s_granule] :< 1)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																	None)))
													)))
												else None
											| (Some cid_0) => None
											end))
									else (
										when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
										(Some (
											9  ,
											((lens 254 st_14).[share].[globals].[g_granules] :<
												((((st_14.(share)).(globals)).(g_granules)) #
													(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
													(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
										))))
								else (
									when cid_0 == (((((((st_9.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
									(Some (
										((((((((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
											((((((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
										((lens 255 st_9).[share].[globals].[g_granules] :<
											((((st_9.(share)).(globals)).(g_granules)) #
												(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
												(((((st_9.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
									))))
							else (
								when cid == (
										((((((sh_0.(globals)).(g_granules)) #
											(((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
											((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
												None)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val)));
								when st_9 == (
										(rtt_walk_lock_unlock_spec
											(mkPtr "stack_s_rtt_walk" 0)
											(mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
											ret_2
											ret_3
											v_1
											3
											(lens 287 st)));
								rely ((((st_9.(share)).(granule_data)) = ((sh_0.(granule_data)))));
								rely ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
								rely ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
								if ((((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level)) =? (3))
								then (
									rely (
										((((("granules" = ("granules")) /\ ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
											((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
											((6 >= (0)))) /\
											((6 <= (24)))));
									when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
									when ret_5 == ((buffer_map_spec' 6 ret_4 false));
									rely ((((ret_5.(pbase)) = ("granule_data")) /\ (((ret_5.(poffset)) >= (0)))));
									when v_28, st_14 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_9));
									rely ((((st_14.(share)).(granule_data)) = (((st_9.(share)).(granule_data)))));
									if ((v_28 & (63)) =? (4))
									then (
										when ret_6 == ((s2tte_pa_spec' v_28 3));
										rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
										rely (
											(((((ret_6 - (MEM0_PHYS)) >= (0)) /\ (((ret_6 - (4294967296)) < (0)))) \/ ((((ret_6 - (MEM1_PHYS)) >= (0)) /\ (((ret_6 - (556198264832)) < (0)))))) /\
												(((ret_6 & (4095)) = (0)))));
										if ((ret_6 - (MEM1_PHYS)) >=? (0))
										then (
											when sh_1 == (
													((st_14.(repl))
														((st_14.(oracle)) (st_14.(log)))
														(((st_14.(share)).[globals].[g_granules] :<
															((((st_14.(share)).(globals)).(g_granules)) #
																(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																	((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																		(((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[granule_data] :<
															(((st_14.(share)).(granule_data)) #
																(((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
																((((st_14.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
																	(((((st_14.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
																		(((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
																		8))))));
											match ((((((sh_1.(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val))) with
											| None =>
												rely (
													((((((((st_14.(share)).(globals)).(g_granules)) #
														(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
														(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
															((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																(((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1)))))) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) -
														(((((sh_1.(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)))) =
														(0)));
												if ((((((sh_1.(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) - (4)) =? (0))
												then (
													rely (((0 = (0)) /\ (((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) >= (0)))));
													when st_20 == ((granule_memzero_spec (mkPtr "granules" (((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16))) 1 (lens 288 st_14)));
													when cid_0 == (((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val)));
													when cid_1 == (
															(((((((st_20.(share)).(globals)).(g_granules)) #
																((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< None).[e_state_s_granule] :< 1)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
													(Some (
														0  ,
														((lens 260 st_20).[share].[globals].[g_granules] :<
															(((((st_20.(share)).(globals)).(g_granules)) #
																((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< None).[e_state_s_granule] :< 1)) #
																(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																((((((st_20.(share)).(globals)).(g_granules)) #
																	((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																	((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< None).[e_state_s_granule] :< 1)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																	None)))
													)))
												else None
											| (Some cid_0) => None
											end)
										else (
											when sh_1 == (
													((st_14.(repl))
														((st_14.(oracle)) (st_14.(log)))
														(((st_14.(share)).[globals].[g_granules] :<
															((((st_14.(share)).(globals)).(g_granules)) #
																(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																	((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																		(((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[granule_data] :<
															(((st_14.(share)).(granule_data)) #
																(((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
																((((st_14.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
																	(((((st_14.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
																		(((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
																		8))))));
											match ((((((sh_1.(globals)).(g_granules)) @ ((ret_6 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val))) with
											| None =>
												rely (
													((((((((st_14.(share)).(globals)).(g_granules)) #
														(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
														(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
															((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																(((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1)))))) @ ((ret_6 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) -
														(((((sh_1.(globals)).(g_granules)) @ ((ret_6 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)))) =
														(0)));
												if ((((((sh_1.(globals)).(g_granules)) @ ((ret_6 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (4)) =? (0))
												then (
													when st_20 == ((granule_memzero_spec (mkPtr "granules" (((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16))) 1 (lens 289 st_14)));
													when cid_0 == (((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16))).(e_lock)).(e_val)));
													when cid_1 == (
															(((((((st_20.(share)).(globals)).(g_granules)) #
																((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16)) ==
																((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16))).[e_lock].[e_val] :< None).[e_state_s_granule] :< 1)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
													(Some (
														0  ,
														((lens 263 st_20).[share].[globals].[g_granules] :<
															(((((st_20.(share)).(globals)).(g_granules)) #
																((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16)) ==
																((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16))).[e_lock].[e_val] :< None).[e_state_s_granule] :< 1)) #
																(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																((((((st_20.(share)).(globals)).(g_granules)) #
																	((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16)) ==
																	((((((st_20.(share)).(globals)).(g_granules)) @ ((((ret_6 + ((- MEM0_PHYS))) >> (12)) * (16)) / (16))).[e_lock].[e_val] :< None).[e_state_s_granule] :< 1)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																	None)))
													)))
												else None
											| (Some cid_0) => None
											end))
									else (
										when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
										(Some (
											9  ,
											((lens 264 st_14).[share].[globals].[g_granules] :<
												((((st_14.(share)).(globals)).(g_granules)) #
													(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
													(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
										))))
								else (
									when cid_0 == (((((((st_9.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
									(Some (
										((((((((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
											((((((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
										((lens 265 st_9).[share].[globals].[g_granules] :<
											((((st_9.(share)).(globals)).(g_granules)) #
												(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
												(((((st_9.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
									))))
						| (Some cid) => None
						end)
					else (Some (8589935105, (lens 290 st))))
				else (Some (4294967553, (lens 291 st)))
			| (Some cid) => None
			end).
	
	Definition smc_rtt_read_entry_spec (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Ptr) (st: RData) : (option RData) :=
		rely ((((v_3.(pbase)) = ("stack_s_smc_result")) /\ (((v_3.(poffset)) = (0)))));
		rely (
			(((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - (4294967296)) < (0)))) \/ ((((v_0 - (MEM1_PHYS)) >= (0)) /\ (((v_0 - (556198264832)) < (0)))))) /\
				(((v_0 & (4095)) = (0)))));
		if ((v_0 - (MEM1_PHYS)) >=? (0))
		then (
			when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
			match ((((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val))) with
			| None =>
				rely (
					(((((((st.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) -
						(((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)))) =
						(0)));
				if ((((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) - (2)) =? (0))
				then (
					when ret == ((granule_addr_spec' (mkPtr "granules" (((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)))));
					when ret_0 == ((buffer_map_spec' 2 ret false));
					rely ((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))));
					rely (((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))) /\ ((((ret_0.(poffset)) mod (4096)) = (0)))));
					rely ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
					when ret_1, st' == ((validate_rtt_entry_cmds_spec' v_1 v_2 ret_0 (lens 113 st)));
					if (ret_1 =? (0))
					then (
						rely ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)));
						rely ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (MEM0_VIRT)) < (0)));
						when ret_2, st'_0 == ((realm_rtt_starting_level_spec' ret_0 (lens 114 st)));
						when ret_3, st'_1 == ((realm_ipa_bits_spec' ret_0 (lens 115 st)));
						when sh_0 == (
								((st.(repl))
									((st.(oracle)) ((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))
									(sh.[globals].[g_granules] :<
										(((sh.(globals)).(g_granules)) #
											((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
											((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))))));
						match ((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val))) with
						| None =>
							rely (
								(((((((sh.(globals)).(g_granules)) #
									((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
									((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
									(((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)))) =
									(0)));
							rely (
								((("granules" = ("granules")) /\ ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) mod (16)) = (0)))) /\
									((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)))));
							if (
								((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
									(5)) =?
									(0)))
							then (
								when cid == ((((((sh_0.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val)));
								when st_9 == (
										(rtt_walk_lock_unlock_spec
											(mkPtr "stack_s_rtt_walk" 0)
											(mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
											ret_2
											ret_3
											v_1
											v_2
											(lens 116 st)));
								rely ((((st_9.(share)).(granule_data)) = ((sh_0.(granule_data)))));
								rely ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
								rely ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
								rely (
									((((("granules" = ("granules")) /\ ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
										((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
										((6 >= (0)))) /\
										((6 <= (24)))));
								when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
								when ret_5 == ((buffer_map_spec' 6 ret_4 false));
								rely ((((ret_5.(pbase)) = ("granule_data")) /\ (((ret_5.(poffset)) >= (0)))));
								when v_29, st_14 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_9));
								rely ((((st_14.(share)).(granule_data)) = (((st_9.(share)).(granule_data)))));
								if ((v_29 & (63)) =? (0))
								then (
									when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
									(Some ((lens 118 st_14).[share].[globals].[g_granules] :<
										((((st_14.(share)).(globals)).(g_granules)) #
											(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
											(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))))
								else (
									if ((v_29 & (63)) =? (8))
									then (
										when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
										(Some ((lens 120 st_14).[share].[globals].[g_granules] :<
											((((st_14.(share)).(globals)).(g_granules)) #
												(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
												(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))))
									else (
										if ((v_29 & (63)) =? (4))
										then (
											when ret_6 == ((s2tte_pa_spec' v_29 (((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level))));
											when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
											(Some ((lens 122 st_14).[share].[globals].[g_granules] :<
												((((st_14.(share)).(globals)).(g_granules)) #
													(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
													(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))))
										else (
											when ret_6 == ((s2tte_is_valid_spec' v_29 (((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level))));
											if ret_6
											then (
												when ret_7 == ((s2tte_pa_spec' v_29 (((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level))));
												when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
												(Some ((lens 124 st_14).[share].[globals].[g_granules] :<
													((((st_14.(share)).(globals)).(g_granules)) #
														(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
														(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))))
											else (
												when ret_7 == ((s2tte_is_valid_ns_spec' v_29 (((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level))));
												if ret_7
												then (
													when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
													(Some ((lens 126 st_14).[share].[globals].[g_granules] :<
														((((st_14.(share)).(globals)).(g_granules)) #
															(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
															(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))))
												else (
													if (((((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level)) <? (3)) && (((v_29 & (3)) =? (3))))
													then (
														when ret_8 == ((s2tte_pa_spec' v_29 (((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level))));
														when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
														(Some ((lens 128 st_14).[share].[globals].[g_granules] :<
															((((st_14.(share)).(globals)).(g_granules)) #
																(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))))
													else (
														when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
														(Some ((lens 130 st_14).[share].[globals].[g_granules] :<
															((((st_14.(share)).(globals)).(g_granules)) #
																(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))))))))))
							else (
								when cid == (
										((((((sh_0.(globals)).(g_granules)) #
											(((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
											((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
												None)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val)));
								when st_9 == (
										(rtt_walk_lock_unlock_spec
											(mkPtr "stack_s_rtt_walk" 0)
											(mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
											ret_2
											ret_3
											v_1
											v_2
											(lens 131 st)));
								rely ((((st_9.(share)).(granule_data)) = ((sh_0.(granule_data)))));
								rely ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
								rely ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
								rely (
									((((("granules" = ("granules")) /\ ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
										((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
										((6 >= (0)))) /\
										((6 <= (24)))));
								when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
								when ret_5 == ((buffer_map_spec' 6 ret_4 false));
								rely ((((ret_5.(pbase)) = ("granule_data")) /\ (((ret_5.(poffset)) >= (0)))));
								when v_29, st_14 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_9));
								rely ((((st_14.(share)).(granule_data)) = (((st_9.(share)).(granule_data)))));
								if ((v_29 & (63)) =? (0))
								then (
									when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
									(Some ((lens 133 st_14).[share].[globals].[g_granules] :<
										((((st_14.(share)).(globals)).(g_granules)) #
											(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
											(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))))
								else (
									if ((v_29 & (63)) =? (8))
									then (
										when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
										(Some ((lens 135 st_14).[share].[globals].[g_granules] :<
											((((st_14.(share)).(globals)).(g_granules)) #
												(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
												(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))))
									else (
										if ((v_29 & (63)) =? (4))
										then (
											when ret_6 == ((s2tte_pa_spec' v_29 (((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level))));
											when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
											(Some ((lens 137 st_14).[share].[globals].[g_granules] :<
												((((st_14.(share)).(globals)).(g_granules)) #
													(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
													(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))))
										else (
											when ret_6 == ((s2tte_is_valid_spec' v_29 (((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level))));
											if ret_6
											then (
												when ret_7 == ((s2tte_pa_spec' v_29 (((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level))));
												when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
												(Some ((lens 139 st_14).[share].[globals].[g_granules] :<
													((((st_14.(share)).(globals)).(g_granules)) #
														(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
														(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))))
											else (
												when ret_7 == ((s2tte_is_valid_ns_spec' v_29 (((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level))));
												if ret_7
												then (
													when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
													(Some ((lens 141 st_14).[share].[globals].[g_granules] :<
														((((st_14.(share)).(globals)).(g_granules)) #
															(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
															(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))))
												else (
													if (((((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level)) <? (3)) && (((v_29 & (3)) =? (3))))
													then (
														when ret_8 == ((s2tte_pa_spec' v_29 (((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level))));
														when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
														(Some ((lens 143 st_14).[share].[globals].[g_granules] :<
															((((st_14.(share)).(globals)).(g_granules)) #
																(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))))
													else (
														when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
														(Some ((lens 145 st_14).[share].[globals].[g_granules] :<
															((((st_14.(share)).(globals)).(g_granules)) #
																(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))))))))))
						| (Some cid) => None
						end)
					else (Some (lens 147 st)))
				else (Some (lens 149 st))
			| (Some cid) => None
			end)
		else (
			when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
			match ((((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val))) with
			| None =>
				rely (
					(((((((st.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) -
						(((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)))) =
						(0)));
				if ((((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (2)) =? (0))
				then (
					when ret == ((granule_addr_spec' (mkPtr "granules" (((v_0 + ((- MEM0_PHYS))) >> (12)) * (16)))));
					when ret_0 == ((buffer_map_spec' 2 ret false));
					rely ((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))));
					rely (((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))) /\ ((((ret_0.(poffset)) mod (4096)) = (0)))));
					rely ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
					when ret_1, st' == ((validate_rtt_entry_cmds_spec' v_1 v_2 ret_0 (lens 150 st)));
					if (ret_1 =? (0))
					then (
						rely ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)));
						rely ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (MEM0_VIRT)) < (0)));
						when ret_2, st'_0 == ((realm_rtt_starting_level_spec' ret_0 (lens 151 st)));
						when ret_3, st'_1 == ((realm_ipa_bits_spec' ret_0 (lens 152 st)));
						when sh_0 == (
								((st.(repl))
									((st.(oracle)) ((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))
									(sh.[globals].[g_granules] :<
										(((sh.(globals)).(g_granules)) #
											((v_0 + ((- MEM0_PHYS))) >> (12)) ==
											((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))))));
						match ((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val))) with
						| None =>
							rely (
								(((((((sh.(globals)).(g_granules)) #
									((v_0 + ((- MEM0_PHYS))) >> (12)) ==
									((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
									(((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)))) =
									(0)));
							rely (
								((("granules" = ("granules")) /\ ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) mod (16)) = (0)))) /\
									((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)))));
							if (
								((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
									(5)) =?
									(0)))
							then (
								when cid == ((((((sh_0.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val)));
								when st_9 == (
										(rtt_walk_lock_unlock_spec
											(mkPtr "stack_s_rtt_walk" 0)
											(mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
											ret_2
											ret_3
											v_1
											v_2
											(lens 153 st)));
								rely ((((st_9.(share)).(granule_data)) = ((sh_0.(granule_data)))));
								rely ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
								rely ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
								rely (
									((((("granules" = ("granules")) /\ ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
										((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
										((6 >= (0)))) /\
										((6 <= (24)))));
								when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
								when ret_5 == ((buffer_map_spec' 6 ret_4 false));
								rely ((((ret_5.(pbase)) = ("granule_data")) /\ (((ret_5.(poffset)) >= (0)))));
								when v_29, st_14 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_9));
								rely ((((st_14.(share)).(granule_data)) = (((st_9.(share)).(granule_data)))));
								if ((v_29 & (63)) =? (0))
								then (
									when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
									(Some ((lens 155 st_14).[share].[globals].[g_granules] :<
										((((st_14.(share)).(globals)).(g_granules)) #
											(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
											(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))))
								else (
									if ((v_29 & (63)) =? (8))
									then (
										when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
										(Some ((lens 157 st_14).[share].[globals].[g_granules] :<
											((((st_14.(share)).(globals)).(g_granules)) #
												(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
												(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))))
									else (
										if ((v_29 & (63)) =? (4))
										then (
											when ret_6 == ((s2tte_pa_spec' v_29 (((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level))));
											when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
											(Some ((lens 159 st_14).[share].[globals].[g_granules] :<
												((((st_14.(share)).(globals)).(g_granules)) #
													(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
													(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))))
										else (
											when ret_6 == ((s2tte_is_valid_spec' v_29 (((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level))));
											if ret_6
											then (
												when ret_7 == ((s2tte_pa_spec' v_29 (((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level))));
												when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
												(Some ((lens 161 st_14).[share].[globals].[g_granules] :<
													((((st_14.(share)).(globals)).(g_granules)) #
														(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
														(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))))
											else (
												when ret_7 == ((s2tte_is_valid_ns_spec' v_29 (((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level))));
												if ret_7
												then (
													when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
													(Some ((lens 163 st_14).[share].[globals].[g_granules] :<
														((((st_14.(share)).(globals)).(g_granules)) #
															(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
															(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))))
												else (
													if (((((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level)) <? (3)) && (((v_29 & (3)) =? (3))))
													then (
														when ret_8 == ((s2tte_pa_spec' v_29 (((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level))));
														when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
														(Some ((lens 165 st_14).[share].[globals].[g_granules] :<
															((((st_14.(share)).(globals)).(g_granules)) #
																(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))))
													else (
														when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
														(Some ((lens 167 st_14).[share].[globals].[g_granules] :<
															((((st_14.(share)).(globals)).(g_granules)) #
																(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))))))))))
							else (
								when cid == (
										((((((sh_0.(globals)).(g_granules)) #
											(((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
											((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
												None)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val)));
								when st_9 == (
										(rtt_walk_lock_unlock_spec
											(mkPtr "stack_s_rtt_walk" 0)
											(mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
											ret_2
											ret_3
											v_1
											v_2
											(lens 168 st)));
								rely ((((st_9.(share)).(granule_data)) = ((sh_0.(granule_data)))));
								rely ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
								rely ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
								rely (
									((((("granules" = ("granules")) /\ ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
										((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
										((6 >= (0)))) /\
										((6 <= (24)))));
								when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
								when ret_5 == ((buffer_map_spec' 6 ret_4 false));
								rely ((((ret_5.(pbase)) = ("granule_data")) /\ (((ret_5.(poffset)) >= (0)))));
								when v_29, st_14 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_9));
								rely ((((st_14.(share)).(granule_data)) = (((st_9.(share)).(granule_data)))));
								if ((v_29 & (63)) =? (0))
								then (
									when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
									(Some ((lens 170 st_14).[share].[globals].[g_granules] :<
										((((st_14.(share)).(globals)).(g_granules)) #
											(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
											(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))))
								else (
									if ((v_29 & (63)) =? (8))
									then (
										when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
										(Some ((lens 172 st_14).[share].[globals].[g_granules] :<
											((((st_14.(share)).(globals)).(g_granules)) #
												(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
												(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))))
									else (
										if ((v_29 & (63)) =? (4))
										then (
											when ret_6 == ((s2tte_pa_spec' v_29 (((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level))));
											when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
											(Some ((lens 174 st_14).[share].[globals].[g_granules] :<
												((((st_14.(share)).(globals)).(g_granules)) #
													(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
													(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))))
										else (
											when ret_6 == ((s2tte_is_valid_spec' v_29 (((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level))));
											if ret_6
											then (
												when ret_7 == ((s2tte_pa_spec' v_29 (((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level))));
												when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
												(Some ((lens 176 st_14).[share].[globals].[g_granules] :<
													((((st_14.(share)).(globals)).(g_granules)) #
														(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
														(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))))
											else (
												when ret_7 == ((s2tte_is_valid_ns_spec' v_29 (((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level))));
												if ret_7
												then (
													when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
													(Some ((lens 178 st_14).[share].[globals].[g_granules] :<
														((((st_14.(share)).(globals)).(g_granules)) #
															(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
															(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))))
												else (
													if (((((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level)) <? (3)) && (((v_29 & (3)) =? (3))))
													then (
														when ret_8 == ((s2tte_pa_spec' v_29 (((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level))));
														when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
														(Some ((lens 180 st_14).[share].[globals].[g_granules] :<
															((((st_14.(share)).(globals)).(g_granules)) #
																(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))))
													else (
														when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
														(Some ((lens 182 st_14).[share].[globals].[g_granules] :<
															((((st_14.(share)).(globals)).(g_granules)) #
																(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))))))))))
						| (Some cid) => None
						end)
					else (Some (lens 184 st)))
				else (Some (lens 186 st))
			| (Some cid) => None
			end).
	
	Definition smc_rtt_unmap_protected_spec (v_0: Z) (v_1: Z) (v_2: Z) (st: RData) : (option (Z * RData)) :=
		rely (
			(((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - (4294967296)) < (0)))) \/ ((((v_0 - (MEM1_PHYS)) >= (0)) /\ (((v_0 - (556198264832)) < (0)))))) /\
				(((v_0 & (4095)) = (0)))));
		if ((v_0 - (MEM1_PHYS)) >=? (0))
		then (
			when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
			match ((((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val))) with
			| None =>
				rely (
					(((((((st.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) -
						(((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)))) =
						(0)));
				if ((((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) - (2)) =? (0))
				then (
					when ret == ((granule_addr_spec' (mkPtr "granules" (((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)))));
					when ret_0 == ((buffer_map_spec' 2 ret false));
					rely (((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))) /\ ((((ret_0.(poffset)) mod (4096)) = (0)))));
					rely ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
					when ret_1, st' == ((validate_rtt_map_cmds_spec' v_1 v_2 ret_0 (lens 150 st)));
					if (ret_1 =? (0))
					then (
						rely ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)));
						rely ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (MEM0_VIRT)) < (0)));
						when ret_2, st'_0 == ((realm_rtt_starting_level_spec' ret_0 (lens 151 st)));
						when ret_3, st'_1 == ((realm_ipa_bits_spec' ret_0 (lens 152 st)));
						when sh_0 == (
								((st.(repl))
									((st.(oracle)) ((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))
									(sh.[globals].[g_granules] :<
										(((sh.(globals)).(g_granules)) #
											((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
											((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))))));
						match ((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val))) with
						| None =>
							rely (
								(((((((sh.(globals)).(g_granules)) #
									((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
									((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
									(((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)))) =
									(0)));
							rely (
								((("granules" = ("granules")) /\ ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) mod (16)) = (0)))) /\
									((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)))));
							if (
								((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
									(5)) =?
									(0)))
							then (
								when cid == ((((((sh_0.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val)));
								when st_10 == (
										(rtt_walk_lock_unlock_spec
											(mkPtr "stack_s_rtt_walk" 0)
											(mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
											ret_2
											ret_3
											v_1
											v_2
											(lens 153 st)));
								rely ((((st_10.(share)).(granule_data)) = ((sh_0.(granule_data)))));
								rely ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
								rely ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
								if (((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) - (v_2)) =? (0))
								then (
									rely (
										((((("granules" = ("granules")) /\ ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
											((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
											((6 >= (0)))) /\
											((6 <= (24)))));
									when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
									when ret_5 == ((buffer_map_spec' 6 ret_4 false));
									when v_32, st_15 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_10));
									rely ((((st_15.(share)).(granule_data)) = (((st_10.(share)).(granule_data)))));
									when ret_6 == ((s2tte_is_valid_spec' v_32 v_2));
									if ret_6
									then (
										when ret_7 == ((s2tte_pa_spec' v_32 v_2));
										rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
										if (v_2 =? (3))
										then (
											match ((stage2_tlbi_ipa_loop210 (z_to_nat 0) false v_1 4096 (lens 154 st_15))) with
											| (Some (__break__, v__13, v__912, st_4)) =>
												when cid_0 == (((((((st_4.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
												(Some (
													0  ,
													((lens 155 st_4).[share].[globals].[g_granules] :<
														((((st_4.(share)).(globals)).(g_granules)) #
															(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
															(((((st_4.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
												))
											| None => None
											end)
										else (
											when cid_0 == (((((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
											(Some (
												0  ,
												((lens 157 st_15).[share].[globals].[g_granules] :<
													((((st_15.(share)).(globals)).(g_granules)) #
														(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
														(((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
											))))
									else (
										when cid_0 == (((((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
										(Some (
											9  ,
											((lens 104 st_15).[share].[globals].[g_granules] :<
												((((st_15.(share)).(globals)).(g_granules)) #
													(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
													(((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
										))))
								else (
									when cid_0 == (((((((st_10.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
									(Some (
										((((((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
											((((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
										((lens 105 st_10).[share].[globals].[g_granules] :<
											((((st_10.(share)).(globals)).(g_granules)) #
												(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
												(((((st_10.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
									))))
							else (
								when cid == (
										((((((sh_0.(globals)).(g_granules)) #
											(((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
											((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
												None)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val)));
								when st_10 == (
										(rtt_walk_lock_unlock_spec
											(mkPtr "stack_s_rtt_walk" 0)
											(mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
											ret_2
											ret_3
											v_1
											v_2
											(lens 158 st)));
								rely ((((st_10.(share)).(granule_data)) = ((sh_0.(granule_data)))));
								rely ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
								rely ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
								if (((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) - (v_2)) =? (0))
								then (
									rely (
										((((("granules" = ("granules")) /\ ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
											((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
											((6 >= (0)))) /\
											((6 <= (24)))));
									when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
									when ret_5 == ((buffer_map_spec' 6 ret_4 false));
									when v_32, st_15 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_10));
									rely ((((st_15.(share)).(granule_data)) = (((st_10.(share)).(granule_data)))));
									when ret_6 == ((s2tte_is_valid_spec' v_32 v_2));
									if ret_6
									then (
										when ret_7 == ((s2tte_pa_spec' v_32 v_2));
										rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
										if (v_2 =? (3))
										then (
											match ((stage2_tlbi_ipa_loop210 (z_to_nat 0) false v_1 4096 (lens 159 st_15))) with
											| (Some (__break__, v__13, v__912, st_4)) =>
												when cid_0 == (((((((st_4.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
												(Some (
													0  ,
													((lens 160 st_4).[share].[globals].[g_granules] :<
														((((st_4.(share)).(globals)).(g_granules)) #
															(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
															(((((st_4.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
												))
											| None => None
											end)
										else (
											when cid_0 == (((((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
											(Some (
												0  ,
												((lens 162 st_15).[share].[globals].[g_granules] :<
													((((st_15.(share)).(globals)).(g_granules)) #
														(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
														(((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
											))))
									else (
										when cid_0 == (((((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
										(Some (
											9  ,
											((lens 114 st_15).[share].[globals].[g_granules] :<
												((((st_15.(share)).(globals)).(g_granules)) #
													(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
													(((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
										))))
								else (
									when cid_0 == (((((((st_10.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
									(Some (
										((((((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
											((((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
										((lens 115 st_10).[share].[globals].[g_granules] :<
											((((st_10.(share)).(globals)).(g_granules)) #
												(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
												(((((st_10.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
									))))
						| (Some cid) => None
						end)
					else (Some ((((((((ret_1 >> (32)) + (2)) << (32)) + (ret_1)) >> (24)) & (4294967040)) |' (((((ret_1 >> (32)) + (2)) << (32)) + (ret_1)))), (lens 163 st))))
				else (Some (4294967553, (lens 164 st)))
			| (Some cid) => None
			end)
		else (
			when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
			match ((((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val))) with
			| None =>
				rely (
					(((((((st.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) -
						(((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)))) =
						(0)));
				if ((((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (2)) =? (0))
				then (
					when ret == ((granule_addr_spec' (mkPtr "granules" (((v_0 + ((- MEM0_PHYS))) >> (12)) * (16)))));
					when ret_0 == ((buffer_map_spec' 2 ret false));
					rely (((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))) /\ ((((ret_0.(poffset)) mod (4096)) = (0)))));
					rely ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
					when ret_1, st' == ((validate_rtt_map_cmds_spec' v_1 v_2 ret_0 (lens 165 st)));
					if (ret_1 =? (0))
					then (
						rely ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)));
						rely ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (MEM0_VIRT)) < (0)));
						when ret_2, st'_0 == ((realm_rtt_starting_level_spec' ret_0 (lens 166 st)));
						when ret_3, st'_1 == ((realm_ipa_bits_spec' ret_0 (lens 167 st)));
						when sh_0 == (
								((st.(repl))
									((st.(oracle)) ((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))
									(sh.[globals].[g_granules] :<
										(((sh.(globals)).(g_granules)) #
											((v_0 + ((- MEM0_PHYS))) >> (12)) ==
											((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))))));
						match ((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val))) with
						| None =>
							rely (
								(((((((sh.(globals)).(g_granules)) #
									((v_0 + ((- MEM0_PHYS))) >> (12)) ==
									((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
									(((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)))) =
									(0)));
							rely (
								((("granules" = ("granules")) /\ ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) mod (16)) = (0)))) /\
									((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)))));
							if (
								((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
									(5)) =?
									(0)))
							then (
								when cid == ((((((sh_0.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val)));
								when st_10 == (
										(rtt_walk_lock_unlock_spec
											(mkPtr "stack_s_rtt_walk" 0)
											(mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
											ret_2
											ret_3
											v_1
											v_2
											(lens 168 st)));
								rely ((((st_10.(share)).(granule_data)) = ((sh_0.(granule_data)))));
								rely ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
								rely ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
								if (((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) - (v_2)) =? (0))
								then (
									rely (
										((((("granules" = ("granules")) /\ ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
											((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
											((6 >= (0)))) /\
											((6 <= (24)))));
									when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
									when ret_5 == ((buffer_map_spec' 6 ret_4 false));
									when v_32, st_15 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_10));
									rely ((((st_15.(share)).(granule_data)) = (((st_10.(share)).(granule_data)))));
									when ret_6 == ((s2tte_is_valid_spec' v_32 v_2));
									if ret_6
									then (
										when ret_7 == ((s2tte_pa_spec' v_32 v_2));
										rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
										if (v_2 =? (3))
										then (
											match ((stage2_tlbi_ipa_loop210 (z_to_nat 0) false v_1 4096 (lens 169 st_15))) with
											| (Some (__break__, v__13, v__912, st_4)) =>
												when cid_0 == (((((((st_4.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
												(Some (
													0  ,
													((lens 170 st_4).[share].[globals].[g_granules] :<
														((((st_4.(share)).(globals)).(g_granules)) #
															(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
															(((((st_4.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
												))
											| None => None
											end)
										else (
											when cid_0 == (((((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
											(Some (
												0  ,
												((lens 172 st_15).[share].[globals].[g_granules] :<
													((((st_15.(share)).(globals)).(g_granules)) #
														(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
														(((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
											))))
									else (
										when cid_0 == (((((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
										(Some (
											9  ,
											((lens 134 st_15).[share].[globals].[g_granules] :<
												((((st_15.(share)).(globals)).(g_granules)) #
													(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
													(((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
										))))
								else (
									when cid_0 == (((((((st_10.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
									(Some (
										((((((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
											((((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
										((lens 135 st_10).[share].[globals].[g_granules] :<
											((((st_10.(share)).(globals)).(g_granules)) #
												(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
												(((((st_10.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
									))))
							else (
								when cid == (
										((((((sh_0.(globals)).(g_granules)) #
											(((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
											((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
												None)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val)));
								when st_10 == (
										(rtt_walk_lock_unlock_spec
											(mkPtr "stack_s_rtt_walk" 0)
											(mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
											ret_2
											ret_3
											v_1
											v_2
											(lens 173 st)));
								rely ((((st_10.(share)).(granule_data)) = ((sh_0.(granule_data)))));
								rely ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
								rely ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
								if (((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) - (v_2)) =? (0))
								then (
									rely (
										((((("granules" = ("granules")) /\ ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
											((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
											((6 >= (0)))) /\
											((6 <= (24)))));
									when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
									when ret_5 == ((buffer_map_spec' 6 ret_4 false));
									when v_32, st_15 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_10));
									rely ((((st_15.(share)).(granule_data)) = (((st_10.(share)).(granule_data)))));
									when ret_6 == ((s2tte_is_valid_spec' v_32 v_2));
									if ret_6
									then (
										when ret_7 == ((s2tte_pa_spec' v_32 v_2));
										rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
										if (v_2 =? (3))
										then (
											match ((stage2_tlbi_ipa_loop210 (z_to_nat 0) false v_1 4096 (lens 174 st_15))) with
											| (Some (__break__, v__13, v__912, st_4)) =>
												when cid_0 == (((((((st_4.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
												(Some (
													0  ,
													((lens 175 st_4).[share].[globals].[g_granules] :<
														((((st_4.(share)).(globals)).(g_granules)) #
															(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
															(((((st_4.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
												))
											| None => None
											end)
										else (
											when cid_0 == (((((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
											(Some (
												0  ,
												((lens 177 st_15).[share].[globals].[g_granules] :<
													((((st_15.(share)).(globals)).(g_granules)) #
														(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
														(((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
											))))
									else (
										when cid_0 == (((((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
										(Some (
											9  ,
											((lens 144 st_15).[share].[globals].[g_granules] :<
												((((st_15.(share)).(globals)).(g_granules)) #
													(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
													(((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
										))))
								else (
									when cid_0 == (((((((st_10.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
									(Some (
										((((((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
											((((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
										((lens 145 st_10).[share].[globals].[g_granules] :<
											((((st_10.(share)).(globals)).(g_granules)) #
												(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
												(((((st_10.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
									))))
						| (Some cid) => None
						end)
					else (Some ((((((((ret_1 >> (32)) + (2)) << (32)) + (ret_1)) >> (24)) & (4294967040)) |' (((((ret_1 >> (32)) + (2)) << (32)) + (ret_1)))), (lens 178 st))))
				else (Some (4294967553, (lens 179 st)))
			| (Some cid) => None
			end).
	
	Definition smc_rtt_destroy_spec (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
		rely (
			(((((v_1 - (MEM0_PHYS)) >= (0)) /\ (((v_1 - (4294967296)) < (0)))) \/ ((((v_1 - (MEM1_PHYS)) >= (0)) /\ (((v_1 - (556198264832)) < (0)))))) /\
				(((v_1 & (4095)) = (0)))));
		if ((v_1 - (MEM1_PHYS)) >=? (0))
		then (
			when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
			match ((((((sh.(globals)).(g_granules)) @ ((((v_1 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val))) with
			| None =>
				rely (
					(((((((st.(share)).(globals)).(g_granules)) @ ((((v_1 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) -
						(((((sh.(globals)).(g_granules)) @ ((((v_1 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)))) =
						(0)));
				if ((((((sh.(globals)).(g_granules)) @ ((((v_1 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) - (2)) =? (0))
				then (
					when ret == ((granule_addr_spec' (mkPtr "granules" (((v_1 + ((- MEM1_PHYS))) >> (524300)) * (16)))));
					when ret_0 == ((buffer_map_spec' 2 ret false));
					rely ((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))));
					rely (((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))) /\ ((((ret_0.(poffset)) mod (4096)) = (0)))));
					rely ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
					when ret_1, st' == ((validate_rtt_structure_cmds_spec' v_2 v_3 ret_0 (lens 280 st)));
					if (ret_1 =? (0))
					then (
						rely ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)));
						rely ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (MEM0_VIRT)) < (0)));
						when ret_2, st'_0 == ((realm_rtt_starting_level_spec' ret_0 (lens 281 st)));
						when ret_3, st'_1 == ((realm_ipa_bits_spec' ret_0 (lens 282 st)));
						when sh_0 == (
								((st.(repl))
									((st.(oracle)) ((EVT CPU_ID (ACQ ((((v_1 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))
									(sh.[globals].[g_granules] :<
										(((sh.(globals)).(g_granules)) #
											((((v_1 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
											((((sh.(globals)).(g_granules)) @ ((((v_1 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))))));
						match ((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val))) with
						| None =>
							rely (
								(((((((sh.(globals)).(g_granules)) #
									((((v_1 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
									((((sh.(globals)).(g_granules)) @ ((((v_1 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
									(((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)))) =
									(0)));
							rely (
								((("granules" = ("granules")) /\ ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) mod (16)) = (0)))) /\
									((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)))));
							if (
								((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
									(5)) =?
									(0)))
							then (
								when cid == ((((((sh_0.(globals)).(g_granules)) @ ((((v_1 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val)));
								when st_10 == (
										(rtt_walk_lock_unlock_spec
											(mkPtr "stack_s_rtt_walk" 0)
											(mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
											ret_2
											ret_3
											v_2
											(v_3 + ((- 1)))
											(lens 283 st)));
								rely ((((st_10.(share)).(granule_data)) = ((sh_0.(granule_data)))));
								rely ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
								rely ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
								if (((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) - ((v_3 + ((- 1))))) =? (0))
								then (
									rely (
										((((("granules" = ("granules")) /\ ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
											((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
											((6 >= (0)))) /\
											((6 <= (24)))));
									when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
									when ret_5 == ((buffer_map_spec' 6 ret_4 false));
									rely ((((ret_5.(pbase)) = ("granule_data")) /\ (((ret_5.(poffset)) >= (0)))));
									when v_34, st_15 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_10));
									rely ((((st_15.(share)).(granule_data)) = (((st_10.(share)).(granule_data)))));
									if (((v_3 + ((- 1))) <? (3)) && (((v_34 & (3)) =? (3))))
									then (
										when ret_6 == ((s2tte_pa_spec' v_34 (v_3 + ((- 1)))));
										if ((ret_6 - (v_0)) =? (0))
										then (
											rely (
												(((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - (4294967296)) < (0)))) \/ ((((v_0 - (MEM1_PHYS)) >= (0)) /\ (((v_0 - (556198264832)) < (0)))))) /\
													(((v_0 & (4095)) = (0)))));
											if ((v_0 - (MEM1_PHYS)) >=? (0))
											then (
												when sh_1 == (((st_15.(repl)) ((st_15.(oracle)) (st_15.(log))) (st_15.(share))));
												match ((((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val))) with
												| None =>
													rely (
														(((((((st_15.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) -
															(((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)))) =
															(0)));
													rely ((((((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) - (5)) =? (0)) = (true)));
													rely (((0 = (0)) /\ (((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) >= (0)))));
													if (((((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_ref)).(e_u_anon_3_0)) & (4095)) =? (0))
													then (
														when ret_7 == ((granule_addr_spec' (mkPtr "granules" (((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)))));
														when ret_8 == ((buffer_map_spec' 7 ret_7 false));
														rely ((((ret_8.(pbase)) = ("granule_data")) /\ (((ret_8.(poffset)) >= (0)))));
														rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
														when cid_0 == (
																(((((((sh_1.(globals)).(g_granules)) #
																	((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																	((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) #
																	(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((sh_1.(globals)).(g_granules)) #
																		((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																		((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																		((((((sh_1.(globals)).(g_granules)) #
																			((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																			((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																			(((((((sh_1.(globals)).(g_granules)) #
																				((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																				((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
																				((- 1)))))) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val)));
														when cid_1 == (
																((((((((sh_1.(globals)).(g_granules)) #
																	((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																	((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) #
																	(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((sh_1.(globals)).(g_granules)) #
																		((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																		((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																		((((((sh_1.(globals)).(g_granules)) #
																			((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																			((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																			(((((((sh_1.(globals)).(g_granules)) #
																				((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																				((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
																				((- 1)))))) #
																	((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																	(((((((sh_1.(globals)).(g_granules)) #
																		((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																		((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) #
																		(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((sh_1.(globals)).(g_granules)) #
																			((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																			((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((sh_1.(globals)).(g_granules)) #
																				((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																				((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((sh_1.(globals)).(g_granules)) #
																					((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																					((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
																					((- 1)))))) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :<
																		None).[e_state_s_granule] :<
																		1)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
														(Some (0, (lens 284 st_15))))
													else (
														when cid_0 == (
																((((((sh_1.(globals)).(g_granules)) #
																	((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																	((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< None)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
														(Some (4, (lens 285 st_15))))
												| (Some cid_0) => None
												end)
											else (
												when sh_1 == (((st_15.(repl)) ((st_15.(oracle)) (st_15.(log))) (st_15.(share))));
												match ((((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val))) with
												| None =>
													rely (
														(((((((st_15.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) -
															(((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)))) =
															(0)));
													rely ((((((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (5)) =? (0)) = (true)));
													if (((((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_ref)).(e_u_anon_3_0)) & (4095)) =? (0))
													then (
														when ret_7 == ((granule_addr_spec' (mkPtr "granules" (((v_0 + ((- MEM0_PHYS))) >> (12)) * (16)))));
														when ret_8 == ((buffer_map_spec' 7 ret_7 false));
														rely ((((ret_8.(pbase)) = ("granule_data")) /\ (((ret_8.(poffset)) >= (0)))));
														rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
														when cid_0 == (
																(((((((sh_1.(globals)).(g_granules)) #
																	((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																	((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) #
																	(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((sh_1.(globals)).(g_granules)) #
																		((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																		((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																		((((((sh_1.(globals)).(g_granules)) #
																			((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																			((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																			(((((((sh_1.(globals)).(g_granules)) #
																				((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																				((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
																				((- 1)))))) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val)));
														when cid_1 == (
																((((((((sh_1.(globals)).(g_granules)) #
																	((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																	((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) #
																	(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((sh_1.(globals)).(g_granules)) #
																		((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																		((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																		((((((sh_1.(globals)).(g_granules)) #
																			((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																			((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																			(((((((sh_1.(globals)).(g_granules)) #
																				((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																				((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
																				((- 1)))))) #
																	((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																	(((((((sh_1.(globals)).(g_granules)) #
																		((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																		((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) #
																		(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((sh_1.(globals)).(g_granules)) #
																			((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																			((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((sh_1.(globals)).(g_granules)) #
																				((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																				((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((sh_1.(globals)).(g_granules)) #
																					((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																					((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
																					((- 1)))))) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :<
																		None).[e_state_s_granule] :<
																		1)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
														(Some (0, (lens 286 st_15))))
													else (
														when cid_0 == (
																((((((sh_1.(globals)).(g_granules)) #
																	((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																	((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< None)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
														(Some (4, (lens 287 st_15))))
												| (Some cid_0) => None
												end))
										else (
											when cid_0 == (((((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
											(Some (
												4294967553  ,
												((lens 224 st_15).[share].[globals].[g_granules] :<
													((((st_15.(share)).(globals)).(g_granules)) #
														(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
														(((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
											))))
									else (
										when cid_0 == (((((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
										(Some (
											((((((v_3 + ((- 1))) << (32)) + (8)) >> (24)) & (4294967040)) |' ((((v_3 + ((- 1))) << (32)) + (8))))  ,
											((lens 225 st_15).[share].[globals].[g_granules] :<
												((((st_15.(share)).(globals)).(g_granules)) #
													(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
													(((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
										))))
								else (
									when cid_0 == (((((((st_10.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
									(Some (
										((((((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
											((((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
										((lens 226 st_10).[share].[globals].[g_granules] :<
											((((st_10.(share)).(globals)).(g_granules)) #
												(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
												(((((st_10.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
									))))
							else (
								when cid == (
										((((((sh_0.(globals)).(g_granules)) #
											(((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
											((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
												None)) @ ((((v_1 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val)));
								when st_10 == (
										(rtt_walk_lock_unlock_spec
											(mkPtr "stack_s_rtt_walk" 0)
											(mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
											ret_2
											ret_3
											v_2
											(v_3 + ((- 1)))
											(lens 288 st)));
								rely ((((st_10.(share)).(granule_data)) = ((sh_0.(granule_data)))));
								rely ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
								rely ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
								if (((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) - ((v_3 + ((- 1))))) =? (0))
								then (
									rely (
										((((("granules" = ("granules")) /\ ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
											((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
											((6 >= (0)))) /\
											((6 <= (24)))));
									when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
									when ret_5 == ((buffer_map_spec' 6 ret_4 false));
									rely ((((ret_5.(pbase)) = ("granule_data")) /\ (((ret_5.(poffset)) >= (0)))));
									when v_34, st_15 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_10));
									rely ((((st_15.(share)).(granule_data)) = (((st_10.(share)).(granule_data)))));
									if (((v_3 + ((- 1))) <? (3)) && (((v_34 & (3)) =? (3))))
									then (
										when ret_6 == ((s2tte_pa_spec' v_34 (v_3 + ((- 1)))));
										if ((ret_6 - (v_0)) =? (0))
										then (
											rely (
												(((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - (4294967296)) < (0)))) \/ ((((v_0 - (MEM1_PHYS)) >= (0)) /\ (((v_0 - (556198264832)) < (0)))))) /\
													(((v_0 & (4095)) = (0)))));
											if ((v_0 - (MEM1_PHYS)) >=? (0))
											then (
												when sh_1 == (((st_15.(repl)) ((st_15.(oracle)) (st_15.(log))) (st_15.(share))));
												match ((((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val))) with
												| None =>
													rely (
														(((((((st_15.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) -
															(((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)))) =
															(0)));
													rely ((((((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) - (5)) =? (0)) = (true)));
													rely (((0 = (0)) /\ (((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) >= (0)))));
													if (((((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_ref)).(e_u_anon_3_0)) & (4095)) =? (0))
													then (
														when ret_7 == ((granule_addr_spec' (mkPtr "granules" (((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)))));
														when ret_8 == ((buffer_map_spec' 7 ret_7 false));
														rely ((((ret_8.(pbase)) = ("granule_data")) /\ (((ret_8.(poffset)) >= (0)))));
														rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
														when cid_0 == (
																(((((((sh_1.(globals)).(g_granules)) #
																	((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																	((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) #
																	(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((sh_1.(globals)).(g_granules)) #
																		((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																		((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																		((((((sh_1.(globals)).(g_granules)) #
																			((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																			((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																			(((((((sh_1.(globals)).(g_granules)) #
																				((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																				((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
																				((- 1)))))) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val)));
														when cid_1 == (
																((((((((sh_1.(globals)).(g_granules)) #
																	((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																	((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) #
																	(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((sh_1.(globals)).(g_granules)) #
																		((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																		((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																		((((((sh_1.(globals)).(g_granules)) #
																			((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																			((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																			(((((((sh_1.(globals)).(g_granules)) #
																				((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																				((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
																				((- 1)))))) #
																	((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																	(((((((sh_1.(globals)).(g_granules)) #
																		((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																		((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) #
																		(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((sh_1.(globals)).(g_granules)) #
																			((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																			((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((sh_1.(globals)).(g_granules)) #
																				((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																				((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((sh_1.(globals)).(g_granules)) #
																					((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																					((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
																					((- 1)))))) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :<
																		None).[e_state_s_granule] :<
																		1)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
														(Some (0, (lens 289 st_15))))
													else (
														when cid_0 == (
																((((((sh_1.(globals)).(g_granules)) #
																	((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																	((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< None)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
														(Some (4, (lens 290 st_15))))
												| (Some cid_0) => None
												end)
											else (
												when sh_1 == (((st_15.(repl)) ((st_15.(oracle)) (st_15.(log))) (st_15.(share))));
												match ((((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val))) with
												| None =>
													rely (
														(((((((st_15.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) -
															(((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)))) =
															(0)));
													rely ((((((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (5)) =? (0)) = (true)));
													if (((((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_ref)).(e_u_anon_3_0)) & (4095)) =? (0))
													then (
														when ret_7 == ((granule_addr_spec' (mkPtr "granules" (((v_0 + ((- MEM0_PHYS))) >> (12)) * (16)))));
														when ret_8 == ((buffer_map_spec' 7 ret_7 false));
														rely ((((ret_8.(pbase)) = ("granule_data")) /\ (((ret_8.(poffset)) >= (0)))));
														rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
														when cid_0 == (
																(((((((sh_1.(globals)).(g_granules)) #
																	((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																	((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) #
																	(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((sh_1.(globals)).(g_granules)) #
																		((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																		((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																		((((((sh_1.(globals)).(g_granules)) #
																			((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																			((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																			(((((((sh_1.(globals)).(g_granules)) #
																				((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																				((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
																				((- 1)))))) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val)));
														when cid_1 == (
																((((((((sh_1.(globals)).(g_granules)) #
																	((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																	((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) #
																	(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((sh_1.(globals)).(g_granules)) #
																		((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																		((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																		((((((sh_1.(globals)).(g_granules)) #
																			((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																			((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																			(((((((sh_1.(globals)).(g_granules)) #
																				((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																				((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
																				((- 1)))))) #
																	((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																	(((((((sh_1.(globals)).(g_granules)) #
																		((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																		((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) #
																		(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((sh_1.(globals)).(g_granules)) #
																			((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																			((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((sh_1.(globals)).(g_granules)) #
																				((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																				((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((sh_1.(globals)).(g_granules)) #
																					((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																					((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
																					((- 1)))))) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :<
																		None).[e_state_s_granule] :<
																		1)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
														(Some (0, (lens 291 st_15))))
													else (
														when cid_0 == (
																((((((sh_1.(globals)).(g_granules)) #
																	((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																	((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< None)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
														(Some (4, (lens 292 st_15))))
												| (Some cid_0) => None
												end))
										else (
											when cid_0 == (((((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
											(Some (
												4294967553  ,
												((lens 237 st_15).[share].[globals].[g_granules] :<
													((((st_15.(share)).(globals)).(g_granules)) #
														(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
														(((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
											))))
									else (
										when cid_0 == (((((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
										(Some (
											((((((v_3 + ((- 1))) << (32)) + (8)) >> (24)) & (4294967040)) |' ((((v_3 + ((- 1))) << (32)) + (8))))  ,
											((lens 238 st_15).[share].[globals].[g_granules] :<
												((((st_15.(share)).(globals)).(g_granules)) #
													(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
													(((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
										))))
								else (
									when cid_0 == (((((((st_10.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
									(Some (
										((((((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
											((((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
										((lens 239 st_10).[share].[globals].[g_granules] :<
											((((st_10.(share)).(globals)).(g_granules)) #
												(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
												(((((st_10.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
									))))
						| (Some cid) => None
						end)
					else (Some ((((((((ret_1 >> (32)) + (3)) << (32)) + (ret_1)) >> (24)) & (4294967040)) |' (((((ret_1 >> (32)) + (3)) << (32)) + (ret_1)))), (lens 293 st))))
				else (Some (8589935105, (lens 294 st)))
			| (Some cid) => None
			end)
		else (
			when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
			match ((((((sh.(globals)).(g_granules)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val))) with
			| None =>
				rely (
					(((((((st.(share)).(globals)).(g_granules)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) -
						(((((sh.(globals)).(g_granules)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)))) =
						(0)));
				if ((((((sh.(globals)).(g_granules)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (2)) =? (0))
				then (
					when ret == ((granule_addr_spec' (mkPtr "granules" (((v_1 + ((- MEM0_PHYS))) >> (12)) * (16)))));
					when ret_0 == ((buffer_map_spec' 2 ret false));
					rely ((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))));
					rely (((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))) /\ ((((ret_0.(poffset)) mod (4096)) = (0)))));
					rely ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
					when ret_1, st' == ((validate_rtt_structure_cmds_spec' v_2 v_3 ret_0 (lens 295 st)));
					if (ret_1 =? (0))
					then (
						rely ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)));
						rely ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (MEM0_VIRT)) < (0)));
						when ret_2, st'_0 == ((realm_rtt_starting_level_spec' ret_0 (lens 296 st)));
						when ret_3, st'_1 == ((realm_ipa_bits_spec' ret_0 (lens 297 st)));
						when sh_0 == (
								((st.(repl))
									((st.(oracle)) ((EVT CPU_ID (ACQ ((v_1 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))
									(sh.[globals].[g_granules] :<
										(((sh.(globals)).(g_granules)) #
											((v_1 + ((- MEM0_PHYS))) >> (12)) ==
											((((sh.(globals)).(g_granules)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))))));
						match ((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val))) with
						| None =>
							rely (
								(((((((sh.(globals)).(g_granules)) #
									((v_1 + ((- MEM0_PHYS))) >> (12)) ==
									((((sh.(globals)).(g_granules)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
									(((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)))) =
									(0)));
							rely (
								((("granules" = ("granules")) /\ ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) mod (16)) = (0)))) /\
									((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)))));
							if (
								((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
									(5)) =?
									(0)))
							then (
								when cid == ((((((sh_0.(globals)).(g_granules)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val)));
								when st_10 == (
										(rtt_walk_lock_unlock_spec
											(mkPtr "stack_s_rtt_walk" 0)
											(mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
											ret_2
											ret_3
											v_2
											(v_3 + ((- 1)))
											(lens 298 st)));
								rely ((((st_10.(share)).(granule_data)) = ((sh_0.(granule_data)))));
								rely ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
								rely ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
								if (((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) - ((v_3 + ((- 1))))) =? (0))
								then (
									rely (
										((((("granules" = ("granules")) /\ ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
											((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
											((6 >= (0)))) /\
											((6 <= (24)))));
									when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
									when ret_5 == ((buffer_map_spec' 6 ret_4 false));
									rely ((((ret_5.(pbase)) = ("granule_data")) /\ (((ret_5.(poffset)) >= (0)))));
									when v_34, st_15 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_10));
									rely ((((st_15.(share)).(granule_data)) = (((st_10.(share)).(granule_data)))));
									if (((v_3 + ((- 1))) <? (3)) && (((v_34 & (3)) =? (3))))
									then (
										when ret_6 == ((s2tte_pa_spec' v_34 (v_3 + ((- 1)))));
										if ((ret_6 - (v_0)) =? (0))
										then (
											rely (
												(((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - (4294967296)) < (0)))) \/ ((((v_0 - (MEM1_PHYS)) >= (0)) /\ (((v_0 - (556198264832)) < (0)))))) /\
													(((v_0 & (4095)) = (0)))));
											if ((v_0 - (MEM1_PHYS)) >=? (0))
											then (
												when sh_1 == (((st_15.(repl)) ((st_15.(oracle)) (st_15.(log))) (st_15.(share))));
												match ((((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val))) with
												| None =>
													rely (
														(((((((st_15.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) -
															(((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)))) =
															(0)));
													rely ((((((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) - (5)) =? (0)) = (true)));
													rely (((0 = (0)) /\ (((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) >= (0)))));
													if (((((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_ref)).(e_u_anon_3_0)) & (4095)) =? (0))
													then (
														when ret_7 == ((granule_addr_spec' (mkPtr "granules" (((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)))));
														when ret_8 == ((buffer_map_spec' 7 ret_7 false));
														rely ((((ret_8.(pbase)) = ("granule_data")) /\ (((ret_8.(poffset)) >= (0)))));
														rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
														when cid_0 == (
																(((((((sh_1.(globals)).(g_granules)) #
																	((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																	((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) #
																	(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((sh_1.(globals)).(g_granules)) #
																		((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																		((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																		((((((sh_1.(globals)).(g_granules)) #
																			((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																			((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																			(((((((sh_1.(globals)).(g_granules)) #
																				((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																				((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
																				((- 1)))))) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val)));
														when cid_1 == (
																((((((((sh_1.(globals)).(g_granules)) #
																	((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																	((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) #
																	(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((sh_1.(globals)).(g_granules)) #
																		((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																		((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																		((((((sh_1.(globals)).(g_granules)) #
																			((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																			((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																			(((((((sh_1.(globals)).(g_granules)) #
																				((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																				((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
																				((- 1)))))) #
																	((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																	(((((((sh_1.(globals)).(g_granules)) #
																		((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																		((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) #
																		(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((sh_1.(globals)).(g_granules)) #
																			((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																			((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((sh_1.(globals)).(g_granules)) #
																				((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																				((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((sh_1.(globals)).(g_granules)) #
																					((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																					((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
																					((- 1)))))) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :<
																		None).[e_state_s_granule] :<
																		1)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
														(Some (0, (lens 299 st_15))))
													else (
														when cid_0 == (
																((((((sh_1.(globals)).(g_granules)) #
																	((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																	((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< None)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
														(Some (4, (lens 300 st_15))))
												| (Some cid_0) => None
												end)
											else (
												when sh_1 == (((st_15.(repl)) ((st_15.(oracle)) (st_15.(log))) (st_15.(share))));
												match ((((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val))) with
												| None =>
													rely (
														(((((((st_15.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) -
															(((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)))) =
															(0)));
													rely ((((((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (5)) =? (0)) = (true)));
													if (((((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_ref)).(e_u_anon_3_0)) & (4095)) =? (0))
													then (
														when ret_7 == ((granule_addr_spec' (mkPtr "granules" (((v_0 + ((- MEM0_PHYS))) >> (12)) * (16)))));
														when ret_8 == ((buffer_map_spec' 7 ret_7 false));
														rely ((((ret_8.(pbase)) = ("granule_data")) /\ (((ret_8.(poffset)) >= (0)))));
														rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
														when cid_0 == (
																(((((((sh_1.(globals)).(g_granules)) #
																	((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																	((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) #
																	(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((sh_1.(globals)).(g_granules)) #
																		((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																		((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																		((((((sh_1.(globals)).(g_granules)) #
																			((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																			((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																			(((((((sh_1.(globals)).(g_granules)) #
																				((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																				((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
																				((- 1)))))) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val)));
														when cid_1 == (
																((((((((sh_1.(globals)).(g_granules)) #
																	((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																	((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) #
																	(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((sh_1.(globals)).(g_granules)) #
																		((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																		((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																		((((((sh_1.(globals)).(g_granules)) #
																			((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																			((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																			(((((((sh_1.(globals)).(g_granules)) #
																				((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																				((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
																				((- 1)))))) #
																	((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																	(((((((sh_1.(globals)).(g_granules)) #
																		((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																		((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) #
																		(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((sh_1.(globals)).(g_granules)) #
																			((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																			((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((sh_1.(globals)).(g_granules)) #
																				((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																				((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((sh_1.(globals)).(g_granules)) #
																					((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																					((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
																					((- 1)))))) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :<
																		None).[e_state_s_granule] :<
																		1)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
														(Some (0, (lens 301 st_15))))
													else (
														when cid_0 == (
																((((((sh_1.(globals)).(g_granules)) #
																	((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																	((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< None)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
														(Some (4, (lens 302 st_15))))
												| (Some cid_0) => None
												end))
										else (
											when cid_0 == (((((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
											(Some (
												4294967553  ,
												((lens 260 st_15).[share].[globals].[g_granules] :<
													((((st_15.(share)).(globals)).(g_granules)) #
														(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
														(((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
											))))
									else (
										when cid_0 == (((((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
										(Some (
											((((((v_3 + ((- 1))) << (32)) + (8)) >> (24)) & (4294967040)) |' ((((v_3 + ((- 1))) << (32)) + (8))))  ,
											((lens 261 st_15).[share].[globals].[g_granules] :<
												((((st_15.(share)).(globals)).(g_granules)) #
													(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
													(((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
										))))
								else (
									when cid_0 == (((((((st_10.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
									(Some (
										((((((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
											((((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
										((lens 262 st_10).[share].[globals].[g_granules] :<
											((((st_10.(share)).(globals)).(g_granules)) #
												(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
												(((((st_10.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
									))))
							else (
								when cid == (
										((((((sh_0.(globals)).(g_granules)) #
											(((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
											((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
												None)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val)));
								when st_10 == (
										(rtt_walk_lock_unlock_spec
											(mkPtr "stack_s_rtt_walk" 0)
											(mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
											ret_2
											ret_3
											v_2
											(v_3 + ((- 1)))
											(lens 303 st)));
								rely ((((st_10.(share)).(granule_data)) = ((sh_0.(granule_data)))));
								rely ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
								rely ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
								if (((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) - ((v_3 + ((- 1))))) =? (0))
								then (
									rely (
										((((("granules" = ("granules")) /\ ((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
											((((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
											((6 >= (0)))) /\
											((6 <= (24)))));
									when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
									when ret_5 == ((buffer_map_spec' 6 ret_4 false));
									rely ((((ret_5.(pbase)) = ("granule_data")) /\ (((ret_5.(poffset)) >= (0)))));
									when v_34, st_15 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_10));
									rely ((((st_15.(share)).(granule_data)) = (((st_10.(share)).(granule_data)))));
									if (((v_3 + ((- 1))) <? (3)) && (((v_34 & (3)) =? (3))))
									then (
										when ret_6 == ((s2tte_pa_spec' v_34 (v_3 + ((- 1)))));
										if ((ret_6 - (v_0)) =? (0))
										then (
											rely (
												(((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - (4294967296)) < (0)))) \/ ((((v_0 - (MEM1_PHYS)) >= (0)) /\ (((v_0 - (556198264832)) < (0)))))) /\
													(((v_0 & (4095)) = (0)))));
											if ((v_0 - (MEM1_PHYS)) >=? (0))
											then (
												when sh_1 == (((st_15.(repl)) ((st_15.(oracle)) (st_15.(log))) (st_15.(share))));
												match ((((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val))) with
												| None =>
													rely (
														(((((((st_15.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) -
															(((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)))) =
															(0)));
													rely ((((((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) - (5)) =? (0)) = (true)));
													rely (((0 = (0)) /\ (((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) >= (0)))));
													if (((((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_ref)).(e_u_anon_3_0)) & (4095)) =? (0))
													then (
														when ret_7 == ((granule_addr_spec' (mkPtr "granules" (((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)))));
														when ret_8 == ((buffer_map_spec' 7 ret_7 false));
														rely ((((ret_8.(pbase)) = ("granule_data")) /\ (((ret_8.(poffset)) >= (0)))));
														rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
														when cid_0 == (
																(((((((sh_1.(globals)).(g_granules)) #
																	((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																	((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) #
																	(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((sh_1.(globals)).(g_granules)) #
																		((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																		((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																		((((((sh_1.(globals)).(g_granules)) #
																			((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																			((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																			(((((((sh_1.(globals)).(g_granules)) #
																				((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																				((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
																				((- 1)))))) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val)));
														when cid_1 == (
																((((((((sh_1.(globals)).(g_granules)) #
																	((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																	((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) #
																	(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((sh_1.(globals)).(g_granules)) #
																		((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																		((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																		((((((sh_1.(globals)).(g_granules)) #
																			((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																			((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																			(((((((sh_1.(globals)).(g_granules)) #
																				((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																				((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
																				((- 1)))))) #
																	((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																	(((((((sh_1.(globals)).(g_granules)) #
																		((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																		((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) #
																		(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((sh_1.(globals)).(g_granules)) #
																			((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																			((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((sh_1.(globals)).(g_granules)) #
																				((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																				((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((sh_1.(globals)).(g_granules)) #
																					((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																					((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
																					((- 1)))))) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :<
																		None).[e_state_s_granule] :<
																		1)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
														(Some (0, (lens 304 st_15))))
													else (
														when cid_0 == (
																((((((sh_1.(globals)).(g_granules)) #
																	((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
																	((((sh_1.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< None)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
														(Some (4, (lens 305 st_15))))
												| (Some cid_0) => None
												end)
											else (
												when sh_1 == (((st_15.(repl)) ((st_15.(oracle)) (st_15.(log))) (st_15.(share))));
												match ((((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val))) with
												| None =>
													rely (
														(((((((st_15.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) -
															(((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)))) =
															(0)));
													rely ((((((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (5)) =? (0)) = (true)));
													if (((((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_ref)).(e_u_anon_3_0)) & (4095)) =? (0))
													then (
														when ret_7 == ((granule_addr_spec' (mkPtr "granules" (((v_0 + ((- MEM0_PHYS))) >> (12)) * (16)))));
														when ret_8 == ((buffer_map_spec' 7 ret_7 false));
														rely ((((ret_8.(pbase)) = ("granule_data")) /\ (((ret_8.(poffset)) >= (0)))));
														rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_10.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
														when cid_0 == (
																(((((((sh_1.(globals)).(g_granules)) #
																	((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																	((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) #
																	(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((sh_1.(globals)).(g_granules)) #
																		((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																		((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																		((((((sh_1.(globals)).(g_granules)) #
																			((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																			((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																			(((((((sh_1.(globals)).(g_granules)) #
																				((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																				((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
																				((- 1)))))) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val)));
														when cid_1 == (
																((((((((sh_1.(globals)).(g_granules)) #
																	((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																	((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) #
																	(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																	(((((sh_1.(globals)).(g_granules)) #
																		((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																		((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																		((((((sh_1.(globals)).(g_granules)) #
																			((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																			((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																			(((((((sh_1.(globals)).(g_granules)) #
																				((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																				((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
																				((- 1)))))) #
																	((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																	(((((((sh_1.(globals)).(g_granules)) #
																		((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																		((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) #
																		(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																		(((((sh_1.(globals)).(g_granules)) #
																			((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																			((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
																			((((((sh_1.(globals)).(g_granules)) #
																				((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																				((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
																				(((((((sh_1.(globals)).(g_granules)) #
																					((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																					((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) +
																					((- 1)))))) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :<
																		None).[e_state_s_granule] :<
																		1)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
														(Some (0, (lens 306 st_15))))
													else (
														when cid_0 == (
																((((((sh_1.(globals)).(g_granules)) #
																	((v_0 + ((- MEM0_PHYS))) >> (12)) ==
																	((((sh_1.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< None)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
														(Some (4, (lens 307 st_15))))
												| (Some cid_0) => None
												end))
										else (
											when cid_0 == (((((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
											(Some (
												4294967553  ,
												((lens 273 st_15).[share].[globals].[g_granules] :<
													((((st_15.(share)).(globals)).(g_granules)) #
														(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
														(((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
											))))
									else (
										when cid_0 == (((((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
										(Some (
											((((((v_3 + ((- 1))) << (32)) + (8)) >> (24)) & (4294967040)) |' ((((v_3 + ((- 1))) << (32)) + (8))))  ,
											((lens 274 st_15).[share].[globals].[g_granules] :<
												((((st_15.(share)).(globals)).(g_granules)) #
													(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
													(((((st_15.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
										))))
								else (
									when cid_0 == (((((((st_10.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
									(Some (
										((((((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
											((((((st_10.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
										((lens 275 st_10).[share].[globals].[g_granules] :<
											((((st_10.(share)).(globals)).(g_granules)) #
												(((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
												(((((st_10.(share)).(globals)).(g_granules)) @ (((((st_10.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
									))))
						| (Some cid) => None
						end)
					else (Some ((((((((ret_1 >> (32)) + (3)) << (32)) + (ret_1)) >> (24)) & (4294967040)) |' (((((ret_1 >> (32)) + (3)) << (32)) + (ret_1)))), (lens 308 st))))
				else (Some (8589935105, (lens 309 st)))
			| (Some cid) => None
			end).

	Definition smc_read_feature_register_spec (v_0: Z) (v_1: Ptr) (st: RData) : (option RData) :=
		rely ((((v_1.(pbase)) = ("stack_s_smc_result")) /\ (((v_1.(poffset)) = (0)))));
		if (v_0 =? (0))
		then (
			when ret, st' == ((max_pa_size_spec' st));
			(Some (st.[stack].[stack_s_smc_result] :< ((((st.(stack)).(stack_s_smc_result)).[e_x0] :< 0).[e_x1] :< ret))))
		else (Some (st.[stack].[stack_s_smc_result] :< (((st.(stack)).(stack_s_smc_result)).[e_x0] :< 4294967553))).
	
	
	Definition smc_data_dispose_spec (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
		when v_8, st_1 == ((find_lock_two_granules_spec v_0 2 (mkPtr "stack_type_4" 0) v_1 3 (mkPtr "stack_type_4__1" 0) st));
		if (v_8 =? (3))
		then (Some (3, st_1))
		else (
			if (v_8 =? (0))
			then (
				rely (((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
				rely ((((((st_1.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0)) = (false)));
				rely ((((((st_1.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0)) = (false)));
				rely ((((((st_1.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0)) = (false)));
				rely (((("granules" = ("granules")) /\ (((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)))) /\ (((((st_1.(stack)).(stack_type_4__1)) mod (16)) = (0)))));
				if ((((((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) & (4095)) =? (0))
				then (
					when ret == ((granule_addr_spec' (mkPtr "granules" (((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)))));
					when ret_0 == ((buffer_map_spec' 3 ret false));
					rely (((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))) /\ ((((ret_0.(poffset)) mod (4096)) = (0)))));
					rely (((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
					rely (((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
					rely (((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_realm_info)).(e_g_rd_s_realm_info)) - (GRANULES_BASE)) >= (0)));
					rely (((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_realm_info)).(e_g_rd_s_realm_info)) - (MEM0_VIRT)) < (0)));
					if ((((st_1.(stack)).(stack_type_4)) - (((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_realm_info)).(e_g_rd_s_realm_info)))) =? (0))
					then (
						if ((((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_dispose_info)).(e_s_anon_0_0)) & (1)) =? (0))
						then (
							when cid == (((((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
							when cid_0 == (
									(((((((st_1.(share)).(globals)).(g_granules)) #
										((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
										(((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
							(Some (
								7  ,
								((lens 86 st_1).[share].[globals].[g_granules] :<
									(((((st_1.(share)).(globals)).(g_granules)) #
										((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
										(((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) #
										((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16)) ==
										((((((st_1.(share)).(globals)).(g_granules)) #
											((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
											(((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
											None)))
							)))
						else (
							when ret_1 == (
									(region_is_contained_spec'
										((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_dispose_info)).(e_s_anon_0_1))
										(((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_dispose_info)).(e_s_anon_0_2)) +
											(((((((st_1.(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rec)).(e_dispose_info)).(e_s_anon_0_1))))
										v_2
										((1 << ((39 + (((- 9) * (v_3)))))) + (v_2))));
							if ret_1
							then (
								rely (
									((((("granules" = ("granules")) /\ (((((st_1.(stack)).(stack_type_4)) mod (16)) = (0)))) /\ (((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)))) /\
										((2 >= (0)))) /\
										((2 <= (24)))));
								when ret_2 == ((granule_addr_spec' (mkPtr "granules" (((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)))));
								when ret_3 == ((buffer_map_spec' 2 ret_2 false));
								rely (((((ret_3.(pbase)) = ("granule_data")) /\ (((ret_3.(poffset)) >= (0)))) /\ ((((ret_3.(poffset)) mod (4096)) = (0)))));
								rely (((((((st_1.(share)).(granule_data)) @ ((ret_3.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
								when ret_4, st' == ((validate_rtt_map_cmds_spec' v_2 v_3 ret_3 st_1));
								if (ret_4 =? (0))
								then (
									if (((((ret_3.(poffset)) + (32)) mod (4096)) >=? (16)) && (((((ret_3.(poffset)) + (32)) mod (4096)) <? (48))))
									then (
										if (((((ret_3.(poffset)) + (32)) mod (4096)) - (16)) =? (16))
										then (
											rely (((((((((st_1.(share)).(granule_data)) @ ((ret_3.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)));
											rely (((((((((st_1.(share)).(granule_data)) @ ((ret_3.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (MEM0_VIRT)) < (0)));
											when ret_5, st'_0 == ((realm_rtt_starting_level_spec' ret_3 st_1));
											when ret_6, st'_1 == ((realm_ipa_bits_spec' ret_3 st_1));
											when sh == (((st_1.(repl)) ((st_1.(oracle)) (st_1.(log))) (st_1.(share))));
											match ((((((sh.(globals)).(g_granules)) @ ((((((((st_1.(share)).(granule_data)) @ ((ret_3.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val))) with
											| None =>
												rely (
													(((((((st_1.(share)).(globals)).(g_granules)) @ ((((((((st_1.(share)).(granule_data)) @ ((ret_3.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
														(((((sh.(globals)).(g_granules)) @ ((((((((st_1.(share)).(granule_data)) @ ((ret_3.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)))) =
														(0)));
												rely (
													((("granules" = ("granules")) /\ (((((((((st_1.(share)).(granule_data)) @ ((ret_3.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) mod (16)) = (0)))) /\
														(((((((((st_1.(share)).(granule_data)) @ ((ret_3.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)))));
												if (
													((((((sh.(globals)).(g_granules)) @ ((((((((st_1.(share)).(granule_data)) @ ((ret_3.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
														(5)) =?
														(0)))
												then (
													when st_20 == (
															(rtt_walk_lock_unlock_spec
																(mkPtr "stack_s_rtt_walk" 0)
																(mkPtr "granules" (((((((st_1.(share)).(granule_data)) @ ((ret_3.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
																ret_5
																ret_6
																v_2
																v_3
																(lens 103 st_1)));
													rely ((((st_20.(share)).(granule_data)) = ((sh.(granule_data)))));
													rely ((((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
													rely ((((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
													if (((((st_20.(stack)).(stack_s_rtt_walk)).(e_last_level)) - (v_3)) =? (0))
													then (
														rely (
															((((("granules" = ("granules")) /\ ((((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
																((((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
																((6 >= (0)))) /\
																((6 <= (24)))));
														when ret_7 == ((granule_addr_spec' (mkPtr "granules" ((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
														when ret_8 == ((buffer_map_spec' 6 ret_7 false));
														when v_73, st_25 == ((__tte_read_spec (mkPtr (ret_8.(pbase)) ((ret_8.(poffset)) + ((8 * ((((st_20.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_20));
														rely ((((st_25.(share)).(granule_data)) = (((st_20.(share)).(granule_data)))));
														if ((v_73 & (63)) =? (8))
														then (
															when ret_9 == ((s2tte_create_ripas_spec' 1));
															rely ((((ret_8.(pbase)) = ("granule_data")) /\ ((((ret_8.(poffset)) + ((8 * ((((st_20.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
															when cid == (((((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
															rely (((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
															if ((((st_25.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0))
															then None
															else (
																if ((((st_25.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0))
																then None
																else (
																	if ((((st_25.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0))
																	then None
																	else (
																		when cid_0 == (
																				(((((((st_25.(share)).(globals)).(g_granules)) #
																					(((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																					(((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
																		rely (((((st_25.(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
																		if ((((st_25.(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0))
																		then None
																		else (
																			if ((((st_25.(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0))
																			then None
																			else (
																				if ((((st_25.(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0))
																				then None
																				else (
																					when cid_1 == (
																							((((((((st_25.(share)).(globals)).(g_granules)) #
																								(((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																								(((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) #
																								((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																								((((((st_25.(share)).(globals)).(g_granules)) #
																									(((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																									(((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																									None)) @ ((((st_25.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
																					(Some (
																						0  ,
																						((lens 105 st_25).[share].[globals].[g_granules] :<
																							((((((st_25.(share)).(globals)).(g_granules)) #
																								(((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																								(((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) #
																								((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																								((((((st_25.(share)).(globals)).(g_granules)) #
																									(((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																									(((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																									None)) #
																								((((st_25.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16)) ==
																								(((((((st_25.(share)).(globals)).(g_granules)) #
																									(((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																									(((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) #
																									((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																									((((((st_25.(share)).(globals)).(g_granules)) #
																										(((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																										(((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																										None)) @ ((((st_25.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																									None)))
																					)))))))))
														else (
															when cid == (((((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
															rely (((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
															if ((((st_25.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0))
															then None
															else (
																if ((((st_25.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0))
																then None
																else (
																	if ((((st_25.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0))
																	then None
																	else (
																		when cid_0 == (
																				(((((((st_25.(share)).(globals)).(g_granules)) #
																					(((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																					(((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
																		rely (((((st_25.(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
																		if ((((st_25.(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0))
																		then None
																		else (
																			if ((((st_25.(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0))
																			then None
																			else (
																				if ((((st_25.(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0))
																				then None
																				else (
																					when cid_1 == (
																							((((((((st_25.(share)).(globals)).(g_granules)) #
																								(((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																								(((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) #
																								((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																								((((((st_25.(share)).(globals)).(g_granules)) #
																									(((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																									(((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																									None)) @ ((((st_25.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
																					(Some (
																						9  ,
																						((lens 91 st_25).[share].[globals].[g_granules] :<
																							((((((st_25.(share)).(globals)).(g_granules)) #
																								(((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																								(((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) #
																								((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																								((((((st_25.(share)).(globals)).(g_granules)) #
																									(((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																									(((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																									None)) #
																								((((st_25.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16)) ==
																								(((((((st_25.(share)).(globals)).(g_granules)) #
																									(((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																									(((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) #
																									((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																									((((((st_25.(share)).(globals)).(g_granules)) #
																										(((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																										(((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																										None)) @ ((((st_25.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																									None)))
																					))))))))))
													else (
														when cid == (((((((st_20.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
														rely (((((st_20.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
														if ((((st_20.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0))
														then None
														else (
															if ((((st_20.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0))
															then None
															else (
																if ((((st_20.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0))
																then None
																else (
																	when cid_0 == (
																			(((((((st_20.(share)).(globals)).(g_granules)) #
																				(((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																				(((((st_20.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_20.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
																	rely (((((st_20.(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
																	if ((((st_20.(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0))
																	then None
																	else (
																		if ((((st_20.(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0))
																		then None
																		else (
																			if ((((st_20.(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0))
																			then None
																			else (
																				when cid_1 == (
																						((((((((st_20.(share)).(globals)).(g_granules)) #
																							(((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																							(((((st_20.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) #
																							((((st_20.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																							((((((st_20.(share)).(globals)).(g_granules)) #
																								(((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																								(((((st_20.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_20.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																								None)) @ ((((st_20.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
																				(Some (
																					((((((((st_20.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
																						((((((st_20.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
																					((lens 92 st_20).[share].[globals].[g_granules] :<
																						((((((st_20.(share)).(globals)).(g_granules)) #
																							(((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																							(((((st_20.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) #
																							((((st_20.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																							((((((st_20.(share)).(globals)).(g_granules)) #
																								(((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																								(((((st_20.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_20.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																								None)) #
																							((((st_20.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16)) ==
																							(((((((st_20.(share)).(globals)).(g_granules)) #
																								(((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																								(((((st_20.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) #
																								((((st_20.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																								((((((st_20.(share)).(globals)).(g_granules)) #
																									(((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																									(((((st_20.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_20.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																									None)) @ ((((st_20.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																								None)))
																				))))))))))
												else (
													when st_20 == (
															(rtt_walk_lock_unlock_spec
																(mkPtr "stack_s_rtt_walk" 0)
																(mkPtr "granules" (((((((st_1.(share)).(granule_data)) @ ((ret_3.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
																ret_5
																ret_6
																v_2
																v_3
																(lens 106 st_1)));
													rely ((((st_20.(share)).(granule_data)) = ((sh.(granule_data)))));
													rely ((((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
													rely ((((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
													if (((((st_20.(stack)).(stack_s_rtt_walk)).(e_last_level)) - (v_3)) =? (0))
													then (
														rely (
															((((("granules" = ("granules")) /\ ((((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
																((((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
																((6 >= (0)))) /\
																((6 <= (24)))));
														when ret_7 == ((granule_addr_spec' (mkPtr "granules" ((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
														when ret_8 == ((buffer_map_spec' 6 ret_7 false));
														when v_73, st_25 == ((__tte_read_spec (mkPtr (ret_8.(pbase)) ((ret_8.(poffset)) + ((8 * ((((st_20.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_20));
														rely ((((st_25.(share)).(granule_data)) = (((st_20.(share)).(granule_data)))));
														if ((v_73 & (63)) =? (8))
														then (
															when ret_9 == ((s2tte_create_ripas_spec' 1));
															rely ((((ret_8.(pbase)) = ("granule_data")) /\ ((((ret_8.(poffset)) + ((8 * ((((st_20.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
															when cid == (((((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
															rely (((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
															if ((((st_25.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0))
															then None
															else (
																if ((((st_25.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0))
																then None
																else (
																	if ((((st_25.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0))
																	then None
																	else (
																		when cid_0 == (
																				(((((((st_25.(share)).(globals)).(g_granules)) #
																					(((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																					(((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
																		rely (((((st_25.(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
																		if ((((st_25.(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0))
																		then None
																		else (
																			if ((((st_25.(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0))
																			then None
																			else (
																				if ((((st_25.(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0))
																				then None
																				else (
																					when cid_1 == (
																							((((((((st_25.(share)).(globals)).(g_granules)) #
																								(((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																								(((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) #
																								((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																								((((((st_25.(share)).(globals)).(g_granules)) #
																									(((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																									(((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																									None)) @ ((((st_25.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
																					(Some (
																						0  ,
																						((lens 108 st_25).[share].[globals].[g_granules] :<
																							((((((st_25.(share)).(globals)).(g_granules)) #
																								(((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																								(((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) #
																								((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																								((((((st_25.(share)).(globals)).(g_granules)) #
																									(((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																									(((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																									None)) #
																								((((st_25.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16)) ==
																								(((((((st_25.(share)).(globals)).(g_granules)) #
																									(((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																									(((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) #
																									((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																									((((((st_25.(share)).(globals)).(g_granules)) #
																										(((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																										(((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																										None)) @ ((((st_25.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																									None)))
																					)))))))))
														else (
															when cid == (((((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
															rely (((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
															if ((((st_25.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0))
															then None
															else (
																if ((((st_25.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0))
																then None
																else (
																	if ((((st_25.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0))
																	then None
																	else (
																		when cid_0 == (
																				(((((((st_25.(share)).(globals)).(g_granules)) #
																					(((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																					(((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
																		rely (((((st_25.(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
																		if ((((st_25.(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0))
																		then None
																		else (
																			if ((((st_25.(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0))
																			then None
																			else (
																				if ((((st_25.(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0))
																				then None
																				else (
																					when cid_1 == (
																							((((((((st_25.(share)).(globals)).(g_granules)) #
																								(((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																								(((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) #
																								((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																								((((((st_25.(share)).(globals)).(g_granules)) #
																									(((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																									(((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																									None)) @ ((((st_25.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
																					(Some (
																						9  ,
																						((lens 97 st_25).[share].[globals].[g_granules] :<
																							((((((st_25.(share)).(globals)).(g_granules)) #
																								(((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																								(((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) #
																								((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																								((((((st_25.(share)).(globals)).(g_granules)) #
																									(((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																									(((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																									None)) #
																								((((st_25.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16)) ==
																								(((((((st_25.(share)).(globals)).(g_granules)) #
																									(((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																									(((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) #
																									((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																									((((((st_25.(share)).(globals)).(g_granules)) #
																										(((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																										(((((st_25.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_25.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																										None)) @ ((((st_25.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																									None)))
																					))))))))))
													else (
														when cid == (((((((st_20.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
														rely (((((st_20.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) >= (0)));
														if ((((st_20.(stack)).(stack_type_4__1)) - (MAX_ERR)) >=? (0))
														then None
														else (
															if ((((st_20.(stack)).(stack_type_4__1)) - (MEM1_VIRT)) >=? (0))
															then None
															else (
																if ((((st_20.(stack)).(stack_type_4__1)) - (MEM0_VIRT)) >=? (0))
																then None
																else (
																	when cid_0 == (
																			(((((((st_20.(share)).(globals)).(g_granules)) #
																				(((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																				(((((st_20.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_20.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
																	rely (((((st_20.(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
																	if ((((st_20.(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0))
																	then None
																	else (
																		if ((((st_20.(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0))
																		then None
																		else (
																			if ((((st_20.(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0))
																			then None
																			else (
																				when cid_1 == (
																						((((((((st_20.(share)).(globals)).(g_granules)) #
																							(((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																							(((((st_20.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) #
																							((((st_20.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																							((((((st_20.(share)).(globals)).(g_granules)) #
																								(((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																								(((((st_20.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_20.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																								None)) @ ((((st_20.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
																				(Some (
																					((((((((st_20.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
																						((((((st_20.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
																					((lens 98 st_20).[share].[globals].[g_granules] :<
																						((((((st_20.(share)).(globals)).(g_granules)) #
																							(((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																							(((((st_20.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) #
																							((((st_20.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																							((((((st_20.(share)).(globals)).(g_granules)) #
																								(((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																								(((((st_20.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_20.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																								None)) #
																							((((st_20.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16)) ==
																							(((((((st_20.(share)).(globals)).(g_granules)) #
																								(((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																								(((((st_20.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) #
																								((((st_20.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
																								((((((st_20.(share)).(globals)).(g_granules)) #
																									(((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
																									(((((st_20.(share)).(globals)).(g_granules)) @ (((((st_20.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_20.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																									None)) @ ((((st_20.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
																								None)))
																				))))))))))
											| (Some cid) => None
											end)
										else None)
									else None)
								else (
									when cid == (((((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
									when cid_0 == (
											(((((((st_1.(share)).(globals)).(g_granules)) #
												((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
												(((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
									(Some (
										(((((((ret_4 >> (32)) + (3)) << (32)) + (ret_4)) >> (24)) & (4294967040)) |' (((((ret_4 >> (32)) + (3)) << (32)) + (ret_4))))  ,
										((lens 99 st_1).[share].[globals].[g_granules] :<
											(((((st_1.(share)).(globals)).(g_granules)) #
												((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
												(((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) #
												((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16)) ==
												((((((st_1.(share)).(globals)).(g_granules)) #
													((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
													(((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
													None)))
									))))
							else (
								when cid == (((((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
								when cid_0 == (
										(((((((st_1.(share)).(globals)).(g_granules)) #
											((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
											(((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
								(Some (
									12884902657  ,
									((lens 100 st_1).[share].[globals].[g_granules] :<
										(((((st_1.(share)).(globals)).(g_granules)) #
											((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
											(((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) #
											((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16)) ==
											((((((st_1.(share)).(globals)).(g_granules)) #
												((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
												(((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
												None)))
								)))))
					else (
						when cid == (((((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
						if ((((st_1.(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0))
						then None
						else (
							if ((((st_1.(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0))
							then None
							else (
								if ((((st_1.(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0))
								then None
								else (
									when cid_0 == (
											(((((((st_1.(share)).(globals)).(g_granules)) #
												((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
												(((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
									(Some (
										6  ,
										((lens 101 st_1).[share].[globals].[g_granules] :<
											(((((st_1.(share)).(globals)).(g_granules)) #
												((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
												(((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) #
												((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16)) ==
												((((((st_1.(share)).(globals)).(g_granules)) #
													((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
													(((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
													None)))
									)))))))
				else (
					when cid == (((((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
					rely (((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) >= (0)));
					if ((((st_1.(stack)).(stack_type_4)) - (MAX_ERR)) >=? (0))
					then None
					else (
						if ((((st_1.(stack)).(stack_type_4)) - (MEM1_VIRT)) >=? (0))
						then None
						else (
							if ((((st_1.(stack)).(stack_type_4)) - (MEM0_VIRT)) >=? (0))
							then None
							else (
								when cid_0 == (
										(((((((st_1.(share)).(globals)).(g_granules)) #
											((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
											(((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
								(Some (
									4  ,
									((lens 102 st_1).[share].[globals].[g_granules] :<
										(((((st_1.(share)).(globals)).(g_granules)) #
											((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
											(((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) #
											((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16)) ==
											((((((st_1.(share)).(globals)).(g_granules)) #
												((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16)) ==
												(((((st_1.(share)).(globals)).(g_granules)) @ ((((st_1.(stack)).(stack_type_4__1)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)) @ ((((st_1.(stack)).(stack_type_4)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
												None)))
								)))))))
			else (Some ((((((((v_8 >> (32)) + (1)) << (32)) + (1)) >> (24)) & (4294967040)) |' (((((v_8 >> (32)) + (1)) << (32)) + (1)))), st_1))).
	

	
	Definition smc_rtt_map_protected_spec (v_0: Z) (v_1: Z) (v_2: Z) (st: RData) : (option (Z * RData)) :=
		rely (
			(((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - (4294967296)) < (0)))) \/ ((((v_0 - (MEM1_PHYS)) >= (0)) /\ (((v_0 - (556198264832)) < (0)))))) /\
				(((v_0 & (4095)) = (0)))));
		if ((v_0 - (MEM1_PHYS)) >=? (0))
		then (
			when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
			match ((((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val))) with
			| None =>
				rely (
					(((((((st.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) -
						(((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)))) =
						(0)));
				if ((((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) - (2)) =? (0))
				then (
					when ret == ((granule_addr_spec' (mkPtr "granules" (((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)))));
					when ret_0 == ((buffer_map_spec' 2 ret false));
					rely ((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))));
					rely (((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))) /\ ((((ret_0.(poffset)) mod (4096)) = (0)))));
					rely ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
					when ret_1, st' == ((validate_rtt_map_cmds_spec' v_1 v_2 ret_0 (lens 130 st)));
					if (ret_1 =? (0))
					then (
						rely ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)));
						rely ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (MEM0_VIRT)) < (0)));
						when ret_2, st'_0 == ((realm_rtt_starting_level_spec' ret_0 (lens 131 st)));
						when ret_3, st'_1 == ((realm_ipa_bits_spec' ret_0 (lens 132 st)));
						when sh_0 == (
								((st.(repl))
									((st.(oracle)) ((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))
									(sh.[globals].[g_granules] :<
										(((sh.(globals)).(g_granules)) #
											((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
											((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))))));
						match ((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val))) with
						| None =>
							rely (
								(((((((sh.(globals)).(g_granules)) #
									((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
									((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
									(((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)))) =
									(0)));
							rely (
								((("granules" = ("granules")) /\ ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) mod (16)) = (0)))) /\
									((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)))));
							if (
								((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
									(5)) =?
									(0)))
							then (
								when cid == ((((((sh_0.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val)));
								when st_9 == (
										(rtt_walk_lock_unlock_spec
											(mkPtr "stack_s_rtt_walk" 0)
											(mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
											ret_2
											ret_3
											v_1
											v_2
											(lens 133 st)));
								rely ((((st_9.(share)).(granule_data)) = ((sh_0.(granule_data)))));
								rely ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
								rely ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
								if (((((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level)) - (v_2)) =? (0))
								then (
									rely (
										((((("granules" = ("granules")) /\ ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
											((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
											((6 >= (0)))) /\
											((6 <= (24)))));
									when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
									when ret_5 == ((buffer_map_spec' 6 ret_4 false));
									rely ((((ret_5.(pbase)) = ("granule_data")) /\ (((ret_5.(poffset)) >= (0)))));
									when v_29, st_14 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_9));
									rely ((((st_14.(share)).(granule_data)) = (((st_9.(share)).(granule_data)))));
									if ((v_29 & (63)) =? (4))
									then (
										when ret_6 == ((s2tte_pa_spec' v_29 v_2));
										when ret_7 == ((s2tte_create_valid_spec' ret_6 v_2));
										rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
										when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
										(Some (
											0  ,
											((lens 135 st_14).[share].[globals].[g_granules] :<
												((((st_14.(share)).(globals)).(g_granules)) #
													(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
													(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
										)))
									else (
										when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
										(Some (
											9  ,
											((lens 96 st_14).[share].[globals].[g_granules] :<
												((((st_14.(share)).(globals)).(g_granules)) #
													(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
													(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
										))))
								else (
									when cid_0 == (((((((st_9.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
									(Some (
										((((((((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
											((((((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
										((lens 97 st_9).[share].[globals].[g_granules] :<
											((((st_9.(share)).(globals)).(g_granules)) #
												(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
												(((((st_9.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
									))))
							else (
								when cid == (
										((((((sh_0.(globals)).(g_granules)) #
											(((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
											((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
												None)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val)));
								when st_9 == (
										(rtt_walk_lock_unlock_spec
											(mkPtr "stack_s_rtt_walk" 0)
											(mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
											ret_2
											ret_3
											v_1
											v_2
											(lens 136 st)));
								rely ((((st_9.(share)).(granule_data)) = ((sh_0.(granule_data)))));
								rely ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
								rely ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
								if (((((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level)) - (v_2)) =? (0))
								then (
									rely (
										((((("granules" = ("granules")) /\ ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
											((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
											((6 >= (0)))) /\
											((6 <= (24)))));
									when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
									when ret_5 == ((buffer_map_spec' 6 ret_4 false));
									rely ((((ret_5.(pbase)) = ("granule_data")) /\ (((ret_5.(poffset)) >= (0)))));
									when v_29, st_14 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_9));
									rely ((((st_14.(share)).(granule_data)) = (((st_9.(share)).(granule_data)))));
									if ((v_29 & (63)) =? (4))
									then (
										when ret_6 == ((s2tte_pa_spec' v_29 v_2));
										when ret_7 == ((s2tte_create_valid_spec' ret_6 v_2));
										rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
										when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
										(Some (
											0  ,
											((lens 138 st_14).[share].[globals].[g_granules] :<
												((((st_14.(share)).(globals)).(g_granules)) #
													(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
													(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
										)))
									else (
										when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
										(Some (
											9  ,
											((lens 102 st_14).[share].[globals].[g_granules] :<
												((((st_14.(share)).(globals)).(g_granules)) #
													(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
													(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
										))))
								else (
									when cid_0 == (((((((st_9.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
									(Some (
										((((((((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
											((((((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
										((lens 103 st_9).[share].[globals].[g_granules] :<
											((((st_9.(share)).(globals)).(g_granules)) #
												(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
												(((((st_9.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
									))))
						| (Some cid) => None
						end)
					else (Some ((((((((ret_1 >> (32)) + (2)) << (32)) + (ret_1)) >> (24)) & (4294967040)) |' (((((ret_1 >> (32)) + (2)) << (32)) + (ret_1)))), (lens 139 st))))
				else (Some (4294967553, (lens 140 st)))
			| (Some cid) => None
			end)
		else (
			when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
			match ((((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val))) with
			| None =>
				rely (
					(((((((st.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) -
						(((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)))) =
						(0)));
				if ((((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (2)) =? (0))
				then (
					when ret == ((granule_addr_spec' (mkPtr "granules" (((v_0 + ((- MEM0_PHYS))) >> (12)) * (16)))));
					when ret_0 == ((buffer_map_spec' 2 ret false));
					rely ((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))));
					rely (((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))) /\ ((((ret_0.(poffset)) mod (4096)) = (0)))));
					rely ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
					when ret_1, st' == ((validate_rtt_map_cmds_spec' v_1 v_2 ret_0 (lens 141 st)));
					if (ret_1 =? (0))
					then (
						rely ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)));
						rely ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (MEM0_VIRT)) < (0)));
						when ret_2, st'_0 == ((realm_rtt_starting_level_spec' ret_0 (lens 142 st)));
						when ret_3, st'_1 == ((realm_ipa_bits_spec' ret_0 (lens 143 st)));
						when sh_0 == (
								((st.(repl))
									((st.(oracle)) ((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))
									(sh.[globals].[g_granules] :<
										(((sh.(globals)).(g_granules)) #
											((v_0 + ((- MEM0_PHYS))) >> (12)) ==
											((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))))));
						match ((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val))) with
						| None =>
							rely (
								(((((((sh.(globals)).(g_granules)) #
									((v_0 + ((- MEM0_PHYS))) >> (12)) ==
									((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
									(((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)))) =
									(0)));
							rely (
								((("granules" = ("granules")) /\ ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) mod (16)) = (0)))) /\
									((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)))));
							if (
								((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
									(5)) =?
									(0)))
							then (
								when cid == ((((((sh_0.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val)));
								when st_9 == (
										(rtt_walk_lock_unlock_spec
											(mkPtr "stack_s_rtt_walk" 0)
											(mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
											ret_2
											ret_3
											v_1
											v_2
											(lens 144 st)));
								rely ((((st_9.(share)).(granule_data)) = ((sh_0.(granule_data)))));
								rely ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
								rely ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
								if (((((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level)) - (v_2)) =? (0))
								then (
									rely (
										((((("granules" = ("granules")) /\ ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
											((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
											((6 >= (0)))) /\
											((6 <= (24)))));
									when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
									when ret_5 == ((buffer_map_spec' 6 ret_4 false));
									rely ((((ret_5.(pbase)) = ("granule_data")) /\ (((ret_5.(poffset)) >= (0)))));
									when v_29, st_14 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_9));
									rely ((((st_14.(share)).(granule_data)) = (((st_9.(share)).(granule_data)))));
									if ((v_29 & (63)) =? (4))
									then (
										when ret_6 == ((s2tte_pa_spec' v_29 v_2));
										when ret_7 == ((s2tte_create_valid_spec' ret_6 v_2));
										rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
										when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
										(Some (
											0  ,
											((lens 146 st_14).[share].[globals].[g_granules] :<
												((((st_14.(share)).(globals)).(g_granules)) #
													(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
													(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
										)))
									else (
										when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
										(Some (
											9  ,
											((lens 118 st_14).[share].[globals].[g_granules] :<
												((((st_14.(share)).(globals)).(g_granules)) #
													(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
													(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
										))))
								else (
									when cid_0 == (((((((st_9.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
									(Some (
										((((((((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
											((((((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
										((lens 119 st_9).[share].[globals].[g_granules] :<
											((((st_9.(share)).(globals)).(g_granules)) #
												(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
												(((((st_9.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
									))))
							else (
								when cid == (
										((((((sh_0.(globals)).(g_granules)) #
											(((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
											((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
												None)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val)));
								when st_9 == (
										(rtt_walk_lock_unlock_spec
											(mkPtr "stack_s_rtt_walk" 0)
											(mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
											ret_2
											ret_3
											v_1
											v_2
											(lens 147 st)));
								rely ((((st_9.(share)).(granule_data)) = ((sh_0.(granule_data)))));
								rely ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
								rely ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
								if (((((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level)) - (v_2)) =? (0))
								then (
									rely (
										((((("granules" = ("granules")) /\ ((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
											((((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
											((6 >= (0)))) /\
											((6 <= (24)))));
									when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
									when ret_5 == ((buffer_map_spec' 6 ret_4 false));
									rely ((((ret_5.(pbase)) = ("granule_data")) /\ (((ret_5.(poffset)) >= (0)))));
									when v_29, st_14 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_9));
									rely ((((st_14.(share)).(granule_data)) = (((st_9.(share)).(granule_data)))));
									if ((v_29 & (63)) =? (4))
									then (
										when ret_6 == ((s2tte_pa_spec' v_29 v_2));
										when ret_7 == ((s2tte_create_valid_spec' ret_6 v_2));
										rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_9.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
										when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
										(Some (
											0  ,
											((lens 149 st_14).[share].[globals].[g_granules] :<
												((((st_14.(share)).(globals)).(g_granules)) #
													(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
													(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
										)))
									else (
										when cid_0 == (((((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
										(Some (
											9  ,
											((lens 124 st_14).[share].[globals].[g_granules] :<
												((((st_14.(share)).(globals)).(g_granules)) #
													(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
													(((((st_14.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
										))))
								else (
									when cid_0 == (((((((st_9.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
									(Some (
										((((((((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
											((((((st_9.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
										((lens 125 st_9).[share].[globals].[g_granules] :<
											((((st_9.(share)).(globals)).(g_granules)) #
												(((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
												(((((st_9.(share)).(globals)).(g_granules)) @ (((((st_9.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
									))))
						| (Some cid) => None
						end)
					else (Some ((((((((ret_1 >> (32)) + (2)) << (32)) + (ret_1)) >> (24)) & (4294967040)) |' (((((ret_1 >> (32)) + (2)) << (32)) + (ret_1)))), (lens 150 st))))
				else (Some (4294967553, (lens 151 st)))
			| (Some cid) => None
			end).
  (* 
      Some smc specs depends on some complex lower-level specs ; e.g. data_create_spec / map_unmap_ns_spec. 
      We leave these spec as low specs as below. 
        by Ganxiang Yang, Dec 3, 2024 
  *)

  Definition smc_data_create_spec (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    when v_5, st_0 == ((find_granule_spec v_3 st));
    rely ((((v_5.(pbase)) = ("granules")) \/ (((v_5.(pbase)) = ("null")))));
    if (ptr_eqb v_5 (mkPtr "null" 0))
    then (
      when v_7, st_1 == ((pack_return_code_spec 1 4 st_0));
      (Some (v_7, st_1)))
    else (
      if ((v_1 & (1)) =? (0))
      then (
        when v_15, st_1 == ((data_create_spec v_0 v_1 v_2 v_5 st_0));
        (Some (((v_15 << (32)) >> (32)), st_1)))
      else (
        when v_13, st_1 == ((data_create_s1_el1_spec v_0 (v_1 & ((- 2))) v_2 v_5 st_0));
        (Some (((v_13 << (32)) >> (32)), st_1)))).

  Definition smc_rtt_map_non_secure_spec (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    if ((v_0 & (1)) =? (0))
    then (
      when v_20, st_0 == ((host_ns_s2tte_is_valid_spec v_3 v_2 st));
      if v_20
      then (
        when v_25, st_1 == ((map_unmap_ns_spec v_0 v_1 v_2 v_3 0 st_0));
        (Some (v_25, st_1)))
      else (
        when v_22, st_1 == ((pack_return_code_spec 1 4 st_0));
        (Some (v_22, st_1))))
    else (
      when v_8, st_0 == ((find_lock_granule_spec (v_0 & ((- 2))) 3 st));
      rely (((((v_8.(poffset)) mod (16)) = (0)) /\ (((v_8.(poffset)) >= (0)))));
      rely ((((v_8.(pbase)) = ("granules")) \/ (((v_8.(pbase)) = ("null")))));
      if (ptr_eqb v_8 (mkPtr "null" 0))
      then (
        when v_10, st_1 == ((pack_return_code_spec 1 1 st_0));
        (Some (v_10, st_1)))
      else (
        when v_13, st_1 == ((granule_map_spec v_8 3 st_0));
        when v_16_tmp, st_2 == ((load_RData 8 (ptr_offset v_13 1544) st_1));
        when v_17, st_3 == ((granule_addr_spec (int_to_ptr v_16_tmp) st_2));
        when v_18, st_4 == ((map_unmap_ns_s1_spec v_17 v_1 v_2 v_3 0 st_3));
        when st_5 == ((granule_unlock_spec v_8 st_4));
        (Some (v_18, st_5)))).

  Definition smc_data_create_unknown_spec (v_0: Z) (v_1: Z) (v_2: Z) (st: RData) : (option (Z * RData)) :=
    if ((v_1 & (1)) =? (0))
    then (
      when v_9, st_0 == ((data_create_spec v_0 v_1 v_2 (mkPtr "null" 0) st));
      (Some (v_9, st_0)))
    else (
      when v_7, st_0 == ((data_create_s1_el1_spec v_0 (v_1 & ((- 2))) v_2 (mkPtr "null" 0) st));
      (Some (v_7, st_0))).

  Definition smc_rtt_unmap_non_secure_spec (v_0: Z) (v_1: Z) (v_2: Z) (st: RData) : (option (Z * RData)) :=
    when v_4, st_0 == ((map_unmap_ns_spec v_0 v_1 v_2 0 1 st));
    (Some (v_4, st_0)).

End Layer13_Spec.

#[global] Hint Unfold smc_realm_activate_spec: spec.
#[global] Hint Unfold smc_rec_enter_spec: spec.
#[global] Hint Unfold smc_data_dispose_spec: spec.
#[global] Hint Unfold smc_read_feature_register_spec: spec.
#[global] Hint Unfold smc_rtt_destroy_spec: spec.
#[global] Hint Unfold smc_data_create_spec: spec.
#[global] Hint Unfold smc_rtt_map_non_secure_spec: spec.
#[global] Hint Unfold smc_data_destroy_spec: spec.
#[global] Hint Unfold smc_rtt_create_spec: spec.
#[global] Hint Unfold smc_rtt_map_protected_spec: spec.
#[global] Hint Unfold smc_data_create_unknown_spec: spec.
#[global] Hint Unfold smc_rtt_unmap_non_secure_spec: spec.
#[global] Hint Unfold smc_rtt_read_entry_spec: spec.
#[global] Hint Unfold smc_rtt_unmap_protected_spec: spec.
(* #[global] Hint Unfold s1tte_is_writable_spec: spec. *)
(* #[global] Hint Unfold stage1_tlbi_va_spec: spec. *)
(* #[global] Hint Unfold stage1_tlbi_val_spec: spec. *)
(* #[global] Hint Unfold s2tte_create_destroyed_spec: spec. *)
(* #[global] Hint Unfold s2tte_addr_type_mask_spec: spec. *)
(* #[global] Hint Unfold data_granule_measure_spec: spec. *)