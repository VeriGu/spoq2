import json
from typing import Any, Optional
import matplotlib.pyplot as plt
import queue
import sys
import numpy as np
import copy
import logging
import os
import argparse

parser = argparse.ArgumentParser(description="Generate layer")
parser.add_argument("ir", type=str, help="The IR (Json) file path.")
parser.add_argument("predefined", type=str, help="The top-bottom layer (Json) file path. "\
                    "It contains a json object {\"top\": [\"func1\"], \"bottom\": [\"func2\", \"func3\"]}")
parser.add_argument("components", nargs="*", type=str, help="Additional file paths")
parser.add_argument("--dump-funcs", action='store_true', required=False, default=False)
args = parser.parse_args()

DEBUG = 1
IR_JSON_PATH = args.ir

with open(args.predefined, "r") as f:
  predefined = json.load(f)
  if "bottom" not in predefined:
    predefined["bottom"] = []
  if "top" not in predefined:
    predefined["top"] = []



def debug(*value):
  if DEBUG:
   print(*value, file=sys.stderr)

class Config:
  def __init__(self):
    self.top = []
    self.bottom = []
    self.name = "default-config"
    self.reachable = None
    self.layer = None
    self.layer_map = None
    self.src_fn = ""
  
  def set_top(self, top):
    self.top = copy.deepcopy(top)

  def set_bottom(self, bottom):
    self.bottom = copy.deepcopy(bottom)

  def dump_config(self, filepath, funcs: Optional[dict[str,Any]]=None):
    with open(filepath, "w+") as f:
      if funcs:
        filtered_funcs = {k: {k2: funcs[k][k2] for k2 in funcs[k] if k2 in ["pres", "sucs", "entry", "fname", "args", "rettype", "is_declaration"]} for k in funcs}
        json.dump({"layer_map": self.layer_map, "funcs": filtered_funcs}, fp = f, indent=4)  
      else:
        json.dump(self.layer_map, fp = f, indent=4)

  def print_layer(self, id, layer):
    layer_name = "Layer" + str(id)
    if(id == 0):
      result = \
      "Section Bottom.\n"\
      "  Definition LAYER_DATA := RData.\n"\
      "  Definition LAYER_NEW_FRAME : string := \"new_frame\"."\
      "  Definition LAYER_CODE : string := \"./rmm-opt.linked.ir2json.json\".\n"\
      "  Definition LAYER_LOAD : string := \"load_RData\".\n"\
      "  Definition LAYER_STORE : string := \"store_RData\".\n"\
      "  Definition LAYER_PRIMS: list string :=\n"
      for f in layer:
        result = result + \
      (f"    \"%s\" ::\n" % f.replace(".", "_"))
      result += \
      "    nil.\n\n"
      # result += \
      # "  Definition ptr_eqb (p1: Ptr) (p2: Ptr) : bool :=\n"\
      # "    (p1.(pbase) =s p2.(pbase)) && (p1.(poffset) =? p2.(poffset)).\n"\
      # "  Definition ptr_lt (p1: Ptr) (p2: Ptr) : bool :=\n"\
      # "    p1.(poffset) <? p2.(poffset).\n"\
      # "  Definition ptr_gt (p1: Ptr) (p2: Ptr) : bool :=\n"\
      # "    p1.(poffset) >? p2.(poffset).\n"
      result += \
      "End Bottom.\n\n"
      return result
    else:
      result = \
      f"Section %s.\n"\
      "  Definition LAYER_DATA := RData.\n"\
      "  Definition LAYER_NEW_FRAME : string := \"new_frame\".\n"\
      "  Definition LAYER_CODE : string := \"./rmm-opt.linked.ir2json.json\".\n"\
      "  Definition LAYER_LOAD : string := \"load_RData\".\n"\
      "  Definition LAYER_STORE : string := \"store_RData\".\n"\
      "  Definition LAYER_ALLOC : string := \"alloc_stack\".\n"\
      "  Definition LAYER_FREE : string := \"free_stack\".\n"\
      "  Definition LAYER_PTR2INT : string := \"ptr_to_int\".\n"\
      "  Definition LAYER_INT2PTR : string := \"int_to_ptr\".\n"\
      "  Definition LAYER_PTR_EQB : string := \"ptr_eqb\".\n"\
      "  Definition LAYER_PTR_GTB : string := \"ptr_gtb\".\n"\
      "  Definition LAYER_PTR_LTB : string := \"ptr_ltb\".\n"\
      "  Definition LAYER_PRIMS: list string :=\n" % ("Layer" + str(id))
      for f in layer:
        result = result + \
      (f"    \"%s\" ::\n" % f.replace(".", "_"))
      result += \
      "    nil.\n\n" 
      result += \
      "End %s.\n\n" % ("Layer" + str(id))
      return result
  
  def dump_config_in_coq(self, filepath, num_layer = 0x7fffffff):
    num = num_layer if len(self.layer) > num_layer else len(self.layer)
    result_header = \
    "Definition PROJ_NAME: string := \"rmm_container_%s_with_%s_layer\".\n"\
    "Definition PROJ_BASE: string := \"./coq/proof_%s_with_%s_layer\".\n\n" % (self.name.replace("-", "_"), str(num), self.name.replace("-", "_"), str(num))
    result = ""
    for i in range(num):
      result += self.print_layer(i, self.layer[i])
    with open(filepath, "w+") as f:
      print(result_header, file = f)
      for c in args.components:
        with open(c, "r") as g:
          content = g.read()
          print(content, file = f)
      print(result, file = f)


class Generator:
  def __init__(self, filter_printf = True):
    self.proj = None

    self.funcs = None
    self.insttype = set()
    self.declarations = []
    self.callee_list = set()

    self.source_nodes = []
    self.sink_nodes = []
    self.external_nodes = []

    # inline_asm_calls: list of (caller, inst)
    self.inline_asm_calls = []
    self.fptr_calls = []
    self.fptr_arguments = []

    self.filter_printf = True

    pass

  PRINT_INTRINSICS = ["printhex_ul", "print_string", "printf", "printf_", "printk", "printhex_ul_dbg", "print_string_dbg", "__debug_save_state", "__debug_restore_state",
  "_out_", "_debug", "_ntoa_"]

  @staticmethod
  def is_llvm_info_intrinsic(fname):
    LLVM_INTRINSICS = ["llvm.dbg", "llvm.lifetime"]
    for l in LLVM_INTRINSICS:
      if fname.startswith(l):
        return True
    return False

  @staticmethod
  def is_external_function(fname):
    EXTERNALS = ["QCBOREncode", "t_cose", "xlat", "attest_" ]
    for l in EXTERNALS:
      if fname.startswith(l):
        return True
    return False

  @staticmethod  
  def is_printf_intrinsic(fname):
    for l in Generator.PRINT_INTRINSICS:
      if fname.startswith(l) or fname.endswith(l):
        return True
    return False
  
  # get_funcs computes self.funcs. 
  # It ignores function calls for debug functions such as llvm.dbg*, llvm.lifetime*
  def compute_funcs(self):
    self.funcs = {}
    for fname in self.proj["functions"]:
      if self.is_llvm_info_intrinsic(fname):
        debug("remove llvm intrinsic", fname)
        continue
      self.funcs[fname] = self.proj["functions"][fname] # TODO: copy.deepcopy
      self.funcs[fname]["pres"] = []
      self.funcs[fname]["sucs"] = []

  # TODO: quick fix function pointer call for a given list. 
  def quick_fix_fptr_call(self, fname):
    # TODO
    return None
    
  def analyze_inst(self, inst, f):
    self.insttype.add(inst["type"])
    if inst["type"] == "CallInst":
      if inst["arguments"][-1]["source"] == "inline_asm":
        self.inline_asm_calls.append((f["fname"], inst)) # TODO: handle inline assembly file
        return
      if inst["arguments"][-1]["source"] != "constant":
        self.fptr_calls.append((f["fname"], inst)) # TODO: handle function pointer calls 
        if (callee := self.quick_fix_fptr_call(f["fname"])) is None:
          return
      else:
        callee = inst["arguments"][-1]["value"]["value"][1:] # remove the '@' callee indicator
      if self.is_llvm_info_intrinsic(callee):
        return
      if callee in f["sucs"]:
        return

      f["sucs"].append(callee)
      if callee not in self.funcs: #TODO: do a thing
        if callee in self.external_nodes:
          pass
        else:
          debug("warning: ", callee , " is called without declaritions")
          return 
      self.funcs[callee]["pres"].append(f["fname"])
      self.callee_list.add(callee)
    
  def analyze_function(self, func):
    for arg_i in range(len(func["args"])):
      arg = func["args"][arg_i]
      if arg["type"]["type"] == "pointer":
        if arg["type"]["subtype"]["type"] == "function":
          self.fptr_arguments.append((func["fname"], arg_i))

  def analyze(self):
    for fname in self.funcs:
      f = self.funcs[fname]
    
      if f["is_declaration"] is True:
        self.declarations.append(f)
        self.external_nodes.append(f["fname"])
        continue

      self.analyze_function(f)
      for bname in f["blocks"]:
        for inst in f["blocks"][bname]:
          self.analyze_inst(inst, f)

    # compute source nodes and sink nodes
    for fname in self.funcs:
      if len(self.funcs[fname]["sucs"]) == 0:
        self.sink_nodes.append(fname)
      if len(self.funcs[fname]["pres"]) == 0:
        self.source_nodes.append(fname)

  def read_json_and_analyze(self, filepath):
    if self.proj is not None:
      print("please use a new genrator.")
      return
    with open(filepath, "r") as f:
      self.proj = json.load(f)
    self.compute_funcs()
    self.analyze()
    # toDO
  
  def check_for_missing_callee(self) -> tuple[bool, list]:  
    fname_list = set(self.proj["functions"].keys())
    callee_list = set()
    if len(callee_list - fname_list) > 0:
      return True, list(callee_list - fname_list)
    return False, []
  
  def get_inst_type(self):
    return self.insttype

  def fix_one_fptr_call(self, caller):
    pass

  def dfs(self, x, l, stamp, cycles):
      # Currently there is no cycle.
      if x in stamp:
        cycles.append(copy.deepcopy(stamp))
        return True
      stamp.append(x)
  
      # end of a path 
      if len(self.funcs[x]["sucs"]) == 0:
        # path_list.append(copy.deepcopy(stamp))
        stamp.pop()
        return False
      
      cycle = False
      for suc in self.funcs[x]["sucs"]:
        cycle = cycle | self.dfs(suc, l + 1, stamp, cycles)
  
      stamp.pop()
      return cycle
   
  def find_cycle(self, source = None) -> tuple[bool, list]:
    source = source if source is not None else self.source_nodes
    cycle = False
    cycles = []
    for fname in source:
      cycle = cycle | self.dfs(fname, 1, [], cycles)
    return cycle, cycles

  def break_cycle(self, cycle) -> tuple[int, str]:
    for i in reversed(range(len(cycle))):
      if len(self.funcs[cycle[i]]["sucs"]) != 0:
        return (len(cycle) - 1 - i), cycle[i]
    return (len(cycle) - 1), cycle[0]
  
  def compute_reachable(self, source, sink): 
    reachable = []
    q = queue.Queue()
    for fname in source:
      q.put(fname)
      reachable.append(fname)

    while not q.empty():
      fname: str = q.get()
      # a function only accessed by Bottom is not needed here.
      # Hack by Raphael, don't ignore renamed functions
      if fname in sink and not fname.endswith(("_vuln", "_patch")):
        continue
      # This should not happen but does in ffm021 for nsv_read_header_patch
      # if fname not in self.funcs:
      #   continue
      for suc in self.funcs[fname]["sucs"]:
        if suc not in reachable:
          q.put(suc)
          reachable.append(suc)
    return reachable

  def get_topological_steps(self, top, bottom, reachable):
    q = []
    topological_steps = []
    pres = {}
    for func in self.funcs:
      if func not in reachable or func in bottom:
        continue
      for suc in self.funcs[func]["sucs"]:
        pres[suc] = pres.get(suc, 0) + 1
  
    for t in top:
      q.append(t)

    # ori_pres = copy.deepcopy(pres)
    while len(q) > 0:
      topological_steps.append(list(q))
      func = q.pop(0)
      # funcs_top_order.append(func)
      if func in bottom:
        continue 
      for suc in self.funcs[func]["sucs"]:
        pres[suc] = pres[suc] - 1
        if pres[suc] == 0:
          q.append(suc)

    if len(bottom) != 0:
      topological_steps.append([])
      for a in bottom:
        topological_steps[-1].append(a)
        # funcs_top_order.append(a)

    return topological_steps# , funcs_top_order
  
  def compute_layers(self, top, bottom, steps):
    x = 0
    layer = []
    layer_map = {}
    # c = 1 if len(config["top"]) > 0 else 0
    c = 1
    while x < len(steps):
      in_layer = False
      for q in steps[x]:
        if q in bottom:
          layer_map[q] = 0 
        elif q in top:
          in_layer = True
          layer_map[q] = -1
        else:
          in_layer = True
          layer_map[q] = -c
      if in_layer:
        c += 1   
      x += len(steps[x])
      
    if len(bottom) == 0:
      c -= 1

    for i in range(c):
      layer.append([])
    
    for t in layer_map.keys():
      if layer_map[t] < 0:
        layer_map[t] = layer_map[t] + c
      layer[layer_map[t]].append(t)
    
    layer_map = dict(sorted(layer_map.items(), key=(lambda item: -item[1])) )
    return layer, layer_map
  

  def dot_underscore_covert(self, f_list: list):
    rv = []
    for b in f_list:
      if b in self.funcs:
        rv.append(b)
        continue
      inserted = False
      for t in self.funcs:
        if b.replace("_", ".") == t.replace("_", "."):
          rv.append(t)
          inserted = True
          break
      if not inserted:
        rv.append(b)  
    return rv
  
  def compute_config(self, top = None, bottom = None, name = "default-config"):
    config = Config()

    _top = top if ((top is not None) and (len(top) != 0)) else self.source_nodes
    _bottom = bottom if bottom is not None else []
    if self.filter_printf:
      _top = list(filter(lambda f : not self.is_printf_intrinsic(f), _top))
      # put printf-like function in the bottom
      _bottom = _bottom + list(filter(lambda f : self.is_printf_intrinsic(f), self.funcs.keys())) 
      # put external function in the bottom
      _bottom = _bottom + list(filter(lambda f : self.is_external_function(f), self.funcs.keys()) )
    _top = self.dot_underscore_covert(_top)
    _bottom = self.dot_underscore_covert(_bottom)
    config.set_top(_top)
    config.set_bottom(_bottom)
    config.reachable = self.compute_reachable(config.top, config.bottom)

    # remove unreachable bottoms.
    reachable_bottom = []
    unreachable_bottom = []
    for f in config.bottom:
      if f in config.reachable:
        reachable_bottom.append(f)
      else:
        unreachable_bottom.append(f)

    debug(config.name, "remove from given unreachable bottom", unreachable_bottom)

    cycle, cycles = self.find_cycle(config.top)
    if cycle:
      for c in cycles:
        _, func = self.break_cycle(c)
        if func not in config.bottom:
          config.bottom.append(func)

    config.reachable = self.compute_reachable(config.top, config.bottom)
    
    steps = self.get_topological_steps(config.top, config.bottom, config.reachable)
    # debug("Steps: ", steps)
    # debug(config.name, "have", len(config.reachable), "reachable functions")

    config.layer, config.layer_map = self.compute_layers(config.top, config.bottom, steps)
    # config.reachable = reachable_bottom

    # debug(config.name, "generate", len(config.layer), "for %d functions generated" % len(config.layer_map), " : ", [len(l) for l in config.layer])

    return config


def run():
  generator = Generator()
  generator.read_json_and_analyze(IR_JSON_PATH)
  config = generator.compute_config(top = predefined["top"], bottom = predefined["bottom"])
  config.dump_config(IR_JSON_PATH.split("/")[-1][:-4] + "gen" + "." + config.name + ".json", funcs=(generator.funcs if args.dump_funcs else None))
  debug(len(generator.inline_asm_calls), " inline asm calls are ignored")
  debug(len(generator.fptr_calls), " function pointer calls are ignored")
  debug(len(generator.fptr_arguments), " functions pointer in arguments")
  debug(len(generator.declarations), " functions with declartions required spec manually", [f["fname"] for f in generator.declarations])
  config.dump_config_in_coq(IR_JSON_PATH.split("/")[-1][:-4] + "gen" + "." + config.name + ".v")
  debug("config(json) dumped into", IR_JSON_PATH.split("/")[-1][:-4] + "gen" + "." + config.name + ".json") 
  debug("config(coq) dumped into", IR_JSON_PATH.split("/")[-1][:-4] + "gen" + "." + config.name + ".v")

  # simple config with only 2 layers
  # num_layer = 2
  # config.dump_config_in_coq(IR_JSON_PATH.split("/")[-1][:-4] + \
                            # f"gen.%s.layer.simple" % str(num_layer) + "." + config.name + ".v", num_layer = num_layer)
  # debug("config(coq) dumped into", IR_JSON_PATH.split("/")[-1][:-4] \
        # + f"gen.%s.layer.simple" % str(num_layer) + "." + config.name + ".v")


if __name__ == "__main__":
  run()