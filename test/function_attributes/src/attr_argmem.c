/* The callee is declared
     memory(read, argmem: readwrite, inaccessiblemem: none, target_mem: none)
   -- it may read anything, and may *write* through its pointer arguments.  It
   is handed &g, so g is argument memory and the call may change it.

   Nothing may therefore be assumed about g afterwards, and the two sides must
   not be proved equivalent: this pins spoq's conservative treatment of the
   granular memory() form.  Only the coarse "never writes at all" cases
   (memory(none), memory(read)) license reusing the incoming state.

   C has no attribute that spells this, so the .ll is edited by hand. */
int g;
int ext_argmem(int *p);

int vuln(void) {
    g = 5;
    ext_argmem(&g);
    return g;
}

int patch(void) {
    g = 5;
    ext_argmem(&g);
    return 5;
}
