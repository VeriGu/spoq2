Definition invalidate_page_spec (v_s2_ctx: Ptr) (v_addr: Z) (st: RData) : (option RData) :=
  (Some st).

Definition invalidate_block_spec (v_s2_ctx: Ptr) (v_addr: Z) (st: RData) : (option RData) :=
  (Some st).

