/* Negative control.  The parameter carries nofree readonly captures(none), as
   on the outlined pv_shared functions, but the function attribute is
   memory(readwrite).  readonly only forbids writes through the parameter: the
   callee may still write g directly, so g is unknown after the call.

   The .ll is edited by hand. */
int g;
int ext_param_readonly_unframed(const int *p);

int vuln(void) {
    g = 5;
    ext_param_readonly_unframed(&g);
    return g;
}

int patch(void) {
    g = 5;
    ext_param_readonly_unframed(&g);
    return 5;
}
