
int dumb;
char patch(unsigned int idx)
{
    char string[] = "hello, world!";
    int i;
    char tmp = -1;
    if (idx > 13)
        return tmp;
    for (i = 0; i < idx; i++)
        tmp = string[idx];
    return tmp;
}
char vuln(unsigned int idx)
{
    char string[] = "hello, world!";
    int i;
    char tmp = -1;
    /* This may get optimized down at O1. If so, do some more arithmetic.*/
    for (i = 0; i < idx; i++)
        tmp = string[idx];
    return tmp;
}