#include <stdbool.h>
typedef unsigned long long u64;
typedef unsigned u32;
typedef unsigned char u8;

u64 iasm_168(void)
{
    u64 out;
    asm volatile("mrs %0, sp_el1": "=r" (out) : );
    return out;
}
