#include <stdbool.h>
typedef unsigned long long u64;
typedef unsigned u32;
typedef unsigned char u8;

u64 iasm_0(u64* in0)
{
    u64 out;
    asm volatile("\tldr\t%0, %1\n": "=r" (out) : "*m" (in0));
    return out;
}
