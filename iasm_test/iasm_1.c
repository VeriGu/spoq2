#include <stdbool.h>
typedef unsigned long long u64;
typedef unsigned u32;
typedef unsigned char u8;

u64 iasm_1(u64* in0)
{
    u64 out;
    asm volatile("\tldar\t%0, %1\n": "=r" (out) : "*Q" (in0));
    return out;
}
