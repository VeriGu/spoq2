#include <stdbool.h>
typedef unsigned long long u64;
typedef unsigned u32;
typedef unsigned char u8;

void iasm_192(u64 in0)
{
    asm volatile("tlbi vae2is, %0":  : "r" (in0));
}
