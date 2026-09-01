Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section TableAux_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition __find_lock_next_level_spec (v_g_tbl: Ptr) (v_map_addr: Z) (v_level: Z) (st: RData) : (option (Ptr * RData)) :=
    rely ((((v_g_tbl.(poffset)) mod (ST_GRANULE_SIZE)) = (0)));
    rely (((v_g_tbl.(pbase)) = ("granules")));
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    when cid == (((((st.(share)).(granules)) @ ((((st.(share)).(slots)) # SLOT_RTT == (((((GRANULES_BASE + ((v_g_tbl.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT)).(e_lock)));
    if (
      (((((((st.(share)).(granule_data)) @ ((((st.(share)).(slots)) # SLOT_RTT == (((((GRANULES_BASE + ((v_g_tbl.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT)).(g_norm)) @
        (((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE)) +
          ((8 * (((v_map_addr >> (((((((v_level * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))) & (511))))))) &
        (3)) =?
        (3)))
    then (
      rely (
        (((0 -
          ((((((((st.(share)).(granule_data)) @ ((((st.(share)).(slots)) # SLOT_RTT == (((((GRANULES_BASE + ((v_g_tbl.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT)).(g_norm)) @
            (((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE)) +
              ((8 * (((v_map_addr >> (((((((v_level * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))) & (511))))))) &
            (281474976710655)) /
            (GRANULE_SIZE)))) <=
          (0)) /\
          (((((((((st.(share)).(granule_data)) @ ((((st.(share)).(slots)) # SLOT_RTT == (((((GRANULES_BASE + ((v_g_tbl.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT)).(g_norm)) @
            (((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE)) +
              ((8 * (((v_map_addr >> (((((((v_level * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))) & (511))))))) &
            (281474976710655)) /
            (GRANULE_SIZE)) <
            (1048576)))));
      rely (
        ((((((st.(share)).(granules)) @
          ((16 *
            ((((((((st.(share)).(granule_data)) @ ((((st.(share)).(slots)) # SLOT_RTT == (((((GRANULES_BASE + ((v_g_tbl.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT)).(g_norm)) @
              (((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE)) +
                ((8 * (((v_map_addr >> (((((((v_level * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))) & (511))))))) &
              (281474976710655)) /
              (GRANULE_SIZE)))) /
            (ST_GRANULE_SIZE))).(e_state)) -
          (6)) =
          (0)));
      when st1 == (
          (query_oracle
            (st.[share].[slots] :<
              (((st.(share)).(slots)) # SLOT_RTT == (((((GRANULES_BASE + ((v_g_tbl.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))))));
      match (
        ((((st1.(share)).(granules)) @
          ((16 *
            ((((((((st.(share)).(granule_data)) @ ((((st.(share)).(slots)) # SLOT_RTT == (((((GRANULES_BASE + ((v_g_tbl.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT)).(g_norm)) @
              (((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE)) +
                ((8 * (((v_map_addr >> (((((((v_level * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))) & (511))))))) &
              (281474976710655)) /
              (GRANULE_SIZE)))) /
            (ST_GRANULE_SIZE))).(e_lock))
      ) with
      | None =>
        rely (
          ((((((st.(share)).(granules)) @
            ((16 *
              ((((((((st.(share)).(granule_data)) @ ((((st.(share)).(slots)) # SLOT_RTT == (((((GRANULES_BASE + ((v_g_tbl.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT)).(g_norm)) @
                (((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE)) +
                  ((8 * (((v_map_addr >> (((((((v_level * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))) & (511))))))) &
                (281474976710655)) /
                (GRANULE_SIZE)))) /
              (ST_GRANULE_SIZE))).(e_state)) -
            (((((st1.(share)).(granules)) @
              ((16 *
                ((((((((st.(share)).(granule_data)) @ ((((st.(share)).(slots)) # SLOT_RTT == (((((GRANULES_BASE + ((v_g_tbl.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT)).(g_norm)) @
                  (((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE)) +
                    ((8 * (((v_map_addr >> (((((((v_level * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))) & (511))))))) &
                  (281474976710655)) /
                  (GRANULE_SIZE)))) /
                (ST_GRANULE_SIZE))).(e_state)))) =
            (0)));
        (Some (
          (mkPtr
            "granules"
            (16 *
              ((((((((st.(share)).(granule_data)) @ ((((st.(share)).(slots)) # SLOT_RTT == (((((GRANULES_BASE + ((v_g_tbl.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT)).(g_norm)) @
                (((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE)) +
                  ((8 * (((v_map_addr >> (((((((v_level * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))) & (511))))))) &
                (281474976710655)) /
                (GRANULE_SIZE)))))  ,
          ((st1.[log] :<
            ((EVT
              CPU_ID
              (ACQ
                ((16 *
                  ((((((((st.(share)).(granule_data)) @ ((((st.(share)).(slots)) # SLOT_RTT == (((((GRANULES_BASE + ((v_g_tbl.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT)).(g_norm)) @
                    (((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE)) +
                      ((8 * (((v_map_addr >> (((((((v_level * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))) & (511))))))) &
                    (281474976710655)) /
                    (GRANULE_SIZE)))) /
                  (ST_GRANULE_SIZE)))) ::
              ((st1.(log))))).[share].[granules] :<
            (((st1.(share)).(granules)) #
              ((16 *
                ((((((((st.(share)).(granule_data)) @ ((((st.(share)).(slots)) # SLOT_RTT == (((((GRANULES_BASE + ((v_g_tbl.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT)).(g_norm)) @
                  (((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE)) +
                    ((8 * (((v_map_addr >> (((((((v_level * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))) & (511))))))) &
                  (281474976710655)) /
                  (GRANULE_SIZE)))) /
                (ST_GRANULE_SIZE)) ==
              ((((st1.(share)).(granules)) @
                ((16 *
                  ((((((((st.(share)).(granule_data)) @ ((((st.(share)).(slots)) # SLOT_RTT == (((((GRANULES_BASE + ((v_g_tbl.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT)).(g_norm)) @
                    (((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE)) +
                      ((8 * (((v_map_addr >> (((((((v_level * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))) & (511))))))) &
                    (281474976710655)) /
                    (GRANULE_SIZE)))) /
                  (ST_GRANULE_SIZE))).[e_lock] :<
                (Some CPU_ID))))
        ))
      | (Some cid_0) => None
      end)
    else (
      (Some (
        (mkPtr "null" 0)  ,
        (st.[share].[slots] :<
          (((st.(share)).(slots)) # SLOT_RTT == (((((GRANULES_BASE + ((v_g_tbl.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))))
      ))).

End TableAux_Spec.

#[global] Hint Unfold __find_lock_next_level_spec: spec.
