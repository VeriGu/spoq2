#include <stdbool.h>
typedef unsigned long long u64;
typedef unsigned u32;
typedef unsigned char u8;

u64 iasm_20(void)
{
    u64 out;
    asm volatile("mrs %0, id_aa64mmfr2_el1": "=r" (out) : );
    return out;
}
