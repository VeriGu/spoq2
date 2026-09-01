/* Negative control.  The callee may write memory, so nothing may be assumed
   about g after the call and the two sides must NOT be proved equivalent.
   The declaration is rewritten to memory(write) in the .ll -- C has no
   attribute that spells it. */
int g;
int ext_wo(void);

int vuln(void) {
    g = 5;
    ext_wo();
    return g;
}

int patch(void) {
    g = 5;
    ext_wo();
    return 5;
}
