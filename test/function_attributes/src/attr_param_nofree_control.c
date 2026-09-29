/* The callee may access only argument memory.  Both functions load through p
   before the call, so the object p names is allocated and large enough; patch
   loads through p again after the call and vuln does not.
   The parameter is not nofree, so the callee may free the object and the
   second load in patch may be undefined.  Negative control for
   attr_param_nofree.

   The .ll is edited by hand. */
int ext_param_nofree_control(int *p);

int vuln(int *p) {
    int a = *p;
    ext_param_nofree_control(p);
    return a - a;
}

int patch(int *p) {
    int a = *p;
    ext_param_nofree_control(p);
    int b = *p;
    return b - b;
}
