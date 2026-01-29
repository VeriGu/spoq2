#!/usr/bin/env python3
"""
Generate layer configuration from LLVM IR (.ll) directly, with the same
functionality as gen-layer.py (which uses JSON from ir2json).

Requires: llvmlite (pip install llvmlite)
"""

import json
import queue
import sys
import copy
import argparse
import os

try:
    from llvmlite import binding as llvm
except ImportError:
    print("gen-layer-llvm.py requires llvmlite. Install with: pip install llvmlite", file=sys.stderr)
    sys.exit(1)

parser = argparse.ArgumentParser(
    description="Generate layer from LLVM IR (.ll) file."
)
parser.add_argument(
    "ir",
    type=str,
    help="The LLVM IR (.ll) file path.",
)
parser.add_argument(
    "predefined",
    type=str,
    help='The top-bottom layer (JSON) file. Object: {"top": ["func1"], "bottom": ["func2", "func3"]}',
)
parser.add_argument(
    "components",
    nargs="*",
    type=str,
    help="Additional file paths to include in Coq output.",
)
args = parser.parse_args()

DEBUG = 1
IR_LL_PATH = args.ir
print(args.ir, file=sys.stderr)
print(args.predefined, file=sys.stderr)

with open(args.predefined, "r") as f:
    predefined = json.load(f)
    if "bottom" not in predefined:
        predefined["bottom"] = []
    if "top" not in predefined:
        predefined["top"] = []


def debug(*value):
    if DEBUG:
        print(*value, file=sys.stderr)


# ---------------------------------------------------------------------------
# LLVM IR parsing via llvmlite (function list + call graph)
# ---------------------------------------------------------------------------


def _llvm_initialize():
    """Initialize LLVM bindings if required (safe to call multiple times)."""
    try:
        llvm.initialize()
    except Exception:
        pass


def parse_llvm_ir(filepath: str):
    """
    Parse .ll file using llvmlite and return:
    funcs: dict fname -> {"fname", "is_declaration", "pres", "sucs"}
    """
    _llvm_initialize()
    with open(filepath, "r") as f:
        ir_text = f.read()

    mod = llvm.parse_assembly(ir_text)

    funcs = {}
    # Register all functions (define + declare)
    for func_ref in mod.functions:
        name = func_ref.name
        if name not in funcs:
            funcs[name] = {
                "fname": name,
                "is_declaration": func_ref.is_declaration,
                "pres": [],
                "sucs": [],
            }

    # For each defined function, collect direct call/invoke callees
    for func_ref in mod.functions:
        if func_ref.is_declaration:
            continue
        fname = func_ref.name
        sucs = funcs[fname]["sucs"]
        for block in func_ref.blocks:
            for inst in block.instructions:
                op = inst.opcode
                if op not in ("call", "invoke"):
                    continue
                # First operand is the callee (function or value for indirect call)
                ops = list(inst.operands)
                if not ops:
                    continue
                callee_ref = ops[0]
                # Direct call: callee operand has a name (e.g. @foo -> name "foo")
                # Indirect call: callee is %reg, name may be empty or a local id
                callee_name = getattr(callee_ref, "name", None) or ""
                if callee_name and not callee_name.startswith("%"):
                    if callee_name not in sucs:
                        sucs.append(callee_name)

    # Fill predecessors from successors
    for fname, f in funcs.items():
        f["pres"] = []
    for fname, f in funcs.items():
        for suc in f["sucs"]:
            if suc in funcs and fname not in funcs[suc]["pres"]:
                funcs[suc]["pres"].append(fname)
    return funcs


# ---------------------------------------------------------------------------
# Config and output (same as JSON version)
# ---------------------------------------------------------------------------

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

    def dump_config(self, filepath):
        with open(filepath, "w+") as f:
            json.dump(self.layer_map, fp=f, indent=4)

    def print_layer(self, id, layer):
        layer_name = "Layer" + str(id)
        if id == 0:
            result = (
                "Section Bottom.\n"
                "  Definition LAYER_DATA := RData.\n"
                "  Definition LAYER_PRIMS: list string :=\n"
            )
            for f in layer:
                result += (f'    "%s" ::\n' % f.replace(".", "_"))
            result += "    nil.\n\n"
            result += "End Bottom.\n\n"
            return result
        else:
            result = (
                f"Section %s.\n"
                "  Definition LAYER_DATA := RData.\n"
                "  Definition LAYER_PRIMS: list string :=\n" % ("Layer" + str(id))
            )
            for f in layer:
                result += (f'    "%s" ::\n' % f.replace(".", "_"))
            result += "    nil.\n\n"
            result += "End %s.\n\n" % ("Layer" + str(id))
            return result

    def dump_config_in_coq(self, filepath, num_layer=0x7FFFFFFF):
        num = num_layer if len(self.layer) > num_layer else len(self.layer)
        result_header = (
            'Definition PROJ_NAME: string := "rmm_container_%s_with_%s_layer".\n'
            'Definition PROJ_BASE: string := "./coq/proof_%s_with_%s_layer".\n\n'
            % (
                self.name.replace("-", "_"),
                str(num),
                self.name.replace("-", "_"),
                str(num),
            )
        )
        result = ""
        for i in range(num):
            result += self.print_layer(i, self.layer[i])
        with open(filepath, "w+") as f:
            print(result_header, file=f)
            for c in args.components:
                with open(c, "r") as g:
                    content = g.read()
                    print(content, file=f)
            print(result, file=f)


# ---------------------------------------------------------------------------
# Generator (layer logic same as JSON version; analysis from IR)
# ---------------------------------------------------------------------------

class Generator:
    def __init__(self, filter_printf=True):
        self.funcs = None
        self.declarations = []
        self.source_nodes = []
        self.sink_nodes = []
        self.external_nodes = []
        self.inline_asm_calls = []
        self.fptr_calls = []
        self.fptr_arguments = []
        self.filter_printf = filter_printf

    PRINT_INTRINSICS = [
        "printhex_ul",
        "print_string",
        "printf",
        "printf_",
        "printk",
        "printhex_ul_dbg",
        "print_string_dbg",
        "__debug_save_state",
        "__debug_restore_state",
        "_out_",
        "_debug",
        "_ntoa_",
    ]

    @staticmethod
    def is_llvm_info_intrinsic(fname):
        LLVM_INTRINSICS = ["llvm.dbg", "llvm.lifetime"]
        for l in LLVM_INTRINSICS:
            if fname.startswith(l):
                return True
        return False

    @staticmethod
    def is_external_function(fname):
        EXTERNALS = ["QCBOREncode", "t_cose", "xlat", "attest_"]
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

    def read_llvm_ir_and_analyze(self, filepath: str):
        if self.funcs is not None:
            print("please use a new generator.", file=sys.stderr)
            return
        raw_funcs = parse_llvm_ir(filepath)
        self.funcs = {}
        for fname, data in raw_funcs.items():
            if self.is_llvm_info_intrinsic(fname):
                debug("remove llvm intrinsic", fname)
                continue
            self.funcs[fname] = {
                "fname": fname,
                "is_declaration": data["is_declaration"],
                "pres": list(data["pres"]),
                "sucs": list(data["sucs"]),
            }
        # pres already filled by parse_llvm_ir()

        for fname, f in self.funcs.items():
            if f["is_declaration"]:
                self.declarations.append(f)
                self.external_nodes.append(f["fname"])

        for fname in self.funcs:
            if len(self.funcs[fname]["sucs"]) == 0:
                self.sink_nodes.append(fname)
            if len(self.funcs[fname]["pres"]) == 0:
                self.source_nodes.append(fname)

    def dot_underscore_convert(self, f_list: list):
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

    def dfs(self, x, l, stamp, cycles):
        if x in stamp:
            cycles.append(copy.deepcopy(stamp))
            return True
        stamp.append(x)
        if len(self.funcs[x]["sucs"]) == 0:
            stamp.pop()
            return False
        cycle = False
        for suc in self.funcs[x]["sucs"]:
            if suc not in self.funcs:
                continue
            cycle = cycle | self.dfs(suc, l + 1, stamp, cycles)
        stamp.pop()
        return cycle

    def find_cycle(self, source=None):
        source = source if source is not None else self.source_nodes
        cycle = False
        cycles = []
        for fname in source:
            cycle = cycle | self.dfs(fname, 1, [], cycles)
        return cycle, cycles

    def break_cycle(self, cycle):
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
            fname = q.get()
            if fname in sink:
                continue
            for suc in self.funcs[fname]["sucs"]:
                if suc not in self.funcs:
                    continue
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
                if suc not in self.funcs:
                    continue
                pres[suc] = pres.get(suc, 0) + 1
        for t in top:
            q.append(t)
        while len(q) > 0:
            topological_steps.append(list(q))
            func = q.pop(0)
            if func in bottom:
                continue
            for suc in self.funcs[func]["sucs"]:
                if suc not in self.funcs:
                    continue
                pres[suc] = pres[suc] - 1
                if pres[suc] == 0:
                    q.append(suc)
        if len(bottom) != 0:
            topological_steps.append([])
            for a in bottom:
                topological_steps[-1].append(a)
        return topological_steps

    def compute_layers(self, top, bottom, steps):
        x = 0
        layer = []
        layer_map = {}
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
        layer_map = dict(sorted(layer_map.items(), key=(lambda item: -item[1])))
        return layer, layer_map

    def compute_config(self, top=None, bottom=None, name="default-config"):
        config = Config()
        _top = top if ((top is not None) and (len(top) != 0)) else self.source_nodes
        _bottom = bottom if bottom is not None else []
        if self.filter_printf:
            _top = list(filter(lambda f: not self.is_printf_intrinsic(f), _top))
            _bottom = _bottom + list(
                filter(lambda f: self.is_printf_intrinsic(f), self.funcs.keys())
            )
            _bottom = _bottom + list(
                filter(lambda f: self.is_external_function(f), self.funcs.keys())
            )
        _top = self.dot_underscore_convert(_top)
        _bottom = self.dot_underscore_convert(_bottom)
        config.set_top(_top)
        config.set_bottom(_bottom)
        config.reachable = self.compute_reachable(config.top, config.bottom)

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
        debug(steps)
        debug(config.name, "have", len(config.reachable), "reachable functions")

        config.layer, config.layer_map = self.compute_layers(
            config.top, config.bottom, steps
        )
        debug(
            config.name,
            "generate",
            len(config.layer),
            "for %d functions generated" % len(config.layer_map),
            " : ",
            [len(l) for l in config.layer],
        )
        return config


def run():
    generator = Generator()
    generator.read_llvm_ir_and_analyze(IR_LL_PATH)
    config = generator.compute_config(
        top=predefined["top"], bottom=predefined["bottom"]
    )

    base = os.path.splitext(os.path.basename(IR_LL_PATH))[0]
    out_json = base + ".gen." + config.name + ".json"
    out_coq = base + ".gen." + config.name + ".v"

    config.dump_config(out_json)
    debug(
        len(generator.inline_asm_calls),
        " inline asm calls are ignored (not detected from .ll)",
    )
    debug(len(generator.fptr_calls), " function pointer calls are ignored (not tracked)")
    debug(len(generator.fptr_arguments), " function pointer in arguments (not tracked)")
    debug(
        len(generator.declarations),
        " functions with declarations required spec manually",
        [f["fname"] for f in generator.declarations],
    )
    config.dump_config_in_coq(out_coq)
    debug("config (json) dumped into", out_json)
    debug("config (coq) dumped into", out_coq)


if __name__ == "__main__":
    run()
