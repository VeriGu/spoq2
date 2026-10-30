void touch(int *);
int entry(int *p, int n) {
  int s = 0;
  touch(&s);
  if (n <= 0)
    return 0;
  int acc = 0;
  int i = 0;
  do {
    acc += p[i];
    i++;
  } while (i < n);
  s = acc;
  return p[0] + s;
}
