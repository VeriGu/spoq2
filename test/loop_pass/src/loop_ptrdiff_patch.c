int fill(char *dst, int n, unsigned off) {
    char *p = dst;
    for (int i = 0; i < n; i++) {
        if (off > (unsigned)(p - dst)) return 1;
        *p = 0;
        p++;
    }
    return 0;
}

int entry(char *dst, int n, unsigned off) {
    if (n > 3) return 0;
    return fill(dst, n, off);
}
