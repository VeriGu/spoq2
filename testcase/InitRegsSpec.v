Parameter init_rec_sysregs_spec_state_oracle : RData -> (option RData).

Parameter init_common_sysregs_spec_state_oracle : RData -> (option RData).

Definition init_rec_sysregs_spec_shadow (v_rec: Ptr) (v_mpidr: Z) (st: RData) : (option RData) :=
  rely (
    ((((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock)) = ((Some CPU_ID))) /\ (((v_rec.(poffset)) = (0)))) /\
      (((v_rec.(pbase)) = ("slot_rec")))) /\
      (((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true)))));
  if ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_pmu_enabled)) & (1)) =? (0))
  then (
    (Some (st.[share].[granule_data] :<
      (((st.(share)).(granule_data)) #
        (((st.(share)).(slots)) @ SLOT_REC) ==
        ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).[g_rec].[e_sysregs] :<
          ((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_sysregs)).[e_sysreg_cnthctl_el2] :< 3072).[e_sysreg_mdscr_el1] :< 4096).[e_sysreg_pmcr_el0] :<
            96).[e_sysreg_sctlr_el1] :<
            12912760).[e_sysreg_vmpidr_el2] :<
            (v_mpidr |' (2147483648))))))))
  else (
    (Some (st.[share].[granule_data] :<
      (((st.(share)).(granule_data)) #
        (((st.(share)).(slots)) @ SLOT_REC) ==
        ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).[g_rec].[e_sysregs] :<
          ((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_sysregs)).[e_sysreg_cnthctl_el2] :< 3072).[e_sysreg_mdscr_el1] :< 4096).[e_sysreg_pmcr_el0] :<
            102).[e_sysreg_sctlr_el1] :<
            12912760).[e_sysreg_vmpidr_el2] :<
            (v_mpidr |' (2147483648)))))))).

Definition init_rec_sysregs_spec (v_rec: Ptr) (v_mpidr: Z) (st: RData) : (option RData) :=
  rely (
    ((((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock)) = ((Some CPU_ID))) /\ (((v_rec.(poffset)) = (0)))) /\
      (((v_rec.(pbase)) = ("slot_rec")))) /\
      (((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true)))));
  when st' == ((init_rec_sysregs_spec_state_oracle st));
  (Some st').

Definition init_common_sysregs_spec_shadow (v_rec: Ptr) (v_rd: Ptr) (st: RData) : (option RData) :=
  rely (
    (((((((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RD)).(e_lock)) = ((Some CPU_ID))) /\
      ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock)) = ((Some CPU_ID))))) /\
      (((v_rd.(poffset)) = (0)))) /\
      (((v_rd.(pbase)) = ("slot_rd")))) /\
      (((v_rec.(poffset)) = (0)))) /\
      (((v_rec.(pbase)) = ("slot_rec")))) /\
      (((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true)))));
  when ret == (
      (realm_vtcr_spec'
        v_rd 
        (st.[share].[granule_data] :<
          (((st.(share)).(granule_data)) #
            (((st.(share)).(slots)) @ SLOT_REC) ==
            ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).[g_rec].[e_common_sysregs].[e_common_hcr_el2] :< 70525511271487)))));
  rely (
    (((((((((((st.(share)).(granule_data)) #
      (((st.(share)).(slots)) @ SLOT_REC) ==
      ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).[g_rec].[e_common_sysregs] :<
        (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_common_sysregs)).[e_common_hcr_el2] :< 70525511271487).[e_common_vtcr_el2] :<
          ret))) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) >?
      (0)) =
      (true)) /\
      ((((((((((((st.(share)).(granule_data)) #
        (((st.(share)).(slots)) @ SLOT_REC) ==
        ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).[g_rec].[e_common_sysregs] :<
          (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_common_sysregs)).[e_common_hcr_el2] :< 70525511271487).[e_common_vtcr_el2] :<
            ret))) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
        (GRANULES_BASE)) >?
        (0)) &&
        ((((((((((st.(share)).(granule_data)) #
          (((st.(share)).(slots)) @ SLOT_REC) ==
          ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).[g_rec].[e_common_sysregs] :<
            (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_common_sysregs)).[e_common_hcr_el2] :< 70525511271487).[e_common_vtcr_el2] :<
              ret))) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
          ((GRANULES_BASE + (16777216)))) <?
          (0)))) =
        (true)))) /\
      ((((((((((((st.(share)).(granule_data)) #
        (((st.(share)).(slots)) @ SLOT_REC) ==
        ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).[g_rec].[e_common_sysregs] :<
          (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_common_sysregs)).[e_common_hcr_el2] :< 70525511271487).[e_common_vtcr_el2] :<
            ret))) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
        (GRANULES_BASE)) mod
        (ST_GRANULE_SIZE)) =
        (0)) /\
        (("granules" = ("granules")))))));
  if (
    ((((((((st.(share)).(granule_data)) #
      (((st.(share)).(slots)) @ SLOT_REC) ==
      ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).[g_rec].[e_common_sysregs] :<
        ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_common_sysregs)).[e_common_hcr_el2] :< 70525511271487).[e_common_vtcr_el2] :<
          ret).[e_common_vttbr_el2] :<
          (((((((((st.(share)).(granule_data)) #
            (((st.(share)).(slots)) @ SLOT_REC) ==
            ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).[g_rec].[e_common_sysregs] :<
              (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_common_sysregs)).[e_common_hcr_el2] :< 70525511271487).[e_common_vtcr_el2] :<
                ret))) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_vmid)) <<
            (48)) +
            ((((((((((((st.(share)).(granule_data)) #
              (((st.(share)).(slots)) @ SLOT_REC) ==
              ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).[g_rec].[e_common_sysregs] :<
                (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_common_sysregs)).[e_common_hcr_el2] :< 70525511271487).[e_common_vtcr_el2] :<
                  ret))) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
              (GRANULES_BASE)) >>
              (4)) *
              (GRANULE_SIZE)) &
              (281474976710654))))))) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_pmu_enabled)) &
      (1)) =?
      (0)))
  then (
    (Some (st.[share].[granule_data] :<
      (((st.(share)).(granule_data)) #
        (((st.(share)).(slots)) @ SLOT_REC) ==
        ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).[g_rec].[e_common_sysregs] :<
          (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_common_sysregs)).[e_common_hcr_el2] :< 70525511271487).[e_common_mdcr_el2] :<
            ((((st.(priv)).(pcpu_regs)).(pcpu_mdcr_el2)) |' (96))).[e_common_vtcr_el2] :<
            ret).[e_common_vttbr_el2] :<
            (((((((((st.(share)).(granule_data)) #
              (((st.(share)).(slots)) @ SLOT_REC) ==
              ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).[g_rec].[e_common_sysregs] :<
                (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_common_sysregs)).[e_common_hcr_el2] :< 70525511271487).[e_common_vtcr_el2] :<
                  ret))) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_vmid)) <<
              (48)) +
              ((((((((((((st.(share)).(granule_data)) #
                (((st.(share)).(slots)) @ SLOT_REC) ==
                ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).[g_rec].[e_common_sysregs] :<
                  (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_common_sysregs)).[e_common_hcr_el2] :< 70525511271487).[e_common_vtcr_el2] :<
                    ret))) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
                (GRANULES_BASE)) >>
                (4)) *
                (GRANULE_SIZE)) &
                (281474976710654))))))))))
  else (
    (Some (st.[share].[granule_data] :<
      (((st.(share)).(granule_data)) #
        (((st.(share)).(slots)) @ SLOT_REC) ==
        ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).[g_rec].[e_common_sysregs] :<
          (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_common_sysregs)).[e_common_hcr_el2] :< 70525511271487).[e_common_mdcr_el2] :<
            ((((st.(priv)).(pcpu_regs)).(pcpu_mdcr_el2)) & ((- 97)))).[e_common_vtcr_el2] :<
            ret).[e_common_vttbr_el2] :<
            (((((((((st.(share)).(granule_data)) #
              (((st.(share)).(slots)) @ SLOT_REC) ==
              ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).[g_rec].[e_common_sysregs] :<
                (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_common_sysregs)).[e_common_hcr_el2] :< 70525511271487).[e_common_vtcr_el2] :<
                  ret))) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_vmid)) <<
              (48)) +
              ((((((((((((st.(share)).(granule_data)) #
                (((st.(share)).(slots)) @ SLOT_REC) ==
                ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).[g_rec].[e_common_sysregs] :<
                  (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_common_sysregs)).[e_common_hcr_el2] :< 70525511271487).[e_common_vtcr_el2] :<
                    ret))) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
                (GRANULES_BASE)) >>
                (4)) *
                (GRANULE_SIZE)) &
                (281474976710654)))))))))).

Definition init_common_sysregs_spec (v_rec: Ptr) (v_rd: Ptr) (st: RData) : (option RData) :=
  rely (
    (((((((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RD)).(e_lock)) = ((Some CPU_ID))) /\
      ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock)) = ((Some CPU_ID))))) /\
      (((v_rd.(poffset)) = (0)))) /\
      (((v_rd.(pbase)) = ("slot_rd")))) /\
      (((v_rec.(poffset)) = (0)))) /\
      (((v_rec.(pbase)) = ("slot_rec")))) /\
      (((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true)))));
  when ret == ((realm_vtcr_spec' v_rd st));
  rely (
    ((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) >? (0)) = (true)) /\
      (((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) >? (0)) &&
        (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - ((GRANULES_BASE + (16777216)))) <? (0)))) =
        (true)))) /\
      (((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)) /\
        (("granules" = ("granules")))))));
  when st' == ((init_common_sysregs_spec_state_oracle st));
  (Some st').

