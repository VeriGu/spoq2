Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section RDState_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition get_rd_state_locked_spec (v_rd: Ptr) (st: RData) : (option (Z * RData)) :=
    rely ((((v_rd.(pbase)) = ("slot_rd")) /\ (((v_rd.(poffset)) = (0)))));
    when cid == (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RD)).(e_lock)));
    (Some ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_rd_state)), st)).

  Definition get_rd_state_unlocked_spec (v_rd: Ptr) (st: RData) : (option (Z * RData)) :=
    rely ((((v_rd.(pbase)) = ("slot_rd")) /\ (((v_rd.(poffset)) = (0)))));
    when cid == (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RD)).(e_lock)));
    (Some ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_rd_state)), st)).

  Definition set_rd_state_spec (v_rd: Ptr) (v_state: Z) (st: RData) : (option RData) :=
    rely ((((v_rd.(pbase)) = ("slot_rd")) /\ (((v_rd.(poffset)) = (0)))));
    if (
      match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RD)).(e_lock))) with
      | (Some cid) => true
      | None => false
      end)
    then (
      when cid == (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RD)).(e_lock)));
      (Some (st.[share].[granule_data] :<
        (((st.(share)).(granule_data)) #
          (((st.(share)).(slots)) @ SLOT_RD) ==
          ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).[g_rd] :<
            (((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).[e_rd_rd_state] :< v_state))))))
    else None.

  Definition get_rd_rec_count_locked_spec (v_rd: Ptr) (st: RData) : (option (Z * RData)) :=
    rely ((((v_rd.(pbase)) = ("slot_rd")) /\ (((v_rd.(poffset)) = (0)))));
    when cid == (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RD)).(e_lock)));
    (Some ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_rec_count)), st)).

  Definition get_rd_rec_count_unlocked_spec (v_rd: Ptr) (st: RData) : (option (Z * RData)) :=
    rely ((((v_rd.(pbase)) = ("slot_rd")) /\ (((v_rd.(poffset)) = (0)))));
    when cid == (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RD)).(e_lock)));
    (Some ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_rec_count)), st)).

  Definition set_rd_rec_count_spec (v_rd: Ptr) (v_val: Z) (st: RData) : (option RData) :=
    rely ((((v_rd.(pbase)) = ("slot_rd")) /\ (((v_rd.(poffset)) = (0)))));
    if (
      match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RD)).(e_lock))) with
      | (Some cid) => true
      | None => false
      end)
    then (
      when cid == (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RD)).(e_lock)));
      (Some (st.[share].[granule_data] :<
        (((st.(share)).(granule_data)) #
          (((st.(share)).(slots)) @ SLOT_RD) ==
          ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).[g_rd] :<
            (((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).[e_rd_rec_count] :< v_val))))))
    else None.

End RDState_Spec.

#[global] Hint Unfold get_rd_state_locked_spec: spec.
#[global] Hint Unfold get_rd_state_unlocked_spec: spec.
#[global] Hint Unfold set_rd_state_spec: spec.
#[global] Hint Unfold get_rd_rec_count_locked_spec: spec.
#[global] Hint Unfold get_rd_rec_count_unlocked_spec: spec.
#[global] Hint Unfold set_rd_rec_count_spec: spec.
