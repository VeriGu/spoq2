#!/usr/bin/env python3
"""Writes the stack_frame fixtures' .ll and .expected.json files.

Run once to write the .ll files, src/mk_fixture.sh on each to write its
.main.v, and again to write the .expected.json files.

Each case stores 5 into the stack slot %x, calls an external function, and
reads %x back.  &x is first passed to @init, a writable captures(none)
parameter: that keeps SROA from promoting %x, which it does for an alloca whose
only call uses are readonly captures(none), without letting &x escape.

f_vuln returns the value read and f_patch returns 5, so the refinement holds
exactly when the call is known not to write %x.  The callee
has no memory attributes, so nothing but the stack-slot frame says so.
"""
import json
import re
import sys
from pathlib import Path

HEADER = """\
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@g = dso_local global i32 0, align 4
@gp = dso_local global ptr null, align 8
"""

FUNC = """\
define dso_local i32 @f_{side}({params}) {{
entry:
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  call void @init(ptr %x)
{pre}  store i32 5, ptr %x, align 4
{call}  %v = load i32, ptr %x, align 4
  ret i32 {ret}
}}
"""

RO = "ptr readonly captures(none)"
INIT = "declare void @init(ptr captures(none))"
RW = "ptr captures(none)"


def case(doc, decls, call, verified, pre="", params=""):
    return dict(doc=doc, decls=decls, call=call, verified=verified, pre=pre, params=params)


PHI_CALL = """\
  br i1 %c, label %a, label %b
a:
  br label %m
b:
  br label %m
m:
  %p = phi ptr [ %x, %a ], [ %y, %b ]
  call void @ext(ptr %p)
"""

CASES = {
    # The attribute on the one pointer parameter.
    "param_readonly": case("readonly parameter given &x", [f"declare void @ext({RO})"],
                           "call void @ext(ptr %x)", True),
    "param_readnone": case("readnone parameter given &x", ["declare void @ext(ptr readnone captures(none))"],
                           "call void @ext(ptr %x)", True),
    "param_byval": case("byval parameter given &x: the callee gets a copy",
                        ["declare void @ext(ptr byval(i32) captures(none))"],
                        "call void @ext(ptr byval(i32) %x)", True),
    "param_writable": case("negative control: writable parameter given &x", [f"declare void @ext({RW})"],
                           "call void @ext(ptr %x)", False),
    "param_writeonly": case("negative control: writeonly parameter given &x",
                            ["declare void @ext(ptr writeonly captures(none))"],
                            "call void @ext(ptr %x)", False),
    "callsite_readonly": case("readonly on the call site, not the declaration", [f"declare void @ext({RW})"],
                              "call void @ext(ptr readonly %x)", True),

    # &x not passed at all.
    "not_passed_other_slot": case("writable parameter given &y, another slot", [f"declare void @ext({RW})"],
                                  "call void @ext(ptr %y)", True),
    "not_passed_no_args": case("no arguments", ["declare void @ext()"], "call void @ext()", True),

    # Several pointer parameters.
    "two_params_x_readonly": case("&x to the readonly parameter, &y to the writable one",
                                  [f"declare void @ext({RO}, {RW})"], "call void @ext(ptr %x, ptr %y)", True),
    "two_params_x_writable": case("negative control: &x to the writable parameter, &y to the readonly one",
                                  [f"declare void @ext({RO}, {RW})"], "call void @ext(ptr %y, ptr %x)", False),
    "two_params_same_slot": case("negative control: &x to both, one writable",
                                 [f"declare void @ext({RO}, {RW})"], "call void @ext(ptr %x, ptr %x)", False),
    "two_params_both_readonly": case("&x to both, both readonly",
                                     [f"declare void @ext({RO}, {RO})"], "call void @ext(ptr %x, ptr %x)", True),

    # Pointers derived from &x, and pointers that cannot be.
    "gep_alias_writable": case("negative control: &x readonly and a GEP of &x writable",
                               [f"declare void @ext({RO}, {RW})"],
                               "call void @ext(ptr %x, ptr %q)", False,
                               pre="  %q = getelementptr inbounds i8, ptr %x, i64 0\n"),
    "gep_readonly": case("a GEP of &x to a readonly parameter", [f"declare void @ext({RO})"],
                         "call void @ext(ptr %q)", True,
                         pre="  %q = getelementptr inbounds i8, ptr %x, i64 0\n"),
    "select_writable": case("negative control: select of &x and &y to a writable parameter",
                            [f"declare void @ext({RW})"], "call void @ext(ptr %s)", False,
                            pre="  %s = select i1 %c, ptr %x, ptr %y\n", params="i1 %c"),
    "select_readonly": case("select of &x and &y to a readonly parameter",
                            [f"declare void @ext({RO})"], "call void @ext(ptr %s)", True,
                            pre="  %s = select i1 %c, ptr %x, ptr %y\n", params="i1 %c"),
    "phi_writable": case("negative control: phi of &x and &y to a writable parameter",
                         [f"declare void @ext({RW})"], PHI_CALL, False, params="i1 %c"),
    "loaded_ptr_writable": case("&x readonly, a pointer loaded from a global writable",
                                [f"declare void @ext({RO}, {RW})"], "call void @ext(ptr %x, ptr %h)", True,
                                pre="  %h = load ptr, ptr @gp, align 8\n"),
    "global_ptr_writable": case("&x readonly, &g writable", [f"declare void @ext({RO}, {RW})"],
                                "call void @ext(ptr %x, ptr @g)", True),
    "arg_ptr_writable": case("&x readonly, the caller's pointer argument writable",
                             [f"declare void @ext({RO}, {RW})"], "call void @ext(ptr %x, ptr %a)", True,
                             params="ptr %a"),

    # The provenance of &x escaping before the call.
    "escape_store": case("negative control: &x stored to a global", ["declare void @ext()"],
                         "call void @ext()", False, pre="  store ptr %x, ptr @gp, align 8\n"),
    "escape_ptrtoint": case("negative control: &x passed as an integer", ["declare void @ext(i64)"],
                            "call void @ext(i64 %i)", False, pre="  %i = ptrtoint ptr %x to i64\n"),

    # An earlier call given &x, with each captures(...) annotation.
    "capture_default": case("negative control: earlier call may capture &x",
                            ["declare void @capt(ptr readonly)", "declare void @ext()"],
                            "call void @ext()", False, pre="  call void @capt(ptr %x)\n"),
    "capture_none": case("earlier call captures(none)",
                         ["declare void @capt(ptr readonly captures(none))", "declare void @ext()"],
                         "call void @ext()", True, pre="  call void @capt(ptr %x)\n"),
    "capture_address": case("earlier call captures(address): no provenance",
                            ["declare void @capt(ptr readonly captures(address))", "declare void @ext()"],
                            "call void @ext()", True, pre="  call void @capt(ptr %x)\n"),
    "capture_address_is_null": case("earlier call captures(address_is_null)",
                                    ["declare void @capt(ptr readonly captures(address_is_null))",
                                     "declare void @ext()"],
                                    "call void @ext()", True, pre="  call void @capt(ptr %x)\n"),
    "capture_read_provenance": case("earlier call captures(read_provenance): reads only",
                                    ["declare void @capt(ptr readonly captures(read_provenance))",
                                     "declare void @ext()"],
                                    "call void @ext()", True, pre="  call void @capt(ptr %x)\n"),
    "capture_provenance": case("negative control: earlier call captures(provenance)",
                               ["declare void @capt(ptr readonly captures(provenance))", "declare void @ext()"],
                               "call void @ext()", False, pre="  call void @capt(ptr %x)\n"),
    "capture_ret_writable": case("negative control: captures(ret: address, provenance), result writable",
                                 ["declare ptr @id(ptr readonly captures(ret: address, provenance))",
                                  f"declare void @ext({RW})"],
                                 "call void @ext(ptr %p)", False, pre="  %p = call ptr @id(ptr %x)\n"),
    "capture_ret_readonly": case("captures(ret: address, provenance), result readonly",
                                 ["declare ptr @id(ptr readonly captures(ret: address, provenance))",
                                  f"declare void @ext({RO})"],
                                 "call void @ext(ptr %p)", True, pre="  %p = call ptr @id(ptr %x)\n"),
    "capture_ret_address": case("captures(ret: address): the result has no provenance of x",
                                ["declare ptr @id(ptr readonly captures(ret: address))",
                                 f"declare void @ext({RW})"],
                                "call void @ext(ptr %p)", True, pre="  %p = call ptr @id(ptr %x)\n"),
}

# Slots of other value types, written out in full.
EXTRA = {
    "ptr_slot_readonly": (True, "a pointer-valued slot given to a readonly parameter", f"""\
{INIT}
declare void @ext({RO})

define dso_local ptr @f_vuln() {{
entry:
  %x = alloca ptr, align 8
  call void @init(ptr %x)
  store ptr @g, ptr %x, align 8
  call void @ext(ptr %x)
  %v = load ptr, ptr %x, align 8
  ret ptr %v
}}

define dso_local ptr @f_patch() {{
entry:
  %x = alloca ptr, align 8
  call void @init(ptr %x)
  store ptr @g, ptr %x, align 8
  call void @ext(ptr %x)
  %v = load ptr, ptr %x, align 8
  ret ptr @g
}}
"""),
    "array_slot_readonly": (True, "an array slot given to a readonly parameter", None),
    "array_slot_writable": (False, "negative control: an array slot given to a writable parameter", None),
}


def array_case(attrs):
    return f"""\
{INIT}
declare void @ext({attrs})

define dso_local i32 @f_vuln() {{
entry:
  %x = alloca [4 x i32], align 16
  call void @init(ptr %x)
  %e = getelementptr inbounds [4 x i32], ptr %x, i64 0, i64 1
  store i32 7, ptr %e, align 4
  call void @ext(ptr %x)
  %v = load i32, ptr %e, align 4
  ret i32 %v
}}

define dso_local i32 @f_patch() {{
entry:
  %x = alloca [4 x i32], align 16
  call void @init(ptr %x)
  %e = getelementptr inbounds [4 x i32], ptr %x, i64 0, i64 1
  store i32 7, ptr %e, align 4
  call void @ext(ptr %x)
  %v = load i32, ptr %e, align 4
  ret i32 7
}}
"""


def write(out, name, doc, body, verified):
    """Writes <name>.ll, and <name>.expected.json once <name>.main.v exists:
    the frame line pins the slot %x was given, which is %x's StackVar hint.
    %x is the first alloca, so its slot leads the list of preserved slots."""
    (out / f"{name}.ll").write_text(f"; {doc}\n\n" + HEADER + "\n" + body)
    main_v = out / f"{name}.main.v"
    if not main_v.exists():
        return
    slot = re.search(r"^Hint StackVar f_vuln v_x (\S+)\.$", main_v.read_text(), re.M).group(1)
    line = f'[FRAME] f_vuln: call to ext_spec preserves "{slot}"'
    expected = {"verified": verified, "stderr_contains" if verified else "stderr_lacks": line}
    (out / f"{name}.expected.json").write_text(json.dumps(expected, indent=2) + "\n")


# Cases whose callee spec main.v defines.  The definition states the call's
# effect exactly, so no frame fact is emitted for it.
DEFINED = {
    "defined_spec": ("param_readonly",
                     "main.v defines ext_spec as (Some st), which states the call's effect: "
                     "no frame fact is emitted for it, though &x is passed to a readonly parameter.",
                     "Definition ext_spec (p: Ptr) (st: RData) : (option RData) := (Some st)."),
}


def case_body(c):
    body = "\n".join([INIT] + c["decls"]) + "\n\n"
    for side, ret in (("vuln", "%v"), ("patch", "5")):
        body += FUNC.format(side=side, params=c["params"], pre=c["pre"],
                            call=c["call"] if c["call"].endswith("\n") else f"  {c['call']}\n",
                            ret=ret) + "\n"
    return body


def main():
    out = Path(sys.argv[1])
    for name, c in CASES.items():
        write(out, name, c["doc"], case_body(c), c["verified"])
    for name, (verified, doc, body) in EXTRA.items():
        if body is None:
            body = array_case(RO if verified else RW)
        write(out, name, doc, body, verified)
    for name, (base, doc, definition) in DEFINED.items():
        (out / f"{name}.ll").write_text(f"; {doc}\n\n" + HEADER + "\n" + case_body(CASES[base]))
        main_v = out / f"{name}.main.v"
        if not main_v.exists():
            continue
        main_v.write_text(re.sub(r"^Parameter ext_spec :.*$", definition, main_v.read_text(), flags=re.M))
        expected = {"verified": True, "stderr_lacks": "[FRAME] f_vuln: call to ext_spec preserves"}
        (out / f"{name}.expected.json").write_text(json.dumps(expected, indent=2) + "\n")


if __name__ == "__main__":
    main()
