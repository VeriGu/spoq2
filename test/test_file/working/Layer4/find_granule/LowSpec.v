Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer4_find_granule_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition find_granule_spec_low (v_0: Z) (st: RData) : (option (Ptr * RData)) :=
    when st_1 == ((query_oracle st));
    rely (((((st_1.(share)).(globals)).(g_granules)) = ((((st.(share)).(globals)).(g_granules)))));
    if (v_0 >=? (MEM1_PHYS))
    then (
      let mem1_id := ((v_0 + ((- MEM1_PHYS))) >> ((12 + (524288)))) in
      (Some ((mkPtr "granules" (mem1_id * (16))), st)))
    else (
      let mem0_id := ((v_0 + ((- MEM0_PHYS))) >> (12)) in
      (Some ((mkPtr "granules" (mem0_id * (16))), st_1))).

End Layer4_find_granule_LowSpec.

#[global] Hint Unfold find_granule_spec_low: spec.
