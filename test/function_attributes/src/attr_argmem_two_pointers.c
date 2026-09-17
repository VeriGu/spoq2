/* Two pointer parameters, framed.

   The frame is stated per region rather than per pointer: each region is pinned
   unless some argument could name it, plus the heap block by block, with the
   blocks the arguments name left open.  That is one clause per region however
   many pointers there are -- an arm per assignment of pointers to regions would
   be 3^n, and a per-argument "leave this block alone" conditional has to name
   the map built so far, which doubles the term per argument.

   Both pointers here are addresses of locals, so no argument can name the
   globals and g is still 5 after the call.

   C has no attribute that spells this, so the .ll is edited by hand. */
int g;
int ext_argmem_two_pointers(int *p, int *q);

int vuln(void) {
    int a = 0;
    int b = 0;
    g = 5;
    ext_argmem_two_pointers(&a, &b);
    return g;
}

int patch(void) {
    int a = 0;
    int b = 0;
    g = 5;
    ext_argmem_two_pointers(&a, &b);
    return 5;
}
