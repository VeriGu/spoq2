#include <stdbool.h>
typedef unsigned long long u64;
typedef unsigned u32;
typedef unsigned char u8;

u64 iasm_181(void)
{
    u64 out;
    asm volatile("mrs %0, S3_4_C1_C2_0": "=r" (out) : );
    return out;
}
