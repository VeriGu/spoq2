Definition get_rd_state_locked_spec (v_rd: Ptr) (st: RData) : (option (Z * RData)) :=
  rely ((((v_rd.(pbase)) = ("slot_rd")) /\ (((v_rd.(poffset)) = (0)))));
  match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RD)).(e_lock))) with
  | (Some cid) => (Some ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_rd_state)), st))
  | _ => None
  end.

Definition get_rd_state_unlocked_spec (v_rd: Ptr) (st: RData) : (option (Z * RData)) :=
  rely ((((v_rd.(pbase)) = ("slot_rd")) /\ (((v_rd.(poffset)) = (0)))));
  match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RD)).(e_lock))) with
  | (Some cid) => (Some ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_rd_state)), st))
  | _ => None
  end.

Definition set_rd_state_spec (v_rd: Ptr) (v_state: Z) (st: RData) : (option RData) :=
  rely (
    ((((v_rd.(pbase)) = ("slot_rd")) /\ (((v_rd.(poffset)) = (0)))) /\
      (match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RD)).(e_lock))) with
      | (Some cid) => (true = (true))
      | _ => (false = (true))
      end)));
  match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RD)).(e_lock))) with
  | (Some cid) =>
    (Some (st.[share].[granule_data] :<
      (((st.(share)).(granule_data)) #
        (((st.(share)).(slots)) @ SLOT_RD) ==
        ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).[g_rd].[e_rd_rd_state] :< v_state))))
  | _ => None
  end.

Definition get_rd_rec_count_locked_spec (v_rd: Ptr) (st: RData) : (option (Z * RData)) :=
  rely ((((v_rd.(pbase)) = ("slot_rd")) /\ (((v_rd.(poffset)) = (0)))));
  match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RD)).(e_lock))) with
  | (Some cid) => (Some ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_rec_count)), st))
  | _ => None
  end.

Definition get_rd_rec_count_unlocked_spec (v_rd: Ptr) (st: RData) : (option (Z * RData)) :=
  rely ((((v_rd.(pbase)) = ("slot_rd")) /\ (((v_rd.(poffset)) = (0)))));
  match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RD)).(e_lock))) with
  | (Some cid) => (Some ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_rec_count)), st))
  | _ => None
  end.

Definition set_rd_rec_count_spec (v_rd: Ptr) (v_val: Z) (st: RData) : (option RData) :=
  rely (
    ((((v_rd.(pbase)) = ("slot_rd")) /\ (((v_rd.(poffset)) = (0)))) /\
      (match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RD)).(e_lock))) with
      | (Some cid) => (true = (true))
      | _ => (false = (true))
      end)));
  match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RD)).(e_lock))) with
  | (Some cid) =>
    (Some (st.[share].[granule_data] :<
      (((st.(share)).(granule_data)) #
        (((st.(share)).(slots)) @ SLOT_RD) ==
        ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).[g_rd].[e_rd_rec_count] :< v_val))))
  | _ => None
  end.

