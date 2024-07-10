Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section InitRec_init_rec_regs_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition init_rec_regs_spec_low (v_rec: Ptr) (v_rec_params: Ptr) (v_rd: Ptr) (st: RData) : (option RData) :=
    rely (((v_rec.(pbase)) = ("slot_rec")));
    rely (((v_rec.(poffset)) = (0)));
    rely (((v_rec_params.(pbase)) = ("stack_realm_params")));
    let ofs := (v_rec.(poffset)) in
    let g_idx := (((st.(share)).(slots)) @ SLOT_REC) in
    let g_data := (((st.(share)).(granule_data)) @ g_idx) in
    let g := (((st.(share)).(granules)) @ g_idx) in
    when cid == ((g.(e_lock)));
    let g_rec := (g_data.(g_rec)) in
    let g_rec_0 := (g_rec.[e_regs] :< rec_regs_init) in
    let g_rec_1 := (g_rec_0.[e_pc] :< rec_pc_init) in
    let g_rec_2 := (g_rec_1.[e_pstate] :< rec_pstate_init) in
    let new_gdata := (g_data.[g_rec] :< g_rec_2) in
    let st_0 := (st.[share].[granule_data] :< (((st.(share)).(granule_data)) # g_idx == new_gdata)) in
    when st_1 == ((init_rec_sysregs_spec v_rec rec_params_mpidr st_0));
    when st_2 == ((init_common_sysregs_spec v_rec v_rd st_1));
    (Some st_2).

End InitRec_init_rec_regs_LowSpec.

#[global] Hint Unfold init_rec_regs_spec_low: spec.
