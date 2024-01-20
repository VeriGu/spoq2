Parameter realm_inject_undef_abort_spec_state_oracle : RData -> (option RData).

Parameter inject_sync_idabort_spec_state_oracle : RData -> (option RData).

Parameter inject_serror_spec_state_oracle : RData -> (option RData).

Parameter inject_sync_idabort_rec_spec_state_oracle : RData -> (option RData).

Definition realm_inject_undef_abort_spec_shadow (st: RData) : (option RData) :=
  (Some (((((st.[priv].[pcpu_regs].[pcpu_elr_el12] :< (((st.(priv)).(pcpu_regs)).(pcpu_elr_el2))).[priv].[pcpu_regs].[pcpu_elr_el2] :<
    (calc_vector_entry_spec' (((st.(priv)).(pcpu_regs)).(pcpu_vbar_el12)) (((st.(priv)).(pcpu_regs)).(pcpu_spsr_el2)) st)).[priv].[pcpu_regs].[pcpu_esr_el12] :<
    33554432).[priv].[pcpu_regs].[pcpu_spsr_el12] :<
    (((st.(priv)).(pcpu_regs)).(pcpu_spsr_el2))).[priv].[pcpu_regs].[pcpu_spsr_el2] :<
    965)).

Definition realm_inject_undef_abort_spec (st: RData) : (option RData) :=
  when st' == ((realm_inject_undef_abort_spec_state_oracle st));
  (Some st').

Definition inject_sync_idabort_spec_shadow (v_fsc: Z) (st: RData) : (option RData) :=
  (Some ((((((st.[priv].[pcpu_regs].[pcpu_elr_el12] :< (((st.(priv)).(pcpu_regs)).(pcpu_elr_el2))).[priv].[pcpu_regs].[pcpu_elr_el2] :<
    (calc_vector_entry_spec' (((st.(priv)).(pcpu_regs)).(pcpu_vbar_el12)) (((st.(priv)).(pcpu_regs)).(pcpu_spsr_el2)) st)).[priv].[pcpu_regs].[pcpu_esr_el12] :<
    (calc_esr_idabort_spec' (((st.(priv)).(pcpu_regs)).(pcpu_esr_el2)) (((st.(priv)).(pcpu_regs)).(pcpu_spsr_el2)) v_fsc st)).[priv].[pcpu_regs].[pcpu_far_el12] :<
    (((st.(priv)).(pcpu_regs)).(pcpu_far_el2))).[priv].[pcpu_regs].[pcpu_spsr_el12] :<
    (((st.(priv)).(pcpu_regs)).(pcpu_spsr_el2))).[priv].[pcpu_regs].[pcpu_spsr_el2] :<
    965)).

Definition inject_sync_idabort_spec (v_fsc: Z) (st: RData) : (option RData) :=
  when st' == ((inject_sync_idabort_spec_state_oracle st));
  (Some st').

Definition inject_serror_spec_shadow (v_rec: Ptr) (v_vsesr: Z) (st: RData) : (option RData) :=
  rely (
    ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\
      (match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
      | (Some cid) => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))
      | None => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))
      end)));
  (Some (st.[share].[granule_data] :<
    (((st.(share)).(granule_data)) #
      (((st.(share)).(slots)) @ SLOT_REC) ==
      ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).[g_rec].[e_serror_info] :<
        (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_serror_info)).[e_inject] :< 1).[e_vsesr_el2] :< v_vsesr))))).

Definition inject_serror_spec (v_rec: Ptr) (v_vsesr: Z) (st: RData) : (option RData) :=
  rely (
    match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
    | (Some cid) =>
      ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\
        (((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))))
    | None =>
      ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\
        (((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))))
    end);
  when st' == ((inject_serror_spec_state_oracle st));
  (Some st').

Definition inject_sync_idabort_rec_spec_shadow (v_rec: Ptr) (v_fsc: Z) (st: RData) : (option RData) :=
  rely (
    (((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) = (1)) /\
      ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock)) = (None)))) /\
      ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))))));
  (Some (st.[share].[granule_data] :<
    (((st.(share)).(granule_data)) #
      (((st.(share)).(slots)) @ SLOT_REC) ==
      ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).[g_rec] :<
        (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).[e_pc] :<
          (calc_vector_entry_spec'
            ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_sysregs)).(e_sysreg_vbar_el1)) 
            (((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_pstate)) 
            (st.[share].[granule_data] :<
              (((st.(share)).(granule_data)) #
                (((st.(share)).(slots)) @ SLOT_REC) ==
                ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).[g_rec].[e_sysregs] :<
                  (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_sysregs)).[e_sysreg_elr_el1] :<
                    (((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_pc))).[e_sysreg_esr_el1] :<
                    (calc_esr_idabort_spec'
                      ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) 
                      (((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_pstate)) 
                      v_fsc 
                      (st.[share].[granule_data] :<
                        (((st.(share)).(granule_data)) #
                          (((st.(share)).(slots)) @ SLOT_REC) ==
                          ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).[g_rec].[e_sysregs] :<
                            ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_sysregs)).[e_sysreg_elr_el1] :<
                              (((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_pc))).[e_sysreg_far_el1] :<
                              ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_far))).[e_sysreg_spsr_el1] :<
                              (((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_pstate)))))))).[e_sysreg_far_el1] :<
                    ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_far))).[e_sysreg_spsr_el1] :<
                    (((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_pstate)))))))).[e_pstate] :<
          965).[e_sysregs] :<
          (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_sysregs)).[e_sysreg_elr_el1] :<
            (((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_pc))).[e_sysreg_esr_el1] :<
            (calc_esr_idabort_spec'
              ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) 
              (((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_pstate)) 
              v_fsc 
              (st.[share].[granule_data] :<
                (((st.(share)).(granule_data)) #
                  (((st.(share)).(slots)) @ SLOT_REC) ==
                  ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).[g_rec].[e_sysregs] :<
                    ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_sysregs)).[e_sysreg_elr_el1] :<
                      (((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_pc))).[e_sysreg_far_el1] :<
                      ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_far))).[e_sysreg_spsr_el1] :<
                      (((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_pstate)))))))).[e_sysreg_far_el1] :<
            ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_far))).[e_sysreg_spsr_el1] :<
            (((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_pstate)))))))).

Definition inject_sync_idabort_rec_spec (v_rec: Ptr) (v_fsc: Z) (st: RData) : (option RData) :=
  rely (
    (((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) = (1)) /\
      ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock)) = (None)))) /\
      ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))))));
  when st' == ((inject_sync_idabort_rec_spec_state_oracle st));
  (Some st').

