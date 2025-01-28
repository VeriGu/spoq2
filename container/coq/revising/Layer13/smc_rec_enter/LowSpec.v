Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer11.Spec.
Require Import Layer12.Spec.
Require Import Layer2.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer7.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer13_smc_rec_enter_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition smc_rec_enter_0_low (st_0: RData) (st_36: RData) (v_2: Z) (v_31: Ptr) (v_40: Ptr) (v_86: Z) : (option RData) :=
    rely (((v_86 =? (0)) = (true)));
    when st_38 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_36));
    when st_39 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_38));
    when v_95, st_46 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_39));
    when st_47 == ((ns_buffer_unmap_spec 0 st_46));
    when st_49 == ((atomic_granule_put_release_spec v_31 st_47));
    when st_51 == ((free_stack "smc_rec_enter" st_0 st_49));
    (Some st_51).

  Definition smc_rec_enter_1_low (st_0: RData) (st_37: RData) (v_2: Z) (v_31: Ptr) (v_40: Ptr) (v_86: Z) : (option RData) :=
    rely (((v_86 =? (0)) = (true)));
    when st_39 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_37));
    when st_40 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_39));
    when v_95, st_47 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_40));
    when st_48 == ((ns_buffer_unmap_spec 0 st_47));
    when st_50 == ((atomic_granule_put_release_spec v_31 st_48));
    when st_52 == ((free_stack "smc_rec_enter" st_0 st_50));
    (Some st_52).

  Definition smc_rec_enter_2_low (st_0: RData) (st_39: RData) (v_2: Z) (v_31: Ptr) (v_40: Ptr) (v_86: Z) : (option RData) :=
    rely (((v_86 =? (0)) = (true)));
    when st_41 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_39));
    when st_42 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_41));
    when v_95, st_49 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_42));
    when st_50 == ((ns_buffer_unmap_spec 0 st_49));
    when st_52 == ((atomic_granule_put_release_spec v_31 st_50));
    when st_54 == ((free_stack "smc_rec_enter" st_0 st_52));
    (Some st_54).

  Definition smc_rec_enter_3_low (st_0: RData) (st_40: RData) (v_2: Z) (v_31: Ptr) (v_40: Ptr) (v_86: Z) : (option RData) :=
    rely (((v_86 =? (0)) = (true)));
    when st_42 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_40));
    when st_43 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_42));
    when v_95, st_50 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_43));
    when st_51 == ((ns_buffer_unmap_spec 0 st_50));
    when st_53 == ((atomic_granule_put_release_spec v_31 st_51));
    when st_55 == ((free_stack "smc_rec_enter" st_0 st_53));
    (Some st_55).

  Definition smc_rec_enter_4_low (st_0: RData) (st_34: RData) (v_2: Z) (v_31: Ptr) (v_40: Ptr) (v_86: Z) : (option RData) :=
    rely (((v_86 =? (0)) = (true)));
    when st_36 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_34));
    when st_37 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_36));
    when v_95, st_44 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_37));
    when st_45 == ((ns_buffer_unmap_spec 0 st_44));
    when st_47 == ((atomic_granule_put_release_spec v_31 st_45));
    when st_49 == ((free_stack "smc_rec_enter" st_0 st_47));
    (Some st_49).

  Definition smc_rec_enter_5_low (st_0: RData) (st_35: RData) (v_2: Z) (v_31: Ptr) (v_40: Ptr) (v_86: Z) : (option RData) :=
    rely (((v_86 =? (0)) = (true)));
    when st_37 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_35));
    when st_38 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_37));
    when v_95, st_45 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_38));
    when st_46 == ((ns_buffer_unmap_spec 0 st_45));
    when st_48 == ((atomic_granule_put_release_spec v_31 st_46));
    when st_50 == ((free_stack "smc_rec_enter" st_0 st_48));
    (Some st_50).

  Definition smc_rec_enter_6_low (st_0: RData) (st_37: RData) (v_2: Z) (v_31: Ptr) (v_40: Ptr) (v_86: Z) : (option RData) :=
    rely (((v_86 =? (0)) = (true)));
    when st_39 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_37));
    when st_40 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_39));
    when v_95, st_47 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_40));
    when st_48 == ((ns_buffer_unmap_spec 0 st_47));
    when st_50 == ((atomic_granule_put_release_spec v_31 st_48));
    when st_52 == ((free_stack "smc_rec_enter" st_0 st_50));
    (Some st_52).

  Definition smc_rec_enter_7_low (st_0: RData) (st_38: RData) (v_2: Z) (v_31: Ptr) (v_40: Ptr) (v_86: Z) : (option RData) :=
    rely (((v_86 =? (0)) = (true)));
    when st_40 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_38));
    when st_41 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_40));
    when v_95, st_48 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_41));
    when st_49 == ((ns_buffer_unmap_spec 0 st_48));
    when st_51 == ((atomic_granule_put_release_spec v_31 st_49));
    when st_53 == ((free_stack "smc_rec_enter" st_0 st_51));
    (Some st_53).

  Definition smc_rec_enter_8_low (st_0: RData) (st_34: RData) (v_2: Z) (v_31: Ptr) (v_40: Ptr) (v_86: Z) : (option RData) :=
    rely (((v_86 =? (0)) = (true)));
    when st_36 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_34));
    when st_37 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_36));
    when v_95, st_44 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_37));
    when st_45 == ((ns_buffer_unmap_spec 0 st_44));
    when st_47 == ((atomic_granule_put_release_spec v_31 st_45));
    when st_49 == ((free_stack "smc_rec_enter" st_0 st_47));
    (Some st_49).

  Definition smc_rec_enter_9_low (st_0: RData) (st_35: RData) (v_2: Z) (v_31: Ptr) (v_40: Ptr) (v_86: Z) : (option RData) :=
    rely (((v_86 =? (0)) = (true)));
    when st_37 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_35));
    when st_38 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_37));
    when v_95, st_45 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_38));
    when st_46 == ((ns_buffer_unmap_spec 0 st_45));
    when st_48 == ((atomic_granule_put_release_spec v_31 st_46));
    when st_50 == ((free_stack "smc_rec_enter" st_0 st_48));
    (Some st_50).

  Definition smc_rec_enter_10_low (st_0: RData) (st_37: RData) (v_2: Z) (v_31: Ptr) (v_40: Ptr) (v_86: Z) : (option RData) :=
    rely (((v_86 =? (0)) = (true)));
    when st_39 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_37));
    when st_40 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_39));
    when v_95, st_47 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_40));
    when st_48 == ((ns_buffer_unmap_spec 0 st_47));
    when st_50 == ((atomic_granule_put_release_spec v_31 st_48));
    when st_52 == ((free_stack "smc_rec_enter" st_0 st_50));
    (Some st_52).

  Definition smc_rec_enter_11_low (st_0: RData) (st_38: RData) (v_2: Z) (v_31: Ptr) (v_40: Ptr) (v_86: Z) : (option RData) :=
    rely (((v_86 =? (0)) = (true)));
    when st_40 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_38));
    when st_41 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_40));
    when v_95, st_48 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_41));
    when st_49 == ((ns_buffer_unmap_spec 0 st_48));
    when st_51 == ((atomic_granule_put_release_spec v_31 st_49));
    when st_53 == ((free_stack "smc_rec_enter" st_0 st_51));
    (Some st_53).

  Definition smc_rec_enter_12_low (st_0: RData) (st_32: RData) (v_2: Z) (v_31: Ptr) (v_40: Ptr) (v_86: Z) : (option RData) :=
    rely (((v_86 =? (0)) = (true)));
    when st_34 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_32));
    when st_35 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_34));
    when v_95, st_42 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_35));
    when st_43 == ((ns_buffer_unmap_spec 0 st_42));
    when st_45 == ((atomic_granule_put_release_spec v_31 st_43));
    when st_47 == ((free_stack "smc_rec_enter" st_0 st_45));
    (Some st_47).

  Definition smc_rec_enter_13_low (st_0: RData) (st_33: RData) (v_2: Z) (v_31: Ptr) (v_40: Ptr) (v_86: Z) : (option RData) :=
    rely (((v_86 =? (0)) = (true)));
    when st_35 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_33));
    when st_36 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_35));
    when v_95, st_43 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_36));
    when st_44 == ((ns_buffer_unmap_spec 0 st_43));
    when st_46 == ((atomic_granule_put_release_spec v_31 st_44));
    when st_48 == ((free_stack "smc_rec_enter" st_0 st_46));
    (Some st_48).

  Definition smc_rec_enter_14_low (st_0: RData) (st_35: RData) (v_2: Z) (v_31: Ptr) (v_40: Ptr) (v_86: Z) : (option RData) :=
    rely (((v_86 =? (0)) = (true)));
    when st_37 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_35));
    when st_38 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_37));
    when v_95, st_45 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_38));
    when st_46 == ((ns_buffer_unmap_spec 0 st_45));
    when st_48 == ((atomic_granule_put_release_spec v_31 st_46));
    when st_50 == ((free_stack "smc_rec_enter" st_0 st_48));
    (Some st_50).

  Definition smc_rec_enter_15_low (st_0: RData) (st_36: RData) (v_2: Z) (v_31: Ptr) (v_40: Ptr) (v_86: Z) : (option RData) :=
    rely (((v_86 =? (0)) = (true)));
    when st_38 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_36));
    when st_39 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_38));
    when v_95, st_46 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_39));
    when st_47 == ((ns_buffer_unmap_spec 0 st_46));
    when st_49 == ((atomic_granule_put_release_spec v_31 st_47));
    when st_51 == ((free_stack "smc_rec_enter" st_0 st_49));
    (Some st_51).

  Definition smc_rec_enter_16_low (st_0: RData) (st_34: RData) (v_2: Z) (v_31: Ptr) (v_40: Ptr) (v_86: Z) : (option RData) :=
    rely (((v_86 =? (0)) = (true)));
    when st_36 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_34));
    when st_37 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_36));
    when v_95, st_44 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_37));
    when st_45 == ((ns_buffer_unmap_spec 0 st_44));
    when st_47 == ((atomic_granule_put_release_spec v_31 st_45));
    when st_49 == ((free_stack "smc_rec_enter" st_0 st_47));
    (Some st_49).

  Definition smc_rec_enter_17_low (st_0: RData) (st_35: RData) (v_2: Z) (v_31: Ptr) (v_40: Ptr) (v_86: Z) : (option RData) :=
    rely (((v_86 =? (0)) = (true)));
    when st_37 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_35));
    when st_38 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_37));
    when v_95, st_45 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_38));
    when st_46 == ((ns_buffer_unmap_spec 0 st_45));
    when st_48 == ((atomic_granule_put_release_spec v_31 st_46));
    when st_50 == ((free_stack "smc_rec_enter" st_0 st_48));
    (Some st_50).

  Definition smc_rec_enter_18_low (st_0: RData) (st_37: RData) (v_2: Z) (v_31: Ptr) (v_40: Ptr) (v_86: Z) : (option RData) :=
    rely (((v_86 =? (0)) = (true)));
    when st_39 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_37));
    when st_40 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_39));
    when v_95, st_47 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_40));
    when st_48 == ((ns_buffer_unmap_spec 0 st_47));
    when st_50 == ((atomic_granule_put_release_spec v_31 st_48));
    when st_52 == ((free_stack "smc_rec_enter" st_0 st_50));
    (Some st_52).

  Definition smc_rec_enter_19_low (st_0: RData) (st_38: RData) (v_2: Z) (v_31: Ptr) (v_40: Ptr) (v_86: Z) : (option RData) :=
    rely (((v_86 =? (0)) = (true)));
    when st_40 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_38));
    when st_41 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_40));
    when v_95, st_48 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_41));
    when st_49 == ((ns_buffer_unmap_spec 0 st_48));
    when st_51 == ((atomic_granule_put_release_spec v_31 st_49));
    when st_53 == ((free_stack "smc_rec_enter" st_0 st_51));
    (Some st_53).

  Definition smc_rec_enter_20_low (st_0: RData) (st_32: RData) (v_2: Z) (v_31: Ptr) (v_40: Ptr) (v_86: Z) : (option RData) :=
    rely (((v_86 =? (0)) = (true)));
    when st_34 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_32));
    when st_35 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_34));
    when v_95, st_42 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_35));
    when st_43 == ((ns_buffer_unmap_spec 0 st_42));
    when st_45 == ((atomic_granule_put_release_spec v_31 st_43));
    when st_47 == ((free_stack "smc_rec_enter" st_0 st_45));
    (Some st_47).

  Definition smc_rec_enter_21_low (st_0: RData) (st_33: RData) (v_2: Z) (v_31: Ptr) (v_40: Ptr) (v_86: Z) : (option RData) :=
    rely (((v_86 =? (0)) = (true)));
    when st_35 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_33));
    when st_36 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_35));
    when v_95, st_43 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_36));
    when st_44 == ((ns_buffer_unmap_spec 0 st_43));
    when st_46 == ((atomic_granule_put_release_spec v_31 st_44));
    when st_48 == ((free_stack "smc_rec_enter" st_0 st_46));
    (Some st_48).

  Definition smc_rec_enter_22_low (st_0: RData) (st_35: RData) (v_2: Z) (v_31: Ptr) (v_40: Ptr) (v_86: Z) : (option RData) :=
    rely (((v_86 =? (0)) = (true)));
    when st_37 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_35));
    when st_38 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_37));
    when v_95, st_45 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_38));
    when st_46 == ((ns_buffer_unmap_spec 0 st_45));
    when st_48 == ((atomic_granule_put_release_spec v_31 st_46));
    when st_50 == ((free_stack "smc_rec_enter" st_0 st_48));
    (Some st_50).

  Definition smc_rec_enter_23_low (st_0: RData) (st_36: RData) (v_2: Z) (v_31: Ptr) (v_40: Ptr) (v_86: Z) : (option RData) :=
    rely (((v_86 =? (0)) = (true)));
    when st_38 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_36));
    when st_39 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_38));
    when v_95, st_46 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_39));
    when st_47 == ((ns_buffer_unmap_spec 0 st_46));
    when st_49 == ((atomic_granule_put_release_spec v_31 st_47));
    when st_51 == ((free_stack "smc_rec_enter" st_0 st_49));
    (Some st_51).

  Definition smc_rec_enter_24_low (st_0: RData) (st_32: RData) (v_2: Z) (v_31: Ptr) (v_40: Ptr) (v_86: Z) : (option RData) :=
    rely (((v_86 =? (0)) = (true)));
    when st_34 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_32));
    when st_35 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_34));
    when v_95, st_42 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_35));
    when st_43 == ((ns_buffer_unmap_spec 0 st_42));
    when st_45 == ((atomic_granule_put_release_spec v_31 st_43));
    when st_47 == ((free_stack "smc_rec_enter" st_0 st_45));
    (Some st_47).

  Definition smc_rec_enter_25_low (st_0: RData) (st_33: RData) (v_2: Z) (v_31: Ptr) (v_40: Ptr) (v_86: Z) : (option RData) :=
    rely (((v_86 =? (0)) = (true)));
    when st_35 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_33));
    when st_36 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_35));
    when v_95, st_43 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_36));
    when st_44 == ((ns_buffer_unmap_spec 0 st_43));
    when st_46 == ((atomic_granule_put_release_spec v_31 st_44));
    when st_48 == ((free_stack "smc_rec_enter" st_0 st_46));
    (Some st_48).

  Definition smc_rec_enter_26_low (st_0: RData) (st_35: RData) (v_2: Z) (v_31: Ptr) (v_40: Ptr) (v_86: Z) : (option RData) :=
    rely (((v_86 =? (0)) = (true)));
    when st_37 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_35));
    when st_38 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_37));
    when v_95, st_45 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_38));
    when st_46 == ((ns_buffer_unmap_spec 0 st_45));
    when st_48 == ((atomic_granule_put_release_spec v_31 st_46));
    when st_50 == ((free_stack "smc_rec_enter" st_0 st_48));
    (Some st_50).

  Definition smc_rec_enter_27_low (st_0: RData) (st_36: RData) (v_2: Z) (v_31: Ptr) (v_40: Ptr) (v_86: Z) : (option RData) :=
    rely (((v_86 =? (0)) = (true)));
    when st_38 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_36));
    when st_39 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_38));
    when v_95, st_46 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_39));
    when st_47 == ((ns_buffer_unmap_spec 0 st_46));
    when st_49 == ((atomic_granule_put_release_spec v_31 st_47));
    when st_51 == ((free_stack "smc_rec_enter" st_0 st_49));
    (Some st_51).

  Definition smc_rec_enter_28_low (st_0: RData) (st_30: RData) (v_2: Z) (v_31: Ptr) (v_40: Ptr) (v_86: Z) : (option RData) :=
    rely (((v_86 =? (0)) = (true)));
    when st_32 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_30));
    when st_33 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_32));
    when v_95, st_40 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_33));
    when st_41 == ((ns_buffer_unmap_spec 0 st_40));
    when st_43 == ((atomic_granule_put_release_spec v_31 st_41));
    when st_45 == ((free_stack "smc_rec_enter" st_0 st_43));
    (Some st_45).

  Definition smc_rec_enter_29_low (st_0: RData) (st_31: RData) (v_2: Z) (v_31: Ptr) (v_40: Ptr) (v_86: Z) : (option RData) :=
    rely (((v_86 =? (0)) = (true)));
    when st_33 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_31));
    when st_34 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_33));
    when v_95, st_41 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_34));
    when st_42 == ((ns_buffer_unmap_spec 0 st_41));
    when st_44 == ((atomic_granule_put_release_spec v_31 st_42));
    when st_46 == ((free_stack "smc_rec_enter" st_0 st_44));
    (Some st_46).

  Definition smc_rec_enter_30_low (st_0: RData) (st_33: RData) (v_2: Z) (v_31: Ptr) (v_40: Ptr) (v_86: Z) : (option RData) :=
    rely (((v_86 =? (0)) = (true)));
    when st_35 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_33));
    when st_36 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_35));
    when v_95, st_43 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_36));
    when st_44 == ((ns_buffer_unmap_spec 0 st_43));
    when st_46 == ((atomic_granule_put_release_spec v_31 st_44));
    when st_48 == ((free_stack "smc_rec_enter" st_0 st_46));
    (Some st_48).

  Definition smc_rec_enter_31_low (st_0: RData) (st_34: RData) (v_2: Z) (v_31: Ptr) (v_40: Ptr) (v_86: Z) : (option RData) :=
    rely (((v_86 =? (0)) = (true)));
    when st_36 == ((rec_run_loop_spec v_40 (mkPtr "stack_s_rec_exit" 0) st_34));
    when st_37 == ((copy_gic_state_to_ns_spec (ptr_offset v_40 584) (mkPtr "stack_s_rec_exit" 0) st_36));
    when v_95, st_44 == ((ns_buffer_write_spec 0 v_2 304 (mkPtr "stack_s_rec_exit" 0) st_37));
    when st_45 == ((ns_buffer_unmap_spec 0 st_44));
    when st_47 == ((atomic_granule_put_release_spec v_31 st_45));
    when st_49 == ((free_stack "smc_rec_enter" st_0 st_47));
    (Some st_49).

  Definition smc_rec_enter_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Ptr) (st: RData) : (option RData) :=
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



End Layer13_smc_rec_enter_LowSpec.

#[global] Hint Unfold smc_rec_enter_spec_low: spec.
#[global] Hint Unfold smc_rec_enter_0_low: spec.
#[global] Hint Unfold smc_rec_enter_1_low: spec.
#[global] Hint Unfold smc_rec_enter_2_low: spec.
#[global] Hint Unfold smc_rec_enter_3_low: spec.
#[global] Hint Unfold smc_rec_enter_4_low: spec.
#[global] Hint Unfold smc_rec_enter_5_low: spec.
#[global] Hint Unfold smc_rec_enter_6_low: spec.
#[global] Hint Unfold smc_rec_enter_7_low: spec.
#[global] Hint Unfold smc_rec_enter_8_low: spec.
#[global] Hint Unfold smc_rec_enter_9_low: spec.
#[global] Hint Unfold smc_rec_enter_10_low: spec.
#[global] Hint Unfold smc_rec_enter_11_low: spec.
#[global] Hint Unfold smc_rec_enter_12_low: spec.
#[global] Hint Unfold smc_rec_enter_13_low: spec.
#[global] Hint Unfold smc_rec_enter_14_low: spec.
#[global] Hint Unfold smc_rec_enter_15_low: spec.
#[global] Hint Unfold smc_rec_enter_16_low: spec.
#[global] Hint Unfold smc_rec_enter_17_low: spec.
#[global] Hint Unfold smc_rec_enter_18_low: spec.
#[global] Hint Unfold smc_rec_enter_19_low: spec.
#[global] Hint Unfold smc_rec_enter_20_low: spec.
#[global] Hint Unfold smc_rec_enter_21_low: spec.
#[global] Hint Unfold smc_rec_enter_22_low: spec.
#[global] Hint Unfold smc_rec_enter_23_low: spec.
#[global] Hint Unfold smc_rec_enter_24_low: spec.
#[global] Hint Unfold smc_rec_enter_25_low: spec.
#[global] Hint Unfold smc_rec_enter_26_low: spec.
#[global] Hint Unfold smc_rec_enter_27_low: spec.
#[global] Hint Unfold smc_rec_enter_28_low: spec.
#[global] Hint Unfold smc_rec_enter_29_low: spec.
#[global] Hint Unfold smc_rec_enter_30_low: spec.
#[global] Hint Unfold smc_rec_enter_31_low: spec.
