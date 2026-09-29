/* The callee may access only argument memory, and its one pointer parameter
   is not writeonly: it may read g, which vuln and patch set
   differently, so the return values may differ.  Negative control for
   attr_param_writeonly.

   g is overwritten after the call so that the post-states agree.  The .ll is
   edited by hand. */
int g;
int ext_param_writeonly_control(int *p);

int vuln(void) {
    g = 1;
    int r = ext_param_writeonly_control(&g);
    g = 0;
    return r;
}

int patch(void) {
    g = 2;
    int r = ext_param_writeonly_control(&g);
    g = 0;
    return r;
}
