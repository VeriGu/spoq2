Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer1_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition buffer_map_spec' (v_0: Z) (v_1: Z) (v_2: bool) : (option Ptr) :=
    rely (
      (((((v_1 - (MEM0_PHYS)) >= (0)) /\ (((v_1 - (4294967296)) < (0)))) /\ (((v_1 & (549755813888)) = (0)))) \/
        (((((v_1 - (MEM1_PHYS)) >= (0)) /\ (((v_1 - (556198264832)) < (0)))) /\ (((v_1 & (549755813888)) = (1)))))));
    if ((v_1 & (549755813888)) =? (0))
    then (Some (mkPtr "granule_data" ((- 2147483648) + (v_1))))
    else (Some (mkPtr "granule_data" ((- 549755813888) + (v_1)))).
  
  Definition granule_addr_spec' (v_0: Ptr) : (option Z) :=
    rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
    if ((v_0.(poffset)) >? (8388592))
    then (Some (((v_0.(poffset)) * (256)) + (549755813888)))
    else (Some (((v_0.(poffset)) * (256)) + (2147483648))).
  
  Definition granule_addr_spec (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    when ret == ((granule_addr_spec' v_0));
    (Some (ret, st)).
  
  Definition buffer_map_spec (v_0: Z) (v_1: Z) (v_2: bool) (st: RData) : (option (Ptr * RData)) :=
    when ret == ((buffer_map_spec' v_0 v_1 v_2));
    (Some (ret, st)).
  
  
End Layer1_Spec.

#[global] Hint Unfold buffer_map_spec': spec.
#[global] Hint Unfold granule_addr_spec': spec.
#[global] Hint Unfold granule_addr_spec: spec.
#[global] Hint Unfold buffer_map_spec: spec.
