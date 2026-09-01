/* Same declaration as attr_argmem --
     memory(read, argmem: readwrite, inaccessiblemem: none, target_mem: none)
   -- but the callee takes no pointer argument, so its argument memory is empty
   and the readwrite permission over it licenses no write at all.  Everything
   else it may touch is read-only, so the state survives the call and g is still
   5 afterwards.

   This is the positive half of the pair: it needs the per-location narrowing
   (drop ArgMem when no pointer is passed) and fails without it.
   attr_argmem is the same attribute where a pointer *is* passed.

   C has no attribute that spells this, so the .ll is edited by hand. */
int g;
int ext_argmem_np(int x);

int vuln(void) {
    g = 5;
    ext_argmem_np(1);
    return g;
}

int patch(void) {
    g = 5;
    ext_argmem_np(1);
    return 5;
}
