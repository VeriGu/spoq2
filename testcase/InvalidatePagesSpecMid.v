Definition invalidate_page_spec_mid (v_s2_ctx: Ptr) (v_addr: Z) (st: RData) : (option RData) :=
  (Some st).

Definition invalidate_pages_in_block_spec_mid (v_s2_ctx: Ptr) (v_addr: Z) (st: RData) : (option RData) :=
  (Some st).

Definition invalidate_block_spec_mid (v_s2_ctx: Ptr) (v_addr: Z) (st: RData) : (option RData) :=
  (Some st).

