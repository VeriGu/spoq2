/* The callee may write argument memory, and &g is passed -- but the parameter
   is readonly, so the callee does not write through it.  With no other pointer
   parameter, nothing the callee may write is reachable, and g is still 5.

   Pairs with attr_argmem, which has the same function attribute and no
   readonly, and is not verified.  The .ll is edited by hand. */
int g;
int ext_param_readonly(const int *p);

int vuln(void) {
    g = 5;
    ext_param_readonly(&g);
    return g;
}

int patch(void) {
    g = 5;
    ext_param_readonly(&g);
    return 5;
}
