/* The external callee is declared pure, so clang emits memory(read) on it.
   vuln reads the global back after the call; patch folds it to the constant.
   They agree only if the call cannot have written to g -- which is exactly
   what memory(read) promises.  Without the attribute the post-call state is
   unconstrained and vuln's return value is unknown. */
int g;
__attribute__((pure)) int ext_pure(void);

int vuln(void) {
    g = 5;
    ext_pure();
    return g;
}

int patch(void) {
    g = 5;
    ext_pure();
    return 5;
}
