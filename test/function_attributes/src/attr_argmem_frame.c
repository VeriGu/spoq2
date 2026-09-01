/* The callee may write through its pointer argument, and a pointer IS passed --
   so the coarse rule gives up.  But the pointer is the address of a local, so
   the only region it can name is the stack; the globals are untouched and g is
   still 5 afterwards.

   This is what the argmem frame buys: the post-call state is the pre-call state
   with only the region the pointer designates replaced, instead of being wholly
   unconstrained.  Fails without the frame.

   C has no attribute that spells this, so the .ll is edited by hand. */
int g;
int ext_argmem_frame(int *p);

int vuln(void) {
    int local = 0;
    g = 5;
    ext_argmem_frame(&local);
    return g;
}

int patch(void) {
    int local = 0;
    g = 5;
    ext_argmem_frame(&local);
    return 5;
}
