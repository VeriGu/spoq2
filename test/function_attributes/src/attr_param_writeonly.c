/* The callee may access only argument memory, and its one pointer parameter
   is writeonly: it reads no memory, so its return value is a
   function of its arguments alone.  vuln and patch store different values to g
   before the call, and the call returns the same value in both.

   g is overwritten after the call so that the post-states agree.  The .ll is
   edited by hand. */
int g;
int ext_param_writeonly(int *p);

int vuln(void) {
    g = 1;
    int r = ext_param_writeonly(&g);
    g = 0;
    return r;
}

int patch(void) {
    g = 2;
    int r = ext_param_writeonly(&g);
    g = 0;
    return r;
}
