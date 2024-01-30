#include <stdbool.h>
typedef unsigned long long u64;
typedef unsigned u32;
typedef unsigned char u8;

u64 iasm_75(void)
{
    u64 out;
    asm volatile("mrs %0, S3_4_C12_C11_2": "=r" (out) : );
    return out;
}
