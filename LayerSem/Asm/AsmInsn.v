Require Import Coqlib.


(* Registers *)

Inductive regsize : Type := SZ32 | SZ64.

Inductive gpreg : Type :=
| Rx0 (sz: regsize) | Rx1 (sz: regsize) | Rx2 (sz: regsize) | Rx3 (sz: regsize)
| Rx4 (sz: regsize) | Rx5 (sz: regsize) | Rx6 (sz: regsize) | Rx7 (sz: regsize)
| Rx8 (sz: regsize) | Rx9 (sz: regsize) | Rx10 (sz: regsize) | Rx11 (sz: regsize)
| Rx12 (sz: regsize) | Rx13 (sz: regsize) | Rx14 (sz: regsize)
| Rx15 (sz: regsize) | Rx16 (sz: regsize) | Rx17 (sz: regsize)
| Rx18 (sz: regsize) | Rx19 (sz: regsize) | Rx20 (sz: regsize)
| Rx21 (sz: regsize) | Rx22 (sz: regsize) | Rx23 (sz: regsize)
| Rx24 (sz: regsize) | Rx25 (sz: regsize) | Rx26 (sz: regsize)
| Rx27 (sz: regsize) | Rx28 (sz: regsize) | Rx29 (sz: regsize)
| Rx30 (sz: regsize) | Rxzr
| Rw0 (sz: regsize) | Rw1 (sz: regsize) | Rw2 (sz: regsize) | Rw3 (sz: regsize)
| Rw4 (sz: regsize) | Rw5 (sz: regsize) | Rw6 (sz: regsize) | Rw7 (sz: regsize)
| Rw8 (sz: regsize) | Rw9 (sz: regsize) | Rw10 (sz: regsize) | Rw11 (sz: regsize)
| Rw12 (sz: regsize) | Rw13 (sz: regsize) | Rw14 (sz: regsize)
| Rw15 (sz: regsize) | Rw16 (sz: regsize) | Rw17 (sz: regsize)
| Rw18 (sz: regsize) | Rw19 (sz: regsize) | Rw20 (sz: regsize)
| Rw21 (sz: regsize) | Rw22 (sz: regsize) | Rw23 (sz: regsize)
| Rw24 (sz: regsize) | Rw25 (sz: regsize) | Rw26 (sz: regsize)
| Rw27 (sz: regsize) | Rw28 (sz: regsize) | Rw29 (sz: regsize)
| Rw30 (sz: regsize) | Rwzr.

Inductive sysreg : Type :=
| Rcntfrq_el0
| Rcntpct_el0
| Rcntp_ctl_el0
| Rcntp_cval_el0
| Rcntp_tval_el0
| Rcntv_ctl_el0
| Rcntv_cval_el0
| Rcntv_tval_el0
| Rsp_el0
| Rpmcr_el0
| Rpmuserenr_el0
| Rtpidrro_el0
| Rtpidr_el0
| Rpmccfiltr_el0
| Rpmccntr_el0
| Rpmcntenclr_el0
| Rpmcntenset_el0
| Rpmevcntr0_el0
| Rpmevcntr1_el0
| Rpmevcntr2_el0
| Rpmevcntr3_el0
| Rpmevcntr4_el0
| Rpmevcntr5_el0
| Rpmevcntr6_el0
| Rpmevcntr7_el0
| Rpmevcntr8_el0
| Rpmevcntr9_el0
| Rpmevcntr10_el0
| Rpmevcntr11_el0
| Rpmevcntr12_el0
| Rpmevcntr13_el0
| Rpmevcntr14_el0
| Rpmevcntr15_el0
| Rpmevcntr16_el0
| Rpmevcntr17_el0
| Rpmevcntr18_el0
| Rpmevcntr19_el0
| Rpmevcntr20_el0
| Rpmevcntr21_el0
| Rpmevcntr22_el0
| Rpmevcntr23_el0
| Rpmevcntr24_el0
| Rpmevcntr25_el0
| Rpmevcntr26_el0
| Rpmevcntr27_el0
| Rpmevcntr28_el0
| Rpmevcntr29_el0
| Rpmevcntr30_el0
| Rpmevtyper0_el0
| Rpmevtyper1_el0
| Rpmevtyper2_el0
| Rpmevtyper3_el0
| Rpmevtyper4_el0
| Rpmevtyper5_el0
| Rpmevtyper6_el0
| Rpmevtyper7_el0
| Rpmevtyper8_el0
| Rpmevtyper9_el0
| Rpmevtyper10_el0
| Rpmevtyper11_el0
| Rpmevtyper12_el0
| Rpmevtyper13_el0
| Rpmevtyper14_el0
| Rpmevtyper15_el0
| Rpmevtyper16_el0
| Rpmevtyper17_el0
| Rpmevtyper18_el0
| Rpmevtyper19_el0
| Rpmevtyper20_el0
| Rpmevtyper21_el0
| Rpmevtyper22_el0
| Rpmevtyper23_el0
| Rpmevtyper24_el0
| Rpmevtyper25_el0
| Rpmevtyper26_el0
| Rpmevtyper27_el0
| Rpmevtyper28_el0
| Rpmevtyper29_el0
| Rpmevtyper30_el0
| Rpmxevtyper_el0
| Rpmovsclr_el0
| Rpmovsset_el0
| Rpmselr_el0
| Rpmxevcntr_el0
| Rcntp_ctl_el02
| Rcntp_cval_el02
| Rcntv_ctl_el02
| Rcntv_cval_el02
| Rsp_el1
| Relr_el1
| Rspsr_el1
| Rcsselr_el1
| Rsctlr_el1
| Ractlr_el1
| Rcpacr_el1
| Rzcr_el1
| Rttbr0_el1
| Rttbr1_el1
| Rtcr_el1
| Resr_el1
| Rafsr0_el1
| Rafsr1_el1
| Rfar_el1
| Rmair_el1
| Rvbar_el1
| Rcontextidr_el1
| Rtpidr_el1
| Ramair_el1
| Rcntkctl_el1
| Rpar_el1
| Rmdscr_el1
| Rmdccint_el1
| Rdisr_el1
| Risr_el1
| Rmidr_el1
| Rmpam0_el1
| Ricc_ctlr_el1
| Ricc_hppir1_el1
| Rid_aa64afr0_el1
| Rid_aa64afr1_el1
| Rid_aa64dfr0_el1
| Rid_aa64dfr1_el1
| Rid_aa64mmfr0_el1
| Rid_aa64mmfr1_el1
| Rid_aa64mmfr2_el1
| Rid_aa64pfr0_el1
| Rid_aa64pfr1_el1
| Rid_aa64zfr0_el1
| Rid_aa64isar0_el1
| Rid_aa64isar1_el1
| Rpmintenclr_el1
| Rpmintenset_el1
| Rafsr0_el12
| Rafsr1_el12
| Ramair_el12
| Rcntkctl_el12
| Rcontextidr_el12
| Rcpacr_el12
| Relr_el12
| Resr_el12
| Rfar_el12
| Rmair_el12
| Rmdcr_el2
| Rsctlr_el12
| Rspsr_el12
| Rtcr_el12
| Rttbr0_el12
| Rttbr1_el12
| Rvbar_el12
| Rcnthctl_el2
| Rcntvoff_el2
| Rcntpoff_el2
| Rvmpidr_el2
| Rvttbr_el2
| Rvtcr_el2
| Rhcr_el2
| Ractlr_el2
| Rafsr0_el2
| Rafsr1_el2
| Ramair_el2
| Rcptr_el2
| Relr_el2
| Resr_el2
| Rfar_el2
| Rhacr_el2
| Rhpfar_el2
| Rhstr_el2
| Rmair_el2
| Rmpam_el2
| Rmpamhcr_el2
| Rpmscr_el2
| Rsctlr_el2
| Rscxtnum_el2
| Rsp_el2
| Rspsr_el2
| Rtcr_el2
| Rtfsr_el2
| Rtpidr_el2
| Rtrfcr_el2
| Rttbr0_el2
| Rttbr1_el2
| Rvbar_el2
| Rvdisr_el2
| Rvncr_el2
| Rvpidr_el2
| Rvsesr_el2
| Rvstcr_el2
| Rvsttbr_el2
| Rzcr_el2
| Ricc_sre_el2
| Rich_hcr_el2
| Rich_lr0_el2
| Rich_lr1_el2
| Rich_lr2_el2
| Rich_lr3_el2
| Rich_lr4_el2
| Rich_lr5_el2
| Rich_lr6_el2
| Rich_lr7_el2
| Rich_lr8_el2
| Rich_lr9_el2
| Rich_lr10_el2
| Rich_lr11_el2
| Rich_lr12_el2
| Rich_lr13_el2
| Rich_lr14_el2
| Rich_lr15_el2
| Rich_misr_el2
| Rich_vmcr_el2
| Rich_vtr_el2
| Rich_ap0r0_el2
| Rich_ap0r1_el2
| Rich_ap0r2_el2
| Rich_ap0r3_el2
| Rich_ap1r0_el2
| Rich_ap1r1_el2
| Rich_ap1r2_el2
| Rich_ap1r3_el2
| Rspsr_el3
| Relr_el3
| Resr_el3
| Rscr_el3
| Rtpidr_el3.

Inductive iregsp : Type :=
| Rgp (r: gpreg) | Rsp.

Inductive regset : Type :=
| Rgpsp (r: iregsp) | Rsys (r: sysreg).

Coercion Rgp: gpreg >-> iregsp.
Coercion Rgpsp: iregsp >-> regset.
Coercion Rsys: sysreg >-> regset.

Lemma regsize_eq: forall (x y: regsize), {x=y} + {x<>y}.
Proof.
  decide equality.
Defined.

Lemma ireg_eq: forall (x y: gpreg), {x=y} + {x<>y}.
Proof.
  decide equality; apply regsize_eq.
Defined.

Inductive flag: Type :=
| Fn | Fz | Fc | Fv.

(* Instructions *)

Inductive asmcond : Type :=
| ACeq: asmcond    (** equal *)
| ACne: asmcond    (** not equal *)
| ACcs: asmcond    (** unsigned higher or same *)
| ACcc: asmcond    (** unsigned lower *)
| ACmi: asmcond    (** negative *)
| ACpl: asmcond    (** positive *)
| ACvs: asmcond    (** overflow *)
| ACvc: asmcond    (** no overflow *)
| AChi: asmcond    (** unsigned higher *)
| ACls: asmcond    (** unsigned lower or same *)
| ACge: asmcond    (** signed greater or equal *)
| AClt: asmcond    (** signed less than *)
| ACgt: asmcond    (** signed greater *)
| ACle: asmcond    (** signed less than or equal *)
| ACundef: asmcond. (** no cond *)

(* Multiplex extend for both extend and shift *)
Inductive extend : Type :=
| SXTB (amount: Z)
| SXTH (amount: Z)
| SXTW (amount: Z)
| SXTX (amount: Z)
| UXTB (amount: Z)
| UXTH (amount: Z)
| UXTW (amount: Z)
| UXTX (amount: Z)
| LSL (amount: Z)
| LSR (amount: Z)
| ASR (amount: Z).

Inductive dsb_typ : Type :=
| DSB_SY
| DSB_ST
| DSB_ISH
| DSB_ISHST
| DSB_NSH
| DSB_NSHST
| DSB_OSH
| DSB_OSHST.

Inductive index_typ : Type :=
| PreIndex
| PostIndex
| SignedIndex
| DirectIndex.

Inductive op : Type :=
| RegOp (r: regset)
| MemOp (reg: regset) (imm: Z) (idx_typ: index_typ)
| Lit (i: Z).

Coercion RegOp: regset >-> op.
Coercion Lit: Z >-> op.

Inductive op_with_ext : Type :=
| OpWithoutExt (op: op)
| EXT (op: op) (ext: extend).

Coercion OpWithoutExt : op >-> op_with_ext.

Definition symbol : Type := string * Z.


(* Instructions we parsed so far
let insn =
    "add" | "adr" | "adrp" | "br" | "bfxil" | "cbnz" | "cbz" | "ccmp" | "clz" |
    "cmp" | "dsb" | "eor" | "ret" | "eret" | "isb" | "ldp" | "ldr" | "lsr" | "mov"  |
    "mrs" | "msr" | "nop" | "sb" | "smc" | "stp" | "str" | "sub" | "tst"
let lblinsn = "b.cs" | "b.eq" | "b.ne" | "bl" | "b"
 *)

(* Alphabetical order *)
Inductive asm_instruction : Type :=
| Iadd (dst: op) (src1: op) (src2: op_with_ext)
| Iadr (dst: gpreg) (sym: symbol)
| Iadrp (dst: gpreg) (sym: symbol)
(* | Ibfm (dst: op) (src: op) (imm1: Z) (imm2: Z) *)
(* | Ibfxil (reg1: gpreg) (reg2: gpreg) (imm1: Z) (imm2: Z) *)
| Ibl (sym: symbol)
| Ibr (reg: gpreg)
| Ibc (cond: asmcond) (sym: symbol)
| Icbnz (reg: gpreg) (sym: symbol)
| Icbz (reg: gpreg) (sym: symbol)
| Iccmp (cond: asmcond) (dst: gpreg) (src: op) (nzcv: Z)
| Icmp (reg1: iregsp) (op2: op_with_ext)
| Iclz (Rd: gpreg) (Rm: gpreg)
| Idsb (* ignore params for now *)
| Iand (reg1: iregsp) (reg2: gpreg) (op3: op_with_ext)
| Ieor (reg1: iregsp) (reg2: gpreg) (op3: op_with_ext)
| Iret
| Ieret
| Iisb
| Ildp (reg1: gpreg) (reg2: gpreg) (mem: op)
| Ildar (reg1: gpreg) (op2: option op_with_ext) (sym: option symbol)
| Ildr (reg1: gpreg) (op2: option op_with_ext) (sym: option symbol)
| Ildrb (reg1: gpreg) (op2: option op_with_ext) (sym: option symbol)
| Ilsr (reg1: gpreg) (reg2: gpreg) (op3: op)
| Imov (reg1: iregsp) (op2: op)
| Imrs (reg: gpreg) (sys: sysreg)
| Imsr (sys: sysreg) (op: op)
| Inop
| Isb
| Iwfe
| Itlbi (* ignore params for now *)
| Iat   (* ignore params for now *)
| Ismc (imm: Z)
| Istp (reg1: gpreg) (reg2: gpreg) (mem: op)
| Istr (reg1: gpreg) (mem: op)
| Istrb (reg1: gpreg) (mem: op)
| Istlr (reg1: gpreg) (mem: op)
| Istclrl (reg1: gpreg) (mem: op)
| Ildsetal (reg1: gpreg) (reg2: gpreg) (mem: op)
| Istadd (reg1: gpreg) (mem: op)
| Ildadd (reg1: gpreg) (reg2: gpreg) (mem: op)
| Ildaddl (reg1: gpreg) (reg2: gpreg) (mem: op)
| Isub (reg1: iregsp) (reg2: iregsp) (op3: op_with_ext)
| Itst (reg1: gpreg) (op2: op_with_ext).

Record procedure : Type :=
  mkProc {
      ploc: Z;
      pname: string;
      pbody: list asm_instruction;
    }.

