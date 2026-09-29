/* The callee may access only argument memory.  Both functions load through p
   before the call, so the object p names is allocated and large enough; patch
   loads through p again after the call and vuln does not.
   The parameter is nofree, so the object is still allocated with its size
   unchanged, and the second load in patch is defined.

   The .ll is edited by hand. */
int ext_param_nofree(int *p);

int vuln(int *p) {
    int a = *p;
    ext_param_nofree(p);
    return a - a;
}

int patch(int *p) {
    int a = *p;
    ext_param_nofree(p);
    int b = *p;
    return b - b;
}
