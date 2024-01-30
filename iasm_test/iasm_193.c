#include <stdbool.h>
typedef unsigned long long u64;
typedef unsigned u32;
typedef unsigned char u8;

void iasm_193(void)
{
    asm volatile("tlbi vmalle1is":  : );
}
