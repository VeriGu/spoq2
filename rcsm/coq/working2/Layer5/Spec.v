Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer3.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter llvm_memset_p0i8_i64_spec_state_oracle : Ptr -> (Z -> (Z -> (bool -> (RData -> (option RData))))).

Parameter memcpy_ns_write_spec_state_oracle : Ptr -> (Ptr -> (Z -> (RData -> (option (bool * RData))))).

Parameter memcpy_ns_read_spec_state_oracle : Ptr -> (Ptr -> (Z -> (RData -> (option (bool * RData))))).

Parameter monitor_call_state_oracle : Z -> (Z -> (Z -> (Z -> (Z -> (Z -> (Z -> (RData -> (option (Z * RData))))))))).

Section Layer5_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition llvm_memset_p0i8_i64_spec (v_0: Ptr) (arg1: Z) (arg2: Z) (arg3: bool) (st: RData) : (option RData) :=
    when st_0 == ((llvm_memset_p0i8_i64_spec_state_oracle v_0 arg1 arg2 arg3 st));
    rely ((((st_0.(share)).(granule_data)) = (((st.(share)).(granule_data)))));
    (Some st_0).

  Definition memcpy_ns_write_spec (v_dest: Ptr) (v_src: Ptr) (v_conv: Z) (st: RData) : (option (bool * RData)) :=
    rely ((((v_src.(pbase)) = ("granule_data")) /\ (((v_src.(poffset)) >= (0)))));
    (memcpy_ns_read_spec_state_oracle v_dest v_src v_conv st).

  Definition memcpy_ns_read_spec (v_dest: Ptr) (v_src: Ptr) (v_conv: Z) (st: RData) : (option (bool * RData)) :=
    rely ((((v_src.(pbase)) = ("granule_data")) /\ (((v_src.(poffset)) >= (0)))));
    (memcpy_ns_read_spec_state_oracle v_dest v_src v_conv st).

  Definition monitor_call_spec (id: Z) (arg0: Z) (arg1: Z) (arg2: Z) (arg3: Z) (arg4: Z) (arg5: Z) (st: RData) : (option (Z * RData)) :=
    (monitor_call_state_oracle id arg0 arg1 arg2 arg3 arg4 arg5 st).

  Definition sort_granules_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
    (Some st).

  Definition find_lock_granule_spec' (v_0: Z) (v_1: Z) (st: RData) : (option (Ptr * RData)) :=
    rely (((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - (4294967296)) < (0)))) /\ (((v_0 & (4095)) = (0)))));
    when ret, st' == ((granule_try_lock_spec' (mkPtr "granules" (((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16))) v_1 st));
    if ret
    then (Some ((mkPtr "granules" (((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16))), st))
    else (Some ((mkPtr "null" 0), st)).

  Definition granule_unlock_spec (v_0: Ptr) (st: RData) : (option RData) :=
    if ((v_0.(pbase)) =s ("granules"))
    then (
      when cid == (((((((st.(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (16))).(e_lock)).(e_val)));
      (Some (((st.[halt] :< false).[log] :<
        ((EVT CPU_ID (REL ((v_0.(poffset)) / (16)) ((((st.(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (16))))) :: ((st.(log))))).[share].[globals].[g_granules] :<
        ((((st.(share)).(globals)).(g_granules)) #
          ((v_0.(poffset)) / (16)) ==
          (((((st.(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (16))).[e_lock].[e_val] :< None)))))
    else (
      if ((v_0.(pbase)) =s ("vmid_lock"))
      then (
        when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
        if ((v_0.(poffset)) =? (0))
        then (
          when cid == (((((st.(share)).(globals)).(g_vmid_lock)).(e_val)));
          (Some ((((lens 20 st).[halt] :< false).[log] :< ((EVT CPU_ID (REL vmid_lock_idx vmid_lock_g)) :: (((lens 20 st).(log))))).[share].[globals].[g_vmid_lock].[e_val] :<
            None)))
        else None)
      else None).

  Definition pack_struct_return_code_spec (v_0: Z) (st: RData) : (option (Z * RData)) :=
    (Some ((((v_0 >> (24)) & (4294967040)) |' (v_0)), st)).

  Definition make_return_code_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    (Some (((v_1 << (32)) + (v_0)), st)).

  Definition find_lock_granule_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Ptr * RData)) :=
    rely (((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - (4294967296)) < (0)))) /\ (((v_0 & (4095)) = (0)))));
    when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
    rely (
      (((((((st.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) -
        (((((((lens 2 st).(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)))) =
        (0)));
    if ((((((((lens 2 st).(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (v_1)) =? (0))
    then (Some ((mkPtr "granules" (((v_0 + ((- MEM0_PHYS))) >> (12)) * (16))), ((lens 28 st).[halt] :< false)))
    else (Some ((mkPtr "null" 0), ((lens 32 st).[halt] :< false))).

End Layer5_Spec.

#[global] Hint Unfold llvm_memset_p0i8_i64_spec: spec.
#[global] Hint Unfold memcpy_ns_write_spec: spec.
#[global] Hint Unfold memcpy_ns_read_spec: spec.
#[global] Hint Unfold monitor_call_spec: spec.
#[global] Hint Unfold sort_granules_spec: spec.
#[global] Hint Unfold find_lock_granule_spec': spec.
#[global] Hint Unfold granule_unlock_spec: spec.
#[global] Hint Unfold pack_struct_return_code_spec: spec.
#[global] Hint Unfold make_return_code_spec: spec.
#[global] Hint Unfold find_lock_granule_spec: spec.
