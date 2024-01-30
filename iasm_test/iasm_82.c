#include <stdbool.h>
typedef unsigned long long u64;
typedef unsigned u32;
typedef unsigned char u8;

u64 iasm_82(void)
{
    u64 out;
    asm volatile("mrs %0, S3_0_C0_C4_4": "=r" (out) : );
    return out;
}
