/* Same shape, but the callee is declared const, so clang emits memory(none):
   it neither reads nor writes memory. */
int g;
__attribute__((const)) int ext_const(void);

int vuln(void) {
    g = 7;
    ext_const();
    return g;
}

int patch(void) {
    g = 7;
    ext_const();
    return 7;
}
