Require Import Coqlib.
Require Import SMap.
Require Import Notations.
Require Import AsmInsn.
Require Import LayerSem.IRSem.
Require Import LayerSem.IR.

Section Semantics.

  Context (L: Layer).
  Context (md: module).
  Context `{IntPtrCast}.

  Notation gvars := md.(global_vars).
  Notation funcs := md.(functions).
  Notation procs := md.(asm_procedures).
  Notation state := L.(State).
  Notation init := L.(Init).
  Notation get_flag := L.(GetFlag).
  Notation set_flag := L.(SetFlag).
  Notation get_reg := L.(GetReg).
  Notation set_reg := L.(SetReg).
  Notation load := L.(Load).
  Notation store := L.(Store).

  Definition next_instr (pc: Ptr) := ptr_offset pc 4.

  Definition find_instr (pc: Ptr) : option asm_instruction :=
    when proc == gets (pc.(pbase)) procs;
    let insts := proc.(pbody) in
    nth_error insts (Z.to_nat (Z.div pc.(poffset) 4)).

  Notation u64_carry v := (v >? 18446744073709551615).

  Definition Z64_lsl (v: Z) (n: Z) : Z := Zmod (Z.shiftl v n) (Z.pow 2 64).

  Definition signed (v: Z) : Z :=
    if zlt v (Z.pow 2 63) then v else v - (Z.pow 2 64).

  Definition add_with_carry (x: Z) (y: Z) (carry_in: Z) : (Z * (bool * bool * bool * bool)) :=
    let sum := x + y + carry_in in
    let ssum := (signed x) + (signed y) + carry_in in
    let res := Zmod sum (Z.pow 2 64) in
    let n := Z.testbit res 63 in
    let z := res =? 0 in
    let c := negb (res =? sum) in
    let v := negb ((signed res) =? ssum) in
    (res, (n, z, c, v)).

  Definition set_flags flags st : option state :=
    match flags with
      (n, z, c, v) =>
        when st1 == (set_flag Fn n st);
        when st2 == (set_flag Fz z st1);
        when st3 == (set_flag Fc c st2);
        when st4 == (set_flag Fv v st3);
        Some st4
    end.

  Definition exec_bfm (reg1: gpreg) (reg2: gpreg) imms immr st : option state :=
    rely (imms <= 63) /\ (imms >= 0);
    rely (immr <= 63) /\ (immr >= 0);
    when dst == get_reg reg1 st;
    when src == get_reg reg2 st;
    if imms >=? immr then
      let wmask := ((Z.shiftl 1 (imms - immr + 1)) - 1) in
      let bot := Z.lor (Z.land dst (Z.lnot wmask)) (Z.land (Z.shiftr src immr) wmask) in
      set_reg reg1 bot st
    else
      let wmask := ((Z.shiftl 1 (imms + 1)) - 1) in
      let res := Z.lor (Z.land dst (Z.lnot (Z.shiftl wmask (64 - immr)))) (Z.shiftl (Z.land src wmask) (64 - immr)) in
      set_reg reg1 res st.

  Definition cond_hold (cond: asmcond) (st: state): bool :=
    match cond with
      ACeq => get_flag Fz st
    | ACne => negb (get_flag Fz st)
    | ACcs => get_flag Fc st
    | ACcc => negb (get_flag Fc st)
    | ACmi => get_flag Fn st
    | ACpl => negb (get_flag Fn st)
    | ACvs => get_flag Fv st
    | ACvc => negb (get_flag Fv st)
    | AChi => (get_flag Fc st) && (negb (get_flag Fz st))
    | ACls => negb ((get_flag Fc st) && (get_flag Fz st))
    | ACge => eqb (get_flag Fn st) (get_flag Fv st)
    | AClt => eqb (negb (get_flag Fn st)) (get_flag Fv st)
    | ACgt => (negb (get_flag Fz st)) && (eqb (get_flag Fn st) (get_flag Fv st))
    | ACle => negb ((negb (get_flag Fz st)) && (eqb (get_flag Fn st) (get_flag Fv st)))
    | _ => true
    end.

  Definition eval_op (src: op) (st: state) : option (Z * state) :=
    match src with
    | RegOp r => when v == get_reg r st; Some (v, st)
    | Lit i => Some (i, st)
    | MemOp r imm idx => None
    end.

  Definition bytes_of_regsize (sz: regsize) : Z :=
    match sz with
    | SZ32 => 4
    | SZ64 => 8
    end.

  Definition load_mem_op (src: op_with_ext) (sz: Z) (n: Z) (st: state) : option (list Z * state) :=
    match src with
		| MemOp reg imm idx =>
		when addr == get_reg reg st;
		match idx with
		| PreIndex =>
			when v, st' == load sz (int_to_ptr (addr + imm)) st;
			if n =? 1 then Some (v :: nil, st')
			else if n =? 2 then
			when v2, st'' == load sz (int_to_ptr (addr + imm + sz)) st';
			Some (v :: v2 :: nil, st'')
			else None
		| PostIndex =>
			when st == set_reg reg (addr + imm) st;
			when v, st' == load sz (int_to_ptr addr) st;
			if n =? 1 then Some (v :: nil, st')
			else if n =? 2 then
			when v2, st'' == load sz (int_to_ptr (addr + imm + sz)) st';
			Some (v :: v2 :: nil, st'')
			else None
		| _ => None
		end
		| _ => None
	end.

  Definition store_mem_op (dst: op) (sz: Z) (vals: list Z) (st: state) : option state :=
    match dst with
		| MemOp reg imm idx =>
		when addr == get_reg reg st;
		match idx with
		| PreIndex =>
			match vals with
			| v :: nil =>
			when st' == store sz (int_to_ptr (addr + imm)) v st;
			Some st'
			| v :: v2 :: nil =>
			when st' == store sz (int_to_ptr (addr + imm)) v st;
			when st'' == store sz (int_to_ptr (addr + imm + sz)) v2 st';
			Some st''
			| _ => None
			end
		| PostIndex =>
			when st == set_reg reg (addr + imm) st;
			match vals with
			| v :: nil =>
			when st' == store sz (int_to_ptr addr) v st;
			Some st'
			| v :: v2 :: nil =>
			when st' == store sz (int_to_ptr addr) v st;
			when st'' == store sz (int_to_ptr (addr + sz)) v2 st';
			Some st''
			| _ => None
			end
		| _ => None
		end
		| _ => None
	end.


  Definition eval_op_with_extend (src: op_with_ext) (st: state) : option (Z * state) :=
    match src with
    | OpWithoutExt op => eval_op op st
    | EXT op ext =>
      match eval_op op st, ext with
      | Some (i, st), (SXTB n) => Some (i, st)
      | Some (i, st), (SXTH n) => Some (i, st)
      | Some (i, st), (SXTW n) => Some (i, st)
      | Some (i, st), (SXTX n) => Some (i, st)
      | Some (i, st), (UXTB n) => Some (i, st)
      | Some (i, st), (UXTH n) => Some (i, st)
      | Some (i, st), (UXTW n) => Some (i, st)
      | Some (i, st), (UXTX n) => Some (i, st)
      | Some (i, st), (LSL n) => Some (Z.shiftl i n, st)
      | Some (i, st), (LSR n) => Some (Z.shiftr i n, st)
      | Some (i, st), (ASR n) => Some (Z.shiftr i n, st)
      | _, _ => None
      end
    end.

  Definition sizeof_gpreg (reg: gpreg) :=
    match reg with
    | Rx0 sz | Rx1 sz | Rx2 sz | Rx3 sz
    | Rx4 sz | Rx5 sz | Rx6 sz | Rx7 sz
    | Rx8 sz | Rx9 sz | Rx10 sz | Rx11 sz
    | Rx12 sz | Rx13 sz | Rx14 sz
    | Rx15 sz | Rx16 sz | Rx17 sz
    | Rx18 sz | Rx19 sz | Rx20 sz
    | Rx21 sz | Rx22 sz | Rx23 sz
    | Rx24 sz | Rx25 sz | Rx26 sz
    | Rx27 sz | Rx28 sz | Rx29 sz
    | Rx30 sz 
    | Rw0 sz | Rw1 sz | Rw2 sz | Rw3 sz
    | Rw4 sz | Rw5 sz | Rw6 sz | Rw7 sz
    | Rw8 sz | Rw9 sz | Rw10 sz | Rw11 sz
    | Rw12 sz | Rw13 sz | Rw14 sz
    | Rw15 sz | Rw16 sz | Rw17 sz
    | Rw18 sz | Rw19 sz | Rw20 sz
    | Rw21 sz | Rw22 sz | Rw23 sz
    | Rw24 sz | Rw25 sz | Rw26 sz
    | Rw27 sz | Rw28 sz | Rw29 sz
    | Rw30 sz => sz
    | Rxzr => SZ64
    | Rwzr => SZ32
    end.

  Definition exec_insn (insn: asm_instruction) (pc: Ptr) (st: state) : option (Ptr * state) :=
    match insn with
    | Iadd (RegOp dst) src1 src2 =>
      when i, st == eval_op src1 st;
      when j, st == eval_op_with_extend src2 st;
      let (res, _) := add_with_carry i j 0 in
      when st' == set_reg dst res st;
      Some (next_instr pc, st)
    | Iadr reg (sym, _) =>
      when st' == set_reg reg (ptr_to_int (mkPtr sym 0)) st;
      Some (next_instr pc, st')
    | Iadrp reg (sym, _) =>
      when st' == set_reg reg ((ptr_to_int (mkPtr sym 0)) mod 4096) st;
      Some (next_instr pc, st')
    | Ibr reg =>  
      when adr == get_reg reg st;
      Some (int_to_ptr adr, st)
    | Ibc cond (sym, offs) => 
      if cond_hold cond st then Some (mkPtr sym offs, st)
      else Some (next_instr pc, st)
    | Icbnz reg (sym, offs) => 
      when v == get_reg reg st;
      if v =? 0 then Some (next_instr pc, st)
      else Some (mkPtr sym offs, st)
    | Icbz reg (sym, offs) => 
      when v == get_reg reg st;
      if v =? 0 then Some (mkPtr sym offs, st)
      else Some (next_instr pc, st)
    | Icmp reg1 op2 =>
      when i == get_reg reg1 st;
      when j, st == eval_op_with_extend op2 st;
      let (_, nzcv) := add_with_carry i ((Z.pow 2 64) - j) 0 in
      when st' == set_flags nzcv st;
      Some (next_instr pc, st')
    | Iccmp cond reg1 op2 nzcv =>
      if cond_hold cond st then
        when i == get_reg reg1 st;
        when j, st == eval_op op2 st;
        let (_, nzcv) := add_with_carry i ((Z.pow 2 64) - j) 0 in
        when st' == set_flags nzcv st;
        Some (next_instr pc, st')
      else
        let n := Z.testbit nzcv 0 in
        let z := Z.testbit nzcv 1 in
        let c := Z.testbit nzcv 2 in
        let v := Z.testbit nzcv 4 in
        when st' == set_flags (n, z, c, v) st;
        Some (next_instr pc, st')
    | Iclz Rd Rm =>
      when v == get_reg Rm st;
      let n_zeros := (if v =? 0 then 64 else 63 - (Z.log2 v)) in
      when st' == set_reg Rd n_zeros st;
      Some (next_instr pc, st')
    | Ieor Rd Rn op2 =>
      when v1 == get_reg Rn st;
      when v2, st == eval_op_with_extend op2 st;
      when st' == set_reg Rd (Z.lxor v1 v2) st;
      Some (next_instr pc, st')
    | Ildp dst1 dst2 memop =>
      match sizeof_gpreg dst1, sizeof_gpreg dst2 with
      | SZ32, SZ32 =>
        match load_mem_op memop 4 2 st with
        | Some (v1 :: v2 :: nil, st) =>
          when st' == set_reg dst1 v1 st;
          when st'' == set_reg dst2 v2 st';
          Some (next_instr pc, st'')
        | _ => None
        end
      | SZ64, SZ64 =>
        match load_mem_op memop 8 2 st with
        | Some (v1 :: v2 :: nil, st) =>
          when st' == set_reg dst1 v1 st;
          when st'' == set_reg dst2 v2 st';
          Some (next_instr pc, st'')
        | _ => None
        end
      | _, _ => None
      end
    | Ildr dst op sym =>
      let sz := (match sizeof_gpreg dst with SZ32 => 4 | SZ64 => 8 end) in
      match sym, op with
      | Some (base, offs), None =>
        when v, st == load sz (mkPtr base offs) st;
        when st' == set_reg dst v st;
        Some (next_instr pc, st')
      | None, Some (MemOp r n i) =>
        match load_mem_op (MemOp r n i) sz 1 st with
        | Some (v :: nil, st) =>
          when st' == set_reg dst v st;
          Some (next_instr pc, st')
        | _ => None
        end
      | None, Some op =>
        when addr, st == eval_op_with_extend op st;
        when v, st == load sz (int_to_ptr addr) st;
        when st' == set_reg dst v st;
        Some (next_instr pc, st')
	  | _, _ => None
      end
    | Imov reg1 op2 =>
      when v, st == eval_op op2 st;
      when st' == set_reg reg1 v st;
      Some (next_instr pc, st')
    | Imrs reg sys =>
      when v == get_reg sys st;
      when st' == set_reg reg v st;
      Some (next_instr pc, st')
    | Imsr sys op =>
      when v, st == eval_op op st;
      when st' == set_reg sys v st;
      Some (next_instr pc, st')
    | Istp src1 src2 memop =>
      when v1 == get_reg src1 st;
      when v2 == get_reg src2 st;
      match sizeof_gpreg src1, sizeof_gpreg src2 with
      | SZ32, SZ32 =>
        when st' == store_mem_op memop 4 (v1 :: v2 :: nil) st;
        Some (next_instr pc, st')
      | SZ64, SZ64 =>
        when st' == store_mem_op memop 8 (v1 :: v2 :: nil) st;
        Some (next_instr pc, st')
      | _, _ => None
      end
    | Iret =>
      when ret_pc == get_reg (Rx30 SZ64) st;
      Some (int_to_ptr ret_pc, st)
    | _ => None
    end.

  (* | Ibfm reg1 reg2 imms immr => next_instr2 pc (exec_bfm reg1 reg2 imms immr st) *)
  (* | Ibfxil reg1 reg2 lsb width => next_instr2 pc (exec_bfm reg1 reg2 lsb (lsb + width - 1) st) *)
  (* | Ilsr reg1 reg2 op3 =>
      when vreg2 == Z_of_reg reg2 st;
      let operand2 := Zmod vreg2 (Z.pow 64 2) in
      match op3 with
        Lit imm =>
          let res := Zmod (Z.shiftl operand2 imm) (Z.pow 64 2) in
          next_instr2 pc (set_reg reg1 (VInt res) st)
      | GPReg r =>
          when vreg3 == Z_of_reg r st;
          let res := Zmod (Z.shiftl operand2 (Zmod vreg3 (Z.pow 64 2))) (Z.pow 64 2) in
          next_instr2 pc (set_reg reg1 (VInt res) st)
      | _ => None
      end *)

  Inductive exec_step: (state * Ptr) -> (state * Ptr) -> Prop :=
  | exec_one_step :
    forall st pc st' pc' insn (Hinstr: find_instr pc = Some insn)
           (Hexec: exec_insn insn pc st = Some (pc', st')),
        exec_step (st, pc) (st', pc').

  Inductive exec_step_star: (state * Ptr) -> (state * Ptr) -> Prop :=
  | exec_stop : forall p, exec_step_star p p
  | exec_trans :
    forall p p' p'',
      exec_step p p' ->
      exec_step_star p' p'' ->
      exec_step_star p p''.

Inductive exec_proc (name: string) (st: state) (st': state) : Prop :=
| exec_proc_intro :
  forall pc'
    (Hexec: exec_step_star (st, mkPtr name 0) (st', pc'))
    (Hret_pc: get_reg (Rx30 SZ64) st = Some (ptr_to_int pc')),
    exec_proc name st st'.

End Semantics.


Definition l1_sync :=
  (Imrs (Rx0 SZ64) Resr_el2)
    ::(Ilsr (Rx0 SZ64) (Rx0 SZ64) 38)
    ::(Icmp (Rx0 SZ64) 22)
    ::(Iccmp ACne (Rx0 SZ64) 18 4)
    ::(Ibc ACeq ("el1_sync"%string,192))
    ::(Icmp (Rx0 SZ64) 36)
    ::(Ibc ACeq ("el1_sync"%string,36))
    ::(Icmp (Rx0 SZ64) 32)
    ::(Ibc ACne ("el1_trap"%string,0))
    ::(Imrs (Rx1 SZ64) Rtpidr_el2)
    ::(Icbnz (Rx1 SZ64) ("el1_trap"%string,0))
    ::(Ildp (Rx0 SZ64) (Rx1 SZ64) (MemOp (Rsp) (22) PostIndex))
    ::(Istp (Rx30 SZ64) (Rxzr) (MemOp (Rsp) (-16) PreIndex))
    ::(Istp (Rx28 SZ64) (Rx29 SZ64) (MemOp (Rsp) (-16) PreIndex))
    ::(Istp (Rx26 SZ64) (Rx27 SZ64) (MemOp (Rsp) (-16) PreIndex))
    ::(Istp (Rx24 SZ64) (Rx25 SZ64) (MemOp (Rsp) (-16) PreIndex))
    ::(Istp (Rx22 SZ64) (Rx23 SZ64) (MemOp (Rsp) (-16) PreIndex))
    ::(Istp (Rx20 SZ64) (Rx21 SZ64) (MemOp (Rsp) (-16) PreIndex))
    ::(Istp (Rx18 SZ64) (Rx19 SZ64) (MemOp (Rsp) (-16) PreIndex))
    ::(Istp (Rx16 SZ64) (Rx17 SZ64) (MemOp (Rsp) (-16) PreIndex))
    ::(Istp (Rx14 SZ64) (Rx15 SZ64) (MemOp (Rsp) (-16) PreIndex))
    ::(Istp (Rx12 SZ64) (Rx13 SZ64) (MemOp (Rsp) (-16) PreIndex))
    ::(Istp (Rx10 SZ64) (Rx11 SZ64) (MemOp (Rsp) (-16) PreIndex))
    ::(Istp (Rx8 SZ64) (Rx9 SZ64) (MemOp (Rsp) (-16) PreIndex))
    ::(Istp (Rx6 SZ64) (Rx7 SZ64) (MemOp (Rsp) (-16) PreIndex))
    ::(Istp (Rx4 SZ64) (Rx5 SZ64) (MemOp (Rsp) (-16) PreIndex))
    ::(Istp (Rx2 SZ64) (Rx3 SZ64) (MemOp (Rsp) (-16) PreIndex))
    ::(Istp (Rx0 SZ64) (Rx1 SZ64) (MemOp (Rsp) (-16) PreIndex))
    ::(Imov (Rx1 SZ64) (Rsp))
    ::(Imov (Rx0 SZ64) (Rx30 SZ64))
    ::(Ibl ("handle_host_stage2_fault"%string,0))
    ::(Ildp (Rx0 SZ64) (Rx1 SZ64) (MemOp (Rsp) (22) PostIndex))
    ::(Ildp (Rx2 SZ64) (Rx3 SZ64) (MemOp (Rsp) (22) PostIndex))
    ::(Ildp (Rx4 SZ64) (Rx5 SZ64) (MemOp (Rsp) (22) PostIndex))
    ::(Ildp (Rx6 SZ64) (Rx7 SZ64) (MemOp (Rsp) (22) PostIndex))
    ::(Ildp (Rx8 SZ64) (Rx9 SZ64) (MemOp (Rsp) (22) PostIndex))
    ::(Ildp (Rx10 SZ64) (Rx11 SZ64) (MemOp (Rsp) (22) PostIndex))
    ::(Ildp (Rx12 SZ64) (Rx13 SZ64) (MemOp (Rsp) (22) PostIndex))
    ::(Ildp (Rx14 SZ64) (Rx15 SZ64) (MemOp (Rsp) (22) PostIndex))
    ::(Ildp (Rx16 SZ64) (Rx17 SZ64) (MemOp (Rsp) (22) PostIndex))
    ::(Ildp (Rx18 SZ64) (Rx19 SZ64) (MemOp (Rsp) (22) PostIndex))
    ::(Ildp (Rx20 SZ64) (Rx21 SZ64) (MemOp (Rsp) (22) PostIndex))
    ::(Ildp (Rx22 SZ64) (Rx23 SZ64) (MemOp (Rsp) (22) PostIndex))
    ::(Ildp (Rx24 SZ64) (Rx25 SZ64) (MemOp (Rsp) (22) PostIndex))
    ::(Ildp (Rx26 SZ64) (Rx27 SZ64) (MemOp (Rsp) (22) PostIndex))
    ::(Ildp (Rx28 SZ64) (Rx29 SZ64) (MemOp (Rsp) (22) PostIndex))
    ::(Ildp (Rx30 SZ64) (Rxzr) (MemOp (Rsp) (22) PostIndex))
    ::(Ieret)
    ::(Ildp (Rx0 SZ64) (Rx1 SZ64) (MemOp (Rsp) (22) PostIndex))
    ::(Icmp (Rx0 SZ64) 5)
    ::(Ibc ACne ("el1_sync"%string,220))
    ::(Imrs (Rx0 SZ64) Rvbar_el2)
    ::(Ieret)
    ::(Icmp (Rx0 SZ64) 3)
    ::(Ibc ACcs ("el1_sync"%string,248))
    ::(Ildr (Rx5 SZ64) None (Some ("el1_fiq_invalid"%string,8)))
    ::(Iadrp (Rx6 SZ64) ("kimage_voffset"%string,0))
    ::(Ildr (Rx6 SZ64) (Some (OpWithoutExt ((MemOp (Rx6 SZ64) (0) DirectIndex)))) None)
    ::(Isub (Rx5 SZ64) (Rx5 SZ64) (Rx6 SZ64))
    ::(Ibr (Rx5 SZ64))
    ::(Istp (Rx30 SZ64) (Rxzr) (MemOp (Rsp) (-16) PreIndex))
    ::(Istp (Rx28 SZ64) (Rx29 SZ64) (MemOp (Rsp) (-16) PreIndex))
    ::(Istp (Rx26 SZ64) (Rx27 SZ64) (MemOp (Rsp) (-16) PreIndex))
    ::(Istp (Rx24 SZ64) (Rx25 SZ64) (MemOp (Rsp) (-16) PreIndex))
    ::(Istp (Rx22 SZ64) (Rx23 SZ64) (MemOp (Rsp) (-16) PreIndex))
    ::(Istp (Rx20 SZ64) (Rx21 SZ64) (MemOp (Rsp) (-16) PreIndex))
    ::(Istp (Rx18 SZ64) (Rx19 SZ64) (MemOp (Rsp) (-16) PreIndex))
    ::(Istp (Rx16 SZ64) (Rx17 SZ64) (MemOp (Rsp) (-16) PreIndex))
    ::(Istp (Rx14 SZ64) (Rx15 SZ64) (MemOp (Rsp) (-16) PreIndex))
    ::(Istp (Rx12 SZ64) (Rx13 SZ64) (MemOp (Rsp) (-16) PreIndex))
    ::(Istp (Rx10 SZ64) (Rx11 SZ64) (MemOp (Rsp) (-16) PreIndex))
    ::(Istp (Rx8 SZ64) (Rx9 SZ64) (MemOp (Rsp) (-16) PreIndex))
    ::(Istp (Rx6 SZ64) (Rx7 SZ64) (MemOp (Rsp) (-16) PreIndex))
    ::(Istp (Rx4 SZ64) (Rx5 SZ64) (MemOp (Rsp) (-16) PreIndex))
    ::(Istp (Rx2 SZ64) (Rx3 SZ64) (MemOp (Rsp) (-16) PreIndex))
    ::(Istp (Rx0 SZ64) (Rx1 SZ64) (MemOp (Rsp) (-16) PreIndex))
    ::(Imov (Rx0 SZ64) (Rsp))
    ::(Ibl ("handle_host_hvc"%string,0))
    ::(Ildp (Rx0 SZ64) (Rx1 SZ64) (MemOp (Rsp) (22) PostIndex))
    ::(Ildp (Rx2 SZ64) (Rx3 SZ64) (MemOp (Rsp) (22) PostIndex))
    ::(Ildp (Rx4 SZ64) (Rx5 SZ64) (MemOp (Rsp) (22) PostIndex))
    ::(Ildp (Rx6 SZ64) (Rx7 SZ64) (MemOp (Rsp) (22) PostIndex))
    ::(Ildp (Rx8 SZ64) (Rx9 SZ64) (MemOp (Rsp) (22) PostIndex))
    ::(Ildp (Rx10 SZ64) (Rx11 SZ64) (MemOp (Rsp) (22) PostIndex))
    ::(Ildp (Rx12 SZ64) (Rx13 SZ64) (MemOp (Rsp) (22) PostIndex))
    ::(Ildp (Rx14 SZ64) (Rx15 SZ64) (MemOp (Rsp) (22) PostIndex))
    ::(Ildp (Rx16 SZ64) (Rx17 SZ64) (MemOp (Rsp) (22) PostIndex))
    ::(Ildp (Rx18 SZ64) (Rx19 SZ64) (MemOp (Rsp) (22) PostIndex))
    ::(Ildp (Rx20 SZ64) (Rx21 SZ64) (MemOp (Rsp) (22) PostIndex))
    ::(Ildp (Rx22 SZ64) (Rx23 SZ64) (MemOp (Rsp) (22) PostIndex))
    ::(Ildp (Rx24 SZ64) (Rx25 SZ64) (MemOp (Rsp) (22) PostIndex))
    ::(Ildp (Rx26 SZ64) (Rx27 SZ64) (MemOp (Rsp) (22) PostIndex))
    ::(Ildp (Rx28 SZ64) (Rx29 SZ64) (MemOp (Rsp) (22) PostIndex))
    ::(Ildp (Rx30 SZ64) (Rxzr) (MemOp (Rsp) (22) PostIndex))
    ::(Ieret)
    ::nil.