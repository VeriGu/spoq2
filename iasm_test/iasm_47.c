#include <stdbool.h>
typedef unsigned long long u64;
typedef unsigned u32;
typedef unsigned char u8;

u64 iasm_47(void)
{
    u64 out;
    asm volatile("mrs %0, S3_0_C12_C12_4": "=r" (out) : );
    return out;
}
