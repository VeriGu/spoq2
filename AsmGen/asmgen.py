import sys
import re
from dataclasses import dataclass
from typing import List, Optional

spregs = set(["sp",])

gpregs = set(["x0", "x1", "x2", "x3", "x4", "x5", "x6", "x7", "x8", "x9", "x10", "x11", "x12", "x13", "x14", "x15", "x16", "x17", "x18", "x19", "x20", "x21", "x22", "x23", "x24", "x25", "x26", "x27", "x28", "x29", "x30", "x30",
        "w0", "w1", "w2", "w3", "w4", "w5", "w6", "w7", "w8", "w9", "w10", "w11", "w12", "w13", "w14", "w15", "w16", "w17", "w18", "w19", "w20", "w21", "w22", "w23", "w24", "w25", "w26", "w27", "w28", "w29", "w30", "w30",
        "xzr"])

# insts = set(["add", "adr", "adrp", "bl", "br", "bc", "cbnz", "cbz", "ccmp", "cmp", "clz", "dsb", "eor",
        #  "ret", "eret", "isb", "ldp", "ldr", "lsr", "move", "mrs", "msr", "nop", "sb", "smc", "stp", "str", "sub", "tst"])

# sysregs = set(["cntp_ctl_el0", "cntp_cval_el0", "cntp_tval_el0", "cntv_ctl_el0", "cntv_cval_el0", "cntv_tval_el0", 
#            "sp_el0", "pmcr_el0", "pmuserenr_el0", "tpidrro_el0", "tpidr_el0", "pmevcntr0_el0",
#            "pmevcntr1_el0", "pmevcntr2_el0", "pmevcntr3_el0", "pmevcntr4_el0", "pmevcntr5_el0", "pmevcntr6_el0", "pmevcntr7_el0", "pmevcntr8_el0", "pmevcntr9_el0", "pmevcntr10_el0", 
#            "pmevcntr11_el0", "pmevcntr12_el0", "pmevcntr13_el0", "pmevcntr14_el0", "pmevcntr15_el0", "pmevcntr16_el0", "pmevcntr17_el0", "pmevcntr18_el0", "pmevcntr19_el0", "pmevcntr20_el0", 
#            "pmevcntr21_el0", "pmevcntr22_el0", "pmevcntr23_el0", "pmevcntr24_el0", "pmevcntr25_el0", "pmevcntr26_el0", "pmevcntr27_el0", "pmevcntr28_el0", "pmevcntr29_el0", "pmevcntr30_el0", 
#            "cntp_ctl_el02", "cntp_cval_el02", "cntv_ctl_el02", "cntv_cval_el02", 
#            "sp_el1", "elr_el1", "spsr_el1", "csselr_el1", "sctlr_el1", "actlr_el1", "cpacr_el1", "zcr_el1", "ttbr0_el1", "ttbr1_el1", "tcr_el1", "esr_el1", "afsr0_el1", "afsr1_el1", "far_el1", 
#            "mair_el1", "vbar_el1", "contextidr_el1", "tpidr_el1", "amair_el1", "cntkctl_el1", "par_el1", "mdscr_el1", "mdccint_el1", "disr_el1", "isr_el1", "midr_el1", "mpam0_el1", "icc_ctlr_el1", 
#            "id_aa64afr0_el1", "id_aa64afr1_el1", "id_aa64dfr0_el1", "id_aa64dfr1_el1", "id_aa64mmfr0_el1", "id_aa64mmfr1_el1", "id_aa64mmfr2_el1", "id_aa64pfr0_el1", "id_aa64pfr1_el1", "id_aa64zfr0_el1", "id_aa64isar0_el1", "id_aa64isar1_el1", 
#            "afsr0_el12", "afsr1_el12", "amair_el12", "cntkctl_el12", "contextidr_el12", "cpacr_el12", "elr_el12", "esr_el12", "far_el12", "mair_el12", 
#            "mdcr_el2", "cnthctl_el2", "cntvoff_el2", "cntpoff_el2", "vmpidr_el2", "vttbr_el2", "vtcr_el2", "hcr_el2", "actlr_el2", "afsr0_el2", "afsr1_el2", "amair_el2", "cptr_el2", 
#            "elr_el2", "esr_el2", "far_el2", "hacr_el2", "hpfar_el2", "hstr_el2", "mair_el2", "mpam_el2", "mpamhcr_el2", "pmscr_el2", "sctlr_el2", "scxtnum_el2", "sp_el2", "spsr_el2", "tcr_el2", 
#            "tfsr_el2", "tpidr_el2", "trfcr_el2", "ttbr0_el2", "ttbr1_el2", "vbar_el2", "vdisr_el2", "vncr_el2", "vpidr_el2", "vsesr_el2", "vstcr_el2", "vsttbr_el2", "zcr_el2", "icc_sre_el2", "ich_hcr_el2", 
#            "ich_lr0_el2", "ich_lr1_el2", "ich_lr2_el2", "ich_lr3_el2", "ich_lr4_el2", "ich_lr5_el2", "ich_lr6_el2", "ich_lr7_el2", "ich_lr8_el2", "ich_lr9_el2", "ich_lr10_el2", "ich_lr11_el2", "ich_lr12_el2", "ich_lr13_el2", 
#            "ich_lr14_el2", "ich_lr15_el2", "ich_misr_el2", "ich_vmcr_el2", "ich_vtr_el2", "ich_ap0r0_el2", "ich_ap0r1_el2", "ich_ap0r2_el2", "ich_ap0r3_el2", "ich_ap1r0_el2", "ich_ap1r1_el2", "ich_ap1r2_el2", "ich_ap1r3_el2", "icc_hppir1_el1", 
#            "spsr_el3", "elr_el3", "esr_el3", "scr_el3"])

@dataclass
class pasm: 
  ploc: int
  pname: str
  pbody: str

def print_pasm(pasm):
  output  = "Definition p_" + pasm.pname + " :=\n{|\n"
  output += "\tploc := " + str(pasm.ploc) + ";\n"
  output += "\tpname := \"" + pasm.pname + "\";\n"
  output += "\tpbody := " + pasm.pbody + ";\n"
  output += "|}.\n"
  print(output)

def parse_config(l):
  match = re.match(r'([0-9a-fA-F]+)\s+<([^>]+)>:', l)
  if match:
      ploc = int(match.group(1), 16)
      pname = match.group(2)
      return ploc, pname

def memop_parse(op):
  if op[0] == '[' and op[-1] == ']':
    op = op[1:-1]
  op = (''.join(op.split())).split(',') # eliminate spaces and split by comma

  if (len(op) == 1):
    return f"(MemOp ({op_parse(op[0])}) (0) DirectIndex)"
  elif (len(op) == 2):
    return f"(MemOp ({op_parse(op[0])}) ({lit_parse(op[1])}) DirectIndex)"

def reg_parse(op):
  if op in gpregs:
    if op[0] == 'x':
      return f"(R{op} SZ64)"
    elif op[0] == 'w':
      return f"(R{op} SZ32)"
  return f"(R{op})"

def lit_parse(op):
  if (op[0] != "#"):
    # print("Literal operand must start with #")
    exit
  return str(int(op[1:], 16))

def op_parse(op):
  if '[' in op and ']' in op:
    return memop_parse(op)
  elif op[0] == '#':
    return lit_parse(op)
  return reg_parse(op)

# insn operands
def mono_insn_parse(insn, ops):
  return f"(I{insn})"
# 


def param_insn_parse(insn, ops):
  op_str = ""
  for op in ops:
    op_str += " " + op_parse(op)
  return f"(I{insn}" + op_str + ")"

def ldr_parse(insn, ops):
  op_str = ""
  op_str += " " + op_parse(ops[0])
  op_str += " (Some (OpWithoutExt (" + op_parse(ops[1]) + "))) None"
  return f"(I{insn}" + op_str + ")"

instruction_handlers = {
    # No operands
    "eret" : mono_insn_parse, 
    "ret": mono_insn_parse,
    "isb": mono_insn_parse,
    "nop": mono_insn_parse,
    "dsb": mono_insn_parse, # ignore parameters for now
    "sb": mono_insn_parse,
    "wfe": mono_insn_parse,
    "at": mono_insn_parse, # ignore parameters for now
    "tlbi": mono_insn_parse, # ignore parameters for now

    "add": param_insn_parse,
    "and": param_insn_parse,
    "sub": param_insn_parse,
    "mov": param_insn_parse,
    
    "msr": param_insn_parse,
    "mrs": param_insn_parse,
    
    "stadd": param_insn_parse,
    "ldadd": param_insn_parse,
    "ldaddl": param_insn_parse,
    
    "str": param_insn_parse,
    "strb": param_insn_parse,
    "stlr": param_insn_parse,
    "stclrl": param_insn_parse,
    "ldsetal": param_insn_parse,
    "ldr": ldr_parse,
    "ldar": ldr_parse,
    "ldrb": ldr_parse,
}

def parse_stmt(line): 
  insn = line.split()[0]
  oprands_str = line[len(insn)+1:]
  operands = split_operands(oprands_str)

  handler = instruction_handlers.get(insn)
  if handler: 
    return handler(insn, operands)
  else:
    # print("Unknown instruction: ", insn)
    exit

def parse_stmts(lines):
  if not lines: 
    return "nil"
  output = parse_stmt(lines[0])
  output += "\n\t\t::" + parse_stmts(lines[1:])
  return output

def parse(): 	
  lines = sys.stdin.readlines()
  if not lines: 
    return
  
  ploc, pname = parse_config(lines[0])
  pbody = parse_stmts(lines[1:])
  asm = pasm(ploc, pname, pbody)
  print_pasm(asm)

def extract_bracketed_part(s: str) -> Optional[str]:
    pattern = r'(\[[^\]]+\])'  # Matches '[' followed by any non-']' characters, then ']'
    match = re.search(pattern, s)
    if match:
        return match.group(1)
    else:
        return None

def split_operands(s: str) -> List[str]:
    bracketed = extract_bracketed_part(s)
    if bracketed:
        temp = s.replace(bracketed, '<<<BRACKETED>>>')
        parts = [part.strip() for part in temp.split(',')]
        operands = []
        for part in parts:
            if part == '<<<BRACKETED>>>':
                operands.append(bracketed)
            else:
                operands.append(part)
        return operands
    else:
        return [part.strip() for part in s.split(',')]

if __name__ == "__main__":
	parse()