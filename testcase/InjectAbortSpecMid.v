Definition realm_inject_undef_abort_spec_mid (st: RData) : (option RData) :=
  (Some (((((st.[priv].[pcpu_regs].[pcpu_elr_el12] :< (((st.(priv)).(pcpu_regs)).(pcpu_elr_el2))).[priv].[pcpu_regs].[pcpu_elr_el2] :<
    (calc_vector_entry_spec' (((st.(priv)).(pcpu_regs)).(pcpu_vbar_el12)) (((st.(priv)).(pcpu_regs)).(pcpu_spsr_el2)) st)).[priv].[pcpu_regs].[pcpu_esr_el12] :<
    33554432).[priv].[pcpu_regs].[pcpu_spsr_el12] :<
    (((st.(priv)).(pcpu_regs)).(pcpu_spsr_el2))).[priv].[pcpu_regs].[pcpu_spsr_el2] :<
    965)).

Definition inject_sync_idabort_spec_mid (v_fsc: Z) (st: RData) : (option RData) :=
  (Some ((((((st.[priv].[pcpu_regs].[pcpu_elr_el12] :< (((st.(priv)).(pcpu_regs)).(pcpu_elr_el2))).[priv].[pcpu_regs].[pcpu_elr_el2] :<
    (calc_vector_entry_spec' (((st.(priv)).(pcpu_regs)).(pcpu_vbar_el12)) (((st.(priv)).(pcpu_regs)).(pcpu_spsr_el2)) st)).[priv].[pcpu_regs].[pcpu_esr_el12] :<
    (calc_esr_idabort_spec' (((st.(priv)).(pcpu_regs)).(pcpu_esr_el2)) (((st.(priv)).(pcpu_regs)).(pcpu_spsr_el2)) v_fsc st)).[priv].[pcpu_regs].[pcpu_far_el12] :<
    (((st.(priv)).(pcpu_regs)).(pcpu_far_el2))).[priv].[pcpu_regs].[pcpu_spsr_el12] :<
    (((st.(priv)).(pcpu_regs)).(pcpu_spsr_el2))).[priv].[pcpu_regs].[pcpu_spsr_el2] :<
    965)).

Definition inject_serror_spec_mid (v_rec: Ptr) (v_vsesr: Z) (st: RData) : (option RData) :=
  rely ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))));
  (anno (((3272 * (0)) = (0)));
  (anno (((0 + (0)) = (0)));
  (anno (((3248 + (0)) = (3248)));
  (anno (((0 + (3248)) = (3248)));
  rely (
    match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
    | (Some cid) => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))
    | None => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))
    end);
  (anno (((3272 * (0)) = (0)));
  (anno (((8 + (0)) = (8)));
  (anno (((3248 + (8)) = (3256)));
  (anno (((0 + (3256)) = (3256)));
  (Some (st.[share].[granule_data] :<
    (((st.(share)).(granule_data)) #
      (((st.(share)).(slots)) @ SLOT_REC) ==
      ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).[g_rec].[e_serror_info] :<
        (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_serror_info)).[e_inject] :< 1).[e_vsesr_el2] :< v_vsesr))))))))))))).

Definition inject_sync_idabort_rec_spec_mid (v_rec: Ptr) (v_fsc: Z) (st: RData) : (option RData) :=
  rely ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) = (1)));
  rely ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock)) = (None)));
  rely ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))));
  (anno (((928 + (16)) = (944)));
  (anno (((0 + (944)) = (944)));
  (anno (((144 + (0)) = (144)));
  (anno (((288 + (144)) = (432)));
  (anno (((0 + (432)) = (432)));
  (anno (((16 + (0)) = (16)));
  (anno (((288 + (16)) = (304)));
  (anno (((0 + (304)) = (304)));
  (anno (((24 + (0)) = (24)));
  (anno (((288 + (24)) = (312)));
  (anno (((0 + (312)) = (312)));
  (anno (((0 + (0)) = (0)));
  (anno (((928 + (0)) = (928)));
  (anno (((0 + (928)) = (928)));
  (anno (((120 + (0)) = (120)));
  (anno (((288 + (120)) = (408)));
  (anno (((0 + (408)) = (408)));
  (anno (((160 + (0)) = (160)));
  (anno (((288 + (160)) = (448)));
  (anno (((0 + (448)) = (448)));
  (anno (((272 + (0)) = (272)));
  (anno (((0 + (272)) = (272)));
  (anno (((3272 * (0)) = (0)));
  (anno (((280 + (0)) = (280)));
  (anno (((0 + (280)) = (280)));
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
            (((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_pstate))))))))))))))))))))))))))))))))).

