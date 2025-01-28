Definition atomic_add_64_spec (loc: Ptr) (val: Z) (st: RData) : (option RData) :=
  when v, st == ((load_RData 64 loc st));
  when st == ((store_RData 64 loc (v + (val)) st));
  (Some st).

Definition cpuid_spec (st: RData) : (option (Z * RData)) :=
  (Some (CPU_ID, st)).

Definition find_granule_spec (v_0: Z) (st: RData) : (option (Ptr * RData)) :=
  let mem0_id := ((v_0 + ((- MEM0_PHYS))) >> (12)) in
  (Some ((mkPtr "granules" (mem0_id * (16))), st)).

Definition granule_lock_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
  if ((v_0.(pbase)) =s ("granules"))
  then (
    when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
    rely (
      (((((((st.(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (16))).(e_state_s_granule)) -
        (((((((lens 2 st).(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (16))).(e_state_s_granule)))) =
        (0)));
    rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
    if ((((((((lens 2 st).(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (16))).(e_state_s_granule)) - (v_1)) =? (0))
    then (Some ((lens 13 st).[halt] :< false))
    else (Some ((lens 17 st).[halt] :< false)))
  else None.

