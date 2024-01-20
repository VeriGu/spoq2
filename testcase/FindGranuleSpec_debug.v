Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import GranuleState.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section FindGranule_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition granule_lock_on_state_match_spec (v_g: Ptr) (v_expected_state: Z) (st: RData) : (option (bool * RData)) :=
    rely ((((v_g.(pbase)) = "granules") /\ (((v_g.(poffset)) mod ST_GRANULE_SIZE) = 0)));
    let v_lock := (ptr_offset v_g ((16 * 0) + (0 + 0))) in
    when st == ((spinlock_acquire_spec v_lock st));
    when v_call, st == ((granule_get_state_spec v_g st));
    let v_cmp_not := (v_call =? v_expected_state) in
    when st == (
        if v_cmp_not
        then (Some st)
        else (
          when st == ((spinlock_release_spec v_lock st));
          (Some st)));
    let __return__ := true in
    let __retval__ := v_cmp_not in
    (Some (__retval__, st)).

  Definition find_granule_spec (v_addr: Z) (st: RData) : (option (Ptr * RData)) :=
    let v_rem := (v_addr & 4095) in
    let v_cmp := (v_rem =? 0) in
    when v_retval_0, st == (
        let v_retval_0 := (mkPtr "#" 0) in
        if v_cmp
        then (
          when v_call, st == ((plat_granule_addr_to_idx_spec v_addr st));
          let v_cmp1 := (v_call >? 1048575) in
          when v_retval_0, st == (
              let v_retval_0 := (mkPtr "#" 0) in
              if v_cmp1
              then (
                let v_retval_0 := (mkPtr "null" 0) in
                (Some (v_retval_0, st)))
              else (
                when v_call4, st == ((granule_from_idx_spec v_call st));
                let v_retval_0 := v_call4 in
                (Some (v_retval_0, st))));
          (Some (v_retval_0, st)))
        else (
          let v_retval_0 := (mkPtr "null" 0) in
          (Some (v_retval_0, st))));
    let __return__ := true in
    let __retval__ := v_retval_0 in
    (Some (__retval__, st)).

  Definition sort_granules_spec (v_granules: Ptr) (v_n: Z) (st: RData) : (option RData) :=
    rely ((((stack_ptr_extract_slot ((v_granules.(poffset)) + 56)) - (stack_ptr_extract_slot (v_granules.(poffset)))) = 0));
    rely ((((stack_ptr_extract_slot ((v_granules.(poffset)) + 48)) - (stack_ptr_extract_slot (v_granules.(poffset)))) = 0));
    rely ((((stack_ptr_extract_slot ((v_granules.(poffset)) + 40)) - (stack_ptr_extract_slot (v_granules.(poffset)))) = 0));
    rely ((((stack_ptr_extract_slot ((v_granules.(poffset)) + 16)) - (stack_ptr_extract_slot (v_granules.(poffset)))) = 0));
    rely ((((stack_ptr_extract_slot ((v_granules.(poffset)) + 8)) - (stack_ptr_extract_slot (v_granules.(poffset)))) = 0));
    rely ((((((st.(priv)).(pcpu_sc)) + 1) - (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))) <> 0));
    rely (((stack_ptr_extract_ofs ((v_granules.(poffset)) + 56)) = 56));
    rely (((stack_ptr_extract_ofs ((v_granules.(poffset)) + 48)) = 48));
    rely (((stack_ptr_extract_ofs ((v_granules.(poffset)) + 40)) = 40));
    rely (((stack_ptr_extract_ofs ((v_granules.(poffset)) + 16)) = 16));
    rely (((stack_ptr_extract_ofs ((v_granules.(poffset)) + 8)) = 8));
    rely (((stack_ptr_extract_ofs (v_granules.(poffset))) = 0));
    rely (((v_granules.(pbase)) = "stack"));
    match (((v_granules.(pbase)), ((v_granules.(poffset)) + 40))) with
    | ("stack", ofs) =>
      if (
        (((((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ofs)).(sf_data)) @ (stack_ptr_extract_ofs ofs)).(sd_size)) -
          8) <>?
          0))
      then None
      else (
        match (((v_granules.(pbase)), ((v_granules.(poffset)) + 48))) with
        | ("stack", ofs_0) =>
          if ((((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ofs_0)).(sf_data)) @ (stack_ptr_extract_ofs ofs_0)).(sd_size)) - 8) <>? 0)
          then None
          else (
            match (((v_granules.(pbase)), ((v_granules.(poffset)) + 8))) with
            | ("stack", ofs_1) =>
              if (
                ((((((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                  (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                  (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                    (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                      (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                      (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                      ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                      (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                      ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                      (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) @ (stack_ptr_extract_slot ofs_1)).(sf_data)) @ (stack_ptr_extract_ofs ofs_1)).(sd_size)) -
                  8) <>?
                  0))
              then None
              else (
                if (
                  ((((((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                    (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                    (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                      (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                        (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                        (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                        ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                        (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                        ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                        (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) @ (stack_ptr_extract_slot ofs_1)).(sf_data)) @ (stack_ptr_extract_ofs ofs_1)).(sd_data)) -
                    ((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ofs_0)).(sf_data)) @ (stack_ptr_extract_ofs ofs_0)).(sd_data))) >?
                    0))
                then (
                  match (((v_granules.(pbase)), (v_granules.(poffset)))) with
                  | ("stack", ofs_2) =>
                    if (
                      (((((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                        (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                        (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                          (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                            (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                            (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                            ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                            (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                            ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                            (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) @ (stack_ptr_extract_slot (v_granules.(poffset)))).(sf_data)) @ (stack_ptr_extract_ofs ofs_2)).(sd_size)) =?
                        0))
                    then (
                      (Some ((st.[priv].[pcpu_sc] :< (((st.(priv)).(pcpu_sc)) + 1)).[priv].[pcpu_stack] :<
                        (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                          (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                          (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                            (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                              (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                              (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                              ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                              (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                              ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                              (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) #
                          (stack_ptr_extract_slot ((v_granules.(poffset)) + 40)) ==
                          ((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                            (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                            (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                              (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 40))).[sf_data] :<
                            ((((((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                              (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                              (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                  (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                  (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                  ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                  (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                  ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                  (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) #
                              (stack_ptr_extract_slot ((v_granules.(poffset)) + 40)) ==
                              ((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                                (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                  (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                    (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                    (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                    ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                    (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                    ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                    (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 40))).[sf_data] :<
                                (((((((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                                  (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                  (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                    (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                      (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                      (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                      ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                      (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                      ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                      (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) @ (stack_ptr_extract_slot (v_granules.(poffset)))).(sf_data)) #
                                  40 ==
                                  (((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                                    (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                    (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                      (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                        (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                        (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                        ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                        (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                        ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                        (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) @ (stack_ptr_extract_slot (v_granules.(poffset)))).(sf_data)) @ (stack_ptr_extract_ofs (v_granules.(poffset))))) #
                                  48 ==
                                  (((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                                    (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                    (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                      (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                        (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                        (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                        ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                        (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                        ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                        (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) @ (stack_ptr_extract_slot (v_granules.(poffset)))).(sf_data)) @ 8)) #
                                  56 ==
                                  (((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                                    (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                    (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                      (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                        (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                        (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                        ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                        (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                        ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                        (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) @ (stack_ptr_extract_slot (v_granules.(poffset)))).(sf_data)) @ 32)) #
                                  (stack_ptr_extract_ofs ofs_2) ==
                                  (mkStackData ((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ofs)).(sf_data)) @ (stack_ptr_extract_ofs ofs)).(sd_data)) 8)) #
                                  (stack_ptr_extract_ofs ofs_1) ==
                                  (mkStackData ((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ofs_0)).(sf_data)) @ (stack_ptr_extract_ofs ofs_0)).(sd_data)) 8)))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).(sf_data)) #
                              16 ==
                              ((((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                                (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                  (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                    (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                    (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                    ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                    (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                    ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                    (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) #
                                (stack_ptr_extract_slot ((v_granules.(poffset)) + 40)) ==
                                ((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                                  (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                  (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                    (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                      (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                      (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                      ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                      (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                      ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                      (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 40))).[sf_data] :<
                                  (((((((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                                    (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                    (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                      (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                        (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                        (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                        ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                        (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                        ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                        (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) @ (stack_ptr_extract_slot (v_granules.(poffset)))).(sf_data)) #
                                    40 ==
                                    (((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                                      (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                      (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                        (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                          (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                          ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                          ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) @ (stack_ptr_extract_slot (v_granules.(poffset)))).(sf_data)) @ (stack_ptr_extract_ofs (v_granules.(poffset))))) #
                                    48 ==
                                    (((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                                      (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                      (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                        (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                          (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                          ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                          ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) @ (stack_ptr_extract_slot (v_granules.(poffset)))).(sf_data)) @ 8)) #
                                    56 ==
                                    (((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                                      (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                      (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                        (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                          (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                          ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                          ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) @ (stack_ptr_extract_slot (v_granules.(poffset)))).(sf_data)) @ 32)) #
                                    (stack_ptr_extract_ofs ofs_2) ==
                                    (mkStackData ((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ofs)).(sf_data)) @ (stack_ptr_extract_ofs ofs)).(sd_data)) 8)) #
                                    (stack_ptr_extract_ofs ofs_1) ==
                                    (mkStackData ((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ofs_0)).(sf_data)) @ (stack_ptr_extract_ofs ofs_0)).(sd_data)) 8)))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).(sf_data)) @ (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)))) #
                              24 ==
                              ((((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                                (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                  (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                    (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                    (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                    ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                    (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                    ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                    (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) #
                                (stack_ptr_extract_slot ((v_granules.(poffset)) + 40)) ==
                                ((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                                  (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                  (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                    (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                      (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                      (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                      ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                      (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                      ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                      (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 40))).[sf_data] :<
                                  (((((((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                                    (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                    (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                      (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                        (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                        (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                        ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                        (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                        ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                        (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) @ (stack_ptr_extract_slot (v_granules.(poffset)))).(sf_data)) #
                                    40 ==
                                    (((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                                      (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                      (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                        (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                          (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                          ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                          ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) @ (stack_ptr_extract_slot (v_granules.(poffset)))).(sf_data)) @ (stack_ptr_extract_ofs (v_granules.(poffset))))) #
                                    48 ==
                                    (((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                                      (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                      (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                        (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                          (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                          ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                          ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) @ (stack_ptr_extract_slot (v_granules.(poffset)))).(sf_data)) @ 8)) #
                                    56 ==
                                    (((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                                      (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                      (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                        (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                          (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                          ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                          ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) @ (stack_ptr_extract_slot (v_granules.(poffset)))).(sf_data)) @ 32)) #
                                    (stack_ptr_extract_ofs ofs_2) ==
                                    (mkStackData ((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ofs)).(sf_data)) @ (stack_ptr_extract_ofs ofs)).(sd_data)) 8)) #
                                    (stack_ptr_extract_ofs ofs_1) ==
                                    (mkStackData ((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ofs_0)).(sf_data)) @ (stack_ptr_extract_ofs ofs_0)).(sd_data)) 8)))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).(sf_data)) @ ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8))) #
                              32 ==
                              ((((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                                (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                  (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                    (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                    (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                    ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                    (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                    ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                    (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) #
                                (stack_ptr_extract_slot ((v_granules.(poffset)) + 40)) ==
                                ((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                                  (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                  (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                    (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                      (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                      (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                      ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                      (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                      ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                      (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 40))).[sf_data] :<
                                  (((((((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                                    (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                    (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                      (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                        (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                        (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                        ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                        (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                        ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                        (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) @ (stack_ptr_extract_slot (v_granules.(poffset)))).(sf_data)) #
                                    40 ==
                                    (((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                                      (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                      (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                        (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                          (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                          ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                          ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) @ (stack_ptr_extract_slot (v_granules.(poffset)))).(sf_data)) @ (stack_ptr_extract_ofs (v_granules.(poffset))))) #
                                    48 ==
                                    (((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                                      (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                      (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                        (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                          (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                          ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                          ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) @ (stack_ptr_extract_slot (v_granules.(poffset)))).(sf_data)) @ 8)) #
                                    56 ==
                                    (((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                                      (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                      (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                        (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                          (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                          ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                          ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) @ (stack_ptr_extract_slot (v_granules.(poffset)))).(sf_data)) @ 32)) #
                                    (stack_ptr_extract_ofs ofs_2) ==
                                    (mkStackData ((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ofs)).(sf_data)) @ (stack_ptr_extract_ofs ofs)).(sd_data)) 8)) #
                                    (stack_ptr_extract_ofs ofs_1) ==
                                    (mkStackData ((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ofs_0)).(sf_data)) @ (stack_ptr_extract_ofs ofs_0)).(sd_data)) 8)))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).(sf_data)) @ ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16))))))))
                    else (
                      if (
                        ((((((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                          (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                          (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                            (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                              (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                              (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                              ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                              (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                              ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                              (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) @ (stack_ptr_extract_slot (v_granules.(poffset)))).(sf_data)) @ (stack_ptr_extract_ofs ofs_2)).(sd_size)) -
                          8) <>?
                          0))
                      then None
                      else (
                        (Some ((st.[priv].[pcpu_sc] :< (((st.(priv)).(pcpu_sc)) + 1)).[priv].[pcpu_stack] :<
                          (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                            (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                            (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                              (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) #
                            (stack_ptr_extract_slot ((v_granules.(poffset)) + 40)) ==
                            ((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                              (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                              (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                  (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                  (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                  ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                  (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                  ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                  (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 40))).[sf_data] :<
                              ((((((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                                (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                  (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                    (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                    (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                    ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                    (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                    ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                    (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) #
                                (stack_ptr_extract_slot ((v_granules.(poffset)) + 40)) ==
                                ((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                                  (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                  (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                    (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                      (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                      (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                      ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                      (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                      ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                      (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 40))).[sf_data] :<
                                  (((((((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                                    (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                    (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                      (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                        (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                        (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                        ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                        (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                        ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                        (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) @ (stack_ptr_extract_slot (v_granules.(poffset)))).(sf_data)) #
                                    40 ==
                                    (((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                                      (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                      (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                        (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                          (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                          ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                          ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) @ (stack_ptr_extract_slot (v_granules.(poffset)))).(sf_data)) @ (stack_ptr_extract_ofs (v_granules.(poffset))))) #
                                    48 ==
                                    (((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                                      (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                      (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                        (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                          (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                          ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                          ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) @ (stack_ptr_extract_slot (v_granules.(poffset)))).(sf_data)) @ 8)) #
                                    56 ==
                                    (((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                                      (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                      (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                        (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                          (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                          ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                          ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) @ (stack_ptr_extract_slot (v_granules.(poffset)))).(sf_data)) @ 32)) #
                                    (stack_ptr_extract_ofs ofs_2) ==
                                    (mkStackData ((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ofs)).(sf_data)) @ (stack_ptr_extract_ofs ofs)).(sd_data)) 8)) #
                                    (stack_ptr_extract_ofs ofs_1) ==
                                    (mkStackData ((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ofs_0)).(sf_data)) @ (stack_ptr_extract_ofs ofs_0)).(sd_data)) 8)))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).(sf_data)) #
                                16 ==
                                ((((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                                  (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                  (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                    (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                      (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                      (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                      ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                      (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                      ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                      (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) #
                                  (stack_ptr_extract_slot ((v_granules.(poffset)) + 40)) ==
                                  ((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                                    (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                    (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                      (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                        (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                        (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                        ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                        (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                        ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                        (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 40))).[sf_data] :<
                                    (((((((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                                      (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                      (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                        (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                          (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                          ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                          ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) @ (stack_ptr_extract_slot (v_granules.(poffset)))).(sf_data)) #
                                      40 ==
                                      (((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                                        (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                        (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                          (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                            (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                            (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                            ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                            (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                            ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                            (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) @ (stack_ptr_extract_slot (v_granules.(poffset)))).(sf_data)) @ (stack_ptr_extract_ofs (v_granules.(poffset))))) #
                                      48 ==
                                      (((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                                        (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                        (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                          (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                            (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                            (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                            ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                            (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                            ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                            (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) @ (stack_ptr_extract_slot (v_granules.(poffset)))).(sf_data)) @ 8)) #
                                      56 ==
                                      (((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                                        (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                        (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                          (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                            (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                            (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                            ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                            (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                            ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                            (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) @ (stack_ptr_extract_slot (v_granules.(poffset)))).(sf_data)) @ 32)) #
                                      (stack_ptr_extract_ofs ofs_2) ==
                                      (mkStackData ((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ofs)).(sf_data)) @ (stack_ptr_extract_ofs ofs)).(sd_data)) 8)) #
                                      (stack_ptr_extract_ofs ofs_1) ==
                                      (mkStackData ((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ofs_0)).(sf_data)) @ (stack_ptr_extract_ofs ofs_0)).(sd_data)) 8)))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).(sf_data)) @ (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)))) #
                                24 ==
                                ((((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                                  (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                  (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                    (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                      (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                      (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                      ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                      (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                      ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                      (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) #
                                  (stack_ptr_extract_slot ((v_granules.(poffset)) + 40)) ==
                                  ((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                                    (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                    (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                      (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                        (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                        (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                        ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                        (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                        ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                        (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 40))).[sf_data] :<
                                    (((((((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                                      (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                      (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                        (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                          (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                          ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                          ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) @ (stack_ptr_extract_slot (v_granules.(poffset)))).(sf_data)) #
                                      40 ==
                                      (((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                                        (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                        (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                          (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                            (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                            (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                            ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                            (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                            ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                            (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) @ (stack_ptr_extract_slot (v_granules.(poffset)))).(sf_data)) @ (stack_ptr_extract_ofs (v_granules.(poffset))))) #
                                      48 ==
                                      (((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                                        (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                        (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                          (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                            (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                            (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                            ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                            (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                            ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                            (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) @ (stack_ptr_extract_slot (v_granules.(poffset)))).(sf_data)) @ 8)) #
                                      56 ==
                                      (((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                                        (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                        (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                          (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                            (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                            (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                            ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                            (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                            ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                            (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) @ (stack_ptr_extract_slot (v_granules.(poffset)))).(sf_data)) @ 32)) #
                                      (stack_ptr_extract_ofs ofs_2) ==
                                      (mkStackData ((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ofs)).(sf_data)) @ (stack_ptr_extract_ofs ofs)).(sd_data)) 8)) #
                                      (stack_ptr_extract_ofs ofs_1) ==
                                      (mkStackData ((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ofs_0)).(sf_data)) @ (stack_ptr_extract_ofs ofs_0)).(sd_data)) 8)))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).(sf_data)) @ ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8))) #
                                32 ==
                                ((((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                                  (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                  (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                    (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                      (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                      (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                      ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                      (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                      ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                      (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) #
                                  (stack_ptr_extract_slot ((v_granules.(poffset)) + 40)) ==
                                  ((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                                    (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                    (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                      (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                        (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                        (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                        ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                        (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                        ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                        (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 40))).[sf_data] :<
                                    (((((((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                                      (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                      (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                        (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                          (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                          ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                          ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) @ (stack_ptr_extract_slot (v_granules.(poffset)))).(sf_data)) #
                                      40 ==
                                      (((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                                        (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                        (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                          (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                            (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                            (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                            ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                            (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                            ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                            (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) @ (stack_ptr_extract_slot (v_granules.(poffset)))).(sf_data)) @ (stack_ptr_extract_ofs (v_granules.(poffset))))) #
                                      48 ==
                                      (((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                                        (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                        (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                          (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                            (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                            (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                            ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                            (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                            ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                            (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) @ (stack_ptr_extract_slot (v_granules.(poffset)))).(sf_data)) @ 8)) #
                                      56 ==
                                      (((((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                                        (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                        (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                                          (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                                            (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                                            (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                                            ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                                            (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                                            ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                                            (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72)))) @ (stack_ptr_extract_slot (v_granules.(poffset)))).(sf_data)) @ 32)) #
                                      (stack_ptr_extract_ofs ofs_2) ==
                                      (mkStackData ((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ofs)).(sf_data)) @ (stack_ptr_extract_ofs ofs)).(sd_data)) 8)) #
                                      (stack_ptr_extract_ofs ofs_1) ==
                                      (mkStackData ((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ofs_0)).(sf_data)) @ (stack_ptr_extract_ofs ofs_0)).(sd_data)) 8)))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).(sf_data)) @ ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16)))))))))
                  | _ => None
                  end)
                else (
                  (Some ((st.[priv].[pcpu_sc] :< (((st.(priv)).(pcpu_sc)) + 1)).[priv].[pcpu_stack] :<
                    ((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) #
                      (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                      (((((st.(priv)).(pcpu_stack)) # ((st.(priv)).(pcpu_sc)) == ((mkStackFrame (ZMap.init (mkStackData 0 0)) 0).[sf_sp] :< (- 1))) @ (stack_ptr_extract_slot ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0))).[sf_data] :<
                        (((((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) #
                          (stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) ==
                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 56)) #
                          ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 8) ==
                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 64)) #
                          ((stack_ptr_extract_ofs ((((st.(priv)).(pcpu_sc)) << MaxStackOrder) |' 0)) + 16) ==
                          (((((st.(priv)).(pcpu_stack)) @ (stack_ptr_extract_slot ((v_granules.(poffset)) + 56))).(sf_data)) @ 72))))))))
            | _ => None
            end)
        | _ => None
        end)
    | _ => None
    end.

  Definition addr_to_granule_spec (v_addr: Z) (st: RData) : (option (Ptr * RData)) :=
    rely ((((0 - (v_addr / 4096)) <= 0) /\ ((v_addr / 4096) < 1048576)));
    (Some ((mkPtr "granules" (16 * (v_addr / 4096))), st)).

End FindGranule_Spec.

#[global] Hint Unfold granule_lock_on_state_match_spec: spec.
#[global] Hint Unfold find_granule_spec: spec.
#[global] Hint Unfold sort_granules_spec: spec.
#[global] Hint Unfold addr_to_granule_spec: spec.
