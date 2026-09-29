/* Two pointer parameters: a readonly one carrying &g and a writable one
   carrying &local.  Only the writable one is framed as written, and it can only
   name the stack, so the globals are pinned and g is still 5.

   The .ll is edited by hand. */
int g;
int ext_param_readonly_mixed(const int *p, int *q);

int vuln(void) {
    int local = 0;
    g = 5;
    ext_param_readonly_mixed(&g, &local);
    return g;
}

int patch(void) {
    int local = 0;
    g = 5;
    ext_param_readonly_mixed(&g, &local);
    return 5;
}
