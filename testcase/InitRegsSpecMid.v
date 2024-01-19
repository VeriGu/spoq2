Definition init_rec_sysregs_spec_mid (v_rec: Ptr) (v_mpidr: Z) (st: RData) : (option RData) :=
  rely ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock)) = ((Some CPU_ID))));
  rely (((v_rec.(poffset)) = (0)));
  rely (((v_rec.(pbase)) = ("slot_rec")));
  (anno (((3272 * (0)) = (0)));
  (anno (((32 + (0)) = (32)));
  (anno (((880 + (32)) = (912)));
  (anno (((0 + (912)) = (912)));
  rely (((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true)));
  (anno (((0 + (912)) = (912)));
  (anno (((912 - (880)) = (32)));
  (anno (((3272 * (0)) = (0)));
  (anno (((32 + (0)) = (32)));
  if ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_pmu_enabled)) & (1)) =? (0))
  then (
    (anno (((288 + (32)) = (320)));
    (anno (((0 + (320)) = (320)));
    (anno (((320 - (288)) = (32)));
    (anno (((64 + (0)) = (64)));
    (anno (((288 + (64)) = (352)));
    (anno (((0 + (352)) = (352)));
    (anno (((352 - (288)) = (64)));
    (anno (((208 + (0)) = (208)));
    (anno (((288 + (208)) = (496)));
    (anno (((0 + (496)) = (496)));
    (anno (((496 - (288)) = (208)));
    (anno (((512 + (0)) = (512)));
    (anno (((288 + (512)) = (800)));
    (anno (((0 + (800)) = (800)));
    (anno (((800 - (288)) = (512)));
    (anno (((3272 * (0)) = (0)));
    (anno (((240 + (0)) = (240)));
    (anno (((288 + (240)) = (528)));
    (anno (((0 + (528)) = (528)));
    (anno (((528 - (288)) = (240)));
    (Some (st.[share].[granule_data] :<
      (((st.(share)).(granule_data)) #
        (((st.(share)).(slots)) @ SLOT_REC) ==
        ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).[g_rec].[e_sysregs] :<
          ((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_sysregs)).[e_sysreg_cnthctl_el2] :< 3072).[e_sysreg_mdscr_el1] :< 4096).[e_sysreg_pmcr_el0] :<
            96).[e_sysreg_sctlr_el1] :<
            12912760).[e_sysreg_vmpidr_el2] :<
            (v_mpidr |' (2147483648))))))))))))))))))))))))))))
  else (
    (anno (((288 + (32)) = (320)));
    (anno (((0 + (320)) = (320)));
    (anno (((320 - (288)) = (32)));
    (anno (((64 + (0)) = (64)));
    (anno (((288 + (64)) = (352)));
    (anno (((0 + (352)) = (352)));
    (anno (((352 - (288)) = (64)));
    (anno (((208 + (0)) = (208)));
    (anno (((288 + (208)) = (496)));
    (anno (((0 + (496)) = (496)));
    (anno (((496 - (288)) = (208)));
    (anno (((512 + (0)) = (512)));
    (anno (((288 + (512)) = (800)));
    (anno (((0 + (800)) = (800)));
    (anno (((800 - (288)) = (512)));
    (anno (((3272 * (0)) = (0)));
    (anno (((240 + (0)) = (240)));
    (anno (((288 + (240)) = (528)));
    (anno (((0 + (528)) = (528)));
    (anno (((528 - (288)) = (240)));
    (Some (st.[share].[granule_data] :<
      (((st.(share)).(granule_data)) #
        (((st.(share)).(slots)) @ SLOT_REC) ==
        ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).[g_rec].[e_sysregs] :<
          ((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_sysregs)).[e_sysreg_cnthctl_el2] :< 3072).[e_sysreg_mdscr_el1] :< 4096).[e_sysreg_pmcr_el0] :<
            102).[e_sysreg_sctlr_el1] :<
            12912760).[e_sysreg_vmpidr_el2] :<
            (v_mpidr |' (2147483648)))))))))))))))))))))))))))))))))))).

Definition init_common_sysregs_spec_mid (v_rec: Ptr) (v_rd: Ptr) (st: RData) : (option RData) :=
  rely ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RD)).(e_lock)) = ((Some CPU_ID))));
  rely ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock)) = ((Some CPU_ID))));
  rely (((v_rd.(poffset)) = (0)));
  rely (((v_rd.(pbase)) = ("slot_rd")));
  rely (((v_rec.(poffset)) = (0)));
  rely (((v_rec.(pbase)) = ("slot_rec")));
  (anno (((3272 * (0)) = (0)));
  (anno (((16 + (0)) = (16)));
  (anno (((816 + (16)) = (832)));
  (anno (((0 + (832)) = (832)));
  rely (((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true)));
  (anno (((0 + (832)) = (832)));
  (anno (((832 - (816)) = (16)));
  when ret == (
      (realm_vtcr_spec'
        v_rd 
        (st.[share].[granule_data] :<
          (((st.(share)).(granule_data)) #
            (((st.(share)).(slots)) @ SLOT_REC) ==
            ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).[g_rec].[e_common_sysregs].[e_common_hcr_el2] :< 70525511271487)))));
  (anno (((3272 * (0)) = (0)));
  (anno (((8 + (0)) = (8)));
  (anno (((816 + (8)) = (824)));
  (anno (((0 + (824)) = (824)));
  (anno (((824 - (816)) = (8)));
  (anno (((456 * (0)) = (0)));
  (anno (((16 + (0)) = (16)));
  (anno (((16 + (16)) = (32)));
  (anno (((0 + (32)) = (32)));
  (anno (((32 - (16)) = (16)));
  rely (
    (((((((((st.(share)).(granule_data)) #
      (((st.(share)).(slots)) @ SLOT_REC) ==
      ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).[g_rec].[e_common_sysregs] :<
        (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_common_sysregs)).[e_common_hcr_el2] :< 70525511271487).[e_common_vtcr_el2] :<
          ret))) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) >?
      (0)) =
      (true)));
  (anno (((RMM_MAX_GRANULES * (ST_GRANULE_SIZE)) = (16777216)));
  rely (
    (((((((((((st.(share)).(granule_data)) #
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
      (true)));
  rely (
    (((((((((((st.(share)).(granule_data)) #
      (((st.(share)).(slots)) @ SLOT_REC) ==
      ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).[g_rec].[e_common_sysregs] :<
        (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_common_sysregs)).[e_common_hcr_el2] :< 70525511271487).[e_common_vtcr_el2] :<
          ret))) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
      (GRANULES_BASE)) mod
      (ST_GRANULE_SIZE)) =
      (0)) /\
      (("granules" = ("granules")))));
  (anno (((24 + (0)) = (24)));
  (anno (((16 + (24)) = (40)));
  (anno (((0 + (40)) = (40)));
  (anno (((40 - (16)) = (24)));
  (anno (((3272 * (0)) = (0)));
  (anno (((0 + (0)) = (0)));
  (anno (((816 + (0)) = (816)));
  (anno (((0 + (816)) = (816)));
  (anno (((816 - (816)) = (0)));
  (anno (((456 * (0)) = (0)));
  (anno (((56 + (0)) = (56)));
  (anno (((0 + (56)) = (56)));
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
    (anno (((3272 * (0)) = (0)));
    (anno (((24 + (0)) = (24)));
    (anno (((816 + (24)) = (840)));
    (anno (((0 + (840)) = (840)));
    (anno (((840 - (816)) = (24)));
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
                (281474976710654)))))))))))))))
  else (
    (anno (((3272 * (0)) = (0)));
    (anno (((24 + (0)) = (24)));
    (anno (((816 + (24)) = (840)));
    (anno (((0 + (840)) = (840)));
    (anno (((840 - (816)) = (24)));
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
                (281474976710654)))))))))))))))))))))))))))))))))))))))))))).

