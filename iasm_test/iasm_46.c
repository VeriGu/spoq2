#include <stdbool.h>
typedef unsigned long long u64;
typedef unsigned u32;
typedef unsigned char u8;

u64 iasm_46(void)
{
    u64 out;
    asm volatile("mrs %0, hpfar_el2": "=r" (out) : );
    return out;
}
